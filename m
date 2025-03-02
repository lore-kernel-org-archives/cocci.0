Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760FCC282DC
	for <cocci@archiver.kernel.org>; Tue,  4 Mar 2025 09:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=+6tLHwT02MdyiarYGqAftjy+FZoaHm2RQy2amBFDQNM=;
  b=rf1OJm/SIbaSkGV6aAQzXpRJ+fizBVm/BM3HCCa2/W/2ez4GiKm3d7xD
   +40JmDRE9kCW3V+OEdwKafY9SpSq+uC6Ry/IbpuPXaHzbHqiz9fXsdD0y
   FURZAsLNnAmlaiFA+aBEav5U/t/wh6dV3AUuWeQKqX6FLG1wP0jQtosjF
   4=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@linaro.org
X-IronPort-AV: E=Sophos;i="6.13,331,1732575600"; 
   d="scan'208";a="211069286"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Mar 2025 10:58:56 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E44B5E0E08; Tue,  4 Mar 2025 10:58:42 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 49F3EE0260
	for <cocci@sympa.inria.fr>; Mon,  3 Mar 2025 00:01:44 +0100 (CET)
IronPort-SDR: 67c4e357_205vCwCUkc9n/mmjZAVnctErwExpfohtQFSeFb6X//qJxDI
 yVahRZk1UB7yOFyWkywtnzFgwv7CPsV48VCaQGw==
X-IPAS-Result: =?us-ascii?q?A0ETAAAQ48RnfC+nVdFaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYFxUoFXMwRThBo8iB1fhlOCIQOSaIssFIFqDwEDAQsBAUICBAEBA?=
 =?us-ascii?q?wSCDIJ0AosVAh4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEB?=
 =?us-ascii?q?gECEAEBIhkHDhIphXsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CDX0BAQEBAgEMB?=
 =?us-ascii?q?hEECwENAQE3AQ8JAhQBAwICHwcCAjMBBQEcBhMIGoUiIwMBkl+PQIEFQopEe?=
 =?us-ascii?q?n8zgQGCDAEBBtwggWUJCQEKgQYuAYVrgmMBhVKFECcPgVVEglCBbz6EDgESA?=
 =?us-ascii?q?YN8gmmCM4FpAYM9lkuGY4sqUnscA1ksAUsKNQw5KEhIA4EyD4EUBTR7gguBM?=
 =?us-ascii?q?joCDQKCQHAfMYQRgjeEPYMwgRCBY4NvghGBXQMDFg8Bgx93HIR8hGodQAN4P?=
 =?us-ascii?q?TcUG6IxOoNPcgFSO0yBXjQLDZJvg1ABr1I0B4QegV0GDJ9wSQODbY0IhjqBP?=
 =?us-ascii?q?pFTmH2pBwIKBwYRI4FEOmxwTTCDKk8DGQ+OITiIVcNaQTU8AgcBCgEBAwmFS?=
 =?us-ascii?q?IpUgUsBAQ?=
IronPort-PHdr: A9a23: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
 AlqaGiCSLVWgL9tM2tsjV2E0aY=
IronPort-Data: A9a23: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
 bjLq6dhLoxYNrH/eUfkhj7xvZJJNA==
IronPort-HdrOrdr: A9a23:bMKMj6jba7jPL/7tDLbu9FDDm3BQXiEji2hC6mlwRA09TyVXrb
 HJoB0+726JtN93YgBepTngAtj8fZq4z/RICOYqTNKftWXdyQ+VxcRZnPXfKl7balfDH4xmpN
 9dmsFFYbWafDpHZITBkXKF+r4bsbq6GcuT9J7jJhlWPGZXQpAlwAFjFA6BH0F6ACVAD4EoDY
 eR66N8ywaISDA4aoCUCBA+MdQrZOelqHslW3M77tIciTVmRAnJ1ILH
X-Talos-CUID: =?us-ascii?q?9a23=3AF+8rfGoXEUolhGsm6kSdXZ3mUZ15UFLlw3rbGGm?=
 =?us-ascii?q?DD3RDD52VaVWx/rwxxg=3D=3D?=
X-Talos-MUID: 9a23:1iJGBwW4hLt3x+jq/BvWoBBnNcBy2LSBIXAHmK42q8+hbTMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,328,1732575600"; 
   d="scan'208";a="210761067"
X-MGA-submission: =?us-ascii?q?MDHIIjS7wCNc0Fzu5ZOm06J7Q4YZwfZP4vecae?=
 =?us-ascii?q?S+4RUyoU8fHoq82Wlwr38Ae+LzhXQhpUpAfKK9FGu+wGqUXu7GR6vsnH?=
 =?us-ascii?q?svczlIx+r1W0oKXeck8FnPU/ffdmi7K9UI0g5oBwuTd1saYnPbl/5oXa?=
 =?us-ascii?q?MzFe7w6AQdVvkll9dyhJpwxQ=3D=3D?=
Received: from mail-lf1-f47.google.com ([209.85.167.47])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 00:01:44 +0100
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-54943bb8006so4219316e87.0
        for <cocci@inria.fr>; Sun, 02 Mar 2025 15:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740956503; x=1741561303; darn=inria.fr;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+6tLHwT02MdyiarYGqAftjy+FZoaHm2RQy2amBFDQNM=;
        b=WeYtgypDM11JBfemDtfdPv9eYns+A5rC8G/I9ElEgn9Bh9816CpUXGmy5Y3NNkHKj1
         sxD8EBinlyab5/nWkMwGLPIvQhCzl8r1amreqEyaa6SA9Y+IdAtkkLsOnRZgSeAoWdm0
         taWYflBTMbtCnaWpB+lT2S6y+rsB+PpfoYL3UjvgyJhIbCCGvvXM2ttiBNpZZEc2H51d
         xncjTHkCPzQD52r3pOHhATlKd2xc/ZtReIg9CXkltC1Bhw8rBpJZ0lQjfgNoK/Vx7keH
         mSK7fQaJqncKoTSE2bX2w4hAjPC+9CJ/vd1C60sm8Co64Ayav8NCT2cVYV1q1oom/+b5
         5g7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740956503; x=1741561303;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+6tLHwT02MdyiarYGqAftjy+FZoaHm2RQy2amBFDQNM=;
        b=KjbfdoAxkR9FUfY33dDjqBVF9TQ1DJiEIpzE98W+jnZCsiR/esGFxXIgNJ3ME24EK9
         Dh3Av8fvTsAuo/PTicuvVTT4g0XG6ey2FplXrrjuvFO8NGoSsp5lUfyDjYl8BYKLO0SX
         q7E6lVbE5qlK6CYmUqasPmnoAqLAtXpyxtYh+HQg1h1xDe2Z/H+cBhtpbiJJcs5JKozD
         ZDZzE2gsMk/NEsASj8by5R6pDOtWKSNcRkvLS1etd6LX9Eoyf4EMLACpSY8JWD/TVjtW
         1mVPw5xt+x+4fecgZFDpdukrIe49AEf/7k/T3Bu9yxvw9B+XVA9S00PwSVhCIhKUwWyQ
         +Qsg==
X-Forwarded-Encrypted: i=1; AJvYcCVPfdrX//dLLzGLARZyE0R7m7bb3D5WZlHDlg1InjJg/KRf4Fj52PxmQlzuHeiDlzdD1q/YaQ==@inria.fr
X-Gm-Message-State: AOJu0YyUI9hk8+deic9+6KLzSCHieVvxv5Euew6CyNM1T7CpeRnRPfYe
	Z8uPitgEBPK5y/RfAxde1K51yTBA4ZjZqVKjNw2nbz3YIK6jvAoj8XHSVKjgAoM=
X-Gm-Gg: ASbGncuG5DNZppaVH8AQkHsD/vqHW2J2ZcVkZCgG1hDh6AYAIkMXvSbLLz0lHVuwtT4
	5ZA7V3r9T88h5qAvpwSbgZdxVp0Nmd+woPROKDv776vCSApg+cgm8GV2g/xWr+G91A4HHffijTk
	vPFN1LL0MGDEBNLeUaE6f8latbpgbUKfMUdfQ0QnZn9ttPK0iAXxzITE4gpduXsoHUxSdCXgxZo
	M780FyMsQ3czv8YhDHJGa/XTF747ZYOMlJw01MliptHSsmyCW5f1u54l0iSe7kMhpddgC7gU5Jk
	hNtnZV/yBTmsTmk62wF3PCfpSrOThJiTOVABliq3GeDah77rlntArMhyW1tXTKSvJRrUFNB5daR
	lM2OHFm9zFwc3U+8FyqIUhrz5
X-Google-Smtp-Source: AGHT+IE6iJ6MJULbhVODlhEs0Uz3Bo0Jahq2KVUfeiM0dMjeCLZC5DbHiJxY2q28Q7dzFsOZ3W5T5w==
X-Received: by 2002:a05:6512:3b11:b0:545:2f48:d524 with SMTP id 2adb3069b0e04-5494c320d25mr3513353e87.29.1740956502909;
        Sun, 02 Mar 2025 15:01:42 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54956a2c610sm747244e87.4.2025.03.02.15.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 15:01:41 -0800 (PST)
Date: Mon, 3 Mar 2025 01:01:40 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: kernel-janitors@vger.kernel.org, freedreno@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Archit Taneja <architt@codeaurora.org>, 
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Jeykumar Sankaran <jsanka@codeaurora.org>, Jordan Crouse <jordan@cosmicpenguin.net>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Simona Vetter <simona@ffwll.ch>, Vinod Koul <vkoul@kernel.org>, cocci@inria.fr, 
	LKML <linux-kernel@vger.kernel.org>
Message-ID: <k7un3bjavyt4ogscgc7jn7thfobegaguqqiy7gtypmq6vq7zox@l4bsevbsjrud>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <13566308-9a80-e4aa-f64e-978c02b1406d@web.de>
 <54c30a69-71cf-4582-9086-50eb0d39f273@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <54c30a69-71cf-4582-9086-50eb0d39f273@web.de>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH RESEND] drm/msm/dpu: Delete a variable
 initialisation before a null pointer check in two functions
Reply-To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Loop: cocci@inria.fr
X-Sequence: 2501
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/k7un3bjavyt4ogscgc7jn7thfobegaguqqiy7gtypmq6vq7zox%40l4bsevbsjrud>

On Sun, Mar 02, 2025 at 09:56:00PM +0100, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 11 Apr 2023 18:24:24 +0200
> 
> The address of a data structure member was determined before
> a corresponding null pointer check in the implementation of
> the functions “dpu_hw_pp_enable_te” and “dpu_hw_pp_get_vsync_info”.
> 
> Thus avoid the risk for undefined behaviour by removing extra
> initialisations for the variable “c” (also because it was already
> reassigned with the same value behind this pointer check).
> 
> This issue was detected by using the Coccinelle software.

Please don't send resends and/or new iterations in response to your
previous patchsets. Otherwise they have a pretty high chance to be
ignored by the maintainers. Use a fresh git-send-email command to send
new patchset.

> 
> Fixes: 25fdd5933e4c ("drm/msm: Add SDM845 DPU support")
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c
> index 0fcad9760b6f..870ab3ebbc94 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c
> @@ -176,7 +176,7 @@ static int dpu_hw_pp_enable_te(struct dpu_hw_pingpong *pp, bool enable)
>  static int dpu_hw_pp_connect_external_te(struct dpu_hw_pingpong *pp,
>  		bool enable_external_te)
>  {
> -	struct dpu_hw_blk_reg_map *c = &pp->hw;
> +	struct dpu_hw_blk_reg_map *c;
>  	u32 cfg;
>  	int orig;
> 
> @@ -221,7 +221,7 @@ static int dpu_hw_pp_get_vsync_info(struct dpu_hw_pingpong *pp,
> 
>  static u32 dpu_hw_pp_get_line_count(struct dpu_hw_pingpong *pp)
>  {
> -	struct dpu_hw_blk_reg_map *c = &pp->hw;
> +	struct dpu_hw_blk_reg_map *c;
>  	u32 height, init;
>  	u32 line = 0xFFFF;
> 
> --
> 2.40.0
> 

-- 
With best wishes
Dmitry
