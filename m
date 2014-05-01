From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 1 May 2014 12:35:43 +0200 (CEST)
Subject: [Cocci] changing all arguments in a call
In-Reply-To: <CAJwHcF6jDP9-L2DcBUKWkLAAvkoJvehaXq4ko-289pokV75e9Q@mail.gmail.com>
References: <CAJwHcF6jDP9-L2DcBUKWkLAAvkoJvehaXq4ko-289pokV75e9Q@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1405011235010.2177@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, 1 May 2014, Akos PASZTORY wrote:

> Hi,
> 
> what did I mess up below?
> I was trying to mangle all arguments of a call but the last one is not handled:
> 
> $ cat bug.c
> void foo() {
>     bar(a,b,c);
> }
> $ cat bug.cocci
> @@ expression e; @@
> bar(...,
> - e,
> + XYZ(e),
> ...)

Just move the comma out of the transformed part:

@@ expression e; @@
bar(...,
- e
+ XYZ(e)
,...)

julia


> $ spatch --sp-file bug.cocci bug.c
> init_defs_builtins: /usr/share/coccinelle/standard.h
> HANDLING: bug.c
> diff =
> --- bug.c
> +++ /tmp/cocci-output-27316-d0cede-bug.c
> @@ -1,3 +1,3 @@
>  void foo() {
> -    bar(a,b,c);
> +    bar(XYZ(a), XYZ(b), c);
>  }
> $ spatch --version
> spatch version 1.0.0-rc21 with Python support and with PCRE support
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
> 
