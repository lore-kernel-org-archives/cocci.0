Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E3B2C531FA
	for <cocci@archiver.kernel.org>; Fri, 24 Jul 2026 08:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=BNEry2bLNg81OguQ9I1ru3wEUBWoj/YG1funVUmQkdk=;
  b=WJKIu1SwEaSCl/kyXccylsQIOc3itbf9LiN24y06Mv8XYnLMYgMTnhCA
   /LZp2u9A7npdAHXtE4QKOMB+tH/pJA12pcAHNMxdMDKgf6+9Sr0o3qe+Q
   PpiMHYesLNc8x62t1xF0uzJVLZKP6lnaGqwRuk347bjLApkR+4SCTjmUz
   E=;
X-CSE-ConnectionGUID: 05JEZqs7RiyD+b7Z9da8nw==
X-CSE-MsgGUID: ruNSkr52T92+qLzp9TQJWw==
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
   d="scan'208";a="287733854"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jul 2026 10:54:29 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id D5C69803D8; Fri, 24 Jul 2026 10:54:28 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 7A778819A4
	for <cocci@sympa.inria.fr>; Thu, 23 Jul 2026 20:47:02 +0200 (CEST)
X-CSE-ConnectionGUID: viB3lW7RQESdYpsw8+bbSw==
X-CSE-MsgGUID: DY49VqdUQ6mBeXquxIbT0A==
IronPort-SDR: 6a6261a6_axqAHQAcNNBP0XJ23w93ZSKV75U6PGZO1GV2nK4Il+fswxM
 BIlthCZ9q+6Cj90M2v5iHZjB01yF7ncD5Cxmp/Q==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HFBABZYGJqfCvYVdFaglkCgj8WgVMzBFSVBwaKb4IZM?=
 =?us-ascii?q?AKHU4pPgT89Ag8BAwELAQFPAgQBAQECBDiERgKNYAIeBwEEMAkOAQIEAwIDA?=
 =?us-ascii?q?QEBAQEBAQEBAQELAQEBBAEBAQIBAQIEAwEBAQECEAEBIhkHDhIphk8NSQEQA?=
 =?us-ascii?q?QQBAYIBAYEkYQIFAzsBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEFAixfAgEDEiABDQEbHQEDDAYQOyACEQEFARwGARIigmCCIwEGEAEDN?=
 =?us-ascii?q?wIBtleBAkKMUgUCFoEBgg0G2mgKGSgNdYFjAQICBwkBCgEBgTcBhHcqXQOCO?=
 =?us-ascii?q?oUjdYQCeieBGIEQhH6CH4I5hjAEgxwSkioBBwcfEggBHAYIAgJIFRIDBAMEB?=
 =?us-ascii?q?AECCxMJAwMCDgIIAwIIBhkBPxIEEwIIAwYECwcFHwoCDBQKKCISAikKAyAKC?=
 =?us-ascii?q?xIPAw0GBRUBAQcGAgIDAQQCBAwCCQICBQMBAwIEBgcDBAEBCAICLQMBAxkIC?=
 =?us-ascii?q?QgCCwURGAwLBQIKJwMPAQkDHwMUGwhFCAYWARoHBQYLNxUFDBEBAhsCIQQdE?=
 =?us-ascii?q?QgDARgEAgICAQsDAQMBFQQICQQMAhAKEhUDDgMHDwINBy4LAwIOAgkIDBcCA?=
 =?us-ascii?q?gIGAgMDAwoBAgEBAQEBAQEIAwMDAgMZBwYDBAQBBAQDAwIDBQEDAwMFAgIKB?=
 =?us-ascii?q?gkBAQEBAwICCAMHAwoJAgUDGwMcBgECAgMCAQIDBgMHCAMNAwQCAwMDBAECA?=
 =?us-ascii?q?gEBAQIDAQMDBAMBAwMCAQMHAgIDAwMLAQIDAwMFAwUBBQMFAgIDBQUDBQICC?=
 =?us-ascii?q?gIDAwMCAQMCHAMIAwYDEgEQAwMGAQMHAwcCBAMIBAMGAgMIAwMCCQgDFgYDA?=
 =?us-ascii?q?wMDBQECAgIDBQMDAwgIBAMDBAICAwwCBgMDAwIDAwUDAwcCBAIDBgMDAwEDA?=
 =?us-ascii?q?wUBAgcCAwcCAQsLCAMCBAIJBwkHAQIDCwQCBAYEDQkEAgQCAg8EBAUDAwcBA?=
 =?us-ascii?q?QIBAggFBgMCAhEFCAoFBgICAh0DIQEDDwYBCQUCAQUOBwUCAgoSAwYCAwQFB?=
 =?us-ascii?q?QEDAQoBCwEBAgMDBQUDAwUHAQIEAgcDAwMEAwMDAwEBAgIEBgQDAgMHAwMDA?=
 =?us-ascii?q?wMEAwUFAwIFAgQDBQMHAgMDAgEFCgEEBQQKAQMDAwMFBQMCAgMDBAECBAYDB?=
 =?us-ascii?q?AIDAQIIBAYFAwMDBQIDAwICAgMDBQEFAgMDAwQDAwMIBwUDAwUCCQMDCQMDC?=
 =?us-ascii?q?wICAyECBQMDAwMGAwcDAwQDAwMHBwIDAgMHAwIFAgcFAwMFAwYBAwIBAwMIC?=
 =?us-ascii?q?xgDCwkIBwwBPAwHCiQEBAwqAQYOFAUEJRlnBwcCjWgjgkABgQ2CKYFRAQEBp?=
 =?us-ascii?q?E6gIUkeCQEGAmCBZ4EKFQovm1+FfBozl1OTGZkII5FwkkeEPgIKBwcRJBKBM?=
 =?us-ascii?q?jqBXDMaI4EBbYFJUAMZD5IjzBU1NT4BBwIHDwKBc4N2iSqBIIErSYFMAQE?=
IronPort-PHdr: A9a23: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
 M4idwyfUEV9ldN58jwGMMPDLUdeaM8ArBDu
IronPort-Data: A9a23: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
 E7K
IronPort-HdrOrdr: A9a23:9K391qG5vp0I7pKepLqEzMeALOsnbusQ8zAXPo5KOHlom6uj5r
 2TdZEgvyMc5wxhP03I9erwW5VoBEmsjaKdgrNhR4tKPjOW3ldARbsKheCD/9SjIVyEygc078
 ZdmsNFebnN5DZB/KTHyTj9PdJl7tfvys+VbCTlo0uFjzsGV0gZ1XYBNu9TKCNLeDU=
X-Talos-CUID: 9a23:qFHDamyG4qBrX1Hvi+F2BgUKG+p+dkKC9k79GEOJEX12GP6fQ2SPrfY=
X-Talos-MUID: 9a23:1O3GRAikyPK3/uPLC6sRS8MpGPY0spq3BH00z5AstvmdKDxRMQvFpWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,181,1779141600"; 
   d="scan'208";a="152815300"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDHLMMrOGxdda50ral/MdqOiqNDQ0NyooB0FAi?=
 =?us-ascii?q?zCbPgtsfVB8QLHqlfgFhp3ecisDS+tV61uMyYyBe87/+37+5tTxqEq4B?=
 =?us-ascii?q?r8aQqM7Zxc7ospCpzB/pbDRZ1I2Pl81WFj6haMOfRwHM2TWLwylk5UUc?=
 =?us-ascii?q?d3AIKcgMrsjM2rX8mjbeIrIw=3D=3D?=
Received: from mail-pj1-f43.google.com ([209.85.216.43])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 20:47:02 +0200
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-381b831d535so1091164a91.0
        for <cocci@inria.fr>; Thu, 23 Jul 2026 11:47:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784832420; x=1785437220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BNEry2bLNg81OguQ9I1ru3wEUBWoj/YG1funVUmQkdk=;
        b=HLdbtU4CXaAyfu9pHbU6Khkz4QtDIYUxP3Qc1nXLXSkmRj4/BdC+57f+4YnpI791ud
         NyC2PgtYEOjRlYVsxyiy8JV9OEa9QaDrX+fpsYBGH4WoMyJsLvT4L9AhLYVrWBNknBUM
         FQPF67XYn4t13BR9oRhDd5jW7rwpuw274OCUT29K0KFHh0gGvw5HAsjauOFvzmZKX0rC
         0Hi4PEe6zrAy5tpkZU236/apNBXB0Tu+awtVRJ0mcetGAmSgiwBC/fgFg9q72bBE25n6
         mRI0cuLCNYUfSn0q0OkyIy0lJFshaCbTvMpfdLyDYrp8Ivt2qw9MhtcjYoPpTqy1fKDK
         A4UQ==
X-Gm-Message-State: AOJu0Yx18/xJMw+/a6N57P+ppZxW0y3V8si8vVHRmiq0i29IVl/W8ht7
	OOs4x2LNhrT0ndemxq9e23dzqDa+5hWgPhl/GaCugS+1Qw+W8ncSI4fj
X-Gm-Gg: AR+sD11ztDQGeKXEp6wjRlPbu/0hakOj60g9cYF8qCYALoxWqEnwJJGDGAXarNogmn3
	gFJCOey/FewYr81Xt7V0G+q92LY0qk1mldayWia1EDec7D68woyoSWFlQhv4XJfduPp5QC5PVXO
	xhqQ5b89LDLCmIBD2kSk8xZzopFrJ8Ue4SBw4/SMFDWOHhYBw2UCjNOKBL3UUJurANM6qVNchne
	W/UTA9ERpjWsrt+PiXb4AamJHK0CWCfjTS82iXwiE8EBlmw15tXa+vF7tUckfLbPXstKXpyuH+P
	EcKh9ibWzsT8CM0pgGmyJGkjuESMdz2ItphK5pf+fOpXJXCjB3c/TNlU5kR4uTrDGZ30btBmq6t
	DFsJZtilRQ2Kz7tSIyHciJlCzpSPJIK+KD8+13wwMzGAlq5q6luaALMMiiQ7mERidz+9ay8LX
X-Received: by 2002:a17:90b:53c4:b0:38d:ef48:b04 with SMTP id 98e67ed59e1d1-38ec657558amr4646237a91.10.1784832420077;
        Thu, 23 Jul 2026 11:47:00 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f03af8a45sm308155a91.10.2026.07.23.11.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 11:46:59 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Julia.Lawall@inria.fr,
	Sean Wang <sean.wang@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: cocci@inria.fr,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Date: Fri, 24 Jul 2026 03:45:26 +0900
Message-ID: <20260723184538.3888637-25-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723184538.3888637-1-ekffu200098@gmail.com>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH 24/36] pinctrl: mediatek: remove conditional return
 with no effect
Reply-To: Sang-Heon Jeon <ekffu200098@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3621
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/JnGouAcFW_S_Wyy6TIax1Q>

Both branches of the check return the same value, so the check has
no effect. Remove it and return the value directly.

This is the result of running the Coccinelle script from
scripts/coccinelle/misc/cond_return_no_effect.cocci.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
index 4918d38abfc2..a8ab982d8f21 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
@@ -1242,11 +1242,7 @@ int mtk_pinconf_adv_drive_set(struct mtk_pinctrl *hw,
 	if (err)
 		return err;
 
-	err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_DRV_E1, e1);
-	if (err)
-		return err;
-
-	return err;
+	return mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_DRV_E1, e1);
 }
 EXPORT_SYMBOL_GPL(mtk_pinconf_adv_drive_set);
 
-- 
2.43.0

