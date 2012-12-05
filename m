From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 5 Dec 2012 10:28:24 +0100 (CET)
Subject: [Cocci] Adding names to arguments in function prototypes
In-Reply-To: <CAACXqO_0dmB+CvJA+DgtnNcOpc2NKHdj9YK-+0uz2ur8q9Gg_A@mail.gmail.com>
References: <CAACXqO_0dmB+CvJA+DgtnNcOpc2NKHdj9YK-+0uz2ur8q9Gg_A@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1212051027460.2115@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Looking quickly, I think you need to inherit the parameter list length n
from one rule to the next.  In the rules after the first one, put rule1.n,
not just n.

julia

On Wed, 5 Dec 2012, H?kon L?vdal wrote:

> Hi. I want to add names to arguments in function prototypes where
> only the type is specified, e.g. adding 'i' below:
>
> -int foo(int);
> +int foo(int i);
>
>
> I have gotten it almost working like I want, but got some problem beyond
> running on the most basic input code. The following works fine:
>
> ---START---
>
> $?more abc.* parameter_wo_name.cocci
> ::::::::::::::
> abc.c
> ::::::::::::::
>
> #include "abc.h"
>
> int foo(int i)
> {
>         return i;
> }
>
> int bar(int i)
> {
>         return i;
> }
>
> int abc(int a, int b, int c)
> {
>         return a + b + c;
> }
>
> ::::::::::::::
> abc.h
> ::::::::::::::
>
> int foo(int);
> int bar(int i);
> int abc(int, int, int);
>
> ::::::::::::::
> parameter_wo_name.cocci
> ::::::::::::::
>
> /* Match function prototypes without parameter names */
> @rule1@
> identifier f;
> type T1, T2;
> parameter list[n] ps;
> position p1;
> @@
>
> T1 f at p1(ps, T2, ...);
>
> /* Match the corresponding function declaration */
> @rule2@
> type rule1.T1;
> type rule1.T2;
> identifier rule1.f;
> parameter list[n] rule1.ps;
> identifier id;
> @@
>
> T1 f(ps, T2 id, ...) {...}
>
> /* Combine information from the above two rules to add the parameter
> name to the function prototype */
> @rule3@
> type rule1.T1;
> type rule1.T2;
> identifier rule1.f;
> parameter list[n] rule1.ps;
> position rule1.p1;
> identifier rule2.id;
> @@
>
> T1 f at p1(ps, T2
> +id
> , ...);
>
> $?spatch --sp-file parameter_wo_name.cocci --recursive-includes -I
> /usr/include abc.c
> init_defs_builtins: /usr/share/coccinelle/standard.h
> HANDLING: abc.c
> a header file was modified: abc.h
> diff =
> --- ./abc.h
> +++ /tmp/cocci-output-27689-53d466-abc.h
> @@ -1,5 +1,5 @@
>
> -int foo(int);
> +int foo(int i);
>  int bar(int i);
> -int abc(int, int, int);
> +int abc(int a, int, int);
>
> $
>
> ---END---
>
>
> As can be seen only the first parameter in abc is named, but this is
> just a matter of running the script multiple times, so this is not a
> big problem (although if anyone have a solution to have it done in one
> operation, feel free to provide a solution).
>
> However, if I start using other types than int I get in trouble:
>
>
> $?more xyz.*
> ::::::::::::::
> xyz.c
> ::::::::::::::
>
> #include "xyz.h"
>
> int xyz(int x, uint8_t y, int z)
> {
>         return x + y + z;
> }
>
> ::::::::::::::
> xyz.h
> ::::::::::::::
> #include <stdint.h>
>
> int xyz(int, uint8_t, int);
>
> $?spatch --sp-file parameter_wo_name.cocci --recursive-includes -I
> /usr/include xyz.c
> init_defs_builtins: /usr/share/coccinelle/standard.h
> HANDLING: xyz.c
> (ONCE) TYPE: header gnu/stubs-32.h not found
> Fatal error: exception Failure("empty list, max_min_ii_by_pos")
> $?mkdir gnu
> $?touch gnu/stubs-32.h
> $?spatch --sp-file parameter_wo_name.cocci --recursive-includes -I
> /usr/include -I . xyz.c
> init_defs_builtins: /usr/share/coccinelle/standard.h
> HANDLING: xyz.c
> Fatal error: exception Failure("empty list, max_min_ii_by_pos")
> $
>
>
>
> Why is coccinelle failing here and how do I solve this?
>
> BR H?kon L?vdal
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
