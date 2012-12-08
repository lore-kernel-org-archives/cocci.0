From: joe@perches.com (Joe Perches)
Date: Sat, 08 Dec 2012 09:45:39 -0800
Subject: [Cocci] [PATCH] scripts/coccinelle/misc/semicolon.cocci: Add
 unneeded semicolon test
In-Reply-To: <1354988074-2165-1-git-send-email-peter.senna@gmail.com>
References: <1354988074-2165-1-git-send-email-peter.senna@gmail.com>
Message-ID: <1354988739.3198.3.camel@joe-AO722>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, 2012-12-08 at 15:34 -0200, Peter Senna Tschudin wrote:
> This semantic patch looks for semicolons that can be removed without
> changing the semantics of the code. The confidence is moderate
> because there are some false positives on cases like:
> 
> b/drivers/mmc/host/cb710-mmc.c:589
>                 break;
>         case MMC_POWER_UP:
>         default:
> -               /* ignore */;
>         }
[]
> diff --git a/scripts/coccinelle/misc/semicolon.cocci b/scripts/coccinelle/misc/semicolon.cocci
[]
> + at r1@
> +statement S;
> +position p1;
> +position p != {r_default.p, r_case.p};
> +identifier label;
> +@@
> +(
> +label:;
> +|
> +S at p1;@p
> +)
> +

I believe this also fails on this case:

	void some_func(...)
	{
		...
		if (foo)
			goto exit;
		...

	exit:
		;
	}

where gcc needs a semicolon after a label before a function exit.
