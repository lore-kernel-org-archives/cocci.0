From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 8 Nov 2017 21:12:50 +0800 (CST)
Subject: [Cocci] [PATCH] coccinelle: fix verbose message about .cocci
 file being run
In-Reply-To: <CAK7LNARMTun58pa1Ew32SvQjR_u1Hg8mE-tDR_qqvztcx_Wnfg@mail.gmail.com>
References: <1508993751-17218-1-git-send-email-yamada.masahiro@socionext.com>
 <c18712da-6b47-3b13-059d-d49db738e386@imag.fr>
 <CAK7LNARMTun58pa1Ew32SvQjR_u1Hg8mE-tDR_qqvztcx_Wnfg@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1711082112400.2708@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 7 Nov 2017, Masahiro Yamada wrote:

> 2017-10-26 16:22 GMT+09:00 Nicolas Palix (LIG) <Nicolas.Palix@imag.fr>:
> > Le 26/10/17 ? 06:55, Masahiro Yamada a ?crit :
> >>
> >> If you run coccicheck with V=1 and COCCI=, you will see a strange
> >> path to the semantic patch file.  For example, run the following:
> >>
> >> $ make V=1 COCCI=scripts/coccinelle/free/kfree.cocci coccicheck
> >>    [ snip ]
> >>   The semantic patch that makes this report is available
> >>   in scriptcoccinelle/free/kfree.cocci.
> >>
> >> Notice "s/" was dropped from "scripts/coccinelle/free/kfree.cocci".
> >>
> >> When running coccicheck without O=, $srctree is expanded to ".", which
> >> represents one arbitrary character in the regular expression.  Using
> >> sed is not a good choice here.  Strip $srctree/ simply without sed.
> >>
> >> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> >
> > Acked-by: Nicolas Palix <nicolas.palix@imag.fr>
> >>
> >> ---
>
> Applied to linux-kbuild/misc.

Thanks!

julia
