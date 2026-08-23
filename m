Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82E50C61CE2
	for <cocci@archiver.kernel.org>; Mon, 24 Aug 2026 07:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Yk+GtFob8YP/nG/tgDLyVHeL2Kuzd/gYoJmQT0SPsjQ=;
  b=Mpih4NAxfxoRWFcDGW6eVKUO52BGCV5dlUE7+8P9YV1JufzqT/c9r2od
   0TJUbW8HyTHEhnKJ3RGn8RxZvlwI9He8jYE/EXgvZFA68VTVNApPeGAGn
   qpaEjLIOQ9ENo5yKJUdr32GKh6S0WiC3KSPYP+eCdSMoSR5EXu9+gYn4s
   4=;
X-CSE-ConnectionGUID: zbICZgTQTFGIVpc/JlTIfA==
X-CSE-MsgGUID: 9TaCjChsSgqEFMTb6Hf5qA==
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
X-IronPort-AV: E=Sophos;i="6.25,240,1779141600"; 
   d="scan'208";a="291207024"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Aug 2026 09:35:13 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 2C68D81658; Mon, 24 Aug 2026 09:35:13 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 4567E80E78
	for <cocci@sympa.inria.fr>; Sun, 23 Aug 2026 18:18:41 +0200 (CEST)
X-CSE-ConnectionGUID: BRFVWo5aSq64t0Dk8nfkNg==
X-CSE-MsgGUID: YD6NJ04nTx60fUl4Ej/Glg==
IronPort-SDR: 6a8b1d60_VkjiPXXzh1FtAt6p5a+dpHaIcmYLnqZ07pQX4MWrxoBGllr
 DOClVkDYs2a/pCIteLdMnozp3wQaMbrH4djvmUQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GBBQDEHItqgbTSVdFaglkCgj8WgVMzBFSVBwaKb4IZM?=
 =?us-ascii?q?AKSIhSBKz0CDwEDAQsBAU8CBAEBAQIEOAINhDcCjW0CHgcBBDAJDgECBAMCA?=
 =?us-ascii?q?wEBAQEBAQEBAQEBCwEBAQQBAQECAQECBAMBAQEBAhABASIZBw47hk8NSQEQA?=
 =?us-ascii?q?QQBAYIBAYEkYQIFAzsBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEFAixfAgEDMgENARsdAQMMBhA7IAIRAQUBHAYBEoMCgiMBBhABAzcCA?=
 =?us-ascii?q?bFPjQYFAhaBAYINBoJq2AAKGSgNdYFjAQICBwkBCgEBgTcBhHcqXQOCPIUjd?=
 =?us-ascii?q?oQCeieBGIEQhH6CH4IKL4YwBIIigQyTWAEHBx8SCAEcBggCAkgVEgMEAwQEA?=
 =?us-ascii?q?QILEwkDAwIOAggDAggGGQE/EgQTAggDBgQLBwUfCgIMFAooIhIrCgMqCxIPA?=
 =?us-ascii?q?w0GBRUBCAYCAgQEAgQMAgkCAgUDBAIEDQMEAQEIAgItAwEDGQgJCAILBREYD?=
 =?us-ascii?q?AsHMQMQCQMfAxQcCEUIBhYBGgYFBgs3FQUMEQECGwIgBB0RCAMBGwQCAQkDA?=
 =?us-ascii?q?QMBFQQCFAodAgYIDBcCAgIGAgMDAwoBAggDAwMCAxkHBgMEBAEEBAMDAgMFA?=
 =?us-ascii?q?QMDAwUCAgoGCQEBAQEDAgIIAwcDCgkCBQMbAxsFAQICAwIBAggDBwgDDQMEA?=
 =?us-ascii?q?gMDAwQBAgIBAQECAwEDAwQDAQMDAgEDBwICAwMDCwECAwMFAwMFBQICBQUDB?=
 =?us-ascii?q?QICCgIDAwMCAQMCHAgDBgMSARADAwYBAwcDBwIEAwkCCAMDCAgDFwMDBQECA?=
 =?us-ascii?q?gQDAwgIBAMDBAICAwwFAwIDAwUDAwcCBAIEAwMBBQECBwIDBwIBGAMCBAgHB?=
 =?us-ascii?q?wUCCwQCCAQNCQQCBAICDwQGAwMHAQECAQcFBgMCAhABCAoFBgICAhwDHQEDD?=
 =?us-ascii?q?wYBCQUCAQUOBwUCAhgDBgIDBgUBAwEKCwEBAgMKAQIEAgUDAwEDAgMCBgMDA?=
 =?us-ascii?q?gUFBQMJBwUOCQEDAwYFAgIDAgMBAggEBgUDAgIDBQEEAwQDCgMCCAMDCAMLA?=
 =?us-ascii?q?hoCBQMDAwYJAwcHAgMHAwIFAgcFAwMFAwYBAwIBAwMICxUlAwEFAwMCAQMCB?=
 =?us-ascii?q?QMDGAICBAUDAwMDAwMIBAICAQcGBAICAgEFBQUEBQYCBAMIAQEFAwMKDQECB?=
 =?us-ascii?q?wwDDAYDBwMDBAQDAgUMAgIEAQcGBwcJBwMCAwgBAQsEAQMDCgMDBQIBAQcFA?=
 =?us-ascii?q?wYDBwIDAwMFBAUDAgsDBwICAwMDAikBAQEDAwMDAwQDAQMBAwMHAwUDAg4CC?=
 =?us-ascii?q?AEECQMCBgMHBgMECwkIBwwBPAwHCiQEBAwqARQUBQQlGWcHBwKOXR+CTAGBD?=
 =?us-ascii?q?oIpgVEBAQGSGpI0i3uUJkkeCQEGAmGBZ4EKFQovm2CFfBozl1OTGS6YWiORc?=
 =?us-ascii?q?JJHhD4CCgcHESQSgTI6gVwzGiOBAW2BSVADGQ+SI8woNTU9AQEHAgcOAwuBa?=
 =?us-ascii?q?IN2iSqBIIErSYFMAQE?=
IronPort-PHdr: A9a23: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
 JetqzRL3AcxNbbdwITfIaNIyh5bgafc5keV
IronPort-Data: A9a23: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
 b0biodND62rNqQvhJYU
IronPort-HdrOrdr: A9a23:Fncs2K8pE57du4Y6Qd9uk+D8I+orL9Y04lQ7vn2ZhyYlF/Bw8P
 re4cjzsCWftN9/YgBGpTntAtjifZqYz+8M3WBzB8bZYOCFghrPEGgK1+KLqF3d8m/Fh5VgPM
 9bEpSWY+eAaWSS4/yKgjWQIpIPxJ2o/smT6ts2DE0AceipUcxdBn9Ce3+m+4RNKjV7OQ==
X-Talos-CUID: 9a23:lG0RoGOzpjja7+5DchNJynETR8keayOB0C/8IB++B2VPR+jA
X-Talos-MUID: 9a23:ctJg9Qv1UAn1WQge0s2ntR08EuUwv6KSGB5Vn6gC5+SGcgN0NGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,239,1779141600"; 
   d="scan'208";a="291143680"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDFSMauftCq8V3i118JTdA9Nzr5PzW1cFWwLsT?=
 =?us-ascii?q?Fc6akzmbZmQMi/F/o7QIZMI72fDC02Hbz9zHXhtxG509Zf+vkb24cWFD?=
 =?us-ascii?q?S4y/P5GmCQn9P8dLU5mUOLjTtgNfL55tsA4KHSBtkZGWmfGgs5XLb9bw?=
 =?us-ascii?q?IpUaBKma2qHGP5PoPSok9NcA=3D=3D?=
Received: from mail-pf1-f180.google.com ([209.85.210.180])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2026 18:18:40 +0200
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8486672f03cso2672614b3a.0
        for <cocci@inria.fr>; Sun, 23 Aug 2026 09:18:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787501919; x=1788106719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Yk+GtFob8YP/nG/tgDLyVHeL2Kuzd/gYoJmQT0SPsjQ=;
        b=VRUYMaP3ygCYKr9L2kmz2Eq/cceIFYyWPBjSarG8dZjY9NCsFeuwLuos01EPMvZl7f
         MuasqzB0dhBgczY3xg3T5PT04m1NZcZrGuYtJGVgyuo2+WW9YpBWiOKosgRoxx19K3Im
         Z5hhdJzQa8UzEpPke7Ayz2x5tvXBrL7kJ88D5djuBI2qQXoxd4U8vu1aE27Fv3rUIwsw
         xbGyPAymUpIHvPqT8uNCxpzNvaY8pPeQLs/VwWEA0t+dUGS5CJSLwV+pfjk2rONJht59
         s+v3zxe1IPb0RP+WQUOKLb0JHqtsDFvHrS5pClQ1XfiDOPtpwRqlh0rwavS6c0auxl4B
         NjPQ==
X-Gm-Message-State: AFuF++kZRcYyvHE28GeErm0EGuljY5ILxZlgDDyaMZCJAcKaT1CZJ8Lh
	jqLkM7pCaHdOZtSCiABvtH24v/MRXNpvgnSvOaay+DBBa9uM0UHTHUtq
X-Gm-Gg: AR+sD127Bmpf01UJqBvEvfG+u4v87vq67SEV6WSJuVSVRlQFOuQkX6R8sug/M8dJNx3
	/pTEITtpmxvacRqK4xX4ABthnUZKb2fVnE3Jl/H1giU4L38XivmTAEt7PHGpqhjAsOpjLI8l1FS
	RJwyZOWevy6aWGli5A3ncRGa2mWNAjZJ0V1Awv5EL/tSvciGtoc6Yfe8a8H/NYkGK73NjWEEl3S
	zNvDkesPNPQCFF4rQ5I7bcF+uADnldNmaoRVASFcjra4UM90KKhYCXSvi3/08mlyJ3+7JuE4r/n
	y5UcTmRgxPwzvklk3RsGequchOLFj9P17Ue6dGDvLNtaM/4nfoSg+wSGZJLg+4ujDLsiPV4mkXo
	qaLRqo/ubj8zFbPGQlJAJf/jNM/0xrWJvQSvuHtQeJOcZxolTSZcuXnp9xhTm0Meokj5NFJBy9U
	tBcFQNpzUh//Vmf/XyeCIhJVq2qwabprbTXzI0H7OgmGucKI5BIDh/NME=
X-Received: by 2002:a05:6a21:3998:b0:3c3:8255:8c4a with SMTP id adf61e73a8af0-3cd4bc4a910mr24290545637.17.1787501918934;
        Sun, 23 Aug 2026 09:18:38 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc199dafa1fsm350181a12.3.2026.08.23.09.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 09:18:38 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>
Cc: cocci@inria.fr,
	linux-kernel@vger.kernel.org
Date: Mon, 24 Aug 2026 01:18:14 +0900
Message-ID: <20260823161826.3805598-3-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260823161826.3805598-1-ekffu200098@gmail.com>
References: <20260823161826.3805598-1-ekffu200098@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH 2/7] coccinelle: alloc_cast: drop removed allocators
Reply-To: Sang-Heon Jeon <ekffu200098@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3702
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-08/hi3QXDPTPnqeN6UXFu_eJA>

- pci_alloc_consistent() and pci_zalloc_consistent() were removed by
  commit 7968778914e5
  ("PCI: Remove the deprecated "pci-dma-compat.h" API")

- kmem_alloc() was removed by commit f078d4ea8276
  ("xfs: convert kmem_alloc() to kmalloc()")

- kmem_zalloc() was removed by commit 10634530f7ba
  ("xfs: convert kmem_zalloc() to kzalloc()")

- kmem_zone_alloc() and kmem_zone_zalloc() were removed by commit
  bae633a4a283 ("xfs: remove xfs_zone_{alloc,zalloc} helpers")

So drop them from the rules.

No functional change.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 scripts/coccinelle/api/alloc/alloc_cast.cocci | 20 ++++++++-----------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/scripts/coccinelle/api/alloc/alloc_cast.cocci b/scripts/coccinelle/api/alloc/alloc_cast.cocci
index 958c914f8ba6..a4b83cc8ea01 100644
--- a/scripts/coccinelle/api/alloc/alloc_cast.cocci
+++ b/scripts/coccinelle/api/alloc/alloc_cast.cocci
@@ -53,9 +53,8 @@ position p != {m1.p1,m2.p2};
   \(kmalloc\|kzalloc\|kcalloc\|kmem_cache_alloc\|kmem_cache_zalloc\|
    kmem_cache_alloc_node\|kmalloc_node\|kzalloc_node\|vmalloc\|vzalloc\|
    dma_alloc_coherent\|devm_kmalloc\|devm_kzalloc\|
-   kvmalloc\|kvzalloc\|kvmalloc_node\|kvzalloc_node\|pci_alloc_consistent\|
-   pci_zalloc_consistent\|kmem_alloc\|kmem_zalloc\|kmem_zone_alloc\|
-   kmem_zone_zalloc\|vmalloc_node\|vzalloc_node\)(...)
+   kvmalloc\|kvzalloc\|kvmalloc_node\|kvzalloc_node\|
+   vmalloc_node\|vzalloc_node\)(...)
 
 //----------------------------------------------------------
 //  For context mode
@@ -76,9 +75,8 @@ type r1.T;
   \(kmalloc\|kzalloc\|kcalloc\|kmem_cache_alloc\|kmem_cache_zalloc\|
    kmem_cache_alloc_node\|kmalloc_node\|kzalloc_node\|vmalloc\|vzalloc\|
    dma_alloc_coherent\|devm_kmalloc\|devm_kzalloc\|
-   kvmalloc\|kvzalloc\|kvmalloc_node\|kvzalloc_node\|pci_alloc_consistent\|
-   pci_zalloc_consistent\|kmem_alloc\|kmem_zalloc\|kmem_zone_alloc\|
-   kmem_zone_zalloc\|vmalloc_node\|vzalloc_node\)(...)
+   kvmalloc\|kvzalloc\|kvmalloc_node\|kvzalloc_node\|
+   vmalloc_node\|vzalloc_node\)(...)
 
 //----------------------------------------------------------
 //  For patch mode
@@ -99,9 +97,8 @@ type r1.T;
   \(kmalloc\|kzalloc\|kcalloc\|kmem_cache_alloc\|kmem_cache_zalloc\|
    kmem_cache_alloc_node\|kmalloc_node\|kzalloc_node\|vmalloc\|vzalloc\|
    dma_alloc_coherent\|devm_kmalloc\|devm_kzalloc\|
-   kvmalloc\|kvzalloc\|kvmalloc_node\|kvzalloc_node\|pci_alloc_consistent\|
-   pci_zalloc_consistent\|kmem_alloc\|kmem_zalloc\|kmem_zone_alloc\|
-   kmem_zone_zalloc\|vmalloc_node\|vzalloc_node\)(...)
+   kvmalloc\|kvzalloc\|kvmalloc_node\|kvzalloc_node\|
+   vmalloc_node\|vzalloc_node\)(...)
 
 //----------------------------------------------------------
 //  For org and report mode
@@ -116,9 +113,8 @@ position p != {m1.p1,m2.p2};
   \(kmalloc\|kzalloc\|kcalloc\|kmem_cache_alloc\|kmem_cache_zalloc\|
    kmem_cache_alloc_node\|kmalloc_node\|kzalloc_node\|vmalloc\|vzalloc\|
    dma_alloc_coherent\|devm_kmalloc\|devm_kzalloc\|
-   kvmalloc\|kvzalloc\|kvmalloc_node\|kvzalloc_node\|pci_alloc_consistent\|
-   pci_zalloc_consistent\|kmem_alloc\|kmem_zalloc\|kmem_zone_alloc\|
-   kmem_zone_zalloc\|vmalloc_node\|vzalloc_node\)(...)
+   kvmalloc\|kvzalloc\|kvmalloc_node\|kvzalloc_node\|
+   vmalloc_node\|vzalloc_node\)(...)
 
 @script:python depends on org@
 p << r2.p;
-- 
2.43.0

