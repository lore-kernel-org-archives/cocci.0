Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7979DC531FC
	for <cocci@archiver.kernel.org>; Fri, 24 Jul 2026 08:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=AjI3AsRUClNng1k/UijCjBlEPjB/wot6PGQU56kuWcU=;
  b=KrKwe1bYMamqqiIggCbkMFqtjCgD7aFKr697sKf9HJu4NRgumB16uQ8/
   8BvuMaMneiTKYNGJRc4LNC1atuqj90b9Pdwk9majPmjnF9kghCh8LJleJ
   4Z5/phgQTpSMixpTDiX7dZrEAOeue8jneiXPzNqfUU9SetuQ2S34AObpE
   E=;
X-CSE-ConnectionGUID: mQUFaa/tSceiFXYol3xe1w==
X-CSE-MsgGUID: T42y1UJmRqi1QBd9XK0Lfg==
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
   d="scan'208";a="287733824"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jul 2026 10:54:27 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 8FBE0803C8; Fri, 24 Jul 2026 10:54:27 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 8E09E819F5
	for <cocci@sympa.inria.fr>; Thu, 23 Jul 2026 20:46:59 +0200 (CEST)
X-CSE-ConnectionGUID: u39YGv1ySKazNk0djt9JWg==
X-CSE-MsgGUID: x/VLbpmQTQKWqCOgT1K7Xw==
IronPort-SDR: 6a6261a3_Pd3XnlectJY1PAQMCIjfww7Hsa/hUJRZe4msB/C96uPKkJW
 X9jqhtoaTIhHaoiktfTYHfVN5CvksoRX6A16yjg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HGBABZYGJqfDHYVdFaglkCgj8WgVMzBFSVBwaKb4IZM?=
 =?us-ascii?q?AKHU4pPgT89Ag8BAwELAQFPAgQBAQECBDiERgKNYAIeBwEEMAkOAQIEAwIDA?=
 =?us-ascii?q?QEBAQEBAQEBAQELAQEBBAEBAQIBAQIEAwEBAQECEAEBIhkHDhIphk8NSQEQA?=
 =?us-ascii?q?QQBAYIBAYEkYQIFAzsBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEFAixfAgEDEhULAQ0BGx0BAwwGEDsgAhEBBQEcBgESIoJggiMBBhABA?=
 =?us-ascii?q?zcCAbZXgQJCjDwWBQIWgQGCDQaCatd+ChkoDXWBYwECAgcJAQoBAYE3AYR3K?=
 =?us-ascii?q?l0DgjqFI3WEAnongRiBEIR+gh+CBjOGMASDHBKSKgEHBx8SCAEcBggCAkgVE?=
 =?us-ascii?q?gMEAwQEAQILEwkDAwIOAggDAggGGQE/EgQTAggDBgQLBwUfCgIMFAooIhIrC?=
 =?us-ascii?q?gMqCxIPAw0GBRUBCAYCAgQEAgQMAgkCAgUDBAIEDQMEAQEIAgItAwEDGQgJC?=
 =?us-ascii?q?AILBREYDAsHMQMQCQMfAxQbCEUIBhYBGgcFBgs3FQUMEQECGwIhBB0RCAMBG?=
 =?us-ascii?q?AQEAgELAwEDARUECAkEDAIQChIVAw4DBw8CDQcuCwMCDgIJCAwXAgICBgIDA?=
 =?us-ascii?q?wMKAQIBAQEBAQEBCAMDAwIDGQcGAwQEAQQEAwMCAwUBAwMDBQICCgYJAQEBA?=
 =?us-ascii?q?QMCAggDBwMKCQIFAxsDHAYBAgIDAgECAwYDBwgDDQMEAgMDAwQBAgIBAQECA?=
 =?us-ascii?q?wEDAwQDAQMDAgEDBwICAwMDCwECAwMDBQMFAQUDBQICAwUFAwUCAgoCAwMDA?=
 =?us-ascii?q?gEDAhwDCAMGAxIBEAMDBgEDBwMHAgQDCAQDBgIDCAMDAgkIAxYGAwMDAwUBA?=
 =?us-ascii?q?gICAwUDAwMICAQDAwQCAgMMAgYDAwMCAwMFAwMHAgQCAwYDAwMBAwMFAQIHA?=
 =?us-ascii?q?gMHAgELCwgDAgQCCQcJBwECAwsEAgQGBA0JBAIEAgIPBAQFAwMHAQECAQIIB?=
 =?us-ascii?q?QYDAgIRBQgKBQYCAgIdAyEBAw8GAQkFAgEFDgcFAgIKEgMGAgMEBQUBAwEKA?=
 =?us-ascii?q?QsBAQIDAwUFAwMFBwECBAIHAwMDBAMDAwMBAQICBAYEAwIDBwMDAwMDBAMFB?=
 =?us-ascii?q?QMCBQIEAwUDBwIDAwIBBQoBBAUECgEDAwMDBQUDAgIDAwQBAgQGAwQCAwECC?=
 =?us-ascii?q?AQGBQMDAwUCAwMCAgIDAwUBBQIDAwMEAwMDCAcFAwMFAgkDAwkDAwsCAgMhA?=
 =?us-ascii?q?gUDAwMDBgMHAwMEAwMDBwcCAwIDBwMCBQIHBQMDBQMGAQMCAQMDCAsYAwsJC?=
 =?us-ascii?q?AcMATwMBwokBAQMKgEUFAUEJRlnBwcCjWgjgkABgQ2CKYFRAQEBpE6gIUkeC?=
 =?us-ascii?q?QEGAmCBZ4EKFQovm1+FfBozl1OTGZkII5FwkkeEPgIKBwcRJBKBMjqBXDMaI?=
 =?us-ascii?q?4EBbYFJUAMZD5IjzBU1NT4BBwIHDwKBc4N2iSqBIIErSYFMAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 E7K
IronPort-HdrOrdr: A9a23:anOptq3EWVicTlqLsuhFugqjBKEkLtp133Aq2lEZdPU1SL37qy
 nKpp8mPHDP+VIssR0b+OxoW5PwIk80i6QFhLX5VI3KNGOKhILPFuFfBODZrAEIdReTygck78
 ldT5Q=
X-Talos-CUID: 9a23:AMKlg20GPDzLOp37fjC2XLxfB5t0Q1LDlWbrAEaqL2UxRL+JGH2v9/Yx
X-Talos-MUID: 9a23:2EQwGQhFILfL3qP/YuYUD8MpJIBWx662DXkxqLY5ouKjOhApGGitk2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,181,1779141600"; 
   d="scan'208";a="287667019"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDHFV7/npF8MYJIHn5C1AWfxt53vpjSvTn8R2y?=
 =?us-ascii?q?1g63dFbvHF6WAKml7vNkQqwdW9aBVMCE2/eg2bVyukF9ujYV2eHgnjxZ?=
 =?us-ascii?q?BKWRmuUX9pJaRpam0Css4fHYvhAgvOqJDytf08sw4Us+emKQcm7XHsgx?=
 =?us-ascii?q?YVNAYD04lcb+D7in6BSOtSKw=3D=3D?=
Received: from mail-pj1-f49.google.com ([209.85.216.49])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 20:46:58 +0200
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38e42560ebcso889835a91.1
        for <cocci@inria.fr>; Thu, 23 Jul 2026 11:46:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784832417; x=1785437217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AjI3AsRUClNng1k/UijCjBlEPjB/wot6PGQU56kuWcU=;
        b=PBo8C4EXoYAKWinUlu2dXc2ECTb0W0LABRXzxbavQqTcuefMbZUlH1NW658qR/BJqI
         g8Sg4xttNV2OlPW2gBYjkXDCuOlZCGJH/2HLNtyAzeOfOjL5DCEKhDs6rZMFOCZhlrp1
         nXKWoCvze5m/iI+PRM4pNq3o/KxHdRhaCrH38dJjA1NG+Um+gHCwmk4pguf6fHcx0qSn
         Vw3NMq5OVcaLC/JcgG6yoduKpAUDGXYQFkTfUJrkdtiKJu46n4Fvvet2VtyMyZTW4VBV
         LatH1cvZvVfyzqPw+njk8y/1dgfmxSPYw64IQQh2SnRoh//maVepN5sf7Lkm5s//Twxo
         g9jA==
X-Gm-Message-State: AOJu0YzLOt5xv89JT1FaCjMxnIoCvlZOfA2YriqC2Sxy7965jwM5SiJT
	OpJHyw6vrGDW7FMwEwmTp33IA6iADs1qCZpHJMpcQLCNnWAGHlp8kBSy5RLEkXZnyOc=
X-Gm-Gg: AR+sD10s1pcoyQdUIBwWkzb/ZnhO8YtGgJF48Ec15x9MP+EXJA+ySd8/m/3yaN0SGDo
	IQ8/JhDKaHqODhSXiosoKTAvCtr0KrQtQjK2i+Leuf4h/9UvlnyOqYgvrWs98Gy2DVLLmn1maal
	lUdV60mxr/u6NpeY6rCCe3XFaJg6Dtf8wMLGs3LB3B4WiLr0UAIgmNJTy7rh3WK1qGGQS4lgvxi
	jggshtubMOnv1npNx7uvOXRa9yzUzbjARtcwN4zitz7KSs5XyhU4wjuuH7QQ34zTmzP3X6CuUYn
	Grfg+7DxcMdbLCccOyZV8+plr8hVEuKyqf+xEoqJgeZBIFyUjcZwu4rmwmCyoS+MCPptyHUJrge
	rE1Gx6/YSr8+poBOmmGGIkH+83eKDXLh/iYqPRQE+nXC2tO+d/Cz/NG+Z0HB/JiOpCJcvqv9W
X-Received: by 2002:a17:90b:1d4f:b0:381:1f51:1ff0 with SMTP id 98e67ed59e1d1-38ec648e273mr4470428a91.2.1784832417345;
        Thu, 23 Jul 2026 11:46:57 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f03af8a45sm308155a91.10.2026.07.23.11.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 11:46:56 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Julia.Lawall@inria.fr,
	Matthew Sakai <msakai@redhat.com>
Cc: cocci@inria.fr,
	dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Date: Fri, 24 Jul 2026 03:45:25 +0900
Message-ID: <20260723184538.3888637-24-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723184538.3888637-1-ekffu200098@gmail.com>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH 23/36] dm vdo: remove conditional return with no
 effect
Reply-To: Sang-Heon Jeon <ekffu200098@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3620
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/YnSSKgc13VjVehzIV1y7zA>

Both branches of the check return the same value, so the check has
no effect. Remove it and return the value directly.

This is the result of running the Coccinelle script from
scripts/coccinelle/misc/cond_return_no_effect.cocci.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 drivers/md/dm-vdo/encodings.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/md/dm-vdo/encodings.c b/drivers/md/dm-vdo/encodings.c
index d75e023df637..b09373b0cfe8 100644
--- a/drivers/md/dm-vdo/encodings.c
+++ b/drivers/md/dm-vdo/encodings.c
@@ -1333,12 +1333,8 @@ int vdo_validate_config(const struct vdo_config *config,
 	if (result != VDO_SUCCESS)
 		return result;
 
-	result = VDO_ASSERT(is_power_of_2(config->recovery_journal_size),
-			    "recovery journal size must be a power of two");
-	if (result != VDO_SUCCESS)
-		return result;
-
-	return result;
+	return VDO_ASSERT(is_power_of_2(config->recovery_journal_size),
+			  "recovery journal size must be a power of two");
 }
 
 /**
-- 
2.43.0

