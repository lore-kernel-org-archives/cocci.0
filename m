From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 23 Sep 2014 15:58:44 +0200 (CEST)
Subject: [Cocci] wrong indentation
In-Reply-To: <20140923132620.GA32618@rei.suse.cz>
References: <20140923132620.GA32618@rei.suse.cz>
Message-ID: <alpine.DEB.2.10.1409231558070.2463@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, 23 Sep 2014, chrubis at suse.cz wrote:

> Hi!
> I've found that spatch fails to detect correct indentation when it
> replaces two functions inside of #ifdef block with one function.
>
> bug.c:
>
> int main(void)
> {
> #if ! HAVE_XYZ
>         f1();
>         f2();
> #endif
> }
>
> bug.cocci:
>
> @@ @@
> - f1();
> - f2();
> + f3();
>
> result:
>
> init_defs_builtins: /usr/lib64/ocaml/coccinelle/standard.h
> HANDLING: d.c
> diff =
> --- d.c
> +++ /tmp/cocci-output-32687-903dcc-d.c
> @@ -1,7 +1,6 @@
>  int main(void)
>  {
>  #if ! HAVE_XYZ
> -       f1();
> -       f2();
> +f3();
>  #endif
>  }
>
> spatch --version
> spatch version 1.0.0-rc19 with Python support and with PCRE support

Thanks for the report.  It could be a good idea to upgrade to rc21, but
unfortunately the problem is still there.

julia
