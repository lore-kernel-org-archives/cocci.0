Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3673C53213
	for <cocci@archiver.kernel.org>; Fri, 24 Jul 2026 08:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=E1YwuB1DfTsRKNQyJAGjUXFVGQNAiKL6OzT+JgKENuM=;
  b=FB4bBNsZIXrj+w3Pa4GlEGY9nqInyJgyGNq0l42flVyQfQ8YUwSEHT+2
   21QzEI1wKsQCNzfwRM42hFIR5DF70PUaugKq8twiax/ae0KcSPSuTOtAR
   iFaxb/2VfHJ5srFP67iWPad4p/4iW5UpW/E4CXcugOYSFMZTIWQFngest
   I=;
X-CSE-ConnectionGUID: hXFUcVEiRVWJc4lf734srg==
X-CSE-MsgGUID: kfQHw6O+SFa3TCBhzIzQzQ==
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
   d="scan'208";a="287733903"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jul 2026 10:54:31 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 354348040C; Fri, 24 Jul 2026 10:54:31 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 4AABB819A4
	for <cocci@sympa.inria.fr>; Thu, 23 Jul 2026 20:47:06 +0200 (CEST)
X-CSE-ConnectionGUID: 0CxkAmGYQQO8R3JIGbLypQ==
X-CSE-MsgGUID: ji18YA9wR9+3yC2UVSGLYg==
IronPort-SDR: 6a6261a9_++NkYDvGYiJBXL5Zj/6jH9jiq9zk05IkJLstGmcG5P2ZSk3
 6Z9Lhj80PVq6RbkADpm9nbQqoaaaJZ9vJ3fVH9g==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HFBABZYGJqfDHYVdFaglkCgj8WgVMzBFSVBwaKb4IZM?=
 =?us-ascii?q?AKHU4pPgT89Ag8BAwELAQFPAgQBAQECBIR+Ao1gAh4HAQQwCQ4BAgQDAgMBA?=
 =?us-ascii?q?QEBAQEBAQEBAQsBAQEEAQEBAgEBAgQDAQEBAQIQAQEiGQcOEimGTw1JARABB?=
 =?us-ascii?q?AEBggEBgSRhAgUDOwEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQUCLF8CAQMSFQsBDQEbHQEDDAYQOyACEQEFARwGARIigmCCIwEGEAEDN?=
 =?us-ascii?q?wIBtleBAkKMPBYFAhaBAYINBoJq134KGSgNdYFjAQICBwkBCgEBgTcBhHcqX?=
 =?us-ascii?q?QOCOoUjdYQCeieBGIEQhH6CH4IGM4YwBIMukioBBwcfEggBHAYIAgJIFRIDB?=
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
 =?us-ascii?q?AE8DAcKJAQEDCoBFBQFBCUZZwcHAo1oI4JAAVg1gimBUQEBAaROoCFJHgkBB?=
 =?us-ascii?q?gJggWeBChUKL5tfhXwaM5dTkxkulXeCYyORcJJHhD4CCgcHESQSgTI6gVwzG?=
 =?us-ascii?q?iOBAW2BSVADGQ+OX4NEzBU1NT4BBwIHDwKBc4N2iSqBIIErSYFMAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 E7K
IronPort-HdrOrdr: A9a23:TiAToa/zwYKT2cr0De9uk+D8I+orL9Y04lQ7vn2ZhyYlF/Bw8P
 re4cjzsCWftN9/YgBGpTntAtjifZqYz+8M3WBzB8bZYOCFghrPEGgK1+KLqF3d8m/Fh5VgPM
 9bEpSWY+eAaWSS4/yKgjWQIpIPxJ2o/smT6ts2DE0AceipUcxdBn9Ce3+m+4RNKjV7OQ==
X-Talos-CUID: 9a23:KiDG3WHWObMQqJ/PqmI/314XM8UKQ0Tk6yfqeG2ZJmxNWaWsHAo=
X-Talos-MUID: 9a23:LygSVwXAVFXvvHjq/D3t3WFTHZZ32fXtU1Emy6g4gOagBCMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,181,1779141600"; 
   d="scan'208";a="152815306"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDGcJBrpSQEltHwAN/Kbdc7qq89QfZS+7Uuexs?=
 =?us-ascii?q?y1Dyt7lschKhRyz0c3hPY9mLjW0uJhvBnUp9MvYUR7Rgl8HlnwZnZjia?=
 =?us-ascii?q?hIWTZdZtnUdw+Bgpf9vJSu79YzdX510g+AAGmdbZ+wDqmC53aLwBcxTl?=
 =?us-ascii?q?cNzT5wcVdBxBx/soNKYlIsbA=3D=3D?=
Received: from mail-pj1-f49.google.com ([209.85.216.49])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 20:47:06 +0200
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3811f512167so961767a91.3
        for <cocci@inria.fr>; Thu, 23 Jul 2026 11:47:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784832424; x=1785437224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=E1YwuB1DfTsRKNQyJAGjUXFVGQNAiKL6OzT+JgKENuM=;
        b=KoTktjVIAWzAG0KJrxa1acX2BtoIBVRuFjR8mbBvIhtpyNsKutHx95ll1SKuyRI3TY
         eReg4IfXC9/Px66whOIGpFxsKZHQp4EW9b0VBFo/CjB/GhiQ3byX4eDC3znu/o81RKMQ
         FCku5Z5jynCMLkLeEC9ancDXxxmL9P5szRwL29APYF1WdklWqYS2nqe07GA6L1buBXs1
         TEan/X4mHd9W5xe6UDQ43wLBV1RWIdoK4pLCFjiREuiZb53tqemBfUY0iF/94NkVGSPg
         +GPTiQ5RY55U8ms8o2qLiOi1YP2uXVSLAbcQryhW7H9qyEeyuRaK3xIYN/ncLkoIyC3p
         eX5A==
X-Gm-Message-State: AOJu0YyC1OyKzmkosf0IJcVjycYw8CpyGChhFD50uBnTSoD7XZG77CRY
	tA5lstLvKxTQx3wMVKDFlbT8DleGv4K73hLXR87L3qrz4PeudmUdEslY
X-Gm-Gg: AR+sD11t3nZD4v3yeHbLU6pn2x+bZh4QHK4v0W8IRwaW6uO2xhaEof5RP4pwvkJgna1
	2h+bm/2dg2J6MHB8j8S55VMTjVspTH67q6dE+E8KZpWxyS3pkiLuXXKLBvZS06cWiP+JceCylxn
	s2+yOy62MVdIT1OQgVn6RKCWMiqP4lsEjbzeGLOreNXRsnMbWmf07Y5PZYiOu6Cn9TtrLL7fWBs
	7uVYYRcMohyBTto2VXbSO68XtwqJ75hTjxjSDsyNA1RAxPa2paPO6aA5sT6q1y22L9XRpIXTfoy
	obKN7EWZqxMD/U1Fr+8OJE9jgBZ+AQiHqSGsqbsiEXd/GEJG8WlbRzcS/XyNESDifr1KHazfoN6
	uYMQVX9/r6EvR48yPcj2TgT/X4qvlvtyuV31rS4n23Pvl8pSl1c8Djb04SPmYETuC62NSKfBjkH
	efPxSpULI=
X-Received: by 2002:a17:90b:580e:b0:381:152b:d596 with SMTP id 98e67ed59e1d1-38ec64dd084mr4855965a91.11.1784832423882;
        Thu, 23 Jul 2026 11:47:03 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f03af8a45sm308155a91.10.2026.07.23.11.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 11:47:03 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Julia.Lawall@inria.fr,
	Sebastian Reichel <sre@kernel.org>
Cc: cocci@inria.fr,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Date: Fri, 24 Jul 2026 03:45:28 +0900
Message-ID: <20260723184538.3888637-27-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723184538.3888637-1-ekffu200098@gmail.com>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH 26/36] power: supply: pm8916_lbc: remove conditional
 return with no effect
Reply-To: Sang-Heon Jeon <ekffu200098@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3623
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/RgHIFI1JQ3tL9yM8uLOmBQ>

Both branches of the check return the same value, so the check has
no effect. Remove it and return the value directly.

This is the result of running the Coccinelle script from
scripts/coccinelle/misc/cond_return_no_effect.cocci.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 drivers/power/supply/pm8916_lbc.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/pm8916_lbc.c b/drivers/power/supply/pm8916_lbc.c
index cdc4d78c4219..569f3f4b16fe 100644
--- a/drivers/power/supply/pm8916_lbc.c
+++ b/drivers/power/supply/pm8916_lbc.c
@@ -231,11 +231,9 @@ static int pm8916_lbc_charger_probe_dt(struct pm8916_lbc_charger *chg)
 		return ret;
 
 	/* Disable charger timeout. */
-	ret = regmap_write(chg->regmap, chg->reg[LBC_CHGR] + PM8916_LBC_CHGR_TCHG_MAX_EN, 0x00);
-	if (ret)
-		return ret;
-
-	return ret;
+	return regmap_write(chg->regmap,
+			    chg->reg[LBC_CHGR] + PM8916_LBC_CHGR_TCHG_MAX_EN,
+			    0x00);
 }
 
 static const struct power_supply_desc pm8916_lbc_charger_psy_desc = {
-- 
2.43.0

