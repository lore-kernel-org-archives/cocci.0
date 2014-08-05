From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 5 Aug 2014 20:16:04 +0200 (CEST)
Subject: [Cocci] [PATCH] Coccinelle: Script to replace if and BUG with
	BUG_ON
In-Reply-To: <53E0E9D0.9040500@suse.cz>
References: <20140720213635.GA12365@himangi-Dell> <53E0E9D0.9040500@suse.cz>
Message-ID: <alpine.DEB.2.02.1408052015440.2047@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 5 Aug 2014, Michal Marek wrote:

> On 2014-07-20 23:36, Himangi Saraogi wrote:
> > This script detects cases where BUG() follows an if condition on an
> > expression and replaces the if condition and BUG() with a BUG_ON having
> > the conditional expression of the if statement as argument.
> > 
> > Signed-off-by: Himangi Saraogi <himangi774@gmail.com>
> > Acked-by: Julia Lawall <julia.lawall@lip6.fr>
> 
> Is this a result of some internal review, or where does Julia's Acked-by
> come from? I'm just wondering, because I haven't seen any previous
> version of this patch.

She sent it to me first.  It's OK with me.

julia
