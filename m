Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6378BC531FA
	for <cocci@archiver.kernel.org>; Fri, 24 Jul 2026 08:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=uC6QoEcftILT8FAj1uSkH8G4vFtlGaDcPImQjtMJshQ=;
  b=u1F+3OcIHeh7PRKQfm/Nk3IdueGq6Xz1Q+vSOxZhmeCx+efXJNkTYwLc
   PTnzmhVtRZ4eQTDF0kcolShaxyjdX70tLA7GtKsQ9I83e6a0nNSaIzoAT
   9SOfIPCKCnzVB8VbM1vQI2AyMurnfDJ8Xbaptru/L2LBfN6Zi2dUDJ/o2
   8=;
X-CSE-ConnectionGUID: sPy0UusOTveaw4uPNp5rgg==
X-CSE-MsgGUID: 3luiETqeQ8W5g+yivq56Yg==
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
   d="scan'208";a="287733993"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jul 2026 10:54:35 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id BB43A80100; Fri, 24 Jul 2026 10:54:34 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id DACCF819F5
	for <cocci@sympa.inria.fr>; Thu, 23 Jul 2026 20:47:09 +0200 (CEST)
X-CSE-ConnectionGUID: 54oTaoA3QqWG77a2Ib5VWQ==
X-CSE-MsgGUID: YJa/E/r2QH2zkMyuLs8dOw==
IronPort-SDR: 6a6261ad_xa9duC+F0Lx785Qjk4QJO5HgiV+XWyXqsaSlNBF7Ux+j5im
 u2nhACWC5Jo1JFHmt7O6AcOMrLv13Q1QKGHlHpA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HFBABZYGJqfC/YVdFaglkCgj8WgVMzBFSVBwaKb4IZM?=
 =?us-ascii?q?AKHU4pPgT89Ag8BAwELAQFPAgQBAQECBIR+Ao1gAh4HAQQwCQ4BAgQDAgMBA?=
 =?us-ascii?q?QEBAQEBAQEBAQsBAQEEAQEBAgEBAgQDAQEBAQIQAQEiGQcOEimGTw1JARABB?=
 =?us-ascii?q?AEBggEBgSRhAgUDOwEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQUCLF8CAQMSFQsBDQEbHQEDDAYQOyACEQEFARwGARIigmCCIwEGEAEDN?=
 =?us-ascii?q?wIBtleBAkKMPBYFAhaBAYINBoJq134KGSgNdYFjAQICBwkBCgEBgTcBhHcqX?=
 =?us-ascii?q?QOCOoUjdYQCeieBGIEQhH6CH4I5hjAEgiJ6EpIqAQcHHxIIARwGCAICSBUSA?=
 =?us-ascii?q?wQDBAQBAgsTCQMDAg4CCAMCCAYZAT8SBBMCCAMGBAsHBR8KAgwUCigiEgIpC?=
 =?us-ascii?q?gMqCxIPAw0GBRUBCAYCAgQEAgQMAgkCAgUDBAIEDQMEAQEIAgItAwEDGQgJC?=
 =?us-ascii?q?AILBREYDAsFAgonAw8BCQMfAxQbCEUIBhYBGgcFBgs3FQUMEQECGwIhBB0RC?=
 =?us-ascii?q?AMBGAQEAgELAwEDARUECAkEDAEBEAoSFQMOAwcPAg0HLgsDAg4CCQgMFwICA?=
 =?us-ascii?q?gYCAwMDCgECAQEBAQEBAQgDAwMCAxkHBgMEBAEEBAMDAgMFAQMDAwUCAgoGC?=
 =?us-ascii?q?QEBAQEDAgIIAwcDCgkCBQMbAxwGAQICAwIBAgMGAwcIAw0DBAIDAwMEAQICA?=
 =?us-ascii?q?QEBAgMBAwMEAwEDAwIBAwcCAgMDAwsBAgMDAwUDBQEFAwUCAgMFBQMFAgIKA?=
 =?us-ascii?q?gMDAwIBAwIcAwgDBgMSARADAwYBAwcDBwIEAwgEAwYCAwgDAwIJCAMWBgMDA?=
 =?us-ascii?q?wMFAQICAgMFAwMDCAgEAwMEAgIDDAIGAwMDAgMDBQMDBwIEAgMGAwMDAQMDB?=
 =?us-ascii?q?QECBwIDBwIBCwsIAwIEAgkHCQcBAgMLBAIEBgQNCQQCBAICDwQEBQMDBwEBA?=
 =?us-ascii?q?gECCAUGAwICEQUICgUGAgICHQMhAQMPBgEJBQIBBQ4HBQICChIDBgIDBAUFA?=
 =?us-ascii?q?QMBCgELAQECAwMFBQMDBQcBAgQCBwMDAwQDAwMDAQECAgQGBAMCAwcDAwMDA?=
 =?us-ascii?q?wQDBQUDAgUCBAMFAwcCAwMCAQUKAQQFBAoBAwMDAwUFAwICAwMEAQIEBgMEA?=
 =?us-ascii?q?gMBAggEBgUDAwMFAgMDAgICAwMFAQUCAwMDBAMDAwgHBQMDBQIJAwMJAwMLA?=
 =?us-ascii?q?gIDIQIFAwMDAwYDBwMDBAMDAwcHAgMCAwcDAgUCBwUDAwUDBgEDAgEDAwgLG?=
 =?us-ascii?q?AMLCQgHDAE8DAcKJAQEDCoBBg4UBQQlGWcHBwKNaCOCQAGBDYIpgVEBAQGkT?=
 =?us-ascii?q?qAhSR4JAQYCYIFngQoVCi+bX4V8GjOXU5MZmQgjkXCSR4Q+AgoHBxEkEoEyO?=
 =?us-ascii?q?oFcMxojgQFtgUlQAxkPkiPMFTU1PQEBBwIHDgMLgWiDdokqgSCBK0mBTAEB?=
IronPort-PHdr: A9a23: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
 Mz0x5ql8w1mZd8xY6fXIfgRpmU=
IronPort-Data: A9a23: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
 J8ve1aw3g==
IronPort-HdrOrdr: A9a23:NzSUp6N+BZlw+8BcTuWjsMiBIKoaSvp037Dk7TEVdfUzSL3kqy
 nKpp4mPHDP+VEssR0b6LO90ey7MAvhHP1OkPMs1NWZLW/bUQKTRekIjbcKgQeQYBEWntQ96U
 4KSdkbNDSfNykZse/KpCe9V/gvqePpzElqv4vjJrVWID2CE5sQljuRwzz0LnFL
X-Talos-CUID: 9a23:OCxaCGz5JSICet+tupB1BgVJRscZe3r0l07JHGDnVm8zabfId2CprfY=
X-Talos-MUID: 9a23:lLRUxwmD8AQ9cXzH+cUxdnpTFs4vzuO0Unkty4cFntiZETcgNxCC2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,181,1779141600"; 
   d="scan'208";a="287667059"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDHqKrX8q+YZz3enx2Frr7qOO3LsQmQNEtLBqe?=
 =?us-ascii?q?D7gTsvXolnVQrwkeme9pxOW2kd00yzOi++byCqjCI44vgfCJCIJcFASy?=
 =?us-ascii?q?q/yrMAC1SfbFNlJLP4Gp15ja52LXCaezbdt2saC8HuuZwCp/3XXckfQK?=
 =?us-ascii?q?L3bkzSoJcOJ7qpplYRrx+fJg=3D=3D?=
Received: from mail-pj1-f47.google.com ([209.85.216.47])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 20:47:09 +0200
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-383cb94f742so1021731a91.3
        for <cocci@inria.fr>; Thu, 23 Jul 2026 11:47:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784832428; x=1785437228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uC6QoEcftILT8FAj1uSkH8G4vFtlGaDcPImQjtMJshQ=;
        b=i6DLD6S9REL55zk3GZFiq9jN6eL4o+nPrfE1XTb84POsxeOAW/k+dzaweND0QqLsvK
         WRXbJZavLN7XT0khvjNN4CKPMP1v062gcqCDafciQLnKjgrZFG7pcwA4CK1/8saEQLM7
         klpGlF36kHCAc6JOE4RXbZb9lYKpZ/lJBHa+FMrQGbi63p3cQlqnCCKS5ZVYuw/u3jjG
         ui+hgh6xCmiTrtrwnbBedk/y0mXMV7UQJIXv83F0W3PzAn+wS0qJlbuuoDzwu0yKLJT9
         Bkhed1NroDBEhf/ub3TU4JJCLAQrfmnpsXSG6XfHuzwOHgmjmCf2lEmnMInq5HRRyoRH
         gIOg==
X-Gm-Message-State: AOJu0YwpbDkGUAeW1Uxek9h1sTWdlhwUpSp85oFpeeUwTjs2H/xiLUaJ
	/vA37CmqxHarVsYakl3P++meO05YSPrrpUi5iWftV/WHniy9/J6588SC
X-Gm-Gg: AR+sD119C3isMc8UJioRJIn6bwPfuh06Eg8HETLoWw/qfFK2VKSc1I51Uvqmz4IClAb
	wPUtLxiC5rvTuVVa4UDtptXSo6H1ETDc7OPBvESdsmdbsREx0hk63sjYUb8Q4EFzeWOygclT8Mr
	2CFAHQaK2YiJPf+DDRUnDO6GHNmlJ7gn77sge7VFe5e3X6WhTPOUB+c/5n+oJz1heknEkGm421n
	6H1su3iGjqpCA9A7Ol7C0Nzb3sZk21/eO/8Ew5II6fZJi+YkoiJSz7q+aJuvuikX31XbRbGfbD8
	s3LNSL2lRUkHSmsTfWjr0MHFPnqKNQTnitDU8axEVQVROALVpH49itMq0wTKz9ueHxsuAW0570V
	4jNIjwXsL1wjTiULkU9ZAbYmrurLN9/I01v7SpWVOX+uJEYaJbQWItUCkTfxr0eCxdy1Pmu4Y
X-Received: by 2002:a17:90b:54c8:b0:38e:b400:a86c with SMTP id 98e67ed59e1d1-38ec698f5a0mr4314176a91.16.1784832427550;
        Thu, 23 Jul 2026 11:47:07 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f03af8a45sm308155a91.10.2026.07.23.11.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 11:47:07 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Julia.Lawall@inria.fr,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: cocci@inria.fr,
	linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com
Date: Fri, 24 Jul 2026 03:45:30 +0900
Message-ID: <20260723184538.3888637-29-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723184538.3888637-1-ekffu200098@gmail.com>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH 28/36] regulator: wm831x-isink: remove conditional
 return with no effect
Reply-To: Sang-Heon Jeon <ekffu200098@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3625
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/HiTJYAmkPEqrdThwZ8gxLA>

Both branches of the check return the same value, so the check has
no effect. Remove it and return the value directly.

This is the result of running the Coccinelle script from
scripts/coccinelle/misc/cond_return_no_effect.cocci.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 drivers/regulator/wm831x-isink.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/regulator/wm831x-isink.c b/drivers/regulator/wm831x-isink.c
index 43f220cea21c..b46e2cde5e9d 100644
--- a/drivers/regulator/wm831x-isink.c
+++ b/drivers/regulator/wm831x-isink.c
@@ -62,11 +62,7 @@ static int wm831x_isink_disable(struct regulator_dev *rdev)
 	if (ret < 0)
 		return ret;
 
-	ret = wm831x_set_bits(wm831x, isink->reg, WM831X_CS1_ENA, 0);
-	if (ret < 0)
-		return ret;
-
-	return ret;
+	return wm831x_set_bits(wm831x, isink->reg, WM831X_CS1_ENA, 0);
 
 }
 
-- 
2.43.0

