Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C07CC531FC
	for <cocci@archiver.kernel.org>; Fri, 24 Jul 2026 08:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=lNzFXtDRL36sjfeetYaoRGkJ3BZXJkrvXWbUMZXEOzM=;
  b=ChgJVsOgGzxuTA5zeZsptwkegtFF4fTSvwYYjPK7QBPEXdyvleHAqZJD
   RffpzXss99yix8gMfTlboKJvRglvHNFpLtW6Rr1BM71g6e1v6j81ddI1v
   h/pRaj6L2javHsjU5ZPBdlE4H+Z1jUazMha8Vnbdkl02XHJ+QLpFJJ7XA
   Q=;
X-CSE-ConnectionGUID: n1Qqr/MhRBWw2LJWDoxmjA==
X-CSE-MsgGUID: sZKLC3w7Qy6gXrxqnHKArg==
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
X-IronPort-AV: E=Sophos;i="6.25,182,1779141600"; 
   d="scan'208";a="287733171"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jul 2026 10:53:59 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id BA66F80100; Fri, 24 Jul 2026 10:53:58 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 5DF6081964
	for <cocci@sympa.inria.fr>; Thu, 23 Jul 2026 20:46:14 +0200 (CEST)
X-CSE-ConnectionGUID: LnKvB9RNTZC3KiChAPnpeA==
X-CSE-MsgGUID: tvGUDdkVQEWCjqa/RgpmBw==
IronPort-SDR: 6a626175_R3GPcymwV2PQz5oTSpOmdX3J9lLoi2gp/fFS1khFyw19YWM
 v51/OKuI+J71KVOHahOkXLZdLJfxUyjyCM2UbCw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HFBABZYGJqfCrYVdFaglkCgj8WgVMzBFSVBwaKb4IZM?=
 =?us-ascii?q?AKSIoE/PQIPAQMBCwEBTwIEAQEBAgQ4hEYCjWACHgcBBDAJDgECBAMCAwEBA?=
 =?us-ascii?q?QEBAQEBAQEBCwEBAQQBAQECAQECBAMBAQEBAhABASIZBw4SKYZPDUkBEAEEA?=
 =?us-ascii?q?QGCAQGBJGECBQM7AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBBQIsXwIBAxIVCwENARsdAQMMBhA7IAIRAQUBHAYBEiKCYIIjAQYQAQM3A?=
 =?us-ascii?q?gG2V4ECQow8FgUCFoEBgg0G2mgKGSgNdYFjAQICBwkBCgEBgTcBhHcqXQOCO?=
 =?us-ascii?q?oUjdYQCeieBGIEQhAh2gh+BfD2GMASDLpIqAQcHHxIIARwGCAICSBUSAwQDB?=
 =?us-ascii?q?AQBAgsTCQMDAg4CCAMCCAYZAT8SBBMCCAMGBAsHBR8KAgwUCigiEgIpCgMgC?=
 =?us-ascii?q?gsSDwMNBgUVAQEHBgICAwEEAgQMAgQFAgIFAwEDAgQGBAMDBAEBCAICLQMBA?=
 =?us-ascii?q?xkICQgCCwURGAwLBQIKJwMPAQkDHwMUGwhFCAYWARoHBQYLNxUFDBEBAhsCI?=
 =?us-ascii?q?QQdEQgDARgEAgICAQsDAQMBFQQICQQMAhAKEhUDDgMHDwINBy4LAwIOAgkID?=
 =?us-ascii?q?BcCAgIGAgMDAwoBAgEBAQEBAQEIAwMDAgMZBwYDBAQBBAQDAwIDBQEDAwMFA?=
 =?us-ascii?q?gIKBgkBAQEBAwICCAMHAwoJAgUDGwMcBgECAgMCAQIDBgMHCAMNAwQCAwMDB?=
 =?us-ascii?q?AECAgEBAQIDAQMDBAMBAwMCAQMHAgIDAwMLAQIDAwMFAwUBBQMFAgIDBQUDB?=
 =?us-ascii?q?QICCgIDAwMCAQMCHAMIAwYDEgEQAwMGAQMHAwcCBAMIBAMGAgMIAwMCCQgDF?=
 =?us-ascii?q?gYDAwMDBQECAgIDBQMDAwgIBAMDBAICAwoCAgYDAwMCAwMFAwMHAgQCAwYDA?=
 =?us-ascii?q?wMBAwMFAQIHAgMHAgELCwgDAgQCCQcJBwECAwsEAgQGBA0JBAIEAgIPBAQFA?=
 =?us-ascii?q?wMHAQECAQIIBQYDAgIRBQgKBQYCAgIdAyEBAw8GAQkFAgEFDgcFAgIKEgMGA?=
 =?us-ascii?q?gMEBQUBAwEKAQsBAQIDAwUFAwMFBwECBAIHAwMDBAMDAwMBAQICBAYEAwIDB?=
 =?us-ascii?q?wMDAwMDBAMFBQMCBQIEAwUDBwIDAwIBBQMBAwIBAQQFBAoBAwMDAwUFAwICA?=
 =?us-ascii?q?wMEAQIEBgMEAgMBAggEBgUDAwMFAgMDAgICAwMFAQUCAwMDBAMDAwgHBQMDB?=
 =?us-ascii?q?QIJAwMJAwMLAgIDIQIFAQIDAwMGAwcDAwQDAwMHBwIDAgMHAwIFAgcFAwMFA?=
 =?us-ascii?q?wYBAwIBAwMICxgDCwkIBwwBPAwHCiQEBAwqAQYOFAUEJRlnBwcCjWgjgkABg?=
 =?us-ascii?q?Q6CKEuBBgEBAZU9jxGgIUkeCQEGAmCBZ4EKFQovm1+FfBozhASTT5MZmQgjg?=
 =?us-ascii?q?jaPOpErhVoCCgcHESQSgTI6gVwzGiOBAW2BSVADGQ+SI489AbxXNTU+AQcCB?=
 =?us-ascii?q?w8CgXODdokqgSCBKxYzgUwBAQ?=
IronPort-PHdr: A9a23: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
 bkFixjfwbCoYIwMCUDO
IronPort-Data: A9a23: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
 b7Kq7Ox3l2r
IronPort-HdrOrdr: A9a23:rxrjZKhxY5QpgY1tXrBXvYnLfHBQXv4ji2hC6mlwRA09TyVXrb
 HKoB19726ItN91YhsdcL+7Sc69qB/nhP1ICMwqTM+ftWrdyRGVxeNZnO3fKlTbckWUltK1l5
 0QCJSWYOeQMbEQt7ef3ODXKadD/PC3tI6twcnRpk0DceioUc1dBsVCZzpzancGPTWuzKBWKK
 ah
X-Talos-CUID: 9a23:8p/NlGODfApENO5DfC9E6mRFIOYZQFaG73b7I2aAD35kYejA
X-Talos-MUID: 9a23:4DX0MAnKD7QrRz5VYh5ydnp+KuhVz6itNnkgrr4EosDDDyNoPh2C2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,181,1779141600"; 
   d="scan'208";a="152815240"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDESeeWO9dsL48qQ41uATyWscALZZJCL1PKN9h?=
 =?us-ascii?q?rZ7S20yfZ5EX7hI0AotOYjBDwGV3H+OQWEdTdwHYf1B5rrO2YZM56IMo?=
 =?us-ascii?q?P+47S5vu6qgXS6IfuDHg9Xj9O/g3u4YR5w4rJsG+fmCc7Qzy7fvhs6/y?=
 =?us-ascii?q?aW5oYwLyDpsSxA+4Y7DtKP2w=3D=3D?=
Received: from mail-pj1-f42.google.com ([209.85.216.42])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 20:46:14 +0200
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so931331a91.0
        for <cocci@inria.fr>; Thu, 23 Jul 2026 11:46:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784832372; x=1785437172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lNzFXtDRL36sjfeetYaoRGkJ3BZXJkrvXWbUMZXEOzM=;
        b=B9ut1qDCfqBWT/d/iK4YtEyJxyJ0zpb4/9NNLIQPSc6r37eHw7ROYpeZNYXKmTeIfa
         +lmFbZs/geTLAGXhv9l1/AGnidYD8MSsES5Cgh4IpQxzJ0bWHH1tpeyS1N/N/uYH4HqJ
         5fLoPQ/+syEhCExpa9TtOLyFVK8t9l9hQMNk0Wa5ac+DYTePtBr9KCaPq1cJ4OExQaSQ
         4AOLzYNVq3KT9PL+ejrUNmPYkXKWrs4J1ig+5JVYuiwj3j+QJvWVe2yhEyJuw2ux0Odn
         T8VCB7haePaxja3XP9d1/Wul/yD75rLqNFspnlCR9IlAyOVM+hWYxgJCxISB6a09CbNy
         K9Pg==
X-Gm-Message-State: AOJu0Yz/iy1ID8BVWlI+mXDkZj81GgUNxURz+YjHnuKzIwQfUS8quE8J
	mRpEYRBF/bFXv3E2g91V+TNOpRan/QsfMf8OdBDULM0UsLE0ehr+pxZC
X-Gm-Gg: AR+sD12O9cHwiedRzueknEbzdBXing7H28fKM+oiTRpF2Y0GajWhO6u26sV5YblsE9y
	wKVDyK5YnD0Zo2tJOU3GsAj38hTGmRE83Gncx2ceaC6fvrnlkif1hreQSMGREiAHXExDcj9tK3U
	zSBNxEen0EId478IJX2VdCMPjUbhdaGbO07/bOVMeinkW8aOZPxhVl9IT0AuQPdCftdPpv1NA8i
	rWJ3WLKvVUzpwlsNJQm4lUB4WHvQnAKUaLUSUwSuk+0eTeRJJqKT5Zmvq0fmeiPE04kXcClQvKY
	rcukEmMGEZIIluE9/bmIHmoTGfziordW9bSKwCKX4hmrzESbvmzggZ28/DsD2XKYuPfBi5EMbox
	TE5HDnj0lwSvc5k1nyNJ+q7YEtZTpokgL12DUmOWClwOLM5Jadg2X/0lEkA8WD4xyu0F71eoy
X-Received: by 2002:a17:90b:1d02:b0:38d:dfd1:7c1 with SMTP id 98e67ed59e1d1-38ec6499300mr4568453a91.2.1784832371666;
        Thu, 23 Jul 2026 11:46:11 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f03af8a45sm308155a91.10.2026.07.23.11.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 11:46:11 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Julia.Lawall@inria.fr,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jyri Sarha <jyri.sarha@iki.fi>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: cocci@inria.fr,
	dri-devel@lists.freedesktop.org,
	Fabio Estevam <festevam@gmail.com>,
	imx@lists.linux.dev,
	Jessica Zhang <jesszhan0024@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	nouveau@lists.freedesktop.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Date: Fri, 24 Jul 2026 03:45:08 +0900
Message-ID: <20260723184538.3888637-7-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723184538.3888637-1-ekffu200098@gmail.com>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH 06/36] drm: remove conditional return with no effect
Reply-To: Sang-Heon Jeon <ekffu200098@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3603
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/bBkM8Qxe5VLALecrMAbVaw>

Both branches of the check return the same value, so the check has
no effect. Remove it and return the value directly.

This is the result of running the Coccinelle script from
scripts/coccinelle/misc/cond_return_no_effect.cocci.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 drivers/gpu/drm/imx/ipuv3/imx-drm-core.c           |  6 +-----
 drivers/gpu/drm/nouveau/dispnv50/disp.c            | 14 +++++---------
 drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c |  7 +------
 drivers/gpu/drm/tilcdc/tilcdc_drv.c                |  6 +-----
 4 files changed, 8 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/imx/ipuv3/imx-drm-core.c b/drivers/gpu/drm/imx/ipuv3/imx-drm-core.c
index 51a0ec043248..52a2334be799 100644
--- a/drivers/gpu/drm/imx/ipuv3/imx-drm-core.c
+++ b/drivers/gpu/drm/imx/ipuv3/imx-drm-core.c
@@ -55,11 +55,7 @@ static int imx_drm_atomic_check(struct drm_device *dev,
 		return ret;
 
 	/* Assign PRG/PRE channels and check if all constrains are satisfied. */
-	ret = ipu_planes_assign_pre(dev, state);
-	if (ret)
-		return ret;
-
-	return ret;
+	return ipu_planes_assign_pre(dev, state);
 }
 
 static const struct drm_mode_config_funcs imx_drm_mode_config_funcs = {
diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 364227f5456f..e8fde399acae 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -301,19 +301,15 @@ nv50_dmac_create(struct nouveau_drm *drm,
 	if (ret)
 		return ret;
 
-	ret = nvif_object_ctor(&dmac->base.user, "kmsVramCtxDma", NV50_DISP_HANDLE_VRAM,
-			       NV_DMA_IN_MEMORY,
-			       &(struct nv_dma_v0) {
+	return nvif_object_ctor(&dmac->base.user, "kmsVramCtxDma", NV50_DISP_HANDLE_VRAM,
+				NV_DMA_IN_MEMORY,
+				&(struct nv_dma_v0) {
 					.target = NV_DMA_V0_TARGET_VRAM,
 					.access = NV_DMA_V0_ACCESS_RDWR,
 					.start = 0,
 					.limit = device->info.ram_user - 1,
-			       }, sizeof(struct nv_dma_v0),
-			       &dmac->vram);
-	if (ret)
-		return ret;
-
-	return ret;
+				}, sizeof(struct nv_dma_v0),
+				&dmac->vram);
 }
 
 /******************************************************************************
diff --git a/drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c b/drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c
index 2334b77f348c..16a02527285e 100644
--- a/drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c
+++ b/drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c
@@ -58,13 +58,8 @@ static int osd101t2587_panel_prepare(struct drm_panel *panel)
 static int osd101t2587_panel_enable(struct drm_panel *panel)
 {
 	struct osd101t2587_panel *osd101t2587 = ti_osd_panel(panel);
-	int ret;
 
-	ret = mipi_dsi_turn_on_peripheral(osd101t2587->dsi);
-	if (ret)
-		return ret;
-
-	return ret;
+	return mipi_dsi_turn_on_peripheral(osd101t2587->dsi);
 }
 
 static const struct drm_display_mode default_mode_osd101t2587 = {
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
index 1d6c9a423a41..990805f1fea6 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
@@ -64,11 +64,7 @@ static int tilcdc_atomic_check(struct drm_device *dev,
 	 * tilcdc ->atomic_check can update ->mode_changed if pixel format
 	 * changes, hence will we check modeset changes again.
 	 */
-	ret = drm_atomic_helper_check_modeset(dev, state);
-	if (ret)
-		return ret;
-
-	return ret;
+	return drm_atomic_helper_check_modeset(dev, state);
 }
 
 static const struct drm_mode_config_funcs mode_config_funcs = {
-- 
2.43.0

