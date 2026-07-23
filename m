Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB794C53209
	for <cocci@archiver.kernel.org>; Fri, 24 Jul 2026 08:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=SiSOFKr0Kvems3WldMsj2qAd8XWvGaX93cSHCBNiZh0=;
  b=iG3dhEN7rU+W282NDYm28wHGfZpMvJ+UpD1/aoZlHy+rQNbByC1CxMv2
   dLbs5CqxTMXOgo2CQ6CAYMj9/GbKPz8uJuoQi2UZJMbwyzah3515D5D7x
   xA4tExf86syBLna0gDEQAOKj6jpxFdoPwCNOhY/Tsx1fM+g4aq/8OPcd7
   g=;
X-CSE-ConnectionGUID: NNrOzAHHSDu4AOC5P5EJzg==
X-CSE-MsgGUID: EkHkr2oJTLuG/GL1qVj6fQ==
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
   d="scan'208";a="287734215"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jul 2026 10:54:45 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 9E3138040A; Fri, 24 Jul 2026 10:54:45 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id E65C581964
	for <cocci@sympa.inria.fr>; Thu, 23 Jul 2026 20:47:38 +0200 (CEST)
X-CSE-ConnectionGUID: M/t1gznbR3ifV93Rgo7Qww==
X-CSE-MsgGUID: gF9EtH2TTl6HBixQyiLQzA==
IronPort-SDR: 6a6261b6_mNLVZ6z7go1JqYY21PP9skrzSks1hAdzIat/oCQ7lltQ0N3
 lwDoY37G6QYLxcpCmkPeSnIS8K3PrNpshphIumw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HEBABdYWJqgbDWVdFaglkCgj8WgVMzBFSVBwaKb4IZM?=
 =?us-ascii?q?AKHU4pPgT89Ag8BAwELAQFPAgQBAQECBIR+Ao1gAh4HAQQwCQ4BAgQDAgMBA?=
 =?us-ascii?q?QEBAQEBAQEBAQsBAQEEAQEBAgEBAgQDAQEBAQIQAQEiGQcOO4ZPDUkBEAEEA?=
 =?us-ascii?q?QGCAQGBJGECBQM7AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBBQIsXwIBAxIVCwENARsdAQMMBhA7IAIRAQUBHAYBEiKCYIIjAQYQAQM3A?=
 =?us-ascii?q?gG2SoECQow8FgUCFoEBgg0G2mgKGSgNdYFjAQICBwkBCgEBgTcBhHcqXQOCO?=
 =?us-ascii?q?oUjdYQCeieBGIEQhH6CH4I5hjAEgy6SKgEHBx8SCAEcBggCAkgVEgMEAwQEA?=
 =?us-ascii?q?QILEwkDAwIOAggDAggGGQE/EgQTAggDBgQLBwUfCgIMFAooIhICKQoDKgsSD?=
 =?us-ascii?q?wMNBgUVAQgGAgIEBAIEDAIJAgIFAwQCBA0DBAEBCAICLQMBAxkICQgCCwURG?=
 =?us-ascii?q?AwLBQIKJwMPAQkDHwMUGwhFCAYWARoHBQYLNxUFDBEBAhsCIQQdEQgDARgEB?=
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
 =?us-ascii?q?AE8DAcKJAQEDCoBBg4UBQQlGWcHBwKNaCOCQAGBDYIpgVEBAQGkTqAhSR4JA?=
 =?us-ascii?q?QYCYIFngQoVCi+bX4V8GjOXU5MZmQgjkXCSR4Q+AgoHBxEkEoEyOoFcMxojg?=
 =?us-ascii?q?QFtgUlQAxkPkiPMFTU1PQEBBwIHDgMLgWiDdokqgSCBK0mBTAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 b7Kq7Ox3l2r
IronPort-HdrOrdr: A9a23:NbWcgqCb7FWbYvLlHemI55DYdb4zR+YMi2TDGXoBLCC9Ffbo6v
 xG+c5w6faaskd3ZJhNo6HiBEDEewKlyXcX2/hqAV7BZniBhILAFugLhuvfKn/balbDH4ZmtJ
 uIGJIObOEYY2IK7/rS0U2XF5IPzrC8n5xARt2z856ud2xXgtlbnn5E48+gfHFLeA==
X-Talos-CUID: 9a23:rZs4OWBteBez5076Ewwg6BcbCMYvSCbcwkmBeHW3DjlQV6LAHA==
X-Talos-MUID: 9a23:N/r/bwZXVAOKSeBTuBG9qS1CbvtU5/qOIkEdqIQHn/CWHHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,181,1779141600"; 
   d="scan'208";a="152815325"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDGQ9mti1NLrJ1aWbvxOJnGFYsYEN4oaywSJqI?=
 =?us-ascii?q?JVQONmoKZierEgkJkXfT8XIUs7ItOVf52CP06zgGFpJmctlAPRGEtjn7?=
 =?us-ascii?q?RYxZm2PlBQv77VvBQ0NLg5wnRcZroPEmEzLJ1zbIYTKRWSxUmYi9hKmk?=
 =?us-ascii?q?j5pP5N5lfop4Yr1bSkkcTl6Q=3D=3D?=
Received: from mail-pl1-f176.google.com ([209.85.214.176])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 20:47:18 +0200
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cce6a0c9c3so11407525ad.1
        for <cocci@inria.fr>; Thu, 23 Jul 2026 11:47:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784832436; x=1785437236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SiSOFKr0Kvems3WldMsj2qAd8XWvGaX93cSHCBNiZh0=;
        b=Vav7kQwPF3NGfOLcbDaQktRBqJc4zoj9+/JSf3eBayI27yeerU/LzNac1THPcl+vgi
         xXUM70xhwRZck2aDM2RT2maJ/030yWV/9d0l/ZZErNXjTgCpQ34/YJdFNhSwW8P347gQ
         GGapbg8ihE31f3o2/vZQEf6Tk7u6yz4NlX9EutVIiBzzSW9p0RHvwprPOcTzsD/IgjGq
         gwpD6p/i0HvwxZEKjmxO22LExd1Wizm3iw5PdYe9Yi9OGEG9Vy6esojyU/7q4q5KzT2s
         5Xjt4Xun8kokjw7o/dPb1f3yQlE6YKrFj8nKitfn4On6yrL19ooIh0QbQr2xMtr6kg5x
         LR/A==
X-Gm-Message-State: AOJu0YzYVuDOSwR/OnZUlbvYEWf56gGsaTUN+1tUwvAUu2X8Unvpw6Mh
	ztWUrx77ElJ1F4GTXstOIL8PTLi/byboyJWQ23xk4GA8ZXVEXytQzvii
X-Gm-Gg: AR+sD136lfBqU4gZkpPJJgQ2lDyHUfSBH4K3jgtM/i94UXgJS3nNWM49D1h3SzJUOIA
	zbufCLHxu1xfT5QSvw9TFZk04FfbtnMJHZnk8+/74XFDYRmh71BEcqLvhRQ9ME1hAOuYW/zIgyg
	xGw36a1UEMOVVPWT/zyS2L0m7hDqACVSa685++LPQdE0he0aPrbWK0ixXcu6vehyTklFXTnv5j/
	ihDWypeANkesSHyqyJbrUQy25l0k9gvXLek8Jq/kKOlu3+menjISpeBD59KiCPEoB91KZqi0+Yb
	dnn7L6PLG8RzyPoT5fJaEesiEwmzWFLunLStl67Lnx/MeUvm166N8d1ozeYGtujn2GoKAv1xir1
	hH/8lChPDuClRtiNCkNDnAnHWEonccQ/bRYo5DPM7vuSg4LfFm8npf6syKiU5hhw8sFkeBWds
X-Received: by 2002:a17:90b:5885:b0:38e:921a:5512 with SMTP id 98e67ed59e1d1-38ec64dd01emr5012020a91.10.1784832436164;
        Thu, 23 Jul 2026 11:47:16 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f03af8a45sm308155a91.10.2026.07.23.11.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 11:47:15 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Julia.Lawall@inria.fr,
	Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: cocci@inria.fr,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Date: Fri, 24 Jul 2026 03:45:34 +0900
Message-ID: <20260723184538.3888637-33-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723184538.3888637-1-ekffu200098@gmail.com>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH 32/36] USB: serial: ch341: remove conditional return
 with no effect
Reply-To: Sang-Heon Jeon <ekffu200098@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3631
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/70n2q097OOcaIra9RPsKFg>

Both branches of the check return the same value, so the check has
no effect. Remove it and return the value directly.

This is the result of running the Coccinelle script from
scripts/coccinelle/misc/cond_return_no_effect.cocci.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 drivers/usb/serial/ch341.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/serial/ch341.c b/drivers/usb/serial/ch341.c
index 569f4aede215..3de317bde07b 100644
--- a/drivers/usb/serial/ch341.c
+++ b/drivers/usb/serial/ch341.c
@@ -279,12 +279,8 @@ static int ch341_set_baudrate_lcr(struct usb_device *dev,
 	if (priv->version < 0x30)
 		return 0;
 
-	r = ch341_control_out(dev, CH341_REQ_WRITE_REG,
-			      CH341_REG_LCR2 << 8 | CH341_REG_LCR, lcr);
-	if (r)
-		return r;
-
-	return r;
+	return ch341_control_out(dev, CH341_REQ_WRITE_REG,
+				 CH341_REG_LCR2 << 8 | CH341_REG_LCR, lcr);
 }
 
 static int ch341_set_handshake(struct usb_device *dev, u8 control)
-- 
2.43.0

