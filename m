Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 410FCC531FA
	for <cocci@archiver.kernel.org>; Fri, 24 Jul 2026 08:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Pa9RhyBV4RDq7tkQpwKRVUOOI8N+P6srYqSVADpe3nI=;
  b=ZeYR9PQqh3KyQvu3U+U1jAjdfwwMnmszeKmSpX1GgwqAq+kSpReyRXs3
   0XNcQPsdLnJARIOiEP3LN7MDN/R8bZIRY6QtblmRsG/A9dXkXo0t34ok+
   Ou+eXdKpKdaoRk8iygt0yMLpGBI+vp55WA+tQwf+o8z/YAr30FBHysMx1
   0=;
X-CSE-ConnectionGUID: dTYucuSQRQSqwkdrElQr6g==
X-CSE-MsgGUID: dJj89Kb8S6Cvo+9pIVUUQQ==
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
X-IronPort-AV: E=Sophos;i="6.25,182,1779141600"; 
   d="scan'208";a="287733785"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jul 2026 10:54:26 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id DDDBF800C7; Fri, 24 Jul 2026 10:54:25 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id CCB32819A4
	for <cocci@sympa.inria.fr>; Thu, 23 Jul 2026 20:46:57 +0200 (CEST)
X-CSE-ConnectionGUID: 4SqNAp+xRvO48ju8iRI2mA==
X-CSE-MsgGUID: H3kFOhu+RNaYFwd8+jYDsA==
IronPort-SDR: 6a6261a1_eZgzafJGMJP3WskAq+T+avy9bpVwl90FjWOZdRjmiq7+rR6
 L57ncCfhb3JnwWWnBT2RruvF/WpP8ETaSwgNOfg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HFBABZYGJqfC/YVdFaglkCgj8WgVMzBFSVBwaKb4IZM?=
 =?us-ascii?q?AKHU4pPgT89Ag8BAwELAQFPAgQBAQECBDiERgKNYAIeBwEEMAkOAQIEAwIDA?=
 =?us-ascii?q?QEBAQEBAQEBAQELAQEBBAEBAQIBAQIEAwEBAQECEAEBIhkHDhIphk8NSQEQA?=
 =?us-ascii?q?QQBAYIBAYEkYQIFAzsBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEFAixfAgEDEiABDQEbHQEDDAYQOyACEQEFARwGARIigmCCIwEGEAEDN?=
 =?us-ascii?q?wIBtleBAkKMUgUCFoEBgg0G2mgKGSgNdYFjAQICBwkBCgEBgTcBhHcqXQOCO?=
 =?us-ascii?q?oUjdYQCeieBGIEQhH6CH4I5hjAEgxwSkioBBwcfEggBHAYIAgJIFRIDBAMEB?=
 =?us-ascii?q?AECCxMJAwMCDgIIAwIIBhkBPxIEEwIIAwYECwcFHwoCDBQKKCISAikKAyAKC?=
 =?us-ascii?q?xIPAw0GBRUBAQcGAgIDAQQCBAwCCQICBQMBAwIEBgQDAwQBAQgCAi0DAQMZC?=
 =?us-ascii?q?AkIAgsFERgMCwUCCicDDwEJAx8DFBsIRQgGFgEaBwUGCzcVBQwRAQIbAiEEH?=
 =?us-ascii?q?REIAwEYBAICAgELAwEDARUECAkEDAIQChIVAw4DBw8CDQcuCwMCDgIJCAwXA?=
 =?us-ascii?q?gICBgIDAwMKAQIBAQEBAQEBCAMDAwIDGQcGAwQEAQQEAwMCAwUBAwMDBQICC?=
 =?us-ascii?q?gYJAQEBAQMCAggDBwMKCQIFAxsDHAYBAgIDAgECAwYDBwgDDQMEAgMDAwQBA?=
 =?us-ascii?q?gIBAQECAwEDAwQDAQMDAgEDBwICAwMDCwECAwMDBQMFAQUDBQICAwUFAwUCA?=
 =?us-ascii?q?goCAwMDAgEDAhwDCAMGAxIBEAMDBgEDBwMHAgQDCAQDBgIDCAMDAgkIAxYGA?=
 =?us-ascii?q?wMDAwUBAgICAwUDAwMICAQDAwQCAgMMAgYDAwMCAwMFAwMHAgQCAwYDAwMBA?=
 =?us-ascii?q?wMFAQIHAgMHAgELCwgDAgQCCQcJBwECAwsEAgQGBA0JBAIEAgIPBAQFAwMHA?=
 =?us-ascii?q?QECAQIIBQYDAgIRBQgKBQYCAgIdAyEBAw8GAQkFAgEFDgcFAgIKEgMGAgMEB?=
 =?us-ascii?q?QUBAwEKAQsBAQIDAwUFAwMFBwECBAIHAwMDBAMDAwMBAQICBAYEAwIDBwMDA?=
 =?us-ascii?q?wMDBAMFBQMCBQIEAwUDBwIDAwIBBQoBBAUECgEDAwMDBQUDAgIDAwQBAgQGA?=
 =?us-ascii?q?wQCAwECCAQGBQMDAwUCAwMCAgIDAwUBBQIDAwMEAwMDCAcFAwMFAgkDAwkDA?=
 =?us-ascii?q?wsCAgMhAgUDAwMDBgMHAwMEAwMDBwcCAwIDBwMCBQIHBQMDBQMGAQMCAQMDC?=
 =?us-ascii?q?AsYAwsJCAcMATwMBwokBAQMKgEGDhQFBCUZZwcHAo1oI4JAAYENgimBUQEBA?=
 =?us-ascii?q?aROoCFJHgkBBgJggWeBChUKL5tfhXwaM5dTkxmZCCORcJJHhD4CCgcHESQSg?=
 =?us-ascii?q?TI6gVwzGiOBAW2BSVADGQ+OLRaDYMwVNTU+AQcCBw8CgXODdokqgSCBK0mBT?=
 =?us-ascii?q?AEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 U/KelY=
IronPort-HdrOrdr: A9a23:Qopix65a2Gb37NyqTAPXwNvXdLJyesId70hD6qkRc202TiX8ra
 uTdZsgpHvJYVoqOU3I+urwW5VoP0mskKKdiLN5Vd3OYOCBgguVxepZgrcKrQeNJ8SHzIBg6Z
 s=
X-Talos-CUID: 9a23:SatctWzo7Cg3jAI9HiUXBgVIIdkDW2We3E3OBBPoC3s5SYe0E1q5rfY=
X-Talos-MUID: 9a23:y6roGgWe42pDaFLq/B+3hx9FNNor2YKnOW4SncVFufioLgUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,181,1779141600"; 
   d="scan'208";a="287667012"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDHH80uipNGG5XZ/fPq5QceQ6yRxPJqbO6+5r6?=
 =?us-ascii?q?nNGDIeiRne0sKwAk/hWZSgqHNgzLpDVxkweKHI/U6T5KwExPtf9myoHG?=
 =?us-ascii?q?40s4+ki9noLKd0hnNsjFP/U23kx62OoesB88XEEiNTqaSYQ6CEsPMpZG?=
 =?us-ascii?q?RtxRmVyg9AvbjIKhEEx7CaQg=3D=3D?=
Received: from mail-pj1-f47.google.com ([209.85.216.47])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 20:46:57 +0200
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso840625a91.3
        for <cocci@inria.fr>; Thu, 23 Jul 2026 11:46:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784832416; x=1785437216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pa9RhyBV4RDq7tkQpwKRVUOOI8N+P6srYqSVADpe3nI=;
        b=Kr1vkeNGD7xOi4+ETejk8M4MgXag2DTOHk7gRVXyvOfS+Mx8tKkIWsgQNq5dO2JChW
         14W4ecIl1CK/V1M7QdpbbPuIRF4qG7FmY0+PMRm3ERTyAiYuHCcKohItmEqgBLdwci5G
         lDm/9IiYkmHch169KGlCeRnJ4pXcbAqkXnFSJ+r13WVQa/yUFeOqK6cf4ZSg08Bta0GD
         H/I1+VxUxyXhzB3m7m9/YvgaY8bTCxl3Od82Z6Xd7T+g0n4W5dl1oI2S4qhD1PrOqfGq
         GQZfK5RHB2WTf+CIgP746bG9RmE9XgxdzeaX1gT0nnsw4/YBbabqly5smQToJJK49rTM
         oJbQ==
X-Gm-Message-State: AOJu0YypmQujNU9d6dt452mKQXV6znNqUlGAdmXG700B0rPlHt7GdMfl
	GWHa01XiO+1lGrZMSwShfQE+PBsmfEeeK/K+qaUjHvjZewn5CjwBFNcy
X-Gm-Gg: AR+sD12j4X1PLzTBqp5mbpihar85TPu5o0e/fBrqYk802/jqgoAYoBc1P3lJDrHlqIu
	1om0+LCDV9vss8YwTDQpq5RR96Y+dMYgplPw9/DlMArnj5UA3vQnqjiUndetqWIO8o3jDMD4Ui8
	qM6yOEy2etvT+yNA/JlVTabyeBgrdui/oiT6oSVxbUt1C3dYdp6D/Ycah2nMSPdnAPz1XZeN0wr
	iGP6T06kiRWsRP5cSj+D4VkpeVDA39VAMsz1whYpc3i2i8E31i4f3rJgyPc+xl3HHtodlCVMc2/
	m+2Myt5+YJWcqwpyBee2t2eYZdlOGLN9cIQL8jkHPQuoKDc7nc3lo9MkgS7vHRC2z5H6pMncmXP
	2zp+C6Y8wsoQ9wmzRKD9gAOD0QrTa0KJNL42JxNuFSu2EZit+m+1z0f2XHjsIAv3hgBhc/CmS
X-Received: by 2002:a17:90b:2b47:b0:383:f52b:d616 with SMTP id 98e67ed59e1d1-38ec6454e6dmr4309241a91.10.1784832415649;
        Thu, 23 Jul 2026 11:46:55 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f03af8a45sm308155a91.10.2026.07.23.11.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 11:46:55 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Julia.Lawall@inria.fr,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: cocci@inria.fr,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>
Date: Fri, 24 Jul 2026 03:45:24 +0900
Message-ID: <20260723184538.3888637-23-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723184538.3888637-1-ekffu200098@gmail.com>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH 22/36] iommu/s390: remove conditional return with no
 effect
Reply-To: Sang-Heon Jeon <ekffu200098@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3619
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/oySyLxThTvkT9Ce7WyJUJA>

Both branches of the check return the same value, so the check has
no effect. Remove it and return the value directly.

This is the result of running the Coccinelle script from
scripts/coccinelle/misc/cond_return_no_effect.cocci.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 drivers/iommu/s390-iommu.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index f148f559ac56..d008b1d14a9e 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -1115,8 +1115,6 @@ __setup("s390_iommu_aperture=", s390_iommu_aperture_setup);
 
 static int __init s390_iommu_init(void)
 {
-	int rc;
-
 	iommu_dma_forcedac = true;
 	s390_iommu_aperture = (u64)virt_to_phys(high_memory);
 	if (!s390_iommu_aperture_factor)
@@ -1124,11 +1122,7 @@ static int __init s390_iommu_init(void)
 	else
 		s390_iommu_aperture *= s390_iommu_aperture_factor;
 
-	rc = dma_alloc_cpu_table_caches();
-	if (rc)
-		return rc;
-
-	return rc;
+	return dma_alloc_cpu_table_caches();
 }
 subsys_initcall(s390_iommu_init);
 
-- 
2.43.0

