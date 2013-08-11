From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 11 Aug 2013 23:16:37 +0200 (CEST)
Subject: [Cocci] [PATCH v3] coccinelle: replace 0/1 with false/true in
 functions returning bool
In-Reply-To: <1376255112-22787-1-git-send-email-linux@rasmusvillemoes.dk>
References: <1376071193-21146-1-git-send-email-linux@rasmusvillemoes.dk>
 <1376255112-22787-1-git-send-email-linux@rasmusvillemoes.dk>
Message-ID: <alpine.DEB.2.02.1308112315150.2072@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Acked-by: Julia Lawall <Julia.Lawall@lip6.fr>


On Sun, 11 Aug 2013, Rasmus Villemoes wrote:

> This semantic patch replaces "return {0,1};" with "return
> {false,true};" in functions returning bool.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
> v2: Simplified script, and eliminate whitespace mangling at the same
> time. Thanks to Julia Lawall.
> 
> v3: Further improvements from Julia. In particular, it now also does
> header files.
> 
>  scripts/coccinelle/misc/boolreturn.cocci |   58 ++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 scripts/coccinelle/misc/boolreturn.cocci
> 
> diff --git a/scripts/coccinelle/misc/boolreturn.cocci b/scripts/coccinelle/misc/boolreturn.cocci
> new file mode 100644
> index 0000000..a43c7b0
> --- /dev/null
> +++ b/scripts/coccinelle/misc/boolreturn.cocci
> @@ -0,0 +1,58 @@
> +/// Return statements in functions returning bool should use
> +/// true/false instead of 1/0.
> +//
> +// Confidence: High
> +// Options: --no-includes --include-headers
> +
> +virtual patch
> +virtual report
> +virtual context
> +
> + at r1 depends on patch@
> +identifier fn;
> +typedef bool;
> +symbol false;
> +symbol true;
> +@@
> +
> +bool fn ( ... )
> +{
> +<...
> +return
> +(
> +- 0
> ++ false
> +|
> +- 1
> ++ true
> +)
> +  ;
> +...>
> +}
> +
> + at r2 depends on report || context@
> +identifier fn;
> +position p;
> +@@
> +
> +bool fn ( ... )
> +{
> +<...
> +return
> +(
> +* 0 at p
> +|
> +* 1 at p
> +)
> +  ;
> +...>
> +}
> +
> +
> + at script:python depends on report@
> +p << r2.p;
> +fn << r2.fn;
> +@@
> +
> +msg = "WARNING: return of 0/1 in function '%s' with return type bool" % fn
> +coccilib.report.print_report(p[0], msg)
> -- 
> 1.7.9.5
> 
> 
