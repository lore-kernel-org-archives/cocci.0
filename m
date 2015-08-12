From: rientjes@google.com (David Rientjes)
Date: Wed, 12 Aug 2015 16:52:12 -0700 (PDT)
Subject: [Cocci] [PATCH v2 1/4] mm: Add support for __GFP_ZERO flag to
 dma_pool_alloc()
In-Reply-To: <1438371404-3219-2-git-send-email-sean.stalley@intel.com>
References: <1438371404-3219-1-git-send-email-sean.stalley@intel.com>
 <1438371404-3219-2-git-send-email-sean.stalley@intel.com>
Message-ID: <alpine.DEB.2.10.1508121649310.30617@chino.kir.corp.google.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, 31 Jul 2015, Sean O. Stalley wrote:

> Currently the __GFP_ZERO flag is ignored by dma_pool_alloc().
> Make dma_pool_alloc() zero the memory if this flag is set.
> 
> Signed-off-by: Sean O. Stalley <sean.stalley@intel.com>

Acked-by: David Rientjes <rientjes@google.com>

This has impacted us as well, and I'm glad to see it fixed.
