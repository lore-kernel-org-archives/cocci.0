Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0CECCAC5AE
	for <cocci@archiver.kernel.org>; Wed, 24 Sep 2025 14:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=T0+3uqja+AcM3h5mmWLoH6MCphRpuvic80vfhVRNM+s=;
  b=ckW+87F6Ysj7fSG2Rua/k9Zqj7aVXJxLa7YTeXxu70KWYfrSGVij6kng
   TM6ZaiwF5R4uxYL6HxtSY3i44QX05H5erj8jPxi3qU/ntZTpeLomaN0GR
   rcMzvyhoJTLeQSfM+HRNhKskBA14Y1V4YopU6H4xqemKdiSmtdbD5bRM7
   k=;
X-CSE-ConnectionGUID: lm1Sq9e3T96ioRBrI+7ilg==
X-CSE-MsgGUID: M2vH60chQUGXu57JsLIshQ==
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@ispras.ru
X-IronPort-AV: E=Sophos;i="6.18,290,1751234400"; 
   d="scan'208";a="240836928"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Sep 2025 16:02:41 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id AE42BE0CD5; Wed, 24 Sep 2025 16:02:40 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 41DEFE0171
	for <cocci@sympa.inria.fr>; Wed, 24 Sep 2025 16:02:39 +0200 (CEST)
X-CSE-ConnectionGUID: y7WIqhiZQ6q/tj8BYpTOgg==
X-CSE-MsgGUID: Hb/iZH0vTVO5Ag4ugRHB8A==
IronPort-SDR: 68d3f9fd_tXomDl6uSbnyiyHSzEiXEdsxoCZ8hOtKBanM/wQoP2lYlpO
 0YeqUy42wmah+M2q+K5bjtDcyi4JGaJ6IHaVgNQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0F3HwB6+NNoclTHlVNaHAEBAQEBAQcBARIBAQQEAQGCE?=
 =?us-ascii?q?4JAgQJZNAQLSZQlgiGeMYFpAg8BAwENPRQEAQEDBIJVgiuMRAIeBwEENBMBA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEBgECEAGBDIZPDYJiAYEkg?=
 =?us-ascii?q?SYBAQEBAQEBAQEBAQEdAg0HeSsLAQ0BATcBgTwBEoMCAYIiB0kHDbYVgXkzg?=
 =?us-ascii?q?QGCDAEBBtwlgWQDBoFJjU2BNIJQaXongWREgRWBO4ItaYMdUoYvgzyCaIEmg?=
 =?us-ascii?q?iiJeoJbikFIgR4DWSwBFj8TDQoLBwWBYwMqCwwLEhwVbjIdgSeFC4QdK0+FA?=
 =?us-ascii?q?oRrJGsPBoEVgWSBdwaIKEADCxgNSBEsNxQbBj5uB5ZTgzQBVyMTARMYgSB/l?=
 =?us-ascii?q?m8BjwuhFAeEH4welTkaM5kTkVcBmQYii2yBepVaP4UggX8jgVwzGjKDKBM8A?=
 =?us-ascii?q?xkPjiEMFohxgQPDDkMyAgEBOAIHCwEBAwmSHoFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:htKlXKxkGd2tFcXlob45KrPwKb1zdoMgy1knxilNoH1uA6ulfq
 WV8ZsmPHDP6Qr5NEtBpTniAtjlfZq/z+8W3WB5B97LN2OL1ldAR7sSiLcKtgeQYxEWgdQtrp
 uIHZIOa+EYdWIK9PoStzPIdeod/A==
X-Talos-CUID: 9a23:97Crnm5NMpavsF83v9ss5RErO9klc0/kkm6XP03oI1dxdJqaRgrF
X-Talos-MUID: 9a23:Kvy3SgnjWMjv1pZ/sXtmdnpCPoBp0YT2FnwztsgvtJWZOhZQEWe02WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,290,1751234400"; 
   d="scan'208";a="126463729"
X-MGA-submission: =?us-ascii?q?MDGCjSyOH0BlKJ27Z4nGZsnVbcRYZW1ahHx4Ix?=
 =?us-ascii?q?4ie87ltuLULKCpeiXvfqWufookBc+srG5YESHL27kkTAbSSYdj1qvBu2?=
 =?us-ascii?q?6mkIah41Q/sJhqxftbJ9Mlbb83BrL1jUPDhmoXUXCtQkHYSKcyLeDsil?=
 =?us-ascii?q?fE421ZOuqV+kS36F2ozt1Mvg=3D=3D?=
Received: from mail.ispras.ru ([83.149.199.84])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 16:02:36 +0200
Received: from petrov-tower.intra.ispras.ru (unknown [10.10.2.58])
	by mail.ispras.ru (Postfix) with ESMTPSA id 67E5B402837E;
	Wed, 24 Sep 2025 14:02:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 67E5B402837E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1758722553;
	bh=T0+3uqja+AcM3h5mmWLoH6MCphRpuvic80vfhVRNM+s=;
	h=From:To:Cc:Subject:Date:From;
	b=jnyhz+dVVoAGjN7Ld89McMTj9+MUNsLcickFRlb5ZL9rAlGNExS+L8tKJs4uhjeyG
	 09A8bmFobZTnQZ1W4vXqaOiPltZjn3KJW8xBWMWvAM7DwAysMsMKyyb7bNujhxAvQX
	 yjE/LDFUpap7RBzBeY6T7POH1g/VD51pvBY7xIGo=
From: Oleg Petrov <o.petrov@ispras.ru>
To: Julia Lawall <Julia.Lawall@inria.fr>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Oleg Petrov <o.petrov@ispras.ru>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	cocci@inria.fr,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	Vadim Mutilin <mutilin@ispras.ru>,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Date: Wed, 24 Sep 2025 17:01:26 +0300
Message-Id: <20250924140126.23027-1-o.petrov@ispras.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [cocci] [PATCH] cocci: drm: report devm-allocated arguments and
 fields
Reply-To: Oleg Petrov <o.petrov@ispras.ru>
X-Loop: cocci@inria.fr
X-Sequence: 3033
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-09/20250924140126.23027-1-o.petrov%40ispras.ru>

Add two Coccinelle rules: (1) flag a devres-managed pointer
passed to a drm-init function, and (2) flag a devres-managed
pointer assigned to a field of drm-managed struct. The mismatch
of the lifespan between devres- and drm-managed memory can cause
a use-after-free error. The rules' have high confidence.

badarg: Report when a pointer to devres-managed memory is passed
   as the second argument to several drm_*_init* functions that
   (a) have such rule documented or (b) are some simple wrappers
   to such a function.

badarg2: The same, but pass the devm-allocated pointer through
   an intermediate variable before passing to a drm-init function.

badfield: Report when a devm-allocated pointer is assigned to a
   field of a drm-managed struct.

Found by Linux Verification Center (linuxtesting.org).

Signed-off-by: Oleg Petrov <o.petrov@ispras.ru>
---
v1: Among drivers/gpu/drm, Coccinelle finds 7 functions (b) that call
functions (a). I included 5 of those in the rule. I did not check other files.
The functions are the same for v6.1+.
Patch https://lore.kernel.org/all/20240216125040.8968-1-e.orlova@ispras.ru/
fixes such violations in stm module. badargs are obvious from diff,
and the badfield is fixed in first lines where ldev is allocated.
 .../coccinelle/api/drm_dont_devm_alloc.cocci  | 124 ++++++++++++++++++
 1 file changed, 124 insertions(+)
 create mode 100644 scripts/coccinelle/api/drm_dont_devm_alloc.cocci

diff --git a/scripts/coccinelle/api/drm_dont_devm_alloc.cocci b/scripts/coccinelle/api/drm_dont_devm_alloc.cocci
new file mode 100644
index 000000000000..693977e98666
--- /dev/null
+++ b/scripts/coccinelle/api/drm_dont_devm_alloc.cocci
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: GPL-2.0-only
+///
+/// Find (1) devres-allocated (usually by devm_kzalloc) argument to drm_*_init
+/// functions or (2) assignment of devres-allocated pointer to a field of a drm-
+/// allocated struct (usually dev_private of drm_device). The mismatch of the
+/// lifespan between devres- and drm-managed memory can cause a use-after-free.
+//
+// Confidence: High
+// Copyright: (C) 2025 Oleg Petrov ISPRAS
+// Options: --no-includes --include-headers
+//
+
+virtual report
+virtual org
+
+// find devm-allocated (devres-managed) second arg for drm*init functions
+@badarg exists@
+position p;
+expression devm,e;
+@@
+// only devm_kzalloc is really used
+devm = \(devm_kzalloc\|devm_kcalloc\|devm_kmalloc\|devm_kmalloc_array\)(...);
+...
+// The kernel-doc comments (v6+) for these 5 functions
+// forbid them to use devm-allocated argument.
+( drm_connector_init
+| drm_crtc_init_with_planes
+| drm_connector_init_with_ddc
+| drm_encoder_init
+| drm_universal_plane_init
+// These are the wrappers found in drivers/gpu/drm/*.c
+// i.e. these call those above and just pass the second argument.
+| drm_bridge_connector_init
+| drm_crtc_init
+| drm_plane_init
+// drm_simple_display_pipe_init // does not apply
+| drm_simple_encoder_init
+| drm_writeback_connector_init
+// mipi_dbi_dev_init_with_formats // does not apply
+) ( e,<+...devm@p...+>,...)
+
+// same as above, but with an intermediate local variable
+@badarg2 exists@
+position p;
+expression devm,e;
+identifier vitm;
+@@
+// only devm_kzalloc is really used
+devm = \(devm_kzalloc\|devm_kcalloc\|devm_kmalloc\|devm_kmalloc_array\)(...);
+...
+vitm = <+...devm...+>;
+...
+// The kernel-doc comments (v6+) for these 5 functions
+// forbid them to use devm-allocated argument.
+( drm_connector_init
+| drm_crtc_init_with_planes
+| drm_connector_init_with_ddc
+| drm_encoder_init
+| drm_universal_plane_init
+// These are the wrappers found in drivers/gpu/drm/*.c
+// i.e. these call those above and just pass the second argument.
+| drm_bridge_connector_init
+| drm_crtc_init
+| drm_plane_init
+// drm_simple_display_pipe_init // does not apply
+| drm_simple_encoder_init
+| drm_writeback_connector_init
+// mipi_dbi_dev_init_with_formats // does not apply
+) ( e,<+...devm@p...+>,...)
+
+// find direct assignment of devres-managed memory to drm device
+@badfield exists@
+position p;
+expression drm,devm;
+identifier f;
+@@
+(
+drm = \(drm_dev_alloc\|drmm_kzalloc\|drmm_kcalloc\|drmm_kmalloc\|drmm_kmalloc_array\)(...);
+...
+devm = \(devm_kzalloc\|devm_kcalloc\|devm_kmalloc\|devm_kmalloc_array\)(...);
+|
+devm = \(devm_kzalloc\|devm_kcalloc\|devm_kmalloc\|devm_kmalloc_array\)(...);
+...
+drm = \(drm_dev_alloc\|drmm_kzalloc\|drmm_kcalloc\|drmm_kmalloc\|drmm_kmalloc_array\)(...);
+)
+...
+drm->f =@p <+...devm...+>;
+
+
+@script:python depends on report@
+p << badarg.p;
+@@
+msg = "WARNING devm-allocated argument in a drm-init; use drmm-init family (or drmm-alloc)."
+coccilib.report.print_report(p[0], msg)
+
+@script:python depends on org@
+p << badarg.p;
+@@
+msg = "WARNING devm-allocated argument in a drm-init; use drmm-init family (or drmm-alloc)."
+coccilib.org.print_report(p[0], msg)
+
+@script:python depends on report@
+p << badarg2.p;
+@@
+msg = "WARNING devm-allocated argument in a drm-init; use drmm-init family (or drmm-alloc)."
+coccilib.report.print_report(p[0], msg)
+
+@script:python depends on org@
+p << badarg2.p;
+@@
+msg = "WARNING devm-allocated argument in a drm-init; use drmm-init family (or drmm-alloc)."
+coccilib.org.print_report(p[0], msg)
+
+@script:python depends on report@
+p << badfield.p;
+@@
+msg = "WARNING devm-allocated field in a drmm-allocated struct; consider drmm-init family or use drmm-alloc."
+coccilib.report.print_report(p[0], msg)
+
+@script:python depends on org@
+p << badfield.p;
+@@
+msg = "WARNING devm-allocated field in a drmm-allocated struct; consider drmm-init family or use drmm-alloc."
+coccilib.org.print_report(p[0], msg)
-- 
2.34.1

