From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 9 Aug 2013 18:18:58 +0200 (CEST)
Subject: [Cocci] [PATCH/RFC] coccinelle: replace 0/1 with false/true in
 functions returning bool
In-Reply-To: <1376064946-20232-1-git-send-email-linux@rasmusvillemoes.dk>
References: <1376064946-20232-1-git-send-email-linux@rasmusvillemoes.dk>
Message-ID: <alpine.DEB.2.02.1308091817010.2295@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 9 Aug 2013, Rasmus Villemoes wrote:

> This semantic patch replaces "return {0,1};" with "return
> {false,true};" in functions returning bool. There doesn't seem to be
> any false positives, but some whitespace mangling is happening, for
> example:

When you change the argument to return, you don't have to recopy the whole
thing.

return
- 0
+ false
  ;

In general, if it is not too inconvenient, it is better not to recopy
code.  That way you are sure that the spaces and newlines will not be
touched.  In this case, it looks like a bug in the pretty printer, but it
it easy to avoid it.

julia

> diff -u -p a/block/blk-throttle.c b/block/blk-throttle.c
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -734,9 +734,7 @@ static inline void throtl_extend_slice(s
>  static bool throtl_slice_used(struct throtl_grp *tg, bool rw)
>  {
>  	if (time_in_range(jiffies, tg->slice_start[rw], tg->slice_end[rw]))
> -		return 0;
> -
> -	return 1;
> +		return false;return true;
>  }
>
> Is there a way to prevent this, or is this the kind of thing which
> must be handled in post-processing?
>
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  scripts/coccinelle/misc/boolreturn.cocci |   51 ++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 scripts/coccinelle/misc/boolreturn.cocci
>
> diff --git a/scripts/coccinelle/misc/boolreturn.cocci b/scripts/coccinelle/misc/boolreturn.cocci
> new file mode 100644
> index 0000000..e6ece0d
> --- /dev/null
> +++ b/scripts/coccinelle/misc/boolreturn.cocci
> @@ -0,0 +1,51 @@
> +/// Return statements in functions returning bool should use
> +/// true/false instead of 1/0.
> +//
> +
> +virtual patch
> +virtual report
> +
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
> +...
> +(
> +-	return 0;
> ++	return false;
> +|
> +-	return 1;
> ++	return true;
> +)
> +...
> +}
> +
> + at r2 depends on !patch@
> +identifier fn;
> +position p;
> +@@
> +
> +bool fn ( ... )
> +{
> +	...
> +(
> +*	return 0 at p ;
> +|
> +*	return 1 at p ;
> +)
> +	...
> +}
> +
> +
> + at script:python depends on report@
> +p << r2.p;
> +fn << r2.fn;
> +@@
> +
> +coccilib.report.print_report(p[0], "WARNING: return of 0/1 in function '%s' with return type bool" % fn)
> --
> 1.7.9.5
>
>
