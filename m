From: nicstange@gmail.com (Nicolai Stange)
Date: Sun, 22 May 2016 15:28:12 +0200
Subject: [Cocci] [PATCH v6 2/8] debugfs: prevent access to removed
	files' private data
In-Reply-To: <874m9rcmzx.fsf@gmail.com> (Nicolai Stange's message of "Sat, 21
 May 2016 19:57:38 +0200")
References: <1458652280-19785-1-git-send-email-nicstange@gmail.com>
 <1458652280-19785-3-git-send-email-nicstange@gmail.com>
 <573C80C8.6090307@oracle.com> <87r3czxvea.fsf@gmail.com>
 <573C87B8.902@oracle.com> <20160518160520.GA5407@kroah.com>
 <573F4200.3080208@oracle.com> <874m9rcmzx.fsf@gmail.com>
Message-ID: <878tz22peb.fsf@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Nicolai Stange <nicstange@gmail.com> writes:

> Sasha Levin <sasha.levin@oracle.com> writes:
>
>> On 05/18/2016 12:05 PM, Greg Kroah-Hartman wrote:
>>> On Wed, May 18, 2016 at 11:18:16AM -0400, Sasha Levin wrote:
>>>> On 05/18/2016 11:01 AM, Nicolai Stange wrote:
>>>>> Thanks a million for reporting!
>>>>>
>>>>> 1.) Do you have lockdep enabled?
>>>>
>>>> Yup, nothing there.
>>>>
>>>>> 2.) Does this happen before or after userspace init has been spawned,
>>>>>     i.e. does the lockup happen at debugfs file creation time or
>>>>>     possibly at usage time?
>>>>
>>>> So I looked closer, and it seems to happen after starting syzkaller, which
>>>> as far as I know tries to open many different debugfs files.
>>>>
>>>> Is there debug code I can add it that'll help us figure out what's up?
>>> 
>>> Trying to figure out _which_ debugfs file is causing this would be
>>> great, if at all possible.  strace?
>>
>> What seems to be failing is syzkaller's attempt to mmap the coverage
>> debugfs file. So this isn't actually a kernel deadlock but syzkaller
>> misbehaves when that scenario happens.
>>
>> Either way, it only fails to mmap with that commit that I've pointed
>> out.
>
> That info is really helpful here: the proxy file_operations introduced by
> this commit doesn't have a ->mmap() defined, i.e. it is NULL from the
> VFS layer's point of view.
>
> The simple reason is that at the time I submitted this series, my
> Coccinelle script didn't find any debugfs user with a ->mmap()
> defined. Thus either that script was broken or things have changed in
> the meanwhile.

Thankfully, it's the latter :)
See the attached cocci script I used back then.

It now reports:

  ./drivers/staging/android/sync_debug.c:330:1-20: unsupported file_operations given to debugfs
  ./kernel/kcov.c:267:6-25: unsupported file_operations given to debugfs

The kcov's ->mmap() has been introduced by

  5c9a8750a640 ("kernel: add kcov code coverage")

dated from March this year.

Since that kcov debugfs file is never removed, it needs no protecting
proxy and thus, a replacement of debugfs_create_file() by
debugfs_create_file_unsafe() will do the trick here.

I'll send patches addressing the above two issues.

>>
>> 	th->cover_fd = open("/sys/kernel/debug/kcov", O_RDWR);
>> 	if (th->cover_fd == -1)
>> 		fail("open of /sys/kernel/debug/kcov failed");
>> 	if (ioctl(th->cover_fd, KCOV_INIT_TRACE, kCoverSize))
>> 		fail("cover enable write failed");
>> 	th->cover_data = (uintptr_t*)mmap(NULL, kCoverSize * sizeof(th->cover_data[0]), PROT_READ | PROT_WRITE, MAP_SHARED, th->cover_fd, 0);
>> 	if ((void*)th->cover_data == MAP_FAILED)
>> 		fail("cover mmap failed");
>>
>> And it's the mmap() that fails with -ENODEV.

-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: debugfs_unsupp_fops.cocci
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20160522/23b3ce79/attachment.ksh>
