Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82E5DC41513
	for <cocci@archiver.kernel.org>; Tue,  1 Aug 2023 09:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=CVpGhAbsOhVUv7mTjVUX7jK45Bup2nh/0H92Fv8cjR4=;
  b=Eet479yjMV1n+36T1fGSdWJzTa18weAHvUczjfsFdDKlk64xnRV1HWHD
   YZ4oosSmQcHqkR8zqpXGa6tqoJaeuUuhFRwMfYrd+oEoqhns8ucXMnJio
   Sg7FmV8R2BwPwrK+DobCTA+6k2fDKFlQXbibUeJQqjVYoXqvyf+0dfkLZ
   8=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.01,246,1684792800"; 
   d="scan'208";a="119796753"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Aug 2023 11:50:08 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C1EF8E013D; Tue,  1 Aug 2023 11:50:07 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 5B3E0E004E
	for <cocci@sympa.inria.fr>; Tue,  1 Aug 2023 11:44:42 +0200 (CEST)
IronPort-SDR: 64c8d3ef_BRVxuNB3tJdQAVfSchM1V278ZWl7+wn48TZCa0Ubv310xpt
 RKJNeNSEr/OjWFT7MCYe8vyiuQF0t5ZneZyMSLA==
X-IPAS-Result: =?us-ascii?q?A0HPAQBy08hkmP/U+S1ahQuBSjEEC0cblhKYIIdYDwEDA?=
 =?us-ascii?q?QwBRAQBAYUGhkkCHQcBBDQTAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECB?=
 =?us-ascii?q?AUBAhABAQEBAQEBAR4ZBQ4QJ4V1gjcig24BRoE+AQ0Fgn6CXQOwLoEBhHauM?=
 =?us-ascii?q?YFogUKIAAGEKFdMhFOCKIJRgi2LBgSJfoVPBQIygjWJTSuBCAhfgW89Ag1UC?=
 =?us-ascii?q?wtjgRiCSQICEToUUFoZGwMHA4EFEC8HBC8kBgkYLyUGUQcXFiQJExVABINOC?=
 =?us-ascii?q?oEEPxUOEYJQYTgbTIJqCRUMNVB4EC4EFBiBFHUfGh49ERIFFA0FCIEBAxoDB?=
 =?us-ascii?q?gIJAgIEBAgCJj8DBQMEGSkDCQMHBSwdQAMLGA1LESw1FBsGQnMHnVOCLQsHA?=
 =?us-ascii?q?XoTg3oBkVyRO4E0nwoGhA+BXZ8kGjOpWQEuh0CQOiCjSIQvAgQCBAUCFoF6I?=
 =?us-ascii?q?4FcTSOBboFJTwMXAg+OOZNhNzI7AgcLAQEDCYozgRUBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:aZhXwK4I83q9FYVOZwPXwPDXdLJyesId70hD6qhwISY7TiX+rb
 HKoB17726RtN9/YhAdcLy7VZVoIkmsl6Kdg7NwAV7KZmCP0wGVxepZg7cKrQeNJ8UjntQtrJ
 uJJMNFebvN5CBB/KXHCV6DYrEd/OU=
X-Talos-CUID: =?us-ascii?q?9a23=3AnlBgZGmjeKGV80gWju3VIhr1KIPXOViHyVrzEkW?=
 =?us-ascii?q?VMmgzRqGeZAet/qg/sMU7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AKWcaYA38Op8vnTxuHG89tIpU+jUj/52vDBA0npU?=
 =?us-ascii?q?/gvK+GQssIiy7qWuee9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.01,246,1684792800"; 
   d="scan'208";a="62770413"
X-MGA-submission: =?us-ascii?q?MDHg8Tkg+3/48gxHrppgraBca1a8xQxfPl/VHA?=
 =?us-ascii?q?1TASeU9KL87t3sGDYVxbO6eIaGKjcjlytFBuqe2648hinSvOx6sbkpk/?=
 =?us-ascii?q?lTnlqrQATQb41mzOYQQQtgGpSx09ybQhzW8F20Bm+O57kgjzqliT5E/x?=
 =?us-ascii?q?JJlJ6iseqCzsjMMRHflclJ2Q=3D=3D?=
Received: from szxga08-in.huawei.com ([45.249.212.255])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 11:44:14 +0200
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.54])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RFVXW1F2pz1GDMP;
	Tue,  1 Aug 2023 17:43:07 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 1 Aug
 2023 17:44:07 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <Julia.Lawall@inria.fr>, <nicolas.palix@imag.fr>
CC: <lizetao1@huawei.com>, <cocci@inria.fr>
Date: Tue, 1 Aug 2023 17:43:37 +0800
Message-ID: <20230801094337.4145806-1-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH -next] coccinelle: platform_get_irq: Add
 dev_err_probe() check
Reply-To: Li Zetao <lizetao1@huawei.com>
X-Loop: cocci@inria.fr
X-Sequence: 1218
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-08/20230801094337.4145806-1-lizetao1%40huawei.com>

After the commit "2043727c2882" and "27446562a1d9", dev_err_probe() will
be called to print error message when get device irq failed, so it is
unnecessary for the caller to print error message. The
platform_get_irq.cocci will check the "dev_err", but not the
"dev_error_probe". Add the inspection of "dev_error_probe" to enhance the
use case.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 scripts/coccinelle/api/platform_get_irq.cocci | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/scripts/coccinelle/api/platform_get_irq.cocci b/scripts/coccinelle/api/platform_get_irq.cocci
index 06b6a95e2bfc..3621411bff92 100644
--- a/scripts/coccinelle/api/platform_get_irq.cocci
+++ b/scripts/coccinelle/api/platform_get_irq.cocci
@@ -21,6 +21,7 @@ platform_get_irq
 platform_get_irq_byname
 )(E, ...);
 
+(
 if ( \( ret < 0 \| ret <= 0 \) )
 {
 (
@@ -34,6 +35,14 @@ if (ret != -EPROBE_DEFER)
 )
 ...
 }
+|
+if ( \( ret < 0 \| ret <= 0 \) )
+(
+*dev_err_probe(...);
+|
+*return dev_err_probe(...);
+)
+)
 
 @depends on patch@
 expression ret;
@@ -47,6 +56,7 @@ platform_get_irq
 platform_get_irq_byname
 )(E, ...);
 
+(
 if ( \( ret < 0 \| ret <= 0 \) )
 {
 (
@@ -60,6 +70,16 @@ if ( \( ret < 0 \| ret <= 0 \) )
 )
 ...
 }
+|
+if ( \( ret < 0 \| ret <= 0 \) )
+(
+-dev_err_probe(...);
++return ret;
+|
+-return dev_err_probe(...);
++return ret;
+)
+)
 
 @r depends on org || report@
 position p1;
@@ -74,6 +94,7 @@ platform_get_irq
 platform_get_irq_byname
 )(E, ...);
 
+(
 if ( \( ret < 0 \| ret <= 0 \) )
 {
 (
@@ -87,6 +108,14 @@ dev_err@p1(...);
 )
 ...
 }
+|
+if ( \( ret < 0 \| ret <= 0 \) )
+(
+dev_err_probe@p1(...);
+|
+return dev_err_probe@p1(...);
+)
+)
 
 @script:python depends on org@
 p1 << r.p1;
-- 
2.34.1

