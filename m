From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 17 Sep 2014 18:00:51 +0200 (CEST)
Subject: [Cocci] [PATCH] configure: Make it clear that missing ocamldoc
 is fatal
In-Reply-To: <1410966424.4975.106.camel@chaos.site>
References: <1410966424.4975.106.camel@chaos.site>
Message-ID: <alpine.DEB.2.10.1409171800130.2582@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, 17 Sep 2014, Jean Delvare wrote:

> Hi all, hi Julia,
>
> As I was trying to build coccinelle from the sources today, configure
> failed on me with the following error message:
>
> configure: error: You must install the OCaml compiler
>
> I did not understand at first because I do have the ocaml package
> installed, and /usr/bin/ocamlc, which I assume is the OCaml compiler,
> is present. After debugging, I found that what's really missing is
> ocamldoc. Indeed configure warned me about it:
>
> checking for ocamldoc... no
>
> but that did not look fatal so I did not pay attention. As ocamldoc
> is in a separate package (on openSUSE at least), I believe the fatal
> error message should explicitly say whether the compiler itself is
> missing, or ocamldoc is missing.

Thanks very much for the feedback and for the patch.  I will take care of
it.

julia

> ---
> Suggested fix below, there may be other ways.
>
>  configure.ac |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> --- a/configure.ac
> +++ b/configure.ac
> @@ -85,10 +85,14 @@ AC_CHECK_OCAMLVERSION([OCAMLATLEAST310],
>  AC_CHECK_OCAMLVERSION([OCAMLATLEAST311],[3.11])
>  AC_SUBST([OCAMLCORIG],["$OCAMLC"])
>
> -AS_IF([test "x$OCAMLC" = xno -o "x$OCAMLDEP" = xno -o "x$OCAMLDOC" = xno -o "x$OCAMLMKLIB" = xno],
> +AS_IF([test "x$OCAMLC" = xno -o "x$OCAMLDEP" = xno -o "x$OCAMLMKLIB" = xno],
>  [dnl
>    AC_MSG_ERROR([You must install the OCaml compiler])
>  ])
> +AS_IF([test "x$OCAMLDOC" = xno],
> +[dnl
> +  AC_MSG_ERROR([You must install the OCaml documentation generator (ocamldoc)])
> +])
>  AS_IF([test "x$OCAMLATLEAST310" = xno],[AC_MSG_NOTICE([a more recent OCaml installation may be required])])
>
>  dnl  ocaml tools
>
> --
> Jean Delvare
> SUSE L3 Support
>
>
