From: joe@perches.com (Joe Perches)
Date: Wed, 28 Mar 2018 11:11:16 -0700
Subject: [Cocci] [PATCH] crypto: cavium: zip: Remove unnecessary
	parentheses
In-Reply-To: <20180328175736.17360-1-rvarsha016@gmail.com>
References: <20180328175736.17360-1-rvarsha016@gmail.com>
Message-ID: <1522260676.12357.121.camel@perches.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, 2018-03-28 at 23:27 +0530, Varsha Rao wrote:
> This patch fixes the clang warning of extraneous parentheses, with the
> following coccinelle script.
> 
> @@
> identifier i;
> constant c;
> @@
> (
> -((i == c))
> +i == c
> > 
> 
> -((i <= c))
> +i <= c

Why just the "==" and "<=" cases?
Why not "<", ">" and ">=" too?

Why not expression instead of constant?
