Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A1FC55162
	for <cocci@archiver.kernel.org>; Sun,  2 Aug 2026 19:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=qZqViyDfghPjBb7mCZQVi4QVxyhF8GzsIG5qzzolxs8=;
  b=md7rmcXPdpdoPX6uhDIj4dv9QAzftrDzwrOtQYkjPRBXGUHnCJKhlzs9
   l5m/QA6LLP7pp9f5D5QIn1gZPqbvAbgkESZdw2DfvbdZu5L+GJuOMV9Er
   9ItXduzUk38ynukKW2QRmHmHdB18MIoVQPs1S5GrTcy/ryFNzYU1AKNKl
   k=;
X-CSE-ConnectionGUID: 779BHr4URZmCyHO88hWpYQ==
X-CSE-MsgGUID: OYhlKEV4TzCy05dZayV9cA==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.25,201,1779141600"; 
   d="scan'208";a="288826569"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Aug 2026 21:30:15 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 6117781293; Sun,  2 Aug 2026 21:30:15 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 699D6812A8
	for <cocci@sympa.inria.fr>; Sun,  2 Aug 2026 21:30:11 +0200 (CEST)
X-CSE-ConnectionGUID: neFT/PIpQLuj6UReWZhOVg==
X-CSE-MsgGUID: CNHspn7IRFqF011QcCYnGA==
X-IronPort-AV: E=Sophos;i="6.25,201,1779141600"; 
   d="scan'208";a="153479549"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.102.196])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2026 21:30:10 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Julia Lawall <Julia.Lawall@inria.fr>
Cc: rostedt@goodmis.org,
	Nicolas Palix <nicolas.palix@imag.fr>,
	cocci@inria.fr,
	linux-kernel@vger.kernel.org
Date: Sun,  2 Aug 2026 21:29:57 +0200
Message-Id: <20260802192957.1425245-1-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [cocci] [PATCH] Coccinelle: alloc_cast: coccinelle: api: check for
 macro context
Reply-To: Julia Lawall <Julia.Lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3667
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-08/ostgfuUv4bPtE1BmYf-7Zw>

A cast on a call to an allocation function that is the body of a macro can
be useful, as it ensures tha the macro is used for allocating objects of
the right type.  Add two new rules to ignore the macro case.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 scripts/coccinelle/api/alloc/alloc_cast.cocci |   23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/scripts/coccinelle/api/alloc/alloc_cast.cocci b/scripts/coccinelle/api/alloc/alloc_cast.cocci
index f6f0ccdb6409..958c914f8ba6 100644
--- a/scripts/coccinelle/api/alloc/alloc_cast.cocci
+++ b/scripts/coccinelle/api/alloc/alloc_cast.cocci
@@ -20,6 +20,24 @@ virtual patch
 virtual org
 virtual report
 
+@m1@
+identifier i;
+expression e;
+type T;
+position p1;
+@@
+
+#define i (T@p1 *)e
+
+@m2@
+identifier i;
+expression e;
+type T;
+position p2;
+@@
+
+#define i(...) (T@p2 *)e
+
 @initialize:python@
 @@
 import re
@@ -28,9 +46,10 @@ m = re.compile(pattern)
 
 @r1 depends on context || patch@
 type T;
+position p != {m1.p1,m2.p2};
 @@
 
-  (T *)
+  (T@p *)
   \(kmalloc\|kzalloc\|kcalloc\|kmem_cache_alloc\|kmem_cache_zalloc\|
    kmem_cache_alloc_node\|kmalloc_node\|kzalloc_node\|vmalloc\|vzalloc\|
    dma_alloc_coherent\|devm_kmalloc\|devm_kzalloc\|
@@ -90,7 +109,7 @@ type r1.T;
 
 @r2 depends on org || report@
 type T;
-position p;
+position p != {m1.p1,m2.p2};
 @@
 
  (T@p *)

