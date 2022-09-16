Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F0CCECAAD8
	for <cocci@archiver.kernel.org>; Fri, 16 Sep 2022 09:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=0UHNhzBuMJL0BOHxd5oVlwbeVf1oq8KcfmahIToAOn4=;
  b=LITuyjrfvkucPF56t3MwI8z21nAE1w8i2dhvH+sukmKVHmWMgbEHQubX
   RIk9Pdfg/R6IgRnSopIvl+XKUwyKeeHvKGkSB7uyXfu+UdHxQoLqMnHdr
   sFSJIQk28T0cjuh/v8gNpn52QMtiUtYPtG8pikTTsF7pWhw+0jm/kq9+4
   g=;
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
   d="scan'208";a="53104740"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Sep 2022 11:34:57 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 31525E0157; Fri, 16 Sep 2022 11:34:57 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 0BDA3E0157
	for <cocci@sympa.inria.fr>; Fri, 16 Sep 2022 08:21:56 +0200 (CEST)
IronPort-SDR: 63241603_RX2vhowi4lohAD5D2khxtJGOlcMt/s2+H5RNtybxhu4zTSY
 uPcF4D0tB8r5VyVnmduT10mM8+RPHa1AYaK0olw==
X-IPAS-Result: =?us-ascii?q?A0BcAwA+FSRjh7vU+S1aHgEBCxIMggQLgiSBVi8EC0UXr?=
 =?us-ascii?q?QmFVRSBaAsBAwEMAUIEAQGBU4MyAoRpAh0HAQQyBw4BAgQBAQEBAwIDAQEBA?=
 =?us-ascii?q?QEBAwEBBQEBAQIBAQIEBAETAQEBARgJFwcOEAUihXWCNSKDbAMDJ1IQUVcGA?=
 =?us-ascii?q?Q0Fgn2DIQOpPzKBAYRwgy2BZYE9inKDT4FjJxyBSUSBFYE8giyEB4Z5BJI2h?=
 =?us-ascii?q?j44AwkEBwUsHUEDCx8NFjQDFQMUAwUkBwMZDyMNDQQdDAMDBSUDAgIbBwICA?=
 =?us-ascii?q?wIGEwUCAhceGDgIBAgEKyQPBQIHLwUELwIeBAUGEQgCFgIGBAQEBBUCEAgCC?=
 =?us-ascii?q?CYXBxMzGQEFWRAJIRYGDhoNBQYTAyBJJgUHPg8oMzU5Kx0bCoEOKgkfFQMEB?=
 =?us-ascii?q?AMCBhMDAyICECoxFAQpExItBytzCQIDImcFAwMEKCwDCSEfBygmPAdZEigFA?=
 =?us-ascii?q?wMQIj0GAwkDAiQTR3kMLBQUBQMNGSYIBSMWHgQIQwIFBppCgQ4Bf8Nug2CBR?=
 =?us-ascii?q?wyeRhoyqQMthwkTj0EgohtahCcCBAIEBQIWgWgDMIFbMxoIGxWDIk4DFwIPj?=
 =?us-ascii?q?jmON0QxOwIGCwEBAwmJbIESAQE?=
IronPort-PHdr: A9a23:zvsVsxZACPmunMBlp1vDxET/LTHV2oqcDmcuAnoPtbtCf+yZ8oj4O
 wSHvLMx1gSPBtyKoKsc0KL/iOPJYSQ4+5GPsXQPItRndiQuroEopTEmG9OPEkbhLfTnPGQQF
 cVGU0J5rTngaRAGUMnxaEfPrXKs8DUcBgvwNRZvJuTyB4Xek9m72/q99pHNbQhEnjSwba52I
 Rm5sAndqscbipZ+J6gszRfEvmFGcPlMy2NyIlKTkRf85sOu85Nm7i9dpfEv+dNeXKvjZ6g3Q
 qBWAzogM2Au+c3krgLDQheV5nsdSWoZjBxFCBXY4R7gX5fxtiz6tvdh2CSfIMb7Q6w4VSik4
 qx2ThLjlSUJOCMj8GzPisJ+krxWrg+vqRJ8xIDbYo+VO/VicaPcZt4aWXZNU9xNWyFbHo+wc
 40CBPcBM+ZCqIn9okMDohmjBQa2AuPk1yFFiWXw3aYn1OkgERzG0xYmH90SqnvUqs74NKcPU
 e+vwqjH0zTDY+lK1jf67YjFaxYsquyDUrxsa8Te01UvFx/bgVWKr4zoJy+Y2/kNvWSF8+ZtV
 OKihnM7pg1vvzWix8Uhh4jJiI8Ry13J+iF0zJsoKdGkS0N2btGqHIVeuSyaKoZ7Q8IvTmJut
 S0nybMGoYa2cScKxZg92RLSZPiKf5KW7h7+SuqdOyp0iXFndb6nmhq+7VKsxvD+W8S0ylpGs
 zdJnsfWunwTyxDe6c6KQeZn8Ei7wzaAzQXT5/lEIU8qkarbLIYswqUxl5scvkTMBDP6lFjvg
 K+XcEUo4Oio6/n9bbTouJCcNpV4hR35MqQrgsC/AOI4PRYSX2WD9umx1Kfv8VP2TbhOlPE6j
 LTVvI7AKcgGpaO0ARdZ0oM55Ba+Czem3s4YnX4CLF9deBOHkpLmO1fSL//iC/eymFSskCpxy
 PHIILLhA4/BIWTEkLfkZbp97VVTxxIpzd9D/5JUFq0BIPXrV0PvrNDYFAM2MxSow+b7D9Vwz
 oceVniBA6CDNKPStUSF5+MuI+mJf4AVoizyJ+Ik5/7ol385mEUScbOn3ZsNcHy4BOhpI12FY
 XrwhdcMCXsFvg0iQ+P2iV2PSiVTZna3X6Ik/D43EoOmDYHZRoCsmrONxim7HocFLlxBXwSuD
 HPpfsOgUugFbCa6I8l7kzVCW6L3D8d10xClswvz0Px/J+7V6gUZsJvsktZvsambwRo1/jd1J
 8WbyWCECW9uyDAmXTgziZFiqEo14V6FmfxpnvVeHtVVz/NUWxg3NNjXyOksWIO6YR7IYtrcE
 AXued6hGzxkFrrZovcLakd5QZC5iwzbmjCtCPkTnqCKA5o99uTd2WLwLoBz0SWOz7Ev2n8hR
 MYHLmi6nuhn7QGGFpPAlU6QkY6qaK0D0S+L/2CGniKVpE8NaAdrSu3eWGwHIE7frND3/ETHG
 q6zALIsOw1pydOLNaZLLNbuiAYOX+/tbfLZZW/5gGKsHVCIy7eLOZLtYHkY1T7BBVIsiBID8
 n/ebE0/AGGhvmvBAT0oHlXqC6/12c95rn7zDko9zgXQKlZky6Lw4Bkew/qVV/IU2LsA/iYns
 TR9WlinjZrQDJKbqgxtcb85A5t16Upb1W/fqw12P4CxZ6FkiFkEdg1rvkTonxxpA4REmMIuo
 Tsk1g13Ya6f1VpAcXuf0/WScvXGN2D09xmpQ67L007T0ZCd/aJOoPU0plP/vR24Q1I4+iYv2
 N1U3n2Ao5TSWVZPF8itAwBtrkI8/uGFMUxfr8vO2HZhMLe5qGrH0tMtXq4+zwq4Os1YO+WCH
 RPzFMsTA46vLvYrkh6ndEFhXqga+agqMsehb/bD1rSsObMqjS+vi29O5qh9z0uT+is6QenNl
 cVgobnQzk6cWjHwgU30+NHqkIZPbDc6Hne21iXlQoVWY+chNZZOAmCoLcqtw9x4jJO4QH9U+
 mmoAFYe0dOocx6fB7Dk9TVZzl9f4XmumC/iiidxjylstK2UmirH3+XlchMDfG9NXmhry1n2c
 8C4iNUTXU7gaAZM9lPt9FvzwaNSoox/MmDMTEYOdC/zZ21vSaq/sLOebtUHtM5u63kGFr7lO
 xbDGuG1qgBSyy75GmpC2D03ElPi8o70mRB3kiPVLXp+qmbYZdAlwB7e4NLGQvsCljECRSR+l
 XzWHg3gYp/zoYTSzc6Z9LnuCDHENNUbayTgwIKeuTHu4GRrBUf6hPWvgpj9FgN81ybn1t5sX
 CGOrRDmY4Ct2b7pVIAvNkRuGlL47NJ3X49klY5lzoAN0H4Rj5O9/WcOjmryd95c3OitCRhFD
 S5O2NPT7AX/jQdyM3uPzIv/fnWAy9RsZp+xZWZciWotqstNDqmT9rlNmyB490G5oQzmav94h
 j4ByPEq5S1/4alBqE83wy6aGLxXAVhAMHmmiUGT997n5vYfdCO1fLO3zkY7gd2xEOTIvFRHQ
 HigH/VqVS5ospcjbRSWjCy1sNi+PoKKJdML6k/IzlGa07kTcstr0KFXzSt/ZTCh4Dt/l7991
 0U0m8vn4e3lYy1s5P7rXkMebGGkIZlKoHe03fkZxJfe3pjzTMk8XG9XDd2yFKjuSWNL/fX/a
 1TXTm168ybGX+uEW1PAjSUu53PXT8LyZyzRfSZHi4ozAkTDbE1H3FJNBWR8zthgSVHsnpC+O
 EZhumJIvw+++l0cm6QxbEe4CT66xk/gay9oGsHGfVwGqFEToR6ObISf9r4hRngJuM3n9VPSb
 DfFIF8RRWARBh7dXgGlbv/3uoaGqLjQQ+O6K7Gmjaymj+tYWr/IwJuu1tEj5DOQLoCVOXIkC
 fQn201FVHQ/GsLDmjxJRTZF3yTKJ9WWohux4EgV5oi27ejrVQTz5ICOF6oaMNNh/AqziLuCM
 OjYjThwKDJR3JcBjXHSz71X0FkXgiBoPz6jdNZI/TbKV77Vk7RLAgQzcDFjO8IQtuc92E9NJ
 MfEh9Kz3bl9z7Y0B1pDSV39i5SpaMgNcATffBvMAEeGMqjDJCWen5yxO//tD+cJ1qMN50Lj3
 FTTW1XuNTmCiTTzAhWmMOUWyTqeIAQbooa2NBBkFWnkStviLBy9Kt5+yzMskthWzjvHM3ARN
 T9kfgZDtLqVuGlJn/x5EGVHxnp4JPaJmmCS6OySefN0+bN7Rz95ke5X+iFw07xO8CRNX+B4g
 gPJvM5hqgn/1+iJjDp6WQVDq3BAg4fB7iAAce3Js5JHX3jD5hcE626dXg8Lq9VSAdrqo6lMy
 9LLmcobyR9Z4cLb9JNFQsnSbsKaOWUsMFziHzuGVGPtoharKGjAik0bm/aXpCT9Rn0SqoXlh
 5cPDLRcUQ5tfs4=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:ECiigqNo/h89WMBcTv+jsMiBIKoaSvp037Eqv3ofdfU1SL3+qy
 nAppUmPHPP5Qr5HUtQ++xoW5PwJU80l6QU3WB5B97LN2PbUSmTXeRfBODZrQEIdReTygaAvZ
 0QC5SXX7bLfCFHZL7BkWqF+oEbsb+6zJw=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,320,1654552800"; 
   d="scan'208";a="53052370"
X-MGA-submission: =?us-ascii?q?MDHlyZZZPLTaDXCcsG3+Veg+uh3aTnqC5Fwp6I?=
 =?us-ascii?q?3KC0heYrC8bCycjPL7V/kCFa+U1iO9sVNhDDJt80X1aJCAyaPNlDFFw0?=
 =?us-ascii?q?2Nowf6y2p76KWnxkq0RxKmMWQDYeP9mcFMb+tCC2bVmH1jRttO1LG/WO?=
 =?us-ascii?q?i7M9HTaDupI3MxpESk8Wbrgg=3D=3D?=
Received: from szxga01-in.huawei.com ([45.249.212.187])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 08:21:54 +0200
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.57])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MTP4s1XyQzlVxP;
	Fri, 16 Sep 2022 14:17:49 +0800 (CST)
Received: from huawei.com (10.175.112.208) by dggpeml500024.china.huawei.com
 (7.185.36.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 16 Sep
 2022 14:21:49 +0800
From: Yuan Can <yuancan@huawei.com>
To: <Julia.Lawall@inria.fr>, <nicolas.palix@imag.fr>, <cocci@inria.fr>
CC: <yuancan@huawei.com>
Date: Fri, 16 Sep 2022 06:19:23 +0000
Message-ID: <20220916061923.29759-2-yuancan@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220916061923.29759-1-yuancan@huawei.com>
References: <20220916061923.29759-1-yuancan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH 2/2] coccinelle: locks: add
 missing_spin_lock_init.cocci script
Reply-To: Yuan Can <yuancan@huawei.com>
X-Loop: cocci@inria.fr
X-Sequence: 550
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/20220916061923.29759-2-yuancan%40huawei.com>

Find spin lock used without init, and point out the
place the spin lock is allocated.

Signed-off-by: Yuan Can <yuancan@huawei.com>
---
 .../locks/missing_spin_lock_init.cocci        | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 scripts/coccinelle/locks/missing_spin_lock_init.cocci

diff --git a/scripts/coccinelle/locks/missing_spin_lock_init.cocci b/scripts/coccinelle/locks/missing_spin_lock_init.cocci
new file mode 100644
index 000000000000..1447f9fe9b16
--- /dev/null
+++ b/scripts/coccinelle/locks/missing_spin_lock_init.cocci
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/// report missing spin_lock_init()
+///
+/// Report spin lock used without initialize. False positives
+/// can occur when the spin lock allocation and initialization
+/// happens in two different files.
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
+@@
+(
+ \(spin_lock\|spin_lock_bh\|spin_trylock\|spin_lock_irq\)(&mm->fld)
+|
+ spin_lock_irqsave(&mm->fld,...)
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
+@@
+cocci.print_main("Spin lock inside the struct malloced here is possibly used without init.", p)
+
+@script:python depends on report@
+p << r5.p;
+@@
+
+msg = "Spin lock inside the struct malloced here is possibly used without init."
+coccilib.report.print_report(p[0], msg)
-- 
2.17.1

