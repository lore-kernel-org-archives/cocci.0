Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAB77F46425
	for <cocci@archiver.kernel.org>; Mon, 16 Mar 2026 09:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=kUyWgaRg4FOlNSUt5jLHeeBJejQ414DBndNgrPYp5vs=;
  b=KEVrYNZKYbh/BYdkKG96poBYpXXBS6TRSSl9YXFC2uJIe0CcHvP/LlvY
   YS6ALJDK4XODuuOjwE5oboZsgpTVSl3rj+HAbfPG7OL/KMaBDcYKaWcyn
   ZaBuyasDcAApGZoQGMcNALi1bEg7fVzo4H4XK+ewBxqEG6kUBAV7azmvF
   s=;
X-CSE-ConnectionGUID: pokrkXGmT0m9vgwo/0iung==
X-CSE-MsgGUID: sjA1EqY7SO+SrXhxWhpg+Q==
X-Ironport-Invalid-End-Of-Message: True
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
X-IronPort-AV: E=Sophos;i="6.23,123,1770591600"; 
   d="scan'208";a="267915583"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Mar 2026 10:29:32 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 1062081F65; Mon, 16 Mar 2026 10:29:32 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id DAD8780F70
	for <cocci@sympa.inria.fr>; Sun, 15 Mar 2026 23:11:08 +0100 (CET)
X-CSE-ConnectionGUID: bAaNmpNLTO+HsJbKyygvQw==
X-CSE-MsgGUID: /91WJX9aRhaHb8uTb3NEiw==
IronPort-SDR: 69b72e7d_x1cs7B4bmktB/lLt/Uf4OKmPq3jpWozyW7kojASPqu65GDu
 L3QXVkiUtRLOlXhShJpS/dA57rOQm2Lkrbjb1tA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FuAQCmLbdphf4EaaxaglmCQYFmMwQLSYRYiHuGWFsCB?=
 =?us-ascii?q?oE+gRaKYZBRgVUUgWkCDwEDAQ1RBAEBAwSFAAKNIwIeBwEEMAkOAQIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABAQEBQEmGTw2CYgGBJIEmA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBHQINfgIBAyMdAQE3AQ8lAiYCAlYGARKDAoIjBxEDNgO0Q?=
 =?us-ascii?q?4EygQGCDAEBBtsvIlmBZQIJFAGBCi6IVAGFAHQ7CYJTaXonG32BEIEVMoJAd?=
 =?us-ascii?q?oQGI4N1gmmCJoEOkyxIgQIcA1ksAVUTDQoLBwVegQgDKgsSEhgVbjIdgSM+D?=
 =?us-ascii?q?wgzWBsHBYUaD4hygWGBE4MtAwsYDUgRLDcUGwQ+bgeNej2CMwGBDoE9pG6jL?=
 =?us-ascii?q?4QmoXIzl1KTGS6YWCKkADeEaIFoOoFcMxoIKAiDIk8DGQ+OOoh6xAJCNT0CB?=
 =?us-ascii?q?wIHDQMLkhyBSwEB?=
IronPort-PHdr: A9a23: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
 10P27yqdOwu
IronPort-Data: A9a23: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
 ewjFrbM0tRdD32nqSv/JhB2vAu/+s7n+w==
IronPort-HdrOrdr: A9a23:r6sjIK0vOXzrw250DpevPAqjBLckLtp133Aq2lEZdPWaSK2lfu
 SV7ZImPH7P+VEssRQb9OxoV5PtfZqxz/FICMwqTM6ftWrdyQ+VxeNZnOjfKlTbckWUnNK1l5
 0QFpSWY+eRMbEVt6jHCXGDYrQd/OU=
X-Talos-CUID: =?us-ascii?q?9a23=3AaqZJTmslABJtvQ3L7Xq87mSP6IsvW3T7yW/2B3O?=
 =?us-ascii?q?fSkZyare2WE6f5pp7xp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AQSbQGQ5VebxZEpnSGLgEThIBxowvsv2RKnBcmK8?=
 =?us-ascii?q?GsumOZTFMMWy7oTWoF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,122,1770591600"; 
   d="scan'208";a="267855459"
X-MGA-submission: =?us-ascii?q?MDH0gpf0+vQYGOpJAqhkkdngFw9cOriwhM3yyA?=
 =?us-ascii?q?WLggupdWwzpfsbbejPfz/OtpI/lHQkkLSd95AcN1zSVbjBIBTqxuKZ+K?=
 =?us-ascii?q?Q5yMZaEYucHpUK2JQxA/jN55tcBxW/kfuPTCHByiyA+V4yVp0PJGDPra?=
 =?us-ascii?q?5xiCPACGTWTRtto+Lt4m76cQ=3D=3D?=
Received: from tor.source.kernel.org ([172.105.4.254])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2026 23:11:08 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 3AD3E61861;
	Sun, 15 Mar 2026 22:11:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8634EC4CEF7;
	Sun, 15 Mar 2026 22:11:05 +0000 (UTC)
Date: Sun, 15 Mar 2026 23:11:03 +0100
From: Alejandro Colomar <alx@kernel.org>
To: cocci@inria.fr, Julia Lawall <Julia.Lawall@inria.fr>
Cc: Alejandro Colomar <alx@kernel.org>, 
	Markus Elfring <Markus.Elfring@web.de>, Kees Cook <kees@kernel.org>, 
	Nicolas Palix <nicolas.palix@imag.fr>
Message-ID: <2ae22f8b73f6424020a6fe876cf2120c7d75b552.1773612610.git.alx@kernel.org>
X-Mailer: git-send-email 2.53.0
References: <cover.1772752564.git.alx@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1772752564.git.alx@kernel.org>
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH v3] scripts/coccinelle: Add script for using
 ARRAY_END()
Reply-To: Alejandro Colomar <alx@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 3436
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/7zHnJTRdGsR5b8FhhxscpA>

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

Hi!

This v3 only has one change: I've removed the comment about the false
negatives.  They were due to spatch(1) not being able to correctly parse
unrelated code elsewhere.

See range-diff and interdiff at the bottom.


Have a lovely night!
Alex

 scripts/coccinelle/misc/array_end.cocci | 73 +++++++++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 scripts/coccinelle/misc/array_end.cocci

diff --git a/scripts/coccinelle/misc/array_end.cocci b/scripts/coccinelle/misc/array_end.cocci
new file mode 100644
index 00000000..88c664de
--- /dev/null
+++ b/scripts/coccinelle/misc/array_end.cocci
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/// Use ARRAY_END instead of an expression derived from ARRAY_SIZE
+//
+// Confidence: High
+// Copyright: 2026, Alejandro Colomar <alx@kernel.org>
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

Range-diff:
1:  9fd8d3d1 ! 1:  2ae22f8b scripts/coccinelle: Add script for using ARRAY_END()
    @@ scripts/coccinelle/misc/array_end.cocci (new)
     +//
     +// Confidence: High
     +// Copyright: 2026, Alejandro Colomar <alx@kernel.org>
    -+// Comments: No known false positives, but has a few false negatives
     +// Options: --no-includes --include-headers
     +
     +virtual patch
-- 
2.53.0

