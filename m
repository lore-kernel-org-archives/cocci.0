From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 26 Jan 2017 22:37:12 +0100 (CET)
Subject: [Cocci] Help with include coccinelle & include paths?
In-Reply-To: <5A897B79-A0C3-44D5-9FB8-3D0DFBB5A3B1@linaro.org>
References: <BBB6D7E1-F6F1-4FE4-80D6-8BD4C6F36026@linaro.org>
 <alpine.DEB.2.20.1701261613120.3109@hadrien>
 <C37E98C9-25E1-4E62-BA80-145CC8483C79@linaro.org>
 <alpine.DEB.2.20.1701262014580.2032@hadrien>
 <BEC46CAB-77E1-4237-B5A0-C9E84BF192DA@linaro.org>
 <alpine.DEB.2.20.1701262055170.2032@hadrien>
 <BB7CE4F7-355C-4CC3-818A-03C47112E293@linaro.org>
 <BD76D02F-FBF3-4F69-9C5B-8C2976D7DFFA@linaro.org>
 <alpine.DEB.2.20.1701262118460.2032@hadrien>
 <6FBEB071-6A44-4A39-9C40-5E28CC402196@linaro.org>
 <alpine.DEB.2.20.1701262149330.2032@hadrien>
 <5A897B79-A0C3-44D5-9FB8-3D0DFBB5A3B1@linaro.org>
Message-ID: <alpine.DEB.2.20.1701262236200.2032@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 26 Jan 2017, Kumar Gala wrote:

>
> > On Jan 26, 2017, at 2:54 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:
> >
> >
> >
> > On Thu, 26 Jan 2017, Kumar Gala wrote:
> >
> >>
> >>> On Jan 26, 2017, at 2:19 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:
> >>>
> >>>> Not sure if there?s some debug info I can dump that would be helpful.
> >>>
> >>> --debug --show-trying
> >>>
> >>> thanks,
> >>> julia
> >>
> >> For the FILE case:
> >> ~/git/coccinelle/spatch.opt --sp-file ./pri.sp --macro-file-builtins $ZEPHYR_BASE/zephyr-std.h --recursive-includes -I $ZEPHYR_BASE/include tests/legacy/kernel/test_mail/src/mail.^C--debug --show-trying 2> file.good.log 1> file.good.out
> >>
> >> For the DIR case:
> >>
> >> ~/git/coccinelle/spatch.opt --sp-file ./pri.sp --macro-file-builtins $ZEPHYR_BASE/zephyr-std.h --recursive-includes -I $ZEPHYR_BASE/include tests/legacy/kernel/test_mail/src/ --debug --show-trying 2> dir.bad.log 1>dir.bad.out
> >>
> >> Not sure if these logs show something useful.
> >
> > We aren't processing the files in the same order.  Your .log file in the
> > dir case shows main.c and the mail.c, while mine has mail.c and then
> > main.c.  I would guess that it is learning something from the parsing of
> > main.c that is throwing it off in the parsing of mail.c.
> >
> > Could you add --verbose-parsing somewhere after --debug in the above
> > command lines and merge standard output and standard error into a single
> > file?
> >
> > thanks,
> > julia
>
> This time with log:
>
>  ~/git/coccinelle/spatch.opt --sp-file ./pri.sp --macro-file-builtins $ZEPHYR_BASE/zephyr-std.h --recursive-includes -I $ZEPHYR_BASE/include tests/legacy/kernel/test_mail/src/ --debug --show-trying --verbose-parsing &> dir.log

The inclusion of header files that have already been included in another
.c file does not seem to be working properly.  I will have to look more
into it tomorrow.

julia
