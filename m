Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99E16C61CE2
	for <cocci@archiver.kernel.org>; Mon, 24 Aug 2026 07:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=SzUgHXjtSETp6lfN9pg6tEvs59h47Kp6Fwngel15g8M=;
  b=h+1aP3JNxhbUusfYm9rRIYEAW0Y5+14jswR19eVROAw8TRSkPz5B/8uh
   HZR7+bv0ADcswjCyr+e2OODpErjYgvly1bmnCPZbI2fUaYq0o8jBJFbc4
   VW6+/TsQwhy+1DpDTCmPjVAf6QSazWCxIbecace8jgM7Jr5SljHOSNq75
   8=;
X-CSE-ConnectionGUID: /LeSTU84Qs29bxqYxMqqSw==
X-CSE-MsgGUID: GyalOifVSEaiWtrwyMxVjg==
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
X-IronPort-AV: E=Sophos;i="6.25,240,1779141600"; 
   d="scan'208";a="291206814"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Aug 2026 09:35:04 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 09EAF81658; Mon, 24 Aug 2026 09:35:04 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 5228780340
	for <cocci@sympa.inria.fr>; Mon, 10 Aug 2026 11:41:39 +0200 (CEST)
X-CSE-ConnectionGUID: 83/evq2XRw+IcXKtIYOWHQ==
X-CSE-MsgGUID: MZHsz1YYRn+S+Jdb1OVq9Q==
IronPort-SDR: 6a799cd2_qokxlQrprdBuJnlzBrae1Qa275vf+UzxtmEJKGH9gdSNOqh
 B2QWQHIxd9d4Q+be2LYdAW1BegZZFJx6Z8NnXyg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HtAAAbnHlqjw2jxsBaHgEBCxIMggULgW5TgWkzBAtJj?=
 =?us-ascii?q?VKGWIIhA4tkkjeBPz0CDwEDAQ1OAQIEAQEBAgSEfgKNZwIeBwEEMAkOAQIEA?=
 =?us-ascii?q?wIDAQEBAQEBAQEBAQELAQEBBAEBAQIBAQIEAwEBAQECEAEBAQEBATkFSYZPD?=
 =?us-ascii?q?YJiAYEkXgcJOAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBARECDV4BHgEBAQECA?=
 =?us-ascii?q?ScTBgEBNwEPCxguEBA2BhODAoIjAQYRAxAnAwHFRniBATOBAYIMAQEG2zMNc?=
 =?us-ascii?q?oFpCRQBgTiFcYJMIAGFeIQCeicPgVVEhEA+gh+IaYImgQyCaI9+UngcA1ksA?=
 =?us-ascii?q?VUTFwsHBYEjQwOBBiNLBS0OD4EjIR0XFx5YGwYFEiAqQUQjAz4dQwWBTgKBd?=
 =?us-ascii?q?D8jGTZ8gQlegSsqZAECEBdGLhWCNQKCdoEtBBELbT03FBmPLiCCRQEBVyMUG?=
 =?us-ascii?q?4ELNU0XkAGDTgEHgyMBjw2gJD00B4QhgWAGDJlthkmEBJQXklGZCJITlzCBa?=
 =?us-ascii?q?DqBXDMaI4M3UAMZD44hDA0Jg2DMHEE1PgEHAgcPAoFzg1sBAQGMVoFMAQE?=
IronPort-PHdr: A9a23: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
 vbZog9/Z/k9sjbq/1ozYFHNoXlp+HQ=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:yIci0qw/ju28sIj8T2LqKrPw1L1zdoMgy1knxilNoNJuA7elfu
 SV7YUmPH7P+UgssRQb8uxoV5PwJk80maQFmLX5eI3SLDUO21HYU72Kj7GSvgEIyxeOkNK1vJ
 0IG8YObayVMbE5t7eH3ODSKadb/DDoytHRuc7ui11WYUVBbaZm4w1lCgCdPHFXaWB9b/sEPa
 vZzPBq4x67d1oqTunTPBRkYwGFnaypqHvhW3Jodnwa1DU=
X-Talos-CUID: 9a23:WSlX2mzDZw+98KrkpJi2BgVEQYcobGSH/E3PYG6zOUV1aYyydn+prfY=
X-Talos-MUID: 9a23:wamqSwu0BplMrEDQt82noQNCL9Ux0pWUDgM20rcKsZCjCzUhAmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,215,1779141600"; 
   d="scan'208";a="289663863"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDEemnt6hAE5RR4e+TIO0t0tQrTo3+ZLFtIQAN?=
 =?us-ascii?q?9CfRN9EncAOl/PBxdnWnK/BEG7A9+Ilg8Vmrbx4rCMDQmml5j23pjjrH?=
 =?us-ascii?q?HgHqxDuJf1+AAOfqDYAVwM5JprbeRZq03BnyHs7votntR4fLbTv9m7Ll?=
 =?us-ascii?q?Q8XdiUUslp6aklFsgMiblE9Q=3D=3D?=
Received: from mgamail.intel.com ([192.198.163.13])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 11:41:38 +0200
X-CSE-ConnectionGUID: EZKKmJ5DTkmQONIPBWBc3Q==
X-CSE-MsgGUID: mHvKLcsdTh+4rM/XmVuqHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="89387734"
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="89387734"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 02:41:33 -0700
X-CSE-ConnectionGUID: KR5OuCjVQT+N3NNT/q2FfQ==
X-CSE-MsgGUID: 8GqWIe1WQnyFLae702V6Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="263607423"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.127])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 02:41:28 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 21C8C11FA5C;
	Mon, 10 Aug 2026 12:41:27 +0300 (EEST)
Date: Mon, 10 Aug 2026 12:41:27 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Sang-Heon Jeon <ekffu200098@gmail.com>, Julia.Lawall@inria.fr,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Eugen Hristev <ehristev@kernel.org>,
	Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
	Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
	Bryan O'Donoghue <bod@kernel.org>,
	Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund@ragnatech.se>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Sylwester Nawrocki <sylvester.nawrocki@gmail.com>,
	Michael Krufky <mkrufky@linuxtv.org>,
	Hans Verkuil <hverkuil@kernel.org>, cocci@inria.fr,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org
Message-ID: <anmcxzxwQSzPfXEr@kekkonen.localdomain>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
 <20260723184538.3888637-13-ekffu200098@gmail.com>
 <20260807122825.GJ2201016@killaraus.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807122825.GJ2201016@killaraus.ideasonboard.com>
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH 12/36] media: remove conditional return with no
 effect
Reply-To: Sakari Ailus <sakari.ailus@linux.intel.com>
X-Loop: cocci@inria.fr
X-Sequence: 3697
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-08/9a5qb_NUIS_A5Zzn88H_VQ>

Hi Laurent, Sang-Heon,

On Fri, Aug 07, 2026 at 03:28:25PM +0300, Laurent Pinchart wrote:
> On Fri, Jul 24, 2026 at 03:45:14AM +0900, Sang-Heon Jeon wrote:
> > Both branches of the check return the same value, so the check has
> > no effect. Remove it and return the value directly.
> > 
> > This is the result of running the Coccinelle script from
> > scripts/coccinelle/misc/cond_return_no_effect.cocci.
> > 
> > Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> > ---
> >  drivers/media/i2c/mt9p031.c                          |  6 +-----
> >  .../media/platform/microchip/microchip-sama7g5-isc.c |  7 +------
> >  drivers/media/platform/qcom/iris/iris_resources.c    |  6 +-----
> >  drivers/media/platform/qcom/venus/pm_helpers.c       |  7 +------
> >  drivers/media/platform/renesas/rcar-csi2.c           |  6 +-----
> >  .../media/platform/samsung/s3c-camif/camif-core.c    |  7 +------
> >  drivers/media/usb/dvb-usb-v2/mxl111sf.c              | 12 ++----------
> >  drivers/media/usb/gspca/jl2005bcd.c                  |  7 +------
> >  8 files changed, 9 insertions(+), 49 deletions(-)
> > 
> > diff --git a/drivers/media/i2c/mt9p031.c b/drivers/media/i2c/mt9p031.c
> > index d21510caf45a..2b09e8315c8e 100644
> > --- a/drivers/media/i2c/mt9p031.c
> > +++ b/drivers/media/i2c/mt9p031.c
> > @@ -452,11 +452,7 @@ static int mt9p031_set_params(struct mt9p031 *mt9p031)
> >  	ret = mt9p031_write(client, MT9P031_HORIZONTAL_BLANK, hblank - 1);
> >  	if (ret < 0)
> >  		return ret;
> > -	ret = mt9p031_write(client, MT9P031_VERTICAL_BLANK, vblank - 1);
> > -	if (ret < 0)
> > -		return ret;
> > -
> > -	return ret;
> 
> I would have just replaced the last line with a
> 
> 	return 0;
> 
> as I find it easier to read code that has multiple error paths when all
> the error paths look the same. It's a small personal preference though
> (and ths best option would be to convert this driver to the CCI
> helpers), so I'm OK with this change as-is.

I wouldn't make an exception here, but obviously CCI is the way to go.

> 
> > +	return mt9p031_write(client, MT9P031_VERTICAL_BLANK, vblank - 1);
> >  }
> >  
> >  static int mt9p031_s_stream(struct v4l2_subdev *subdev, int enable)
> > diff --git a/drivers/media/platform/microchip/microchip-sama7g5-isc.c b/drivers/media/platform/microchip/microchip-sama7g5-isc.c
> > index b0302dfc3278..7383341ec51d 100644
> > --- a/drivers/media/platform/microchip/microchip-sama7g5-isc.c
> > +++ b/drivers/media/platform/microchip/microchip-sama7g5-isc.c
> > @@ -598,13 +598,8 @@ static int __maybe_unused xisc_runtime_suspend(struct device *dev)
> >  static int __maybe_unused xisc_runtime_resume(struct device *dev)
> >  {
> >  	struct isc_device *isc = dev_get_drvdata(dev);
> > -	int ret;
> > -
> > -	ret = clk_prepare_enable(isc->hclock);
> > -	if (ret)
> > -		return ret;
> >  
> > -	return ret;
> > +	return clk_prepare_enable(isc->hclock);
> 
> Here the change looks good, there's a single error paths so a direct
> return is fine.
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> >  }
> >  
> >  static const struct dev_pm_ops microchip_xisc_dev_pm_ops = {
> > diff --git a/drivers/media/platform/qcom/iris/iris_resources.c b/drivers/media/platform/qcom/iris/iris_resources.c
> > index 773f6548370a..872bd09656b1 100644
> > --- a/drivers/media/platform/qcom/iris/iris_resources.c
> > +++ b/drivers/media/platform/qcom/iris/iris_resources.c
> > @@ -78,11 +78,7 @@ int iris_enable_power_domains(struct iris_core *core, struct device *pd_dev)
> >  	if (ret)
> >  		return ret;
> >  
> > -	ret = pm_runtime_get_sync(pd_dev);
> > -	if (ret < 0)
> > -		return ret;
> > -
> > -	return ret;
> > +	return pm_runtime_get_sync(pd_dev);

The patch no longer applies after commit
f87d7eda07fca21efe4b96169ae59007db46e60e .

> >  }
> >  
> >  int iris_disable_power_domains(struct iris_core *core, struct device *pd_dev)
> > diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
> > index be1cbd5cfe84..e88e66be4f6d 100644
> > --- a/drivers/media/platform/qcom/venus/pm_helpers.c
> > +++ b/drivers/media/platform/qcom/venus/pm_helpers.c
> > @@ -781,7 +781,6 @@ static int decide_core(struct venus_inst *inst)
> >  	unsigned long max_freq = ULONG_MAX;
> >  	struct device *dev = core->dev;
> >  	struct dev_pm_opp *opp;
> > -	int ret = 0;
> >  
> >  	if (legacy_binding) {
> >  		if (inst->session_type == VIDC_SESSION_TYPE_DEC)
> > @@ -829,11 +828,7 @@ static int decide_core(struct venus_inst *inst)
> >  	}
> >  
> >  done:
> > -	ret = hfi_session_set_property(inst, ptype, &cu);
> > -	if (ret)
> > -		return ret;
> > -
> > -	return ret;
> > +	return hfi_session_set_property(inst, ptype, &cu);
> >  }
> >  
> >  static int acquire_core(struct venus_inst *inst)
> > diff --git a/drivers/media/platform/renesas/rcar-csi2.c b/drivers/media/platform/renesas/rcar-csi2.c
> > index 7305cc4a04cb..6635f5782175 100644
> > --- a/drivers/media/platform/renesas/rcar-csi2.c
> > +++ b/drivers/media/platform/renesas/rcar-csi2.c
> > @@ -2273,11 +2273,7 @@ static int rcsi2_init_phtw_v3u(struct rcar_csi2 *priv,
> >  			return ret;
> >  	}
> >  
> > -	ret = rcsi2_phtw_write_array(priv, step4, ARRAY_SIZE(step4));
> > -	if (ret)
> > -		return ret;
> > -
> > -	return ret;
> > +	return rcsi2_phtw_write_array(priv, step4, ARRAY_SIZE(step4));
> >  }
> >  
> >  /* -----------------------------------------------------------------------------
> > diff --git a/drivers/media/platform/samsung/s3c-camif/camif-core.c b/drivers/media/platform/samsung/s3c-camif/camif-core.c
> > index 14eedd1ceb27..bb06847f3a63 100644
> > --- a/drivers/media/platform/samsung/s3c-camif/camif-core.c
> > +++ b/drivers/media/platform/samsung/s3c-camif/camif-core.c
> > @@ -301,7 +301,6 @@ static int camif_media_dev_init(struct camif_dev *camif)
> >  	struct media_device *md = &camif->media_dev;
> >  	struct v4l2_device *v4l2_dev = &camif->v4l2_dev;
> >  	unsigned int ip_rev = camif->variant->ip_revision;
> > -	int ret;
> >  
> >  	memset(md, 0, sizeof(*md));
> >  	snprintf(md->model, sizeof(md->model), "Samsung S3C%s CAMIF",
> > @@ -316,11 +315,7 @@ static int camif_media_dev_init(struct camif_dev *camif)
> >  
> >  	media_device_init(md);
> >  
> > -	ret = v4l2_device_register(camif->dev, v4l2_dev);
> > -	if (ret < 0)
> > -		return ret;
> > -
> > -	return ret;
> > +	return v4l2_device_register(camif->dev, v4l2_dev);
> >  }
> >  
> >  static void camif_clk_put(struct camif_dev *camif)
> > diff --git a/drivers/media/usb/dvb-usb-v2/mxl111sf.c b/drivers/media/usb/dvb-usb-v2/mxl111sf.c
> > index 870ac3c8b085..6404eb74db32 100644
> > --- a/drivers/media/usb/dvb-usb-v2/mxl111sf.c
> > +++ b/drivers/media/usb/dvb-usb-v2/mxl111sf.c
> > @@ -987,11 +987,7 @@ static int mxl111sf_frontend_attach_atsc_mh(struct dvb_usb_adapter *adap)
> >  	if (ret < 0)
> >  		return ret;
> >  
> > -	ret = mxl111sf_lg2160_frontend_attach(adap, 2);
> > -	if (ret < 0)
> > -		return ret;
> > -
> > -	return ret;
> > +	return mxl111sf_lg2160_frontend_attach(adap, 2);
> >  }
> >  
> >  static int mxl111sf_frontend_attach_mercury(struct dvb_usb_adapter *adap)
> > @@ -1007,11 +1003,7 @@ static int mxl111sf_frontend_attach_mercury(struct dvb_usb_adapter *adap)
> >  	if (ret < 0)
> >  		return ret;
> >  
> > -	ret = mxl111sf_lg2161_ep6_frontend_attach(adap, 2);
> > -	if (ret < 0)
> > -		return ret;
> > -
> > -	return ret;
> > +	return mxl111sf_lg2161_ep6_frontend_attach(adap, 2);
> >  }
> >  
> >  static int mxl111sf_frontend_attach_mercury_mh(struct dvb_usb_adapter *adap)
> > diff --git a/drivers/media/usb/gspca/jl2005bcd.c b/drivers/media/usb/gspca/jl2005bcd.c
> > index a408fcc3a060..4988fbf5005e 100644
> > --- a/drivers/media/usb/gspca/jl2005bcd.c
> > +++ b/drivers/media/usb/gspca/jl2005bcd.c
> > @@ -148,17 +148,12 @@ static int jl2005c_start_new_frame(struct gspca_dev *gspca_dev)
> >  static int jl2005c_write_reg(struct gspca_dev *gspca_dev, unsigned char reg,
> >  						    unsigned char value)
> >  {
> > -	int retval;
> >  	u8 instruction[2];
> >  
> >  	instruction[0] = reg;
> >  	instruction[1] = value;
> >  
> > -	retval = jl2005c_write2(gspca_dev, instruction);
> > -	if (retval < 0)
> > -			return retval;
> > -
> > -	return retval;
> > +	return jl2005c_write2(gspca_dev, instruction);
> >  }
> >  
> >  static int jl2005c_get_firmware_id(struct gspca_dev *gspca_dev)
> 

-- 
Regards,

Sakari Ailus
