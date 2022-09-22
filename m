Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6069CC6FA93
	for <cocci@archiver.kernel.org>; Thu, 22 Sep 2022 12:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=kAx/w/OXKPnqIaPd93+8HNRXwC2NBhI4/OeJi+p+Yk0=;
  b=ObjNw1s6RHxp6O0yOy1IHMqAb4KZ6UfpJ+DkfaeqxNj/8GqzZn0FSS70
   nya1JpWAtzrUvACj9r1U5RIgZPlEl/Hgytz888L4l1a3CTKfFaIYquO2X
   ox9lVZZlTkIMXELYVqqhW+Mq1hdmKkRkWIIAdq1nfJipyU7LrbbIzfz2S
   A=;
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
   d="scan'208";a="54036647"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Sep 2022 14:28:28 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6C985E0090; Thu, 22 Sep 2022 14:28:28 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 1B5F4E0130
	for <cocci@sympa.inria.fr>; Thu, 22 Sep 2022 13:58:10 +0200 (CEST)
IronPort-SDR: 632c4dd1_MBoGT4BRC9CHv64zdIaWbd9dpa3cibiSlu9l18SAqwDS014
 ORluvznvfDCngG+22tRWnlVKgzWT268v2I3+jPQ==
X-IPAS-Result: =?us-ascii?q?A0ArAAABTSxjh7zU+S1SCB0BAQEBCQESAQUFAYF7CAELA?=
 =?us-ascii?q?YIjgVYvBAtFF4xWoDSFVRSBaAsBAwEMAUIEAQGBU4MyAoRsAh0HAQQwCQ4BA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAETAQEBARgJFwcOEAUihXWCN?=
 =?us-ascii?q?SKDbAMDJ1IQUVcGAQ0Fgn2DIQOsITOBAYRwgy2BZYE9AYp1g1CBYyccgUlEg?=
 =?us-ascii?q?RWBPIIshAcWhmMEkjCGaTgDCQMHBSwdQQMLHw0WNAMVAxQDBSQHAxkPIw0NB?=
 =?us-ascii?q?B0MAwMFJQMCAhsHAgIDAgYTBQICFx4YNggECAQrJA8FAgcvBQQvAh4EBQYRC?=
 =?us-ascii?q?AIWAgYEBAQEFQIQCAIIJhcHEzMZAQVZEAkhFgYOGg0FBhMDIEkmBQc9Dygxa?=
 =?us-ascii?q?ysdGwqBDCoJHxUDBAQDAgYTAwMiAhAqMRQEKRMSLQcrcwkCAyJnBQMDBCgsA?=
 =?us-ascii?q?wkhHwcoJjwHWBIoBQMDECI9BgMJAwIkE0d2DCwUFAUDDRkmCAUjARYdBAg8A?=
 =?us-ascii?q?gUGVxMCChIDmmaBDgGCBaF7oHODYoFJDJ5JGjKpBC2HCROPQSCiH1qEJwIEA?=
 =?us-ascii?q?gQFAhaBYTqBWzMaCBsVgyJOAxcCD445jjdEMTsCBgsBAQMJiVCBEgEB?=
IronPort-PHdr: A9a23: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
 5cPDLRcUQ5tfs4=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:eqZ63KMNG9rlScBcTv+jsMiBIKoaSvp037Eqv3ofdfU1SL3+qy
 nAppUmPHPP5Qr5HUtQ++xoW5PwJU80l6QU3WB5B97LN2PbUSmTXeRfBODZrQEIdReTygaAvZ
 0QC5SXX7bLfCFHZL7BkWqF+oEbsb+6zJw=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,335,1654552800"; 
   d="scan'208";a="54029196"
X-MGA-submission: =?us-ascii?q?MDHj/nBgr4mYWfy6a0Nb5suejehWvHEd8DAGav?=
 =?us-ascii?q?raz1Ni6+CoHkV7/I2CupXcqereBO30p/Xh2VGy3hTnY63J9/wklRKB1q?=
 =?us-ascii?q?i7mZyMCgljZpEcdVCQV9u+/QaEIXcMxkOvg4uW61sO/k7yg+aQ8S8mIc?=
 =?us-ascii?q?l+my+x9yB1NY7mEsaH9Qopxw=3D=3D?=
Received: from szxga02-in.huawei.com ([45.249.212.188])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 13:58:08 +0200
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.53])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MYDG72DQczWgtQ;
	Thu, 22 Sep 2022 19:54:07 +0800 (CST)
Received: from huawei.com (10.175.112.208) by dggpeml500024.china.huawei.com
 (7.185.36.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 22 Sep
 2022 19:58:04 +0800
From: Yuan Can <yuancan@huawei.com>
To: <Julia.Lawall@inria.fr>, <nicolas.palix@imag.fr>, <cocci@inria.fr>
CC: <yuancan@huawei.com>
Date: Thu, 22 Sep 2022 11:55:34 +0000
Message-ID: <20220922115535.44132-2-yuancan@huawei.com>
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
Subject: [cocci] [PATCH v3 1/2] coccinelle: locks: add
 missing_mutex_init.cocci script
Reply-To: Yuan Can <yuancan@huawei.com>
X-Loop: cocci@inria.fr
X-Sequence: 572
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/20220922115535.44132-2-yuancan%40huawei.com>

Find mutex inside struct which is possibly used without init,
provide the name of the struct and of the mutex, the position
where the struct is malloced and where the mutex get locked.

Signed-off-by: Yuan Can <yuancan@huawei.com>
---
 .../coccinelle/locks/missing_mutex_init.cocci | 76 +++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 scripts/coccinelle/locks/missing_mutex_init.cocci

diff --git a/scripts/coccinelle/locks/missing_mutex_init.cocci b/scripts/coccinelle/locks/missing_mutex_init.cocci
new file mode 100644
index 000000000000..1a77119b1177
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
+mutex_init(&(mm->fld))
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
+mm@p = \(kmalloc\|kzalloc\|devm_kmalloc\|devm_kzalloc\)(...)
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

