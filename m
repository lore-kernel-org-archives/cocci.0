Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5282AC54EE9
	for <cocci@archiver.kernel.org>; Fri, 16 Sep 2022 09:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=7sWdTFmR10ZhSKySzMtsPxx1MkV3lU8LJ2b19ApJyZ8=;
  b=QZ1GnWdIZK4Rlon9aAmMIVoxgd/x1DLsNKblbraeLfKvZfTFFWyBG2of
   S3MeVif8Nz2OAsUd33tKHQuGIJ5kHHICDXcPz9DrUpIdxCNYb0fMzsQ0y
   c/53u2In9jVYZL534ZliznU4TmVKhnwpOxA9ZFFSnRjVLLwh1seDNm1pB
   Y=;
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
X-IronPort-AV: E=Sophos;i="5.93,320,1654552800"; 
   d="scan'208";a="53104770"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Sep 2022 11:34:58 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6318BE0157; Fri, 16 Sep 2022 11:34:58 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 263A8E019E
	for <cocci@sympa.inria.fr>; Fri, 16 Sep 2022 08:21:56 +0200 (CEST)
IronPort-SDR: 63241603_AJajqCCqTQuW+hmWXXJJIl3Z0N7Dpc3mXk197Fq0J2YXvTQ
 KaN3YUTRfIUqv4Ykue+UZo19ODwXoZLPy4FtvLw==
X-IPAS-Result: =?us-ascii?q?A0CMAgDWFCRjh7vU+S1agliCJIFWLwQLRRetCYVVFIFoC?=
 =?us-ascii?q?wEDAQwBQgQBAYFTgzKEawIdBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQMBAQUBA?=
 =?us-ascii?q?QECAQECBAQBEwEBAQEYCRcHDhAFIoV1gjUihBlSgT4BDQWCfYMhA6lAMoEBh?=
 =?us-ascii?q?HCDLYFlgT2KcoNPggocgUlEgRWBPIIshAeGeQSSNoY+OAMJBAcFLB1BAwsfD?=
 =?us-ascii?q?RY0AxUDFAMFJAcDGQ8jDQ0EHQwDAwUlAwICGwcCAgMCBhMFAgIXHhg4CAQIB?=
 =?us-ascii?q?CskDwUCBy8FBC8CHgQFBhEIAhYCBgQEBAQVAhAIAggmFwcTMxkBBVkQCSEWB?=
 =?us-ascii?q?igNBQYTAyBJJgUHPg8oMzU5Kx0bCoEOKgkfFQMEBAMCBhMDAyICECoxFAQpE?=
 =?us-ascii?q?xItBytzCQIDImwDAwQoLAMJIR8HKCY8B1kSKAUDAxAiPQYDCQMCJBNHeQwsF?=
 =?us-ascii?q?BQFAw0ZJggFOR4ECEMCBQaaQoEOAcRtg2CBRwyeRhoyqQMthwkTj0Egohtah?=
 =?us-ascii?q?CcCBAIEBQIWgWE6gVszGggbFYMiTgMXAg+OOY43RDE7AgYLAQEDCYlsgRIBA?=
 =?us-ascii?q?Q?=
IronPort-PHdr: A9a23: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
 Q==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:NtYFtqOatwgo88BcT1T155DYdb4zR+YMi2TDiHoddfUFSKalfp
 6V98jzjSWE7gr5K0tQ4OxoWZPwCE80kKQY3WB/B8bHYOCLggqVxeJZnMPfKl/bakrDH4dmvM
 8OHZSWY+eAbmSS+PyKhTVQZOxQouVvnprJuc7ui1NWCS16YaBp6Al0TiyBFFdteQVADZ0lUL
 KB+8tuvVObCD4qR/X+IkNAc/nIptXNmp6jSwUBHQQb5A6Hii7twKLmEiKfwgwVX1p0sPofGC
 n+4kDED5eYwr+GIyznpi7uBlNt6ZvcI+54dYOxYw4uW3bRY0iTFcZcsva5zUgISamUmS0XeZ
 /30lwd1o1Img7slivem2qW5yDwlDkp8HPs0lmenD/qptH4XiszD45biZteaQax0TtVgDhQ6t
 M444uijesjMTrQ2CDmo9TYXRBjkUS55XIkjO4IlnRaFY8TcqVYo4AT9F5cVM5oJlON1Kk3VO
 11SM3M7vdfdl2XK3jfo2l02dSpGnA+BA2PTEQOstGclzJWgHd6xU0Fw9F3pAZ2yLstD51fo+
 jUOKVhk79DCscQcKJmHe8EBdC6D2TcKCi8Q157CjzcZd060rL22u7KCZkOlZCXkcYzveQPcb
 z6IS1liVI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,320,1654552800"; 
   d="scan'208";a="23855410"
X-MGA-submission: =?us-ascii?q?MDEkXTDl2VCdHYmXbbYEYip3/64LksOduu2l8S?=
 =?us-ascii?q?HUCKk2kb+DZ/9EPvh99OJHc9qCMmU2cUcnTospAziTge70pObpQ6aSp4?=
 =?us-ascii?q?/1Wf7FWAfkIgZrljoK4zpDu+hws5ZZCEk8vlaWJ45cG3UDmwqMVPYVxV?=
 =?us-ascii?q?TiMAYExDHF4DQonnvIScX9cg=3D=3D?=
Received: from szxga01-in.huawei.com ([45.249.212.187])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 08:21:54 +0200
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.53])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MTP4r63xvzlVwY;
	Fri, 16 Sep 2022 14:17:48 +0800 (CST)
Received: from huawei.com (10.175.112.208) by dggpeml500024.china.huawei.com
 (7.185.36.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 16 Sep
 2022 14:21:48 +0800
From: Yuan Can <yuancan@huawei.com>
To: <Julia.Lawall@inria.fr>, <nicolas.palix@imag.fr>, <cocci@inria.fr>
CC: <yuancan@huawei.com>
Date: Fri, 16 Sep 2022 06:19:22 +0000
Message-ID: <20220916061923.29759-1-yuancan@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH 1/2] coccinelle: locks: add missing_mutex_init.cocci
 script
Reply-To: Yuan Can <yuancan@huawei.com>
X-Loop: cocci@inria.fr
X-Sequence: 551
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/20220916061923.29759-1-yuancan%40huawei.com>

Find mutex used without init, and point out the
place the mutex is allocated.

Signed-off-by: Yuan Can <yuancan@huawei.com>
---
 .../coccinelle/locks/missing_mutex_init.cocci | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 scripts/coccinelle/locks/missing_mutex_init.cocci

diff --git a/scripts/coccinelle/locks/missing_mutex_init.cocci b/scripts/coccinelle/locks/missing_mutex_init.cocci
new file mode 100644
index 000000000000..bec8ce60d0c5
--- /dev/null
+++ b/scripts/coccinelle/locks/missing_mutex_init.cocci
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/// report missing mutex_init()
+///
+/// Report mutex used without initialize. False positives can occur
+/// when the mutex allocation and initialization happens in two
+/// different files.
+///
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
+@@
+
+mutex_lock(&mm->fld)
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
+@@
+cocci.print_main("Mutex inside the struct malloced here is possibly used without init.", p)
+
+@script:python depends on report@
+p << r5.p;
+@@
+
+msg = "Mutex inside the struct malloced here is possibly used without init."
+coccilib.report.print_report(p[0], msg)
-- 
2.17.1

