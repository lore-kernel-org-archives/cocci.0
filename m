Return-Path: <SRS0=WlPR=MC=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8642DC07E95
	for <cocci@archiver.kernel.org>; Sat, 10 Jul 2021 06:46:16 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15069613BE
	for <cocci@archiver.kernel.org>; Sat, 10 Jul 2021 06:46:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15069613BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 16A6k6c0011423;
	Sat, 10 Jul 2021 08:46:06 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 2536742CB;
	Sat, 10 Jul 2021 08:46:06 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 8FC533FE7
 for <cocci@systeme.lip6.fr>; Sat, 10 Jul 2021 02:18:13 +0200 (CEST)
Received: from smtprelay.hostedemail.com (smtprelay0143.hostedemail.com
 [216.40.44.143])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 16A0I8RN010314
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Sat, 10 Jul 2021 02:18:09 +0200 (CEST)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave01.hostedemail.com (Postfix) with ESMTP id 7DD52181EE432
 for <cocci@systeme.lip6.fr>; Fri,  9 Jul 2021 20:39:58 +0000 (UTC)
Received: from omf07.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
 by smtprelay06.hostedemail.com (Postfix) with ESMTP id 413A11822186A;
 Fri,  9 Jul 2021 20:39:53 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by
 omf07.hostedemail.com (Postfix) with ESMTPA id 5EE1C315D76; 
 Fri,  9 Jul 2021 20:39:52 +0000 (UTC)
Message-ID: <08b89608cfb1280624d1a89ead6547069f9a4c31.camel@perches.com>
From: Joe Perches <joe@perches.com>
To: cocci <cocci@systeme.lip6.fr>, LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Date: Fri, 09 Jul 2021 13:39:51 -0700
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
X-Stat-Signature: p8gm4unmuw4swswddgqjs15r3ud18tos
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 5EE1C315D76
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX188jliru3tMGVQG5WvLmv89U8fSMgB4HrY=
X-HE-Tag: 1625863192-583294
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 10 Jul 2021 08:46:09 +0200 (CEST)
X-Greylist: Delayed for 03:29:59 by milter-greylist-4.4.3 (isis.lip6.fr
 [132.227.60.2]); Sat, 10 Jul 2021 02:18:10 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Sat, 10 Jul 2021 08:46:04 +0200
Subject: [Cocci] cocci script to convert linux-kernel allocs with
 BITS_TO_LONGS to bitmap_alloc
X-BeenThere: cocci@systeme.lip6.fr
X-Mailman-Version: 2.1.13
Precedence: list
List-Id: <cocci.systeme.lip6.fr>
List-Unsubscribe: <https://systeme.lip6.fr/mailman/options/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=unsubscribe>
List-Archive: <https://systeme.lip6.fr/pipermail/cocci>
List-Post: <mailto:cocci@systeme.lip6.fr>
List-Help: <mailto:cocci-request@systeme.lip6.fr?subject=help>
List-Subscribe: <https://systeme.lip6.fr/mailman/listinfo/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

Here is a cocci script to convert various types of bitmap allocations
that use BITS_TO_LONGS to the more typical bitmap_alloc functions.

Perhaps something like it could be added to scripts/coccinelle.
The diff produced by the script is also below.

$ cat bitmap_allocs.cocci
// typical uses of bitmap allocations

@@
expression val;
expression e1;
expression e2;
@@

-	val = kcalloc(BITS_TO_LONGS(e1), sizeof(\(long\|unsigned long\)), e2)
+	val = bitmap_zalloc(e1, e2)

@@
expression val;
expression e1;
expression e2;
@@

-	val = kcalloc(BITS_TO_LONGS(e1), sizeof(*val), e2)
+	val = bitmap_zalloc(e1, e2)

@@
expression val;
expression e1;
expression e2;
@@

-	val = kmalloc_array(BITS_TO_LONGS(e1), sizeof(\(long\|unsigned long\)), e2)
+	val = bitmap_alloc(e1, e2)

@@
expression val;
expression e1;
expression e2;
@@

-	val = kmalloc_array(BITS_TO_LONGS(e1), sizeof(*val), e2)
+	val = bitmap_alloc(e1, e2)

@@
expression val;
expression e1;
expression e2;
@@

-	val = kmalloc(BITS_TO_LONGS(e1), sizeof(\(long\|unsigned long\)), e2)
+	val = bitmap_alloc(e1, e2)

@@
expression val;
expression e1;
expression e2;
@@

-	val = kmalloc(BITS_TO_LONGS(e1), sizeof(*val), e2)
+	val = bitmap_alloc(e1, e2)

@@
expression val;
expression e1;
expression e2;
@@

-	val = kmalloc(BITS_TO_LONGS(e1) * sizeof(\(long\|unsigned long\)), e2)
+	val = bitmap_alloc(e1, e2)

@@
expression val;
expression e1;
expression e2;
@@

-	val = kmalloc(BITS_TO_LONGS(e1) * sizeof(*val), e2)
+	val = bitmap_alloc(e1, e2)

@@
expression val;
expression e1;
expression e2;
@@

-	val = kzalloc(BITS_TO_LONGS(e1) * sizeof(\(long\|unsigned long\)), e2)
+	val = bitmap_zalloc(e1, e2)

@@
expression val;
expression e1;
expression e2;
@@

-	val = kzalloc(BITS_TO_LONGS(e1) * sizeof(*val), e2)
+	val = bitmap_zalloc(e1, e2)

// devm_ uses of bitmap allocations

@@
expression dev;
expression val;
expression e1;
expression e2;
@@

-	val = devm_kcalloc(dev, BITS_TO_LONGS(e1), sizeof(\(long\|unsigned long\)), e2)
+	val = devm_bitmap_zalloc(dev, e1, e2)

@@
expression dev;
expression val;
expression e1;
expression e2;
@@

-	val = devm_kcalloc(dev, BITS_TO_LONGS(e1), sizeof(*val), e2)
+	val = devm_bitmap_zalloc(dev, e1, e2)

@@
expression dev;
expression val;
expression e1;
expression e2;
@@

-	val = devm_kmalloc_array(dev, BITS_TO_LONGS(e1), sizeof(\(long\|unsigned long\)), e2)
+	val = devm_bitmap_alloc(dev, e1, e2)

@@
expression dev;
expression val;
expression e1;
expression e2;
@@

-	val = devm_kmalloc_array(dev, BITS_TO_LONGS(e1), sizeof(*val), e2)
+	val = devm_bitmap_alloc(dev, e1, e2)

@@
expression dev;
expression val;
expression e1;
expression e2;
@@

-	val = devm_kmalloc(dev, BITS_TO_LONGS(e1) * sizeof(\(long\|unsigned long\)), e2)
+	val = devm_bitmap_alloc(dev, e1, e2)

@@
expression dev;
expression val;
expression e1;
expression e2;
@@

-	val = devm_kmalloc(dev, BITS_TO_LONGS(e1) * sizeof(*val), e2)
+	val = devm_bitmap_alloc(dev, e1, e2)

@@
expression dev;
expression val;
expression e1;
expression e2;
@@

-	val = devm_kzalloc(dev, BITS_TO_LONGS(e1) * sizeof(\(long\|unsigned long\)), e2)
+	val = devm_bitmap_zalloc(dev, e1, e2)

@@
expression dev;
expression val;
expression e1;
expression e2;
@@

-	val = devm_kzalloc(dev, BITS_TO_LONGS(e1) * sizeof(*val), e2)
+	val = devm_bitmap_zalloc(dev, e1, e2)

$

This cocci script produces this diff against next-20210709

$ spatch -sp-file bitmap_allocs.cocci . --in-place

$ git diff --stat -p
 arch/csky/mm/asid.c                                |  3 +-
 arch/mips/math-emu/dsemul.c                        |  6 +--
 arch/mips/mm/context.c                             |  3 +-
 arch/powerpc/kvm/book3s_hv_uvmem.c                 |  3 +-
 arch/s390/pci/pci.c                                |  3 +-
 drivers/atm/he.c                                   |  4 +-
 drivers/base/regmap/regcache-rbtree.c              |  4 +-
 drivers/block/xen-blkfront.c                       |  3 +-
 drivers/crypto/hisilicon/zip/zip_crypto.c          |  3 +-
 drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c  |  5 +--
 .../crypto/marvell/octeontx2/otx2_cptpf_ucode.c    |  5 +--
 drivers/cxl/pci.c                                  |  6 +--
 drivers/dma/stm32-dmamux.c                         |  6 +--
 drivers/dma/ti/dma-crossbar.c                      |  5 +--
 drivers/dma/ti/edma.c                              |  8 ++--
 drivers/dma/ti/k3-udma.c                           | 46 +++++++---------------
 drivers/firmware/arm_scmi/driver.c                 |  4 +-
 drivers/firmware/ti_sci.c                          | 11 ++----
 drivers/gpu/drm/vc4/vc4_validate_shaders.c         |  5 +--
 drivers/gpu/host1x/channel.c                       |  4 +-
 drivers/hid/hid-multitouch.c                       |  7 ++--
 drivers/infiniband/hw/cxgb4/id_table.c             |  3 +-
 drivers/infiniband/hw/hfi1/user_sdma.c             |  4 +-
 drivers/infiniband/hw/hns/hns_roce_alloc.c         |  3 +-
 drivers/infiniband/hw/irdma/hw.c                   |  5 +--
 drivers/infiniband/hw/mlx4/main.c                  |  6 +--
 drivers/infiniband/hw/mthca/mthca_allocator.c      |  3 +-
 drivers/infiniband/hw/qib/qib_init.c               |  3 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_doorbell.c |  2 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt.c             |  3 +-
 drivers/irqchip/irq-alpine-msi.c                   |  4 +-
 drivers/irqchip/irq-gic-v2m.c                      |  3 +-
 drivers/irqchip/irq-gic-v3-its.c                   |  2 +-
 drivers/irqchip/irq-gic-v3-mbi.c                   |  4 +-
 drivers/irqchip/irq-ls-scfg-msi.c                  |  6 +--
 drivers/irqchip/irq-mvebu-gicp.c                   |  5 +--
 drivers/irqchip/irq-mvebu-odmi.c                   |  3 +-
 drivers/irqchip/irq-partition-percpu.c             |  3 +-
 drivers/lightnvm/core.c                            |  3 +-
 drivers/md/dm-zone.c                               | 10 ++---
 drivers/misc/cxl/irq.c                             |  3 +-
 drivers/misc/cxl/of.c                              |  3 +-
 drivers/misc/habanalabs/common/asid.c              |  4 +-
 drivers/misc/sgi-xp/xpnet.c                        |  5 +--
 drivers/mtd/ubi/fastmap.c                          |  6 +--
 drivers/net/dsa/hirschmann/hellcreek.c             |  7 +---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  4 +-
 drivers/net/ethernet/broadcom/cnic.c               |  2 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c |  2 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c |  4 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c    | 12 ++----
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c    |  3 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_npc.c    |  9 ++---
 drivers/net/ethernet/mellanox/mlx5/core/lib/dm.c   | 10 ++---
 drivers/net/ethernet/qlogic/qed/qed_rdma.c         |  3 +-
 drivers/net/ethernet/sfc/falcon/farch.c            |  4 +-
 drivers/net/ethernet/sfc/farch.c                   |  4 +-
 drivers/net/ethernet/ti/cpsw_ale.c                 |  6 +--
 drivers/net/wireless/intersil/p54/fwio.c           |  5 +--
 drivers/pci/controller/dwc/pcie-designware-ep.c    | 12 ++----
 drivers/pci/controller/pcie-iproc-msi.c            |  4 +-
 drivers/pci/controller/pcie-rcar-ep.c              |  5 +--
 drivers/perf/arm-cci.c                             |  7 ++--
 drivers/scsi/qedi/qedi_main.c                      |  2 +-
 drivers/scsi/qla2xxx/qla_os.c                      |  4 +-
 drivers/soc/qcom/llcc-qcom.c                       |  5 +--
 drivers/soc/ti/k3-ringacc.c                        | 15 +++----
 kernel/events/uprobes.c                            |  3 +-
 net/mac80211/mesh_plink.c                          |  3 +-
 net/netfilter/ipvs/ip_vs_mh.c                      |  3 +-
 net/smc/smc_wr.c                                   |  4 +-
 71 files changed, 135 insertions(+), 247 deletions(-)

diff --git a/arch/csky/mm/asid.c b/arch/csky/mm/asid.c
index b2e914745c1d0..eef49f7d9049b 100644
--- a/arch/csky/mm/asid.c
+++ b/arch/csky/mm/asid.c
@@ -178,8 +178,7 @@ int asid_allocator_init(struct asid_info *info,
 	 */
 	WARN_ON(NUM_CTXT_ASIDS(info) - 1 <= num_possible_cpus());
 	atomic64_set(&info->generation, ASID_FIRST_VERSION(info));
-	info->map = kcalloc(BITS_TO_LONGS(NUM_CTXT_ASIDS(info)),
-			    sizeof(*info->map), GFP_KERNEL);
+	info->map = bitmap_zalloc(NUM_CTXT_ASIDS(info), GFP_KERNEL);
 	if (!info->map)
 		return -ENOMEM;
 
diff --git a/arch/mips/math-emu/dsemul.c b/arch/mips/math-emu/dsemul.c
index e2d46cb93ca98..fc28bcc290750 100644
--- a/arch/mips/math-emu/dsemul.c
+++ b/arch/mips/math-emu/dsemul.c
@@ -82,10 +82,8 @@ static int alloc_emuframe(void)
 
 	/* Ensure we have an allocation bitmap */
 	if (!mm_ctx->bd_emupage_allocmap) {
-		mm_ctx->bd_emupage_allocmap =
-			kcalloc(BITS_TO_LONGS(emupage_frame_count),
-					      sizeof(unsigned long),
-				GFP_ATOMIC);
+		mm_ctx->bd_emupage_allocmap = bitmap_zalloc(emupage_frame_count,
+							    GFP_ATOMIC);
 
 		if (!mm_ctx->bd_emupage_allocmap) {
 			idx = BD_EMUFRAME_NONE;
diff --git a/arch/mips/mm/context.c b/arch/mips/mm/context.c
index b255640909390..09ae989424658 100644
--- a/arch/mips/mm/context.c
+++ b/arch/mips/mm/context.c
@@ -277,8 +277,7 @@ static int mmid_init(void)
 	WARN_ON(num_mmids <= num_possible_cpus());
 
 	atomic64_set(&mmid_version, asid_first_version(0));
-	mmid_map = kcalloc(BITS_TO_LONGS(num_mmids), sizeof(*mmid_map),
-			   GFP_KERNEL);
+	mmid_map = bitmap_zalloc(num_mmids, GFP_KERNEL);
 	if (!mmid_map)
 		panic("Failed to allocate bitmap for %u MMIDs\n", num_mmids);
 
diff --git a/arch/powerpc/kvm/book3s_hv_uvmem.c b/arch/powerpc/kvm/book3s_hv_uvmem.c
index a7061ee3b1577..0ceb7b920a150 100644
--- a/arch/powerpc/kvm/book3s_hv_uvmem.c
+++ b/arch/powerpc/kvm/book3s_hv_uvmem.c
@@ -1185,8 +1185,7 @@ int kvmppc_uvmem_init(void)
 
 	pfn_first = res->start >> PAGE_SHIFT;
 	pfn_last = pfn_first + (resource_size(res) >> PAGE_SHIFT);
-	kvmppc_uvmem_bitmap = kcalloc(BITS_TO_LONGS(pfn_last - pfn_first),
-				      sizeof(unsigned long), GFP_KERNEL);
+	kvmppc_uvmem_bitmap = bitmap_zalloc(pfn_last - pfn_first, GFP_KERNEL);
 	if (!kvmppc_uvmem_bitmap) {
 		ret = -ENOMEM;
 		goto out_unmap;
diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index b0993e05affe6..2e33dbf1cc45d 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -861,8 +861,7 @@ static int zpci_mem_init(void)
 	if (!zpci_iomap_start)
 		goto error_iomap;
 
-	zpci_iomap_bitmap = kcalloc(BITS_TO_LONGS(ZPCI_IOMAP_ENTRIES),
-				    sizeof(*zpci_iomap_bitmap), GFP_KERNEL);
+	zpci_iomap_bitmap = bitmap_zalloc(ZPCI_IOMAP_ENTRIES, GFP_KERNEL);
 	if (!zpci_iomap_bitmap)
 		goto error_iomap_bitmap;
 
diff --git a/drivers/atm/he.c b/drivers/atm/he.c
index 17f44abc9418e..61d37aeec6f86 100644
--- a/drivers/atm/he.c
+++ b/drivers/atm/he.c
@@ -780,9 +780,7 @@ static int he_init_group(struct he_dev *he_dev, int group)
 		  G0_RBPS_BS + (group * 32));
 
 	/* bitmap table */
-	he_dev->rbpl_table = kmalloc_array(BITS_TO_LONGS(RBPL_TABLE_SIZE),
-					   sizeof(*he_dev->rbpl_table),
-					   GFP_KERNEL);
+	he_dev->rbpl_table = bitmap_alloc(RBPL_TABLE_SIZE, GFP_KERNEL);
 	if (!he_dev->rbpl_table) {
 		hprintk("unable to allocate rbpl bitmap table\n");
 		return -ENOMEM;
diff --git a/drivers/base/regmap/regcache-rbtree.c b/drivers/base/regmap/regcache-rbtree.c
index cfa29dc89bbff..8e14b22976982 100644
--- a/drivers/base/regmap/regcache-rbtree.c
+++ b/drivers/base/regmap/regcache-rbtree.c
@@ -351,9 +351,7 @@ regcache_rbtree_node_alloc(struct regmap *map, unsigned int reg)
 	if (!rbnode->block)
 		goto err_free;
 
-	rbnode->cache_present = kcalloc(BITS_TO_LONGS(rbnode->blklen),
-					sizeof(*rbnode->cache_present),
-					GFP_KERNEL);
+	rbnode->cache_present = bitmap_zalloc(rbnode->blklen, GFP_KERNEL);
 	if (!rbnode->cache_present)
 		goto err_free_block;
 
diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 8d49f8fa98bbe..2503b173e111e 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -438,8 +438,7 @@ static int xlbd_reserve_minors(unsigned int minor, unsigned int nr)
 	if (end > nr_minors) {
 		unsigned long *bitmap, *old;
 
-		bitmap = kcalloc(BITS_TO_LONGS(end), sizeof(*bitmap),
-				 GFP_KERNEL);
+		bitmap = bitmap_zalloc(end, GFP_KERNEL);
 		if (bitmap == NULL)
 			return -ENOMEM;
 
diff --git a/drivers/crypto/hisilicon/zip/zip_crypto.c b/drivers/crypto/hisilicon/zip/zip_crypto.c
index 9520a4113c81e..ce31da800504c 100644
--- a/drivers/crypto/hisilicon/zip/zip_crypto.c
+++ b/drivers/crypto/hisilicon/zip/zip_crypto.c
@@ -606,8 +606,7 @@ static int hisi_zip_create_req_q(struct hisi_zip_ctx *ctx)
 		req_q = &ctx->qp_ctx[i].req_q;
 		req_q->size = QM_Q_DEPTH;
 
-		req_q->req_bitmap = kcalloc(BITS_TO_LONGS(req_q->size),
-					    sizeof(long), GFP_KERNEL);
+		req_q->req_bitmap = bitmap_zalloc(req_q->size, GFP_KERNEL);
 		if (!req_q->req_bitmap) {
 			ret = -ENOMEM;
 			if (i == 0)
diff --git a/drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c b/drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c
index 40b482198ebc5..8300fe6a05ca3 100644
--- a/drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c
+++ b/drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c
@@ -1635,9 +1635,8 @@ int otx_cpt_init_eng_grps(struct pci_dev *pdev,
 		snprintf(grp->sysfs_info_name, OTX_CPT_UCODE_NAME_LENGTH,
 			 "engine_group%d", i);
 		for (j = 0; j < OTX_CPT_MAX_ETYPES_PER_GRP; j++) {
-			grp->engs[j].bmap =
-				kcalloc(BITS_TO_LONGS(eng_grps->engs_num),
-					sizeof(long), GFP_KERNEL);
+			grp->engs[j].bmap = bitmap_zalloc(eng_grps->engs_num,
+							  GFP_KERNEL);
 			if (!grp->engs[j].bmap) {
 				ret = -ENOMEM;
 				goto err;
diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c b/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c
index dff34b3ec09e1..dd3a3e4c1334d 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c
@@ -1325,9 +1325,8 @@ int otx2_cpt_init_eng_grps(struct pci_dev *pdev,
 		grp->idx = i;
 
 		for (j = 0; j < OTX2_CPT_MAX_ETYPES_PER_GRP; j++) {
-			grp->engs[j].bmap =
-				kcalloc(BITS_TO_LONGS(eng_grps->engs_num),
-					sizeof(long), GFP_KERNEL);
+			grp->engs[j].bmap = bitmap_zalloc(eng_grps->engs_num,
+							  GFP_KERNEL);
 			if (!grp->engs[j].bmap) {
 				ret = -ENOMEM;
 				goto cleanup_eng_grps;
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 4cf351a3cf992..4d2b6de7581be 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -930,10 +930,8 @@ static struct cxl_mem *cxl_mem_create(struct pci_dev *pdev)
 
 	mutex_init(&cxlm->mbox_mutex);
 	cxlm->pdev = pdev;
-	cxlm->enabled_cmds =
-		devm_kmalloc_array(dev, BITS_TO_LONGS(cxl_cmd_count),
-				   sizeof(unsigned long),
-				   GFP_KERNEL | __GFP_ZERO);
+	cxlm->enabled_cmds = devm_bitmap_alloc(dev, cxl_cmd_count,
+					       GFP_KERNEL | __GFP_ZERO);
 	if (!cxlm->enabled_cmds) {
 		dev_err(dev, "No memory available for bitmap\n");
 		return ERR_PTR(-ENOMEM);
diff --git a/drivers/dma/stm32-dmamux.c b/drivers/dma/stm32-dmamux.c
index ef0d0555103d9..e7d04a4a5a828 100644
--- a/drivers/dma/stm32-dmamux.c
+++ b/drivers/dma/stm32-dmamux.c
@@ -229,10 +229,8 @@ static int stm32_dmamux_probe(struct platform_device *pdev)
 
 	stm32_dmamux->dma_requests = dma_req;
 	stm32_dmamux->dma_reqs[0] = count;
-	stm32_dmamux->dma_inuse = devm_kcalloc(&pdev->dev,
-					       BITS_TO_LONGS(dma_req),
-					       sizeof(unsigned long),
-					       GFP_KERNEL);
+	stm32_dmamux->dma_inuse = devm_bitmap_zalloc(&pdev->dev, dma_req,
+						     GFP_KERNEL);
 	if (!stm32_dmamux->dma_inuse)
 		return -ENOMEM;
 
diff --git a/drivers/dma/ti/dma-crossbar.c b/drivers/dma/ti/dma-crossbar.c
index 71d24fc07c003..9995f9195946e 100644
--- a/drivers/dma/ti/dma-crossbar.c
+++ b/drivers/dma/ti/dma-crossbar.c
@@ -355,9 +355,8 @@ static int ti_dra7_xbar_probe(struct platform_device *pdev)
 	}
 	of_node_put(dma_node);
 
-	xbar->dma_inuse = devm_kcalloc(&pdev->dev,
-				       BITS_TO_LONGS(xbar->dma_requests),
-				       sizeof(unsigned long), GFP_KERNEL);
+	xbar->dma_inuse = devm_bitmap_zalloc(&pdev->dev, xbar->dma_requests,
+					     GFP_KERNEL);
 	if (!xbar->dma_inuse)
 		return -ENOMEM;
 
diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index 35d81bd857f11..2d9407cbeea86 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -2415,12 +2415,10 @@ static int edma_probe(struct platform_device *pdev)
 	ecc->slave_chans = devm_kcalloc(dev, ecc->num_channels,
 					sizeof(*ecc->slave_chans), GFP_KERNEL);
 
-	ecc->slot_inuse = devm_kcalloc(dev, BITS_TO_LONGS(ecc->num_slots),
-				       sizeof(unsigned long), GFP_KERNEL);
+	ecc->slot_inuse = devm_bitmap_zalloc(dev, ecc->num_slots, GFP_KERNEL);
 
-	ecc->channels_mask = devm_kcalloc(dev,
-					   BITS_TO_LONGS(ecc->num_channels),
-					   sizeof(unsigned long), GFP_KERNEL);
+	ecc->channels_mask = devm_bitmap_zalloc(dev, ecc->num_channels,
+						GFP_KERNEL);
 	if (!ecc->slave_chans || !ecc->slot_inuse || !ecc->channels_mask) {
 		ret = -ENOMEM;
 		goto err_disable_pm;
diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 96ad21869ba72..2bcdc8f5ed76c 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -4463,24 +4463,16 @@ static int udma_setup_resources(struct udma_dev *ud)
 	ud->rchan_tpl.start_idx[0] = ud->tchan_tpl.start_idx[0];
 	ud->rchan_tpl.start_idx[1] = ud->tchan_tpl.start_idx[1];
 
-	ud->tchan_map = devm_kmalloc_array(dev, BITS_TO_LONGS(ud->tchan_cnt),
-					   sizeof(unsigned long), GFP_KERNEL);
+	ud->tchan_map = devm_bitmap_alloc(dev, ud->tchan_cnt, GFP_KERNEL);
 	ud->tchans = devm_kcalloc(dev, ud->tchan_cnt, sizeof(*ud->tchans),
 				  GFP_KERNEL);
-	ud->rchan_map = devm_kmalloc_array(dev, BITS_TO_LONGS(ud->rchan_cnt),
-					   sizeof(unsigned long), GFP_KERNEL);
+	ud->rchan_map = devm_bitmap_alloc(dev, ud->rchan_cnt, GFP_KERNEL);
 	ud->rchans = devm_kcalloc(dev, ud->rchan_cnt, sizeof(*ud->rchans),
 				  GFP_KERNEL);
-	ud->rflow_gp_map = devm_kmalloc_array(dev, BITS_TO_LONGS(ud->rflow_cnt),
-					      sizeof(unsigned long),
-					      GFP_KERNEL);
-	ud->rflow_gp_map_allocated = devm_kcalloc(dev,
-						  BITS_TO_LONGS(ud->rflow_cnt),
-						  sizeof(unsigned long),
-						  GFP_KERNEL);
-	ud->rflow_in_use = devm_kcalloc(dev, BITS_TO_LONGS(ud->rflow_cnt),
-					sizeof(unsigned long),
-					GFP_KERNEL);
+	ud->rflow_gp_map = devm_bitmap_alloc(dev, ud->rflow_cnt, GFP_KERNEL);
+	ud->rflow_gp_map_allocated = devm_bitmap_zalloc(dev, ud->rflow_cnt,
+							GFP_KERNEL);
+	ud->rflow_in_use = devm_bitmap_zalloc(dev, ud->rflow_cnt, GFP_KERNEL);
 	ud->rflows = devm_kcalloc(dev, ud->rflow_cnt, sizeof(*ud->rflows),
 				  GFP_KERNEL);
 
@@ -4622,22 +4614,17 @@ static int bcdma_setup_resources(struct udma_dev *ud)
 		ud->tchan_tpl.levels = 1;
 	}
 
-	ud->bchan_map = devm_kmalloc_array(dev, BITS_TO_LONGS(ud->bchan_cnt),
-					   sizeof(unsigned long), GFP_KERNEL);
+	ud->bchan_map = devm_bitmap_alloc(dev, ud->bchan_cnt, GFP_KERNEL);
 	ud->bchans = devm_kcalloc(dev, ud->bchan_cnt, sizeof(*ud->bchans),
 				  GFP_KERNEL);
-	ud->tchan_map = devm_kmalloc_array(dev, BITS_TO_LONGS(ud->tchan_cnt),
-					   sizeof(unsigned long), GFP_KERNEL);
+	ud->tchan_map = devm_bitmap_alloc(dev, ud->tchan_cnt, GFP_KERNEL);
 	ud->tchans = devm_kcalloc(dev, ud->tchan_cnt, sizeof(*ud->tchans),
 				  GFP_KERNEL);
-	ud->rchan_map = devm_kmalloc_array(dev, BITS_TO_LONGS(ud->rchan_cnt),
-					   sizeof(unsigned long), GFP_KERNEL);
+	ud->rchan_map = devm_bitmap_alloc(dev, ud->rchan_cnt, GFP_KERNEL);
 	ud->rchans = devm_kcalloc(dev, ud->rchan_cnt, sizeof(*ud->rchans),
 				  GFP_KERNEL);
 	/* BCDMA do not really have flows, but the driver expect it */
-	ud->rflow_in_use = devm_kcalloc(dev, BITS_TO_LONGS(ud->rchan_cnt),
-					sizeof(unsigned long),
-					GFP_KERNEL);
+	ud->rflow_in_use = devm_bitmap_zalloc(dev, ud->rchan_cnt, GFP_KERNEL);
 	ud->rflows = devm_kcalloc(dev, ud->rchan_cnt, sizeof(*ud->rflows),
 				  GFP_KERNEL);
 
@@ -4780,21 +4767,16 @@ static int pktdma_setup_resources(struct udma_dev *ud)
 	ud->rchan_tpl.start_idx[0] = ud->tchan_tpl.start_idx[0];
 	ud->rchan_tpl.start_idx[1] = ud->tchan_tpl.start_idx[1];
 
-	ud->tchan_map = devm_kmalloc_array(dev, BITS_TO_LONGS(ud->tchan_cnt),
-					   sizeof(unsigned long), GFP_KERNEL);
+	ud->tchan_map = devm_bitmap_alloc(dev, ud->tchan_cnt, GFP_KERNEL);
 	ud->tchans = devm_kcalloc(dev, ud->tchan_cnt, sizeof(*ud->tchans),
 				  GFP_KERNEL);
-	ud->rchan_map = devm_kmalloc_array(dev, BITS_TO_LONGS(ud->rchan_cnt),
-					   sizeof(unsigned long), GFP_KERNEL);
+	ud->rchan_map = devm_bitmap_alloc(dev, ud->rchan_cnt, GFP_KERNEL);
 	ud->rchans = devm_kcalloc(dev, ud->rchan_cnt, sizeof(*ud->rchans),
 				  GFP_KERNEL);
-	ud->rflow_in_use = devm_kcalloc(dev, BITS_TO_LONGS(ud->rflow_cnt),
-					sizeof(unsigned long),
-					GFP_KERNEL);
+	ud->rflow_in_use = devm_bitmap_zalloc(dev, ud->rflow_cnt, GFP_KERNEL);
 	ud->rflows = devm_kcalloc(dev, ud->rflow_cnt, sizeof(*ud->rflows),
 				  GFP_KERNEL);
-	ud->tflow_map = devm_kmalloc_array(dev, BITS_TO_LONGS(ud->tflow_cnt),
-					   sizeof(unsigned long), GFP_KERNEL);
+	ud->tflow_map = devm_bitmap_alloc(dev, ud->tflow_cnt, GFP_KERNEL);
 
 	if (!ud->tchan_map || !ud->rchan_map || !ud->tflow_map || !ud->tchans ||
 	    !ud->rchans || !ud->rflows || !ud->rflow_in_use)
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 36d80661d473d..8a944e2355663 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -1037,8 +1037,8 @@ static int __scmi_xfer_info_init(struct scmi_info *sinfo,
 	if (!info->xfer_block)
 		return -ENOMEM;
 
-	info->xfer_alloc_table = devm_kcalloc(dev, BITS_TO_LONGS(desc->max_msg),
-					      sizeof(long), GFP_KERNEL);
+	info->xfer_alloc_table = devm_bitmap_zalloc(dev, desc->max_msg,
+						    GFP_KERNEL);
 	if (!info->xfer_alloc_table)
 		return -ENOMEM;
 
diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 235c7e7869aa7..df342539c8f85 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -3182,9 +3182,8 @@ devm_ti_sci_get_resource_sets(const struct ti_sci_handle *handle,
 
 		valid_set = true;
 		res_count = res->desc[i].num + res->desc[i].num_sec;
-		res->desc[i].res_map =
-			devm_kzalloc(dev, BITS_TO_LONGS(res_count) *
-				     sizeof(*res->desc[i].res_map), GFP_KERNEL);
+		res->desc[i].res_map = devm_bitmap_zalloc(dev, res_count,
+							  GFP_KERNEL);
 		if (!res->desc[i].res_map)
 			return ERR_PTR(-ENOMEM);
 	}
@@ -3352,10 +3351,8 @@ static int ti_sci_probe(struct platform_device *pdev)
 	if (!minfo->xfer_block)
 		return -ENOMEM;
 
-	minfo->xfer_alloc_table = devm_kcalloc(dev,
-					       BITS_TO_LONGS(desc->max_msgs),
-					       sizeof(unsigned long),
-					       GFP_KERNEL);
+	minfo->xfer_alloc_table = devm_bitmap_zalloc(dev, desc->max_msgs,
+						     GFP_KERNEL);
 	if (!minfo->xfer_alloc_table)
 		return -ENOMEM;
 	bitmap_zero(minfo->xfer_alloc_table, desc->max_msgs);
diff --git a/drivers/gpu/drm/vc4/vc4_validate_shaders.c b/drivers/gpu/drm/vc4/vc4_validate_shaders.c
index 7cf82b071de29..2489da3bf1a5e 100644
--- a/drivers/gpu/drm/vc4/vc4_validate_shaders.c
+++ b/drivers/gpu/drm/vc4/vc4_validate_shaders.c
@@ -791,9 +791,8 @@ vc4_validate_shader(struct drm_gem_cma_object *shader_obj)
 
 	reset_validation_state(&validation_state);
 
-	validation_state.branch_targets =
-		kcalloc(BITS_TO_LONGS(validation_state.max_ip),
-			sizeof(unsigned long), GFP_KERNEL);
+	validation_state.branch_targets = bitmap_zalloc(validation_state.max_ip,
+							GFP_KERNEL);
 	if (!validation_state.branch_targets)
 		goto fail;
 
diff --git a/drivers/gpu/host1x/channel.c b/drivers/gpu/host1x/channel.c
index 4cd212bb570d5..d374e9d7830a9 100644
--- a/drivers/gpu/host1x/channel.c
+++ b/drivers/gpu/host1x/channel.c
@@ -21,9 +21,7 @@ int host1x_channel_list_init(struct host1x_channel_list *chlist,
 	if (!chlist->channels)
 		return -ENOMEM;
 
-	chlist->allocated_channels =
-		kcalloc(BITS_TO_LONGS(num_channels), sizeof(unsigned long),
-			GFP_KERNEL);
+	chlist->allocated_channels = bitmap_zalloc(num_channels, GFP_KERNEL);
 	if (!chlist->allocated_channels) {
 		kfree(chlist->channels);
 		return -ENOMEM;
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 3ea7cb1cda84c..8fc4e16a2a555 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1281,10 +1281,9 @@ static int mt_touch_input_configured(struct hid_device *hdev,
 	if (td->is_buttonpad)
 		__set_bit(INPUT_PROP_BUTTONPAD, input->propbit);
 
-	app->pending_palm_slots = devm_kcalloc(&hi->input->dev,
-					       BITS_TO_LONGS(td->maxcontacts),
-					       sizeof(long),
-					       GFP_KERNEL);
+	app->pending_palm_slots = devm_bitmap_zalloc(&hi->input->dev,
+						     td->maxcontacts,
+						     GFP_KERNEL);
 	if (!app->pending_palm_slots)
 		return -ENOMEM;
 
diff --git a/drivers/infiniband/hw/cxgb4/id_table.c b/drivers/infiniband/hw/cxgb4/id_table.c
index 724d23297b355..b023d780c7a74 100644
--- a/drivers/infiniband/hw/cxgb4/id_table.c
+++ b/drivers/infiniband/hw/cxgb4/id_table.c
@@ -92,8 +92,7 @@ int c4iw_id_table_alloc(struct c4iw_id_table *alloc, u32 start, u32 num,
 		alloc->last = 0;
 	alloc->max  = num;
 	spin_lock_init(&alloc->lock);
-	alloc->table = kmalloc_array(BITS_TO_LONGS(num), sizeof(long),
-				     GFP_KERNEL);
+	alloc->table = bitmap_alloc(num, GFP_KERNEL);
 	if (!alloc->table)
 		return -ENOMEM;
 
diff --git a/drivers/infiniband/hw/hfi1/user_sdma.c b/drivers/infiniband/hw/hfi1/user_sdma.c
index da5b2e37355ab..d1e76d83fe6f6 100644
--- a/drivers/infiniband/hw/hfi1/user_sdma.c
+++ b/drivers/infiniband/hw/hfi1/user_sdma.c
@@ -202,9 +202,7 @@ int hfi1_user_sdma_alloc_queues(struct hfi1_ctxtdata *uctxt,
 	if (!pq->reqs)
 		goto pq_reqs_nomem;
 
-	pq->req_in_use = kcalloc(BITS_TO_LONGS(hfi1_sdma_comp_ring_size),
-				 sizeof(*pq->req_in_use),
-				 GFP_KERNEL);
+	pq->req_in_use = bitmap_zalloc(hfi1_sdma_comp_ring_size, GFP_KERNEL);
 	if (!pq->req_in_use)
 		goto pq_reqs_no_in_use;
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_alloc.c b/drivers/infiniband/hw/hns/hns_roce_alloc.c
index 1b02d3bc9bae2..fcf989d05813d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_alloc.c
+++ b/drivers/infiniband/hw/hns/hns_roce_alloc.c
@@ -90,8 +90,7 @@ int hns_roce_bitmap_init(struct hns_roce_bitmap *bitmap, u32 num, u32 mask,
 	bitmap->mask = mask;
 	bitmap->reserved_top = reserved_top;
 	spin_lock_init(&bitmap->lock);
-	bitmap->table = kcalloc(BITS_TO_LONGS(bitmap->max), sizeof(long),
-				GFP_KERNEL);
+	bitmap->table = bitmap_zalloc(bitmap->max, GFP_KERNEL);
 	if (!bitmap->table)
 		return -ENOMEM;
 
diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/hw.c
index 7afb8a6a0526c..803785a97792b 100644
--- a/drivers/infiniband/hw/irdma/hw.c
+++ b/drivers/infiniband/hw/irdma/hw.c
@@ -1973,9 +1973,8 @@ u32 irdma_initialize_hw_rsrc(struct irdma_pci_f *rf)
 	u32 ret;
 
 	if (rf->rdma_ver != IRDMA_GEN_1) {
-		rf->allocated_ws_nodes =
-			kcalloc(BITS_TO_LONGS(IRDMA_MAX_WS_NODES),
-				sizeof(unsigned long), GFP_KERNEL);
+		rf->allocated_ws_nodes = bitmap_zalloc(IRDMA_MAX_WS_NODES,
+						       GFP_KERNEL);
 		if (!rf->allocated_ws_nodes)
 			return -ENOMEM;
 
diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index ae4c91b612ce3..1f325d3d8377f 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -2773,10 +2773,8 @@ static void *mlx4_ib_add(struct mlx4_dev *dev)
 		if (err)
 			goto err_counter;
 
-		ibdev->ib_uc_qpns_bitmap =
-			kmalloc_array(BITS_TO_LONGS(ibdev->steer_qpn_count),
-				      sizeof(long),
-				      GFP_KERNEL);
+		ibdev->ib_uc_qpns_bitmap = bitmap_alloc(ibdev->steer_qpn_count,
+							GFP_KERNEL);
 		if (!ibdev->ib_uc_qpns_bitmap)
 			goto err_steer_qp_release;
 
diff --git a/drivers/infiniband/hw/mthca/mthca_allocator.c b/drivers/infiniband/hw/mthca/mthca_allocator.c
index aef1d274a14e4..a9e9c4ef1594a 100644
--- a/drivers/infiniband/hw/mthca/mthca_allocator.c
+++ b/drivers/infiniband/hw/mthca/mthca_allocator.c
@@ -90,8 +90,7 @@ int mthca_alloc_init(struct mthca_alloc *alloc, u32 num, u32 mask,
 	alloc->max  = num;
 	alloc->mask = mask;
 	spin_lock_init(&alloc->lock);
-	alloc->table = kmalloc_array(BITS_TO_LONGS(num), sizeof(long),
-				     GFP_KERNEL);
+	alloc->table = bitmap_alloc(num, GFP_KERNEL);
 	if (!alloc->table)
 		return -ENOMEM;
 
diff --git a/drivers/infiniband/hw/qib/qib_init.c b/drivers/infiniband/hw/qib/qib_init.c
index b5a78576c48bd..985d17481ab7a 100644
--- a/drivers/infiniband/hw/qib/qib_init.c
+++ b/drivers/infiniband/hw/qib/qib_init.c
@@ -1106,8 +1106,7 @@ struct qib_devdata *qib_alloc_devdata(struct pci_dev *pdev, size_t extra)
 	if (!qib_cpulist_count) {
 		u32 count = num_online_cpus();
 
-		qib_cpulist = kcalloc(BITS_TO_LONGS(count), sizeof(long),
-				      GFP_KERNEL);
+		qib_cpulist = bitmap_zalloc(count, GFP_KERNEL);
 		if (qib_cpulist)
 			qib_cpulist_count = count;
 	}
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_doorbell.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_doorbell.c
index bf51357ea3aaf..9492650495188 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_doorbell.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_doorbell.c
@@ -63,7 +63,7 @@ int pvrdma_uar_table_init(struct pvrdma_dev *dev)
 	tbl->max = num;
 	tbl->mask = mask;
 	spin_lock_init(&tbl->lock);
-	tbl->table = kcalloc(BITS_TO_LONGS(num), sizeof(long), GFP_KERNEL);
+	tbl->table = bitmap_zalloc(num, GFP_KERNEL);
 	if (!tbl->table)
 		return -ENOMEM;
 
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index f2c40e50f25ea..ce05ae6912a13 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1403,8 +1403,7 @@ static int alloc_permits(struct rtrs_clt *clt)
 	unsigned int chunk_bits;
 	int err, i;
 
-	clt->permits_map = kcalloc(BITS_TO_LONGS(clt->queue_depth),
-				   sizeof(long), GFP_KERNEL);
+	clt->permits_map = bitmap_zalloc(clt->queue_depth, GFP_KERNEL);
 	if (!clt->permits_map) {
 		err = -ENOMEM;
 		goto out_err;
diff --git a/drivers/irqchip/irq-alpine-msi.c b/drivers/irqchip/irq-alpine-msi.c
index ede02dc2bcd0b..25a4e74efdda3 100644
--- a/drivers/irqchip/irq-alpine-msi.c
+++ b/drivers/irqchip/irq-alpine-msi.c
@@ -267,9 +267,7 @@ static int alpine_msix_init(struct device_node *node,
 		goto err_priv;
 	}
 
-	priv->msi_map = kcalloc(BITS_TO_LONGS(priv->num_spis),
-				sizeof(*priv->msi_map),
-				GFP_KERNEL);
+	priv->msi_map = bitmap_zalloc(priv->num_spis, GFP_KERNEL);
 	if (!priv->msi_map) {
 		ret = -ENOMEM;
 		goto err_priv;
diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index be9ea6fd6f8b2..48b546b97f3db 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -386,8 +386,7 @@ static int __init gicv2m_init_one(struct fwnode_handle *fwnode,
 			break;
 		}
 	}
-	v2m->bm = kcalloc(BITS_TO_LONGS(v2m->nr_spis), sizeof(long),
-			  GFP_KERNEL);
+	v2m->bm = bitmap_zalloc(v2m->nr_spis, GFP_KERNEL);
 	if (!v2m->bm) {
 		ret = -ENOMEM;
 		goto err_iounmap;
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index ba39668c3e085..25a924f9b5e66 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2140,7 +2140,7 @@ static unsigned long *its_lpi_alloc(int nr_irqs, u32 *base, int *nr_ids)
 	if (err)
 		goto out;
 
-	bitmap = kcalloc(BITS_TO_LONGS(nr_irqs), sizeof (long), GFP_ATOMIC);
+	bitmap = bitmap_zalloc(nr_irqs, GFP_ATOMIC);
 	if (!bitmap)
 		goto out;
 
diff --git a/drivers/irqchip/irq-gic-v3-mbi.c b/drivers/irqchip/irq-gic-v3-mbi.c
index e81e89a81cb5b..468e68aa6e052 100644
--- a/drivers/irqchip/irq-gic-v3-mbi.c
+++ b/drivers/irqchip/irq-gic-v3-mbi.c
@@ -290,8 +290,8 @@ int __init mbi_init(struct fwnode_handle *fwnode, struct irq_domain *parent)
 		if (ret)
 			goto err_free_mbi;
 
-		mbi_ranges[n].bm = kcalloc(BITS_TO_LONGS(mbi_ranges[n].nr_spis),
-					   sizeof(long), GFP_KERNEL);
+		mbi_ranges[n].bm = bitmap_zalloc(mbi_ranges[n].nr_spis,
+						 GFP_KERNEL);
 		if (!mbi_ranges[n].bm) {
 			ret = -ENOMEM;
 			goto err_free_mbi;
diff --git a/drivers/irqchip/irq-ls-scfg-msi.c b/drivers/irqchip/irq-ls-scfg-msi.c
index 55322da51c56a..fbc10b462d4af 100644
--- a/drivers/irqchip/irq-ls-scfg-msi.c
+++ b/drivers/irqchip/irq-ls-scfg-msi.c
@@ -362,10 +362,8 @@ static int ls_scfg_msi_probe(struct platform_device *pdev)
 
 	msi_data->irqs_num = MSI_IRQS_PER_MSIR *
 			     (1 << msi_data->cfg->ibs_shift);
-	msi_data->used = devm_kcalloc(&pdev->dev,
-				    BITS_TO_LONGS(msi_data->irqs_num),
-				    sizeof(*msi_data->used),
-				    GFP_KERNEL);
+	msi_data->used = devm_bitmap_zalloc(&pdev->dev, msi_data->irqs_num,
+					    GFP_KERNEL);
 	if (!msi_data->used)
 		return -ENOMEM;
 	/*
diff --git a/drivers/irqchip/irq-mvebu-gicp.c b/drivers/irqchip/irq-mvebu-gicp.c
index 3be5c5dba1dab..8857d8a3e5830 100644
--- a/drivers/irqchip/irq-mvebu-gicp.c
+++ b/drivers/irqchip/irq-mvebu-gicp.c
@@ -210,9 +210,8 @@ static int mvebu_gicp_probe(struct platform_device *pdev)
 		gicp->spi_cnt += gicp->spi_ranges[i].count;
 	}
 
-	gicp->spi_bitmap = devm_kcalloc(&pdev->dev,
-				BITS_TO_LONGS(gicp->spi_cnt), sizeof(long),
-				GFP_KERNEL);
+	gicp->spi_bitmap = devm_bitmap_zalloc(&pdev->dev, gicp->spi_cnt,
+					      GFP_KERNEL);
 	if (!gicp->spi_bitmap)
 		return -ENOMEM;
 
diff --git a/drivers/irqchip/irq-mvebu-odmi.c b/drivers/irqchip/irq-mvebu-odmi.c
index b4d367868dbbe..6c7c77a19a4e8 100644
--- a/drivers/irqchip/irq-mvebu-odmi.c
+++ b/drivers/irqchip/irq-mvebu-odmi.c
@@ -171,8 +171,7 @@ static int __init mvebu_odmi_init(struct device_node *node,
 	if (!odmis)
 		return -ENOMEM;
 
-	odmis_bm = kcalloc(BITS_TO_LONGS(odmis_count * NODMIS_PER_FRAME),
-			   sizeof(long), GFP_KERNEL);
+	odmis_bm = bitmap_zalloc(odmis_count * NODMIS_PER_FRAME, GFP_KERNEL);
 	if (!odmis_bm) {
 		ret = -ENOMEM;
 		goto err_alloc;
diff --git a/drivers/irqchip/irq-partition-percpu.c b/drivers/irqchip/irq-partition-percpu.c
index 89c23a1566dcf..8e76d2913e6be 100644
--- a/drivers/irqchip/irq-partition-percpu.c
+++ b/drivers/irqchip/irq-partition-percpu.c
@@ -215,8 +215,7 @@ struct partition_desc *partition_create_desc(struct fwnode_handle *fwnode,
 		goto out;
 	desc->domain = d;
 
-	desc->bitmap = kcalloc(BITS_TO_LONGS(nr_parts), sizeof(long),
-			       GFP_KERNEL);
+	desc->bitmap = bitmap_zalloc(nr_parts, GFP_KERNEL);
 	if (WARN_ON(!desc->bitmap))
 		goto out;
 
diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index cf8a754948335..8bc684d655fdb 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -1081,8 +1081,7 @@ static int nvm_core_init(struct nvm_dev *dev)
 	struct nvm_geo *geo = &dev->geo;
 	int ret;
 
-	dev->lun_map = kcalloc(BITS_TO_LONGS(geo->all_luns),
-					sizeof(unsigned long), GFP_KERNEL);
+	dev->lun_map = bitmap_zalloc(geo->all_luns, GFP_KERNEL);
 	if (!dev->lun_map)
 		return -ENOMEM;
 
diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
index 6d82a34438c85..0c613cee9fd89 100644
--- a/drivers/md/dm-zone.c
+++ b/drivers/md/dm-zone.c
@@ -185,9 +185,8 @@ static int dm_zone_revalidate_cb(struct blk_zone *zone, unsigned int idx,
 	switch (zone->type) {
 	case BLK_ZONE_TYPE_CONVENTIONAL:
 		if (!q->conv_zones_bitmap) {
-			q->conv_zones_bitmap =
-				kcalloc(BITS_TO_LONGS(q->nr_zones),
-					sizeof(unsigned long), GFP_NOIO);
+			q->conv_zones_bitmap = bitmap_zalloc(q->nr_zones,
+							     GFP_NOIO);
 			if (!q->conv_zones_bitmap)
 				return -ENOMEM;
 		}
@@ -196,9 +195,8 @@ static int dm_zone_revalidate_cb(struct blk_zone *zone, unsigned int idx,
 	case BLK_ZONE_TYPE_SEQWRITE_REQ:
 	case BLK_ZONE_TYPE_SEQWRITE_PREF:
 		if (!q->seq_zones_wlock) {
-			q->seq_zones_wlock =
-				kcalloc(BITS_TO_LONGS(q->nr_zones),
-					sizeof(unsigned long), GFP_NOIO);
+			q->seq_zones_wlock = bitmap_zalloc(q->nr_zones,
+							   GFP_NOIO);
 			if (!q->seq_zones_wlock)
 				return -ENOMEM;
 		}
diff --git a/drivers/misc/cxl/irq.c b/drivers/misc/cxl/irq.c
index 4cb829d5d873c..5f2a96bbc1625 100644
--- a/drivers/misc/cxl/irq.c
+++ b/drivers/misc/cxl/irq.c
@@ -318,8 +318,7 @@ int afu_allocate_irqs(struct cxl_context *ctx, u32 count)
 	}
 
 	ctx->irq_count = count;
-	ctx->irq_bitmap = kcalloc(BITS_TO_LONGS(count),
-				  sizeof(*ctx->irq_bitmap), GFP_KERNEL);
+	ctx->irq_bitmap = bitmap_zalloc(count, GFP_KERNEL);
 	if (!ctx->irq_bitmap)
 		goto out;
 
diff --git a/drivers/misc/cxl/of.c b/drivers/misc/cxl/of.c
index 1cfecba42d019..49fead5eb4aa8 100644
--- a/drivers/misc/cxl/of.c
+++ b/drivers/misc/cxl/of.c
@@ -308,8 +308,7 @@ static int read_adapter_irq_config(struct cxl *adapter, struct device_node *np)
 		cur = &adapter->guest->irq_avail[i];
 		cur->offset = be32_to_cpu(ranges[i * 2]);
 		cur->range  = be32_to_cpu(ranges[i * 2 + 1]);
-		cur->bitmap = kcalloc(BITS_TO_LONGS(cur->range),
-				sizeof(*cur->bitmap), GFP_KERNEL);
+		cur->bitmap = bitmap_zalloc(cur->range, GFP_KERNEL);
 		if (cur->bitmap == NULL)
 			goto err;
 		if (cur->offset < adapter->guest->irq_base_offset)
diff --git a/drivers/misc/habanalabs/common/asid.c b/drivers/misc/habanalabs/common/asid.c
index ede04c032b6e8..f24ea25782a23 100644
--- a/drivers/misc/habanalabs/common/asid.c
+++ b/drivers/misc/habanalabs/common/asid.c
@@ -11,8 +11,8 @@
 
 int hl_asid_init(struct hl_device *hdev)
 {
-	hdev->asid_bitmap = kcalloc(BITS_TO_LONGS(hdev->asic_prop.max_asid),
-					sizeof(*hdev->asid_bitmap), GFP_KERNEL);
+	hdev->asid_bitmap = bitmap_zalloc(hdev->asic_prop.max_asid,
+					  GFP_KERNEL);
 	if (!hdev->asid_bitmap)
 		return -ENOMEM;
 
diff --git a/drivers/misc/sgi-xp/xpnet.c b/drivers/misc/sgi-xp/xpnet.c
index 2508f83bdc3fa..4d1db9c3edbc7 100644
--- a/drivers/misc/sgi-xp/xpnet.c
+++ b/drivers/misc/sgi-xp/xpnet.c
@@ -521,9 +521,8 @@ xpnet_init(void)
 
 	dev_info(xpnet, "registering network device %s\n", XPNET_DEVICE_NAME);
 
-	xpnet_broadcast_partitions = kcalloc(BITS_TO_LONGS(xp_max_npartitions),
-					     sizeof(long),
-					     GFP_KERNEL);
+	xpnet_broadcast_partitions = bitmap_zalloc(xp_max_npartitions,
+						   GFP_KERNEL);
 	if (xpnet_broadcast_partitions == NULL)
 		return -ENOMEM;
 
diff --git a/drivers/mtd/ubi/fastmap.c b/drivers/mtd/ubi/fastmap.c
index 022af59906aa9..12b5d3c6902c1 100644
--- a/drivers/mtd/ubi/fastmap.c
+++ b/drivers/mtd/ubi/fastmap.c
@@ -20,8 +20,7 @@ static inline unsigned long *init_seen(struct ubi_device *ubi)
 	if (!ubi_dbg_chk_fastmap(ubi))
 		return NULL;
 
-	ret = kcalloc(BITS_TO_LONGS(ubi->peb_count), sizeof(unsigned long),
-		      GFP_KERNEL);
+	ret = bitmap_zalloc(ubi->peb_count, GFP_KERNEL);
 	if (!ret)
 		return ERR_PTR(-ENOMEM);
 
@@ -1098,8 +1097,7 @@ int ubi_fastmap_init_checkmap(struct ubi_volume *vol, int leb_count)
 	if (!ubi->fast_attach)
 		return 0;
 
-	vol->checkmap = kcalloc(BITS_TO_LONGS(leb_count), sizeof(unsigned long),
-				GFP_KERNEL);
+	vol->checkmap = bitmap_zalloc(leb_count, GFP_KERNEL);
 	if (!vol->checkmap)
 		return -ENOMEM;
 
diff --git a/drivers/net/dsa/hirschmann/hellcreek.c b/drivers/net/dsa/hirschmann/hellcreek.c
index 9fdcc4bde4809..ecbe506b4e1fc 100644
--- a/drivers/net/dsa/hirschmann/hellcreek.c
+++ b/drivers/net/dsa/hirschmann/hellcreek.c
@@ -1813,11 +1813,8 @@ static int hellcreek_probe(struct platform_device *pdev)
 		if (!port->counter_values)
 			return -ENOMEM;
 
-		port->vlan_dev_bitmap =
-			devm_kcalloc(dev,
-				     BITS_TO_LONGS(VLAN_N_VID),
-				     sizeof(unsigned long),
-				     GFP_KERNEL);
+		port->vlan_dev_bitmap = devm_bitmap_zalloc(dev, VLAN_N_VID,
+							   GFP_KERNEL);
 		if (!port->vlan_dev_bitmap)
 			return -ENOMEM;
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index f56245eeef7b1..6a47d3e073b55 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4200,9 +4200,7 @@ static int bnxt_alloc_ntp_fltrs(struct bnxt *bp)
 		INIT_HLIST_HEAD(&bp->ntp_fltr_hash_tbl[i]);
 
 	bp->ntp_fltr_count = 0;
-	bp->ntp_fltr_bmap = kcalloc(BITS_TO_LONGS(BNXT_NTP_FLTR_MAX_FLTR),
-				    sizeof(long),
-				    GFP_KERNEL);
+	bp->ntp_fltr_bmap = bitmap_zalloc(BNXT_NTP_FLTR_MAX_FLTR, GFP_KERNEL);
 
 	if (!bp->ntp_fltr_bmap)
 		rc = -ENOMEM;
diff --git a/drivers/net/ethernet/broadcom/cnic.c b/drivers/net/ethernet/broadcom/cnic.c
index f7f10cfb3476e..1d06e4cdd75ed 100644
--- a/drivers/net/ethernet/broadcom/cnic.c
+++ b/drivers/net/ethernet/broadcom/cnic.c
@@ -660,7 +660,7 @@ static int cnic_init_id_tbl(struct cnic_id_tbl *id_tbl, u32 size, u32 start_id,
 	id_tbl->max = size;
 	id_tbl->next = next;
 	spin_lock_init(&id_tbl->lock);
-	id_tbl->table = kcalloc(BITS_TO_LONGS(size), sizeof(long), GFP_KERNEL);
+	id_tbl->table = bitmap_zalloc(size, GFP_KERNEL);
 	if (!id_tbl->table)
 		return -ENOMEM;
 
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c
index 7d49fd4edc9ec..8000d4e021093 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c
@@ -3429,7 +3429,7 @@ static ssize_t blocked_fl_write(struct file *filp, const char __user *ubuf,
 	unsigned long *t;
 	struct adapter *adap = filp->private_data;
 
-	t = kcalloc(BITS_TO_LONGS(adap->sge.egr_sz), sizeof(long), GFP_KERNEL);
+	t = bitmap_zalloc(adap->sge.egr_sz, GFP_KERNEL);
 	if (!t)
 		return -ENOMEM;
 
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
index 83ed10ac86606..252220ad6b345 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
@@ -2250,9 +2250,7 @@ int cxgb4_init_ethtool_filters(struct adapter *adap)
 			goto free_eth_finfo;
 		}
 
-		eth_filter->port[i].bmap = kcalloc(BITS_TO_LONGS(nentries),
-						   sizeof(unsigned long),
-						   GFP_KERNEL);
+		eth_filter->port[i].bmap = bitmap_zalloc(nentries, GFP_KERNEL);
 		if (!eth_filter->port[i].bmap) {
 			ret = -ENOMEM;
 			goto free_eth_finfo;
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
index dbf9a0e6601d1..2d207a27bdcfb 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
@@ -5047,23 +5047,20 @@ static int adap_init0(struct adapter *adap, int vpd_skip)
 	/* Allocate the memory for the vaious egress queue bitmaps
 	 * ie starving_fl, txq_maperr and blocked_fl.
 	 */
-	adap->sge.starving_fl =	kcalloc(BITS_TO_LONGS(adap->sge.egr_sz),
-					sizeof(long), GFP_KERNEL);
+	adap->sge.starving_fl = bitmap_zalloc(adap->sge.egr_sz, GFP_KERNEL);
 	if (!adap->sge.starving_fl) {
 		ret = -ENOMEM;
 		goto bye;
 	}
 
-	adap->sge.txq_maperr = kcalloc(BITS_TO_LONGS(adap->sge.egr_sz),
-				       sizeof(long), GFP_KERNEL);
+	adap->sge.txq_maperr = bitmap_zalloc(adap->sge.egr_sz, GFP_KERNEL);
 	if (!adap->sge.txq_maperr) {
 		ret = -ENOMEM;
 		goto bye;
 	}
 
 #ifdef CONFIG_DEBUG_FS
-	adap->sge.blocked_fl = kcalloc(BITS_TO_LONGS(adap->sge.egr_sz),
-				       sizeof(long), GFP_KERNEL);
+	adap->sge.blocked_fl = bitmap_zalloc(adap->sge.egr_sz, GFP_KERNEL);
 	if (!adap->sge.blocked_fl) {
 		ret = -ENOMEM;
 		goto bye;
@@ -5853,8 +5850,7 @@ static int alloc_msix_info(struct adapter *adap, u32 num_vec)
 	if (!msix_info)
 		return -ENOMEM;
 
-	adap->msix_bmap.msix_bmap = kcalloc(BITS_TO_LONGS(num_vec),
-					    sizeof(long), GFP_KERNEL);
+	adap->msix_bmap.msix_bmap = bitmap_zalloc(num_vec, GFP_KERNEL);
 	if (!adap->msix_bmap.msix_bmap) {
 		kfree(msix_info);
 		return -ENOMEM;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index 10cddf1ac7b9e..05d4ead7d1512 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -194,8 +194,7 @@ bool is_rsrc_free(struct rsrc_bmap *rsrc, int id)
 
 int rvu_alloc_bitmap(struct rsrc_bmap *rsrc)
 {
-	rsrc->bmap = kcalloc(BITS_TO_LONGS(rsrc->max),
-			     sizeof(long), GFP_KERNEL);
+	rsrc->bmap = bitmap_zalloc(rsrc->max, GFP_KERNEL);
 	if (!rsrc->bmap)
 		return -ENOMEM;
 	return 0;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index 3612e0a2cab32..2dcfd440e5354 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -1782,14 +1782,13 @@ static int npc_mcam_rsrcs_init(struct rvu *rvu, int blkaddr)
 	mcam->pf_offset = mcam->nixlf_offset + nixlf_count;
 
 	/* Allocate bitmaps for managing MCAM entries */
-	mcam->bmap = devm_kcalloc(rvu->dev, BITS_TO_LONGS(mcam->bmap_entries),
-				  sizeof(long), GFP_KERNEL);
+	mcam->bmap = devm_bitmap_zalloc(rvu->dev, mcam->bmap_entries,
+					GFP_KERNEL);
 	if (!mcam->bmap)
 		return -ENOMEM;
 
-	mcam->bmap_reverse = devm_kcalloc(rvu->dev,
-					  BITS_TO_LONGS(mcam->bmap_entries),
-					  sizeof(long), GFP_KERNEL);
+	mcam->bmap_reverse = devm_bitmap_zalloc(rvu->dev, mcam->bmap_entries,
+						GFP_KERNEL);
 	if (!mcam->bmap_reverse)
 		return -ENOMEM;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/dm.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/dm.c
index 3d5e57ff558c1..f0f138eef47e9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/dm.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/dm.c
@@ -34,9 +34,8 @@ struct mlx5_dm *mlx5_dm_create(struct mlx5_core_dev *dev)
 			BIT(MLX5_CAP_DEV_MEM(dev, log_steering_sw_icm_size) -
 			    MLX5_LOG_SW_ICM_BLOCK_SIZE(dev));
 
-		dm->steering_sw_icm_alloc_blocks =
-			kcalloc(BITS_TO_LONGS(steering_icm_blocks),
-				sizeof(unsigned long), GFP_KERNEL);
+		dm->steering_sw_icm_alloc_blocks = bitmap_zalloc(steering_icm_blocks,
+								 GFP_KERNEL);
 		if (!dm->steering_sw_icm_alloc_blocks)
 			goto err_steering;
 	}
@@ -46,9 +45,8 @@ struct mlx5_dm *mlx5_dm_create(struct mlx5_core_dev *dev)
 			BIT(MLX5_CAP_DEV_MEM(dev, log_header_modify_sw_icm_size) -
 			    MLX5_LOG_SW_ICM_BLOCK_SIZE(dev));
 
-		dm->header_modify_sw_icm_alloc_blocks =
-			kcalloc(BITS_TO_LONGS(header_modify_icm_blocks),
-				sizeof(unsigned long), GFP_KERNEL);
+		dm->header_modify_sw_icm_alloc_blocks = bitmap_zalloc(header_modify_icm_blocks,
+								      GFP_KERNEL);
 		if (!dm->header_modify_sw_icm_alloc_blocks)
 			goto err_modify_hdr;
 	}
diff --git a/drivers/net/ethernet/qlogic/qed/qed_rdma.c b/drivers/net/ethernet/qlogic/qed/qed_rdma.c
index da864d12916b7..9f51e255194aa 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_rdma.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_rdma.c
@@ -41,8 +41,7 @@ int qed_rdma_bmap_alloc(struct qed_hwfn *p_hwfn,
 
 	bmap->max_count = max_count;
 
-	bmap->bitmap = kcalloc(BITS_TO_LONGS(max_count), sizeof(long),
-			       GFP_KERNEL);
+	bmap->bitmap = bitmap_zalloc(max_count, GFP_KERNEL);
 	if (!bmap->bitmap)
 		return -ENOMEM;
 
diff --git a/drivers/net/ethernet/sfc/falcon/farch.c b/drivers/net/ethernet/sfc/falcon/farch.c
index 2c91792cec014..00cf5fa65b230 100644
--- a/drivers/net/ethernet/sfc/falcon/farch.c
+++ b/drivers/net/ethernet/sfc/falcon/farch.c
@@ -2740,9 +2740,7 @@ int ef4_farch_filter_table_probe(struct ef4_nic *efx)
 		table = &state->table[table_id];
 		if (table->size == 0)
 			continue;
-		table->used_bitmap = kcalloc(BITS_TO_LONGS(table->size),
-					     sizeof(unsigned long),
-					     GFP_KERNEL);
+		table->used_bitmap = bitmap_zalloc(table->size, GFP_KERNEL);
 		if (!table->used_bitmap)
 			goto fail;
 		table->spec = vzalloc(array_size(sizeof(*table->spec),
diff --git a/drivers/net/ethernet/sfc/farch.c b/drivers/net/ethernet/sfc/farch.c
index 148dcd48b58d3..b4aadd1346ca7 100644
--- a/drivers/net/ethernet/sfc/farch.c
+++ b/drivers/net/ethernet/sfc/farch.c
@@ -2820,9 +2820,7 @@ int efx_farch_filter_table_probe(struct efx_nic *efx)
 		table = &state->table[table_id];
 		if (table->size == 0)
 			continue;
-		table->used_bitmap = kcalloc(BITS_TO_LONGS(table->size),
-					     sizeof(unsigned long),
-					     GFP_KERNEL);
+		table->used_bitmap = bitmap_zalloc(table->size, GFP_KERNEL);
 		if (!table->used_bitmap)
 			goto fail;
 		table->spec = vzalloc(array_size(sizeof(*table->spec),
diff --git a/drivers/net/ethernet/ti/cpsw_ale.c b/drivers/net/ethernet/ti/cpsw_ale.c
index 0c75e0576ee1f..3f1852c992533 100644
--- a/drivers/net/ethernet/ti/cpsw_ale.c
+++ b/drivers/net/ethernet/ti/cpsw_ale.c
@@ -1299,10 +1299,8 @@ struct cpsw_ale *cpsw_ale_create(struct cpsw_ale_params *params)
 	if (!ale)
 		return ERR_PTR(-ENOMEM);
 
-	ale->p0_untag_vid_mask =
-		devm_kmalloc_array(params->dev, BITS_TO_LONGS(VLAN_N_VID),
-				   sizeof(unsigned long),
-				   GFP_KERNEL);
+	ale->p0_untag_vid_mask = devm_bitmap_alloc(params->dev, VLAN_N_VID,
+						   GFP_KERNEL);
 	if (!ale->p0_untag_vid_mask)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/drivers/net/wireless/intersil/p54/fwio.c b/drivers/net/wireless/intersil/p54/fwio.c
index bece14e4ff0df..31fd06312cd81 100644
--- a/drivers/net/wireless/intersil/p54/fwio.c
+++ b/drivers/net/wireless/intersil/p54/fwio.c
@@ -173,9 +173,8 @@ int p54_parse_firmware(struct ieee80211_hw *dev, const struct firmware *fw)
 		 * keeping a extra list for uploaded keys.
 		 */
 
-		priv->used_rxkeys = kcalloc(BITS_TO_LONGS(priv->rx_keycache_size),
-					    sizeof(long),
-					    GFP_KERNEL);
+		priv->used_rxkeys = bitmap_zalloc(priv->rx_keycache_size,
+						  GFP_KERNEL);
 
 		if (!priv->used_rxkeys)
 			return -ENOMEM;
diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 8d028a88b375b..0f94702558f10 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -714,17 +714,13 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	ep->phys_base = res->start;
 	ep->addr_size = resource_size(res);
 
-	ep->ib_window_map = devm_kcalloc(dev,
-					 BITS_TO_LONGS(pci->num_ib_windows),
-					 sizeof(long),
-					 GFP_KERNEL);
+	ep->ib_window_map = devm_bitmap_zalloc(dev, pci->num_ib_windows,
+					       GFP_KERNEL);
 	if (!ep->ib_window_map)
 		return -ENOMEM;
 
-	ep->ob_window_map = devm_kcalloc(dev,
-					 BITS_TO_LONGS(pci->num_ob_windows),
-					 sizeof(long),
-					 GFP_KERNEL);
+	ep->ob_window_map = devm_bitmap_zalloc(dev, pci->num_ob_windows,
+					       GFP_KERNEL);
 	if (!ep->ob_window_map)
 		return -ENOMEM;
 
diff --git a/drivers/pci/controller/pcie-iproc-msi.c b/drivers/pci/controller/pcie-iproc-msi.c
index 35a82124a1260..9ca2e8172a1dc 100644
--- a/drivers/pci/controller/pcie-iproc-msi.c
+++ b/drivers/pci/controller/pcie-iproc-msi.c
@@ -591,8 +591,8 @@ int iproc_msi_init(struct iproc_pcie *pcie, struct device_node *node)
 		msi->has_inten_reg = true;
 
 	msi->nr_msi_vecs = msi->nr_irqs * EQ_LEN;
-	msi->bitmap = devm_kcalloc(pcie->dev, BITS_TO_LONGS(msi->nr_msi_vecs),
-				   sizeof(*msi->bitmap), GFP_KERNEL);
+	msi->bitmap = devm_bitmap_zalloc(pcie->dev, msi->nr_msi_vecs,
+					 GFP_KERNEL);
 	if (!msi->bitmap)
 		return -ENOMEM;
 
diff --git a/drivers/pci/controller/pcie-rcar-ep.c b/drivers/pci/controller/pcie-rcar-ep.c
index b4a288e24aafb..9c703c325c697 100644
--- a/drivers/pci/controller/pcie-rcar-ep.c
+++ b/drivers/pci/controller/pcie-rcar-ep.c
@@ -505,9 +505,8 @@ static int rcar_pcie_ep_probe(struct platform_device *pdev)
 	}
 
 	ep->num_ib_windows = MAX_NR_INBOUND_MAPS;
-	ep->ib_window_map =
-			devm_kcalloc(dev, BITS_TO_LONGS(ep->num_ib_windows),
-				     sizeof(long), GFP_KERNEL);
+	ep->ib_window_map = devm_bitmap_zalloc(dev, ep->num_ib_windows,
+					       GFP_KERNEL);
 	if (!ep->ib_window_map) {
 		err = -ENOMEM;
 		dev_err(dev, "failed to allocate memory for inbound map\n");
diff --git a/drivers/perf/arm-cci.c b/drivers/perf/arm-cci.c
index 54aca3a628147..f7896aa800389 100644
--- a/drivers/perf/arm-cci.c
+++ b/drivers/perf/arm-cci.c
@@ -1629,10 +1629,9 @@ static struct cci_pmu *cci_pmu_alloc(struct device *dev)
 					     GFP_KERNEL);
 	if (!cci_pmu->hw_events.events)
 		return ERR_PTR(-ENOMEM);
-	cci_pmu->hw_events.used_mask = devm_kcalloc(dev,
-						BITS_TO_LONGS(CCI_PMU_MAX_HW_CNTRS(model)),
-						sizeof(*cci_pmu->hw_events.used_mask),
-						GFP_KERNEL);
+	cci_pmu->hw_events.used_mask = devm_bitmap_zalloc(dev,
+							  CCI_PMU_MAX_HW_CNTRS(model),
+							  GFP_KERNEL);
 	if (!cci_pmu->hw_events.used_mask)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/drivers/scsi/qedi/qedi_main.c b/drivers/scsi/qedi/qedi_main.c
index 0b0acb8270719..9b07ba9c48a87 100644
--- a/drivers/scsi/qedi/qedi_main.c
+++ b/drivers/scsi/qedi/qedi_main.c
@@ -535,7 +535,7 @@ static int qedi_init_id_tbl(struct qedi_portid_tbl *id_tbl, u16 size,
 	id_tbl->max = size;
 	id_tbl->next = next;
 	spin_lock_init(&id_tbl->lock);
-	id_tbl->table = kcalloc(BITS_TO_LONGS(size), sizeof(long), GFP_KERNEL);
+	id_tbl->table = bitmap_zalloc(size, GFP_KERNEL);
 	if (!id_tbl->table)
 		return -ENOMEM;
 
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index cedd558f65ebf..1e44f497914dd 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -4236,9 +4236,7 @@ qla2x00_mem_alloc(struct qla_hw_data *ha, uint16_t req_len, uint16_t rsp_len,
 	INIT_LIST_HEAD(&ha->vp_list);
 
 	/* Allocate memory for our loop_id bitmap */
-	ha->loop_id_map = kcalloc(BITS_TO_LONGS(LOOPID_MAP_SIZE),
-				  sizeof(long),
-				  GFP_KERNEL);
+	ha->loop_id_map = bitmap_zalloc(LOOPID_MAP_SIZE, GFP_KERNEL);
 	if (!ha->loop_id_map)
 		goto fail_loop_id_map;
 	else {
diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
index 15a36dcab990e..3c61f08e2c0ac 100644
--- a/drivers/soc/qcom/llcc-qcom.c
+++ b/drivers/soc/qcom/llcc-qcom.c
@@ -590,9 +590,8 @@ static int qcom_llcc_probe(struct platform_device *pdev)
 	for (i = 0; i < num_banks; i++)
 		drv_data->offsets[i] = i * BANK_OFFSET_STRIDE;
 
-	drv_data->bitmap = devm_kcalloc(dev,
-	BITS_TO_LONGS(drv_data->max_slices), sizeof(unsigned long),
-						GFP_KERNEL);
+	drv_data->bitmap = devm_bitmap_zalloc(dev, drv_data->max_slices,
+					      GFP_KERNEL);
 	if (!drv_data->bitmap) {
 		ret = -ENOMEM;
 		goto err;
diff --git a/drivers/soc/ti/k3-ringacc.c b/drivers/soc/ti/k3-ringacc.c
index 312ba0f98ad79..e2d8a15bf4a03 100644
--- a/drivers/soc/ti/k3-ringacc.c
+++ b/drivers/soc/ti/k3-ringacc.c
@@ -1402,12 +1402,10 @@ static int k3_ringacc_init(struct platform_device *pdev,
 				      sizeof(*ringacc->rings) *
 				      ringacc->num_rings,
 				      GFP_KERNEL);
-	ringacc->rings_inuse = devm_kcalloc(dev,
-					    BITS_TO_LONGS(ringacc->num_rings),
-					    sizeof(unsigned long), GFP_KERNEL);
-	ringacc->proxy_inuse = devm_kcalloc(dev,
-					    BITS_TO_LONGS(ringacc->num_proxies),
-					    sizeof(unsigned long), GFP_KERNEL);
+	ringacc->rings_inuse = devm_bitmap_zalloc(dev, ringacc->num_rings,
+						  GFP_KERNEL);
+	ringacc->proxy_inuse = devm_bitmap_zalloc(dev, ringacc->num_proxies,
+						  GFP_KERNEL);
 
 	if (!ringacc->rings || !ringacc->rings_inuse || !ringacc->proxy_inuse)
 		return -ENOMEM;
@@ -1483,9 +1481,8 @@ struct k3_ringacc *k3_ringacc_dmarings_init(struct platform_device *pdev,
 				      sizeof(*ringacc->rings) *
 				      ringacc->num_rings * 2,
 				      GFP_KERNEL);
-	ringacc->rings_inuse = devm_kcalloc(dev,
-					    BITS_TO_LONGS(ringacc->num_rings),
-					    sizeof(unsigned long), GFP_KERNEL);
+	ringacc->rings_inuse = devm_bitmap_zalloc(dev, ringacc->num_rings,
+						  GFP_KERNEL);
 
 	if (!ringacc->rings || !ringacc->rings_inuse)
 		return ERR_PTR(-ENOMEM);
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index af24dc3febbef..5f706fe340359 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1488,8 +1488,7 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
 	if (unlikely(!area))
 		goto out;
 
-	area->bitmap = kcalloc(BITS_TO_LONGS(UINSNS_PER_PAGE), sizeof(long),
-			       GFP_KERNEL);
+	area->bitmap = bitmap_zalloc(UINSNS_PER_PAGE, GFP_KERNEL);
 	if (!area->bitmap)
 		goto free_area;
 
diff --git a/net/mac80211/mesh_plink.c b/net/mac80211/mesh_plink.c
index a6915847d78ae..6b59f9e21a8c8 100644
--- a/net/mac80211/mesh_plink.c
+++ b/net/mac80211/mesh_plink.c
@@ -475,8 +475,7 @@ static int mesh_allocate_aid(struct ieee80211_sub_if_data *sdata)
 	unsigned long *aid_map;
 	int aid;
 
-	aid_map = kcalloc(BITS_TO_LONGS(IEEE80211_MAX_AID + 1),
-			  sizeof(*aid_map), GFP_KERNEL);
+	aid_map = bitmap_zalloc(IEEE80211_MAX_AID + 1, GFP_KERNEL);
 	if (!aid_map)
 		return -ENOMEM;
 
diff --git a/net/netfilter/ipvs/ip_vs_mh.c b/net/netfilter/ipvs/ip_vs_mh.c
index da0280cec506b..32298676ee402 100644
--- a/net/netfilter/ipvs/ip_vs_mh.c
+++ b/net/netfilter/ipvs/ip_vs_mh.c
@@ -174,8 +174,7 @@ static int ip_vs_mh_populate(struct ip_vs_mh_state *s,
 		return 0;
 	}
 
-	table = kcalloc(BITS_TO_LONGS(IP_VS_MH_TAB_SIZE),
-			sizeof(unsigned long), GFP_KERNEL);
+	table = bitmap_zalloc(IP_VS_MH_TAB_SIZE, GFP_KERNEL);
 	if (!table)
 		return -ENOMEM;
 
diff --git a/net/smc/smc_wr.c b/net/smc/smc_wr.c
index cbc73a7e4d590..2c19b89eec905 100644
--- a/net/smc/smc_wr.c
+++ b/net/smc/smc_wr.c
@@ -649,9 +649,7 @@ int smc_wr_alloc_link_mem(struct smc_link *link)
 				   GFP_KERNEL);
 	if (!link->wr_rx_sges)
 		goto no_mem_wr_tx_sges;
-	link->wr_tx_mask = kcalloc(BITS_TO_LONGS(SMC_WR_BUF_CNT),
-				   sizeof(*link->wr_tx_mask),
-				   GFP_KERNEL);
+	link->wr_tx_mask = bitmap_zalloc(SMC_WR_BUF_CNT, GFP_KERNEL);
 	if (!link->wr_tx_mask)
 		goto no_mem_wr_rx_sges;
 	link->wr_tx_pends = kcalloc(SMC_WR_BUF_CNT,


_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
