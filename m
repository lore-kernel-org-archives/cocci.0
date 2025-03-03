Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A79F7C282E3
	for <cocci@archiver.kernel.org>; Tue,  4 Mar 2025 09:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=8RROaO6yARYWUmuYiLttBRg0vezrYJsF0zsoMASJ+Y0=;
  b=LOvxAmgwzHmcc9+m7GU4dzwAY6SKhyAZjeITdEd/UWU4XnJtnqvZiKgo
   KH7GPGyI6WmBwgZEk6+c5MVDikahv5y540gvoP8bmZ3VvRAhYNpipP6a4
   uEKv4Fiw0EzzfqzEnHWfP8AU6KrCSlbwuqC8UqXYbtwh2yhNO7QMuOiEP
   Q=;
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
   d="scan'208";a="211069342"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Mar 2025 10:58:56 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 643EFE0E48; Tue,  4 Mar 2025 10:58:43 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 4B088E0260
	for <cocci@sympa.inria.fr>; Mon,  3 Mar 2025 08:14:12 +0100 (CET)
IronPort-SDR: 67c556c3_h4TowoZph1DC0e8nrfc8Psapuc06qxJAA8Hqbr3v1clbbes
 J0fBNA4aHLaBNUxhviSvKbAWgKHlvSykm1jZ4PQ==
X-IPAS-Result: =?us-ascii?q?A0G1CADUVcVnfCzQVdE9HR4BAQsSDECBSAuCRIFXMwQkL?=
 =?us-ascii?q?4QaPI1dgXKBdC0DnhQUgWoPAQMBCwEBQgIEAQEDBIIMgnQCixUCHgcBBDEID?=
 =?us-ascii?q?gECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQEiGQcOEimFew2CY?=
 =?us-ascii?q?gGBJIEmAQEBAQEBAQEBAQEBHQINfQEBAQECAQwGEQ8BDQEBNwEPCQIUAQMCA?=
 =?us-ascii?q?h8HAgIzAQUBHAYTIoFhf4JCIwECB5I4j0CBBUKKRHqBMoEBggwBAQbcIIFlC?=
 =?us-ascii?q?QkBCoEGLoVsgmMBhVKFECcPgVVEgTwLgng+gVKCPAESAYN8gmmCM4FpAYM9l?=
 =?us-ascii?q?kuDOoMpiypSexwDWSwBVRMXCwcFYUhIA4EPIw+BFAU0QTqCC2lJOgINAjWCH?=
 =?us-ascii?q?nyCK2oEBYEkgjeEPYRAhVKCEYFdAwMWDwGDH3cchHyEah1AAgELbT03CQsbo?=
 =?us-ascii?q?jE6g09zUoEHgV0BNAsNkm+DUAGOeqBYNAeEHoFdBgyfXgYTL4QDjQiGOgyTB?=
 =?us-ascii?q?Zh9qQcCCgcGESOBRgI2bHBNMIMqTwMZD44hOIhVw0pANTwCBwEKAQEDCYVDJ?=
 =?us-ascii?q?hOKIIFLAQE?=
IronPort-PHdr: A9a23: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
 REyh011ZuF/rF/R
IronPort-Data: A9a23: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
 J85q6ZhI4xb55DLhZYUhg==
IronPort-HdrOrdr: A9a23:LyTPEKsn1NrQeBE8GlXnCoVy7skDjdV00zEX/kB9WHVpmwKj5q
 aTddAgpGPJYVEqKQ4dcLG7SdS9qBbnn6KdjrNhWItKMDOW3FdAabsSk7cKoAeQYREWlNQtrZ
 uIGpIWYLaAb2SSz/yKmzVQe+xQo+Vvm5rY/Ns2oU0dKj1CWuVO6RxmAh2XHkAzaA5NHoohCZ
 aQj/AqmxOQPVoSKuq0b0NqYwEBnbL2fVDdDCLuyyRH1OBGt1OV1II=
X-Talos-CUID: 9a23:5Y9i3WAOljXH2gD6Ey5l/3ZKWeYqSXnE53uMfWu6Nj5CSrLAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3AHNB8ug2nB9n+htNjiNdRMEO8BzUj7IDxV1081pU?=
 =?us-ascii?q?9guqWFCxNZxmB1Wrva9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,329,1732575600"; 
   d="scan'208";a="110453968"
X-MGA-submission: =?us-ascii?q?MDEef8+bF301aqzgiTm9+NN46ArsREE/DUR86u?=
 =?us-ascii?q?0pn7VC2wvp09SWRGV+yGB4cra2HV0hHN8bi1qlhhzjsx77w/TxkGfW8B?=
 =?us-ascii?q?7TlA9Ol2GzEj+nrCJoK9Kt5xwG5ia/PGFxnPVxk1e4VlbUdYwS69hQuM?=
 =?us-ascii?q?0TsIL8+EQpLm70wylceWH5pA=3D=3D?=
Received: from mail-ed1-f44.google.com ([209.85.208.44])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 08:14:12 +0100
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e5491eb37dso1177677a12.0
        for <cocci@inria.fr>; Sun, 02 Mar 2025 23:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740986050; x=1741590850; darn=inria.fr;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8RROaO6yARYWUmuYiLttBRg0vezrYJsF0zsoMASJ+Y0=;
        b=KKqht7wASnXYCBDSSq+/IdYS5PezbS0dGkIXdz6zYEipUDTHeDfjLxdPe4cU2ehgvF
         TSn48Z+LEX2sbbFFdn9PktUIKuZqVcJ1uBugH9hhTrKvYMZs3AkEJt3PV4/WbI3n99+3
         sGUoNDkAC5hGun9BbWcfn1SIdzOQUov8RrLIRtL8kTVMeBTLy4HR8z+rXrt29Pu86ndo
         T6sqsvpxjDJMe1saFs1Ou306Pw2zCFAiS79QbHEIfogkcNNSlnsabQdelc14jI5mwRAz
         +aHgBoCXqX+D3ie9oT75qPsBamN5Mf9E1pjuf6vXr/Ov6Aeoc6fSx1BIJzOS8QG9fNXW
         d8Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740986050; x=1741590850;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8RROaO6yARYWUmuYiLttBRg0vezrYJsF0zsoMASJ+Y0=;
        b=GEpBs13M2zVOGTEZq926Z+dwg5RdiHhEqDSIbsCgX700YtFJoOK+ETFKIqvzyuLMPr
         AK7nKFmQ80jPxdYhSe3Nf/eeHUnSV3Gd2+Xy2/oBw8YPAdhhvVqs4bkjcwi3HNs+1N38
         gUCoTl6w54lTfnPxsrnd/QKpiO/Y3y8A4FESFtkdmVrCZ3PLaivR/Z6gN4MIiy+b1YLy
         SB7j1DF9O1esFrZYwObibNWJVDTiex4fAaWp1lDcuvTOBpu52limDo1zUARZubPUYu51
         MWxetoKZpLyVN40MNfuigjhnBNH0ekAxqTAkEW2Ys4I5IB8wJCmqhvJjOz5QcPY0JZoc
         Ftxg==
X-Forwarded-Encrypted: i=1; AJvYcCUulSLz/ghuxRh9l6Xju7bRYS8TtMXbjH1051oWiLrHmiVo4ApWs+CzuM1PXv7Ya2FsVXxaHw==@inria.fr
X-Gm-Message-State: AOJu0YyY182nW7NG42FcYUlSGMNKBDaop5uVZxcWNgbYqzNf6bChY86G
	FgEFiZvc5cIFEfAEgj6y6xFzff+LciULgDfcqzKlvbPl/cKgRUriRPDcJIBSlls=
X-Gm-Gg: ASbGncu1vmIQgcI7cbyKkYpUAN3/L7Nlfsee6noakQd8/YVitB/LGtSb1wk+3TTMkgy
	dyp2BJm/tlkTIkH6HxNgICBWCPaatOtcNkf5IHrGpgfMaej5Fd39Jrznxfg9iZVYTf//c0er278
	DRwDmNVZ+7hNL5Hd6+ssiC+DdYt7eTgbcLiNK6wBmyx/Hi/ZkgFht4zaWYgz30eDxD0yA+wgQwJ
	qqhOURhDEBq6HSDTyea5CpvQ3y8VT1AfWzDwGJe3iHdrwmLZ27y0Kd0/7/5AfPckKnM2I426WDi
	enV4s/W2HssXvC1jmXtkQbrUIJoN0TYzM08B1imosgx2SDvGEg==
X-Google-Smtp-Source: AGHT+IEny668UimPZ3R6dx4axvviTs297S1IJ5VK/kkx2SxfpDGI4c5Rl/7By42IdqNYV74cMm4sFA==
X-Received: by 2002:a17:907:980e:b0:ab7:b250:aaa with SMTP id a640c23a62f3a-abf2682f996mr1554838466b.54.1740986050266;
        Sun, 02 Mar 2025 23:14:10 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ac1dd6fd870sm60633966b.70.2025.03.02.23.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 23:14:09 -0800 (PST)
Date: Mon, 3 Mar 2025 10:14:06 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Markus Elfring <Markus.Elfring@web.de>, kernel-janitors@vger.kernel.org,
	freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Archit Taneja <architt@codeaurora.org>,
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
	Jeykumar Sankaran <jsanka@codeaurora.org>,
	Jordan Crouse <jordan@cosmicpenguin.net>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
	Simona Vetter <simona@ffwll.ch>, Vinod Koul <vkoul@kernel.org>,
	cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
Message-ID: <29b32b0d-312d-4848-9e26-9e5e76e527a7@stanley.mountain>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <13566308-9a80-e4aa-f64e-978c02b1406d@web.de>
 <54c30a69-71cf-4582-9086-50eb0d39f273@web.de>
 <k7un3bjavyt4ogscgc7jn7thfobegaguqqiy7gtypmq6vq7zox@l4bsevbsjrud>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <k7un3bjavyt4ogscgc7jn7thfobegaguqqiy7gtypmq6vq7zox@l4bsevbsjrud>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH RESEND] drm/msm/dpu: Delete a variable
 initialisation before a null pointer check in two functions
Reply-To: Dan Carpenter <dan.carpenter@linaro.org>
X-Loop: cocci@inria.fr
X-Sequence: 2503
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/29b32b0d-312d-4848-9e26-9e5e76e527a7%40stanley.mountain>

On Mon, Mar 03, 2025 at 01:01:40AM +0200, Dmitry Baryshkov wrote:
> On Sun, Mar 02, 2025 at 09:56:00PM +0100, Markus Elfring wrote:
> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Tue, 11 Apr 2023 18:24:24 +0200
> > 
> > The address of a data structure member was determined before
> > a corresponding null pointer check in the implementation of
> > the functions “dpu_hw_pp_enable_te” and “dpu_hw_pp_get_vsync_info”.
> > 
> > Thus avoid the risk for undefined behaviour by removing extra
> > initialisations for the variable “c” (also because it was already
> > reassigned with the same value behind this pointer check).

There is no undefined behavior here.

> > 
> > This issue was detected by using the Coccinelle software.
> 
> Please don't send resends and/or new iterations in response to your
> previous patchsets. Otherwise they have a pretty high chance to be
> ignored by the maintainers. Use a fresh git-send-email command to send
> new patchset.
> 
> > 
> > Fixes: 25fdd5933e4c ("drm/msm: Add SDM845 DPU support")

Remove the Fixes tag.  This patch is fine as a clean up.

> > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

regards,
dan carpenter

