Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1C75C7EE23
	for <cocci@archiver.kernel.org>; Tue, 30 May 2023 07:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=ggSXz9APR7T4eEiVeW1/uNBmXHsKECBIohW3aczusXE=;
  b=KoN3dJW2tHX//3YAJuil3Ix4WS+jec+37Dud3IbDHI5BkFX5nDxv8XEY
   NvFbENe74TwXIMw5Soapar3NHWP1XP9qBKFJLYRx78Rk6ByKhYbMvIdub
   2LIzDAo2Kp9049Lms0OZRdT4ffksq08FqzGHRCfvAvTIqJV64WFxqY770
   U=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@microchip.com
X-IronPort-AV: E=Sophos;i="6.00,203,1681164000"; 
   d="scan'208";a="110201489"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 May 2023 09:53:53 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9584DE2697; Tue, 30 May 2023 09:53:53 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id B14C3E0090
	for <cocci@sympa.inria.fr>; Tue, 30 May 2023 09:41:11 +0200 (CEST)
IronPort-SDR: 6475a896_AqppCojMMQI4DusA+6vS7P9di9IaQv6da2ZkvAL1jD0iDKJ
 3B0ba547o8yoPuGTBRK3bd5veRW7qgJxKYTWlrw==
X-IPAS-Result: =?us-ascii?q?A0GMAgBkp3Vkh+mZ6ERaHgEBCxIMggQLgi+BSzAHT7JNg?=
 =?us-ascii?q?SyBQD4PAQMBDAFEBAEBAwSEf4VfAh4GAQQwCQ4BAgQBAQEBAwIDAQEBAQEBA?=
 =?us-ascii?q?wEBBQEBAQIBAQIEBQECEAEBAQEiFwcQDieFaA2CNyJ9Sj4BAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQ8CCF4BIRYgAQ0BATcBgT0BDQUiglyCXQOgPQGBK?=
 =?us-ascii?q?z4CKAFAAQyBCos7GgJlgggBAQaCZZprgV8JCQGBOIwUV4N5gSEPgVVEgRWDa?=
 =?us-ascii?q?YsGjj+NJIEvcIEhPWqBAgIJAhFngQ4IZoF0QAINVQsLZYEjglkCAhE+FE1iG?=
 =?us-ascii?q?g4BEQMHBAKBBxAvBwQyKAYJGDEnBlYHFxYkCRMVQgSDbAMKgSM1NwMJAwcFL?=
 =?us-ascii?q?B1AAwsYDUsRLDUUHwYmIIEJGGMEggIoJJ87BwGBDTWmR590NQeEC4FXBgyfF?=
 =?us-ascii?q?k2Df5M8A5IRAZgOIIIvoQuELwIEAgQFAhaBYzqBXDMaI1CCZ08DGQ+OIBmDW?=
 =?us-ascii?q?498PjQ7AgcLAQEDCYtGAQE?=
IronPort-PHdr: A9a23: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
 raprnla3AljbcZzLqvVdvMh8w==
IronPort-Data: A9a23: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
 QAIeIyPfK13pYMd3yqtl7651Sz1ZA/S8gg=
IronPort-HdrOrdr: A9a23:/uT/SqGP7Wjq7zGSpLqFXpHXdLJyesId70hD6qkvc3Jom52j+P
 xGws526fatskdsZJhBo7q90dq7MAzhHPlOkMQs1NaZLUPbUQ6TTb2KgrGSugEJlUfFh5ZgPM
 tbAspD4ZjLfCVHZKXBkUWF+rQbsaK6GcmT7I+0rwYPcegpUdAb0+4TMHf+LqQCfnghOXNPLu
 v62iMonUvERZ0QVKmGL0hAe9KGi8zAlZrgbxJDLQUg8hOygTSh76O/OwSE3z8FOgk/j4sKwC
 zgqUjU96+ju/a0xlv3zGnI9albn9Pn159qGNGMsM4IMT/h4zzYJbiJGofy/AzdktvfqmrCo+
 O85ivI+P4Dr085S1vF4icFHTOQlwrGpUWSj2NwykGT3/ARDAhKevapw7gpPScwLyEbzYlBOG
 Uh5RPBi7NHSRzHhyjz/N7OSlVjkVe1u2MrlaoJg2VYSpZ2Us4ZkWUzxjIjLH47JlON1Kk3VO
 11SM3M7vdfdl2XK3jfo2l02dSpGnA+BA2PTEQOstGcl2E+pgEz82IIgMgE2nsQ/pM0TJdJo+
 zCL6RzjblLCssbd7h0CusNSda+TmbNXRXPOmSPJkmPLtBOB1vd75rspLkl7uCjf5IFiJM0hZ
 TaSVtd8XU/fkr/YPf+qKGjMiq9NVlVcQ6duP22vaIJyoEUbICbQhG+dA==
X-Talos-CUID: 9a23:gn9a6GBt6A/PY5L6EzBFxFZIH/A/SXzQ8FGAIkWfEnlLa6LAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3Ax1DJGA0Y3sZ3EVTcJHZxaIB5kjUj4qXwKE4msrY?=
 =?us-ascii?q?9otjcbg16PzSHtSSWTdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.00,203,1681164000"; 
   d="scan'208";a="57297881"
X-MGA-submission: =?us-ascii?q?MDGP5O4AMQJJLDFxrn+YlrUX09+PhZrH+hq4Zr?=
 =?us-ascii?q?tISOVb8fZkxJuum2ESzYWrFCL/GOQ9dHiVEeq8mf5ZQXOMVC1vOle2J6?=
 =?us-ascii?q?OP77UYul5IsMmugK34jDiI3iLqY08Byl3svTwAerz1qSb5OSvhGD4mpX?=
 =?us-ascii?q?SpeV7B9S8ki7BYdm7JHj2ruQ=3D=3D?=
Received: from esa.microchip.iphmx.com ([68.232.153.233])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 09:41:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685432471; x=1716968471;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=abTEt8MT54+VSoQvOPiB4OxGZUy2+4IKzxvnOb4KoPk=;
  b=GQ/XD114iPsKq/7FwHiRWDCDIN5etvNAXvj9o6TLn4L2PDimpxCH2oa1
   IAKoxcdBE7O++7G6PqF/u+9+YULJx/y8NvT79/HMnNVyqlDfEXQYXqckO
   wLGBpJAPhL4XwIx8QknPGK69txf07bdNZzEII5+iNROqrutQ9aODO5PcQ
   CoSBx3CA9kyBFjfTMVRJAxEibt5r5REGrtvH1/NeDb3o1y6DMkJFHCCo+
   r6rwpxX5uVNZczhc1cstFUFjq/Ty2kaqDvR7Zs7ZH+nyazoZXBnsdyn9i
   q2EcSCojdw40SlgvTfroXWWq4ros1tDDn3OCPMWWM2Aalm2/UUKvuud2d
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="215991659"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 May 2023 00:41:08 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 30 May 2023 00:41:06 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Tue, 30 May 2023 00:41:04 -0700
From: Claudiu Beznea <claudiu.beznea@microchip.com>
To: <Julia.Lawall@inria.fr>, <nicolas.palix@imag.fr>
CC: <cocci@inria.fr>, <linux-kernel@vger.kernel.org>, Claudiu Beznea
	<claudiu.beznea@microchip.com>
Date: Tue, 30 May 2023 10:40:44 +0300
Message-ID: <20230530074044.1603426-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH] Coccinelle: kmerr: increase check list
Reply-To: Claudiu Beznea <claudiu.beznea@microchip.com>
X-Loop: cocci@inria.fr
X-Sequence: 1160
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-05/20230530074044.1603426-1-claudiu.beznea%40microchip.com>

There are other functions allocating memory who's return value could
be NULL in case allocation fails. Update the list with these.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 scripts/coccinelle/null/kmerr.cocci | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/coccinelle/null/kmerr.cocci b/scripts/coccinelle/null/kmerr.cocci
index 68db20de62eb..db1387f1938a 100644
--- a/scripts/coccinelle/null/kmerr.cocci
+++ b/scripts/coccinelle/null/kmerr.cocci
@@ -35,7 +35,7 @@ position any withtest.p;
 identifier f;
 @@
 
-*x@p1 = \(kmalloc\|kzalloc\|kcalloc\)(...);
+*x@p1 = \(kmalloc\|devm_kmalloc\|kmalloc_array\|devm_kmalloc_array\|krealloc_array\|kzalloc\|devm_kzalloc\|kcalloc\|devm_kcalloc\|kasprintf\|devm_kasprintf\|kstrdup\|kstrdup_const\)(...);
 ...
 *x1@p = f(...);
 if (!x1) S
@@ -51,7 +51,7 @@ position any withtest.p;
 identifier f;
 @@
 
-x@p1 = \(kmalloc\|kzalloc\|kcalloc\)(...);
+x@p1 = \(kmalloc\|devm_kmalloc\|kmalloc_array\|devm_kmalloc_array\|krealloc_array\|kzalloc\|devm_kzalloc\|kcalloc\|devm_kcalloc\|kasprintf\|devm_kasprintf\|kstrdup\|kstrdup_const\)(...);
 ...
 x1@p = f@p2(...);
 if (!x1) S
-- 
2.34.1

