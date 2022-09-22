Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B8B5C6FA92
	for <cocci@archiver.kernel.org>; Thu, 22 Sep 2022 12:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=03yg6uKIla7xjweiHWlxyRpSUAHoXcniyHLmFG5QRW4=;
  b=WgwKvrXDPFBM0xMBEiB/rYKlI0nBBs2Q1wA4697P72SPjHtqOVF6OvzE
   zqOc38R2WsuwOgaav75mMZRhSIW1df1cxSWosoHRChMua4v4FLbLYV5WE
   7ULHNNFHIW0Mr8DnjArWESvY8tETPfnOZRye60Iqp3n+t0pJmsVLTwptm
   c=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="5.93,335,1654552800"; 
   d="scan'208";a="54036620"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Sep 2022 14:28:27 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 53200E0090; Thu, 22 Sep 2022 14:28:27 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id AEE4BE0090
	for <cocci@sympa.inria.fr>; Thu, 22 Sep 2022 13:58:09 +0200 (CEST)
IronPort-SDR: 632c4dd1_JC8/nTmcpLhsbCwfEfT+fTs4dg4ibx9rz0UDnGA8uj3uD3U
 U7TY8rDNVInMngDtIt1hkWkQtB9RVrSWKkfTUVA==
X-IPAS-Result: =?us-ascii?q?A0ArAABLTSxjh7vU+S1SCB0BAQEBCQESAQUFAYF7CAELA?=
 =?us-ascii?q?YIjgVYvBAtFF4xWiHWXP4VVFIFoCwEDAQwBQgQBAYFTgzIChGwCHQcBBDAJD?=
 =?us-ascii?q?gECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEARMBAQEBGAkXBw4QBSKFd?=
 =?us-ascii?q?YI1IoNsAwMnUhBRVwYBDQWCfYMhA6whM4EBhHCDLYFlgT0BinWDUIFjJxyBS?=
 =?us-ascii?q?USBFYE8giyEBxaGYwSSMIZpOAMJAwcFLB1BAwsfDRY0AxUDFAMFJAcDGQ8jD?=
 =?us-ascii?q?Q0EHQwDAwUlAwICGwcCAgMCBhMFAgIXHhg2CAQIBCskDwUCBy8FBC8CHgQFB?=
 =?us-ascii?q?hEIAhYCBgQEBAQVAhAIAggmFwcTMxkBBVkQCSEWBg4aDQUGEwMgSSYFBz0PK?=
 =?us-ascii?q?DFrKx0bCoEMKgkfFQMEBAMCBhMDAyICECoxFAQpExItBytzCQIDImcFAwMEK?=
 =?us-ascii?q?CwDCSEfBygmPAdYEigFAwMQIj0GAwkDAiQTR3YMLBQUBQMNGSYIBSMBFh0EC?=
 =?us-ascii?q?DwCBQZXEwIKEgOaZoEOAX+BBqF7oHODYoFJDJ5JGjKpBC2HCROPQSCiH1qEJ?=
 =?us-ascii?q?wIEAgQFAhaBYTqBWzMaCBsVgyJOAxcCD445jjdEMTsCBgsBAQMJiVCBEgEB?=
IronPort-PHdr: A9a23:I1BPExIbUfu/09AMSNmcuJBsWUAX0o4c3iYr45Yqw4hDbr6kt8y7e
 hCFvrM21wSCAd+TwskHotKei7rnV20E7MTJm1E5W7sIaSU4j94LlRcrGs+PBB6zBvfraysnA
 JYKDwc9rDm0PkdPBcnxeUDZrGGs4j4OABX/Mhd+KvjoFoLIgMm7ye6/94fdbghGijexbrx/I
 AurpgjNq8cahpdvJLwswRXTuHtIfOpWxWJsJV2Nmhv3+9m98p1+/SlOovwt78FPX7n0cKQ+V
 rxYES8pM3sp683xtBnMVhWA630BWWgLiBVIAgzF7BbnXpfttybxq+Rw1DWGMcDwULs5Xymp4
 aV2Rx/ykCoJNyA3/X/KhMJ+j6xVpxCupxJwzIHIYYGYL+Z+cr/HcN8GX2dNQtpdWipcCY28d
 YsPCO8BMP5aoIngvVQOqwa1CBe2C+Pp1zRFgX/33bAg3OQnDQ7JxgogEskOsHTJttr0OrkdU
 eGvwKbUyjXDaupb1DHg44fHbh4vu+uDXa5sccXP00kvERvIg0mNpILlIT+ZyuUAvmiG4ud8S
 +6ilm8qpgNwrzavwsohi4bEi4YIxlzZ6Sl0w4k4K9KmREB1YdOpDZpduiCZOoZwX8gsQHlot
 T41x7AGo5K3YicHxZA9yxLBdvCLbZKE7g/gWeuTOTt0mW5pdKiiixuw8UWs0PDwWtSq3FpQs
 CZJjtrBu3YQ3BLJ8MeHUOFy/kK51DaPyQ/T7uZELFgvlavaJJ8hzaQ/moYOvUjaHy/2nl/6j
 K+Ldko+9Omn9eXnbq/6qZ+bMo94kgD+MqIwlcyjGek1PQgDU3KF9emz0LDv51P1TKhUgvEsj
 6XUs5LXKdwepqGjAg9V1ogj6wy4DzejyNkZnWQHI0hDeB2blYfpPUrDIPDlDfiljVWjjjZry
 +raMb3mB5XBNn7Dn6z5crZn90Fc0BYzzcxY559MFL0NOOjzVVPptNzEEh85NBS5w+L9B9Rzz
 IweXWaPD7SYMaPTtF+H/fgvLPOWaI8Uvjb9Mfkl6OT0gX83g18RZbOp0ocPaHCkAvRmJF2Ub
 mbrgtgdDWgKvxEzTPfqiV2HST5cfWy+X6M65jEhCYKpF53PRo63gO/J4CDuSr9LYmFPTHSFD
 n7sc62FXe0NYWScOJkl2mgCVLOmT4Y6kwmnsA7q47tiJ+WS9DdO8dq3399+7Oz7lBco9DUyA
 d7LgE+XSGQhr34BQXcd1aY39V1gw1GI2K5Qg+FRCtFSofhOV1FpZtbn0+VmBoWqCUr6ddCTR
 QP+Kj3HKTQ4T9ZqhsQLf144ANK6yBbKwyutBbYR0b2NHp09tKzGjDDqP8go7XHA2eE6ikU+B
 NNVPDi3m6d5/AHVL47UmlqUluChcqFPlDXV+jK7xHGV9FpdTBY2VKzEWX4FYU6DvMnw4EjLS
 ZeuFL04PwoHwsmHeeNRctO8q1JASb/4PcjGJWK8n2DlHRGT2raFd5bnYU0GzjXSARBd1gEVu
 3abPBczB2GqpGe24CVGM1Xpbgus9OB/rCj+VUoo10SRaFUn0bOp+xkTjPjaSvUJ37tCtj1z4
 zNzVE2w2d7bEb/i70JoYblcbNUh4VxGyXORtgpzOYalJrxjgVhWehp+vkfn3RF6Qotals1io
 HQvxQt0YaWWtTEJPyKF1Jb7M7v/KnT74x2uLaXR3xCW0dqb/LsO9OVts0/q70miEksv9Wki0
 sEAjybavMmbSlBLC9SoAhlkknoy76vXaSQ8+Y7OgHhlMK3v9yTHx8psH+w9jBCpY9ZYNqqAU
 g70CcwTQca0e4lI0xCkaAwJOOdK+es6JcSjIrGXxaetN+9mtDK7hHtK4cZ21UfGpE8eAqbYm
 o0Ixf2VxF7NRir1ilyotOj3hIlbaDBUFW26g3usFMtaYat8epwOAGGlLpisx9lwsJXqXmZR6
 F+pA15uNNaBQROJdBS92ARR0R9Sunm7gW6jyCQylTg1r62Z1SiIwuL4dRNBNHQZDGVliF7tJ
 8CzgbV4FAC5cgEvnxKjzUbnzrdWpeJ0KGybTUpTfifwJn1vSePs6/zYP58Jsspy93wHD6y1e
 hiCR6T4ogcG3i+GfSMW3z09ezyw+934kxF8lGOBPSN2pXvdd9t3wESX79jdSPhNmzseEXUlz
 2OLVx7mZoPvpIXLxPKh+qikWmmsV4Nea3zuxIKE726g4HFyRAa4h7a1k8HmFg4z1Wn60cNrX
 GPGtkWZAMGj2qKkPOZgZkQtCkX77p8wC5x3lIA5grkQxHEFi5TT9n0C2zSWU50TyeflYXwBS
 CReic/I6Q7u0UtLLm+A2I/4EH6ax4EyL8n/aWQQ1CUn6slMA6rB971Ikxx+pV+gpB7Qa/xwz
 VJ/gbM+rWQXiOYTtE8x3z2QV/oMSFJAM3WmxFyYqsqzp6JNaCOzfKisgQBgyMu5AujnwEkUW
 W6lKMt/W3Usv4MlaQiKiye765m4KoWNK4hP51vOyk2G1LUdKYptxKZXw3A7aCSn5CdjkbNm6
 H4mlZCi4NrbdiM3oPP/WEcCcGSlOIRJq3nslfoMwpvQhdz+WM84QHNSDcKgTOr0QmtM5bK+Z
 lvIQWZ69ij+e/KXHBfDuh428jSWTM7taCDReSdRzM0+FkDEdQoPxllLDXNgwsFxFxj2lpW4I
 QEpoGBAoAej9FwXk4cKf1H+SjuN/V75LGdyGMnZdUELpgBauxWMaJ3YvqQqQH4epcPm91XFK
 3THNV0RXCdZHBXbWBa4bvHr7N3EuYB0H8KYKP3DKfWLoO1aDLKTwI63l5Bh53CKP9mOOX9rC
 7s63FBCVDZ3AZaRnTJHUCERmy/XCqzT7B6h5i16qNy++/X3SUru44WIEb5bLdRo/Vi/n66CM
 +eagCsxJyxf09sAwnrByb5X21B36Wkmbz62DbEJrjLAVorLiL9YBkZCLiJ1cstV5r0x309GP
 suawtL527hkj+IkXldIUVuy/6PhLccOImy7KBbGHBPXafLceWyNmZitJ/rsFu417q0crRC7t
 DeFHlW2Oz2Ck2KsTBWzKaRXizndOhVCuYa7exIrCG75TdugZAfoVb0/xTAw37AwgWvHcGAGN
 j0pOVJQp7ub5CVwguh2BGFAqHFiKKPX/kTRp/mdMZsQvfZxV25skPlG5X0h17ZPxDpWVPN8w
 HKXr9goo0yvjeSOjDFgVVAdz1QDzJLOtkJkN6LD85BGUnuR5xMB41KbDBESrsdkANni00i14
 tjSnb3+KXFJ9NeGpaP06ODUNcuYPXtnOh3sSme85OotViy7OmiH3glclreS63SKo5l8oZ/py
 sJmdw==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:w4yegKlalulhrGuExX2Da3a84sHpDfIS3DAbv31ZSRFFG/Fxl6
 iV88jztCWE7wr5N0tApTntAsS9qDbnhPxICOoqTNOftWvd2FdARbsKheCJ/9SjIVyaygc378
 ldmsZFZOEZ0TBB/L7HCF7SKadY/DD+ytHKuQ6I9QYKcT1X
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,335,1654552800"; 
   d="scan'208";a="24404039"
X-MGA-submission: =?us-ascii?q?MDGRnrUw2WMJXOK/Nswrv4QizF1YDVpl56bkkn?=
 =?us-ascii?q?Cqu0g3hZkuAil0kE4dwZoMchfnts7bGkHecLlATn5T+TqnFe95x0SIGj?=
 =?us-ascii?q?xjKHFcODDus++4hLGTBBLRgIDIwT4m6cKiUXMOEa5Rp/XtgIQI2cAUdY?=
 =?us-ascii?q?WnErLRdSjvu6nJa6vrHylz6A=3D=3D?=
Received: from szxga01-in.huawei.com ([45.249.212.187])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 13:58:09 +0200
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.55])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MYDFw2FCjzlXGN;
	Thu, 22 Sep 2022 19:53:56 +0800 (CST)
Received: from huawei.com (10.175.112.208) by dggpeml500024.china.huawei.com
 (7.185.36.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 22 Sep
 2022 19:58:04 +0800
From: Yuan Can <yuancan@huawei.com>
To: <Julia.Lawall@inria.fr>, <nicolas.palix@imag.fr>, <cocci@inria.fr>
CC: <yuancan@huawei.com>
Date: Thu, 22 Sep 2022 11:55:35 +0000
Message-ID: <20220922115535.44132-3-yuancan@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220922115535.44132-1-yuancan@huawei.com>
References: <20220922115535.44132-1-yuancan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH v3 2/2] coccinelle: locks: add
 missing_spin_lock_init.cocci script
Reply-To: Yuan Can <yuancan@huawei.com>
X-Loop: cocci@inria.fr
X-Sequence: 570
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/20220922115535.44132-3-yuancan%40huawei.com>

Find spin lock inside struct which is possibly used without init,
provide the name of the struct and of the spin lock, the position
where the struct is malloced and where the spin lock get locked.

Signed-off-by: Yuan Can <yuancan@huawei.com>
---
 .../locks/missing_spin_lock_init.cocci        | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 scripts/coccinelle/locks/missing_spin_lock_init.cocci

diff --git a/scripts/coccinelle/locks/missing_spin_lock_init.cocci b/scripts/coccinelle/locks/missing_spin_lock_init.cocci
new file mode 100644
index 000000000000..9724d348e28e
--- /dev/null
+++ b/scripts/coccinelle/locks/missing_spin_lock_init.cocci
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/// report missing spin_lock_init()
+///
+/// Report spin lock used without initialize. False positives
+/// can occur when the spin lock allocation and initialization
+/// happens in two different files.
+///
+// Confidence: Low
+// Copyright: (C) 2022 Huawei Technologies Co, Ltd.
+// Comments:
+// Options: --include-headers
+
+virtual org
+virtual report
+
+@r1@
+identifier s, fld;
+struct s *mm;
+@@
+  spin_lock_init(&(mm->fld))
+
+@r2@
+identifier r1.s, r1.fld;
+position p;
+@@
+
+struct s {
+  ...
+  spinlock_t fld@p;
+  ...
+};
+
+@r3@
+identifier s, fld;
+position p != {r2.p};
+@@
+
+struct s {
+  ...
+  spinlock_t fld@p;
+  ...
+};
+
+@r4@
+identifier r3.fld;
+identifier r3.s;
+struct s *mm;
+position p;
+@@
+(
+ \(spin_lock\|spin_lock_bh\|spin_trylock\|spin_lock_irq\)(&mm->fld@p)
+|
+ spin_lock_irqsave(&mm->fld@p,...)
+)
+
+@r5 depends on r4@
+identifier r3.s;
+struct s *mm;
+position p;
+@@
+mm@p = \(kmalloc\|kzalloc\|devm_kmalloc\|devm_kzalloc\)(...)
+
+@script:python depends on org@
+p << r5.p;
+p1 << r4.p;
+s << r3.s;
+fld << r3.fld;
+@@
+msg = "Spin lock %s inside the struct %s malloced at line %s is possibly used at line %s without init." % (fld, s, p[0].line, p1[0].line);
+cocci.print_main(msg, p)
+
+@script:python depends on report@
+p << r5.p;
+p1 << r4.p;
+s << r3.s;
+fld << r3.fld;
+@@
+msg = "Spin lock %s inside the struct %s malloced at line %s is possibly used at line %s without init." % (fld, s, p[0].line, p1[0].line);
+coccilib.report.print_report(p[0], msg)
-- 
2.17.1

