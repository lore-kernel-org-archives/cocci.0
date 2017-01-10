From: wpengfeinudt@gmail.com (Pengfei Wang)
Date: Tue, 10 Jan 2017 17:02:03 +0800
Subject: [Cocci] [PATCH] coccicheck: add a test for repeat copy_from_user
In-Reply-To: <4ba1f717-9ad8-687b-e31c-64e5f2ffcab1@oracle.com>
References: <20160426222442.GA8104@www.outflux.net>
 <alpine.DEB.2.20.1612271916250.2001@hadrien>
 <d0289ec5-3ce2-f119-6876-e19dc1a5ccde@oracle.com>
 <05AE3A59-EF48-4FFF-A028-0204B2E56DEB@gmail.com>
 <4ba1f717-9ad8-687b-e31c-64e5f2ffcab1@oracle.com>
Message-ID: <19545870-5238-4BEB-AF1E-741BA97A6AA2@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr


> ? 2017?1?10????4:40?Vaishali Thakkar <vaishali.thakkar@oracle.com> ???
> 
> On Tuesday 10 January 2017 01:51 PM, Pengfei Wang wrote:
>> 
>>> ? 2017?1?10????1:05?Vaishali Thakkar <vaishali.thakkar@oracle.com> ???
>>> 
>>> On Tuesday 27 December 2016 11:51 PM, Julia Lawall wrote:
>>>> I totally dropped the ball on this.  Many thanks to Vaishali for
>>>> resurrecting it.
>>>> 
>>>> Some changes are suggested below.
>>>> 
>>>> On Tue, 26 Apr 2016, Kees Cook wrote:
>>>> 
>>>>> This is usually a sign of a resized request. This adds a check for
>>>>> potential races or confusions. The check isn't 100% accurate, so it
>>>>> needs some manual review.
>>>>> 
>>>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>>>> ---
>>>>> scripts/coccinelle/tests/reusercopy.cocci | 36 +++++++++++++++++++++++++++++++
>>>>> 1 file changed, 36 insertions(+)
>>>>> create mode 100644 scripts/coccinelle/tests/reusercopy.cocci
>>>>> 
>>>>> diff --git a/scripts/coccinelle/tests/reusercopy.cocci b/scripts/coccinelle/tests/reusercopy.cocci
>>>>> new file mode 100644
>>>>> index 000000000000..53645de8ae95
>>>>> --- /dev/null
>>>>> +++ b/scripts/coccinelle/tests/reusercopy.cocci
>>>>> @@ -0,0 +1,36 @@
>>>>> +/// Recopying from the same user buffer frequently indicates a pattern of
>>>>> +/// Reading a size header, allocating, and then re-reading an entire
>>>>> +/// structure. If the structure's size is not re-validated, this can lead
>>>>> +/// to structure or data size confusions.
>>>>> +///
>>>>> +// Confidence: Moderate
>>>>> +// Copyright: (C) 2016 Kees Cook, Google. License: GPLv2.
>>>>> +// URL: http://coccinelle.lip6.fr/
>>>>> +// Comments:
>>>>> +// Options: -no_includes -include_headers
>>>> 
>>>> The options could be: --no-include --include-headers
>>>> 
>>>> Actually, Coccinelle supports both, but it only officially supports the
>>>> -- versions.
>>>> 
>>>>> +
>>>>> +virtual report
>>>>> +virtual org
>>>> 
>>>> Add, the following for the *s:
>>>> 
>>>> virtual context
>>>> 
>>>> Then add the following rule:
>>>> 
>>>> @ok@
>>>> position p;
>>>> expression src,dest;
>>>> @@
>>>> 
>>>> copy_from_user at p(&dest, src, sizeof(dest))
>>>> 
>>>>> +
>>>>> + at cfu_twice@
>>>>> +position p;
>>>> 
>>>> Change this to:
>>>> 
>>>> position p != ok.p;
>>>> 
>>>>> +identifier src;
>>>>> +expression dest1, dest2, size1, size2, offset;
>>>>> +@@
>>>>> +
>>>>> +*copy_from_user(dest1, src, size1)
>>>>> + ... when != src = offset
>>>>> +     when != src += offset
>>> 
>>> Here, may be we should add few more lines from Pengfei's
>>> script to avoid th potential FPs.
>>> 
>>>> Add the following lines:
>>>> 
>>>>    when != if (size2 > e1 || ...) { ... return ...; }
>>>>    when != if (size2 > e1 || ...) { ... size2 = e2 ... }
>>>> 
>>>> These changes drop cases where the last argument to copy_from_usr is the
>>>> size of the first argument, which seems safe enough, and where there is a
>>>> test on the size value that can either update it or abort the function.
>>>> These changes only eliminate false positives, as far as I could tell.
>>>> 
>>>> If it would be more convenient, I could just send the complete revised
>>>> patch, or whatever seems convenient.
>>> 
>>> I was also thinking that probably we should also add other user space memory API functions. May be get_user and strncpy_from_user. Although I'm not sure how common it is to find such patterns for both of these functions.
>> 
>> I strongly recommend you adding get_user() API , which is used pervasively
>> within the kernel just like copy_from user().
> 
> Sure. I have changed regetuser-wang.cocci from Kees's RFC patches to
> include everything in the pattern matching rule. I'll send that as well.
> 
>> In many situations, there is a combination use, get_user() copies first then
>> followed by a copy_from_user() copy. According to our investigation, this typical
>> situation works by get_user() firstly copying a field of a specific struct to check,
>> then copy_from_user() copies in the whole struct to use. Of course, the struct
>> field is fetch twice.
> 
> Do you mean that there is a problem when we have get_user() followed by copy_from_user()? Basically something like
> this:
> 
> get_user(..., src.arg) //where src.arg = field of a structure
> ...
> copy_from_user(..., src, ...) //where src is a whole structure
> 
> If that is the case then we would need to have one more new script
> or rule for such kind of combinational patterns. Disjunction can
> probably give FPs.

Yes, I?ve seen these cases when examining the source code. Actually, copying a field
first and then copying the whole struct is very common in the kernel especially the driver.
For example, when a struct (or a message as we call it) is variable length, the first copy is
used to check its size field, and allocate a kernel buffer based on it, then the second copy is 
to copy the whole message also based on the size. There are also situations of the 
variable type messages.

The reason that they use get_user() instead of copy_from_user() for the first copy is because 
get_user() is defined as a macro, which works faster than a function call that copy_from_user() does 
when copy simple data type such as char and int.


Regards
Pengfei


> Thanks!
> 
>> Regards
>> Pengfei
>>> 
>>>> thanks,
>>>> julia
>>>> 
>>>>> +*copy_from_user at p(dest2, src, size2)
>>>>> +
>>>>> + at script:python depends on org@
>>>>> +p << cfu_twice.p;
>>>>> +@@
>>>>> +
>>>>> +cocci.print_main("potentially dangerous second copy_from_user()",p)
>>>>> +
>>>>> + at script:python depends on report@
>>>>> +p << cfu_twice.p;
>>>>> +@@
>>>>> +
>>>>> +coccilib.report.print_report(p[0],"potentially dangerous second copy_from_user()")
>>>>> --
>>>>> 2.6.3
>>>>> 
>>>>> 
>>>>> --
>>>>> Kees Cook
>>>>> Chrome OS & Brillo Security
>>>>> 
>>>> _______________________________________________
>>>> Cocci mailing list
>>>> Cocci at systeme.lip6.fr <mailto:Cocci@systeme.lip6.fr> <mailto:Cocci at systeme.lip6.fr <mailto:Cocci@systeme.lip6.fr>>
>>>> https://systeme.lip6.fr/mailman/listinfo/cocci <https://systeme.lip6.fr/mailman/listinfo/cocci> <https://systeme.lip6.fr/mailman/listinfo/cocci <https://systeme.lip6.fr/mailman/listinfo/cocci>>

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20170110/eadab6db/attachment-0001.html>
