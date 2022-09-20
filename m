Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9799C54EE9
	for <cocci@archiver.kernel.org>; Tue, 20 Sep 2022 07:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=fkanhIzyMFNsVTb42lYrj9fE0SmOKaGJaPyLiePwxYU=;
  b=qqUdFAH8k/simrusyRYfLrxjFEyBXTy/AeXcfniMDeCEn6hyzi5Nm5z6
   shxjMVLa9Xt5YEj2iEX3p2DljhtTu2vqhdBKageleKvlAXeMAnGKOea2M
   z2xEBuu92DC/ABGZmYVHr20EtSGUW5T7bm69pr7QZ1hrwb+wxnGRulH+h
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
   d="scan'208";a="53562721"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Sep 2022 09:45:45 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 87E1FE039C; Tue, 20 Sep 2022 09:45:45 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 37EBDE019E
	for <cocci@sympa.inria.fr>; Tue, 20 Sep 2022 05:00:52 +0200 (CEST)
IronPort-SDR: 63292ce3_T+2F/a95Re91pbUWhmGoQgRKHnAPTBwf/OcZQbtYz0Mm9Oc
 aNC6iKTkiyDF+Q9Mq8z3kmzRF++zzmmXAZnXG5g==
X-IPAS-Result: =?us-ascii?q?A0ATAADUKyljmLvU+S1SCB0BAQEBCQESAQUFAYF7CAELA?=
 =?us-ascii?q?YIjgVYvBAtFF4xWiHWXPoVVFIFoCwEDAQwBQgQBAYFTgzIChGoCHQcBBDAJD?=
 =?us-ascii?q?gECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEARMBAQEBAQEBARQJGQUOE?=
 =?us-ascii?q?AUihXWCNSKDbAMDJ1IQUVcGAQ0Fgn2DIQOtMDKBAYRwgy2BZYE9AYpxg0+BY?=
 =?us-ascii?q?yccgUlEgRWBPIIshAcWhmMEkjOGSTgDCQQHBSwdQQMLHw0WNAMVAxQDBSQHA?=
 =?us-ascii?q?xkPIw0NBB0MAwMFJQMCAhsHAgIDAgYTBQICFx4YOAgECAQrJA8FAgcvBQQvA?=
 =?us-ascii?q?h4EBQYRCAIWAgYEBAQEFQIQCAIIJhcHEzMZAQVZEAkhFgYOGg0FBhMDIEkmB?=
 =?us-ascii?q?Qc+DygyaysdGwqBDCoJHxUDBAQDAgYTAwMiAhAqMRQEKRMSLQcrcwkCAyJnB?=
 =?us-ascii?q?QMDBCgsAwkhHwcoJjwHWBIoBQMDECI9BgMJAwIkE0d4DCwUFAUDDRkmCAUjF?=
 =?us-ascii?q?h0ECDwCBQaaaYEOAX+BBqF6oG+DYIFHDJ5GGjKpBC2HCROPQSCiG1qEJwIEA?=
 =?us-ascii?q?gQFAhaBYTqBWzMaCBsVgyJOAxcCD445jjdEMTsCBgsBAQMJiWuBEgEB?=
IronPort-PHdr: A9a23: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
 sJmdw==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:oaxJaaH2WPTOBTUnpLqE1seALOsnbusQ8zAXP0AYc3Nom62j5q
 eTdZsgtCMc5Ax9ZJhko6HjBEDiewK5yXcW2+ks1N6ZNWGM0ldAbrsSiLcKqAePJ8SRzIJgPX
 sJSdkHNDWmZmIK9PoSmDPIcOrIl+P3lpyVuQ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,329,1654552800"; 
   d="scan'208";a="24128013"
X-MGA-submission: =?us-ascii?q?MDHCD+6QGjXsyvRIoM3DMDux/qJvcjMizFQa2v?=
 =?us-ascii?q?PzeaRieyK/O0tvktPblsarNU8Zp5gllBorMQw7OBzGRFqFFOQrNWiyio?=
 =?us-ascii?q?QfMQRrNZkFrA9deiH5b98B/Zanu82JOJM5p0K8u6XUevzucpRP19p4wq?=
 =?us-ascii?q?RhpeaFeMl08mmnjcjwfHSVLA=3D=3D?=
Received: from szxga01-in.huawei.com ([45.249.212.187])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 05:00:50 +0200
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.54])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MWmSP5DB4zpT3L;
	Tue, 20 Sep 2022 10:57:57 +0800 (CST)
Received: from huawei.com (10.175.112.208) by dggpeml500024.china.huawei.com
 (7.185.36.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 20 Sep
 2022 11:00:44 +0800
From: Yuan Can <yuancan@huawei.com>
To: <Julia.Lawall@inria.fr>, <nicolas.palix@imag.fr>, <cocci@inria.fr>
CC: <yuancan@huawei.com>
Date: Tue, 20 Sep 2022 02:58:20 +0000
Message-ID: <20220920025820.105924-2-yuancan@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220920025820.105924-1-yuancan@huawei.com>
References: <20220920025820.105924-1-yuancan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH v2 2/2] coccinelle: locks: add
 missing_spin_lock_init.cocci script
Reply-To: Yuan Can <yuancan@huawei.com>
X-Loop: cocci@inria.fr
X-Sequence: 559
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/20220920025820.105924-2-yuancan%40huawei.com>

Find spin lock inside struct which is possibly used without init,
provide the name of the struct and of the spin lock, the position
where the struct is malloced and where the spin lock get locked.

Signed-off-by: Yuan Can <yuancan@huawei.com>
---
changes in v2:
- adjust commit msg
- add Confidence: tag
- print out more information in the report
---
 .../locks/missing_spin_lock_init.cocci        | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 scripts/coccinelle/locks/missing_spin_lock_init.cocci

diff --git a/scripts/coccinelle/locks/missing_spin_lock_init.cocci b/scripts/coccinelle/locks/missing_spin_lock_init.cocci
new file mode 100644
index 000000000000..0bb642e5ed4a
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
+  spin_lock_init(\(&mm->fld\|&(mm->fld)\))
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
+* mm@p = \(kmalloc\|kzalloc\|devm_kmalloc\|devm_kzalloc\)(...)
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

