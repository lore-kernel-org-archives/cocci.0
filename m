From: sean.stalley@intel.com (Sean O. Stalley)
Date: Wed, 15 Jul 2015 14:14:41 -0700
Subject: [Cocci] [PATCH 2/4] mm: Add dma_pool_zalloc() call to DMA API
In-Reply-To: <1436994883-16563-1-git-send-email-sean.stalley@intel.com>
References: <1436994883-16563-1-git-send-email-sean.stalley@intel.com>
Message-ID: <1436994883-16563-3-git-send-email-sean.stalley@intel.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Add a wrapper function for dma_pool_alloc() to get zeroed memory.

Signed-off-by: Sean O. Stalley <sean.stalley@intel.com>
---
 Documentation/DMA-API.txt | 7 +++++++
 include/linux/dmapool.h   | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/Documentation/DMA-API.txt b/Documentation/DMA-API.txt
index 5208840..988f757 100644
--- a/Documentation/DMA-API.txt
+++ b/Documentation/DMA-API.txt
@@ -104,6 +104,13 @@ crossing restrictions, pass 0 for alloc; passing 4096 says memory allocated
 from this pool must not cross 4KByte boundaries.
 
 
+	void *dma_pool_zalloc(struct dma_pool *pool, gfp_t mem_flags,
+			      dma_addr_t *handle)
+
+Wraps dma_pool_alloc() and also zeroes the returned memory if the
+allocation attempt succeeded.
+
+
 	void *dma_pool_alloc(struct dma_pool *pool, gfp_t gfp_flags,
 			dma_addr_t *dma_handle);
 
diff --git a/include/linux/dmapool.h b/include/linux/dmapool.h
index 022e34f..6d8079b 100644
--- a/include/linux/dmapool.h
+++ b/include/linux/dmapool.h
@@ -22,6 +22,12 @@ void dma_pool_destroy(struct dma_pool *pool);
 void *dma_pool_alloc(struct dma_pool *pool, gfp_t mem_flags,
 		     dma_addr_t *handle);
 
+static inline void *dma_pool_zalloc(struct dma_pool *pool, gfp_t mem_flags,
+				    dma_addr_t *handle)
+{
+	return dma_pool_alloc(pool, mem_flags | __GFP_ZERO, handle);
+}
+
 void dma_pool_free(struct dma_pool *pool, void *vaddr, dma_addr_t addr);
 
 /*
-- 
1.9.1
