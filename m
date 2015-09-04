From: joe@perches.com (Joe Perches)
Date: Fri, 04 Sep 2015 09:43:38 -0700
Subject: [Cocci] [PATCH] coccinelle: misc: move constants to the right
In-Reply-To: <1441382154-16840-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1441382154-16840-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1441385018.9666.51.camel@perches.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, 2015-09-04 at 17:55 +0200, Julia Lawall wrote:
> Move constants to the right in binary operators.

Thanks Julia.

I think this should be sent to lkml.

Does this manage to not move upper case identifiers
that aren't constants?

{
	int E = foo();

	if (E < bar())
		baz();
}

> diff --git a/var/julia/linuxcopy/scripts/coccinelle/misc/compare_const_fl.cocci b/var/julia/linuxcopy/scripts/coccinelle/misc/compare_const_fl.cocci
[]
> +++ b/scripts/coccinelle/misc/compare_const_fl.cocci
> @@ -0,0 +1,171 @@
> +/// Move constants to the right of binary operators.
> +//# Depends on personal taste in some cases.
> +///
> +// Confidence: Moderate

If not, maybe some of the cases that don't work
well should be noted in the commit message and
perhaps here in the code comments as well.
