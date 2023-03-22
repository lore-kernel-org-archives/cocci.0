Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1899EC77B60
	for <cocci@archiver.kernel.org>; Wed, 22 Mar 2023 10:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=yT81fKLmpzXLewKztLGeWy+9tYKaRNjg+cYubwEYNAs=;
  b=A3Ti0wIck/aVqh7ZtYBjJc8qBCYMbr+UCkbTEAKq68a6gLLQqGOy0ne8
   jZrduBq63TRfJU5L7B7LpeYsYk4ffDqRHyoEiFIPiDukrahG1wjStL0aj
   z4iUQZgg4O4VZW+blgPeTheEWFaZDhXscRA9XWRYssqmcdrLA0Gnrogsi
   M=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@collabora.com
X-IronPort-AV: E=Sophos;i="5.98,281,1673910000"; 
   d="scan'208";a="98472412"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Mar 2023 11:20:21 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E57C4E0D42; Wed, 22 Mar 2023 11:20:21 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 5522EE0131
	for <cocci@sympa.inria.fr>; Wed, 22 Mar 2023 10:36:52 +0100 (CET)
IronPort-SDR: 641acc33_nWWPGql8hlxfO3gA5L8mEvw/kTsV0in4jesgMvHkEmS2Yti
 IQuFYKWXC36odxp/Mhy4/PSHxv/iy5UOgSOmrtQ==
X-IPAS-Result: =?us-ascii?q?A0EYAAALyxpkkKzj6y5aHQEBAQEJARIBBQUBQIE7CAELA?=
 =?us-ascii?q?YFbUoFLLwQLRoRTiB+Ga4F3LgOEL5NNhAKBVoF+DwEDAQ1BAQIEAQEDBIILg?=
 =?us-ascii?q?nMCCIUuAh0HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAEBA?=
 =?us-ascii?q?hABAQEBAQEgHhAOJ4VoDYI3KQF1gQgBAQEBAQEBAQEBAQEBAQEBAQEBFgIIU?=
 =?us-ascii?q?l0BAR4BAgIBIwQLAQUIAQE3AQ8JAhQGAiYCAlcGAQwGAgEBgnqCOiMEA5VSn?=
 =?us-ascii?q?Bd/M4EBgggBAQadSoFeCYEULQGNBIM2eicPgVVEgRUnDIEJbYEBPogcgmeCK?=
 =?us-ascii?q?YdXg3WCeogrCoE0doEgDoE9gQQCCQIRa4ESCGuBfUECDWULDnGBSwJkTTMlB?=
 =?us-ascii?q?A4DGSsdQAIBCzs6PzUGAwsgBlhrAgkjERMFAwsVKkcECDkGGzQRAggPEg8GJ?=
 =?us-ascii?q?kQOQjc0EwZcASkLDhEDT4FHBC+BXwYBJiScGXMBUigTTCaBN02SWJJAng40B?=
 =?us-ascii?q?4N9gVMGDJ8MBhMuqT8uhy2QDyCneoFjOoFcTSODN08DGQ+OIBkegzuPPAE9Q?=
 =?us-ascii?q?DQ7AgcBCgEBAwmFRgEBIYVaAQE?=
IronPort-PHdr: A9a23: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
 +wx
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:0Vxx0KwMiO5nZJOpO466KrPwFb1zdoMgy1knxilNoNJuA66lfr
 OV/MjzsiWE8Qr5OUtQ/+xoXZPrfZqyz/JICOUqTNOftUzdyQyVxeJZgrcKoQeMJ8SWzIc0vp
 uIMZIObeEYZmIasS+V2njaLz9t+re6zJw=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,281,1673910000"; 
   d="scan'208";a="50896857"
X-MGA-submission: =?us-ascii?q?MDHQmLjxhXlOgCAh+ICyqx/VP0aIaAKe7R1W+u?=
 =?us-ascii?q?0f5ZJyuOG2K3wk/OpZmSUOIFuGCPn8G2+UM4kjSKie8Qokr1X1Ma/wcp?=
 =?us-ascii?q?4m7EyVstMUswnJLibBsaaHI/2kgzoVO0hSVnNBhvHZfjWbiMtBEKdMEs?=
 =?us-ascii?q?LDRRbu5kw16Q1mKxrVloXRkg=3D=3D?=
Received: from madras.collabora.co.uk ([46.235.227.172])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 10:36:51 +0100
Received: from [IPV6:2a01:e0a:120:3210:cd0d:1462:ffab:ab3a] (unknown [IPv6:2a01:e0a:120:3210:cd0d:1462:ffab:ab3a])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 0FB7566003AE;
	Wed, 22 Mar 2023 09:36:50 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1679477810;
	bh=PG6CX5ajqtdLi2tzLr2luOtl3CwHO03O+WLnE2aRKAw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lCP+okL1HpozS00eimFUyuYxd4HkDX0N6Bt75CbT7z5LnCZHxqXlEfTWHK56NJOF8
	 ptnN6IFaQFwWGCZysac0wJ2wfoHX5mMmGvw3ZCfCYxFvdfvdt1e2DItZ/2IxcishQn
	 65d/SIqvad1YHJWySE2W8pIuDOS1HvuUwVVcNoZ2HvUQe3k+8awhw6ZLw3li29Qn0a
	 kze1mDH6SI4qHQ9ounD46I5RAbU4ZEYYgxnI30HPf/r0dSzIHvqGkejiVCuVCBLmHi
	 gveFPCKOTMlT+GA9pz3jbprSIYyni/ocKC9WzoiVxpCjQ+imuUQTvxEvI3ZrO9iv2M
	 j1YwLxCp7CTOQ==
Message-ID: <5d5c8c7b-b926-8397-7994-623ac9b37e83@collabora.com>
Date: Wed, 22 Mar 2023 10:36:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To: Markus Elfring <Markus.Elfring@web.de>, kernel-janitors@vger.kernel.org,
 linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
 Adrian Ratiu <adrian.ratiu@collabora.com>,
 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
 Hans Verkuil <hverkuil-cisco@xs4all.nl>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <e3aaeecf-8e74-2e74-c58a-d80e153e98f9@web.de>
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <e3aaeecf-8e74-2e74-c58a-d80e153e98f9@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH] media: hantro: HEVC: Fix exception handling in
 tile_buffer_reallocate()
Reply-To: Benjamin Gaignard <benjamin.gaignard@collabora.com>
X-Loop: cocci@inria.fr
X-Sequence: 909
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/5d5c8c7b-b926-8397-7994-623ac9b37e83%40collabora.com>

Hi Markus,

Thanks for your patch,

Le 20/03/2023 à 19:43, Markus Elfring a écrit :
> Date: Mon, 20 Mar 2023 19:13:20 +0100
>
> The label “err_free_tile_buffers” was used to jump to another pointer
> check despite of the detail in the implementation of the function
> “tile_buffer_reallocate” that it was determined already that
> a corresponding variable contained a null pointer because of a failed
> function call “dma_alloc_coherent”.
>
> * Thus use an additional label instead.
>
> * Delete a redundant check.
>
>
> This issue was detected by using the Coccinelle software.

If you want to optimize the error path I think the best
option is to return -ENOMEM when hevc_dec->tile_filter.cpu is NULL,
remove
	if (hevc_dec->tile_bsd.cpu)
		dma_free_coherent(vpu->dev, hevc_dec->tile_bsd.size,
				  hevc_dec->tile_bsd.cpu,
				  hevc_dec->tile_bsd.dma);
and reorder the two other dma_free to get something clean.

Regards,
Benjamin

>
> Fixes: cb5dd5a0fa518dff14ff2b90837c3c8f98f4dd5c ("media: hantro: Introduce G2/HEVC decoder")
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>   drivers/media/platform/verisilicon/hantro_hevc.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/media/platform/verisilicon/hantro_hevc.c b/drivers/media/platform/verisilicon/hantro_hevc.c
> index 9383fb7081f6..ac60df18efb7 100644
> --- a/drivers/media/platform/verisilicon/hantro_hevc.c
> +++ b/drivers/media/platform/verisilicon/hantro_hevc.c
> @@ -109,7 +109,7 @@ static int tile_buffer_reallocate(struct hantro_ctx *ctx)
>                                  &hevc_dec->tile_filter.dma,
>                                  GFP_KERNEL);
>       if (!hevc_dec->tile_filter.cpu)
> -        goto err_free_tile_buffers;
> +        goto recheck_tile_sao_cpu;
>       hevc_dec->tile_filter.size = size;
>   
>       size = (VERT_SAO_RAM_SIZE * height64 * (num_tile_cols - 1) * ctx->bit_depth) / 8;
> @@ -133,12 +133,12 @@ static int tile_buffer_reallocate(struct hantro_ctx *ctx)
>       return 0;
>   
>   err_free_tile_buffers:
> -    if (hevc_dec->tile_filter.cpu)
> -        dma_free_coherent(vpu->dev, hevc_dec->tile_filter.size,
> -                  hevc_dec->tile_filter.cpu,
> -                  hevc_dec->tile_filter.dma);
> +    dma_free_coherent(vpu->dev, hevc_dec->tile_filter.size,
> +              hevc_dec->tile_filter.cpu,
> +              hevc_dec->tile_filter.dma);
>       hevc_dec->tile_filter.cpu = NULL;
>   
> +recheck_tile_sao_cpu:
>       if (hevc_dec->tile_sao.cpu)
>           dma_free_coherent(vpu->dev, hevc_dec->tile_sao.size,
>                     hevc_dec->tile_sao.cpu,
> --
> 2.40.0
>
>
