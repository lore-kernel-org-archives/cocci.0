Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58124C531FA
	for <cocci@archiver.kernel.org>; Fri, 24 Jul 2026 08:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=SwEjmO2jCXryeO/+vZSbFs1N6H7TTum1y2++GBGUUZo=;
  b=hLQzNLVEJE81uvx0JT4iUFg4DuFe67yfNPKAFH7iN3QpuD2IZ5tIA9A+
   /B2dnoW7X0tJz8YbKL+HDVKM4JXE0or54GFJ2LghYAypxN/LaDrHDpIup
   c8N5uuTFHZhan3qBO5zbkWybvUKdd7bw7BcbXkq5MpHsDp5vPjxw0OBkL
   4=;
X-CSE-ConnectionGUID: Pr8IOZH/Q0SU1dToAbPOTw==
X-CSE-MsgGUID: b8PtqWZfQPGYxSFEEMHEYg==
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
   d="scan'208";a="287734727"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jul 2026 10:55:02 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 7D21D804F5; Fri, 24 Jul 2026 10:55:02 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 623648003A
	for <cocci@sympa.inria.fr>; Fri, 24 Jul 2026 02:38:36 +0200 (CEST)
X-CSE-ConnectionGUID: RDKOm6YMSHObaEjWrJ/gzQ==
X-CSE-MsgGUID: IbTj+PTJT72L1hVL/eHWig==
IronPort-SDR: 6a62b40a_9D2CtVM+Jf4nsJdB8EJ5c4kX2tDIJ2UgwNVW0sPgemPjvp5
 7QDP527SgTBchjk/w/ESnvRNO0ByYLLL5OGBbIw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0H3AQB+smJqhR/86qxaHgEBCxIMggULAoI/gWkzBAtJj?=
 =?us-ascii?q?VKGWF0GgT4Di2QQkieBfAIPAQMBDVEEAQEBAgSEfgKNYAIeBwEEMAkOAQIEA?=
 =?us-ascii?q?wIDAQEBAQEBAQEBAQELAQEBBAEBAQIBAQIEAwEBAQECEAEBAQFASYZPDUkBE?=
 =?us-ascii?q?AGCBwGBJIEmAQEBAQEBAQEBAQEBHQINfgEBAQIBJxMGAQE3AQQLC0YgNgYTg?=
 =?us-ascii?q?wKCIwcRAxAnA8NkgQEzgQGCDAEBBtsyDXKBaQkUAYE4iDwgAYV3hAJ6J4EYg?=
 =?us-ascii?q?RCEQD6CH4hpgiaBDJIuSAp4eCwBVRMNCgsHBV5FQwM1EioVI0sFLR1kPyEdF?=
 =?us-ascii?q?xYeWBsHBRIgKkFFIwNBJhA4C0MFgVYCgXg/Ix8DOX+BL3VKdy1pAQIQF0o4J?=
 =?us-ascii?q?INJAoE3AwsYDUgRLDcUGUJuB41rI4FeWwcBcxsHA0qBVIFRAQGSG5FMoQlwA?=
 =?us-ascii?q?QYChB+bX4V8TRMDg26NFIY7kxmTK4VdkhOSR4RpgWg6gVwzGjCBYYFJUAMZD?=
 =?us-ascii?q?44hDA0JiHPFL0M1PgEHAgcPAoFzizOFAYFMAQE?=
IronPort-PHdr: A9a23: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
 R0FxfX/N4tBbuUTPmRhZ0N8kYCMHFDfD4glnw==
IronPort-Data: A9a23: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
 kBtLV15rIqHpYId3Cqul7O52P3Ugd838wgVUA==
IronPort-HdrOrdr: A9a23:/zzpxaxti78YGoUitlERKrPwKb1zdoMgy1knxilNoNJuE/Bw8P
 re5cjztCWE7gr5PUtMpTnuAsW9qB/nmqKdpLNhX4tKPzOW31dATrsSjrcKqgeIc0aVygce79
 YET0EUMr3N5DZB4/oSmDPId+od/A==
X-Talos-CUID: =?us-ascii?q?9a23=3AKvVzrGvV+aPR87NGLPWtanyB6IsfXl76ySnhBnS?=
 =?us-ascii?q?YLmxgZb+qU33X97Fdxp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AkU+aIQyT77KpIwbcz9WWfQrsSfSaqIWkNEJOqak?=
 =?us-ascii?q?kh5beEXVwBRPagRSIQ4Byfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,181,1779141600"; 
   d="scan'208";a="287686990"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDFlm9aQPPXTjKeLn3OySFds24xL5s9Jl4NJ12?=
 =?us-ascii?q?HQA1jH/G52g8TWObQcoOobpGvf+3uGoger0lIgwLPhAsZLTYhjL9NcFj?=
 =?us-ascii?q?r9+GFkTtkup/lAsHEl97gcvMo9wVA5s3VCOhjBih+sEFO6aypxqMvtuf?=
 =?us-ascii?q?vKG/KHNFeg6rRGWVLDb3kC0Q=3D=3D?=
Received: from sea.source.kernel.org ([172.234.252.31])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 02:38:34 +0200
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 662B441804;
	Fri, 24 Jul 2026 00:38:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18F341F000E9;
	Fri, 24 Jul 2026 00:38:31 +0000 (UTC)
Date: Fri, 24 Jul 2026 01:38:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: Julia.Lawall@inria.fr, Linus Walleij <linusw@kernel.org>,
 cocci@inria.fr, Andy Shevchenko <andy@kernel.org>, David Lechner
 <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Message-ID: <20260724013827.612dd9ab@jic23-huawei>
In-Reply-To: <20260723184538.3888637-16-ekffu200098@gmail.com>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
	<20260723184538.3888637-16-ekffu200098@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH 15/36] iio: remove conditional return with no
 effect
Reply-To: Jonathan Cameron <jic23@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 3642
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/APGO5fZxtNdsi6NlkpRa9g>

On Fri, 24 Jul 2026 03:45:17 +0900
Sang-Heon Jeon <ekffu200098@gmail.com> wrote:

> Both branches of the check return the same value, so the check has
> no effect. Remove it and return the value directly.
> 
> This is the result of running the Coccinelle script from
> scripts/coccinelle/misc/cond_return_no_effect.cocci.
> 
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> ---
>  drivers/iio/light/isl29028.c      |  6 +-----
>  drivers/iio/light/tsl2583.c       | 14 +++-----------
>  drivers/iio/magnetometer/ak8974.c |  6 +-----
>  3 files changed, 5 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/iio/light/isl29028.c b/drivers/iio/light/isl29028.c
> index b88e7c4eae3e..ea38d797082b 100644
> --- a/drivers/iio/light/isl29028.c
> +++ b/drivers/iio/light/isl29028.c
> @@ -405,11 +405,7 @@ static int isl29028_write_raw(struct iio_dev *indio_dev,
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = isl29028_set_pm_runtime_busy(chip, false);
> -	if (ret < 0)
> -		return ret;
> -
> -	return ret;
> +	return isl29028_set_pm_runtime_busy(chip, false);

That should have been a return 0.  The call to pm_runtime_put_auto_suspend()
can return positive (in theory anyway).  The intent here was probably to eat
that positive and ensure we return 0 or negative only from this function

Please split up a fix for this as a separate patch.

Even better if you have time would be to do that and then a second patch to
get rid of this helper that adds no obvious value.  Smells like code
that evolved into a slightly silly form!


>  }
>  
>  static int isl29028_read_raw(struct iio_dev *indio_dev,
> diff --git a/drivers/iio/light/tsl2583.c b/drivers/iio/light/tsl2583.c
> index a0dd122af2cf..a38a0130d854 100644
> --- a/drivers/iio/light/tsl2583.c
> +++ b/drivers/iio/light/tsl2583.c
> @@ -456,12 +456,8 @@ static int tsl2583_chip_init_and_power_on(struct iio_dev *indio_dev)
>  
>  	usleep_range(3000, 3500);
>  
> -	ret = tsl2583_set_power_state(chip, TSL2583_CNTL_PWR_ON |
> -					    TSL2583_CNTL_ADC_ENBL);
> -	if (ret < 0)
> -		return ret;
> -
> -	return ret;
> +	return tsl2583_set_power_state(chip,
> +				       TSL2583_CNTL_PWR_ON | TSL2583_CNTL_ADC_ENBL);
>  }
>  
>  /* Sysfs Interface Functions */
> @@ -790,11 +786,7 @@ static int tsl2583_write_raw(struct iio_dev *indio_dev,
>  		return ret;
>  	}
>  
> -	ret = tsl2583_set_pm_runtime_busy(chip, false);
> -	if (ret < 0)
> -		return ret;
> -
> -	return ret;
> +	return tsl2583_set_pm_runtime_busy(chip, false);
Similar to case above.   It should have been eating the positive return
by return 0;  Also the same suggested follow up cleanup applies in this driver.

>  }
>  
>  static const struct iio_info tsl2583_info = {
> diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer/ak8974.c
> index c7fdb7c2f543..c988d0e40cea 100644
> --- a/drivers/iio/magnetometer/ak8974.c
> +++ b/drivers/iio/magnetometer/ak8974.c
> @@ -379,11 +379,7 @@ static int ak8974_getresult(struct ak8974 *ak8974, __le16 *result)
>  		return -ERANGE;
>  	}
>  
> -	ret = regmap_bulk_read(ak8974->map, AK8974_DATA_X, result, 6);
> -	if (ret)
> -		return ret;
> -
> -	return ret;
> +	return regmap_bulk_read(ak8974->map, AK8974_DATA_X, result, 6);
This one I agree with.

Thanks for looking at these.  I suspect you may want to take a closer
look at any other changes you've scripted that are similarl

When code is doing something silly it might just be that, or it might
be intended to do something not so silly!

Jonathan

>  }
>  
>  static irqreturn_t ak8974_drdy_irq(int irq, void *d)

