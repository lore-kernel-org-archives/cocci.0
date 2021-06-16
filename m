Return-Path: <SRS0=gt+u=LP=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BD1C4743C
	for <cocci@archiver.kernel.org>; Mon, 21 Jun 2021 18:40:14 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AD6560FF1
	for <cocci@archiver.kernel.org>; Mon, 21 Jun 2021 18:40:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AD6560FF1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 15LIe8Aa004541;
	Mon, 21 Jun 2021 20:40:08 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B548F4108;
	Mon, 21 Jun 2021 20:40:08 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id BBB4D3E89
 for <cocci@systeme.lip6.fr>; Wed, 16 Jun 2021 20:54:40 +0200 (CEST)
Received: from smtp.smtpout.orange.fr (smtp08.smtpout.orange.fr
 [80.12.242.130])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 15GIsbjV005616
 (version=TLSv1 cipher=DHE-RSA-AES128-SHA bits=128 verify=FAIL)
 for <cocci@systeme.lip6.fr>; Wed, 16 Jun 2021 20:54:37 +0200 (CEST)
Received: from localhost.localdomain ([86.243.172.93]) by mwinf5d88 with ME
 id Huub2500G21Fzsu03uucKk; Wed, 16 Jun 2021 20:54:36 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 16 Jun 2021 20:54:36 +0200
X-ME-IP: 86.243.172.93
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Julia.Lawall@inria.fr, Gilles.Muller@inria.fr, nicolas.palix@imag.fr,
        michal.lkml@markovi.net
Date: Wed, 16 Jun 2021 20:54:34 +0200
Message-Id: <9ea05b27750d20f61217c88c3ec63f3e2420678a.1623869587.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 21 Jun 2021 20:40:09 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 16 Jun 2021 20:54:37 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Mon, 21 Jun 2021 20:40:07 +0200
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        kernel-janitors@vger.kernel.org, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [Cocci] [PATCH] Coccinelle: remove pci_[z]alloc_consistent from
	api/alloc/alloc_cast.cocci
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

'pci_alloc_consistent()' and 'pci_zalloc_consistent()' are about to be
removed from the kernel.
So, there is no point any more for searching for these identifiers.

Simplify the script.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 scripts/coccinelle/api/alloc/alloc_cast.cocci | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/scripts/coccinelle/api/alloc/alloc_cast.cocci b/scripts/coccinelle/api/alloc/alloc_cast.cocci
index f6f0ccdb6409..ef8a97bb5f38 100644
--- a/scripts/coccinelle/api/alloc/alloc_cast.cocci
+++ b/scripts/coccinelle/api/alloc/alloc_cast.cocci
@@ -34,8 +34,8 @@ type T;
   \(kmalloc\|kzalloc\|kcalloc\|kmem_cache_alloc\|kmem_cache_zalloc\|
    kmem_cache_alloc_node\|kmalloc_node\|kzalloc_node\|vmalloc\|vzalloc\|
    dma_alloc_coherent\|devm_kmalloc\|devm_kzalloc\|
-   kvmalloc\|kvzalloc\|kvmalloc_node\|kvzalloc_node\|pci_alloc_consistent\|
-   pci_zalloc_consistent\|kmem_alloc\|kmem_zalloc\|kmem_zone_alloc\|
+   kvmalloc\|kvzalloc\|kvmalloc_node\|kvzalloc_node\|
+   kmem_alloc\|kmem_zalloc\|kmem_zone_alloc\|
    kmem_zone_zalloc\|vmalloc_node\|vzalloc_node\)(...)
 
 //----------------------------------------------------------
@@ -57,8 +57,8 @@ type r1.T;
   \(kmalloc\|kzalloc\|kcalloc\|kmem_cache_alloc\|kmem_cache_zalloc\|
    kmem_cache_alloc_node\|kmalloc_node\|kzalloc_node\|vmalloc\|vzalloc\|
    dma_alloc_coherent\|devm_kmalloc\|devm_kzalloc\|
-   kvmalloc\|kvzalloc\|kvmalloc_node\|kvzalloc_node\|pci_alloc_consistent\|
-   pci_zalloc_consistent\|kmem_alloc\|kmem_zalloc\|kmem_zone_alloc\|
+   kvmalloc\|kvzalloc\|kvmalloc_node\|kvzalloc_node\|
+   kmem_alloc\|kmem_zalloc\|kmem_zone_alloc\|
    kmem_zone_zalloc\|vmalloc_node\|vzalloc_node\)(...)
 
 //----------------------------------------------------------
@@ -80,8 +80,8 @@ type r1.T;
   \(kmalloc\|kzalloc\|kcalloc\|kmem_cache_alloc\|kmem_cache_zalloc\|
    kmem_cache_alloc_node\|kmalloc_node\|kzalloc_node\|vmalloc\|vzalloc\|
    dma_alloc_coherent\|devm_kmalloc\|devm_kzalloc\|
-   kvmalloc\|kvzalloc\|kvmalloc_node\|kvzalloc_node\|pci_alloc_consistent\|
-   pci_zalloc_consistent\|kmem_alloc\|kmem_zalloc\|kmem_zone_alloc\|
+   kvmalloc\|kvzalloc\|kvmalloc_node\|kvzalloc_node\|
+   kmem_alloc\|kmem_zalloc\|kmem_zone_alloc\|
    kmem_zone_zalloc\|vmalloc_node\|vzalloc_node\)(...)
 
 //----------------------------------------------------------
@@ -97,8 +97,8 @@ position p;
   \(kmalloc\|kzalloc\|kcalloc\|kmem_cache_alloc\|kmem_cache_zalloc\|
    kmem_cache_alloc_node\|kmalloc_node\|kzalloc_node\|vmalloc\|vzalloc\|
    dma_alloc_coherent\|devm_kmalloc\|devm_kzalloc\|
-   kvmalloc\|kvzalloc\|kvmalloc_node\|kvzalloc_node\|pci_alloc_consistent\|
-   pci_zalloc_consistent\|kmem_alloc\|kmem_zalloc\|kmem_zone_alloc\|
+   kvmalloc\|kvzalloc\|kvmalloc_node\|kvzalloc_node\|
+   kmem_alloc\|kmem_zalloc\|kmem_zone_alloc\|
    kmem_zone_zalloc\|vmalloc_node\|vzalloc_node\)(...)
 
 @script:python depends on org@
-- 
2.30.2

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
