Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ED55F3C246
	for <cocci@archiver.kernel.org>; Mon,  9 Mar 2026 12:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=trLOFqPpr7SRhWJmD8vM55OWvwK3qE1re6lswXuQdy4=;
  b=S6poVdIPWSw4G5a0bqsn9hCTsjkHq6CEQISimhn7jcH4CSLEQ6Ymd/2p
   75+1JCzNt0NkQC4nS7J3vsq/FTjRorHGmt1MmwMtLQc/bIsmqL2RcCHX9
   bUmuEkCq6F9W0peZs/LuRouSMRj4j1jbwuABIMV6gowexUt43xJaptjdv
   8=;
X-CSE-ConnectionGUID: UWKJ7f0QRDq9bShVEnmhCA==
X-CSE-MsgGUID: uPMoZ3a1TwGgj+glBSRJpg==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
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
X-IronPort-AV: E=Sophos;i="6.23,109,1770591600"; 
   d="scan'208";a="266890405"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Mar 2026 13:55:21 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 20EE5830C4; Mon,  9 Mar 2026 13:55:21 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id F031B83083
	for <cocci@sympa.inria.fr>; Mon,  9 Mar 2026 13:13:14 +0100 (CET)
X-CSE-ConnectionGUID: aJjyADRbQ1yceVXCN/74iw==
X-CSE-MsgGUID: 7IldL4RjQ5Wta6LqcLlmNw==
IronPort-SDR: 69aeb95b_YxV8NoUZ6Hc++V14Vv5jaOwdmvBNrLR/ppEvhhrN0LhOScx
 GDK8AlLAWMR0uO9V6d285uQWiAM+vwl1QW3J1aQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GVAQAPuK5phf4EaaxaHgEBCxIMQIFFC4JBgWYzBAtJh?=
 =?us-ascii?q?FiIe4ZYWwEBBoJUimGSJhSBaQIPAQMBDVEEAQEDBIUAAo0hAh4HAQQwCQ4BA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEBgECEAEBAQFASYZPDYJiA?=
 =?us-ascii?q?YEkgSYBAQEBAQEBAQEBAQEdAg1+AgEDIx0BATcBDyUCJgICVhmDAoIjBxEDN?=
 =?us-ascii?q?gOtToEygQGCDAEBBtsvIlmBZQIJFAGBCi6IVAGFAHREglNpeicbfYEQgRUyg?=
 =?us-ascii?q?kB2hAaEGIJpgzSTG0iBAhwDWSwBVRMNCgsHBV6BCAM1EioVbjIdgSM+DwgzW?=
 =?us-ascii?q?BsHBYUgD4hygWKBE4MDAwsYDUgRLDcUGwQ+bgeNaj6CNIEOgT2UWoMkjHCjL?=
 =?us-ascii?q?4QmoXIzl1KTGS6YWKQiN4RogWg6gVwzGggoCIMiTwMZD44hGYh6w2dCNTwCB?=
 =?us-ascii?q?wsBAQMJkh6BSwEB?=
IronPort-PHdr: A9a23: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
 twVTaJBX1FzFf4ADElhWtsYL8UvNg4=
IronPort-Data: A9a23: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
 bkjx5E7AvR9LlyFiwreCjxXTNqLHs/n+08=
IronPort-HdrOrdr: A9a23:o9mymaEm4JcfuRUfpLqE7ceALOsnbusQ8zAXPo5KKCC9Vvbo8f
 xG/c5rsiMc7Qx9ZJhOo7y90cW7Lk80sKQFmLX5Xo3SODUO2lHYT72KhLGKq1aLJ8S9zJ856U
 4KSchD4bPLY2SS9fyKgjWFLw==
X-Talos-CUID: =?us-ascii?q?9a23=3As0Ti7GtUEi4XJLxMBH46Bu/b6IssUH/M5VvqKXb?=
 =?us-ascii?q?hGG1kdo2+bxjPpKJ7xp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3ANC/zxgygNq4DK9kT7ZDaUpjUtv2aqPuPDEwpza8?=
 =?us-ascii?q?EgpS7KSUuHy6WqDCyZJByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,109,1770591600"; 
   d="scan'208";a="266879799"
X-MGA-submission: =?us-ascii?q?MDH0aorZpAhEBiLRwxAfoVV0MJp5sPg398l+4s?=
 =?us-ascii?q?XAbTfUt/upo10p0C+MWQ0kzTu/DKYw5X9mQN5UeLUOQENxkAsFP8zv9W?=
 =?us-ascii?q?7lh6nbdc8JkETaod2DctW1a6stHzzhp2Nw5nkTxzPE1DHX31gCEdt6Pv?=
 =?us-ascii?q?YBPxTvZ0SBZVmUTRBPdxTZ2Q=3D=3D?=
Received: from tor.source.kernel.org ([172.105.4.254])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 13:13:14 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 97FBA60130;
	Mon,  9 Mar 2026 12:13:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E95F1C2BC9E;
	Mon,  9 Mar 2026 12:13:10 +0000 (UTC)
Date: Mon, 9 Mar 2026 13:13:09 +0100
From: Alejandro Colomar <alx@kernel.org>
To: cocci@inria.fr
Cc: Alejandro Colomar <alx@kernel.org>, Kees Cook <kees@kernel.org>, 
	Markus Elfring <Markus.Elfring@web.de>, Julia Lawall <Julia.Lawall@inria.fr>, 
	Nicolas Palix <nicolas.palix@imag.fr>
Message-ID: <9fd8d3d1e7ef3efb6e6dae0972dd515ff02e42bd.1773058287.git.alx@kernel.org>
X-Mailer: git-send-email 2.53.0
References: <cover.1772752564.git.alx@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1772752564.git.alx@kernel.org>
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH v2] scripts/coccinelle: Add script for using
 ARRAY_END()
Reply-To: Alejandro Colomar <alx@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 3357
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/UqkomMDJMZYN9T4qAZWeww>

Recently, we added an ARRAY_END() macro to simplify finding a pointer
one past the last element in an array.  Such a pointer is often called
the 'end', and thus the macro name.

Make it easy to find more places where that macro should be used.

See also:
436debc9cad8 ("array_size.h: add ARRAY_END()")
8118f197b7b7 ("mm: fix benign off-by-one bugs")
a9e5620c9a9e ("kernel: fix off-by-one benign bugs")
61e9210e2392 ("mm: use ARRAY_END() instead of open-coding it")

Cc: Kees Cook <kees@kernel.org>
Cc: Markus Elfring <Markus.Elfring@web.de>
Cc: Julia Lawall <Julia.Lawall@inria.fr>
Cc: Nicolas Palix <nicolas.palix@imag.fr>
Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 scripts/coccinelle/misc/array_end.cocci | 74 +++++++++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 scripts/coccinelle/misc/array_end.cocci

diff --git a/scripts/coccinelle/misc/array_end.cocci b/scripts/coccinelle/misc/array_end.cocci
new file mode 100644
index 00000000..fc431c4a
--- /dev/null
+++ b/scripts/coccinelle/misc/array_end.cocci
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/// Use ARRAY_END instead of an expression derived from ARRAY_SIZE
+//
+// Confidence: High
+// Copyright: 2026, Alejandro Colomar <alx@kernel.org>
+// Comments: No known false positives, but has a few false negatives
+// Options: --no-includes --include-headers
+
+virtual patch
+virtual context
+virtual org
+virtual report
+
+@depends on context@
+type T;
+T[] a;
+expression b;
+@@
+(
+* (a + ARRAY_SIZE(a))
+|
+* (&a[0] + ARRAY_SIZE(a))
+|
+* (&a[ARRAY_SIZE(a)])
+|
+* (&a[ARRAY_SIZE(a) - b])
+)
+
+@depends on patch@
+type T;
+T[] a;
+expression b;
+@@
+(
+- (a + ARRAY_SIZE(a))
++ ARRAY_END(a)
+|
+- (&a[0] + ARRAY_SIZE(a))
++ ARRAY_END(a)
+|
+- (&a[ARRAY_SIZE(a)])
++ ARRAY_END(a)
+|
+- (&a[ARRAY_SIZE(a) - b])
++ ARRAY_END(a) - b
+)
+
+@r depends on org || report@
+type T;
+T[] a;
+expression b;
+position p;
+@@
+(
+ (a@p + ARRAY_SIZE(a))
+|
+ (&a[0]@p + ARRAY_SIZE(a))
+|
+ (&a[ARRAY_SIZE(a)]@p)
+|
+ (&a[ARRAY_SIZE(a)@p - b])
+)
+
+@script:python depends on org@
+p << r.p;
+@@
+
+coccilib.org.print_todo(p[0], "WARNING should use ARRAY_END")
+
+@script:python depends on report@
+p << r.p;
+@@
+
+coccilib.report.print_report(p[0], "WARNING: opportunity for ARRAY_END")

Range-diff against v1:
1:  f1c9dff5 ! 1:  9fd8d3d1 scripts/coccinelle: Add script for using ARRAY_END()
    @@ Commit message
         one past the last element in an array.  Such a pointer is often called
         the 'end', and thus the macro name.
     
    -    This script makes it easy to find more places where that macro should be
    -    used.
    +    Make it easy to find more places where that macro should be used.
     
         See also:
         436debc9cad8 ("array_size.h: add ARRAY_END()")
    @@ Commit message
         61e9210e2392 ("mm: use ARRAY_END() instead of open-coding it")
     
         Cc: Kees Cook <kees@kernel.org>
    +    Cc: Markus Elfring <Markus.Elfring@web.de>
         Cc: Julia Lawall <Julia.Lawall@inria.fr>
         Cc: Nicolas Palix <nicolas.palix@imag.fr>
         Signed-off-by: Alejandro Colomar <alx@kernel.org>
    @@ scripts/coccinelle/misc/array_end.cocci (new)
     +// SPDX-License-Identifier: GPL-2.0-only
     +/// Use ARRAY_END instead of an expression derived from ARRAY_SIZE
     +//
    -+// Confidence: ???
    ++// Confidence: High
     +// Copyright: 2026, Alejandro Colomar <alx@kernel.org>
    -+// Comments:
    ++// Comments: No known false positives, but has a few false negatives
     +// Options: --no-includes --include-headers
     +
     +virtual patch
    @@ scripts/coccinelle/misc/array_end.cocci (new)
     +virtual org
     +virtual report
     +
    -+@i@
    -+@@
    -+
    -+#include <linux/kernel.h>
    -+
    -+//----------------------------------------------------------
    -+//  For context mode
    -+//----------------------------------------------------------
    -+
    -+@depends on i&&context@
    ++@depends on context@
     +type T;
     +T[] a;
     +expression b;
    @@ scripts/coccinelle/misc/array_end.cocci (new)
     +* (&a[ARRAY_SIZE(a) - b])
     +)
     +
    -+//----------------------------------------------------------
    -+//  For patch mode
    -+//----------------------------------------------------------
    -+
    -+@depends on i&&patch@
    ++@depends on patch@
     +type T;
     +T[] a;
     +expression b;
    @@ scripts/coccinelle/misc/array_end.cocci (new)
     ++ ARRAY_END(a) - b
     +)
     +
    -+//----------------------------------------------------------
    -+//  For org and report mode
    -+//----------------------------------------------------------
    -+
    -+@r depends on (org || report)@
    ++@r depends on org || report@
     +type T;
     +T[] a;
     +expression b;
    @@ scripts/coccinelle/misc/array_end.cocci (new)
     +p << r.p;
     +@@
     +
    -+msg="WARNING: Use ARRAY_END"
    -+coccilib.report.print_report(p[0], msg)
    -+
    ++coccilib.report.print_report(p[0], "WARNING: opportunity for ARRAY_END")
-- 
2.53.0

