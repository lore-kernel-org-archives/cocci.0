Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8446C53209
	for <cocci@archiver.kernel.org>; Fri, 24 Jul 2026 08:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=SS85S9k55fKh3CHy42qY+ZLh5U3vliQxWiJO6SqlhjU=;
  b=SAJ3wwifDKCXmChE5qIdiKVqe6cP9ly4ayLqyA1FmktDGgXw+K9aYxzX
   AObhLXyju1SDnsAjw9bnescRRQCJFPTYyJT85jYNtffgyQupXjcNZGUhY
   hUBWcb2LWiIn3FySQDB6qbuRP4M9fb4XDHO+KhY5IJsdF5w5X8Bxh6y/q
   Y=;
X-CSE-ConnectionGUID: sgEjkU4CSoik0GMcaBGFNA==
X-CSE-MsgGUID: up6Pclw3RFy5Fwl8pdXRqA==
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
   d="scan'208";a="287734028"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jul 2026 10:54:36 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 4ED8D803FA; Fri, 24 Jul 2026 10:54:36 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id C5F9581964
	for <cocci@sympa.inria.fr>; Thu, 23 Jul 2026 20:47:11 +0200 (CEST)
X-CSE-ConnectionGUID: 7OmiZarUQS2BO9yWaQHxcQ==
X-CSE-MsgGUID: p+TkltETTf2Fe85cXUmklw==
IronPort-SDR: 6a6261af_QVLC9vaaWNbdNhsXxrzKTAFdPow7s7ZTm0aASRLgQWRt5x/
 IQZlYUzd2l7Hljrl9VGyRHcYPCA7vq4wGqDJFgQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HGBABZYGJqfCnYVdFaglkCgj8WgVMzBFSVBwaKb4IZM?=
 =?us-ascii?q?AKHU4pPgT89Ag8BAwELAQFPAgQBAQECBDiERgKNYAIeBwEEMAkOAQIEAwIDA?=
 =?us-ascii?q?QEBAQEBAQEBAQELAQEBBAEBAQIBAQIEAwEBAQECEAEBIhkHDhIphk8NSQEQA?=
 =?us-ascii?q?QQBAYIBAYEkYQIFAzsBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEFAixfAgEDEhULAQ0BGx0BAwwGEDsgAhEBBQEcBgESIoJggiMBBhABA?=
 =?us-ascii?q?zcCAbZXgQJCjDwWBQIWgQGCDQaCatd+ChkoDXWBYwECAgcJAQoBAYE3AYR3K?=
 =?us-ascii?q?l0DgjqFI3WEAnongRiBEIR+gh+COYYwBIMukioBBwcfEggBHAYIAgJIFRIDB?=
 =?us-ascii?q?AMEBAECCxMJAwMCDgIIAwIIBhkBPxIEEwIIAwYECwcFHwoCDBQKKCISKwoDK?=
 =?us-ascii?q?gsSDwMNBgUVAQgGAgIEBAIEDAIJAgIFAwQCBA0DBAEBCAICLQMBAxkICQgCC?=
 =?us-ascii?q?wURGAwLBzEDEAkDHwMUGwhFCAYWARoHBQYLNxUFDBEBAhsCIQQdEQgDARgEB?=
 =?us-ascii?q?AIBCwMBAwEVBAgJBAwCEAoSFQMOAwcPAg0HLgsDAg4CCQgMFwICAgYCAwMDC?=
 =?us-ascii?q?gECAQEBAQEBAQgDAwMCAxkHBgMEBAEEBAMDAgMFAQMDAwUCAgoGCQEBAQEDA?=
 =?us-ascii?q?gIIAwcDCgkCBQMbAxwGAQICAwIBAgMGAwcIAw0DBAIDAwMEAQICAQEBAgMBA?=
 =?us-ascii?q?wMEAwEDAwIBAwcCAgMDAwsBAgMDAwUDBQEFAwUCAgMFBQMFAgIKAgMDAwIBA?=
 =?us-ascii?q?wIcAwgDBgMSARADAwYBAwcDBwIEAwgEAwYCAwgDAwIJCAMWBgMDAwMFAQICA?=
 =?us-ascii?q?gMFAwMDCAgEAwMEAgIDDAIGAwMDAgMDBQMDBwIEAgMGAwMDAQMDBQECBwIDB?=
 =?us-ascii?q?wIBCwsIAwIEAgkHCQcBAgMLBAIEBgQNCQQCBAICDwQEBQMDBwEBAgECCAUGA?=
 =?us-ascii?q?wICEQUICgUGAgICHQMhAQMPBgEJBQIBBQ4HBQICChIDBgIDBAUFAQMBCgELA?=
 =?us-ascii?q?QECAwMFBQMDBQcBAgQCBwMDAwQDAwMDAQECAgQGBAMCAwcDAwMDAwQDBQUDA?=
 =?us-ascii?q?gUCBAMFAwcCAwMCAQUKAQQFBAoBAwMDAwUFAwICAwMEAQIEBgMEAgMBAggEB?=
 =?us-ascii?q?gUDAwMFAgMDAgICAwMFAQUCAwMDBAMDAwgHBQMDBQIJAwMJAwMLAgIDIQIFA?=
 =?us-ascii?q?wMDAwYDBwMDBAMDAwcHAgMCAwcDAgUCBwUDAwUDBgEDAgEDAwgLGAMLCQgHD?=
 =?us-ascii?q?AE8DAcKJAQEDCoBFBQFBCUZZwcHAo1oI4JAAYENgimBUQEBAaROoCFJHgkBB?=
 =?us-ascii?q?gJggWeBChUKL5tfhXwaM5dTkxmZCCORcJJHhD4CCgcHESQSgTI6gVwzGiOBA?=
 =?us-ascii?q?W2BSVADGQ+SI8wVNTU+AQcCBw8CgXODdokqgSCBK0mBTAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 J8ve1aw3g==
IronPort-HdrOrdr: A9a23:qvRXFKBCehm5pxHlHemI55DYdb4zR+YMi2TDGXoBLCC9Ffbo6v
 xG+c5w6faaskd3ZJhNo6HiBEDEewKlyXcX2/hqAV7BZniBhILAFugLhuvfKn/balbDH4ZmtJ
 uIGJIObOEYY2IK7/rS0U2XF5IPzrC8n5xARt2z856ud2xXgtlbnn5E48+gfHFLeA==
X-Talos-CUID: 9a23:sLWrtWHTAPYxlX8hqmI400sVKMk/T0Tmll33cl6HAF9JWLasHAo=
X-Talos-MUID: 9a23:i7/MSQb+FojDZOBTr3zQhzV+GftU7f6ABRBQmqU7vsqAKnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,181,1779141600"; 
   d="scan'208";a="287667075"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDGwgFUZSBYkjpvIvRsLSPBHe+4XUUABw2OQs4?=
 =?us-ascii?q?dxqLcDGv/L7yYowiNAwTCoMJ6rwOIbSbP2y6URYE7GW4vlL8MIqAeQgW?=
 =?us-ascii?q?N/I9bysu2//KMYaJlHeBlibjDrTJvkEOMWLzYBnP1XShpCsnsROsz52D?=
 =?us-ascii?q?siUerJPqGrLQ/DUrbKvM1WDg=3D=3D?=
Received: from mail-pj1-f41.google.com ([209.85.216.41])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 20:47:11 +0200
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38e3617ba36so977970a91.3
        for <cocci@inria.fr>; Thu, 23 Jul 2026 11:47:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784832430; x=1785437230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SS85S9k55fKh3CHy42qY+ZLh5U3vliQxWiJO6SqlhjU=;
        b=HpV9Vvrp4jvDwtOhHAEU8JOr3usSA9E4qyREXoq2C3rEHcRisYi//AFLOCqK66gOuO
         QsUdP15N2Oc5wKEH0XVT15xmLbJL+2u5+PUgXhMUjmY6ZeTH4p767Gg2q/1pcamSmLOw
         hfGUyie7OpfHx6+y6BHp2S8vdDRv1cWLc7rvEcHNF2wMV949prSNNLTYNgbWUFAi56V7
         yq7vP9ccrKyQmtFj9FwU3kzlicZ1T10zFI0TfZZvgd5Il1KfFRUqw/pzKyI2qzCbjOvV
         mYx2VHD2PJYJn2+1Q/aO4bHXKHHMNub/EpoqUjaPQTYrnAih8xpaGPyXdgdouVV+HILo
         QpWw==
X-Gm-Message-State: AOJu0YxNBWZPoR084k2VUG1QC8C5gfRr2T46vVioMuKvCOwF00QTUQb2
	uUZHLdeQy9Lxwc6xgLKgYXnZSRQaP6z77/THjYLxfVX6R0+QFOiwBBqz0Ia+BnPnXq0=
X-Gm-Gg: AR+sD11dmpVceITqbhxaeh0IT371KIvt+QfJDtD9jiK5NlSRX5zdd3f4INX6/5dbOiN
	0rVODA7yssOwrEnXypff/NOz/ZI+5vmks6T4+itOlg2BTXXFcJs/6DpgvMLgmWUs5um1HC3nx4w
	3CE9pCfSgcyFRbC37fTq/rnebzq25cDTpAVM2eMmATOYjIL8alXnHTsCgVS2kweVjB6solC5yc9
	eWfdzqXfWkJIfcaxZs+sFChy9eyQON5pStOaG7gZtzM2KEM+4xHrWONDHBBtFNr3DQNAMtrDjjt
	TPHx9bLtZRqao2IjxFkn0pFESMQbd3WJtbRwbo+qAsuqcvb84jOdsOk5yrqazClIQRRFUDfI4XO
	r75x2YaVfx7kV1IWvd4XD+LaFsJjhkTVMpY9gSHgpOrdE50CSS32UQhaOlcQm+e5SfjSCDe8w
X-Received: by 2002:a17:90b:3b4f:b0:387:e0bb:57f1 with SMTP id 98e67ed59e1d1-38ec6a7a591mr4120286a91.34.1784832429331;
        Thu, 23 Jul 2026 11:47:09 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f03af8a45sm308155a91.10.2026.07.23.11.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 11:47:08 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Julia.Lawall@inria.fr,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: cocci@inria.fr,
	linux-kernel@vger.kernel.org,
	linux-rtc@vger.kernel.org
Date: Fri, 24 Jul 2026 03:45:31 +0900
Message-ID: <20260723184538.3888637-30-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723184538.3888637-1-ekffu200098@gmail.com>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH 29/36] rtc: pcf2127: remove conditional return with
 no effect
Reply-To: Sang-Heon Jeon <ekffu200098@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3626
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/RAaCC70DuYV7ggKk6la5EA>

Both branches of the check return the same value, so the check has
no effect. Remove it and return the value directly.

This is the result of running the Coccinelle script from
scripts/coccinelle/misc/cond_return_no_effect.cocci.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 drivers/rtc/rtc-pcf2127.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
index 1995e9f2756d..ff2023908f5a 100644
--- a/drivers/rtc/rtc-pcf2127.c
+++ b/drivers/rtc/rtc-pcf2127.c
@@ -1184,12 +1184,7 @@ static int pcf2127_configure_interrupt_pins(struct device *dev)
 	if (ret)
 		return ret;
 
-	ret = regmap_write(pcf2127->regmap,
-			   PCF2131_REG_INT_A_MASK2, 0);
-	if (ret)
-		return ret;
-
-	return ret;
+	return regmap_write(pcf2127->regmap, PCF2131_REG_INT_A_MASK2, 0);
 }
 
 static int pcf2127_probe(struct device *dev, struct regmap *regmap,
-- 
2.43.0

