Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB764CC6B1D
	for <cocci@archiver.kernel.org>; Wed, 14 Oct 2026 14:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=0RlhzqoT3cJ+6lZeccmZxuRb0fn+HLK2OHg/odNv83M=;
  b=u5Ujy//ugFQtg0p9IMCNVd2+8RP+HqF8bqq+aWPxyIKqYv64ROJXjVSv
   sz75mV9tAXl5MDjRle+Tc3L55xD0NpwRXfmRN9sDWvPQ+totqWd35ncUY
   M7QXa3UztBdvZd6TlxDnT3grd5bLwiIQCvCTeA5vgddACLGsIthF8CoeK
   M=;
X-CSE-ConnectionGUID: zrTHyuTrQY2nVaPUvlYmtg==
X-CSE-MsgGUID: bw3dYmP9S3KzlBdXSE3ZwA==
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
X-IronPort-AV: E=Sophos;i="6.27,158,1787004000"; 
   d="scan'208";a="300198192"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 14 Oct 2026 16:19:06 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 2D0568060D; Wed, 14 Oct 2026 16:19:06 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 3B7848143C
	for <cocci@sympa.inria.fr>; Wed,  7 Oct 2026 18:43:25 +0200 (CEST)
X-CSE-ConnectionGUID: MiTOdHVHReWMfYGueVOVwg==
X-CSE-MsgGUID: FmNJdwLkSLCsZB72RsXj+g==
IronPort-SDR: 6ac676ac_DmG9arMsB+GUlazK1PbPdPnIPEa/n9t2mtbsgOiVbaL1ByF
 wIvnepAR2ANnbgKSUJGXoQr8Vqa3pYSUWLwCQcg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FTAgB0dcZqgTHdVdFaglmCQYFsMwRUjVKIeYEWijQwA?=
 =?us-ascii?q?pIhFIErPQIPAQMBCwEBUQQBAQECBDiERgKOCgIeBwEEMAkOAQIEAwIDAQEBA?=
 =?us-ascii?q?QEBAQEBAQELAQEBBAEBAQIBAQIEAwEBAQECEAEBOwcOO4ZPDYwTgSxhAgUDO?=
 =?us-ascii?q?wEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQUCLF8CAQMnC?=
 =?us-ascii?q?wENARsdAQMMBhA7IAIRAQUBHBmDAoIjAQYQAQM3A601jHEWBQIWgQGCDQaCa?=
 =?us-ascii?q?9gAChkoDXWBZgICBwkBCgEBgTeEeSpdA4I8hSR2gxlpeieCKIEVgnN2gh+BZ?=
 =?us-ascii?q?1KGMASDLoJdknsBBwcfEggBHAYIAgJIFRIDBAMEBAECCxMJAwMCDgIIAwIIB?=
 =?us-ascii?q?hkBPxIEEwIIAwYECwcFHwoCDBQKKCISKwoDNRIPEAYFFQEIBgICBAQCBAwCC?=
 =?us-ascii?q?QICBQMEAgQNAwQBAQgCAi0DAQMZCAkIAgsFERgMCwcxAxAJAx8DFBYIRQgGF?=
 =?us-ascii?q?gEaBgUGCzcVBQwRAQIbAh8EHREIAwEUBAIBCQMEFgQCFAofAgMDBgMKCQIFA?=
 =?us-ascii?q?xsYBAECAgMCAQIIAwcIAw0DBAIDAwMEAQICAQEBAgMBAwMEBAMCAQMHAgIDA?=
 =?us-ascii?q?wMLAQIDAwUDAwUFAgIFBQMFAgIKAgMDAwIBAwIaCAMGAxIBEAMDBgEDBwMHA?=
 =?us-ascii?q?gQDCQIIAwMICAMXAwMFAQICBAMDCAgEAwMEAgIDDAUDAgMDBQMDBwIEAgQDA?=
 =?us-ascii?q?wEFAQIHAgMHAgEYAwIECAcHBQILBAIIBA0JBAIEAgIPBAYDAwcBAQIBBwUGA?=
 =?us-ascii?q?wICEAEICgUGAgICHAMdAQMNBgEJBQIBBQ4HBQICGAMGAgMGBQEDAQoLAQECA?=
 =?us-ascii?q?woBAgQCBQMDAQMCAwIGAwMCBQUFAwkHBQ4JAQMDBgUCAgMCAwECCAQGBQMCA?=
 =?us-ascii?q?gMFAQMDBAMKAwIIAwMIAwwCGgIFAwMDBgkDBwcCAwcDAgUCBwUDAwUDBgEDA?=
 =?us-ascii?q?gEDAwgLFSIDAQUDAwIBAwIFAwMYAgIEBQMDAwMDCAQCAgEHBgQCAgIBBQUFB?=
 =?us-ascii?q?AUGAgQDCAEBBQMDCg0BAgcMAwwGAwcDAwQEAwIFCgIEAQcGBwcJBwMCAwcBA?=
 =?us-ascii?q?QsEAQMDCgMDBQIBAQcFAwYDBwIDAwMFBAUDAgsDBwICAwMDAicBAQEDAwMDA?=
 =?us-ascii?q?wQDAQMBAwMHAwUDAg4CCAEKAwIGAwcGAwUDAwIBAgMDBREDBgQFBhcCBhEyA?=
 =?us-ascii?q?QgCAwMBFAQEBQIFFQIIAQMFAwMDAwIFAwEFAQEDAwUDAwMDAwMEAQMEAgMHB?=
 =?us-ascii?q?ggBAQECCAMDAgUDAwMEAwMCAQ0EAgUDBgICBAIEAQcDAQICAwMDAwECBAQCB?=
 =?us-ascii?q?wQFAgwDBAIDAwUCAwIDCwYCCwQCAwMDAwMNAQILBgMUBQkECAUDDwUBBQcHC?=
 =?us-ascii?q?QEDCAUDBgMLAxQDAwYDAwMKBAIFAQYQDA4EAQIECQMCAgkJCAcMATwMBwokB?=
 =?us-ascii?q?AQMKgEVFAUEJRlnBwcCkF4egW5yUygTFC8LfkUYIoEvAQEBlT2Mc6I/SR4JA?=
 =?us-ascii?q?QYCDVSBZ4EKFQovm2CFfBozhASTT5McLpdfe4JZjzqSR4Q+AgoHBxEkEoEyO?=
 =?us-ascii?q?oFccFAxbYFJUAMZD5IkzBtCNT0CBwIHDgMLkhyBTAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:pNuCEar3agEYlWfT8ujrceQaV5o4eYIsimQD101hICG9E/bo9f
 xG+c5x6faaskd0ZJhNo7G90cq7MBDhHOBOkOws1N6ZNWGN1VdASrsD0WKI+VLd8kPFmtK1rZ
 0PT5RD
X-Talos-CUID: 9a23:yWzPwGM9EEdWkO5DfShb00I0JOAff0L4wkb/PkKGLlh2R+jA
X-Talos-MUID: 9a23:jW5g2gtTHV5N9uzCas2nqjREFst3x6eVLGsWo79Z4fOfBS4zNGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,144,1787004000"; 
   d="scan'208";a="299011732"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDEQizdm6p1e7jp8OatNUz4gQR8vDTHPLBvnIm?=
 =?us-ascii?q?P9/ERz9obWFRQk//g6tdgyWO0viX+yMan8NbN0y/2VfRB+M+DPfUz4EW?=
 =?us-ascii?q?EJUBAou11sWppuuSD5SoxMdR6u2Cl+sqrkuBeUhkywLtNiLOuKIlIzyL?=
 =?us-ascii?q?tsPEPsHzJl4kUXuFPuOPFoig=3D=3D?=
Received: from mail-wr1-f49.google.com ([209.85.221.49])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 18:43:24 +0200
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48afbd2c386so1699517f8f.3
        for <cocci@inria.fr>; Wed, 07 Oct 2026 09:43:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791391404; x=1791996204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0RlhzqoT3cJ+6lZeccmZxuRb0fn+HLK2OHg/odNv83M=;
        b=ClYM4VP6oFaNfSQLtSprJUbXV48HY31KNNmAuuAxfKxrdcb4FX7ast9lK07sc1c6Uq
         Rzv27L4Jtm6FHuzfZhJDuGUhuhQylAWrZB5smMtVozClWCx/4qQjFubOLnSGN2Eiykh5
         4/jcskbM1sfT/KjPsVfMaLLzBGp/OWc83FfaaPX+9ArVvQqjDzNrOGg5pjecMCy38EMr
         H+xqS9ZRGezKRGRkn7tOHwHiu7GXR7uI1AFiQTjgW/cWl+3wCpdXFscIe5uGQb079bSY
         rSU4LrKDu6LktXm8Zt4yx3TU3vbqeBdQRVmfiUQQR+JhsMj8OZX6k3yx4PpQRaFzwJm9
         Oc5g==
X-Forwarded-Encrypted: i=1; AKwUvByULqtO1mTeDozfB7inZQmwK5Oex9lTZyQQU91YJ3yFfntAYW/a4vVBTQq38WStZ12gQJSOQw==@inria.fr
X-Gm-Message-State: AFuF++nUEpNQN0PRxxidTXL4O/EhiM78f3rIZPd/v1F8Rww0TJY9O3S8
	RtDj5IFfdPstD2LJL5OiVk8bmntcHVnrprFchdYF1e5apVwIdoB0N0YNni+o6Q==
X-Gm-Gg: AYBFou2UnE6CEUr1y+1W3aAZ0sAs7BW52UTu38HB0jsOE+aGshHRZXujXGuXL0Jp+3S
	YNP3Gs4p3CNLeC3wlfVW4UHoDdkqjjm0GiJN+oodA8cXcmWdpAxcdGH1SY7/hgj5N4mQl+PWVg8
	qYoVkxC+zXSWGS3FGCwx4+0czsNlLBFWDyKNt43dWgubgcs9B6G3m0QPLS/m2YKU+s/j3CAF8O5
	O+sL6dXW+uT/PdTpXlBK9J1gzTsjApWAM0e2bX51/+55v7ljptHccGw6DifudjXzBmlGRRj8rWi
	f/OJegbJXtu6RIeXOALLnICMPheFMmO4DoiUXx+aiwhR1hW6YKVDfqgi+7T4RDcc8+KKh/S2d9C
	aqdMN09SGTc/LYxVBRCnOtGxHDfKhzZrmMV75tEU8K+na5ogCtTswfYjnJyPoshElFYFgBB0qf9
	ndi5YuEGstod2tb4eKif67PR0Om++XTZKWNq4TiHR5Lk2YZR3OW7yIBg7Rug9VdMKU6oih+lIok
	9x8N1tuA0x4lb88qni+yQGJo2RsMtrF7wFp63XnBsjNH7Zd+RHA
X-Received: by 2002:a05:600c:1c03:b0:49f:ff32:803c with SMTP id 5b1f17b1804b1-4a180423bd2mr56190855e9.16.1791391404162;
        Wed, 07 Oct 2026 09:43:24 -0700 (PDT)
Received: from ptb-02009389.paris.inria.fr (wifi-pro-83-031.paris.inria.fr. [128.93.83.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d2eeb6sm6373096f8f.43.2026.10.07.09.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 09:43:23 -0700 (PDT)
From: Ella Ma <alansnape3058@gmail.com>
To: julia.lawall@inria.fr
Cc: alansnape3058@gmail.com,
	cocci@inria.fr,
	linux-kernel@vger.kernel.org,
	nicolas.palix@imag.fr
Date: Wed,  7 Oct 2026 18:43:16 +0200
Message-Id: <20261007164316.15102-1-alansnape3058@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ec578f57-a7f5-7afc-ec2-9156c336187@inria.fr>
References: <ec578f57-a7f5-7afc-ec2-9156c336187@inria.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH v3] coccinelle: free: add a checker for
 `__cleanup(kfree)` usage
Reply-To: Ella Ma <alansnape3058@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3749
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-10/ZIvxkyHc4e8WJbFPDMXPIw>

Using __cleanup(kfree) will pass the stack address of the annotated
local variable to kfree functions. This will lead to invalid
deallocation issues. Inspired by CVE-2026-45959 and similar bugs
recently detected.

Signed-off-by: Ella Ma <alansnape3058@gmail.com>
---

Changes in v2:
- Add virtual rules `report` and `org` as suggested by Sashiko
- Remove `kvfree_sensitive` from rule `cleanup` as suggested by Sashiko
- Add `free_percpu` to rule `free`
- Add `kfree_const` to rule `cleanup`

Changes in v3:
- Edit the error messages to clarify the reasons and results

 scripts/coccinelle/free/cleanup-free.cocci | 112 +++++++++++++++++++++
 1 file changed, 112 insertions(+)
 create mode 100644 scripts/coccinelle/free/cleanup-free.cocci

diff --git a/scripts/coccinelle/free/cleanup-free.cocci b/scripts/coccinelle/free/cleanup-free.cocci
new file mode 100644
index 000000000000..48e47ed2186a
--- /dev/null
+++ b/scripts/coccinelle/free/cleanup-free.cocci
@@ -0,0 +1,112 @@
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
+virtual report
+virtual org
+
+// Suggesting using __free for the functions with a DEFINE_FREE definition.
+// Update this list when new DEFINE_FREE definitions are added.
+@free@
+attribute name __cleanup;
+symbol kfree, kfree_sensitive, kvfree, kvfree_atomic, free_percpu;
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
+  kfree \| kfree_sensitive \| kvfree \| kvfree_atomic \| free_percpu
+)
+)
+  );
+|
+  T v __cleanup@p(
+(
+  n
+&
+(
+  kfree \| kfree_sensitive \| kvfree \| kvfree_atomic \| free_percpu
+)
+)
+  ) = ...;
+)
+
+@script:python depends on report@
+p << free.p;
+n << free.n;
+@@
+
+msg = f"ERROR: __cleanup({n}) will cause an invalid free: the stack address of the annotated variable will be passed to {n}; use __free({n}) to free the pointee"
+coccilib.report.print_report(p[0], msg)
+
+@script:python depends on org@
+p << free.p;
+n << free.n;
+@@
+
+msg = f"ERROR: __cleanup({n}) will cause an invalid free: the stack address of the annotated variable will be passed to {n}; use __free({n}) to free the pointee"
+coccilib.org.print_todo(p[0], msg)
+
+
+// Reporting __cleanup usage for the functions without a DEFINE_FREE definition.
+// The following list only contains frequently used functions. Supplement it if
+// necessary.
+@cleanup@
+attribute name __cleanup;
+symbol vfree, vfree_atomic, kfree_const;
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
+  vfree \| vfree_atomic \| kfree_const
+)
+)
+  );
+|
+  T v __cleanup@p(
+(
+  n
+&
+(
+  vfree \| vfree_atomic \| kfree_const
+)
+)
+  ) = ...;
+)
+
+@script:python depends on report@
+p << cleanup.p;
+n << cleanup.n;
+@@
+
+msg = f"ERROR: __cleanup({n}) will cause an invalid free: the stack address of the annotated variable will be passed to {n}"
+coccilib.report.print_report(p[0], msg)
+
+@script:python depends on org@
+p << cleanup.p;
+n << cleanup.n;
+@@
+
+msg = f"ERROR: __cleanup({n}) will cause an invalid free: the stack address of the annotated variable will be passed to {n}"
+coccilib.org.print_todo(p[0], msg)
-- 
2.34.1

