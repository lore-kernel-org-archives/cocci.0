Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1084C48BF0
	for <cocci@archiver.kernel.org>; Fri, 16 Feb 2024 08:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=QIYw7eSbWLV7XoUbQKHEdm790KcZl0MNKg+/VA8SNvQ=;
  b=rKAkli6zinOwU2oNzn6rxAAV6XdARmie/CCRM64ggTSMPKXyP4cL68gD
   TXy1pRztH/9XWPKvYEMm22GTcpN5n8RjcxnnnisCnqCEqavW92DuclRTC
   li1aj4TsOt/GctiFg7OVXR/hm9jIMu/ld7Lt6DRVrXMJHY9VxCwshjWjO
   A=;
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@chromium.org
X-IronPort-AV: E=Sophos;i="6.06,164,1705359600"; 
   d="scan'208";a="152260698"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Feb 2024 09:56:29 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id EB982E0CE8; Fri, 16 Feb 2024 09:56:28 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 31643E008A
	for <cocci@sympa.inria.fr>; Thu, 15 Feb 2024 20:48:48 +0100 (CET)
IronPort-SDR: 65ce6a9f_68W9FenwrIReowwfHmOyVcLD/SH4wRC+9gMYP32JRr0mec6
 uDWJopFRumjcJoDSWRFhegdlfrcVOptL2wfrRUg==
X-IPAS-Result: =?us-ascii?q?A0ETAwBPas5lf6/SVdFagliCOXxWMgRTBJQTgzicc4F+D?=
 =?us-ascii?q?wEDAQwBOwkEAQEDBIR/h10CHgcBBDEIDgECBAEBAQEDAgMBAQEBAQEIAQEFA?=
 =?us-ascii?q?QEBAgEBAgQGAQIQAQEiGQcODimFbA2CXAGBHoEmAQEBAQEBAQEBAQEBHQINf?=
 =?us-ascii?q?hYgAQ0BAS4JAU5FAQUBIhMigl+CXwMRpiSBBUKMbYEBggoBAQaxHoFhAwYJA?=
 =?us-ascii?q?QqBNIx0g3tpgSEbgUlEgRWBO4E3doRYhi6CFoMSKYRbhVGPNkqBJgOBBW0bE?=
 =?us-ascii?q?B43ERATDQMIbh0CESI6AwUDBDIKEgwLHwUSQgNDBkkLAwIaBQMDBIEwBQ0aA?=
 =?us-ascii?q?hAsKAMDEkkCEBQDOAMDBgMKMTBVQQxQA00XHxoYCTwPDBoCGxsNJCMCLEADC?=
 =?us-ascii?q?QoQAhYDHRYEMhEJCyYDKgY5AhIMBgYGXSMWCQQlAwgEA1QDIXQRAwQKAxMHC?=
 =?us-ascii?q?wd4gVGBdQQTRAMQgTSKJ4E3AwkDBwVJQAMLGA1IESw1FBsGPm8Hng4Bgk+BD?=
 =?us-ascii?q?gErUJgZjk6gZIQbgWEMihuVGBozlzCScy6YKot4gXeaXwIKBwYQI4FDATeBX?=
 =?us-ascii?q?DMaCCgIgyJPAxkPly6LBiI1AjkCBwsBAQMJiSKBRgEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 b7Kq7Ox3l2r
IronPort-HdrOrdr: A9a23:c9pXnqo0ny4qbBPXSDdw8GQaV5rHeYIsimQD101hICG9vPbo8/
 xG+85rqSMc7Qx6ZJhOo6HnBEDtewK/yXcX2/hrAV7dZniehILAFugLhvqA/9SJIU3DH4VmpM
 BdmsZFebjNJGk/oMrk7Ay/Cto6hPuK4MmT9Jrj5kYoYA10Z6Rn9gtjTjyaHEp/WRVcCfMCZe
 Chz/sCiDy6Z3wNY8i3QlUDVfPSvsDGmfvdDSLuxCRJ1OBNt16VAXLBfSRwpi1uKw+nCI1CzV
 T4
X-Talos-CUID: 9a23:h4Jk72NIWi+QEO5DdQ9//UpTOuUZVFbs0kiBel+zJjcqYejA
X-Talos-MUID: 9a23:xqDV8wmn2wRhjlutHAj3dno6GvpQ/o+oInoEjL4sgfKLGT5SGjCS2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.06,162,1705359600"; 
   d="scan'208";a="79769036"
X-MGA-submission: =?us-ascii?q?MDGQFo7CCcrRi7l+1Dlps1AfBp6L4D/sunVzW/?=
 =?us-ascii?q?yaaKce8368Rj2NCBKBPv2b23qZTAtLdN8Boa7NtaOxbMDOKRTIRRa2ju?=
 =?us-ascii?q?CH9bmmGwNd5roNDWMgezxy2AUrfF+mwUw9B4SAAowjnMwBTxq7VBuUIJ?=
 =?us-ascii?q?GAHfGwyeoRzKsC3UVgoWwyGA=3D=3D?=
Received: from mail-pf1-f175.google.com ([209.85.210.175])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 20:48:46 +0100
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6da9c834646so1138023b3a.3
        for <cocci@inria.fr>; Thu, 15 Feb 2024 11:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708026525; x=1708631325; darn=inria.fr;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QIYw7eSbWLV7XoUbQKHEdm790KcZl0MNKg+/VA8SNvQ=;
        b=DYFcCDG3FAWhcAqGKUgjv2TGhi1nSGqw8QsdaP3Z/ejCHKzQQSG4MxNTxrG8BZm95F
         n5yVAwmMfnpHdqUzXtH51dPnhsKZkaIjN5oY1dglTsa/z3cLEUorVC/A72lPRS8nKiqS
         LXykeU91UysvCDJYZJBk9rZiAdlyIeEBF4VvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708026525; x=1708631325;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QIYw7eSbWLV7XoUbQKHEdm790KcZl0MNKg+/VA8SNvQ=;
        b=Ga0qfTq43cuU71MR2xQaQcXuLQSCqQCZKzg8y5/okgY3paRHKOKYgVo9k/L4FQyDhw
         M+cONE59/zlosv+13R10RRIWblypxQ80Y5FJKYrv4aTKEBdY0IEgi7qKvLgIl4UULrNw
         YqGEHJk4TUgQ/1yoGTP3lfwa1/ltThzzzU+w1YWd8P1gayWiVoa5b1RCiYdGFgUjG3nd
         DDwdIZaOx4MbqU6DkSOvzWanuk8VnjGD0A0X5JAOH7pNdKPQz01gcbplpKTkWF20mUFh
         5ReF05s8jN1JGgmIc7bggCaqUEb2bWG4qGnlv0LjJXKSZOwPhhXG5xSe7A9RUgp+5TYY
         yk1w==
X-Forwarded-Encrypted: i=1; AJvYcCXXNoQMC1m6Y2X86hPV0tA5V+5vHkFSHVZqDLyuwR4j0CQQxFRC1r42lBsuSRyBb3D6HDACI3MHGMDiYxp2QQ==
X-Gm-Message-State: AOJu0YzBCRN3gfD2V4JPiRu937ojPlfbdLh98NDJdJvfF6HWp/1o6jXt
	/K6a7szOhBA/Y/pAqEy4lpHClmNa01FCjEhjIaD6yJn3QV5iaHNei3FcBuDJyg==
X-Google-Smtp-Source: AGHT+IEM+StosCqZ55sygRnsnsOd8RG91kej8rW/CYhQnz564dOpCtuBK4/olP1fc7zPiVUQ1amuwg==
X-Received: by 2002:a05:6a00:cd1:b0:6e0:540e:bf43 with SMTP id b17-20020a056a000cd100b006e0540ebf43mr3746595pfv.33.1708026524790;
        Thu, 15 Feb 2024 11:48:44 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id fb6-20020a056a002d8600b006e06b8548c3sm1716126pfb.139.2024.02.15.11.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 11:48:44 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: Kees Cook <keescook@chromium.org>,
	Jani Nikula <jani.nikula@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	cocci@inria.fr,
	Andy Shevchenko <andy@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Date: Thu, 15 Feb 2024 11:48:38 -0800
Message-Id: <20240215194834.it.509-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2300; i=keescook@chromium.org;
 h=from:subject:message-id; bh=A5PjOGMPXIrdqCLXYAaU3KmDy3tgFDmnsiE7yKFkflo=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlzmqV+0wutn9XyekUmyiDf5ZhU6fAehM/QsZ3A
 6Ynpnw+na+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZc5qlQAKCRCJcvTf3G3A
 JqZXD/4puC6/Pv7aBKVlPmGek/tSw3eiITHz9KDqi4WWlX3vQqItXAQeju8KfX9dY1a0ahQP91u
 Rc7URV4jgOwyP8AWCvYKhgdVRL2NmKVYyzUuNm2O/599sTf5BqQdGkMHyAig/6GCb8SE2ZVs0E/
 7/2TIwUR4QkGnaS5hE6KMPCG5ai+2YWsNR8hXj4G/5YAMlGG71i/1xhu1A+8TyAAY6zHaQI3kRQ
 RbOf+1OGpnP8/PZtyGqvdsc1FgcEY0AeZ3i0zIlPKrPcpqiV2cJDf+APwO7cZkmeGGNaGpvs59b
 vUy65MOpZPsaa4Jehgw4OM5bO43Q6qjSSc1F85B9FIH/eUqs+aoT99WNZUzNVTXQevXhmjOobE8
 oVXcvqZG1hTp6q1xzSR2nK9qh8ddAniyED9xviF+U5x1M6+f3Y+de9b7tTPymr2aes3JBOp7qST
 5dSXbDhJ7VTRKmdYgQPdRc1ZswTprEB003W7km5oJwXQQJKw2EDTwTiTfsMJazs2c/jHpdL8AA8
 9/gUWv/qO7JcmpnmYZhLj6Yh2MqtbaFePZwPr4zkfqClxF+qjub6zLf104ugFgN7yzNWjgBCORX
 KVMeq8/ieRKOPl3suLvgefRMKEDUQn8lMrDceiDLIX4Y8r7v7A9QICq3rAaSYpqDZRDqF6/6O1S
 FqcHgwm 3KrGcs+w==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH v2] cocci: Add rules to find str_plural()
 replacements
Reply-To: Kees Cook <keescook@chromium.org>
X-Loop: cocci@inria.fr
X-Sequence: 1563
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/20240215194834.it.509-kees%40kernel.org>

Add rules for finding places where str_plural() can be used. This
currently finds:
 54 files changed, 62 insertions(+), 61 deletions(-)

Co-developed-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Link: https://lore.kernel.org/all/fc1b25a8-6381-47c2-831c-ab6b8201a82b@intel.com/
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Julia Lawall <Julia.Lawall@inria.fr>
Cc: Nicolas Palix <nicolas.palix@imag.fr>
Cc: cocci@inria.fr
---
 MAINTAINERS                                 |  1 +
 scripts/coccinelle/api/string_choices.cocci | 41 +++++++++++++++++++++
 2 files changed, 42 insertions(+)
 create mode 100644 scripts/coccinelle/api/string_choices.cocci

diff --git a/MAINTAINERS b/MAINTAINERS
index d0df728734c1..216d02a3fed5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8979,6 +8979,7 @@ F:	lib/string.c
 F:	lib/string_helpers.c
 F:	lib/test-string_helpers.c
 F:	lib/test_string.c
+F:	scripts/coccinelle/api/string_choices.cocci
 
 GENERIC UIO DRIVER FOR PCI DEVICES
 M:	"Michael S. Tsirkin" <mst@redhat.com>
diff --git a/scripts/coccinelle/api/string_choices.cocci b/scripts/coccinelle/api/string_choices.cocci
new file mode 100644
index 000000000000..a71966c0494e
--- /dev/null
+++ b/scripts/coccinelle/api/string_choices.cocci
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/// Find places to use string_choices.h's various helpers.
+//
+// Confidence: Medium
+// Options: --no-includes --include-headers
+virtual patch
+virtual context
+virtual report
+
+@str_plural depends on patch@
+expression E;
+@@
+(
+-	((E == 1) ? "" : "s")
++	str_plural(E)
+|
+-	((E != 1) ? "s" : "")
++	str_plural(E)
+|
+-	((E > 1) ? "s" : "")
++	str_plural(E)
+)
+
+@str_plural_r depends on !patch exists@
+expression E;
+position P;
+@@
+(
+*	((E@P == 1) ? "" : "s")
+|
+*	((E@P != 1) ? "s" : "")
+|
+*	((E@P > 1) ? "s" : "")
+)
+
+@script:python depends on report@
+p << str_plural_r.P;
+e << str_plural_r.E;
+@@
+
+coccilib.report.print_report(p[0], "opportunity for str_plural(%s)" % e)
-- 
2.34.1

