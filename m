From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 2 Nov 2013 16:09:41 +0100 (CET)
Subject: [Cocci] [PATCH] coccinelle: Add a script to find and remove
 unnecessary ifs with no body
In-Reply-To: <20131102150520.GV15704@leaf>
References: <20131102143236.GA18084@leaf>
 <alpine.DEB.2.02.1311021550330.2261@hadrien> <20131102150520.GV15704@leaf>
Message-ID: <alpine.DEB.2.02.1311021608550.2261@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> I observed several where the patch seemed entirely correct, with no
> FIXME/TODO/XXX comments associated with the conditional.
>
> Nonetheless, I don't mind removing the patch mode if you don't think
> it's worthwhile.  I'll send a v2.

I think it would be better without it.

thanks,
julia
