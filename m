Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 577D5C531F9
	for <cocci@archiver.kernel.org>; Fri, 24 Jul 2026 08:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=8aDNX5oWZPCLlEUZqO7qQYiyJOs0NAqqQhS2frdoUAY=;
  b=WHFjFAUe1JmMoIjBhVGmBohFSyaOvtV55Qpt0FifZTPgVK8kCBfMHORE
   x2eN8wpEEVdwdPgaGClnW0NZ3h+pegw8ENsXGIc4RFhTnOZice/f0zISV
   bG+erzHTeTPOhqPnhWYcS+wG12JczfqKj69ge4FcA1fMAM4UEHvzUQ6ei
   c=;
X-CSE-ConnectionGUID: 9mfplgt4TiyWdQOCqLxMBA==
X-CSE-MsgGUID: RXVzNqjuQNGVlb3AlPCjmA==
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
   d="scan'208";a="287733424"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jul 2026 10:54:09 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id C0EB8803EC; Fri, 24 Jul 2026 10:54:08 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id D904381964
	for <cocci@sympa.inria.fr>; Thu, 23 Jul 2026 20:46:33 +0200 (CEST)
X-CSE-ConnectionGUID: KzSdVranQzaakWE/gau19w==
X-CSE-MsgGUID: wo8tbXCdRA6ymPImt/I8TA==
IronPort-SDR: 6a626189_DF/wEuwrYwl/X+5eltvI26/OIxBNoQus+kumSyLfRzkrZBW
 Bap2gWzLQkJRsLoGK9h9+F8z7nABra8G9TuZ99g==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0E8CABZYGJqgTTYVdFaglkCgj8WgVMzBFSVBwaKb4IZM?=
 =?us-ascii?q?AKSIoE/PQIPAQMBCwEBTwIEAQEBAgQ4hEYCjWACHgcBBDAJDgECBAMCAwEBA?=
 =?us-ascii?q?QEBAQEBAQEBCwEBAQQBAQECAQECBAMBAQEBAhABASIZBw47hk8NSQEBBAsBB?=
 =?us-ascii?q?AEBggEBgSRhAgUDOwEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQUCLF8CAQMSFQsBDQEbHQEDDAYQOyACEQEFARwGARIigmCCIwEGEAEDN?=
 =?us-ascii?q?wIBtleBAkKMPBYFAhaBAYINBtpoChkoDXWBYwECAgcJAQoBAYE3AYR3Kl0Dg?=
 =?us-ascii?q?jqFI3WEAnongRiBEIR+gh+COYYwBIMukioBBwcfEggBHAYIAgJIFRIDBAMEB?=
 =?us-ascii?q?AECCxMJAwMCDgIIAwIIBhkBPxIEEwIIAwYECwcFHwoCDBQKKCISAikKAyAKC?=
 =?us-ascii?q?xIPAw0GBRUBAQcGAgIDAQQCBAwCCQICBQMBAwIEBgQDAwQBAQgCAi0DAQMZC?=
 =?us-ascii?q?AkIAgsFERgMCwUCCicDDwEJAx8DFBsIRQgGFgEaBwUGCzcVBQwRAQIbAiEEH?=
 =?us-ascii?q?REIAwEYBAICAgELAwEDARUECAkEDAIQChIVAw4DBw8CDQcuCwMCDgIJCAwXA?=
 =?us-ascii?q?gICBgIDAwMKAQIBAQEBAQEBCAMDAwIDGQcGAwQEAQQEAwMCAwUBAwMDBQICC?=
 =?us-ascii?q?gYJAQEBAQMCAggDBwMKCQIFAxsDHAYBAgIDAgECAwYDBwgDDQMEAgMDAwQBA?=
 =?us-ascii?q?gIBAQECAwEDAwQDAQMDAgEDBwICAwMDCwECAwMDBQMFAQUDBQICAwUFAwUCA?=
 =?us-ascii?q?goCAwMDAgEDAhwDCAMGAxIBEAMDBgEDBwMHAgQDCAQDBgIDCAMDAgkIAxYGA?=
 =?us-ascii?q?wMDAwUBAgICAwUDAwMICAQDAwQCAgMMAgYDAwMCAwMFAwMHAgQCAwYDAwMBA?=
 =?us-ascii?q?wMFAQIHAgMHAgELCwgDAgQCCQcJBwECAwsEAgQGBA0JBAIEAgIPBAQFAwMHA?=
 =?us-ascii?q?QECAQIIBQYDAgIRBQgKBQYCAgIdAyEBAw8GAQkFAgEFDgcFAgIKEgMGAgMEB?=
 =?us-ascii?q?QUBAwEKAQsBAQIDAwUFAwMFBwECBAIHAwMDBAMDAwMBAQICBAYEAwIDBwMDA?=
 =?us-ascii?q?wMDBAMFBQMCBQIEAwUDBwIDAwIBBQoBBAUECgEDAwMDBQUDAgIDAwQBAgQGA?=
 =?us-ascii?q?wQCAwECCAQGBQMDAwUCAwMCAgIDAwUBBQIDAwMEAwMDCAcFAwMFAgkDAwkDA?=
 =?us-ascii?q?wsCAgMhAgUDAwMDBgMHAwMEAwMDBwcCAwIDBwMCBQIHBQMDBQMGAQMCAQMDC?=
 =?us-ascii?q?AsYAwsJCAcMATwMBwokBAQMKgEGDhQFBCUZZwcHAo1oI4JAAYEOgiiBUQEBA?=
 =?us-ascii?q?Y5Eg04BB5I0oCFJHgkBBgJggWeBChUKL5tfhXwaM5dTkxmZCCORcJcFAgoHB?=
 =?us-ascii?q?xEkEoEyOoFcMxojgQFtgUlQAxkPji0Wg2CPPQG8VzU1PgEHAgcPAoFzg3aCT?=
 =?us-ascii?q?oZcgSCBK0mBTAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 J8ve1aw3g==
IronPort-HdrOrdr: A9a23:QP0s4KBwZ+flBjnlHem/55DYdb4zR+YMi2TDtnoBKyC9F/byqy
 nApoV+6faZslcssRIb6LO90de7MBbhHPdOiOF6UItKOjOHhILCFu5fBOXZrwEIYxeRytJg
X-Talos-CUID: 9a23:FXHJrm7C42zyyi4kZ9ss11wvFv4/e3vk3n7ZIHCVTmlgVeTEVgrF
X-Talos-MUID: 9a23:BmZU4Abp0flMTOBTqDi8mDtSH8tSyvq/DXgslIlBmpm4HHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,181,1779141600"; 
   d="scan'208";a="287666945"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDEXwXDo213wB+Mjrw37Znkfg05cQwo7OHws2p?=
 =?us-ascii?q?dOhFXlNKa70zj97fx1KYW3hMLVZE4oi7wwhONZyYBzs31VaUAbgU9viJ?=
 =?us-ascii?q?ITzPcLh2ahwOKijNz4WPWSe0He2uY5uYIGjFIyDHwx6wCW2kWQPos0sG?=
 =?us-ascii?q?puthDK6qmMUp6oew3iUY7PZQ=3D=3D?=
Received: from mail-pj1-f52.google.com ([209.85.216.52])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 20:46:32 +0200
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-385ea3ce80dso961828a91.2
        for <cocci@inria.fr>; Thu, 23 Jul 2026 11:46:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784832391; x=1785437191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8aDNX5oWZPCLlEUZqO7qQYiyJOs0NAqqQhS2frdoUAY=;
        b=prEW52IZNz2E7YpGwnhK4JSekC2ImdHkATVt5/MnKrLEQSh8c+Gf1hzQYm8QSlaTNh
         1loDOm7U1qfEjrlD4EsKusxHh1+ttBnEQUJCB3+oyhAentARIbd086loGc+mA8CfxLOp
         TnpinlnFRkpXc4V/QDTh80YdlgVrzjb8bYCklbUGUCd10JgEtCmNx8vMSxWCDLHpMAE8
         mMB78DcD8TKnsZYHR51ctExf4KFmuhq+4fIv+Qy0vQgLWQ+GVuJJ/nAhE4elm4xtzq6s
         SvIAOsjODm26JJVwO72mmSHHwdXvhoImvzqTZRkbljIWI2P7wx8NMB9ETxB84e8MH/Ik
         SwFQ==
X-Gm-Message-State: AOJu0Yz2gy/RJ8QesKJSLGXvSJYGAGqX+NoLVAhNA3Wy+bpLlNy4qEC0
	5XSG+XMHG5FkgjKCP03Q31isRwqSmvLp/0pihimdKN2/62jWpPNyoWgt
X-Gm-Gg: AR+sD1017pW2WzImFJD7j0Sd5XErEnJToI6PEZjTWBQfeqbeH95Isufo6jmq7uglpSp
	ZlH4ZZa4Q7EaxgmkBeRFaeR/4aATJxNCCTtBUeCo9xjstx7SiOtW15ASI1GaQ3GBiQLjKsvKwuG
	ojmaz+dXHwmACUKjQJ+6CT4AaGN6AnI/Xcq7L24QB9B3vO68J1AkieYAY/9nYLC0GovT3CM0IbD
	XIsXM/ASCtjXpQK4w1LEyI2Qlq9VvbtGmixBqx/1l+Z9zCSfF2FyJ+hWspJHiB1CW4Y7oSpfvM+
	m8fOaoFeBrdPLEtbD9epPff5X4wBbjqWwU0gdIuQqWy7pSGrJZpvUVnae+w5hkrnEeTF1GA/f+D
	QqSOiHtWIt73/6pEFNhtIdSb4GclqVd6BNcp2BmU4GzclM+GeYNW/oNZ2gZlMDBdEu2HUND9Q
X-Received: by 2002:a17:90b:52cd:b0:387:e0cb:7ee with SMTP id 98e67ed59e1d1-38ec6661b73mr4668847a91.34.1784832391486;
        Thu, 23 Jul 2026 11:46:31 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f03af8a45sm308155a91.10.2026.07.23.11.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 11:46:31 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Julia.Lawall@inria.fr,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Eugen Hristev <ehristev@kernel.org>,
	Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
	Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
	"Bryan O'Donoghue" <bod@kernel.org>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Sylwester Nawrocki <sylvester.nawrocki@gmail.com>,
	Michael Krufky <mkrufky@linuxtv.org>,
	Hans Verkuil <hverkuil@kernel.org>
Cc: cocci@inria.fr,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org
Date: Fri, 24 Jul 2026 03:45:14 +0900
Message-ID: <20260723184538.3888637-13-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723184538.3888637-1-ekffu200098@gmail.com>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH 12/36] media: remove conditional return with no
 effect
Reply-To: Sang-Heon Jeon <ekffu200098@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3609
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/LSnYnKKlIrMB69ajc4HBTQ>

Both branches of the check return the same value, so the check has
no effect. Remove it and return the value directly.

This is the result of running the Coccinelle script from
scripts/coccinelle/misc/cond_return_no_effect.cocci.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 drivers/media/i2c/mt9p031.c                          |  6 +-----
 .../media/platform/microchip/microchip-sama7g5-isc.c |  7 +------
 drivers/media/platform/qcom/iris/iris_resources.c    |  6 +-----
 drivers/media/platform/qcom/venus/pm_helpers.c       |  7 +------
 drivers/media/platform/renesas/rcar-csi2.c           |  6 +-----
 .../media/platform/samsung/s3c-camif/camif-core.c    |  7 +------
 drivers/media/usb/dvb-usb-v2/mxl111sf.c              | 12 ++----------
 drivers/media/usb/gspca/jl2005bcd.c                  |  7 +------
 8 files changed, 9 insertions(+), 49 deletions(-)

diff --git a/drivers/media/i2c/mt9p031.c b/drivers/media/i2c/mt9p031.c
index d21510caf45a..2b09e8315c8e 100644
--- a/drivers/media/i2c/mt9p031.c
+++ b/drivers/media/i2c/mt9p031.c
@@ -452,11 +452,7 @@ static int mt9p031_set_params(struct mt9p031 *mt9p031)
 	ret = mt9p031_write(client, MT9P031_HORIZONTAL_BLANK, hblank - 1);
 	if (ret < 0)
 		return ret;
-	ret = mt9p031_write(client, MT9P031_VERTICAL_BLANK, vblank - 1);
-	if (ret < 0)
-		return ret;
-
-	return ret;
+	return mt9p031_write(client, MT9P031_VERTICAL_BLANK, vblank - 1);
 }
 
 static int mt9p031_s_stream(struct v4l2_subdev *subdev, int enable)
diff --git a/drivers/media/platform/microchip/microchip-sama7g5-isc.c b/drivers/media/platform/microchip/microchip-sama7g5-isc.c
index b0302dfc3278..7383341ec51d 100644
--- a/drivers/media/platform/microchip/microchip-sama7g5-isc.c
+++ b/drivers/media/platform/microchip/microchip-sama7g5-isc.c
@@ -598,13 +598,8 @@ static int __maybe_unused xisc_runtime_suspend(struct device *dev)
 static int __maybe_unused xisc_runtime_resume(struct device *dev)
 {
 	struct isc_device *isc = dev_get_drvdata(dev);
-	int ret;
-
-	ret = clk_prepare_enable(isc->hclock);
-	if (ret)
-		return ret;
 
-	return ret;
+	return clk_prepare_enable(isc->hclock);
 }
 
 static const struct dev_pm_ops microchip_xisc_dev_pm_ops = {
diff --git a/drivers/media/platform/qcom/iris/iris_resources.c b/drivers/media/platform/qcom/iris/iris_resources.c
index 773f6548370a..872bd09656b1 100644
--- a/drivers/media/platform/qcom/iris/iris_resources.c
+++ b/drivers/media/platform/qcom/iris/iris_resources.c
@@ -78,11 +78,7 @@ int iris_enable_power_domains(struct iris_core *core, struct device *pd_dev)
 	if (ret)
 		return ret;
 
-	ret = pm_runtime_get_sync(pd_dev);
-	if (ret < 0)
-		return ret;
-
-	return ret;
+	return pm_runtime_get_sync(pd_dev);
 }
 
 int iris_disable_power_domains(struct iris_core *core, struct device *pd_dev)
diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
index be1cbd5cfe84..e88e66be4f6d 100644
--- a/drivers/media/platform/qcom/venus/pm_helpers.c
+++ b/drivers/media/platform/qcom/venus/pm_helpers.c
@@ -781,7 +781,6 @@ static int decide_core(struct venus_inst *inst)
 	unsigned long max_freq = ULONG_MAX;
 	struct device *dev = core->dev;
 	struct dev_pm_opp *opp;
-	int ret = 0;
 
 	if (legacy_binding) {
 		if (inst->session_type == VIDC_SESSION_TYPE_DEC)
@@ -829,11 +828,7 @@ static int decide_core(struct venus_inst *inst)
 	}
 
 done:
-	ret = hfi_session_set_property(inst, ptype, &cu);
-	if (ret)
-		return ret;
-
-	return ret;
+	return hfi_session_set_property(inst, ptype, &cu);
 }
 
 static int acquire_core(struct venus_inst *inst)
diff --git a/drivers/media/platform/renesas/rcar-csi2.c b/drivers/media/platform/renesas/rcar-csi2.c
index 7305cc4a04cb..6635f5782175 100644
--- a/drivers/media/platform/renesas/rcar-csi2.c
+++ b/drivers/media/platform/renesas/rcar-csi2.c
@@ -2273,11 +2273,7 @@ static int rcsi2_init_phtw_v3u(struct rcar_csi2 *priv,
 			return ret;
 	}
 
-	ret = rcsi2_phtw_write_array(priv, step4, ARRAY_SIZE(step4));
-	if (ret)
-		return ret;
-
-	return ret;
+	return rcsi2_phtw_write_array(priv, step4, ARRAY_SIZE(step4));
 }
 
 /* -----------------------------------------------------------------------------
diff --git a/drivers/media/platform/samsung/s3c-camif/camif-core.c b/drivers/media/platform/samsung/s3c-camif/camif-core.c
index 14eedd1ceb27..bb06847f3a63 100644
--- a/drivers/media/platform/samsung/s3c-camif/camif-core.c
+++ b/drivers/media/platform/samsung/s3c-camif/camif-core.c
@@ -301,7 +301,6 @@ static int camif_media_dev_init(struct camif_dev *camif)
 	struct media_device *md = &camif->media_dev;
 	struct v4l2_device *v4l2_dev = &camif->v4l2_dev;
 	unsigned int ip_rev = camif->variant->ip_revision;
-	int ret;
 
 	memset(md, 0, sizeof(*md));
 	snprintf(md->model, sizeof(md->model), "Samsung S3C%s CAMIF",
@@ -316,11 +315,7 @@ static int camif_media_dev_init(struct camif_dev *camif)
 
 	media_device_init(md);
 
-	ret = v4l2_device_register(camif->dev, v4l2_dev);
-	if (ret < 0)
-		return ret;
-
-	return ret;
+	return v4l2_device_register(camif->dev, v4l2_dev);
 }
 
 static void camif_clk_put(struct camif_dev *camif)
diff --git a/drivers/media/usb/dvb-usb-v2/mxl111sf.c b/drivers/media/usb/dvb-usb-v2/mxl111sf.c
index 870ac3c8b085..6404eb74db32 100644
--- a/drivers/media/usb/dvb-usb-v2/mxl111sf.c
+++ b/drivers/media/usb/dvb-usb-v2/mxl111sf.c
@@ -987,11 +987,7 @@ static int mxl111sf_frontend_attach_atsc_mh(struct dvb_usb_adapter *adap)
 	if (ret < 0)
 		return ret;
 
-	ret = mxl111sf_lg2160_frontend_attach(adap, 2);
-	if (ret < 0)
-		return ret;
-
-	return ret;
+	return mxl111sf_lg2160_frontend_attach(adap, 2);
 }
 
 static int mxl111sf_frontend_attach_mercury(struct dvb_usb_adapter *adap)
@@ -1007,11 +1003,7 @@ static int mxl111sf_frontend_attach_mercury(struct dvb_usb_adapter *adap)
 	if (ret < 0)
 		return ret;
 
-	ret = mxl111sf_lg2161_ep6_frontend_attach(adap, 2);
-	if (ret < 0)
-		return ret;
-
-	return ret;
+	return mxl111sf_lg2161_ep6_frontend_attach(adap, 2);
 }
 
 static int mxl111sf_frontend_attach_mercury_mh(struct dvb_usb_adapter *adap)
diff --git a/drivers/media/usb/gspca/jl2005bcd.c b/drivers/media/usb/gspca/jl2005bcd.c
index a408fcc3a060..4988fbf5005e 100644
--- a/drivers/media/usb/gspca/jl2005bcd.c
+++ b/drivers/media/usb/gspca/jl2005bcd.c
@@ -148,17 +148,12 @@ static int jl2005c_start_new_frame(struct gspca_dev *gspca_dev)
 static int jl2005c_write_reg(struct gspca_dev *gspca_dev, unsigned char reg,
 						    unsigned char value)
 {
-	int retval;
 	u8 instruction[2];
 
 	instruction[0] = reg;
 	instruction[1] = value;
 
-	retval = jl2005c_write2(gspca_dev, instruction);
-	if (retval < 0)
-			return retval;
-
-	return retval;
+	return jl2005c_write2(gspca_dev, instruction);
 }
 
 static int jl2005c_get_firmware_id(struct gspca_dev *gspca_dev)
-- 
2.43.0

