Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50ED3C531FC
	for <cocci@archiver.kernel.org>; Fri, 24 Jul 2026 08:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=a2nXppCiGAGzj7x2K7RacxH7dn9WK6P2XEuUv+uCRKY=;
  b=Zp6THULFlqYjTQfApu8XizxhGivnbiqZczia4ehil+7g9zWHF3ZluYDd
   YLzn2JPxdGvifBoXU3MkULgmMzmqS92/hRb8RW1DLwF8xgUhky0DSCRPJ
   vY+2jZ8xbYu6WMV11BNZJJhA9uZl3ZxyvBmCNnqGNfPKfpbqMu991vTKR
   Y=;
X-CSE-ConnectionGUID: 4NmxtHHmQTebQvoSIYWuBw==
X-CSE-MsgGUID: C17OtPusSiOMjJuplCCgFg==
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
   d="scan'208";a="287733495"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jul 2026 10:54:11 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 831108040C; Fri, 24 Jul 2026 10:54:11 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id AA2F0819F5
	for <cocci@sympa.inria.fr>; Thu, 23 Jul 2026 20:46:39 +0200 (CEST)
X-CSE-ConnectionGUID: Lu4OqbyFQrqcf4DiziMJPQ==
X-CSE-MsgGUID: weS06vYqRHqibSemX6v6TA==
IronPort-SDR: 6a62618f_Xn1Wd84u1HVcLrhkFOWTOfITNKebyLy60lwNM2gzT33rZeb
 VUwc4lrvVqfyM9D3VH1cXtPYXsrjFImJdTixsxg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HHBABZYGJqfDbYVdFaglkCgj8WgVMzBFSVBwaBPokxg?=
 =?us-ascii?q?hkwApIiFIErPQIPAQMBCwEBTwIEAQEBAgQ4hEYCjWACHgcBBDAJDgECBAMCA?=
 =?us-ascii?q?wEBAQEBAQEBAQEBCwEBAQQBAQECAQECBAMBAQEBAhABASIZBw4SKYZPDUkBE?=
 =?us-ascii?q?AEEAQGCAQGBJGECBQM7AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBBQIsXwIBAxIVCwENARsdAQMMBhA7IAIRAQUBHAYBEiKCYIIjAQYQA?=
 =?us-ascii?q?QM3AgG2V4ECQow8FgUCFoEBgg0G2mgKGSgNdYFjAQICBwkBCgEBgTcBhHcqX?=
 =?us-ascii?q?QOCOoUjdYQCeieBGIEQgRWDaYIfggsuhjAEgy6SKgEHBx8SCAEcBggCAkgVE?=
 =?us-ascii?q?gMEAwQEAQILEwkDAwIOAggDAggGGQE/EgQTAggDBgQLBwUfCgIMFAooIhICK?=
 =?us-ascii?q?QoDIAoLEg8DDQYFFQEBBwYCAgMBBAIEDAIEBQICBQMBAwIEBgQDAwQBAQgCA?=
 =?us-ascii?q?i0DAQMZCAkIAgsFERgMCwUCCicDDwEJAx8DFBsIRQgGFgEaBwUGCzcVBQwRA?=
 =?us-ascii?q?QIbAiEEHREIAwEYBAICAgELAwEDARUECAkEDAIQChIVAw4DBw8CDQcuCwMCD?=
 =?us-ascii?q?gIJCAwXAgICBgIDAwMKAQIBAQEBAQEBCAMDAwIDGQcGAwQEAQQEAwMCAwUBA?=
 =?us-ascii?q?wMDBQICCgYJAQEBAQMCAggDBwMKCQIFAxsDHAYBAgIDAgECAwYDBwgDDQMEA?=
 =?us-ascii?q?gMDAwQBAgIBAQECAwEDAwQDAQMDAgEDBwICAwMDCwECAwMDBQMFAQUDBQICA?=
 =?us-ascii?q?wUFAwUCAgoCAwMDAgEDAhwDCAMGAxIBEAMDBgEDBwMHAgQDCAQDBgIDCAMDA?=
 =?us-ascii?q?gkIAxYGAwMDAwUBAgICAwUDAwMICAQDAwQCAgMKAgIGAwMDAgMDBQMDBwIEA?=
 =?us-ascii?q?gMGAwMDAQMDBQECBwIDBwIBCwsIAwIEAgkHCQcBAgMLBAIEBgQNCQQCBAICD?=
 =?us-ascii?q?wQEBQMDBwEBAgECCAUGAwICEQUICgUGAgICHQMhAQMPBgEJBQIBBQ4HBQICC?=
 =?us-ascii?q?hIDBgIDBAUFAQMBCgELAQECAwMFBQMDBQcBAgQCBwMDAwQDAwMDAQECAgQGB?=
 =?us-ascii?q?AMCAwcDAwMDAwQDBQUDAgUCBAMFAwcCAwMCAQUDAQMCAQEEBQQKAQMDAwMFB?=
 =?us-ascii?q?QMCAgMDBAECBAYDBAIDAQIIBAYFAwMDBQIDAwICAgMDBQEFAgMDAwQDAwMIB?=
 =?us-ascii?q?wUDAwUCCQMDCQMDCwICAyECBQECAwMDBgMHAwMEAwMDBwcCAwIDBwMCBQIHB?=
 =?us-ascii?q?QMDBQMGAQMCAQMDCAsYAwsJCAcMATwMBwokBAQMKgEGDhQFBCUZZwcHAo1oI?=
 =?us-ascii?q?4IyDgGBDoE8bA6BQwEBAY5Eg0+SO6AhSR4JAQYCYIFngQoVCi+bX4V8GjOXU?=
 =?us-ascii?q?5MZmQgjkXCXBQIKBwcRJBKBMjqBXDMaI4EBbYFJUAMZD44tFoNgjz0BvFc1N?=
 =?us-ascii?q?T4BBwIHDwKBc4N2iSqBIIErSYFMAQE?=
IronPort-PHdr: A9a23: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
 eIrbJ8yYBquvAM7ZfXXHQ==
IronPort-Data: A9a23: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
 E4=
IronPort-HdrOrdr: A9a23:2wWH6qh3f4sQ4iDftS6TdLzoGXBQXv4ji2hC6mlwRA09TyVXrb
 HKoB19726ItN91YhsdcL+7Sc69qB/nhP1ICMwqTM+ftWrdyRGVxeNZnO3fKlTbckWUltK1l5
 0QCJSWYOeQMbEQt7ef3ODXKadD/PC3tI6twcnRpk0DceioUc1dBsVCZzpzancGPTWuzKBWKK
 ah
X-Talos-CUID: 9a23:+D8o7W2Abk6D7IEb+kFNN7xfPt15VWTX3VnpOVazBzpFSa+UbH2owfYx
X-Talos-MUID: 9a23:IKOzlQb3ILdvSuBTqDLX3G98Bd5Sw72vAnsAlKVYpZe4HHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,181,1779141600"; 
   d="scan'208";a="287666956"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDGEK+v35JYafrdc6KxIZsYkD873qxzxn2ASaZ?=
 =?us-ascii?q?dKz+Vq5t3hB7kElgxDtJHBB4sfqLf+6T1oFLQZikpvDklEKtAziecePq?=
 =?us-ascii?q?0rLGUFbiC/2pnPbkbVIOjkLPCG4gy7HEyk86P3ugswBKRSmOBvWTyuR2?=
 =?us-ascii?q?kQVbTRb53Pdkm+QzMG8UrD3g=3D=3D?=
Received: from mail-pj1-f54.google.com ([209.85.216.54])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 20:46:38 +0200
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3810c5d691bso818952a91.1
        for <cocci@inria.fr>; Thu, 23 Jul 2026 11:46:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784832397; x=1785437197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=a2nXppCiGAGzj7x2K7RacxH7dn9WK6P2XEuUv+uCRKY=;
        b=DOytP7OpHon1J5kAijK5mL0RsR64+QsaIV8NN1k5zpgWx36tbfj3Qer2Y6y6Tkh/MN
         HkgfAs2EjuMPq8kL0XsR6kzLymG0bZ59bSvsBPWqdIzhjt0kHkMeGZMOixKncbvpNRhM
         SUS1DCyFC+0nzKlqlscLdSsxijowOsm3l1i+8eIjzW3PP1uBcjd6c75hgSwXpG6HIYHP
         31OOjrO+7OpWqlqZIYLnKANnFx25uHB1y21HVlB/D/wh71OqVjIVGNm1yyJgF9TDZPn0
         AaCYHnTkfQ35Oa5iS0HFM/WZBp227qgnlBDHnHpBiiJd5h1wBvz4cGkci8mHegoVsbtj
         /KWg==
X-Gm-Message-State: AOJu0YyxHMPivmIKJnNW/+8yqQql+O0PrCaLwCENOrxRxGR8DkilvKhA
	1U74GL6LBVAJoI2QNWR4nrg2RbxQM39ju4+3AbU4KjpmWNOA5jJrOkjJ4c44Y86fJXU=
X-Gm-Gg: AR+sD13gKCp6aH4MIw30PXDLu8jivJlPxcU9I0pexHhH3gGMyGZRvDwDBAf836oj2Mp
	gzTAV6xRe3i1FKtqI0H8iHdWWcb56ufJm8MiK/+D9vWcUJjDjgLMntBqML6w2ZnHpKB70w8Ufq8
	d+UBvlp/X0kp9Se3J9auywS0INxzfT0GtIbo5dzSR5vrxxtJp/8UMgKjbXFgqz8D+Jd0qB9UZCj
	IXZ7k8Vgo/YkeeVKYkiUO98V+6drMK8g/dScplydtZXSL85//fzOJkMVLeQTj7yVRDg1kV1Lhzu
	A9VsyqPaX7jNQuqd6W3SD1rVteZpFtQWF1HPuGp8m1nram7DxkDa0qEg6fr3kASez6xhrP+gg+D
	GB4zgfofVmBn5jwb6yVdbEm1xYkYLmAAkUtjJIoY4XIxJXXL78X4hAhuokmk0n/Sh+QNOwdFm
X-Received: by 2002:a17:90b:2e84:b0:387:e0bb:57f4 with SMTP id 98e67ed59e1d1-38ec6a965a9mr4789308a91.37.1784832397395;
        Thu, 23 Jul 2026 11:46:37 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f03af8a45sm308155a91.10.2026.07.23.11.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 11:46:36 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Julia.Lawall@inria.fr,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Daniel Baluta <daniel.baluta@nxp.com>
Cc: cocci@inria.fr,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	sound-open-firmware@alsa-project.org,
	Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
Date: Fri, 24 Jul 2026 03:45:16 +0900
Message-ID: <20260723184538.3888637-15-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723184538.3888637-1-ekffu200098@gmail.com>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH 14/36] ASoC: remove conditional return with no
 effect
Reply-To: Sang-Heon Jeon <ekffu200098@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3611
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/ySFd-8E6BvZbU-3uvUcqUw>

Both branches of the check return the same value, so the check has
no effect. Remove it and return the value directly.

This is the result of running the Coccinelle script from
scripts/coccinelle/misc/cond_return_no_effect.cocci.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 sound/soc/amd/acp/acp-mach-common.c          | 11 +++--------
 sound/soc/intel/atom/sst-mfld-platform-pcm.c |  7 +------
 sound/soc/samsung/smdk_spdif.c               |  8 ++------
 sound/soc/sof/intel/hda-dsp.c                |  6 +-----
 4 files changed, 7 insertions(+), 25 deletions(-)

diff --git a/sound/soc/amd/acp/acp-mach-common.c b/sound/soc/amd/acp/acp-mach-common.c
index ef784cca13f2..01a0aaa60246 100644
--- a/sound/soc/amd/acp/acp-mach-common.c
+++ b/sound/soc/amd/acp/acp-mach-common.c
@@ -938,15 +938,10 @@ static int acp_max98388_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *codec_dai =
 			snd_soc_card_get_codec_dai(card,
 						   MAX98388_CODEC_DAI);
-	int ret;
 
-	ret = snd_soc_dai_set_fmt(codec_dai,
-				  SND_SOC_DAIFMT_CBC_CFC | SND_SOC_DAIFMT_I2S |
-				  SND_SOC_DAIFMT_NB_NF);
-	if (ret < 0)
-		return ret;
-
-	return ret;
+	return snd_soc_dai_set_fmt(codec_dai,
+				   SND_SOC_DAIFMT_CBC_CFC | SND_SOC_DAIFMT_I2S |
+				   SND_SOC_DAIFMT_NB_NF);
 }
 
 static const struct snd_soc_ops acp_max98388_ops = {
diff --git a/sound/soc/intel/atom/sst-mfld-platform-pcm.c b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
index 9ee4d9926e06..a4c8cbfba096 100644
--- a/sound/soc/intel/atom/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
@@ -236,12 +236,7 @@ static int sst_platform_alloc_stream(struct snd_pcm_substream *substream,
 
 	stream->stream_info.str_id = str_params.stream_id;
 
-	ret_val = stream->ops->open(sst->dev, &str_params);
-	if (ret_val <= 0)
-		return ret_val;
-
-
-	return ret_val;
+	return stream->ops->open(sst->dev, &str_params);
 }
 
 static void sst_period_elapsed(void *arg)
diff --git a/sound/soc/samsung/smdk_spdif.c b/sound/soc/samsung/smdk_spdif.c
index 2474eb619882..515e4dfc1432 100644
--- a/sound/soc/samsung/smdk_spdif.c
+++ b/sound/soc/samsung/smdk_spdif.c
@@ -130,12 +130,8 @@ static int smdk_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 
 	/* Set S/PDIF uses internal source clock */
-	ret = snd_soc_dai_set_sysclk(cpu_dai, SND_SOC_SPDIF_INT_MCLK,
-					rclk_rate, SND_SOC_CLOCK_IN);
-	if (ret < 0)
-		return ret;
-
-	return ret;
+	return snd_soc_dai_set_sysclk(cpu_dai, SND_SOC_SPDIF_INT_MCLK,
+				      rclk_rate, SND_SOC_CLOCK_IN);
 }
 
 static const struct snd_soc_ops smdk_spdif_ops = {
diff --git a/sound/soc/sof/intel/hda-dsp.c b/sound/soc/sof/intel/hda-dsp.c
index e9f092f082a1..b9b2bdff4ccb 100644
--- a/sound/soc/sof/intel/hda-dsp.c
+++ b/sound/soc/sof/intel/hda-dsp.c
@@ -1114,11 +1114,7 @@ static int hda_dsp_s5_quirk(struct snd_sof_dev *sdev)
 	usleep_range(500, 1000);
 
 	/* Restore state for shutdown, back to reset */
-	ret = hda_dsp_ctrl_link_reset(sdev, true);
-	if (ret < 0)
-		return ret;
-
-	return ret;
+	return hda_dsp_ctrl_link_reset(sdev, true);
 }
 
 int hda_dsp_shutdown_dma_flush(struct snd_sof_dev *sdev)
-- 
2.43.0

