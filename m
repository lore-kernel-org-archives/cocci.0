Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03538C282D1
	for <cocci@archiver.kernel.org>; Thu,  6 Mar 2025 09:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=ZC/qen37fd4vBSgLI91hwOumJ/Sl+TjsYB6y5Vr5M7A=;
  b=PcsmZsZBkBMdzpk2GW+Zt+tlLLunWOSX55ip8SGaHse5pYziUcVkbHuN
   Nkrf7Pv/Z8xAkzRzlwKNfIUxk8iu3ZONq/df7DCop8y2sVwE4SbP4bOYG
   5eW23FwDqC2+UtLr/ZnGeHE4Cj1eXfWFyRAud1zjMcN4ET8oAdITeMZ/0
   k=;
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
X-IronPort-AV: E=Sophos;i="6.14,225,1736809200"; 
   d="scan'208";a="211491557"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Mar 2025 10:08:52 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C6779E0D20; Thu,  6 Mar 2025 10:08:51 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id E9A8AE0260
	for <cocci@sympa.inria.fr>; Wed,  5 Mar 2025 09:52:03 +0100 (CET)
IronPort-SDR: 67c810b4_7t4DzbKlhi0JHJ2QAVobucECRGv/xflOEdLJHXXIoLZ+EGj
 3IluGgiFo0b3cKbClj/T0NrAyDnOda4qmGnU0OA==
X-IPAS-Result: =?us-ascii?q?A0GWCQDVD8hngTSAVdE9HYEJgVOCRH1aMwRThBo8jV2Bc?=
 =?us-ascii?q?oF0MJ4UgX4PAQMBCwEBOQkCBAEBAwSFAAKLFgIeBwEEMQgOAQIEAQEBAQMCA?=
 =?us-ascii?q?wEBAQEBARABAQUBAQECAQECBAYBAhABASIZBw47hXsNgmIBgSSBJgEBAQEBA?=
 =?us-ascii?q?QEBAQEBAR0CDX4BAQEDDAYRDwENAQE3AQ8JAhgCAiYCAjMBBQERCwY1gWF/A?=
 =?us-ascii?q?YJkAQIHCpJrj0CBBUKLPoEygQGCDAEBBtwggWUDBgkBCoEGLoVsgmMBhVuFB?=
 =?us-ascii?q?ycPgVVEgTyDAz6CYQWFOIJpgjOBaYM+mgaOXFJ7HANZLAFVExcLBwVhSEMDg?=
 =?us-ascii?q?Q8jgSMFNEE6ggtpSToCDQI1gh58gitqBAWBJII3hD2EQoVSghGBYAMDFg8Bg?=
 =?us-ascii?q?x93HIRDO4RyHUACAQttPTcJCxuiMDuDUHOBOYF+kzuDUAGOe6BYNAeEHoFdB?=
 =?us-ascii?q?gyKKZU1BhMvl0YMkwWGIpJcjgWbBAIKBwYRIxKBMwE4gVxNMIMqTwMZD5Ibh?=
 =?us-ascii?q?RPDYEA1PAIHAQoBAQMJAYFVg20mE4oggUsBAQ?=
IronPort-PHdr: A9a23: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
 A==
IronPort-Data: A9a23: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
 bjLq6dhLoxYNrH/eUfkhj7xvZJJNA==
IronPort-HdrOrdr: A9a23:pPGAaaNIUs5+RsBcTjqjsMiBIKoaSvp037Dk7TEWdfVwSL3lqy
 nIpoVl6faUskdtZJhEo7q90ca7MBbhHPJOkO0s1PKZLXfbUQiTXftfBOnZskXd8kTFn4Y3pM
 VdmupFeabN5DBB/KXHCWKDYq8dKbe8gceVrNab4HF3UwlwZq1sqyt/AB2KC1B7SWB9aaYRJd
 6z4o5oqVObF0j/rf7VOpDGZYX+ThHw9a4OqCRnOyIa
X-Talos-CUID: 9a23:1GlvSWDzsJLbUXz6E3Zh600MBNAoSFT28HKPA0mgECV0eKLAHA==
X-Talos-MUID: 9a23:E5y9UAjLSYTWGuSzfTUqj8MpM5lDvfn3CUE3zb4G5IrdLj1JPxmhk2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,222,1736809200"; 
   d="scan'208";a="211260183"
X-MGA-submission: =?us-ascii?q?MDHaK/+Z9wk5TzVnYTUFbtFRkIrzTNrio0RmF1?=
 =?us-ascii?q?NVaOAnFCJUe6lPblZ3IpC11+Tlgt7YtM2hdcgbBisgdrlEvBs4YTkoVF?=
 =?us-ascii?q?/eP5wJ0UuD6tzrBSF3ZC0uYYdXdwlJOY+QH668TdscGcZsX3nK2CRPA6?=
 =?us-ascii?q?yyp9pX8DGCK6IW9NbLg2KZJw=3D=3D?=
Received: from mail-wm1-f52.google.com ([209.85.128.52])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 09:52:03 +0100
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43bcf9612f4so9015575e9.3
        for <cocci@inria.fr>; Wed, 05 Mar 2025 00:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741164723; x=1741769523; darn=inria.fr;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZC/qen37fd4vBSgLI91hwOumJ/Sl+TjsYB6y5Vr5M7A=;
        b=pT6jpHsi2Q3KXOSXc4T9d3Zsrxgb8/UqyMAR4acTS/+b6lTSnDmJKVCT8PpvMtDMjd
         Iok2jXxIMQWNQ3489lfpjdKeVKbviv7X2wBvwY/rb74qhMQVJx581SsqdBEnElFTVob7
         fi3sRSxHAObuHk+XskJM0qxHKnt+oCyoT8FYUlQtBg17wweM4uxRs198FFPfCDdEFPTX
         lxBoGCmIQ9sb3C7WOs80729yaCjICEKoyIXk264YlxbynCy0zbi1W2MegCT3gEkvRZts
         akQewoKYRsVjzp/y14Dv2dcfMX6sf4mqeWAP36Lk00R86Qu8/gJ8U5miRg4BnEnPlM2/
         j1Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741164723; x=1741769523;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZC/qen37fd4vBSgLI91hwOumJ/Sl+TjsYB6y5Vr5M7A=;
        b=SwumYqXlwGhE8A2GaRYnGFdE9HYL84Pfm0NoccdMvrzzGJzTaZ/Gn8IeSEKDiRc1ru
         N2ZqYOvj+3oxzba0+fjO1KLhPkkLwOF3oPNI90qY87iKHo4jzDEj10+AJKRlbmBXyJSz
         CZTIpSGh50K9+lyftqMXogMp8R0sl2rnMmz8OG7VxNhEay4EnVJvY7TGGKZAImMuixie
         mrUJ3aH+L0B6fF6mD3h9ezT+oIhhCQnSQva3SMQ3PyQ6u7OAGHi9FECqb3dFjS7Cn/4K
         wr4gnc8y+0z9Ezxk/Ku7aiRmm1rE4DR+GdK2siPSdfaaTqhCnEQaZ7qLNYZODPhqko9I
         8PoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLeNCx8Q2Z3hVa1kNHzDlIrPxfkEVJfK35A/TAqBoFTi3mEoJYNXRf9LEPuij6sqLAcy/Jcw==@inria.fr
X-Gm-Message-State: AOJu0YzFI2ubXalw7G53Q7jZyhQdH4/88gplCytPna1QiOU357aZEHBA
	onrp5LCqEigdvRXV0cXPDqQiyGtUQwc37OsNp5rJoj2dW/Vy7N3HcOG6/hHp6Jo=
X-Gm-Gg: ASbGncte1z67GpZDamzTsGC85NBea6a4TvAk1kH9c4jrbpsYdVyirWk8FTFr+DrrDt4
	pCQVxFP9CDGL8ONbi+tWnghVw8RoELadlKNp2cDDbu2QZCqj32MigGa2h7aFWioG9DFFQrzbAiF
	HI9057qrkBuDjrZR/6Wh7dgFTh3pBSSpni5yo5O5RGxGZbIzw5ytL8WyRWW/vZJIehtY6qH2lqp
	V3Vv9Q1dpdBp7IP7YHBx+Ak2zx+DgL0VVPPi5FZ6bOEPwd8FXgWSuzRfjyB8/FiJYLvVXwKls1d
	kSR2jEnaJwtsbXOGSGsgeGwjs95Lu+Pbuwv/Iz1zox69wD7wGQ==
X-Google-Smtp-Source: AGHT+IEnll5wrK+ucj99FN5wPB9IJR42RFtfAed9YIQq8iwKwZ5zCrl027CguxNQpWhglI/cbwh/2Q==
X-Received: by 2002:a05:600c:548c:b0:43b:c284:5bc2 with SMTP id 5b1f17b1804b1-43bd28a3847mr16238155e9.0.1741164722999;
        Wed, 05 Mar 2025 00:52:02 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-390e485d8e4sm19946896f8f.85.2025.03.05.00.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 00:52:02 -0800 (PST)
Date: Wed, 5 Mar 2025 11:51:59 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	kernel-janitors@vger.kernel.org, freedreno@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Archit Taneja <architt@codeaurora.org>,
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
	Jeykumar Sankaran <jsanka@codeaurora.org>,
	Jordan Crouse <jordan@cosmicpenguin.net>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
	Simona Vetter <simona@ffwll.ch>, Vinod Koul <vkoul@kernel.org>,
	cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
Message-ID: <4c489b64-4c25-43e3-90d3-37f2f335d665@stanley.mountain>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <13566308-9a80-e4aa-f64e-978c02b1406d@web.de>
 <54c30a69-71cf-4582-9086-50eb0d39f273@web.de>
 <k7un3bjavyt4ogscgc7jn7thfobegaguqqiy7gtypmq6vq7zox@l4bsevbsjrud>
 <29b32b0d-312d-4848-9e26-9e5e76e527a7@stanley.mountain>
 <e665514b-5a62-4afb-b267-7c320e4872af@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e665514b-5a62-4afb-b267-7c320e4872af@web.de>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [RFC] Clarification for =?UTF-8?Q?=E2=80=9Cundefined_?=
 =?UTF-8?Q?behaviour=E2=80=9D=3F?=
Reply-To: Dan Carpenter <dan.carpenter@linaro.org>
X-Loop: cocci@inria.fr
X-Sequence: 2555
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/4c489b64-4c25-43e3-90d3-37f2f335d665%40stanley.mountain>

On Wed, Mar 05, 2025 at 09:40:43AM +0100, Markus Elfring wrote:
> >>> The address of a data structure member was determined before
> >>> a corresponding null pointer check in the implementation of
> >>> the functions “dpu_hw_pp_enable_te” and “dpu_hw_pp_get_vsync_info”.
> >>>
> >>> Thus avoid the risk for undefined behaviour by removing extra
> >>> initialisations for the variable “c” (also because it was already
> >>> reassigned with the same value behind this pointer check).
> > There is no undefined behavior here.
> 
> Is there a need to improve the wording precision?
> 
> There are words which denote a special meaning according to aspects of
> the programming language “C”.
> https://en.cppreference.com/w/c/language/behavior
> 
> Dereferences of null pointers are treated in special ways.

This not a dereference.  It's just pointer math.

regards,
dan carpenter

