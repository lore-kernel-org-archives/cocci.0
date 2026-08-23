Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9546CC5DF94
	for <cocci@archiver.kernel.org>; Mon, 24 Aug 2026 07:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=FnNvQl0uN9HU1o8I9irMelxeab7NfR3NVxVTLdCJxH4=;
  b=uur1AKZ9fx5IJeK10YdqXAQpAkYGOTqPf3vlQ3h6JqjN1KAt8GSVPDSn
   CiyQZoOsO95VbkWyYPPDQZxENbXRIdQhyvy/ZVI7ca6LXrJLgC4TGTCFN
   vrGKscMFOxvegnE8pG++ElffT9b9Jr+4YH2mZHr5GVqISdR42DMVBdqsj
   8=;
X-CSE-ConnectionGUID: o49HtMKZRfy0URlGRSC+SA==
X-CSE-MsgGUID: z75VBGN1RqWnlZ2Ur2HGNA==
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
   d="scan'208";a="291207105"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Aug 2026 09:35:16 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 402818165E; Mon, 24 Aug 2026 09:35:16 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 9C80A805B3
	for <cocci@sympa.inria.fr>; Sun, 23 Aug 2026 18:18:45 +0200 (CEST)
X-CSE-ConnectionGUID: Kq+4e84cSR2cc/7/v6wncg==
X-CSE-MsgGUID: THr12jeQQgav4SbyagTwMA==
IronPort-SDR: 6a8b1d65_WOwYJ+k3NU2xbBIXKotdszF2dZsjV0tqBDrxKq53BS5jNn7
 hjVnnL9VPIQ/2cHao3ykF4T0QjPyhLknDGee0kA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EhBQCUG4tqgbDXVdFaHgEBCxIMggULAoI/FoFTMwRUl?=
 =?us-ascii?q?QcGim+CGTACkiIUgSs9Ag8BAwELAQFPAgQBAQECBDqERAKNbQIeBwEEMAkOA?=
 =?us-ascii?q?QIEAwIDAQEBAQEBAQEBAQELAQEBBAEBAQIBAQIEAwEBAQECEAEBIhkHDjuGT?=
 =?us-ascii?q?w1JARABBAEBggEBgSRhAgUDOwEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQUCLF8CAQMyAQ0BGx0BAwwGEDsgAhEBBQEcBgESgwKCIwEGE?=
 =?us-ascii?q?AEDNwIBsTyNBgUCFoEBgg0GgmrYAAoZKA11gWMBAgIHCQEKAQGBNwGEdypdA?=
 =?us-ascii?q?4I8hSN2RIM+eieBGIEQgRWDaYIfgWcjL4YwBIIiehKTWAEHBx8SCAEcBggCA?=
 =?us-ascii?q?kgVEgMEAwQEAQILEwkDAwIOAggDAggGGQE/EgQTAggDBgQLBwUfCgIMFAooI?=
 =?us-ascii?q?hIrCgMqCxIPAw0GBRUBCAYCAgQEAgQMAgkCAgUDBAIEDQMEAQEIAgItAwEDG?=
 =?us-ascii?q?QgJCAILBREYDAsHMQMQCQMfAxQcCEUIBhYBGgYFBgs3FQUMEQECGwIgBB0RC?=
 =?us-ascii?q?AMBGwQCAQkDAQMBFQQCFAodAgYIDBcCAgIGAgMDAwoBAggDAwMCAxkHBgMEB?=
 =?us-ascii?q?AEEBAMDAgMFAQMDAwUCAgoGCQEBAQEDAgIIAwcDCgkCBQMbAxsFAQICAwIBA?=
 =?us-ascii?q?ggDBwgDDQMEAgMDAwQBAgIBAQECAwEDAwQDAQMDAgEDBwICAwMDCwECAwMFA?=
 =?us-ascii?q?wMFBQICBQUDBQICCgIDAwMCAQMCHAgDBgMSARADAwYBAwcDBwIEAwkCCAMDC?=
 =?us-ascii?q?AgDFwMDBQECAgQDAwgIBAMDBAICAwwFAwIDAwUDAwcCBAIEAwMBBQECBwIDB?=
 =?us-ascii?q?wIBGAMCBAgHBwUCCwQCCAQNCQQCBAICDwQGAwMHAQECAQcFBgMCAhABCAoFB?=
 =?us-ascii?q?gICAhwDHQEDDwYBCQUCAQUOBwUCAhgDBgIDBgUBAwEKCwEBAgMKAQIEAgUDA?=
 =?us-ascii?q?wEDAgMCBgMDAgUFBQMJBwUOCQEDAwYFAgIDAgMBAggEBgUDAgIDBQEEAwQDC?=
 =?us-ascii?q?gMCCAMDCAMLAhoCBQMDAwYJAwcHAgMHAwIFAgcFAwMFAwYBAwIBAwMICxUlA?=
 =?us-ascii?q?wEFAwMCAQMCBQMDGAICBAUDAwMDAwMIBAICAQcGBAICAgEFBQUEBQYCBAMIA?=
 =?us-ascii?q?QEFAwMKDQECBwwDDAYDBwMDBAQDAgUMAgIEAQcGBwcJBwMCAwgBAQsEAQMDC?=
 =?us-ascii?q?gMDBQIBAQcFAwYDBwIDAwMFBAUDAgsDBwICAwMDAikBAQEDAwMDAwQDAQMBA?=
 =?us-ascii?q?wMHAwUDAg4CCAEECQMCBgMHBgMECwkIBwwBPAwHCiQEBAwqARQUBQQlGWcHB?=
 =?us-ascii?q?wKOXR+CTAGBDoIpgVEBAQGSGpI0i3uUJkkeCQEGAmGBZ4EKFQovm2CFfBozl?=
 =?us-ascii?q?1OTGS6HZpB0I5FwkkeEPgIKBwcRJBKBMjqBXDMaI4EBbYFJUAMZD44hhALMK?=
 =?us-ascii?q?DU1PQIHAgcOAwuFXokqgSCBK0mBTAEB?=
IronPort-PHdr: A9a23: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
 sfpoSsfhURsa9k6IaGWL61MnAA4uw==
IronPort-Data: A9a23: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
 b4bh4dA3oxO5kEuhA==
IronPort-HdrOrdr: A9a23:X05mAqgJJX+mm34FwPMHYS+W6nBQXv4ji2hC6mlwRA09TyVXrb
 HKoB19726ItN91YhsdcL+7Sc69qB/nhP1ICMwqTM+ftWrdyRGVxeNZnO3fKlTbckWUltK1l5
 0QCJSWYOeQMbEQt7ef3ODXKadD/PC3tI6twcnRpk0DceioUc1dBsVCZzpzancGPTWuzKBWKK
 ah
X-Talos-CUID: 9a23:JurVjWEdf16fKZddqmJE7Q1IF5B5eUbnlnzbZBD/Fzh2TraaHAo=
X-Talos-MUID: 9a23:t9rtuglZrGXsFajLea7gdnpeFN0xuaajMXkCmItagMOVPCNMJBK02WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,239,1779141600"; 
   d="scan'208";a="154804256"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDEu4xERi9N3UDfxEEfMDtPMdwn8ASVeXrgoXG?=
 =?us-ascii?q?M2UDdP9lFWITlk5cpELDGFLLj2D06OzcVmZovhcwG3lIFbZEqdVfQ9mU?=
 =?us-ascii?q?J3xbqn2yxTAF4ynterkonGnBGDz7PA+A8DAL2d/zWst8Pv1imd6Hhy4D?=
 =?us-ascii?q?nCSAAHXKDe4SuJfoCRIeDSnQ=3D=3D?=
Received: from mail-pg1-f176.google.com ([209.85.215.176])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2026 18:18:44 +0200
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c998fd549a8so1994910a12.2
        for <cocci@inria.fr>; Sun, 23 Aug 2026 09:18:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787501923; x=1788106723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FnNvQl0uN9HU1o8I9irMelxeab7NfR3NVxVTLdCJxH4=;
        b=XvEiHpDBsHzA4hSbVisdXawGHtCd2sRc2gy4+GY9DSpgZKXlzkzCWcPJ5yCRhnjM52
         M5Hcib3vpvgY4LN0kSuNLNrj/YXPVwUEljH/tCxjyfNjZKDMlyTYbrKtVO4z/Z4KBSVj
         efyf4gpsjS3szHunjpQF8BZXlDxINm+RwV1IZY9kxiFD/lL3u7vg4CwXSv0sil9zgST+
         R1wj+fnGSCuuPawOVlS/QEpO4SnGprpJiQtsyvseZimU6oxY7nZGEc71UzBpku8+hIS+
         z4FiJ/OqPdH7gJv3+CWnVgGeOm/h1k/yxFvzSYFCdjbfcUI+LMaW5/CBNQNzz54Mv5bK
         cUNw==
X-Gm-Message-State: AFuF++nmGtmpucH+1e+bp60KagrGz8MaAqM/w1bIOqn+CjyjSACgcYoP
	eQgHubUwVgEXLjQelcaxpE2kcHDFiwgRaKKW0IjXcowIh09JPN9VxmA8
X-Gm-Gg: AR+sD10qqm98Sni8siRPZqQWKf23+lHOZbxBUYFjW6u5oTkBUYcxGx7L/2xciZuNENN
	FE0GtfyaT3pxiIE4sKhm1uY/4B3sXuwFVbjXacSLuRKiBtCTaeeRmyctzlMR8N2Ri9ZZp1s5ep/
	h8b/Djz7nEcmZ8Rk2h99z2OkGO0tzk9vtXKFxbFHXYNDYU9F1fMdnIz3QM68TXoNr6jSOsNxGdr
	+Dwu+19EjZ6gQy3g83sUA6ZtYGELRt6xOg82W+803Rn8axeB0z/zQkyI3Ma2BqdVxdTJwwUg2uE
	80BboGzLBSkVX4mzUTkTsOI9+eZILZr6q80XKnwgM29mAbHvKny5na3FLakO1JGRCyHZrJ+GY06
	5t/M+HTcnug4I4gaKuuRLjsK8+uexUFo4zqTal8LAaduTFcBgytM7usf48rUTGZkcwuhF5NrffP
	3yNGJ5I73C6s5BJnuE4ddBQKaRs7X5U23Ri/gJuvhYiumZEddJB7QMu4I=
X-Received: by 2002:a05:6a20:6f87:b0:3c3:33df:4d9a with SMTP id adf61e73a8af0-3cd4b9ae0b1mr24094467637.1.1787501922959;
        Sun, 23 Aug 2026 09:18:42 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc199dafa1fsm350181a12.3.2026.08.23.09.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 09:18:42 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>
Cc: cocci@inria.fr,
	linux-kernel@vger.kernel.org
Date: Mon, 24 Aug 2026 01:18:16 +0900
Message-ID: <20260823161826.3805598-5-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260823161826.3805598-1-ekffu200098@gmail.com>
References: <20260823161826.3805598-1-ekffu200098@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH 4/7] coccinelle: pool_zalloc-simple: drop the
 pci_pool_alloc rules
Reply-To: Sang-Heon Jeon <ekffu200098@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3704
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-08/NbXEBLSVk4zJmWZGTb2FzQ>

pci_pool_alloc() and pci_pool_zalloc() were removed by commit
88dee3b0efe4 ("PCI: Remove unused pci_pool wrappers").

So drop the pci_pool_alloc rules.

No functional change.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 .../api/alloc/pool_zalloc-simple.cocci          | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/scripts/coccinelle/api/alloc/pool_zalloc-simple.cocci b/scripts/coccinelle/api/alloc/pool_zalloc-simple.cocci
index 9c61a23b34db..2c36fb70e0ab 100644
--- a/scripts/coccinelle/api/alloc/pool_zalloc-simple.cocci
+++ b/scripts/coccinelle/api/alloc/pool_zalloc-simple.cocci
@@ -5,7 +5,7 @@
 // Copyright: (C) 2015 Intel Corp.
 // Options: --no-includes --include-headers
 //
-// Keywords: dma_pool_zalloc, pci_pool_zalloc
+// Keywords: dma_pool_zalloc
 //
 
 virtual context
@@ -22,7 +22,7 @@ expression x;
 statement S;
 @@
 
-* x = \(dma_pool_alloc\|pci_pool_alloc\)(...);
+* x = dma_pool_alloc(...);
   if ((x==NULL) || ...) S
 * memset(x,0, ...);
 
@@ -41,17 +41,6 @@ statement S;
   if ((x==NULL) || ...) S
 - memset(x,0,...);
 
-@depends on patch@
-expression x;
-expression a,b,c;
-statement S;
-@@
-
-- x = pci_pool_alloc(a,b,c);
-+ x = pci_pool_zalloc(a,b,c);
-  if ((x==NULL) || ...) S
-- memset(x,0,...);
-
 //----------------------------------------------------------
 //  For org and report mode
 //----------------------------------------------------------
@@ -63,7 +52,7 @@ statement S;
 position p;
 @@
 
- x = @p\(dma_pool_alloc\|pci_pool_alloc\)(a,b,c);
+ x = @p\(dma_pool_alloc\)(a,b,c);
  if ((x==NULL) || ...) S
  memset(x,0, ...);
 
-- 
2.43.0

