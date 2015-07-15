From: sean.stalley@intel.com (Sean O. Stalley)
Date: Wed, 15 Jul 2015 14:14:42 -0700
Subject: [Cocci] [PATCH 3/4] pci: mm: Add pci_pool_zalloc() call
In-Reply-To: <1436994883-16563-1-git-send-email-sean.stalley@intel.com>
References: <1436994883-16563-1-git-send-email-sean.stalley@intel.com>
Message-ID: <1436994883-16563-4-git-send-email-sean.stalley@intel.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Add a wrapper function for pci_pool_alloc() to get zeroed memory.

Signed-off-by: Sean O. Stalley <sean.stalley@intel.com>
---
 include/linux/pci.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 755a2cd..e6ec7d9 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1176,6 +1176,8 @@ int pci_set_vga_state(struct pci_dev *pdev, bool decode,
 		dma_pool_create(name, &pdev->dev, size, align, allocation)
 #define	pci_pool_destroy(pool) dma_pool_destroy(pool)
 #define	pci_pool_alloc(pool, flags, handle) dma_pool_alloc(pool, flags, handle)
+#define	pci_pool_zalloc(pool, flags, handle) \
+		dma_pool_zalloc(pool, flags, handle)
 #define	pci_pool_free(pool, vaddr, addr) dma_pool_free(pool, vaddr, addr)
 
 enum pci_dma_burst_strategy {
-- 
1.9.1
