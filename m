From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 2 Nov 2013 17:49:27 +0100 (CET)
Subject: [Cocci] [PATCHv2] coccinelle: Add a script to find unnecessary
 ifs with no body
In-Reply-To: <20131102151500.GW15704@leaf>
References: <20131102143236.GA18084@leaf>
 <alpine.DEB.2.02.1311021550330.2261@hadrien> <20131102151500.GW15704@leaf>
Message-ID: <alpine.DEB.2.02.1311021748590.2261@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> + at r depends on report || context@
> +expression E;
> +position p;
> +@@
> +if at p (E) {}

There should be a * in front of the if, to support context mode.

julia
