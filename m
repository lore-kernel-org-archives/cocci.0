From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 2 Jan 2013 21:22:51 +0100 (CET)
Subject: [Cocci] Problem with variable declared with macro
In-Reply-To: <CAACXqO9uArVgbnU=pGYWGgczHY_tCR6+0yOyBPYA22iP0OgahA@mail.gmail.com>
References: <CAACXqO9uArVgbnU=pGYWGgczHY_tCR6+0yOyBPYA22iP0OgahA@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1301022120020.2022@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 2 Jan 2013, H?kon L?vdal wrote:

> I have a problem with some macros that I have trimmed down to the following:
>
>
> $ more macro_problem.c*
> ::::::::::::::
> macro_problem.c
> ::::::::::::::
>
> //#define MACRO1(id) MACROSTATEMENT
>
> #define MACRO1(id) \
> int id
>
> MACRO1(dummy2);
>
> ::::::::::::::
> macro_problem.cocci
> ::::::::::::::
>
> @@
> @@
>
> -MACRO1
> +MACRO2
>
> $ /tmp/coccinelle/bin/spatch  --verbose-parsing --parse-error-msg
> --sp-file macro_problem.cocci macro_problem.c
> init_defs_builtins: /tmp/coccinelle/share/coccinelle/standard.h
> HANDLING: macro_problem.c
> ERROR-RECOV: found sync end of #define, line 5
> parsing pass2: try again
> ERROR-RECOV: found sync end of #define, line 5

On the other hand, it does mention that it is resynchronizing here.  And 
that is what it looks like it is doing from the bad/BAD messages below. 
If MACRO1 is not getting changed, it is probably because it has been 
recognized as a macro to skip, and so no change can be made to it.

julia

> parse error
> = File "macro_problem.c", line 6, column 0,  charpos = 64
>    around = '', whole content =
> badcount: 3
> bad: #define MACRO1(id) MACROSTATEMENT
> bad:
> bad: #define MACRO1(id) \
> BAD:!!!!! int id
> $ /tmp/coccinelle/bin/spatch  --version
> spatch version 1.0.0-rc15 with Python support and with PCRE support
> $
> (although this is really rc16, compiled from latest git version).
>
>
> This seems extremely basic, so I do not understand what the problem is here.
> Adding MACROSTATEMENT did not make any difference. Can someone explain?
>
> BR H?kon L?vdal
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
