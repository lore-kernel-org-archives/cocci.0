Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 348FFC531F9
	for <cocci@archiver.kernel.org>; Fri, 24 Jul 2026 08:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=inEAHAT4FZx62nofTUdSreIh00cPh6gTjTfAeZvFyf4=;
  b=U3gtWQ1zCncUJDOrtHhprJ4AtTo+S4Nau9uvmojY4gHfQv3V9s/0IhDK
   +GiPVXbVaNUJuW0sDWWbMS56bQBZAV0Shx33Sm+WLJWiVddA4lx2IOr3m
   p7hxbgpv1czswYOmAIn998dMYqnVv/Vq88eq2agZb5HqWjrc4XnvF9iIQ
   c=;
X-CSE-ConnectionGUID: wiGmWE8vSTqkGX59UZdy6A==
X-CSE-MsgGUID: qjKfw+hkQLC/D4J4VQJ4ag==
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
   d="scan'208";a="287733678"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jul 2026 10:54:20 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 91A5A8040A; Fri, 24 Jul 2026 10:54:20 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id C7576819FD
	for <cocci@sympa.inria.fr>; Thu, 23 Jul 2026 20:46:50 +0200 (CEST)
X-CSE-ConnectionGUID: fVo67Hk9SauftwZh5ABtmA==
X-CSE-MsgGUID: 3KmZK/5GTeuxMf+KjSACsw==
IronPort-SDR: 6a62619a_821EVGKgTEQJKOT0PFajDTX225OQSvdZCqYpMuKKITP1+XF
 +ToMwEcYKGBWBQwv+eS5IURgy/ZYSVjMjsS5elQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HFBABZYGJqfDLYVdFaglkCgj8WgVMzBFSVBwaKb4IZM?=
 =?us-ascii?q?AKHU4pPgT89Ag8BAwELAQFPAgQBAQECBIR+Ao1gAh4HAQQwCQ4BAgQDAgMBA?=
 =?us-ascii?q?QEBAQEBAQEBAQsBAQEEAQEBAgEBAgQDAQEBAQIQAQEiGQcOEimGTw1JARABB?=
 =?us-ascii?q?AEBggEBgSRhAgUDOwEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQUCLF8CAQMSFQsBDQEbHQEDDAYQOyACEQEFARwGARIigmCCIwEGEAEDN?=
 =?us-ascii?q?wIBtleBAkKMPBYFAhaBAYINBtpoChkoDXWBYwECAgcJAQoBAYE3AYR3Kl0Dg?=
 =?us-ascii?q?jqFI3WEAnongRiBEIR+gh+COYYwBIMukioBBwcfEggBHAYIAgJIFRIDBAMEB?=
 =?us-ascii?q?AECCxMJAwMCDgIIAwIIBhkBPxIEEwIIAwYECwcFHwoCDBQKKCISAikKAyoLE?=
 =?us-ascii?q?g8DDQYFFQEIBgICBAQCBAwCCQICBQMEAgQNAwQBAQgCAi0DAQMZCAkIAgsFE?=
 =?us-ascii?q?RgMCwUCCicDDwEJAx8DFBsIRQgGFgEaBwUGCzcVBQwRAQIbAiEEHREIAwEYB?=
 =?us-ascii?q?AQCAQsDAQMBFQQICQQMAhAKEhUDDgMHDwINBy4LAwIOAgkIDBcCAgIGAgMDA?=
 =?us-ascii?q?woBAgEBAQEBAQEIAwMDAgMZBwYDBAQBBAQDAwIDBQEDAwMFAgIKBgkBAQEBA?=
 =?us-ascii?q?wICCAMHAwoJAgUDGwMcBgECAgMCAQIDBgMHCAMNAwQCAwMDBAECAgEBAQIDA?=
 =?us-ascii?q?QMDBAMBAwMCAQMHAgIDAwMLAQIDAwMFAwUBBQMFAgIDBQUDBQICCgIDAwMCA?=
 =?us-ascii?q?QMCHAMIAwYDEgEQAwMGAQMHAwcCBAMIBAMGAgMIAwMCCQgDFgYDAwMDBQECA?=
 =?us-ascii?q?gIDBQMDAwgIBAMDBAICAwwCBgMDAwIDAwUDAwcCBAIDBgMDAwEDAwUBAgcCA?=
 =?us-ascii?q?wcCAQsLCAMCBAIJBwkHAQIDCwQCBAYEDQkEAgQCAg8EBAUDAwcBAQIBAggFB?=
 =?us-ascii?q?gMCAhEFCAoFBgICAh0DIQEDDwYBCQUCAQUOBwUCAgoSAwYCAwQFBQEDAQoBC?=
 =?us-ascii?q?wEBAgMDBQUDAwUHAQIEAgcDAwMEAwMDAwEBAgIEBgQDAgMHAwMDAwMEAwUFA?=
 =?us-ascii?q?wIFAgQDBQMHAgMDAgEFCgEEBQQKAQMDAwMFBQMCAgMDBAECBAYDBAIDAQIIB?=
 =?us-ascii?q?AYFAwMDBQIDAwICAgMDBQEFAgMDAwQDAwMIBwUDAwUCCQMDCQMDCwICAyECB?=
 =?us-ascii?q?QMDAwMGAwcDAwQDAwMHBwIDAgMHAwIFAgcFAwMFAwYBAwIBAwMICxgDCwkIB?=
 =?us-ascii?q?wwBPAwHCiQEBAwqAQYOFAUEJRlnBwcCjWgjgkABgQ2CKYFRAQEBpE6gIUkeC?=
 =?us-ascii?q?QEGAmCBZ4EKFQovm1+FfBozl1OTGS6YWiORcJJHhD4CCgcHESQSgTI6gVwzG?=
 =?us-ascii?q?iOBAW2BSVADGQ+OLRaDYMwVNTU+AQcCBw8CgXODdokqgSCBK0mBTAEB?=
IronPort-PHdr: A9a23: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
 pGoojRL3AcxNLYI
IronPort-Data: A9a23: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
 avLelaw
IronPort-HdrOrdr: A9a23:xIMP2aD2V7AKvg7lHemI55DYdb4zR+YMi2TDGXoBLCC9Ffbo6v
 xG+c5w6faaskd3ZJhNo6HiBEDEewKlyXcX2/hqAV7BZniBhILAFugLhuvfKn/balbDH4ZmtJ
 uIGJIObOEYY2IK7/rS0U2XF5IPzrC8n5xARt2z856ud2xXgtlbnn5E48+gfHFLeA==
X-Talos-CUID: 9a23:afMQ0G6p+Lt+3LPlCNss+nATRJ8FcSzmxWreP1CKCTtAYqGQYArF
X-Talos-MUID: =?us-ascii?q?9a23=3AK30Xng1PEJCC8VmAk6BJcq2aATUjuIerOmNKzLo?=
 =?us-ascii?q?6ttSUECIzGDWmpR+sXdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,181,1779141600"; 
   d="scan'208";a="287666980"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDF9itEHqjsUkLjpDHFdhWg/jrZSuUC15I3+Z/?=
 =?us-ascii?q?GnxpMJMgwmEl/G4GM8EHPht9MsAZRuoiQohXlvEr1GEn49s6vZZPL8gC?=
 =?us-ascii?q?aNgihSBDP+IlrQ14d+yUcFUULaZ4nRdNIpODTPju/2ykpx85e95cnIZG?=
 =?us-ascii?q?llfo78EOj9QkNPEDP16qBA2Q=3D=3D?=
Received: from mail-pj1-f50.google.com ([209.85.216.50])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 20:46:50 +0200
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38e08baf860so1121904a91.2
        for <cocci@inria.fr>; Thu, 23 Jul 2026 11:46:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784832409; x=1785437209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=inEAHAT4FZx62nofTUdSreIh00cPh6gTjTfAeZvFyf4=;
        b=gKnmFDL+G7C497ocObUIm997BM8mVq7XtuFZap0pRChbww9zX6oLLwF7T6eE9H47pF
         NGZpwIyqp6KNFEHb3kHuy6C5+aQae2aEfVMtwCswh8w13WuAW/OJVZT54xOUZgIEGWdU
         nh+8k+PDSi5FgHBUyfJwGxC5dPRmYcUrHY4qd3LGau8ayeMUut3dr+JnaJnF2i9QAyEj
         jIZspdn7N+pJTGJIY82g0+ItoNF9h1zBbom/M5FYgWgAVdAI6InJGwV2mErbWLVTwyOX
         ts8JxTDSQpK3ZFjNRy8DVLJ1za8+QZtTQ2/IQm5d5s7EzYM5Sc/YWf/rerjs3qf+CKt3
         ImEA==
X-Gm-Message-State: AOJu0Yw1gOxbz3k8YZbiCxfxJ70t6lIPmIGfB4LuhrpQSkl5OSz7qNxb
	Ou2LhpDqcJmPf3miTnLkD2m+7bVOCFf1R/yBY6ok24sc4Z09ca8U/Tnc
X-Gm-Gg: AR+sD13cPVAWy7J6v9TRIeD9IgDMK9psdSmwp0THTct1kGuEaXB5UE3jVQ6ESAs/VVt
	LLlxleJYAkFoCwFuiJncwIk7GSDE/1/Sc/oUoXbK8jQntPeMwNhPloX2X/ytAozyji53BT2YlJr
	8KNMleC4j5dLIDoVQPjV8okAy6ttOp3CTzii7YP4VnoRBBjDhpw7+hVJPHvH8DQbGZG9vqDgM52
	ARenKKaJDJscIwnLP3v5YRIh70Tl1XjOR3ix1Uu7pkzf1VHgaG837vhDqD2IkbqqNFztnuMW4gw
	C+Z+Po7I2xc7XVlxtuEa8LrYqWmuIICWJ02NpGtxFJJGypHS7ecYg/oKV2xJFQ+ns/dAoMNlCag
	46Vf+GEU/UfcWFYD7PBqOAnss9HdpJMGLSmtm1qMPGuy3tP3bUb30h7m47eWlZmc7rPh6tfIW
X-Received: by 2002:a17:90b:5603:b0:38e:7eb:d07b with SMTP id 98e67ed59e1d1-38ec6622023mr4815354a91.34.1784832408660;
        Thu, 23 Jul 2026 11:46:48 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f03af8a45sm308155a91.10.2026.07.23.11.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 11:46:48 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Julia.Lawall@inria.fr,
	Sinan Kaya <okaya@kernel.org>,
	Vinod Koul <vkoul@kernel.org>
Cc: cocci@inria.fr,
	dmaengine@vger.kernel.org,
	Frank Li <Frank.Li@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Date: Fri, 24 Jul 2026 03:45:21 +0900
Message-ID: <20260723184538.3888637-20-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723184538.3888637-1-ekffu200098@gmail.com>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH 19/36] dmaengine: qcom_hidma: remove conditional
 return with no effect
Reply-To: Sang-Heon Jeon <ekffu200098@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3616
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/Qm1zCfHlomRQ7iojMAxgUA>

Both branches of the check return the same value, so the check has
no effect. Remove it and return the value directly.

This is the result of running the Coccinelle script from
scripts/coccinelle/misc/cond_return_no_effect.cocci.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 drivers/dma/qcom/hidma_ll.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/dma/qcom/hidma_ll.c b/drivers/dma/qcom/hidma_ll.c
index 53244e0e34a3..f081aa787f0c 100644
--- a/drivers/dma/qcom/hidma_ll.c
+++ b/drivers/dma/qcom/hidma_ll.c
@@ -677,11 +677,7 @@ int hidma_ll_setup(struct hidma_lldev *lldev)
 	/* configure interrupts */
 	hidma_ll_setup_irq(lldev, lldev->msi_support);
 
-	rc = hidma_ll_enable(lldev);
-	if (rc)
-		return rc;
-
-	return rc;
+	return hidma_ll_enable(lldev);
 }
 
 void hidma_ll_setup_irq(struct hidma_lldev *lldev, bool msi)
-- 
2.43.0

