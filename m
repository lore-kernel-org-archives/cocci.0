From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 25 Jul 2016 10:50:28 +0200 (CEST)
Subject: [Cocci] [PATCH v2] Coccinelle: Script to replace NULL test with
 IS_ERR test for devm_ioremap_resource
In-Reply-To: <20160725082120.GA5055@amitoj-Inspiron-3542>
References: <20160725082120.GA5055@amitoj-Inspiron-3542>
Message-ID: <alpine.DEB.2.10.1607251047060.3293@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 25 Jul 2016, Amitoj Kaur Chawla wrote:

> This script detects cases which have incorrect error handling for
> devm_ioremap_resource function, employing a NULL test instead of an
> IS_ERR() test.
>
> Signed-off-by: Amitoj Kaur Chawla <amitoj1606@gmail.com>
> ---
> Changes in v2:
>         -Changed script to correct error handling instead of just
>          detecting cases of incorrect error handling
>
>  .../null/devm_ioremap_resource_test.cocci          | 66 ++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 scripts/coccinelle/null/devm_ioremap_resource_test.cocci
>
> diff --git a/scripts/coccinelle/null/devm_ioremap_resource_test.cocci b/scripts/coccinelle/null/devm_ioremap_resource_test.cocci
> new file mode 100644
> index 0000000..671970a
> --- /dev/null
> +++ b/scripts/coccinelle/null/devm_ioremap_resource_test.cocci
> @@ -0,0 +1,66 @@
> +/// Correct error handling for devm_ioremap_resource
> +///
> +// Confidence: High
> +// Copyright: (C) 2016 Amitoj Kaur Chawla
> +// Keywords: devm, devm_ioremap_resource
> +
> +virtual patch
> +virtual context
> +virtual org
> +virtual report
> +
> + at err depends on patch && !context && !org && !report@
> +expression e,e1;
> +@@
> +
> +  e = devm_ioremap_resource(...);
> +  if(
> +-    e == NULL
> ++    IS_ERR(e)
> +    )
> +    {
> +  ...
> +  return
> +- e1
> ++ PTR_ERR(e)
> +  ;
> +  }

Sorry not to have thought about this earlier, but this rule is going to
cause problems.  The ... return e1; hops over any gotos in the if branch.
So it could end up at the return at the end of the function, which might
be reachable from places in which e is not defined in the way expected.
This is likely to result in an error about modifying inconsistent paths.
The rule could be made more complicated to protect against this issue, but
given that the problem found by this semantic patch is now rare in the
first place, perhaps it is not worth it.  People can just make the change
by hand based on the report, and we can just use the original version of
the semantic patch.

julia


> +// ----------------------------------------------------------------------------
> +
> + at err_context depends on !patch && (context || org || report)@
> +expression e, e1;
> +position j0, j1;
> +@@
> +
> +  e at j0 = devm_ioremap_resource(...);
> +  if(
> +*     e == NULL
> +    )
> +    {
> +  ...
> +  return
> +*  e1 at j1
> +  ;
> +  }
> +
> +// ----------------------------------------------------------------------------
> +
> + at script:python err_org depends on org@
> +j0 << err_context.j0;
> +j1 << err_context.j1;
> +@@
> +
> +msg = "Incorrect error handling."
> +coccilib.org.print_todo(j0[0], msg)
> +coccilib.org.print_link(j1[0], "")
> +
> +// ----------------------------------------------------------------------------
> +
> + at script:python err_report depends on report@
> +j0 << err_context.j0;
> +j1 << err_context.j1;
> +@@
> +
> +msg = "Incorrect error handling around line %s." % (j1[0].line)
> +coccilib.report.print_report(j0[0], msg)
> --
> 1.9.1
>
>
