From: joe@perches.com (Joe Perches)
Date: Sat, 14 Jun 2014 09:06:01 -0700
Subject: [Cocci] [PATCH] Coccinelle : Script to detect cast after memory
 allocation
In-Reply-To: <20140614154541.GA4179@himangi-Dell>
References: <20140614154541.GA4179@himangi-Dell>
Message-ID: <1402761961.2756.12.camel@joe-AO725>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, 2014-06-14 at 21:15 +0530, Himangi Saraogi wrote:
> This script detects cases of use of cast for the value returned by
> kmalloc, kzalloc, kcalloc, kmem_cache_alloc, kmem_cache_zalloc,
> kmem_cache_alloc_node, kmalloc_node and kzalloc_node and removes
> the cast as it is not useful. This Coccinelle script replaces
> drop_kmalloc_cast.cocci as it removes the casting in more limited
> cases of kmalloc, kzalloc and kcalloc.

Perhaps make this more generic for any void *?

Something like:

@@
void *t;
type other;
@@

-       (other *)t
+       t
