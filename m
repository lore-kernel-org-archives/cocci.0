From: kumar.gala@linaro.org (Kumar Gala)
Date: Thu, 26 Jan 2017 14:27:43 -0600
Subject: [Cocci] Help with include coccinelle & include paths?
In-Reply-To: <alpine.DEB.2.20.1701262118460.2032@hadrien>
References: <BBB6D7E1-F6F1-4FE4-80D6-8BD4C6F36026@linaro.org>
 <alpine.DEB.2.20.1701261613120.3109@hadrien>
 <C37E98C9-25E1-4E62-BA80-145CC8483C79@linaro.org>
 <alpine.DEB.2.20.1701262014580.2032@hadrien>
 <BEC46CAB-77E1-4237-B5A0-C9E84BF192DA@linaro.org>
 <alpine.DEB.2.20.1701262055170.2032@hadrien>
 <BB7CE4F7-355C-4CC3-818A-03C47112E293@linaro.org>
 <BD76D02F-FBF3-4F69-9C5B-8C2976D7DFFA@linaro.org>
 <alpine.DEB.2.20.1701262118460.2032@hadrien>
Message-ID: <6FBEB071-6A44-4A39-9C40-5E28CC402196@linaro.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr


> On Jan 26, 2017, at 2:19 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:
> 
>> Not sure if there?s some debug info I can dump that would be helpful.
> 
> --debug --show-trying
> 
> thanks,
> julia

For the FILE case:
~/git/coccinelle/spatch.opt --sp-file ./pri.sp --macro-file-builtins $ZEPHYR_BASE/zephyr-std.h --recursive-includes -I $ZEPHYR_BASE/include tests/legacy/kernel/test_mail/src/mail.^C--debug --show-trying 2> file.good.log 1> file.good.out

For the DIR case:

~/git/coccinelle/spatch.opt --sp-file ./pri.sp --macro-file-builtins $ZEPHYR_BASE/zephyr-std.h --recursive-includes -I $ZEPHYR_BASE/include tests/legacy/kernel/test_mail/src/ --debug --show-trying 2> dir.bad.log 1>dir.bad.out

Not sure if these logs show something useful.

- k

-------------- next part --------------
A non-text attachment was scrubbed...
Name: dir.bad.log
Type: application/octet-stream
Size: 172102 bytes
Desc: not available
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20170126/bd825ed5/attachment-0004.obj>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: dir.bad.out
Type: application/octet-stream
Size: 6622 bytes
Desc: not available
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20170126/bd825ed5/attachment-0005.obj>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: file.good.log
Type: application/octet-stream
Size: 1376314 bytes
Desc: not available
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20170126/bd825ed5/attachment-0006.obj>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: file.good.out
Type: application/octet-stream
Size: 39623 bytes
Desc: not available
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20170126/bd825ed5/attachment-0007.obj>
