Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED8BC83F09
	for <cocci@archiver.kernel.org>; Sat,  5 Jul 2025 13:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=hkN8L9xgqGTz5SjbY2lKznqJQajE7JkxLsFT/BgDVSM=;
  b=lpLf3B67BRKArbBF2sBZ++T38BjXbJNIUQJ2tEgiVS688x1j4U2magra
   BEnsVUJ2dQX92tpceq6Gk3AqcK+abL3TDNlncW6rS7UnRmx4ak6gj7vt1
   4dP9Axh8jH9QkC9GYnmRxXBXKeKOP882syfC00qtL4clGazMCYYMlICrY
   U=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@linux.microsoft.com
X-IronPort-AV: E=Sophos;i="6.16,290,1744063200"; 
   d="scan'208";a="230456032"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Jul 2025 15:35:41 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D5B80E0CE0; Sat,  5 Jul 2025 15:35:40 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id D1D1CE0157
	for <cocci@sympa.inria.fr>; Fri,  4 Jul 2025 00:52:16 +0200 (CEST)
IronPort-SDR: 686709a0_8YoWZcVKRC5iG6z57Dy+Hj04gXP7I0REmiKO+L/mYhWxNfN
 ZA3Fk/7YM2LFW/kw3wr85Ccf+Ol2wLLVLPNjs5Q==
X-IPAS-Result: =?us-ascii?q?A0EQAAD0CGdohbaaTQ1aHAEBAQEBAQcBARIBAQQEAQGBf?=
 =?us-ascii?q?wcBAQsBgkOBAFozBwgaLwSMbYlVi3eGT4tTFIEsPQIPAQMBUQoBAgQBAQMEh?=
 =?us-ascii?q?QCLfAIfBgEEMAkOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABA?=
 =?us-ascii?q?QEBQEmFew2CYgGBJFENSAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBARECDV4BA?=
 =?us-ascii?q?SAVIQENAQE3AYE8ARKDAgGCIQdGBgIMmmYBh2ABAQKKKYIsgQGCDAEBBtwjg?=
 =?us-ascii?q?WUDBoFJAY1NgTSCUGl6JxuBSUSBSoI9dmmDHVKGL4ImgRaCV484hldIgR4DW?=
 =?us-ascii?q?SwBVRMNCgsHBYEwMwMgCgsMCxIcFQIULw8EFjIdcwwoEoZshCsrT4QaeIRsJ?=
 =?us-ascii?q?G0PBoEfgRFAAwsYDUgRLDcGDhtEbgeRfYMrgQ4sjQ+bCaELhCWMHZU3GjMaq?=
 =?us-ascii?q?kcBLodlkHIii2yBeZV9GDeEN4IaOoFcRgcjFYMiEzwDGQ+OIRklg0KFE7x2I?=
 =?us-ascii?q?zUCATkCBwsBAQMJhUUBAQGIDIFLAQE?=
IronPort-PHdr: A9a23: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
 55Lm6+8U0Ep0avXEhUCL83ZLg9JKcFV8SqLFRs=
IronPort-Data: A9a23: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
 wSR
IronPort-HdrOrdr: A9a23:+vYPVa0pzMVSP9eHO4G1ogqjBLokLtp133Aq2lEZdPWaSKKlfq
 eV7ZAmPX2dslwssRQb9OxoV5PhfZqxz/JICOoqTNKftWvdyQiVxehZhOOI/9SKIUzDH4Bmup
 uIC5IOauHNMQ==
X-Talos-CUID: 9a23:FRiP622fLu3K7A+KYHVT1LxfG94LQ3LmxmzrIGSfFV9uR5+1FXXO9/Yx
X-Talos-MUID: 9a23:ZMJZjARf+DcWSHDTRXSwhx5tMcVwsp2CLxwCz7oNsPeYOi9JbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,285,1744063200"; 
   d="scan'208";a="120647454"
X-MGA-submission: =?us-ascii?q?MDEAzhzht8BbQKG2xwnBluc8gJGXCPnSS/LzF9?=
 =?us-ascii?q?2zk+0KcPArSW41judKc1sMORmTG9gzd+nq32pmHWh97wkG65fr7U0XzO?=
 =?us-ascii?q?QoKVXZB8a/N50pWLFlX3gE9oqRh7LBqyE1U+onY92vnCSXZhrsw+ixhv?=
 =?us-ascii?q?Rse0iZ6mXw8tGTITiPEZSRSQ=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail3-smtp-sop.national.inria.fr with ESMTP; 04 Jul 2025 00:52:16 +0200
Received: from gem-name-lb-02.localdomain (unknown [20.29.225.195])
	by linux.microsoft.com (Postfix) with ESMTPSA id C97C52112234;
	Thu,  3 Jul 2025 15:52:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C97C52112234
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1751583133;
	bh=hkN8L9xgqGTz5SjbY2lKznqJQajE7JkxLsFT/BgDVSM=;
	h=From:To:Cc:Subject:Date:From;
	b=sbpVjUub2Vsk1TkQ1ZGCLm706D8CpRnhbjwpwNJjcBSBcuJrcxd74qVAgZ/GzgiIL
	 Q/StG9Dr330EVko5xEjZugWVNVG1lwSRcJb8GkAmS/NwN5+dl3LnhyTU7Ot7fOXs1q
	 Oiz1spIN8L6+adLRfiB8BT4WQ/1yICoN1EeFDeWA=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
To: Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	cocci@inria.fr (moderated list:COCCINELLE/Semantic Patches (SmPL)),
	linux-kernel@vger.kernel.org (open list)
Cc: Jakub Kicinski <kuba@kernel.org>,
	Ricardo Ribalda <ribalda@chromium.org>
Date: Thu,  3 Jul 2025 15:51:32 -0700
Message-ID: <20250703225145.152288-1-eahariha@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [RESEND PATCH] coccinelle: misc: secs_to_jiffies: Implement
 context and report modes
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2854
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/20250703225145.152288-1-eahariha%40linux.microsoft.com>

As requested by Ricardo and Jakub, implement report and context  modes
for the secs_to_jiffies Coccinelle script. While here, add the option to
look for opportunities to use secs_to_jiffies() in headers.

Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Ricardo Ribalda <ribalda@chromium.org>
Closes: https://lore.kernel.org/all/20250129-secs_to_jiffles-v1-1-35a5e16b9f03@chromium.org/
Closes: https://lore.kernel.org/all/20250221162107.409ae333@kernel.org/
Tested-by: Ricardo Ribalda <ribalda@chromium.org>
Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 scripts/coccinelle/misc/secs_to_jiffies.cocci | 49 +++++++++++++++++--
 1 file changed, 44 insertions(+), 5 deletions(-)

diff --git a/scripts/coccinelle/misc/secs_to_jiffies.cocci b/scripts/coccinelle/misc/secs_to_jiffies.cocci
index 416f348174ca..f3241ce75a7b 100644
--- a/scripts/coccinelle/misc/secs_to_jiffies.cocci
+++ b/scripts/coccinelle/misc/secs_to_jiffies.cocci
@@ -7,26 +7,65 @@
 // Confidence: High
 // Copyright: (C) 2024 Easwar Hariharan, Microsoft
 // Keywords: secs, seconds, jiffies
-//
+// Options: --include-headers
 
 virtual patch
+virtual report
+virtual context
 
-@depends on patch@ constant C; @@
+@pconst depends on patch@ constant C; @@
 
 - msecs_to_jiffies(C * 1000)
 + secs_to_jiffies(C)
 
-@depends on patch@ constant C; @@
+@pconstms depends on patch@ constant C; @@
 
 - msecs_to_jiffies(C * MSEC_PER_SEC)
 + secs_to_jiffies(C)
 
-@depends on patch@ expression E; @@
+@pexpr depends on patch@ expression E; @@
 
 - msecs_to_jiffies(E * 1000)
 + secs_to_jiffies(E)
 
-@depends on patch@ expression E; @@
+@pexprms depends on patch@ expression E; @@
 
 - msecs_to_jiffies(E * MSEC_PER_SEC)
 + secs_to_jiffies(E)
+
+@r depends on report && !patch@
+constant C;
+expression E;
+position p;
+@@
+
+(
+  msecs_to_jiffies(C@p * 1000)
+|
+  msecs_to_jiffies(C@p * MSEC_PER_SEC)
+|
+  msecs_to_jiffies(E@p * 1000)
+|
+  msecs_to_jiffies(E@p * MSEC_PER_SEC)
+)
+
+@c depends on context && !patch@
+constant C;
+expression E;
+@@
+
+(
+* msecs_to_jiffies(C * 1000)
+|
+* msecs_to_jiffies(C * MSEC_PER_SEC)
+|
+* msecs_to_jiffies(E * 1000)
+|
+* msecs_to_jiffies(E * MSEC_PER_SEC)
+)
+
+@script:python depends on report@
+p << r.p;
+@@
+
+coccilib.report.print_report(p[0], "WARNING opportunity for secs_to_jiffies()")
-- 
2.43.0

