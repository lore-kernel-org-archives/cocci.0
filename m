From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 13 Oct 2017 15:59:00 +0200 (CEST)
Subject: [Cocci] How to remove unused global variables by using
 Coccinelle?
In-Reply-To: <tencent_0C53782B45D6A684021E71E3@qq.com>
References: <tencent_0C53782B45D6A684021E71E3@qq.com>
Message-ID: <alpine.DEB.2.20.1710131556040.3242@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 13 Oct 2017, ??? wrote:

> Hello,
>
> Thanks for this awesome tool - Coccinelle.
>
> Currently, I am trying to use Coccinelle to remove unused global variables in C source code. While applying the following remove.cocci to test.c , it does not work.
>
> Can anyone help?
>
> Thanks.
> ---
> Yibiao
>
> $ spatch --version
> spatch version 1.0.6 compiled with OCaml version 4.02.3
> Flags passed to the configure script: [none]
> Python scripting support: yes
> Syntax of regular expresssions: PCRE
>
> $ spatch ?in-place -sp-file remove.cocci small.c
> init_defs_builtins: /usr/local/lib/coccinelle/standard.h
> HANDLING: small.c
>
> $ cat remove.cocci
> @@
> type T;
> identifier i;
> expression E;
> @@
> - static T i = E;
>   ... when != I

This doesn't work for various reasons.  First Coccinelle is case
sensitive, so i is different than I.  Also Coccinelle works on one
function at a time.  So you can't use ... to refer to the rest of the
file.  You want something like:

@r@
type T;
identifier i;
expression E;
@@
static T i = E;

@useful@
identifier r.i;
@@

i

@depends on !useful@
identifier r.i;
@@
- static T i = E;

julia

>
> $ cat small.c
> static int g = 0;
> int main()
> {
>     return 0;
> }
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
