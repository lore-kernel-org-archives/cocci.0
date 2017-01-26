From: kumar.gala@linaro.org (Kumar Gala)
Date: Thu, 26 Jan 2017 14:01:52 -0600
Subject: [Cocci] Help with include coccinelle & include paths?
In-Reply-To: <alpine.DEB.2.20.1701262055170.2032@hadrien>
References: <BBB6D7E1-F6F1-4FE4-80D6-8BD4C6F36026@linaro.org>
 <alpine.DEB.2.20.1701261613120.3109@hadrien>
 <C37E98C9-25E1-4E62-BA80-145CC8483C79@linaro.org>
 <alpine.DEB.2.20.1701262014580.2032@hadrien>
 <BEC46CAB-77E1-4237-B5A0-C9E84BF192DA@linaro.org>
 <alpine.DEB.2.20.1701262055170.2032@hadrien>
Message-ID: <BB7CE4F7-355C-4CC3-818A-03C47112E293@linaro.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr


> On Jan 26, 2017, at 1:57 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:
> 
> 
> 
> On Thu, 26 Jan 2017, Kumar Gala wrote:
> 
>> 
>>> On Jan 26, 2017, at 1:17 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:
>>> 
>>>> So this I?m trying to use a modified version of Johann?s script to convert printf formatters that are passed a {u}int32_t to use ?%l{d,x,u,?}?.  My version of the script is attached.  I?m trying to figure out why some typedef / structs are being processed/figured out.
>>>> 
>>>> I do:
>>>> ~/git/coccinelle/spatch.opt --sp-file ./pri.sp --macro-file-builtins $ZEPHYR_BASE/zephyr-std.h tests/legacy/kernel/test_mail/src/
>>>> 
>>>> I?d expect to match line 206/207 of tests/legacy/kernel/test_mail/src/mail.c, where MSTmsg is of type ?struct k_msg? and k_msg is defined in include/legacy.h.  Where the size field is a uint32_t.
>>>> 
>>>> So trying to figure out why the struct is getting resolved and match.
>>> 
>>> I'm not completely sure from your message whether it is working or not.
>>> If you give the options --recursive-includes -I $ZEPHYR_BASE/include
>>> then I think it should work.
>>> 
>>> If you give the name of a directory, Coccinelle will add dir/include to
>>> the include path.  But since you are working on a subdirectory, you don't
>>> benefit from that.
>>> 
>>> julia
>> 
>> Sorry if I wasn?t clear.  Its partially working.  Some issue with file vs dir.  If I do:
>> 
>> This FAILS:
>> 
>> ~/git/coccinelle/spatch.opt --sp-file ./pri.sp --recursive-includes  -I $ZEPHYR_BASE/include  tests/legacy/kernel/test_mail/src/
> 
> I get a change on lines 206/207 with this command.  Actually, I have no
> difference, except in the diff line, between the above and the mail.c
> case.

Interesting, I?m seeing different behavior, if I --cache-limit 0 that seems to help some in the dir case.

> 
> julia
> 
>> This PASSES:
>> 
>> ~/git/coccinelle/spatch.opt --sp-file ./pri.sp --recursive-includes  -I $ZEPHYR_BASE/include  tests/legacy/kernel/test_mail/src/mail.c
>> 
>> This also PASSES:
>> ~/git/coccinelle/spatch.opt --sp-file ./pri.sp --recursive-includes  -I $ZEPHYR_BASE/include  tests/legacy/kernel/test_mail/src/*.c
>> 
>> So not sure what exactly happens differently if a dir vs file.
>> 
>> - k
>> 
>> 
