Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA5A8C5DF8E
	for <cocci@archiver.kernel.org>; Fri, 21 Aug 2026 08:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=ZYUB93GXJePpLbcDYnipTyjFgtOGrser5ClzPaHaXZQ=;
  b=lHbThk6dM6yFyJlVLBmk9NQ2N7oTXsFVq7rbMG035JXiCZPIrWkDtHNv
   PiPBEv8o1tMuB01dSh+AxBLioOjEN7hJ5ZRKRsEv5RXYRxYysn/fw9zj4
   VglZw/ZY3Wr63+nMAACV6VNJ22uPtAdTfRQzgzmgSf1dFd3U20Cpca33Q
   8=;
X-CSE-ConnectionGUID: i5E9SrdCS/+YDlTBe4GIFA==
X-CSE-MsgGUID: ylrAitgJRNaWdgBdYbMxUQ==
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
X-IronPort-AV: E=Sophos;i="6.25,234,1779141600"; 
   d="scan'208";a="290932994"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Aug 2026 10:26:57 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 1B39C8182C; Fri, 21 Aug 2026 10:26:57 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 8A28280618
	for <cocci@sympa.inria.fr>; Fri,  7 Aug 2026 14:28:27 +0200 (CEST)
X-CSE-ConnectionGUID: h2bEU/PcRvqVx8EXDMrGpg==
X-CSE-MsgGUID: A5PU0/cwRGu/BtIBOLx44A==
IronPort-SDR: 6a75cf6b_W4kKvlCg+cNOMmuU3npf7wKTO7WNkbOr7ZQNYBEgbMPJHSv
 xL+66HHhmjXOG4mCf3k/mbpmjlRuzQfjrZIYODg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FYAgCVznVqhUDyp9VaHgEBCxIMggULgW5TgWkzBwhJh?=
 =?us-ascii?q?FiIeogSZwMTgSyKJZI3gXwCDwEDAQ1RBAEBAQIEhH4CjWcCHwYBBDIHDgECB?=
 =?us-ascii?q?AMCAwEBAQEBAQEBAQEBCwEBAQQBAQECAQECBAMBAQEBAhABAQEBQEmGTw2CY?=
 =?us-ascii?q?gGBJIEmAQEBAQEBAQEBAQEBHQINfgEBAQMjBBkBATcBDwsYAgImAgIgNgYTg?=
 =?us-ascii?q?wKCIwcRAzcEAwHAVH8zgQGCDAEBBtsyDXKBaQkUAYEKLoVxgkwgAYV4hAJ6J?=
 =?us-ascii?q?w+BVUSBSoJ2PoIfhX+CaoImgQyCaJAAUngcA1ksAVUTFwsHBYEjQwOBBiNLB?=
 =?us-ascii?q?S0dgSMhHRcXHlgbBwUSICpBRCMDPh1DBYFNAoF0PyMZNnqBCV6BLSpkAQIQF?=
 =?us-ascii?q?0YuFYJJAoJ2gTAFC209NxQZjy8hgkABAVcjFBuBCzVNF5ABg04BB4MjAY8No?=
 =?us-ascii?q?CQ9NAeEIIFgBgyZbYV8BEmEBJQXklGZCJITln8xgW8BMoFcTSODN1ADGQ+OI?=
 =?us-ascii?q?QwNCYNgzBxBNT4BBwIHDwKBc5A0gUwBAQ?=
IronPort-PHdr: A9a23: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
 N0oflSdUwYuwLaYDBMPP83LMw0TZM1XpiG7QA==
IronPort-Data: A9a23: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
 wQ=
IronPort-HdrOrdr: A9a23:YieWfKwA6KGYg88R408bKrPwIb1zdoMgy1knxilNoNJuHPBws/
 re+MjztCWE7Qr5PUtLpTnuAsS9qB/nmaKdpLNhWotKPzOW2ldATrsD0WKK+VSJcBEWtNQttp
 uIGJIeNDSfNzdHsfo=
X-Talos-CUID: 9a23:BWWK4W559PoriK1Of9ss9BQeN/1iSnbn0m7uMx+VOUpMUpKNRgrF
X-Talos-MUID: 9a23:5lfiSAk+JCIGW56G4d8fdnpLaf9Vu+OlF3oijNIsp+iuEghgZ2u02WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,210,1779141600"; 
   d="scan'208";a="289442093"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDFPjGO0Z7MMES+4ZcG3eJWwz3W5PKhwk3A+h+?=
 =?us-ascii?q?s22rY/Fq3qZGEjE7WWQaXZWaFjti9L149HsM+o4eHd53Lwam1T42IezP?=
 =?us-ascii?q?ACymlW/B8c5kEWkQwPVcAqZp+i9cBeh92HjAgVc6wLKaBpskBb/8qnT+?=
 =?us-ascii?q?RPtxQzXtaUyToKVFqbAtnG6g=3D=3D?=
Received: from perceval.ideasonboard.com ([213.167.242.64])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 14:28:27 +0200
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id C20B456D;
	Fri,  7 Aug 2026 14:27:14 +0200 (CEST)
Date: Fri, 7 Aug 2026 15:28:25 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: Julia.Lawall@inria.fr, Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Eugen Hristev <ehristev@kernel.org>,
	Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
	Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
	Bryan O'Donoghue <bod@kernel.org>,
	Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Sylwester Nawrocki <sylvester.nawrocki@gmail.com>,
	Michael Krufky <mkrufky@linuxtv.org>,
	Hans Verkuil <hverkuil@kernel.org>, cocci@inria.fr,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org
Message-ID: <20260807122825.GJ2201016@killaraus.ideasonboard.com>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
 <20260723184538.3888637-13-ekffu200098@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260723184538.3888637-13-ekffu200098@gmail.com>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH 12/36] media: remove conditional return with no
 effect
Reply-To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
X-Loop: cocci@inria.fr
X-Sequence: 3688
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-08/0UVUP0XdulOThzbX61J7Fg>

On Fri, Jul 24, 2026 at 03:45:14AM +0900, Sang-Heon Jeon wrote:
> Both branches of the check return the same value, so the check has
> no effect. Remove it and return the value directly.
> 
> This is the result of running the Coccinelle script from
> scripts/coccinelle/misc/cond_return_no_effect.cocci.
> 
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> ---
>  drivers/media/i2c/mt9p031.c                          |  6 +-----
>  .../media/platform/microchip/microchip-sama7g5-isc.c |  7 +------
>  drivers/media/platform/qcom/iris/iris_resources.c    |  6 +-----
>  drivers/media/platform/qcom/venus/pm_helpers.c       |  7 +------
>  drivers/media/platform/renesas/rcar-csi2.c           |  6 +-----
>  .../media/platform/samsung/s3c-camif/camif-core.c    |  7 +------
>  drivers/media/usb/dvb-usb-v2/mxl111sf.c              | 12 ++----------
>  drivers/media/usb/gspca/jl2005bcd.c                  |  7 +------
>  8 files changed, 9 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/media/i2c/mt9p031.c b/drivers/media/i2c/mt9p031.c
> index d21510caf45a..2b09e8315c8e 100644
> --- a/drivers/media/i2c/mt9p031.c
> +++ b/drivers/media/i2c/mt9p031.c
> @@ -452,11 +452,7 @@ static int mt9p031_set_params(struct mt9p031 *mt9p031)
>  	ret = mt9p031_write(client, MT9P031_HORIZONTAL_BLANK, hblank - 1);
>  	if (ret < 0)
>  		return ret;
> -	ret = mt9p031_write(client, MT9P031_VERTICAL_BLANK, vblank - 1);
> -	if (ret < 0)
> -		return ret;
> -
> -	return ret;

I would have just replaced the last line with a

	return 0;

as I find it easier to read code that has multiple error paths when all
the error paths look the same. It's a small personal preference though
(and ths best option would be to convert this driver to the CCI
helpers), so I'm OK with this change as-is.

> +	return mt9p031_write(client, MT9P031_VERTICAL_BLANK, vblank - 1);
>  }
>  
>  static int mt9p031_s_stream(struct v4l2_subdev *subdev, int enable)
> diff --git a/drivers/media/platform/microchip/microchip-sama7g5-isc.c b/drivers/media/platform/microchip/microchip-sama7g5-isc.c
> index b0302dfc3278..7383341ec51d 100644
> --- a/drivers/media/platform/microchip/microchip-sama7g5-isc.c
> +++ b/drivers/media/platform/microchip/microchip-sama7g5-isc.c
> @@ -598,13 +598,8 @@ static int __maybe_unused xisc_runtime_suspend(struct device *dev)
>  static int __maybe_unused xisc_runtime_resume(struct device *dev)
>  {
>  	struct isc_device *isc = dev_get_drvdata(dev);
> -	int ret;
> -
> -	ret = clk_prepare_enable(isc->hclock);
> -	if (ret)
> -		return ret;
>  
> -	return ret;
> +	return clk_prepare_enable(isc->hclock);

Here the change looks good, there's a single error paths so a direct
return is fine.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  }
>  
>  static const struct dev_pm_ops microchip_xisc_dev_pm_ops = {
> diff --git a/drivers/media/platform/qcom/iris/iris_resources.c b/drivers/media/platform/qcom/iris/iris_resources.c
> index 773f6548370a..872bd09656b1 100644
> --- a/drivers/media/platform/qcom/iris/iris_resources.c
> +++ b/drivers/media/platform/qcom/iris/iris_resources.c
> @@ -78,11 +78,7 @@ int iris_enable_power_domains(struct iris_core *core, struct device *pd_dev)
>  	if (ret)
>  		return ret;
>  
> -	ret = pm_runtime_get_sync(pd_dev);
> -	if (ret < 0)
> -		return ret;
> -
> -	return ret;
> +	return pm_runtime_get_sync(pd_dev);
>  }
>  
>  int iris_disable_power_domains(struct iris_core *core, struct device *pd_dev)
> diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
> index be1cbd5cfe84..e88e66be4f6d 100644
> --- a/drivers/media/platform/qcom/venus/pm_helpers.c
> +++ b/drivers/media/platform/qcom/venus/pm_helpers.c
> @@ -781,7 +781,6 @@ static int decide_core(struct venus_inst *inst)
>  	unsigned long max_freq = ULONG_MAX;
>  	struct device *dev = core->dev;
>  	struct dev_pm_opp *opp;
> -	int ret = 0;
>  
>  	if (legacy_binding) {
>  		if (inst->session_type == VIDC_SESSION_TYPE_DEC)
> @@ -829,11 +828,7 @@ static int decide_core(struct venus_inst *inst)
>  	}
>  
>  done:
> -	ret = hfi_session_set_property(inst, ptype, &cu);
> -	if (ret)
> -		return ret;
> -
> -	return ret;
> +	return hfi_session_set_property(inst, ptype, &cu);
>  }
>  
>  static int acquire_core(struct venus_inst *inst)
> diff --git a/drivers/media/platform/renesas/rcar-csi2.c b/drivers/media/platform/renesas/rcar-csi2.c
> index 7305cc4a04cb..6635f5782175 100644
> --- a/drivers/media/platform/renesas/rcar-csi2.c
> +++ b/drivers/media/platform/renesas/rcar-csi2.c
> @@ -2273,11 +2273,7 @@ static int rcsi2_init_phtw_v3u(struct rcar_csi2 *priv,
>  			return ret;
>  	}
>  
> -	ret = rcsi2_phtw_write_array(priv, step4, ARRAY_SIZE(step4));
> -	if (ret)
> -		return ret;
> -
> -	return ret;
> +	return rcsi2_phtw_write_array(priv, step4, ARRAY_SIZE(step4));
>  }
>  
>  /* -----------------------------------------------------------------------------
> diff --git a/drivers/media/platform/samsung/s3c-camif/camif-core.c b/drivers/media/platform/samsung/s3c-camif/camif-core.c
> index 14eedd1ceb27..bb06847f3a63 100644
> --- a/drivers/media/platform/samsung/s3c-camif/camif-core.c
> +++ b/drivers/media/platform/samsung/s3c-camif/camif-core.c
> @@ -301,7 +301,6 @@ static int camif_media_dev_init(struct camif_dev *camif)
>  	struct media_device *md = &camif->media_dev;
>  	struct v4l2_device *v4l2_dev = &camif->v4l2_dev;
>  	unsigned int ip_rev = camif->variant->ip_revision;
> -	int ret;
>  
>  	memset(md, 0, sizeof(*md));
>  	snprintf(md->model, sizeof(md->model), "Samsung S3C%s CAMIF",
> @@ -316,11 +315,7 @@ static int camif_media_dev_init(struct camif_dev *camif)
>  
>  	media_device_init(md);
>  
> -	ret = v4l2_device_register(camif->dev, v4l2_dev);
> -	if (ret < 0)
> -		return ret;
> -
> -	return ret;
> +	return v4l2_device_register(camif->dev, v4l2_dev);
>  }
>  
>  static void camif_clk_put(struct camif_dev *camif)
> diff --git a/drivers/media/usb/dvb-usb-v2/mxl111sf.c b/drivers/media/usb/dvb-usb-v2/mxl111sf.c
> index 870ac3c8b085..6404eb74db32 100644
> --- a/drivers/media/usb/dvb-usb-v2/mxl111sf.c
> +++ b/drivers/media/usb/dvb-usb-v2/mxl111sf.c
> @@ -987,11 +987,7 @@ static int mxl111sf_frontend_attach_atsc_mh(struct dvb_usb_adapter *adap)
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = mxl111sf_lg2160_frontend_attach(adap, 2);
> -	if (ret < 0)
> -		return ret;
> -
> -	return ret;
> +	return mxl111sf_lg2160_frontend_attach(adap, 2);
>  }
>  
>  static int mxl111sf_frontend_attach_mercury(struct dvb_usb_adapter *adap)
> @@ -1007,11 +1003,7 @@ static int mxl111sf_frontend_attach_mercury(struct dvb_usb_adapter *adap)
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = mxl111sf_lg2161_ep6_frontend_attach(adap, 2);
> -	if (ret < 0)
> -		return ret;
> -
> -	return ret;
> +	return mxl111sf_lg2161_ep6_frontend_attach(adap, 2);
>  }
>  
>  static int mxl111sf_frontend_attach_mercury_mh(struct dvb_usb_adapter *adap)
> diff --git a/drivers/media/usb/gspca/jl2005bcd.c b/drivers/media/usb/gspca/jl2005bcd.c
> index a408fcc3a060..4988fbf5005e 100644
> --- a/drivers/media/usb/gspca/jl2005bcd.c
> +++ b/drivers/media/usb/gspca/jl2005bcd.c
> @@ -148,17 +148,12 @@ static int jl2005c_start_new_frame(struct gspca_dev *gspca_dev)
>  static int jl2005c_write_reg(struct gspca_dev *gspca_dev, unsigned char reg,
>  						    unsigned char value)
>  {
> -	int retval;
>  	u8 instruction[2];
>  
>  	instruction[0] = reg;
>  	instruction[1] = value;
>  
> -	retval = jl2005c_write2(gspca_dev, instruction);
> -	if (retval < 0)
> -			return retval;
> -
> -	return retval;
> +	return jl2005c_write2(gspca_dev, instruction);
>  }
>  
>  static int jl2005c_get_firmware_id(struct gspca_dev *gspca_dev)

-- 
Regards,

Laurent Pinchart
