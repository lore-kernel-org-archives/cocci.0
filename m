From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 22 Mar 2017 15:46:32 +0100 (CET)
Subject: [Cocci] Problems with adding code after macro definitions
In-Reply-To: <8873570.AgTeYTv5Np@detux>
References: <8873570.AgTeYTv5Np@detux>
Message-ID: <alpine.DEB.2.20.1703221544480.3413@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 22 Mar 2017, sebald.ziegler.cocci at ikolus.de wrote:

> Hi,
>
> I try to use coccinelle for some kind of Macro instrumentation.
> One important step is to define a wrapper for a macro after the original macro definition.
> This is attempted in the rule: macro_wrapper_int_MAX_int_int
> But I cannot get it to work - see the ???.
> All other rules work as intended.
>
> So the question is: What is the right way to specify the macro definition after which something should be added?
> Is it at all possible to only use the name of the macro and some wildcard (as opposed to using macro name and its definition).
>
> @script:python macros@
> macro_wrapper_int_MAX_int_int_str;
> @@
> coccinelle.macro_wrapper_int_MAX_int_int_str = '({printf("MAX\\n"); MAX(p0, p1); })'
>
> @macro_wrapper_int_MAX_int_int@
> identifier macros.macro_wrapper_int_MAX_int_int_str;
> @@
> #define MAX(x,y) ???
> +#define macro_wrapper_int_MAX_int_int(p0, p1) macro_wrapper_int_MAX_int_int_str

It looks like the body of the macro will be an expression.  So just add
expression e; in the metavariable list, and replace ??? by e.

You can also match macros where the body is a statement.  Unfortunately
macro definitions can be any random thing in general, and I don't think
that would be supported.  At the very least, parsing the macro definition
would fail, so it would not be possible to match against it.

julia

>
> @macro_replacer_macro_wrapper_int_MAX_int_int@
> int P0;
> int P1;
> @@
> -MAX(P0, P1)
> +macro_wrapper_int_MAX_int_int(P0, P1)
>
> C program:
> $ cat test.c
> #define MAX(x,y) ((x>y)?x:y)
> #include <stdio.h>
> int main(int argc, char** argv) {
>         int a=5;
>         int b=7;
>         int d=MAX(a,b+4);
>         return d;
> }
>
> Any hints and information is greatly appreciated!
>
> Thanks,
> Sebald
>
>
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
