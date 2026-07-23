Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C0B7C531FA
	for <cocci@archiver.kernel.org>; Fri, 24 Jul 2026 08:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=F+UjJ2nGjxXWT2RhAQzqOjO+SrT+lpfkp3b16ZbPdls=;
  b=cmdScTapEnuLaroLwdZbUmSru19PV59SsyaZicy21beTSB3ItlxhMKD0
   phNyZlOyTcUVq0jX7ohiKLFvd0dwgpP07T1zJ13u0VBaj7A1i9hYk/UNY
   1UVAoUpe+cVyS43tl1GIv9SJSDN2CWOoH4iWuzvG2MCOjh2VUcQxeWX7B
   c=;
X-CSE-ConnectionGUID: 3DI+4+Y8Rniiyctew4zkVw==
X-CSE-MsgGUID: ARFkC+AsQ/60X2D2kYH76Q==
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
   d="scan'208";a="287734065"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jul 2026 10:54:38 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 51B34803C8; Fri, 24 Jul 2026 10:54:38 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 34CEC819A4
	for <cocci@sympa.inria.fr>; Thu, 23 Jul 2026 20:47:16 +0200 (CEST)
X-CSE-ConnectionGUID: 9G/IQfRAQj+cr7jSdnc6TA==
X-CSE-MsgGUID: UwNXKqmpQIeIZTxw3V4mWA==
IronPort-SDR: 6a6261b3_WFLyvaDeyORGWI0hoqLyJfpaSiNoeS+xcvRL2mC5BbgGYmZ
 7oq7bDZGQY+qeXgClPQO43ipAGvKVf5PagPxt9Q==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HEBABZYGJqfCnYVdFaglkCgj8WgVMzBFSVBwaKb4IZM?=
 =?us-ascii?q?AKHU4pPgT89Ag8BAwELAQFPAgQBAQECBIR+Ao1gAh4HAQQwCQ4BAgQDAgMBA?=
 =?us-ascii?q?QEBAQEBAQEBAQsBAQEEAQEBAgEBAgQDAQEBAQIQAQEiGQcOEimGTw1JARABB?=
 =?us-ascii?q?AEBggEBgSRhAgUDOwEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQUCLF8CAQMSIAENARsdAQMMBhA7IAIRAQUBHAYBEiKCYIIjAQYQAQM3A?=
 =?us-ascii?q?gG2V4ECQoxSBQIWgQGCDQbaaAoZKA11gWMBAgIHCQEKAQGBNwGEdypdA4I6h?=
 =?us-ascii?q?SN1hAJ6J4EYgRCEfoIfgjmGMASDLpIqAQcHHxIIARwGCAICSBUSAwQDBAQBA?=
 =?us-ascii?q?gsTCQMDAg4CCAMCCAYZAT8SBBMCCAMGBAsHBR8KAgwUCigiEgIpCgMqCxIPA?=
 =?us-ascii?q?w0GBRUBCAYCAgQEAgQMAgkCAgUDBAIEDQMEAQEIAgItAwEDGQgJCAILBREYD?=
 =?us-ascii?q?AsFAgonAw8BCQMfAxQbCEUIBhYBGgcFBgs3FQUMEQECGwIhBB0RCAMBGAQEA?=
 =?us-ascii?q?gELAwEDARUECAkEDAIQChIVAw4DBw8CDQcuCwMCDgIJCAwXAgICBgIDAwMKA?=
 =?us-ascii?q?QIBAQEBAQEBCAMDAwIDGQcGAwQEAQQEAwMCAwUBAwMDBQICCgYJAQEBAQMCA?=
 =?us-ascii?q?ggDBwMKCQIFAxsDHAYBAgIDAgECAwYDBwgDDQMEAgMDAwQBAgIBAQECAwEDA?=
 =?us-ascii?q?wQDAQMDAgEDBwICAwMDCwECAwMDBQMFAQUDBQICAwUFAwUCAgoCAwMDAgEDA?=
 =?us-ascii?q?hwDCAMGAxIBEAMDBgEDBwMHAgQDCAQDBgIDCAMDAgkIAxYGAwMDAwUBAgICA?=
 =?us-ascii?q?wUDAwMICAQDAwQCAgMMAgYDAwMCAwMFAwMHAgQCAwYDAwMBAwMFAQIHAgMHA?=
 =?us-ascii?q?gELCwgDAgQCCQcJBwECAwsEAgQGBA0JBAIEAgIPBAQFAwMHAQECAQIIBQYDA?=
 =?us-ascii?q?gIRBQgKBQYCAgIdAyEBAw8GAQkFAgEFDgcFAgIKEgMGAgMEBQUBAwEKAQsBA?=
 =?us-ascii?q?QIDAwUFAwMFBwECBAIHAwMDBAMDAwMBAQICBAYEAwIDBwMDAwMDBAMFBQMCB?=
 =?us-ascii?q?QIEAwUDBwIDAwIBBQoBBAUECgEDAwMDBQUDAgIDAwQBAgQGAwQCAwECCAQGB?=
 =?us-ascii?q?QMDAwUCAwMCAgIDAwUBBQIDAwMEAwMDCAcFAwMFAgkDAwkDAwsCAgMhAgUDA?=
 =?us-ascii?q?wMDBgMHAwMEAwMDBwcCAwIDBwMCBQIHBQMDBQMGAQMCAQMDCAsYAwsJCAcMA?=
 =?us-ascii?q?TwMBwokBAQMKgEGDhQFBCUZZwcHAo1oI4JAAYENgimBUQEBAaROoCFJHgkBB?=
 =?us-ascii?q?gJggWeBChUKL5tfhXwaM5dTkxkumFojkXCSR4Q+AgoHBxEkEoEyOoFcMxojg?=
 =?us-ascii?q?QFtgUlQAxkPjl+DRMwVNTU+AQcCBw8CgXODdokqgSCBK0mBTAEB?=
IronPort-PHdr: A9a23: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
 X+EqntB30d7bodwK/CJYqVOyVdUi+SFuSr6jogM
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:agcDXalGzvw1rp61uDy3BXTq5OTpDfII3DAbv31ZSRFFG/FwWf
 re+cjzsiWE9Qr5PUtLpTnuAtjmfZqxz+8X3WBVB8bbYOCEghrTEGgB1/qF/9SIIUSXnY5gPO
 VbAtND4bXLbGSS5vyKhDVQfexQouWvweSHgaPxwR5WIj2CqJsN0+66MGum+zVNNXB77FMCeq
 ah2g==
X-Talos-CUID: =?us-ascii?q?9a23=3AV9bbu2u8QiibxFw9IQPF45Do6It0XTr89XnqCna?=
 =?us-ascii?q?6Sm1zF7+uRVmbpp9Nxp8=3D?=
X-Talos-MUID: 9a23:mQybngSFN2CZZ0PkRXTRmxdSF95t+52PBWE/rYUZ4PfYMBNZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,181,1779141600"; 
   d="scan'208";a="287667083"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDFBbgZIUpjbswXtf6ijWwJEtWxb9b81EZhEBH?=
 =?us-ascii?q?Nl5birbzLKolobfhiePeC+87hWd896psKV9ICgnFGv8swA6NJuFAk5Dh?=
 =?us-ascii?q?TTIqM8FnVUDYdvWKwEuocX02WC9moY96GAmgYnlZOyJOWoHbcnCq4aT3?=
 =?us-ascii?q?ozI9RqsbZy4UOD0+Ut6JCeUA=3D=3D?=
Received: from mail-pj1-f41.google.com ([209.85.216.41])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 20:47:15 +0200
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-383cb94f742so1021822a91.3
        for <cocci@inria.fr>; Thu, 23 Jul 2026 11:47:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784832434; x=1785437234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=F+UjJ2nGjxXWT2RhAQzqOjO+SrT+lpfkp3b16ZbPdls=;
        b=JQEMNeaK3gvAvq29BOxlCxzDUeoRuviUstME/pZ2CaiyEq2/wCw65Lygq4cvWVdTtr
         pkkQh6EtcprLxUTyiV11e9WL9jl1fppPrvyYKmiFhiuV1gT49hEmCM/FtT6E28DGpZHX
         gwpjJIh5QjHcbIYBEhP8hsNEDMsD1T/Fbg1IaL3hSVb0MUawe9ThzKyAQXoXK3ipwjLV
         CZSJMGiA6PELlaPVJCQUT8Ft/DUa99d+nZwbR2FcQAPyZ4W17aRPZalWXkNxpU8SEjlh
         99ipp1OAsbqXPV2FunZdDualLkyCr4le/Lp+iFih0ckG2u95CYFUOgr5WMaTrT0TSHJv
         d/Sw==
X-Gm-Message-State: AOJu0Yxlk5iy5QNYMKMR1Qk7CXhgGJ0vQ/NlJTrWuFjrdF4Q5Eve1o1e
	KLnPn2aAqeQt14ei8q0n4HWfi6dg63nHfb/AY9a3V4/nDBnYbLNm7UnZ
X-Gm-Gg: AR+sD10h172ClPwN9aCT8ir5Wnep3JytxAQ7QD7Du6dy7fM/OtcxY2M7bN3MG+AdRgo
	D8qPJV912km9kYOWEnq95ABEx6zSMwCI8egun8LFMag9INsHJ6z2qTNILwojdkOO3RXCauHsSd4
	571hAQ2YayUUCB6evQnLa45iRXAtkvq7MD8jTogdUldOmk7KAh8B/eQPovHKRaxwAtdTc5199bs
	GSvqQvCy80rzF/QAUalUZcw2IpnIVke3fgjAB8DlRDD74t13Y52gISfY9Lqdff7kXZdoZmdfFXa
	N4jRjjM7EefTVwAUZM1XJyCpPsxsscHAZOwsWTisCFBoistMe0GTKmo5Syl1FQwc4HBg85plwQA
	VxqimZN5YBWO85BrJoWilwN5Yx+cnMobZojoF/MLPM8vXllHTrgnsce8i+AVKpCfRBVQfP3Lv
X-Received: by 2002:a17:90b:3ccf:b0:37f:fda5:8d9a with SMTP id 98e67ed59e1d1-38ec6a5115dmr4286424a91.25.1784832434078;
        Thu, 23 Jul 2026 11:47:14 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f03af8a45sm308155a91.10.2026.07.23.11.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 11:47:13 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Julia.Lawall@inria.fr,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: cocci@inria.fr,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Lukasz Luba <lukasz.luba@arm.com>,
	Zhang Rui <rui.zhang@intel.com>
Date: Fri, 24 Jul 2026 03:45:33 +0900
Message-ID: <20260723184538.3888637-32-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723184538.3888637-1-ekffu200098@gmail.com>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH 31/36] thermal/drivers/k3_bandgap: remove
 conditional return with no effect
Reply-To: Sang-Heon Jeon <ekffu200098@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3627
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/HZ4beRe3tqPAMwRa1rWYpQ>

Both branches of the check return the same value, so the check has
no effect. Remove it and return the value directly.

This is the result of running the Coccinelle script from
scripts/coccinelle/misc/cond_return_no_effect.cocci.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 drivers/thermal/k3_bandgap.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/thermal/k3_bandgap.c b/drivers/thermal/k3_bandgap.c
index 678d6ed711b5..766fab7bcf1b 100644
--- a/drivers/thermal/k3_bandgap.c
+++ b/drivers/thermal/k3_bandgap.c
@@ -141,13 +141,8 @@ static int k3_bgp_read_temp(struct k3_thermal_data *devdata,
 static int k3_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
 	struct k3_thermal_data *data = thermal_zone_device_priv(tz);
-	int ret = 0;
 
-	ret = k3_bgp_read_temp(data, temp);
-	if (ret)
-		return ret;
-
-	return ret;
+	return k3_bgp_read_temp(data, temp);
 }
 
 static const struct thermal_zone_device_ops k3_of_thermal_ops = {
-- 
2.43.0

