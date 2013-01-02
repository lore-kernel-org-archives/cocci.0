From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 2 Jan 2013 21:19:37 +0100 (CET)
Subject: [Cocci] Problem with variable declared with macro
In-Reply-To: <CAACXqO9uArVgbnU=pGYWGgczHY_tCR6+0yOyBPYA22iP0OgahA@mail.gmail.com>
References: <CAACXqO9uArVgbnU=pGYWGgczHY_tCR6+0yOyBPYA22iP0OgahA@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1301022116120.2022@localhost6.localdomain6>
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

MACROSTATEMENT is only understood in the standard.h file.

It can't parse the int i because of the missing semicolon.

Then it doesn't parse what comes afterwards, because it has not 
resynchronized (I think).

If that is the problem, then the C parser should really resynchronize 
after coming to the newline in a macro definition.

Christian, could you look into that?

thanks,
julia
