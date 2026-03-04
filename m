Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 622D3EFCE33
	for <cocci@archiver.kernel.org>; Wed,  4 Mar 2026 17:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=q3bt69veRGTuMpF7s+1p2dynfh0PLtZ3Q+XiTpxNWFY=;
  b=He0N0wHONpZdWyIszQgqOaTApeUI6X0vnRA/ECVWSDXSQXErDU+i39uT
   Yxlta3fY4EQ+bJVQaIsP0NKokcCeHb94S1+vA9BWr35CNCrsnjB6xlDdA
   3hWRh4ZbZMYsB1KVg7LeUgQmOgQRWAX61aQUmFnWJjYXSfjDQFpyf5uTo
   s=;
X-CSE-ConnectionGUID: Hjui1uNAQwWWGod5s64vUQ==
X-CSE-MsgGUID: qHS+JMxQRQmeLck7E9SWEQ==
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
X-IronPort-AV: E=Sophos;i="6.21,324,1763420400"; 
   d="scan'208";a="266267698"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Mar 2026 18:54:19 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id CEB51838E3; Wed,  4 Mar 2026 18:54:18 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 5EB4C82E89
	for <cocci@sympa.inria.fr>; Wed,  4 Mar 2026 18:38:26 +0100 (CET)
X-CSE-ConnectionGUID: UshFL+tQQTmVwEKTn8GeZA==
X-CSE-MsgGUID: eyctGup3TIOPTLW4vWG88w==
IronPort-SDR: 69a86e12_dZdWvJdXh6ksi88oSG58CS/MJeagJXzyH/Q6TGQsjXxqQhx
 GtCcH/YRw+qvXlleq9lQ8CvxSMwalFerKdmN2Sw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GQAgDTbKhpgXf0KtRaglmCQYFnMgQLjhyIVSSBFpsyg?=
 =?us-ascii?q?VUUgWsPAQMBDVEEAQGFB40iAh4HAQQxCA4BAgQBAQEBAwIDAQEBAQEBAQEBD?=
 =?us-ascii?q?QEBBQEBAQIBAQIEBgECEAEBPQVJhlyCW4QKNgE7AgmBa4VbB6tVgQGEfNlCg?=
 =?us-ascii?q?WULFAGBOIg5IW6IGIIKgiiBFTIBgj92hAYkBYZYBIIigQ6MZIY0gWYDWSwBV?=
 =?us-ascii?q?RMXCwcFgWYDgQZuMh2BIz4XgQsbBwWFSg+KVYETgk4DC209NxQbBJIPAXoTA?=
 =?us-ascii?q?YJXBpMvAReeHpUXgj+BZwOKdZctl2AGkwQBLodlkHOjaYVYgWoDNYFcMxokT?=
 =?us-ascii?q?4JoTgMZD9Y2Q3ACBwsBAQMJkh5rYAEB?=
IronPort-PHdr: A9a23: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
 QWcnn1PdTpUP8c=
IronPort-Data: A9a23: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
 AzwUQ==
IronPort-HdrOrdr: A9a23:hC+yPqn2rdiCSu+4QjjOW1NwSvnpDfLW3DAbv31ZSRFFG/FwWf
 rAoB19726QtN9/YhAdcLy7VZVoIkmslqKdg7NwAV5zZniFhILAFugLhuHfKlbbdREWmNQw6Y
 5QN7FjE9P5EFQSt7eDkXKFOudl2cWd/qi0iaP3wh5WPHhXQpAl9htjBA6HHglXaWB9dP4EPa
 vZ/9ZdqTK8dTAMbte2b0N1OdTrlpnTiInpaQMLQwM28QXmt0LO1ILH
X-Talos-CUID: 9a23:TPjUNW3OXl5BDAODwKz+C7xfJ9slXFme0E7pH0qGFktKdLvFZlKi0fYx
X-Talos-MUID: 9a23:8MGVxgT1zvPN2bvQRXThlTp+G9pwuJiPL3gxtapapfarZXxvbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,324,1763420400"; 
   d="scan'208";a="266265928"
X-MGA-submission: =?us-ascii?q?MDGcLTp1cDaoYwGoywWkIXXeAnlD8cerknI1x7?=
 =?us-ascii?q?9DSmA76nfZG5WviPmfMyGSjipwqV35172Y4jUAa3ijYHYfHVPmCRQQCp?=
 =?us-ascii?q?dn14ul/voR8OLeH+TIPlhYX7lPd8/DGQglvf3C7kWUVV2+OOgYzS9HXB?=
 =?us-ascii?q?YhYbkcgp58ZlFZrv/c6mVEAQ=3D=3D?=
Received: from mail.avm.de ([212.42.244.119])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 18:38:26 +0100
Received: from [212.42.244.71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.55.2)
	(envelope-from <phahn-oss@avm.de>)
	id 69a86e10-2367-7f0000032729-7f000001ecfe-1
	for <cocci@inria.fr>; Wed, 04 Mar 2026 18:38:24 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS
	for <cocci@inria.fr>; Wed,  4 Mar 2026 18:38:24 +0100 (CET)
From: Philipp Hahn <phahn-oss@avm.de>
To: cocci@inria.fr
Cc: Philipp Hahn <phahn-oss@avm.de>
Date: Wed,  4 Mar 2026 18:38:11 +0100
Message-ID: <726546e758862eac541526151f085401756edc64.1772645314.git.p.hahn@avm.de>
MIME-Version: 1.0
Organization: FRITZ! Technology GmbH, Berlin, Germany
Content-Transfer-Encoding: 8bit
X-purgate-ID: 149429::1772645904-1FCBFE1F-29987137/0/0
X-purgate-type: clean
X-purgate-size: 3928
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [RFC] Coccinelle: Use IS_ERR_OR_NULL
Reply-To: Philipp Hahn <phahn-oss@avm.de>
X-Loop: cocci@inria.fr
X-Sequence: 3321
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/JytH_0S82vXdRmMkjFzEDw>

Hello,

after a colleague of mine recently gave a talk about Coccinelle, I had look
myself and created the below semantic patch to find and convert uses of
IS_ERR() plus NULL check to IS_ERR_OR_NULL() in the Linux kernel.

On 7.0.0-rc2 the patch applies to 79 files and finds most places I identified
manually. Fantastic!

There are some cases where the checks are part of a larger expression:
- mm/kmemleak.c:1095
- mm/kmemleak.c:1155
- mm/kmemleak.c:1173
- mm/kmemleak.c:1290
- mm/kmemleak.c:1328
- mm/kmemleak.c:1241
- mm/kmemleak.c:1310
- mm/kmemleak.c:1258
- net/mac80211/tx.c:4831
- net/netlink/af_netlink.c:2670
- security/keys/internal.h:367
So far I've been unable to teach Coccinelle to also generate patches for
these. Is there some easy solution to fix my patch to also handle those cases?

There are several cases where `!ptr && WARN_ON[_ONCE](IS_ERR(ptr))` is
used; they are not found and changed.
- arch/x86/kernel/callthunks.c:215 WARN_ON_ONCE
- drivers/clk/clk.c:4561 WARN_ON_ONCE
- drivers/interconnect/core.c:793 WARN_ON
- drivers/reset/core.c:718 WARN_ON
I don't expect Cocinelle to create a patch there and would ask the maintainers,
if they prefer the WARN_ON[_ONCE] to remain or would prefer changing it to
IS_ERR_OR_NULL.

drivers/clocksource/mips-gic-timer.c:283 looks suspicious: ret != clk
I'll ask the maintainer if this is on purpose or an error.


How are new semantic patches normally handled:
- are they first discussed on some mailing list?
- should I then create the individual patches myself and send them to the
  subsystem maintainers myself?
- when should the semantic patch itself be included with the Linux kernel?

Thank you for the feedback.

Philipp Hahn
---
 scripts/coccinelle/api/is_err_or_null.cocci | 86 +++++++++++++++++++++
 1 file changed, 86 insertions(+)
 create mode 100644 scripts/coccinelle/api/is_err_or_null.cocci

diff --git a/scripts/coccinelle/api/is_err_or_null.cocci b/scripts/coccinelle/api/is_err_or_null.cocci
new file mode 100644
index 0000000000000..942ba95a206f9
--- /dev/null
+++ b/scripts/coccinelle/api/is_err_or_null.cocci
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0-only
+///
+/// Use IF_ERR_OR_NULL() instead of IS_ERR() plus a check for (not) NULL
+///
+// Copyright: (C) 2026 Philipp Hahn, FRITZ! Technology GmbH.
+// Confidence: Medium
+// Options: --no-includes --include-headers
+// Keywords: IS_ERR, IS_ERR_OR_NULL
+
+virtual patch
+virtual report
+virtual org
+
+@p1 depends on patch@
+expression E;
+@@
+(
+-	E != NULL && !IS_ERR(E)
++	!IS_ERR_OR_NULL(E)
+|
+-	E == NULL || IS_ERR(E)
++	!IS_ERR_OR_NULL(E)
+|
+-	!IS_ERR(E) && E != NULL
++	IS_ERR_OR_NULL(E)
+|
+-	IS_ERR(E) || E == NULL
++	IS_ERR_OR_NULL(E)
+)
+
+@r1 depends on report || org@
+expression E;
+position p;
+@@
+(
+ 	E != NULL && ... && !IS_ERR@p(E)
+|
+ 	E == NULL || ... || IS_ERR@p(E)
+|
+ 	!IS_ERR@p(E) && ... && E != NULL
+|
+ 	IS_ERR@p(E) || ... || E == NULL
+)
+
+@script:python depends on report@
+p << r1.p;
+@@
+coccilib.report.print_report(p[0], "opportunity for IS_ERR_OR_NULL()")
+
+@script:python depends on org@
+p << r1.p;
+@@
+coccilib.org.print_todo(p[0], "opportunity for IS_ERR_OR_NULL()")
+
+@p2 depends on patch@
+identifier I;
+expression E;
+@@
+(
+-	(I = E) != NULL && !IS_ERR(I)
++	!IS_ERR_OR_NULL((I = E))
+|
+-	(I = E) == NULL || IS_ERR(I)
++	IS_ERR_OR_NULL((I = E))
+)
+
+@r2 depends on report || org@
+identifier I;
+expression E;
+position p;
+@@
+(
+*	(I = E) != NULL && ... && !IS_ERR@p(I)
+|
+*	(I = E) == NULL || ... || IS_ERR@p(I)
+)
+
+@script:python depends on report@
+p << r2.p;
+@@
+coccilib.report.print_report(p[0], "opportunity for IS_ERR_OR_NULL()")
+
+@script:python depends on org@
+p << r2.p;
+@@
+coccilib.org.print_todo(p[0], "opportunity for IS_ERR_OR_NULL()")
-- 
2.43.0

