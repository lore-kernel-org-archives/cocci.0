From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 19 May 2016 12:34:09 +0200 (CEST)
Subject: [Cocci] [RFC 1/3] tests: add test to remove single statement
 from branch
In-Reply-To: <1463607743-11947-2-git-send-email-mcgrof@kernel.org>
References: <1463607743-11947-1-git-send-email-mcgrof@kernel.org>
 <1463607743-11947-2-git-send-email-mcgrof@kernel.org>
Message-ID: <alpine.DEB.2.10.1605191233010.2865@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, 18 May 2016, Luis R. Rodriguez wrote:

> At leaset with coccinelle 1.0.4 this test fails with
> two issues, one is the return statement is shifted,
> another is debatable -- an empty branch statement is
> left. This is funtional however its debatable if this
> is desirable by default.

The return statement should not move, but the if should not be removed
either.  Please send a second version.

Note the type mentioned by Markus as well (leaset, funtional)

thanks,
julia

>
> Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
> ---
>  tests/remove-code-in-branch1.c     | 7 +++++++
>  tests/remove-code-in-branch1.cocci | 4 ++++
>  tests/remove-code-in-branch1.res   | 4 ++++
>  3 files changed, 15 insertions(+)
>  create mode 100644 tests/remove-code-in-branch1.c
>  create mode 100644 tests/remove-code-in-branch1.cocci
>  create mode 100644 tests/remove-code-in-branch1.res
>
> diff --git a/tests/remove-code-in-branch1.c b/tests/remove-code-in-branch1.c
> new file mode 100644
> index 000000000000..83840bdd99ac
> --- /dev/null
> +++ b/tests/remove-code-in-branch1.c
> @@ -0,0 +1,7 @@
> +int main(void)
> +{
> +	if (a > 1)
> +		c();
> +
> +	return 0;
> +}
> diff --git a/tests/remove-code-in-branch1.cocci b/tests/remove-code-in-branch1.cocci
> new file mode 100644
> index 000000000000..b3f03523ac92
> --- /dev/null
> +++ b/tests/remove-code-in-branch1.cocci
> @@ -0,0 +1,4 @@
> + at r@
> +@@
> +
> +-c();
> diff --git a/tests/remove-code-in-branch1.res b/tests/remove-code-in-branch1.res
> new file mode 100644
> index 000000000000..31dbf45bf99c
> --- /dev/null
> +++ b/tests/remove-code-in-branch1.res
> @@ -0,0 +1,4 @@
> +int main(void)
> +{
> +	return 0;
> +}
> --
> 2.7.2
>
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
