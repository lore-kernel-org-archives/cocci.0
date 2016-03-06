From: nicstange@gmail.com (Nicolai Stange)
Date: Sun, 06 Mar 2016 21:03:55 +0100
Subject: [Cocci] [PATCH v4 0/8] fix debugfs file removal races
In-Reply-To: <20160306135430.GA17315@kroah.com> (Greg Kroah-Hartman's message
 of "Sun, 6 Mar 2016 05:54:30 -0800")
References: <8737sjo7qa.fsf@gmail.com> <20160305212613.GA29738@kroah.com>
 <87egbn3gxb.fsf@gmail.com> <20160306135430.GA17315@kroah.com>
Message-ID: <87a8mb2x1w.fsf@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> On Sun, Mar 06, 2016 at 01:54:40PM +0100, Nicolai Stange wrote:
>> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
>> 
>> > On Tue, Feb 23, 2016 at 02:51:25PM +0100, Nicolai Stange wrote:
>> >> The changes from v3 to v4 are style changes regarding the Coccinelle
>> >> part only -- it has been split off from former [3/7] into its own
>> >> patch [4/8].
>> >> 
>> >> The big step has been from v2 to v3 and these changes haven't got any
>> >> review yet.
>> >
>> > Well, given that they look sane to me, I've applied them to my tree,
>> > let's see what breaks in linux-next now :)
>> 
>> Great, thank you!
>> 
>> Unfortunately, the kbuild test robot detected two minor issues and I've
>> sent v5 in order to correct this.
>> 
>> In case that it isn't possible to simply replace v4 by v5, please let me
>> know and I'll send two fixup patches instead.
>
> What do the fixup patches look like?  That might be easier to take if
> they aren't really major issues (one was a documentation issue, which
> isn't a big deal...)

I sent the two fixup patches as a proposal in a series of their own:
http://lkml.kernel.org/g/1457294345-4588-1-git-send-email-nicstange at gmail.com

Thank you!

Nicolai
