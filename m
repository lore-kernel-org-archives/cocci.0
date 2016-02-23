From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 23 Feb 2016 15:00:51 +0100 (CET)
Subject: [Cocci] [PATCH v3] coccinelle: add style check for assignment
	in if
In-Reply-To: <1456163450-28640-1-git-send-email-kborer@gmail.com>
References: <1456163450-28640-1-git-send-email-kborer@gmail.com>
Message-ID: <alpine.DEB.2.02.1602231500260.2168@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 22 Feb 2016, Kris Borer wrote:

> Add a semantic patch for fixing some cases of checkpatch.pl error:
> 
> ERROR: do not use assignment in if condition
> 
> Signed-off-by: Kris Borer <kborer@gmail.com>

Acked-by: Julia Lawall <julia.lawall@lip6.fr>

> ---
> changes since v2
> - added comment warning that changes may not work well with ifdefs
> 
>  scripts/coccinelle/style/assignment_in_if.cocci | 132 ++++++++++++++++++++++++
>  1 file changed, 132 insertions(+)
>  create mode 100644 scripts/coccinelle/style/assignment_in_if.cocci
> 
> diff --git a/scripts/coccinelle/style/assignment_in_if.cocci b/scripts/coccinelle/style/assignment_in_if.cocci
> new file mode 100644
> index 0000000..c99cd7e
> --- /dev/null
> +++ b/scripts/coccinelle/style/assignment_in_if.cocci
> @@ -0,0 +1,132 @@
> +/// move assignments out of if conditions
> +///
> +//# This script is designed to correct code where assignments exist in if
> +//# conditions. It is only capable of handling a subset of such problems.
> +//# Ideally it would handle all checkpatch errors of the following type:
> +//#	ERROR: do not use assignment in if condition
> +//#
> +//# For example:
> +//#	if(result = myfun())
> +//#
> +//# would become:
> +//#	result = myfun();
> +//#	if(result)
> +//#
> +//# note:
> +//#	added braces due to the replacement of an if by multiple statements
> +//#	may not interact well with ifdefs
> +//
> +// Confidence: Moderate
> +// Copyright: (C) 2015 Kris Borer.  GPLv2.
> +// URL: http://coccinelle.lip6.fr/
> +// Comments:
> +// Options: --no-includes --include-headers
> +
> +virtual patch
> +
> +
> +// if ( (ret = call()) )
> +// if ( (ret = call()) < 0 )
> + at if1@
> +expression i;
> +expression E, E2;
> +statement S1, S2;
> +binary operator b;
> +@@
> +
> ++ i = E;
> +  if (
> +(
> +- (i = E)
> ++ i
> +|
> +- (i = E)
> ++ i
> +  b ...
> +|
> +- (i = E),
> +  E2
> +)
> +  ) S1 else S2
> +
> +
> +// if ( ptr->fun && (ret = ptr->fun()) )
> + at if2@
> +expression i2;
> +expression E1, E2;
> +@@
> +
> ++ if( E1 ) {
> ++       i2 = E2;
> ++       if (i2) {
> +- if( E1 && (i2 = E2) ) {
> +  ...
> +- }
> ++       }
> ++ }
> +
> +
> +// if ( ptr->fun && (ret = ptr->fun()) < 0 )
> + at if3@
> +expression i2;
> +expression E1, E2;
> +constant c;
> +binary operator b;
> +@@
> +
> ++ if( E1 ) {
> ++       i2 = E2;
> ++       if (i2 b c) {
> +- if( E1 && ((i2 = E2) b c) ) {
> +  ...
> +- }
> ++       }
> ++ }
> +
> +
> +// if ( (ret = call()) && ret != -1 )
> +// if ( (ret = call()) < 0 && ret != -1 )
> + at if4@
> +expression i;
> +expression E, E2;
> +statement S1, S2;
> +binary operator b;
> +@@
> +
> ++ i = E;
> +  if (
> +(
> +- (i = E)
> ++ i
> +|
> +  (
> +- (i = E)
> ++ i
> +  b
> +  ...)
> +)
> +  && E2 ) S1 else S2
> +
> +
> +// if ( (ret = call()) && ret != -1 && ret != -2 )
> +// if ( (ret = call()) < 0 && ret != -1 && ret != -2 )
> + at if5@
> +expression i;
> +expression E, E2, E3;
> +statement S1, S2;
> +binary operator b;
> +@@
> +
> ++ i = E;
> +  if (
> +(
> +- (i = E)
> ++ i
> +|
> +  (
> +- (i = E)
> ++ i
> +  b
> +  ...)
> +)
> +  && E2 && E3 ) S1 else S2
> -- 
> 1.9.1
> 
> 
