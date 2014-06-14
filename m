From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 14 Jun 2014 18:11:51 +0200 (CEST)
Subject: [Cocci] [PATCH] Coccinelle : Script to detect cast after memory
 allocation
In-Reply-To: <1402761961.2756.12.camel@joe-AO725>
References: <20140614154541.GA4179@himangi-Dell>
 <1402761961.2756.12.camel@joe-AO725>
Message-ID: <alpine.DEB.2.02.1406141809050.1962@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, 14 Jun 2014, Joe Perches wrote:

> On Sat, 2014-06-14 at 21:15 +0530, Himangi Saraogi wrote:
> > This script detects cases of use of cast for the value returned by
> > kmalloc, kzalloc, kcalloc, kmem_cache_alloc, kmem_cache_zalloc,
> > kmem_cache_alloc_node, kmalloc_node and kzalloc_node and removes
> > the cast as it is not useful. This Coccinelle script replaces
> > drop_kmalloc_cast.cocci as it removes the casting in more limited
> > cases of kmalloc, kzalloc and kcalloc.
> 
> Perhaps make this more generic for any void *?
> 
> Something like:
> 
> @@
> void *t;
> type other;
> @@
> 
> -       (other *)t
> +       t

Himangi, could you try it and check that you get at least the results that 
you get with the current rule?  Because I'm not sure that Coccinelle would 
have the type information available to know what is the return type of eg
kmalloc.  Maybe you would need to give the option --recursive-includes.

Perhaps it would be reasonable to add this among the specific functions.  
That is, t could be part of the disjunctions.

julia
