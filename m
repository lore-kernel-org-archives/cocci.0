Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DE34C5DF9D
	for <cocci@archiver.kernel.org>; Mon, 24 Aug 2026 07:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=n1w9QX5xdwi74QKa5z7EDP4Mx2bk9XoiF8oMMpJexfM=;
  b=MG/oDzdOOPezJvgPXXZ5F36dy60IK/3Qqwy3Zfc3+uWRKhvK1EouCqAi
   SoEZ/RMe/J1HfTU+OaYOg8C7yfV6NCQkYV1SQ79LeGahObjtlCQiVKJDh
   rceZQQsngjv7Z1ztCGoNr2DhXaEE2ZXRSLS8p47VfPQJFKFJYJemrCNXz
   g=;
X-CSE-ConnectionGUID: Cu6UQ5CJSd+SPc96LtEsuQ==
X-CSE-MsgGUID: bPkyvXRnSxm6H36R1z6r3w==
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
   d="scan'208";a="291206949"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Aug 2026 09:35:09 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 8B72281696; Mon, 24 Aug 2026 09:35:09 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 7FAF880527
	for <cocci@sympa.inria.fr>; Sun, 23 Aug 2026 18:18:37 +0200 (CEST)
X-CSE-ConnectionGUID: Xqhjfzt1SaecPMLJGQdrDA==
X-CSE-MsgGUID: BAODUo7NSE6LzrKvH3aZyQ==
IronPort-SDR: 6a8b1d5d_5ZZ6wxCocEaporsOMbQnVftRooD3dAIGvG8CSbJ5WpriKNS
 4NRNKRYlB6C6J9QKPhoXKPyHgVyB+BPJEKre26Q==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0H/BwCUG4tqgbXSVdFaglkCgj+BaTMEVJUHBopvghkwA?=
 =?us-ascii?q?odTA4pMFIErPQIPAQMBCwEBTwIEAQEBAgQ6hESNbwIeBwEEMAkOAQIEAwIDA?=
 =?us-ascii?q?QEBAQEBAQEBAQELAQEBBAEBAQIBAQIEAwEBAQECEAEBIhkHDjuGTw1JARABB?=
 =?us-ascii?q?AEBggEBgSRhAgUDOwEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQUCLGE2AQ0BGx0BAxIQXREBBQEiAYMUgiMBBhABAzcCAbE8jQYFAhaBA?=
 =?us-ascii?q?YINBoJq2AAKGSgNdYFmAgcJAQsBgTcBhHcqXQOHX3aEAoEhgRiBEIR+hCkvh?=
 =?us-ascii?q?jAEgxwSgnCQaAEHBx8SCAEcBggCAkgVEgMEAwQEAQILEwkDAwIOAggDAggGG?=
 =?us-ascii?q?QE/EgQTAggDBgQLBwUfCgIMFAooIhIrCgMqCxIPAw0GBRUBCAYCAgQEAgQMA?=
 =?us-ascii?q?gkCAgUDBAIEDQMEAQEIAgItAwEDGQgJCAILBREYDAsHMQMQCQMfAxQcCEUIB?=
 =?us-ascii?q?hYBGgYFBgs3FQUMEQECGwIgBB0RCAMBGwQCAQkDAQMBFQQCFAodAgYIDBcCA?=
 =?us-ascii?q?gIGAgMDAwoBAggDAwMCAxkHBgMEBAEEBAMDAgMFAQMDAwUCAgoGCQEBAQEDA?=
 =?us-ascii?q?gIIAwcDCgkCBQMbAxsFAQICAwIBAggDBwgDDQMEAgMDAwQBAgIBAQECAwEDA?=
 =?us-ascii?q?wQDAQMDAgEDBwICAwMDCwECAwMFAwMFBQICBQUDBQICCgIDAwMCAQMCHAgDB?=
 =?us-ascii?q?gMSARADAwYBAwcDBwIEAwkCCAMDCAgDFwMDBQECAgQDAwgIBAMDBAICAwwFA?=
 =?us-ascii?q?wIDAwUDAwcCBAIEAwMBBQECBwIDBwIBGAMCBAgHBwUCCwQCCAQNCQQCBAICD?=
 =?us-ascii?q?wQGAwMHAQECAQcFBgMCAhABCAoFBgICAhwDHQEDDwYBCQUCAQUOBwUCAhgDB?=
 =?us-ascii?q?gIDBgUBAwEKCwEBAgMKAQIEAgUDAwEDAgMCBgMDAgUFBQMJBwUOCQEDAwYFA?=
 =?us-ascii?q?gIDAgMBAggEBgUDAgIDBQEEAwQDCgMCCAMDCAMLAhoCBQMDAwYJAwcHAgMHA?=
 =?us-ascii?q?wIFAgcFAwMFAwYBAwIBAwMICxUlAwEFAwMCAQMCBQMDGAICBAUDAwMDAwMIB?=
 =?us-ascii?q?AICAQcGBAICAgEFBQUEBQYCBAMIAQEFAwMKDQECBwwDDAYDBwMDBAQDAgUMA?=
 =?us-ascii?q?gIEAQcGBwcJBwMCAwgBAQsEAQMDCgMDBQIBAQcFAwYDBwIDAwMFBAUDAgsDB?=
 =?us-ascii?q?wICAwMDAikBAQEDAwMDAwQDAQMBAwMHAwUDAg4CCAEECQMCBgMHBgMECwkIB?=
 =?us-ascii?q?wwBPAwHCiQEBAwqARQUBQQlGWcHBwKOXR+CTYEPE4IVNYEcAQEBkhqSNKBqH?=
 =?us-ascii?q?gkBBgJhgWeBChUKL6FcGjOEBJNPkxmZCCOCNqIBhD4CCgcHESQSgTI6gVwzG?=
 =?us-ascii?q?iNQMW2BSVADGQ+SI8woNTU9AgcCBw4DC4VeiSqBIIErSYFMAQE?=
IronPort-PHdr: A9a23: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
 Nui9iIZnQ1ka9ExKOrbI68bljBt
IronPort-Data: A9a23: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
 U7Keg==
IronPort-HdrOrdr: A9a23:WRkFDKPV/2cUmMBcTumjsMiBIKoaSvp037Dk7TEVdfUzSL3iqy
 nKpp4mPHDP+VEssR0b6LO90cq7MAvhHPxOkO8s1N6ZNWGM2FdARLsC0WKI+UyFJ8SRzJ8+6Y
 5QN4Z7TPP/ZGIUsS842mWF+hQbreVviJrY/Ns2Bk0CcT1X
X-Talos-CUID: =?us-ascii?q?9a23=3AQaJky2vboY//tN4MsB4wSZJb6IsVa33fwmXMenS?=
 =?us-ascii?q?xBG1RbZm3Zmac4o9Nxp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AGXZkhg9Up9P9DeMWyN+qAj6Qf+1BxIiTDx8rqrh?=
 =?us-ascii?q?Yn9ueFjJQYD6vnQ3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,239,1779141600"; 
   d="scan'208";a="154804241"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDHtWxmwyq/cbOH8yHrqwNLS9SF8pctg8mHPzG?=
 =?us-ascii?q?zgTJoESZ6FiXyaHK5dChSumxm421EbCTaXD2NjuYwBluXvomlsQPbo3H?=
 =?us-ascii?q?c4lH/A39AmBaE1aWabaQFYlKk3x9YA9+VvIwK2ErNow37NQgArJnHFpS?=
 =?us-ascii?q?lWdBTZuIm2JDu7QuuCAzZ9OQ=3D=3D?=
Received: from mail-pf1-f181.google.com ([209.85.210.181])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2026 18:18:36 +0200
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8486672f03cso2672587b3a.0
        for <cocci@inria.fr>; Sun, 23 Aug 2026 09:18:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787501915; x=1788106715;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n1w9QX5xdwi74QKa5z7EDP4Mx2bk9XoiF8oMMpJexfM=;
        b=NphlyGSlq7IoQO1fAUqAuhCrwD9Idyhf5lzdpZAzixJLblb6LBOK+MYv8yAGRLkdYc
         dIxdHZHLOx3AuG3dTwPpMTjZQ0+k97VpDyl0Q4mBt8t+vs7caVBOBIsfpbH0ykFkt2tu
         x/iWxPCHg//nA0QYV+8jGX7kUE8l73ReOajhOKTIat+ru+0iVbqWMiJjrr8zm05E9hn1
         cAbVezXX5YUrlB4QRAQ696oEUcOqHstCt5kR/6+MN9wetoBGudH86jV0vKZEQmcsqdSH
         cLGwHGdCspJ1GduxUk1JpBfZrTuMqUPp5/5CYo6Q/5V0WFqPXGNyP7k1EXlM0R8dSBmR
         CqOw==
X-Gm-Message-State: AFuF++m982Ev1LFWhi0O46aFn/9Q65CyCuHz0wyyY+/GJBcWHEM5k61I
	HhBON941hNKhqOesF1OVA1L6AMWcyg+N82MJs4wd9asTef/kX14Sd3uto8XGog==
X-Gm-Gg: AR+sD10nsCByB1Q1kY6KuofBbkIcdoTDf4jmuY4mS2SPlxt39S/Bpi8lp+J9/DpxNh7
	YGsEwJe1mGgiMDAN7PrX2z54BZonFer6NUGqeFfHQF4ETnj165HJTQBfxkKrqJK/XeKF0gz4rfV
	wqitINp2fDEMyuVgUD0RGzTIWB9fC2CSvhQOlk9Wq19rsXzNf2rRl2VHk2obeiDCGelTN7i7q/Y
	n9dLx3AwKgnSfRHuPp2s4L2AFsmwq+2yRTgcevPWaJn6oS7r5TjlwVDwLaD8DLqVqhYqVG6RY01
	mqRqyDXLcz042CNC/In8OLNL4lOjiUDVqEjMi6Pj64pcaNLzcl3BxWes2C76DP9VxV66gfYU9lM
	e7+b5giv33/ty7+bleZP08oR7atmRpVn6vEkagtv6Cg8mDU0miRQK4ct5vWKk7S0NR3Tynn/E0J
	1LzGhcRd+zBqReDB6WE0f7f6IS02+P/G9/0jni7e7zd9UuC1ZY2H78nV8=
X-Received: by 2002:a05:6a00:2e0f:b0:842:7296:dba with SMTP id d2e1a72fcca58-8520b983fdbmr18504990b3a.7.1787501914865;
        Sun, 23 Aug 2026 09:18:34 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc199dafa1fsm350181a12.3.2026.08.23.09.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 09:18:34 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>
Cc: cocci@inria.fr,
	linux-kernel@vger.kernel.org
Date: Mon, 24 Aug 2026 01:18:12 +0900
Message-ID: <20260823161826.3805598-1-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH 0/7] coccinelle: fix rules that match outdated
 function names
Reply-To: Sang-Heon Jeon <ekffu200098@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3700
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-08/ieZPB5whm8ZCg1V5n8UGCg>

Several scripts still list functions that no longer exist in the tree,
so those rules can never match.

Patches 1-6 remove those functions from the scripts.

Patch 7 replaces dev_put_track() and dev_hold_track() with
netdev_put() and netdev_hold(). I will send separate patches for the
two new reports.

Sang-Heon Jeon (7):
  coccinelle: remove obsolete pci_free_consistent.cocci
  coccinelle: alloc_cast: drop removed allocators
  coccinelle: zalloc-simple: drop the kmem_alloc rules
  coccinelle: pool_zalloc-simple: drop the pci_pool_alloc rules
  coccinelle: kfree_mismatch: drop vmalloc_exec
  coccinelle: atomic_as_refcounter: drop atomic_long_dec_and_lock
  coccinelle: ifnulldev_put: update outdated helper names

 scripts/coccinelle/api/alloc/alloc_cast.cocci | 20 +++----
 .../api/alloc/pool_zalloc-simple.cocci        | 17 ++----
 .../coccinelle/api/alloc/zalloc-simple.cocci  | 41 +-------------
 .../coccinelle/api/atomic_as_refcounter.cocci |  4 --
 scripts/coccinelle/api/kfree_mismatch.cocci   | 12 ++---
 scripts/coccinelle/free/ifnulldev_put.cocci   |  8 +--
 .../coccinelle/free/pci_free_consistent.cocci | 53 -------------------
 7 files changed, 22 insertions(+), 133 deletions(-)
 delete mode 100644 scripts/coccinelle/free/pci_free_consistent.cocci

-- 
2.43.0

