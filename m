Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E850BC5DF9D
	for <cocci@archiver.kernel.org>; Mon, 24 Aug 2026 07:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=sQBhcy1nAyOUrB8VId64+rB9Yq/ylsxAkfkW9H1DeUs=;
  b=a7OS0r9STEvBB5I7Dwy5ypDcGxFSl4g2up7NpmNBO+ZApUAquI4/SFY4
   5puw0z391mrhfc9NyXfjJBFTmTT3bzIkbeGXw0+86tSw4fUDKs5DGQyPJ
   lb8nGg8bnem2ICqrzBaXybKrQp4umudhLNF2+FVlS7sT5QlH7MKzhS5CL
   M=;
X-CSE-ConnectionGUID: nvsNyzpbQK2UxAViO4FOwA==
X-CSE-MsgGUID: kHL2ubMCRSqHszdv9xOnyQ==
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
   d="scan'208";a="291207064"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Aug 2026 09:35:14 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 6E32F81684; Mon, 24 Aug 2026 09:35:14 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 7494D80E6D
	for <cocci@sympa.inria.fr>; Sun, 23 Aug 2026 18:18:43 +0200 (CEST)
X-CSE-ConnectionGUID: uXLXwfChRACNTMqxv6maIw==
X-CSE-MsgGUID: TyHtjVwzT3qdfhX1Csm/bA==
IronPort-SDR: 6a8b1d63_V+CLrGci7HMnm2dOjuWonZt2gjci1/QugOnSwB5QPGV3bka
 XMUjRReW2GYAmERzassNO0/X1gU5n+Z37LykwUg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EvBQCUG4tqfLPSVdFaHgEBCxIMggULAoI/FoFTMwRUl?=
 =?us-ascii?q?QcGim+CGTACkiIUgSs9Ag8BAwELAQFPAgQBAQECBDqERAKNbQIeBwEEMAkOA?=
 =?us-ascii?q?QIEAwIDAQEBAQEBAQEBAQELAQEBBAEBAQIBAQIEAwEBAQECEAEBIhkHDhIph?=
 =?us-ascii?q?k8NSQEQAQQBAYIBAYEkYQIFAzsBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEFAixfAgEDMgENARsdAQMMBhA7IAIRAQUBHAYBEoMCgiMBB?=
 =?us-ascii?q?hABAzcCAbE8jQYFAhaBAYINBoJq2AAKGSgNdYFjAQICBwkBCgEBgTcBhHcqX?=
 =?us-ascii?q?QOCPIUjdoMZaXongRiBEIEVg2mCH4IKL4YwBIIigQyTWAEHBx8SCAEcBggCA?=
 =?us-ascii?q?kgVEgMEAwQEAQILEwkDAwIOAggDAggGGQE/EgQTAggDBgQLBwUfCgIMFAooI?=
 =?us-ascii?q?hIrCgMqCxIPAw0GBRUBCAYCAgQEAgQMAgkCAgUDBAIEDQMEAQEIAgItAwEDG?=
 =?us-ascii?q?QgJCAILBREYDAsHMQMQCQMfAxQcCEUIBhYBGgYFBgs3FQUMEQECGwIgBB0RC?=
 =?us-ascii?q?AMBGwQCAQkDAQMBFQQCFAodAgYIDBcCAgIGAgMDAwoBAggDAwMCAxkHBgMEB?=
 =?us-ascii?q?AEEBAMDAgMFAQMDAwUCAgoGCQEBAQEDAgIIAwcDCgkCBQMbAxsFAQICAwIBA?=
 =?us-ascii?q?ggDBwgDDQMEAgMDAwQBAgIBAQECAwEDAwQDAQMDAgEDBwICAwMDCwECAwMFA?=
 =?us-ascii?q?wMFBQICBQUDBQICCgIDAwMCAQMCHAgDBgMSARADAwYBAwcDBwIEAwkCCAMDC?=
 =?us-ascii?q?AgDFwMDBQECAgQDAwgIBAMDBAICAwwFAwIDAwUDAwcCBAIEAwMBBQECBwIDB?=
 =?us-ascii?q?wIBGAMCBAgHBwUCCwQCCAQNCQQCBAICDwQGAwMHAQECAQcFBgMCAhABCAoFB?=
 =?us-ascii?q?gICAhwDHQEDDwYBCQUCAQUOBwUCAhgDBgIDBgUBAwEKCwEBAgMKAQIEAgUDA?=
 =?us-ascii?q?wEDAgMCBgMDAgUFBQMJBwUOCQEDAwYFAgIDAgMBAggEBgUDAgIDBQEEAwQDC?=
 =?us-ascii?q?gMCCAMDCAMLAhoCBQMDAwYJAwcHAgMHAwIFAgcFAwMFAwYBAwIBAwMICxUlA?=
 =?us-ascii?q?wEFAwMCAQMCBQMDGAICBAUDAwMDAwMIBAICAQcGBAICAgEFBQUEBQYCBAMIA?=
 =?us-ascii?q?QEFAwMKDQECBwwDDAYDBwMDBAQDAgUMAgIEAQcGBwcJBwMCAwgBAQsEAQMDC?=
 =?us-ascii?q?gMDBQIBAQcFAwYDBwIDAwMFBAUDAgsDBwICAwMDAikBAQEDAwMDAwQDAQMBA?=
 =?us-ascii?q?wMHAwUDAg4CCAEECQMCBgMHBgMECwkIBwwBPAwHCiQEBAwqARQUBQQlGWcHB?=
 =?us-ascii?q?wKOXR+CTAGBDoN6AQEBkhqSNIt7lCZJHgkBBgJhgWeBChUKL5tghXwaM5dTk?=
 =?us-ascii?q?xkumFojkXCSEDeEPgIKBwcRJBKBMjqBXDMaI4EBbYFJUAMZD44hhALMKDU1P?=
 =?us-ascii?q?QIHAgcOAwuFXokqgSCBK0mBTAEB?=
IronPort-PHdr: A9a23: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
 Mz1x5ql8w1mZd8xY6fXIfgRpmU=
IronPort-Data: A9a23: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
 avLelaw
IronPort-HdrOrdr: A9a23:xIkJ3qFA5gxtlYaTpLqEzMeALOsnbusQ8zAXPo5KOHlom6uj5r
 2TdZEgvyMc5wxhP03I9erwW5VoBEmsjaKdgrNhR4tKPjOW3ldARbsKheCD/9SjIVyEygc078
 ZdmsNFebnN5DZB/KTHyTj9PdJl7tfvys+VbCTlo0uFjzsGV0gZ1XYBNu9TKCNLeDU=
X-Talos-CUID: 9a23:fB2da24t9yTqTCeDEtss6X4wKt8rWX3n5Vz2H2qhGXg3TbS0VgrF
X-Talos-MUID: =?us-ascii?q?9a23=3AcaQ+8g6jiXHol6IdRdB7KWl+xoxU8oSyCn4Sg6l?=
 =?us-ascii?q?dosWKNRwpECyYyz6eF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,239,1779141600"; 
   d="scan'208";a="154804248"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDHU5sKTV4e8+xjEtm0ZYRzLC65GtwILnRDwKO?=
 =?us-ascii?q?GFbb8bzS76uygDU6sDTZHUrCj8vK+C4QtZsbLlVSGjUEW+YWh/eni9td?=
 =?us-ascii?q?iLd6/tQvNVrE3JZj509SfYaGmRQKDzmJ6NRgAIbAp7XBME24q5Xc7c8a?=
 =?us-ascii?q?p+sNOuvOZPLszHZyf6oLUeSA=3D=3D?=
Received: from mail-pf1-f179.google.com ([209.85.210.179])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2026 18:18:42 +0200
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84862b0d5aeso1909619b3a.2
        for <cocci@inria.fr>; Sun, 23 Aug 2026 09:18:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787501921; x=1788106721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sQBhcy1nAyOUrB8VId64+rB9Yq/ylsxAkfkW9H1DeUs=;
        b=dcIp4Rg7w6bwbX6nRh3La/psuXw9E2/QiEs8oVQcLWj7WEkFQFW4BbuwiVblYnipY/
         SDZ4BP4tTn0Eo/53pFLhR49KzySB1y08GDVygXuEna3UTwSoaphYJu3j/u2nAU1bjNQ3
         +W/iD8gaXAO683OSd0dqn+oDoZsB83MUbzB8qWHuA5olfChja8T03pU7JEFQDQo5EZNJ
         Cn50S7Q0OwcjpYRHRmHTIJcspoG/mf4EfLYNCrCp/7t9Gj7OrfJcTLdaREwxJxtvVe3l
         GstUI3UjNKzxZqR334i/c/DeZTTyptMHrf9JkMr1ioxX5wnSFXM6WtJPeoHQvVF1vRU6
         /YNg==
X-Gm-Message-State: AFuF++k9m4S1Ia5pwtcpWLTOkW/pUv7G9nDIsA6K4dY7sJInWyhethqn
	qsQCucsErEbvbXhEZSaBi1mj0WLh/fdHCyxY0+2dXdN9nXYI40fk00hj
X-Gm-Gg: AR+sD131+v4XeRpg1au2q9ylhpC/mADmQoOZQtNpY/l+BpJbU3LEXTzp0sDaQ4b988x
	1mmy/lrOngwcVGmVlujAEgc7LXN2Iw7J6aNp6Db8NpLucYumyn4WE9eV3KZZ3kscq/J50O6faPg
	KkK3cOtgGiOzxPininm4TAfLfxRuX4HoEei1N5eHb51knAQ1wgKY6gt0CBNn12oYNjVnkV6ATuq
	/hAJMklxK0oShZCY9+1TCPNoGl+Lz7mHOBnt9gHmViw9sVzJ65OY8vk7ZjH3JgmyKW/+0CsTciL
	aqhOvV6aJiozrsqx0L/9mqqhVZXVgOCz4ypvIshveXG7YZTbaXdE6MvcBp0yfgUHWAEYdXJhrYU
	O39SN1Yn1emk9UPqLKB0vpDmr6rPJR/F2ZAxMECoBeTp4hzd5Q6dRKapp1A9/kLWBYzGQveLQal
	AgDXKq5/1euOzh403ymyy1RZxYzj1oNcJ/0Nl2/FOcdDmk9XYZhU0LH3Q=
X-Received: by 2002:a05:6a21:4c06:b0:3c4:3112:3b with SMTP id adf61e73a8af0-3cd3021b509mr39128079637.18.1787501920898;
        Sun, 23 Aug 2026 09:18:40 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc199dafa1fsm350181a12.3.2026.08.23.09.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 09:18:40 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>
Cc: cocci@inria.fr,
	linux-kernel@vger.kernel.org
Date: Mon, 24 Aug 2026 01:18:15 +0900
Message-ID: <20260823161826.3805598-4-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260823161826.3805598-1-ekffu200098@gmail.com>
References: <20260823161826.3805598-1-ekffu200098@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH 3/7] coccinelle: zalloc-simple: drop the kmem_alloc
 rules
Reply-To: Sang-Heon Jeon <ekffu200098@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3703
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-08/3yqclh0DDWy4j11fZ0jYFQ>

- kmem_alloc() was removed by commit f078d4ea8276
  ("xfs: convert kmem_alloc() to kmalloc()")

- kmem_zalloc() was removed by commit 10634530f7ba
  ("xfs: convert kmem_zalloc() to kzalloc()")

So drop the kmem_alloc rules.

No functional change.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 .../coccinelle/api/alloc/zalloc-simple.cocci  | 41 +------------------
 1 file changed, 1 insertion(+), 40 deletions(-)

diff --git a/scripts/coccinelle/api/alloc/zalloc-simple.cocci b/scripts/coccinelle/api/alloc/zalloc-simple.cocci
index d66c45356691..ae1d39e71e31 100644
--- a/scripts/coccinelle/api/alloc/zalloc-simple.cocci
+++ b/scripts/coccinelle/api/alloc/zalloc-simple.cocci
@@ -35,7 +35,7 @@ statement S;
 @@
 
 * x = (T)\(kmalloc(E1, ...)\|vmalloc(E1)\|dma_alloc_coherent(...,E1,...)\|
-  kmalloc_node(E1, ...)\|kmem_cache_alloc(...)\|kmem_alloc(E1, ...)\|
+  kmalloc_node(E1, ...)\|kmem_cache_alloc(...)\|
   devm_kmalloc(...,E1,...)\|kvmalloc(E1, ...)\|kvmalloc_node(E1,...)\);
   if ((x==NULL) || ...) S
 * memset((T2)x,0,E1);
@@ -88,15 +88,6 @@ statement S;
 - x = (T)kmem_cache_alloc(E3,E4);
 + x = (T)kmem_cache_zalloc(E3,E4);
 |
-- x = kmem_alloc(E1,E2);
-+ x = kmem_zalloc(E1,E2);
-|
-- x = (T *)kmem_alloc(E1,E2);
-+ x = kmem_zalloc(E1,E2);
-|
-- x = (T)kmem_alloc(E1,E2);
-+ x = (T)kmem_zalloc(E1,E2);
-|
 - x = devm_kmalloc(E2,E1,E3);
 + x = devm_kzalloc(E2,E1,E3);
 |
@@ -290,36 +281,6 @@ x << r4.x;
 msg="WARNING: kmem_cache_zalloc should be used for %s, instead of kmem_cache_alloc/memset" % (x)
 coccilib.report.print_report(p[0], msg)
 
-//-----------------------------------------------------------------
-@r5 depends on org || report@
-type T, T2;
-expression x;
-expression E1,E2;
-statement S;
-position p;
-@@
-
- x = (T)kmem_alloc@p(E1,E2);
- if ((x==NULL) || ...) S
- memset((T2)x,0,E1);
-
-@script:python depends on org@
-p << r5.p;
-x << r5.x;
-@@
-
-msg="%s" % (x)
-msg_safe=msg.replace("[","@(").replace("]",")")
-coccilib.org.print_todo(p[0], msg_safe)
-
-@script:python depends on report@
-p << r5.p;
-x << r5.x;
-@@
-
-msg="WARNING: kmem_zalloc should be used for %s, instead of kmem_alloc/memset" % (x)
-coccilib.report.print_report(p[0], msg)
-
 //-----------------------------------------------------------------
 @r6 depends on org || report@
 type T, T2;
-- 
2.43.0

