Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C21C282D0
	for <cocci@archiver.kernel.org>; Tue,  4 Mar 2025 09:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   reply-to:mime-version:content-transfer-encoding:subject:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=DocaNsuHjM+N41rLqaAWsZ7H9Gb/g9wp09AAVVo026g=;
  b=M8QgTemUkmJMLO5WXnn2R1B+wbMqn9P/olqOzSbe6AlI2JPYkYC1EjI5
   QfPv9k92Ym5p5aj9GoNdlssJQGarWj+rp5jDDyYEfqI6udY2rOxymhU9X
   XV+81dwMysLnEzwPegaJLMJ62GUqiH71r9rCpJxPA+Px4C/65WBVyhY3V
   Y=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
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
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@seltendoof.de
X-IronPort-AV: E=Sophos;i="6.13,331,1732575600"; 
   d="scan'208";a="211068896"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Mar 2025 10:58:52 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id AB50BE0DC5; Tue,  4 Mar 2025 10:58:41 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 4F0FBE0264
	for <cocci@sympa.inria.fr>; Sun,  2 Mar 2025 17:07:19 +0100 (CET)
IronPort-SDR: 67c48236_7wNTvUxVVYECBOvV3boVjKjLxK4mt7r95RQtuXCqSy7TzvZ
 7+pY/6BV7eYAOniwLYTe3Nk6my+re9bW8G3u93g==
X-IPAS-Result: =?us-ascii?q?A0EEAAAngcRn/6Mwd6haGQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RIBAQEBAQEBAQEBAQFAgT8EAQEBAQELAQGCQgdpC1s0BAseKoRWiB2JUwOBE?=
 =?us-ascii?q?5A0jE0UDIFeDwEDAQ1EBAEBAwEDhQACixUCHgcBBDAJDgECBAEBAQEDAgMBA?=
 =?us-ascii?q?QEBAQEQAQEFAQEBAgEBAgQGAQKBChOFew1JAQwBggs0ghYsgQIJAgEDIw8BD?=
 =?us-ascii?q?QEBNwEPIAUCGA4CAj0BGBlbgicBgjABAQExA68rgTKBAYIMAQEGglDYLwQKG?=
 =?us-ascii?q?g2BMYEgCYEaLgGITgGFa4MUaXonG4INgRWBO4E3doIfgWcUhAQWglOCM4Fqg?=
 =?us-ascii?q?z2Wa4MajloHYV4cA4FuFxKBdgOBD4FFRDeCRWlJOg83gh6DJ4ROgx2BfC8DA?=
 =?us-ascii?q?wMDjQAUhEECAoNrgy+BbU1UDAttPTcILT0IQh0SoHU6hDoHAYENAS8dLmBlC?=
 =?us-ascii?q?w2TDS6DI697C4I/gWaKeJZQTZdTkwOIMLRHARiFHmCBBz2BWXFPgR4JCxqBG?=
 =?us-ascii?q?08DGQ+OIYQtyCNFMjwCBwEKAQEDCYI5imSCSzSBSwE?=
IronPort-PHdr: A9a23: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
 d/B0q7+em4qGzf85sYYG8XSJMWAPjwtPEixcAM=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:ftiak691MGrOr1BfcnBuk+DZI+orL9Y04lQ7vn2ZhyY4TiX+rb
 HIoB17726RtN91YhsdcL+7VpVoLUm2yXcx2+ks1NSZLWzbUQmTTb2KhLGKqwEIWReOldK1s5
 0QEZSWY+eeMbEVt6vH3DU=
X-Talos-CUID: =?us-ascii?q?9a23=3ArkFyQGiEh8kb5HUb3rK77ZX6ITJubn7QnVTaPx+?=
 =?us-ascii?q?DUyVsWYzFa1aw4J1rnJ87?=
X-Talos-MUID: =?us-ascii?q?9a23=3Ac9q0kQ/zzSodTznwlUC6h2+Qf856/KOrJXkzraQ?=
 =?us-ascii?q?lpsSjaWtXYm6dvCviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,327,1732575600"; 
   d="scan'208";a="210743793"
X-MGA-submission: =?us-ascii?q?MDG+mmmYYgUYyz6HNWTNHccPI6A+KxBweHzc9I?=
 =?us-ascii?q?qbRoJZVauaZc1+KgbpwR3ii6RsnG4a9p1W/YHP47g+cVwtpCC67tUBpU?=
 =?us-ascii?q?gyOQKCsn6ju+ndQMvd11oZNQ85flSYbmQAYoEIt78H+PdpgVrEPwJwt/?=
 =?us-ascii?q?9c88fcLspj2fVlK8DTUFemyQ=3D=3D?=
Received: from server02.seltendoof.de ([168.119.48.163])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 17:07:19 +0100
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1740931638;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DocaNsuHjM+N41rLqaAWsZ7H9Gb/g9wp09AAVVo026g=;
	b=I8Us6+wwEBsSw3c/3WEDogDmTjcrUN78W4pRQk/r8mUCE4HL31uoClsJaAivN/3V/6XqD8
	BADNH6reL9sZ1mS76cvitfZJDq3G1BGl+enF4gm2K8k32JUnxEyAUcqOxUGsmrOA1D17BU
	j2QbCRtr+f0eRBa9AGgDd63jkxRchptmeA4Al/MXKqCbWsQar+koAeeJtx/zXrtfUPIdyM
	vWfOfR2T8mkQ84ROq/wPTQdQbX6HOzsQBKMTC3V4XgBydnCuO05Lg5hslRvQBmxn56F5OE
	jZ7z+rIuMwFKWRm4XYAEEFsV7U6Vfxk9y/J4DSWMND/c+kbkc34Hf3CVBRSG4w==
To: 
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Serge Hallyn <serge@hallyn.com>,
	Jan Kara <jack@suse.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	cocci@inria.fr
Date: Sun,  2 Mar 2025 17:06:48 +0100
Message-ID: <20250302160657.127253-11-cgoettsche@seltendoof.de>
In-Reply-To: <20250302160657.127253-1-cgoettsche@seltendoof.de>
References: <20250302160657.127253-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH v2 01/11] coccinelle: Add script to reorder
 capable() calls
X-Loop: cocci@inria.fr
X-Sequence: 2497
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/20250302160657.127253-11-cgoettsche%40seltendoof.de>

From: Christian Göttsche <cgzones@googlemail.com>

capable() calls refer to enabled LSMs whether to permit or deny the
request.  This is relevant in connection with SELinux, where a
capability check results in a policy decision and by default a denial
message on insufficient permission is issued.
It can lead to three undesired cases:
  1. A denial message is generated, even in case the operation was an
     unprivileged one and thus the syscall succeeded, creating noise.
  2. To avoid the noise from 1. the policy writer adds a rule to ignore
     those denial messages, hiding future syscalls, where the task
     performs an actual privileged operation, leading to hidden limited
     functionality of that task.
  3. To avoid the noise from 1. the policy writer adds a rule to permit
     the task the requested capability, while it does not need it,
     violating the principle of least privilege.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
Reviewed-by: Serge Hallyn <serge@hallyn.com>
---
 MAINTAINERS                                |  1 +
 scripts/coccinelle/api/capable_order.cocci | 98 ++++++++++++++++++++++
 2 files changed, 99 insertions(+)
 create mode 100644 scripts/coccinelle/api/capable_order.cocci

diff --git a/MAINTAINERS b/MAINTAINERS
index 8e0736dc2ee0..b1d1c801765b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5196,6 +5196,7 @@ F:	include/linux/capability.h
 F:	include/trace/events/capability.h
 F:	include/uapi/linux/capability.h
 F:	kernel/capability.c
+F:	scripts/coccinelle/api/capable_order.cocci
 F:	security/commoncap.c
 
 CAPELLA MICROSYSTEMS LIGHT SENSOR DRIVER
diff --git a/scripts/coccinelle/api/capable_order.cocci b/scripts/coccinelle/api/capable_order.cocci
new file mode 100644
index 000000000000..4150d91b0f33
--- /dev/null
+++ b/scripts/coccinelle/api/capable_order.cocci
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0-only
+///
+/// Checks for capable() calls of the left side of a binary expression.
+/// Reordering might avoid needless checks, LSM log messages, and more
+/// restrictive LSM security policies (e.g. SELinux).
+/// Can report false positives if the righthand side contains a nested
+/// capability check or has side effects.
+///
+// Confidence: Moderate
+// Copyright: (C) 2024 Christian Göttsche.
+// Options: --no-includes --include-headers
+// Keywords: capable, ns_capable, sockopt_ns_capable
+//
+
+virtual patch
+virtual context
+virtual org
+virtual report
+
+//----------------------------------------------------------
+//  Pattern to ignore
+//----------------------------------------------------------
+
+@ignore@
+identifier F1 = { capable, ns_capable, sockopt_ns_capable };
+identifier F2 = { capable, ns_capable, sockopt_ns_capable };
+binary operator op,op1,op2;
+expression E;
+position p;
+@@
+
+(
+F1@p(...) op F2(...)
+|
+E op1 F1@p(...) op2 F2(...)
+)
+
+
+//----------------------------------------------------------
+//  For patch mode
+//----------------------------------------------------------
+
+@ depends on patch@
+identifier F = { capable, ns_capable, sockopt_ns_capable };
+binary operator op,op1,op2;
+expression E,E1,E2;
+expression list EL;
+position p != ignore.p;
+@@
+
+(
+-  F@p(EL) op E
++  E op F(EL)
+|
+-  E1 op1 F@p(EL) op2 E2
++  E1 op1 E2 op2 F(EL)
+)
+
+
+//----------------------------------------------------------
+//  For context mode
+//----------------------------------------------------------
+
+@r1 depends on !patch exists@
+identifier F = { capable, ns_capable, sockopt_ns_capable };
+binary operator op,op1,op2;
+expression E, E1, E2;
+position p != ignore.p;
+@@
+
+(
+*  F@p(...) op E
+|
+*  E1 op1 F@p(...) op2 E2
+)
+
+
+//----------------------------------------------------------
+//  For org mode
+//----------------------------------------------------------
+
+@script:python depends on org@
+p << r1.p;
+@@
+
+cocci.print_main("WARNING opportunity for capable reordering",p)
+
+
+//----------------------------------------------------------
+//  For report mode
+//----------------------------------------------------------
+
+@script:python depends on report@
+p << r1.p;
+@@
+
+msg = "WARNING opportunity for capable reordering"
+coccilib.report.print_report(p[0], msg)
-- 
2.47.2

