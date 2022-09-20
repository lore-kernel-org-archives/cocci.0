Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBFF8ECAAD8
	for <cocci@archiver.kernel.org>; Tue, 20 Sep 2022 07:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=vqoo3sDJBlbiBF/f9G2Eh9fitQCymCuDhsRHcGs2xfI=;
  b=WM1LYpBg8Ms1O0WW/anCYLr6pO9lqvZzldA6ACHJBTMyZmQY2sOPB2Pw
   B6TIDIXR+3H+QlYqAIRil8Utl+1NvH50/dLUfj7l7NLei4WP3MSSxSpoZ
   Stcpn7hOV26Ptkau3ZEG9pcyrjpVu8b/82fXWLQ1YHcAbo/EX/OhMm+C6
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
X-IronPort-AV: E=Sophos;i="5.93,329,1654552800"; 
   d="scan'208";a="53562700"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Sep 2022 09:45:45 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B5F39E039B; Tue, 20 Sep 2022 09:45:44 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 26061E0157
	for <cocci@sympa.inria.fr>; Tue, 20 Sep 2022 05:00:52 +0200 (CEST)
IronPort-SDR: 63292ce3_4l/mM1EE6HfyaGRiHGsZWTlq4DR5uXEDWD6V1/NHm94CGHN
 9XurRSDT99u50PLC4gBFrgxMJ/wmifrrUYkpGWQ==
X-IPAS-Result: =?us-ascii?q?A0AmAQDUKyljmLvU+S1SCB4BAQsSDIIEC4IkgVYvBAtFF?=
 =?us-ascii?q?60JhVUUgWgLAQMBDAFCBAEBgVODMoRsAh0HAQQwCQ4BAgQBAQEBAwIDAQEBA?=
 =?us-ascii?q?QEBAwEBBQEBAQIBAQIEBAETAQEBAQEBAQEUCRkFDhAFIoV1gjUihBlSgT4BD?=
 =?us-ascii?q?QWCfYMhA60wMoEBhHCDLYFlgT2KcoNPggocgUlEgRWBPIIshAcWhmMEkjOGS?=
 =?us-ascii?q?TgDCQQHBSwdQQMLHw0WNAMVAxQDBSQHAxkPIw0NBB0MAwMFJQMCAhsHAgIDA?=
 =?us-ascii?q?gYTBQICFx4YOAgECAQrJA8FAgcvBQQvAh4EBQYRCAIWAgYEBAQEFQIQCAIIJ?=
 =?us-ascii?q?hcHEzMZAQVZEAkhFgYoDQUGEwMgSSYFBz4PKDJrKx0bCoEMKgkfFQMEBAMCB?=
 =?us-ascii?q?hMDAyICECoxFAQpExItBytzCQIDImwDAwQoLAMJIR8HKCY8B1gSKAUDAxAiP?=
 =?us-ascii?q?QYDCQMCJBNHeAwsFBQFAw0ZJggFOR0ECDwCBQaaaYEOAYIFoXqgb4NggUcMn?=
 =?us-ascii?q?kYaMqkELYcJE49BIKIbWoQnAgQCBAUCFoFhOoFbMxoIGxWDIk4DFwIPjjmON?=
 =?us-ascii?q?0QxOwIGCwEBAwmJa4ESAQE?=
IronPort-PHdr: A9a23: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
 50LGOczaQ==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:0rZztaqsyqaUvnjBj1ldJ6MaV5opeYIsimQD101hICG8cqSj+P
 xG/c5rsCMc5wxxZJhNo7290cq7MBHhHPxOgbX5VI3KNGKNhILCFu9fBOXZrwEJx0XFh4hgPf
 AKSdkYNDSJNykYsS+s2njdL+od
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,329,1654552800"; 
   d="scan'208";a="24128014"
X-MGA-submission: =?us-ascii?q?MDEapGQe1T3eIn8n2Dg/avd6/e3TCBysmnsDdN?=
 =?us-ascii?q?mJeIbpJmwY33FpocBCLKfecceG92Jbl8i2BqcWCuYmk0VDGnZpU0F6y0?=
 =?us-ascii?q?60obh+yGSiv019lyGiRvt1M6dqZz3p5i2QumI54jObXHSEjH8x0X9z6O?=
 =?us-ascii?q?MGJlsHC4buYQbRlCCYa00m7A=3D=3D?=
Received: from szxga01-in.huawei.com ([45.249.212.187])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 05:00:50 +0200
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.57])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MWmSP2f7hzpT0d;
	Tue, 20 Sep 2022 10:57:57 +0800 (CST)
Received: from huawei.com (10.175.112.208) by dggpeml500024.china.huawei.com
 (7.185.36.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 20 Sep
 2022 11:00:44 +0800
From: Yuan Can <yuancan@huawei.com>
To: <Julia.Lawall@inria.fr>, <nicolas.palix@imag.fr>, <cocci@inria.fr>
CC: <yuancan@huawei.com>
Date: Tue, 20 Sep 2022 02:58:19 +0000
Message-ID: <20220920025820.105924-1-yuancan@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH v2 1/2] coccinelle: locks: add
 missing_mutex_init.cocci script
Reply-To: Yuan Can <yuancan@huawei.com>
X-Loop: cocci@inria.fr
X-Sequence: 558
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/20220920025820.105924-1-yuancan%40huawei.com>

Find mutex inside struct which is possibly used without init,
provide the name of the struct and of the mutex, the position
where the struct is malloced and where the mutex get locked.

Signed-off-by: Yuan Can <yuancan@huawei.com>
---
changes in v2:
- adjust commit msg
- add Confidence: tag
- print out more information in the report
---
 .../coccinelle/locks/missing_mutex_init.cocci | 76 +++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 scripts/coccinelle/locks/missing_mutex_init.cocci

diff --git a/scripts/coccinelle/locks/missing_mutex_init.cocci b/scripts/coccinelle/locks/missing_mutex_init.cocci
new file mode 100644
index 000000000000..bf522efc7f24
--- /dev/null
+++ b/scripts/coccinelle/locks/missing_mutex_init.cocci
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/// report missing mutex_init()
+///
+/// Report mutex used without initialize. False positives can occur
+/// when the mutex allocation and initialization happens in two
+/// different files.
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
+mutex_init(\(&mm->fld\|&(mm->fld)\))
+
+@r2@
+identifier r1.s, r1.fld;
+position p;
+@@
+
+struct s {
+  ...
+  struct mutex fld@p;
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
+  struct mutex fld@p;
+  ...
+};
+
+@r4@
+identifier r3.fld;
+identifier r3.s;
+struct s *mm;
+position p;
+@@
+
+mutex_lock@p(&mm->fld)
+
+@r5 depends on r4@
+identifier r3.s;
+struct s *mm;
+position p;
+@@
+* mm@p = \(kmalloc\|kzalloc\|devm_kmalloc\|devm_kzalloc\)(...)
+
+@script:python depends on org@
+p << r5.p;
+p1 << r4.p;
+s << r3.s;
+fld << r3.fld;
+@@
+msg = "Mutex %s inside the struct %s malloced at line %s is possibly used at line %s without init." % (fld, s, p[0].line, p1[0].line);
+cocci.print_main(msg, p)
+
+@script:python depends on report@
+p << r5.p;
+p1 << r4.p;
+s << r3.s;
+fld << r3.fld;
+@@
+msg = "Mutex %s inside the struct %s malloced at line %s is possibly used at line %s without init." % (fld, s, p[0].line, p1[0].line);
+coccilib.report.print_report(p[0], msg)
-- 
2.17.1

