Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E284FC624C6
	for <cocci@archiver.kernel.org>; Mon, 31 Aug 2026 13:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=SzlwyLZN9eqId7ybekFhy3BedoUz5HO9PJUmsOGl30I=;
  b=QahHbFCuMAhgKkbf+RCMyWvPDj+6j/aI/7Boyldoj9uRI+6RApPiX9Zv
   S/qa0wkhlndKV3KWDhIOVJp6sOWRZ7kbSfhu3X8WUvK3dTAQhJvB37rqo
   JRNGl59wsXLZYbUOUnUvmfZWyL+LKEy3HQcW3KJiPpMSItn/ttOeQCtP9
   Q=;
X-CSE-ConnectionGUID: 9BTLovGrTx6TbMZxaL8Byw==
X-CSE-MsgGUID: eml46AsqRUC8+Wz9YdqEBg==
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
X-IronPort-AV: E=Sophos;i="6.25,254,1779141600"; 
   d="scan'208";a="292371932"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 31 Aug 2026 15:51:40 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id A1BD781F03; Mon, 31 Aug 2026 15:51:40 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id B000481EFA
	for <cocci@sympa.inria.fr>; Mon, 31 Aug 2026 15:44:04 +0200 (CEST)
X-CSE-ConnectionGUID: K0EbfDtwTrmSC5k78+5lPA==
X-CSE-MsgGUID: QvEcj5ONSpCTWAPO00YT5w==
IronPort-SDR: 6a958524_ps036Rwx+ktZiw2UtlTHvRkNUcF0jVx+YSpxrYFQ6wwca56
 1AaDkp6mNtFEDYE5Xv26dq3vDRkB5AMhb10sPzw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EVAwD/g5VqgTKAVdFaglmCQYFpMwRUjVKIeYEWijQwA?=
 =?us-ascii?q?pIiFIErPQIPAQMBCwEBUQQBAQECBDcBD4Q3jXYCHgcBBDEIDgECBAMCAwEBA?=
 =?us-ascii?q?QEBAQEBAQEBCwEBAQQBAQECAQECBAMBAQEBAhABASIZBw47hk8NgluBLGECB?=
 =?us-ascii?q?QM7AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBBQIsYSsLA?=
 =?us-ascii?q?Q0BGx0BAxIQWwIRAQUBIxKDAoIjAQYQAQM3A7RtjHAWBQIWgQGCDQaCatgAC?=
 =?us-ascii?q?hkoDXWBZAICBwkBCgEBgTeEeCpdA4I8hSOED2mBIYIogRWCc3aCH4FnUjiFe?=
 =?us-ascii?q?ASDLoJxkQgBBwcfEggBHAYIAgJIFRIDBAMEBAECCxMJAwMCDgIIAwIIBhkBP?=
 =?us-ascii?q?xIEEwIIAwYECwcFHwoCDBQKKCISKwoDKgsSDwMNBgUVAQgGAgIEBAIEDAIJA?=
 =?us-ascii?q?gIFAwQCBA0DBAEBCAICLQMBAxkICQgCCwURGAwLBzEDEAkDHwMUHAhFCAYWA?=
 =?us-ascii?q?RoGBQYLNxUFDBEBAhsCIAQdEQgDARsEAgEJAwQWBAIUCh0CBggMFwICAgYCA?=
 =?us-ascii?q?wMDCgECCAMDAwIDGQcGAwQEAQQEAwMCAwUBAwMDBQICCgYJAQEBAQMCAggDB?=
 =?us-ascii?q?wMKCQIFAxsDGwQBAgIDAgECCAMHCAMNAwQCAwMDBAECAgEBAQIDAQMDBAMBA?=
 =?us-ascii?q?wMCAQMHAgIDAwMLAQIDAwUDAwUFAgIFBQMFAgIKAgMDAwIBAwIcCAMGAxABE?=
 =?us-ascii?q?AMDBgEDBwMHAgQDCQIIAwMICAMXAwMFAQICBAMDCAgEAwMEAgIDDAUDAgMDB?=
 =?us-ascii?q?QMDBwIEAgQDAwEFAQIHAgMHAgEYAwIECAcHBQILBAIIBA0JBAIEAgIPBAYDA?=
 =?us-ascii?q?wcBAQIBBwUGAwICEAEICgUGAgICHAMdAQMPBgEJBQIBBQ4HBQICGAMGAgMGB?=
 =?us-ascii?q?QEDAQoLAQECAwoBAgQCBQMDAQMCAwIGAwMCBQUFAwkHBQ4JAQMDBgUCAgMCA?=
 =?us-ascii?q?wECCAQGBQMCAgMFAQQDBAMKAwIIAwMIAwwCGgIFAwMDBgkDBwcCAwcDAgUCB?=
 =?us-ascii?q?wUDAwUDBgEDAgEDAwgLFSUDAQUDAwIBAwIFAwMYAgIEBQMDAwMDAwgEAgIBB?=
 =?us-ascii?q?wYEAgICAQUFBQQFBgIEAwgBAQUDAwoNAQIHDAMMBgMHAwMEBAMCBQwCAgQBB?=
 =?us-ascii?q?wYHBwkHAwIDCAEBCwQBAwMKAwMFAgEBBwUDBgMHAgMDAwUEBQMCCwMHAgIDA?=
 =?us-ascii?q?wMCKQEBAQMDAwMDBAMBAwEDAwcDBQMCDgIIAQQIAwIGAwcGAwUDAwIBAgMDB?=
 =?us-ascii?q?REDBgQFBAsJCAcMATwMBwokBAQMKgEVFAUEJRlnBwcCjngfgVlyUygTFC8Lf?=
 =?us-ascii?q?oIuAQEBlT2Mc6I/SR4JAQYCDVSBZ4EKFQovm2CFfBozhASTT5MYAS6XX3sjg?=
 =?us-ascii?q?jaPOpJHhD4CCgcHESQSgTQCNoFccFAxbYFJUAMZD5IjzBtCNT0CBwIHDgMLk?=
 =?us-ascii?q?hyBTAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:9861YK4/qr0svNcNQAPXwBvXdLJyesId70hD6qm+c20wTiX+rb
 HVoB1/73XJYVkqKRcdcLy7Scu9qBDnhOVICPcqTM6ftWDd0QPCXeJfBOPZowEIcBeOkdK1u5
 0QFpRWOZneC0Nlhd327AT9P9Er28mf7ayk7N2z815dCS9vL49vhj0WNu9ZKCJLrct9aKbRbK
 DsnvavbgDARUgq
X-Talos-CUID: 9a23:+VknJmGvLgwZUA7TqmJErGMeFOw5bUHHyUz7fkznWSU0TIW8HAo=
X-Talos-MUID: =?us-ascii?q?9a23=3AZEfR2g+62qtpa4G3x6LcYpSQf/52zq+sVWcrqo0?=
 =?us-ascii?q?th/atDQsoYwah0SviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,254,1779141600"; 
   d="scan'208";a="155491365"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDHkEmj7UTtaeH6tQX+gwS7pMrYHzBpE8932gP?=
 =?us-ascii?q?4aKrCdyctjdKWDPyjRRkukXZpo1B1ps9VY8Ef2pOgQKxNroo+C6YpNn/?=
 =?us-ascii?q?k4t7kMouLLK3QWzFKfC+gBEpLPAkoCPFWRL06D0JFzsLxF4ANo8Hqsx8?=
 =?us-ascii?q?QNlpm/brLt0Mk/e4+B6tag8A=3D=3D?=
Received: from mail-wm1-f50.google.com ([209.85.128.50])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 15:44:04 +0200
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49ccfbe062eso15839925e9.3
        for <cocci@inria.fr>; Mon, 31 Aug 2026 06:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788183843; x=1788788643;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SzlwyLZN9eqId7ybekFhy3BedoUz5HO9PJUmsOGl30I=;
        b=JFqJwnjj+3exP7N/iXd7egpGTaZlUwnibwUmrgyHJw7KHlN32beY74RS/doYg+JTP2
         6xPo6Y59BD73JePnWLz8I/ryQGYSodnK7MZRZOuWoeRPxZS9gZqO7r5DkNwHtVEjY5oz
         GWSQM93EAyipTc1bjJFvQjdvLDHPmzco2x7GpErjHmU6ECkKSGtiNgosKm+x4FQJv+Yv
         2ER/WPe/dS+NmQP7Fsw3WavnLbwdSqgYHYSvwJJ3l45ClFKNNDXcNo30gsX5ENc3R3uQ
         NuQPLX5JjU6L1ub+q+c5SI2xEX23hGkiKM8WNLT3A1r9K4dP5VWTQ33BUQqv0Z8conM2
         nXPg==
X-Forwarded-Encrypted: i=1; AHgh+RrQ2G3aghk4jvalsYTZC49KEeaYOrfSkSJLBgx5X+sDapx+jqdEHJhJQMSDwV023/jg2PQx7A==@inria.fr
X-Gm-Message-State: AFuF++n08FdoPR+/megQLcHVZlHx6AGZ42FYpZTTlj2zyILHO4HayXqH
	Yc7g35rgKPi3Tm8h1AgBZx/PdRU0wf2pPtNRhvDovadVgfHEuJDjWVI0
X-Gm-Gg: AR+sD13vtSUcO87ke4TvNNQ0LRWuobA7viUGYFge2r2ziqzeHFH9d6Jrq85VTrPrXYN
	jC+2SfW9Jv7sRhD6/nFojuB+fWFrN4uZGMbH7PjBuWIryKOm8ukA3WI9F6FsXOY48vFApSjDVXn
	JVOZezS5Pydv1BcHzw3MhXhXhEAq9FGx6SzcSW/H0f0Lc2o89KcWu2hI+XSYnJHvnMYOkcnRXRK
	sm75aAZkE7F2bJSk0z6Kv+8RSWOuZESSLlhmHQTrbfmZ1CXPILq9VOeTPA8IBetc09zf5j4d7QJ
	FRbJTyfh6Qf/IRlF67Ip/EgJ4aF9Rbkgn26OrXSahUGhtmJtyXgl+7rKKE/Wb3QXRqYN8MHNcJM
	jl4v4exbdOYTfXzOtuosFBCikW8JbRhaLq0hLEF5u5WA+0O/svykcW/1aubmuHC+Vs7tv0eUiGn
	LRqSRkku0/fGIIrFy68QLBoJUfnwxPhfI/dkMcCnMLelI9fmy1rt2UEkfdMBbCxIzstOqIlOsOd
	a68aojUjfus/5MPJcYHTAA+yVTNNdUCcQ4w7lW5WSyE
X-Received: by 2002:a05:600c:4453:b0:499:8777:ccba with SMTP id 5b1f17b1804b1-49b91c486abmr346085025e9.12.1788183843113;
        Mon, 31 Aug 2026 06:44:03 -0700 (PDT)
Received: from ptb-02009389.paris.inria.fr (wifi-pro-83-187.paris.inria.fr. [128.93.83.187])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cd2922ebdsm167798735e9.3.2026.08.31.06.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 06:44:02 -0700 (PDT)
From: Ella Ma <alansnape3058@gmail.com>
To: Julia.Lawall@inria.fr,
	nicolas.palix@imag.fr
Cc: alansnape3058@gmail.com,
	linux-kernel@vger.kernel.org,
	cocci@inria.fr
Date: Mon, 31 Aug 2026 15:43:36 +0200
Message-Id: <20260831134336.45540-1-alansnape3058@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH] coccinelle: free: add a checker for
 `__cleanup(kfree)` usage
Reply-To: Ella Ma <alansnape3058@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3726
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-08/5FB5doEYHQgqoUs7WSJJoQ>

Using __cleanup(kfree) will pass the stack address of the annotated
local variable to kfree functions. This will lead to invalid
deallocation issues. Inspired by CVE-2026-45959 and similar bugs
recently detected.

Signed-off-by: Ella Ma <alansnape3058@gmail.com>
---
 scripts/coccinelle/free/cleanup-free.cocci | 94 ++++++++++++++++++++++
 1 file changed, 94 insertions(+)
 create mode 100644 scripts/coccinelle/free/cleanup-free.cocci

diff --git a/scripts/coccinelle/free/cleanup-free.cocci b/scripts/coccinelle/free/cleanup-free.cocci
new file mode 100644
index 000000000000..cdf984ac6b44
--- /dev/null
+++ b/scripts/coccinelle/free/cleanup-free.cocci
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0-only
+///
+/// Find __cleanup(kfree)
+/// Using __cleanup(kfree) will pass the stack address of the annotated
+/// local variable to kfree, causing an invalid free.
+/// I.e., `T v __cleanup(kfree);` --> `kfree(&v);`
+/// Such usage is impossible to be correct.
+///
+// Confidence: High
+// Copyright: (C) 2026 Ella Ma
+// Options: --no-includes --include-headers
+
+
+// Suggesting using __free for the functions with a DEFINE_FREE definition.
+// Update this list when new DEFINE_FREE definitions are added.
+@free@
+attribute name __cleanup;
+symbol kfree, kfree_sensitive, kvfree, kvfree_atomic;
+type T;
+identifier v, n;
+position p;
+@@
+
+(
+  T v __cleanup@p(
+(
+  n
+&
+(
+  kfree \| kfree_sensitive \| kvfree \| kvfree_atomic
+)
+)
+  );
+|
+  T v __cleanup@p(
+(
+  n
+&
+(
+  kfree \| kfree_sensitive \| kvfree \| kvfree_atomic
+)
+)
+  ) = ...;
+)
+
+@script:python depends on free@
+p << free.p;
+n << free.n;
+@@
+
+coccilib.report.print_report(
+  p[0], f"ERROR: found `__cleanup({n})', do you mean `__free({n})'?")
+
+
+// Reporting __cleanup usage for the functions without a DEFINE_FREE definition.
+// The following list only contains frequently used functions. Supplement it if
+// necessary.
+@cleanup@
+attribute name __cleanup;
+symbol kvfree_sensitive, vfree, vfree_atomic;
+type T;
+identifier v, n;
+position p;
+@@
+
+(
+  T v __cleanup@p(
+(
+  n
+&
+(
+  kvfree_sensitive \| vfree \| vfree_atomic
+)
+)
+  );
+|
+  T v __cleanup@p(
+(
+  n
+&
+(
+  kvfree_sensitive \| vfree \| vfree_atomic
+)
+)
+  ) = ...;
+)
+
+@script:python depends on cleanup@
+p << cleanup.p;
+n << cleanup.n;
+@@
+
+coccilib.report.print_report(
+  p[0], f"ERROR: `__cleanup({n})' will free the annotated variable, rather than its pointee")
-- 
2.34.1

