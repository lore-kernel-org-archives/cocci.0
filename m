Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D7BBC5DF7D
	for <cocci@archiver.kernel.org>; Fri, 21 Aug 2026 08:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=ZDOdXiVF/xf41VWsCiqG4/1i+sm5JmjMqfQEkuoApZs=;
  b=WPZe+HE0W0eKwIfJyziCCe65tEPkE9Dh55ktNB8n0JJXFTPkzb6OCKRB
   sRNWK+73SoBYTMIMXgniPNup/5YKUUNOKfEFdQUhyd4AFOQwtiNx5dg2/
   49kWhCIjNhDLsDrDeAAbdGnfEOz3POfjDcvI9kXr4HDZrXgPqOE7l8nlz
   Y=;
X-CSE-ConnectionGUID: qwFuEejCS1uSegIyUT8NpA==
X-CSE-MsgGUID: CAaVlJ7KTzmSIYkcuVWwkw==
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
   d="scan'208";a="290932963"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Aug 2026 10:26:56 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id ED7D2812DE; Fri, 21 Aug 2026 10:26:55 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id E433781976
	for <cocci@sympa.inria.fr>; Fri,  7 Aug 2026 09:52:37 +0200 (CEST)
X-CSE-ConnectionGUID: V+I+wBZ/QZOQ74t2XF0gNw==
X-CSE-MsgGUID: m7HiVfTBSYGKj/txQGhH5A==
IronPort-SDR: 6a758ec5_Cuh9pGcgCB0n7qV6/yDzJZ/3Ow+gPnwBhtzzlXCHlB6pJaW
 u8d4vghxvQFiXS/WJ5whIPP53LfSjPoyhpQK6bw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0F3AQCIjXVqhf4EaaxaHgEBCxIMggULgkGBaTMEC0mEW?=
 =?us-ascii?q?Ih6hliBdDCEO4cpkGKBVYF8Ag8BAwENUQQBAQECBIR+Ao1nAh4HAQQwCQ4BA?=
 =?us-ascii?q?gQDAgMBAQEBAQEBAQEBAQsBAQEEAQEBAgEBAgQDAQEBAQIQAQEBAUBJhk8Ng?=
 =?us-ascii?q?mIBgSSBJgEBAQEBAQEBAQEBAR0CDX4BAQEDIwQZAQE3AQ8LGAICJgICIDYGA?=
 =?us-ascii?q?RICAQGCfoIjBxEDNwO/Fn8zgQGCDAEBBtsyDXKBaQkUAYEKLog9IAGFeDuDR?=
 =?us-ascii?q?3onG4FJRIE8C4J5PoIfgjmDRoJqgiaBDJJ5UngcA1ksAVUTFwsHBV5FEDMDI?=
 =?us-ascii?q?AovLQIUDSIPBBYFLR1wDCcSDx0XFx5YGwcFEiAqQUQjAxMrHUMFgU0CgXQ/I?=
 =?us-ascii?q?xk2fIEJXoEtKmQBAhAXRi4VgmECgneBNQQBC209NwYDCxkEPY5+IYJHAYEOg?=
 =?us-ascii?q?igXkAGDVpFMZaAkcYQnm1+GAQYPBC+XU5MZmQgjkXCXMIFoOoFcMxoIKAiDI?=
 =?us-ascii?q?lADGQ+OIRmIfIoqAbxeQTU+AQcCBw8CgXOQNIFMAQE?=
IronPort-PHdr: A9a23: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
 8NT5vk77fWufY9TVW70AHMPI23y
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:Vnypj68e4zvWCs/SWxBuk+AoI+orL9Y04lQ7vn2ZKSYlCfBw5P
 re+MjzsiWE8Ar5OUtQ4OxoXZPwO080mqQa3WB8B8bEYOCighrPEGgA1+rfKl/bdBEWn9Q1vc
 0NT0E9MqyUMbETt63HCWKDYrUdKbe8gcKVbKvlr0uEEmlRBp1I3kNCMy6+VnZbfjViOPMCZe
 Whz/sCnQOJXTAsROKBKhA+LpT+juyOrqvPRVo9OjYb1DPmt0LU1ILH
X-Talos-CUID: 9a23:uPjjCW9f0jb2Qk9fxNqVv3BXO4M6WE+a9UX3GhDkFTxZZuWab0DFrQ==
X-Talos-MUID: 9a23:GC0wngZbHzrpguBTsmDMhQ9sCO1T0ouNCgcRgawpu+nZHHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,210,1779141600"; 
   d="scan'208";a="289406850"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDFAEOYE4O83r0OW7AaOT1R3KiUnGdI0y+R+2L?=
 =?us-ascii?q?Sg3MNoW/bRjeXR4yUX7uCiEFY7BryZJGnKN7KEh8vECdZBWn9K/Yqm4h?=
 =?us-ascii?q?dxjM5mi43BcjeUTWbieZM919TbwHUTYuzJnMCxW1xvkddwQzDeR4DtyH?=
 =?us-ascii?q?M4H7bmGshX9iBLZZHzsvD73g=3D=3D?=
Received: from tor.source.kernel.org ([172.105.4.254])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 09:52:36 +0200
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id EF28860AB0;
	Fri,  7 Aug 2026 07:52:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 529391F000E9;
	Fri,  7 Aug 2026 07:52:29 +0000 (UTC)
Message-ID: <2284aa9b-9299-4c43-8af9-d5cfd84452d6@kernel.org>
Date: Fri, 7 Aug 2026 10:52:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Sang-Heon Jeon <ekffu200098@gmail.com>, Julia.Lawall@inria.fr,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Bryan O'Donoghue <bod@kernel.org>,
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Sylwester Nawrocki <sylvester.nawrocki@gmail.com>,
 Michael Krufky <mkrufky@linuxtv.org>, Hans Verkuil <hverkuil@kernel.org>
Cc: cocci@inria.fr, Abhinav Kumar <abhinav.kumar@linux.dev>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
 <20260723184538.3888637-13-ekffu200098@gmail.com>
From: Eugen Hristev <ehristev@kernel.org>
Content-Language: en-US
In-Reply-To: <20260723184538.3888637-13-ekffu200098@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH 12/36] media: remove conditional return with no
 effect
Reply-To: Eugen Hristev <ehristev@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 3687
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-08/9-N-E_A3w6S2DFeMbshpbg>

On 7/23/26 21:45, Sang-Heon Jeon wrote:
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
>  }
>  

For microchip isc,

Reviewed-by: Eugen Hristev <ehristev@kernel.org>


