From: amitoj1606@gmail.com (Amitoj Kaur Chawla)
Date: Wed, 3 Jan 2018 11:14:42 +0530
Subject: [Cocci] [PATCH] Coccinelle: kzalloc-simple: Add more zero
 allocating functions
In-Reply-To: <20171226191129.GA8851@himanshu-Vostro-3559>
References: <1514116040-9815-1-git-send-email-himanshujha199640@gmail.com>
 <901a0b77-39c7-1284-1229-c436e0836779@users.sourceforge.net>
 <20171226191129.GA8851@himanshu-Vostro-3559>
Message-ID: <CA+5yK5HvhF4mvB-CbZHdfQY7HRG_2iJwpeX5XhehSr4UYpLtcw@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, Dec 27, 2017 at 12:41 AM, Himanshu Jha
<himanshujha199640@gmail.com> wrote:
> Hello Markus,
>
> On Tue, Dec 26, 2017 at 06:39:07PM +0100, SF Markus Elfring wrote:
>> > We already have zero memory allocator functions to set the memory to
>> > 0 value instead of manually setting it using memset.
>>
>> Thanks for your extension of this script for the semantic patch
>> language.
>>
>> Will this update suggestion get any better chances than the approach
>> ?Script to replace allocate and memset with zalloc functions??
>> https://systeme.lip6.fr/pipermail/cocci/2016-August/003510.html
>
> Yes! You can check it yourself. And I didn't knew someone previously
> worked on this. I was assigned the task of scrapping vmalloc/meset with
> vzalloc by Luis R. Rodriguez but when I made a new rule and sent it
> usptream, Julia told me find all instances and group into one.
> https://lkml.org/lkml/2017/11/4/171
>

Since Himanshu's patch is a extension to my patch, it seems to be a
better idea to go on ahead with his version.

Amitoj
>>
>> > +/// Use zeroing allocator rather than allocator followed by memset
>> > with 0
>>
>> Do you find the shown function name list complete now?
>
> Perhaps yes! If you find anything new then please send to patch out when
> it gets merged.
> You are most welcome!
>> Did you omit a name like ?kvm_kvzalloc? intentionally?
>
> Hmm...I don't anything in my linux-next latest
>
> himanshu at himanshu-Vostro-3559:~/linux-next$ git grep -w "kvm_kvzalloc"
> himanshu at himanshu-Vostro-3559:~/linux-next$
>
>> How do you think about the possibility to analyse relevant source
>> files for
>> functions with the mentioned property?
>
> Three rules for one functions :
>
> (
> - x = kmalloc(E1,E2);
> + x = kzalloc(E1,E2);
>
> It is most basic case.
>
> |
> - x = (T)kmalloc(E1,E2);
> + x = (T)kzalloc(E1,E2);
>
> This for useless pointer cast which is done implicitily.
>
>> > +(
>> > +- x = kmalloc(E1,E2);
>> > ++ x = kzalloc(E1,E2);
>> > +|
>>
>> You suggest to use another application for the SmPL disjunction.
>> How do you think about to refactor this specification a bit like the
>> following?
>>
>> +(
>> + x =
>> +-    kmalloc
>> ++    kzalloc
>> +            (E1, E2);
>> +|
>
> Julia answered this better!
>
>> > +|
>> > +- x = (T *)kmalloc(E1,E2);
>> > + x = kzalloc(E1,E2);
>> > +|
>>
>> Why do you find it appropriate to omit a cast at this place while it
>> is
>> preserved at other places?
>
> What we can do is your best to make a perfect rule with least number of
> false positives but can we ensure it to be fully perfect. The coccinelle
> tool find can do its best but we are the ones to ensure that the patch
> generated is absolutely correct and if it's not, then we change and
> improve the existing rule perhaps!
>
> Thanks for the feedback! I am not an experienced developer like you and
> used to send out checkpatch 2 months ago and now I work under the
> mentorship of Luis. Just to let you know I am just another
> *kernelnewbie* ;-)
>
> If found any queries then you can too omit/change rule to see why I
> exactly did that!
>
> Lastly, I got it 0-day tested with no errors :-)
> https://github.com/himanshujha199640/linux-next/commit/24c13fe24c21a5997cbdb099d1da9f5e8e23c100
>
> I already shared the 0-day test report with Julia and if you wish I can
> send it to you too!
>
> Please while replying also cc this to lkml mainling list so that other
> relevant people can also put their opinion.
>
> Also, Julia who is going to get it merged ? Please get it merged soon,
> and after that I will start sending out the patches!
>
> Thanks
> Himanshu Jha
