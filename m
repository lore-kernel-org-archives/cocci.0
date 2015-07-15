From: sean.stalley@intel.com (Sean O. Stalley)
Date: Wed, 15 Jul 2015 14:14:39 -0700
Subject: [Cocci] [PATCH 0/4] mm: add dma_pool_zalloc() & pci_pool_zalloc()
Message-ID: <1436994883-16563-1-git-send-email-sean.stalley@intel.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Currently a call to dma_pool_alloc() with a ___GFP_ZERO flag returns
a non-zeroed memory region.

This patchset adds support for the ___GFP_ZERO flag to dma_pool_alloc(),
adds 2 wrapper functions for allocing zeroed memory from a pool, 
and provides a coccinelle script for finding & replacing instances of
dma_pool_alloc() followed by memset(0) with a single dma_pool_zalloc() call.

Sean O. Stalley (4):
  mm: Add support for __GFP_ZERO flag to dma_pool_alloc()
  mm: Add dma_pool_zalloc() call to DMA API
  pci: mm: Add pci_pool_zalloc() call
  coccinelle: mm: scripts/coccinelle/api/alloc/pool_zalloc-simple.cocci

 Documentation/DMA-API.txt                          |  7 ++
 include/linux/dmapool.h                            |  6 ++
 include/linux/pci.h                                |  2 +
 mm/dmapool.c                                       |  6 +-
 .../coccinelle/api/alloc/pool_zalloc-simple.cocci  | 84 ++++++++++++++++++++++
 5 files changed, 104 insertions(+), 1 deletion(-)
 create mode 100644 scripts/coccinelle/api/alloc/pool_zalloc-simple.cocci

-- 
1.9.1
