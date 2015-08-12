From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 12 Aug 2015 16:00:10 +0200 (CEST)
Subject: [Cocci] [RFC] coccinelle: add style check for assignment in if
In-Reply-To: <1439387500-11183-1-git-send-email-kborer@gmail.com>
References: <1439387500-11183-1-git-send-email-kborer@gmail.com>
Message-ID: <alpine.DEB.2.10.1508121558480.2527@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Thanks for the contribution.  Have you checked very carefully that it
doesn't eg pull XXX out of if (E && XXX)?  (I don't know if it does or it
doesn't, but it is a common pitfall with this issue).

thanks,
julia

On Wed, 12 Aug 2015, Kris Borer wrote:

> Add a semantic patch for fixing some cases of checkpatch.pl error:
>
> ERROR: do not use assignment in if condition
>
> Signed-off-by: Kris Borer <kborer@gmail.com>
> ---
>  scripts/coccinelle/style/assignment_in_if.cocci | 82 +++++++++++++++++++++++++
>  1 file changed, 82 insertions(+)
>  create mode 100644 scripts/coccinelle/style/assignment_in_if.cocci
>
> diff --git a/scripts/coccinelle/style/assignment_in_if.cocci b/scripts/coccinelle/style/assignment_in_if.cocci
> new file mode 100644
> index 0000000..d9895e7
> --- /dev/null
> +++ b/scripts/coccinelle/style/assignment_in_if.cocci
> @@ -0,0 +1,82 @@
> +// find checkpatch.pl errors of the type:
> +//	ERROR: do not use assignment in if condition
> +//
> +// Confidence: Moderate
> +
> +
> +// if ( ret = call() )
> + at if1@
> +identifier i;
> +expression E;
> +statement S1, S2;
> +@@
> +
> ++ i = E;
> +  if (
> +- (i = E)
> ++ i
> +  ) S1 else S2
> +
> +
> +// if ( (ret = call()) < 0 )
> + at if2@
> +identifier i;
> +expression E;
> +statement S1, S2;
> +binary operator b;
> +@@
> +
> ++ i = E;
> +  if (
> +- (i = E)
> ++ i
> +  b ... ) S1 else S2
> +
> +// if ( ptr->fun && (ret = ptr->fun()) < 0 )
> + at if3@
> +identifier i, i2;
> +expression E1, E2;
> +constant c;
> +binary operator b;
> +@@
> +
> ++ if( E1->i ) {
> ++  	i2 = E2;
> ++ 	if (i2 < c) {
> +- if( E1->i && ((i2 = E2) b c) ) {
> +  ...
> +- }
> ++ 	}
> ++ }
> +
> +// if ( (ret = call()) < 0 && ret != 0 )
> + at if4@
> +identifier i;
> +expression E, E2, E3;
> +statement S1, S2;
> +binary operator b;
> +@@
> +
> ++ i = E;
> +  if (
> +- (i = E)
> ++ i
> +  b
> +  ... && E2 && E3 ) S1 else S2
> +
> +// if ( (ret = call()) < 0 && ret != 0 && ret != 0 )
> + at if5@
> +identifier i;
> +expression E, E2, E3;
> +statement S1, S2;
> +binary operator b;
> +@@
> +
> ++ i = E;
> +  if (
> +- (i = E)
> ++ i
> +  b
> +  ... && E2 && E3 ) S1 else S2
> +
> +
> --
> 1.9.1
>
>
