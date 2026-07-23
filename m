Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE314C53209
	for <cocci@archiver.kernel.org>; Fri, 24 Jul 2026 08:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=O0IXVWZk1Ru5X2yu0BgI0Dx4RhQRg+VvgM7kUVgisNw=;
  b=sXkHr2C4Q95McjmaYIG6sJZsB46tBnu/kECH4UgJwM8La+nxWuE7N+Uz
   hdI9V2RUkUoIfElTGo0LFWbMXxhOMDrIeOxFO8/HBHPVP2oV0d9J4nOQq
   U82v+2/LFwVFk0bRm3iWHHIJl6U5Du2Bxh9oECFpIKDj4z6dOibWEWFeA
   E=;
X-CSE-ConnectionGUID: +k+DVso3SvCx6oLFK70wzA==
X-CSE-MsgGUID: 1q6KrwuOQLmWBR2j5XKO0A==
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
   d="scan'208";a="287733877"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jul 2026 10:54:30 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 2B901803D8; Fri, 24 Jul 2026 10:54:30 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 74E7A81964
	for <cocci@sympa.inria.fr>; Thu, 23 Jul 2026 20:47:04 +0200 (CEST)
X-CSE-ConnectionGUID: 8mb8Bg7qT4WkJW6n7nJsvg==
X-CSE-MsgGUID: i+Ff2o/9Q+ySQIFgQoBODA==
IronPort-SDR: 6a6261a8_fZeagZ95cDahiT2B1EMkPmqU2ux8DdVBTo1KCC+QjRErlgT
 tt6rXyLIu4SbikZ+f4xpQymhzWZOFGnBLD2mS4A==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HUBQBZYGJqfDXYVdFaglkCgj8WgVMzBFSVBwaKb4IZM?=
 =?us-ascii?q?AKHU4pPFIErPQIPAQMBCwEBTwIEAQEBAgSEfgKNYAIeBwEEMQgOAQIEAwIDA?=
 =?us-ascii?q?QEBAQEBAQEBAQELAQEBBAEBAQIBAQIEAwEBAQECEAEBIhkHDhIphk8NSQEQA?=
 =?us-ascii?q?QQBAYIBAYEkYQIFAzsBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEFAixfAgEDEhULAQ0BGx0BAwwGEDsgAhEBBQEcBgESIoJggiMBBhABA?=
 =?us-ascii?q?zcCAbZXgQJCjDwWBQIWgQGCDQbaaAoZKA11gWMBAgIHCQEKAQGBNwGEdypdA?=
 =?us-ascii?q?4I6hSN1hAJ6J4EYgRCEfoIfggsuhjAEgxwSkioBBwcfEggBHAYIAgJIFRIDB?=
 =?us-ascii?q?AMEBAECCxMJAwMCDgIIAwIIBhkBPxIEEwIIAwYECwcFHwoCDBQKKCISAikKA?=
 =?us-ascii?q?yAKCxIPAw0GBRUBAQcGAgIDAQQCBAwCCQICBQMBAwIEBgcDBAEBCAICLQMBA?=
 =?us-ascii?q?xkICQgCCwURGAwLBQIKJwMPAQkDHwMUGwhFCAYWARoHBQYLNxUFDBEBAhsCI?=
 =?us-ascii?q?QQdEQgDARgEAgICAQsDAQMBFQQICQQMAQEQChIVAw4DBw8CDQcuCwMCDgIJC?=
 =?us-ascii?q?AwXAgICBgIDAwMKAQIBAQEBAQEBCAMDAwIDGQcGAwQEAQQEAwMCAwUBAwMDB?=
 =?us-ascii?q?QICCgYJAQEBAQMCAggDBwMKCQIFAxsDHAYBAgIDAgECAwYDBwgDDQMEAgMDA?=
 =?us-ascii?q?wQBAgIBAQECAwEDAwQDAQMDAgEDBwICAwMDCwECAwMDBQMFAQUDBQICAwUFA?=
 =?us-ascii?q?wUCAgoCAwMDAgEDAhwDCAMGAxIBEAMDBgEDBwMHAgQDCAQDBgIDCAMDAgkIA?=
 =?us-ascii?q?xYGAwMDAwUBAgICAwUDAwMICAQDAwQCAgMMAgYDAwMCAwMFAwMHAgQCAwYDA?=
 =?us-ascii?q?wMBAwMFAQIHAgMHAgELCwgDAgQCCQcJBwECAwsEAgQGBA0JBAIEAgIPBAQFA?=
 =?us-ascii?q?wMHAQECAQIIBQYDAgIRBQgKBQYCAgIdAyEBAw8GAQkFAgEFDgcFAgIKEgMGA?=
 =?us-ascii?q?gMEBQUBAwEKAQsBAQIDAwUFAwMFBwECBAIHAwMDBAMDAwMBAQICBAYEAwIDB?=
 =?us-ascii?q?wMDAwMDBAMFBQMCBQIEAwUDBwIDAwIBBQoBBAUECgEDAwMDBQUDAgIDAwQBA?=
 =?us-ascii?q?gQGAwQCAwECCAQGBQMDAwUCAwMCAgIDAwUBBQIDAwMEAwMDCAcFAwMFAgkDA?=
 =?us-ascii?q?wkDAwsCAgMhAgUDAwMDBgMHAwMEAwMDBwcCAwIDBwMCBQIHBQMDBQMGAQMCA?=
 =?us-ascii?q?QMDCAsYAwsJCAcMATwMBwokBAQMKgEGDhQFBCUZZwcHAo1oI4JAAYENggMmg?=
 =?us-ascii?q?VEBAQGSEJI+oCFJHgkBBgJggWeBChUKL5tfhXwaM5dTkxkumFojkXCSR4Q+A?=
 =?us-ascii?q?goHBxEkEoEzATiBXDMaI4EBbYFJUAMZD45fg0TMFTU1PgEHAgcPAoFzg3aJK?=
 =?us-ascii?q?oEggStJgUwBAQ?=
IronPort-PHdr: A9a23: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
 eRnszRGcWkIEfEtp6Aynn4=
IronPort-Data: A9a23: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
 E4=
IronPort-HdrOrdr: A9a23:r53g1auTaRkK8tzzYzw38Zli7skDUtV00zEX/kB9WHVpmwKj5q
 WTdZMgpGLJYVMqMk3I9urwX5VoLUmslqKdpLNhRYtKPzOWwldATrsSi7cKqgeIc0afygce79
 YaT0EXMrzN5DNB/KLHCWeDYrQd6ejC3qTtq+m29RhQpMJRB52ILT0VNu/iKDwOeOCOP/QEKK
 Y=
X-Talos-CUID: 9a23:cKdJWmNcy7UYXO5DCCxtpGQbRdkZLkLe7kiOJRC+K313R+jA
X-Talos-MUID: 9a23:B2EJHwUozKapfQrq/D6vqj84M4A52ue/M3ksv5o/vOOjGQUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,181,1779141600"; 
   d="scan'208";a="152815303"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDHB33mV3AuspMJ7Ntk3M25KzN30T/zopWj+L9?=
 =?us-ascii?q?rS8yMUzKiiL7EdxsPXBoM5dgF9E1dIGzzVK4SFmUUOpRqtYks2C9mUq2?=
 =?us-ascii?q?Sh8tZMbHHMHZan8l50UTFIj9wmpM4uM5EcTjEyE64d76empallIa7lPO?=
 =?us-ascii?q?r0n4fzko54QxWWmyBYx5/DqA=3D=3D?=
Received: from mail-pj1-f53.google.com ([209.85.216.53])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 20:47:04 +0200
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-384930ca5e2so1050786a91.3
        for <cocci@inria.fr>; Thu, 23 Jul 2026 11:47:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784832422; x=1785437222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=O0IXVWZk1Ru5X2yu0BgI0Dx4RhQRg+VvgM7kUVgisNw=;
        b=c0BTLjgUyZ3Fm2QXKykEPuDmNlpFTkAE+hscMB98UttyjTB1E8JNLBO1a6tM3je5sV
         heObGZaliAS3vrUqA4oCved6rvKDiaLbkYbG0bb3PucpBaxKsRm8uhHo3hN1DgSe7yot
         oGfbdreJ8+RiOds4jfmgDdOp1MJWN+aZABR97FPZvEW2aygfoQDXE++RI2pRO+EOygFC
         D1vR3x7CEJcDcJKV2WZfz95+7gE2N30L5GmTTHrOpQok0IKgFlYEQy+Mqudd4Z7rre2X
         gemJufYoom4q/NwnxOl//GbywC4hYLAbnCsCn3iApI7rt9sPBWEdfXu2C5w0eQAC6B6L
         HeMA==
X-Gm-Message-State: AOJu0YwoB8uOK39LDPvgWoijj0T7hiX1jbgnrifuExIp8TIGVLfORZwa
	vPLtAMoWJwDWHrGKR6jM1noU7MMq3G6kRC8lOfHVr8GBClV+TM7tdr/fIHsxbb2WE3k=
X-Gm-Gg: AR+sD124Sr2W98TAl3nEc/acr9/5muFoRapBY4Ht1AMSxFSwsT2b38JInWoYDuae1Wx
	gl1dhjZ4CRjriCrP0qUZPiR3Rha8i5ecn9CdA5+UxP2mPPyM1hsBu8rFxWPrYTzc35Wt/DlUzPa
	a3ZTQy7Pm9/sFPNU4RrAN0rRUi+PJFW65spk4qytjMw7thbYkPy6AExrVeby8gNXFrK1FtUCDlL
	H2yHFWs9ZzoOnYkvp2oDo/olqxwcW+3oKfRPQefOVEfkzETj3lYPngAf+HuWUl6q0XuGny+WiiU
	ohlxaNuDvsmxuw7AmCcbE4/9nUq4IQT7e+wfrB2dl6yIIilX3OkuwQWP894VWrBcXIxp08AYlI2
	YLDNzmL95/HVTig45104zQZXqTPfYwUcmwjJlBUjc+hcj2mLFdR/oIyOze+Iym1EHTE0B5n0d
X-Received: by 2002:a17:90b:1350:b0:37f:c69d:ce69 with SMTP id 98e67ed59e1d1-38ec64a7b7emr4626593a91.10.1784832422117;
        Thu, 23 Jul 2026 11:47:02 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f03af8a45sm308155a91.10.2026.07.23.11.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 11:47:01 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Julia.Lawall@inria.fr,
	Azael Avalos <coproscefalo@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: cocci@inria.fr,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Date: Fri, 24 Jul 2026 03:45:27 +0900
Message-ID: <20260723184538.3888637-26-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723184538.3888637-1-ekffu200098@gmail.com>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH 25/36] platform/x86: toshiba_haps: remove
 conditional return with no effect
Reply-To: Sang-Heon Jeon <ekffu200098@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3622
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/XxPltNEQKy6M-rPo0vAmlg>

Both branches of the check return the same value, so the check has
no effect. Remove it and return the value directly.

This is the result of running the Coccinelle script from
scripts/coccinelle/misc/cond_return_no_effect.cocci.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 drivers/platform/x86/toshiba_haps.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/platform/x86/toshiba_haps.c b/drivers/platform/x86/toshiba_haps.c
index c6633b74029f..4f62476b8dd1 100644
--- a/drivers/platform/x86/toshiba_haps.c
+++ b/drivers/platform/x86/toshiba_haps.c
@@ -251,11 +251,7 @@ static int toshiba_haps_resume(struct device *device)
 					    haps->protection_level);
 
 	/* Reset the protection on resume */
-	ret = toshiba_haps_reset_protection(haps->acpi_dev->handle);
-	if (ret != 0)
-		return ret;
-
-	return ret;
+	return toshiba_haps_reset_protection(haps->acpi_dev->handle);
 }
 #endif
 
-- 
2.43.0

