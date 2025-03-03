Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5818CC021B8
	for <cocci@archiver.kernel.org>; Tue,  4 Mar 2025 09:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=RaZ/CcmeFoBTR8ddNDuQVJv3AT8EACnAOxQQ2V8mS5A=;
  b=lOzP+Gag8C5+ft03a/TVoSHq3uA+Xnw4GGKaR8JUcK5UUUZmgBybvugI
   9/JUNq5JP0WWvPqOpbohsfMZ8No3K5icywww7pwvxewj2BJJczV/i7Alt
   ewgfB6uSJfyp4WOwYm/fZNSF7dYTRQF/O903YQwQEQQ+mAHHcPu0xZUHK
   s=;
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
   d="scan'208";a="211069424"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Mar 2025 10:58:57 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 12CD6E0D22; Tue,  4 Mar 2025 10:58:43 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 42BA9E0260
	for <cocci@sympa.inria.fr>; Mon,  3 Mar 2025 09:24:32 +0100 (CET)
IronPort-SDR: 67c5673f_gdiDDbypigUHCJEvDdUmHBfedIWzdrvU5FX1/wllMjxAq0J
 PJ5K6kQ5kEJUZAsErXHFEjYtmfXGzlHE7L7t1/Q==
X-IPAS-Result: =?us-ascii?q?A0EgBwARZsVnfC3QVdE9HR4BAQsSDECBSAuCRH1aMwRTh?=
 =?us-ascii?q?Bo8jV2BcoF0MJ4UgX4PAQMBCwEBOwcCBAEBAwSCDIJ0AosVAh4HAQQwCQ4BA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBIhkHDhIphXsNgmIBg?=
 =?us-ascii?q?SSBJgEBAQEBAQEBAQEBAR0CDQd3AQEBAwwGEQQLAQ0BATcBDwkCGAICHwcCA?=
 =?us-ascii?q?jMBBQEcBjWBYX8BgmQBAgcKkjmPQIEFQos+fzOBAYIMAQEG3CCBZQMGCQEKg?=
 =?us-ascii?q?QYuhWyCYwGFUoUQJw+BVUSBFSeCUjE+iB6CaYIzgWmDPoFsilMcLYIliliOU?=
 =?us-ascii?q?1J7HANZLAFVExcLBwVhSEgDgQ8jD4EUBTRBOoILaUk6Ag0CNYIefIIragQFg?=
 =?us-ascii?q?SSCN4Q9hECFUoIRgV0DAxYPAYMfdxyEfIRqHUACAQttPTcJCxuiMDuDT3OBO?=
 =?us-ascii?q?YF+kzthgm8BjnqgWDQHhB6BXQYMiimVNQYTL5dFDJMFmH2OBZsCAgoHBhEjg?=
 =?us-ascii?q?UQ6gVxNMIMqTwMZD44hOIQshCnDWkA1AjoCBwEKAQEDCYVDJhOKIIFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 b4biYdAD6B6F0H/YZcUhu8=
IronPort-HdrOrdr: A9a23:v86ciKNf8Tw9+cBcTjqjsMiBIKoaSvp037Dk7TEWdfVwSL3lqy
 nIpoVl6faUskdtZJhEo7q90ca7MBbhHPJOkO0s1PKZLXfbUQiTXftfBOnZskXd8kTFn4Y3pM
 VdmupFeabN5DBB/KXHCWKDYq8dKbe8gceVrNab4HF3UwlwZq1sqyt/AB2KC1B7SWB9aaYRJd
 6z4o5oqVObF0j/rf7VOpDGZYX+ThHw9a4OqCRnOyIa
X-Talos-CUID: 9a23:bBgcQ2GtHv+7FksmqmJo+nQGCMk+UEGN70iIfla1FXRFeqGaHAo=
X-Talos-MUID: 9a23:RbfuugaGVNmhkeBT7mLCuy9+b+xUuKmyDGosqsgNtM6LDHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,329,1732575600"; 
   d="scan'208";a="110460929"
X-MGA-submission: =?us-ascii?q?MDHrI9HqLIJzCmYURcwWNbpHVo0+AdC2+aik5z?=
 =?us-ascii?q?1J4kqVvq42lKswsu//7RtP3u/e+Z+YuhOBUD3eXbdLD6zSWob/HcRgNT?=
 =?us-ascii?q?xY2us+qUizRaH2gDhkHZKhA+qaIixsAIVEUefWsngV7hx0RH/KdcT7NY?=
 =?us-ascii?q?cAPVc2FgWj0G+5SpavhTxxNw=3D=3D?=
Received: from mail-ed1-f45.google.com ([209.85.208.45])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 09:24:32 +0100
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e4b410e48bso6261313a12.0
        for <cocci@inria.fr>; Mon, 03 Mar 2025 00:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740990270; x=1741595070; darn=inria.fr;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RaZ/CcmeFoBTR8ddNDuQVJv3AT8EACnAOxQQ2V8mS5A=;
        b=Wq6l1UQCglBYFfeIN63i7p/PueCJFDfhTOqavRFn9IiAY3JpluCXybgV2V6U7Vn/60
         fh0XDuN1PEEiVHuuh3ZRl30ThLGa4F+ebl5PyighbB3FMnP7lZiw/t78wqD3X3KbW2hv
         pbNabuCz0lipo+ncqpcwJdMZTyxr+GCqkNx/QVB5iDdjY3jeGMZV9CVZFc0xi/vxnPrQ
         QJ4PZPh3nHH3wxekZb5FisY2zGK9xqdLD8ZTceXWWNxUk4QyQ2lZ8hdxg2Z1qKyVgTPI
         ruGVn5Flv7doPw/RX48iVCUDo4xw+Ul4yBGDxzeLOKBLMXps959jebOqpjYNwKoRZ1uS
         BQEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740990270; x=1741595070;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RaZ/CcmeFoBTR8ddNDuQVJv3AT8EACnAOxQQ2V8mS5A=;
        b=LDwTBkSrlDQMxQy4ZR+YSrz9zlrxf+9fZhTarp9QXiXApGqouKk2dXd/Xc5kfzeuqs
         LjrxI77AO4VouDiqwPmlEMZ3FFtlFL6pc6bGoLvJgO3AQlr3eaOn8ogmbbt8XVEURqZc
         O8c52XddEIAsbS5cPZU7sf0DXgY4erdBn9XyMzKdX6WZSeASapOlNcHCaXQa61GhZQl9
         dPkuJVTAMMc1TvQhUrIRI1aptD5Aq/SYXAWLKhxD/E6H0pQxFg5hclIIHOecHtxXjI9s
         g8kr6oD9zcyzKr31CN+0nG+wBY349QTNzRUzRE6/e8TJPSfJLkYXKGc8V9rIw1e3xu2u
         3SiA==
X-Forwarded-Encrypted: i=1; AJvYcCWlEP/C4urv3v9a5U2QNI4cIl/dSWxVqrmgO0cR+6FJxJ6jaZBwRwa4V+Dx90qT0p6l0zl5wg==@inria.fr
X-Gm-Message-State: AOJu0YxE369CzENTmJ1wGD/h0rP0IAmoDz9QPUikDZVTBexlbxKTOTxF
	aFlDbx/NJyeHpQD6s3JeSL8tvbaMe4sFBhuUGscPCH7HzynA8jm/CW//ic9MpZo=
X-Gm-Gg: ASbGncuB02iViOXVxiG5Z0gaMK+pX5McOUFgUH1J0O+Jgwpr5JdQZRBbh94zgpxIF90
	29Hz81vVrvNRXabMA5lJz5EHVEcv3Dtnxd6Ap/VpEFICX6+1wpQLhqY1lfpl4saj/gogFk4DVMA
	IEUMCpEXPuKoK2kAUcI+NVGXRB0mYTvkq+x5AnVeluY7mgRot4uY3ipE8lkRcjHGyvBxMwtK6yA
	EPEbm6CvwuI/1fYCIQpgbj6LIqiHPlRg9w637lL22mHgpTzOTNQAVpH+0Y9/MwT9qR8JNyUioZV
	z4HgePopuuVAnwbJdvYiKcOf8B8IXP1wpkB1aApuh4o8K93+vg==
X-Google-Smtp-Source: AGHT+IFy4o0lL4wbVfv25BbUZiZprY5pePIQkrVcMtYcd0n6ALHYFSnKECFQ/9k22YMwYBQpC08ZKg==
X-Received: by 2002:a17:907:6d0c:b0:ac1:791c:1526 with SMTP id a640c23a62f3a-ac1791c1cd3mr169820066b.56.1740990270586;
        Mon, 03 Mar 2025 00:24:30 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abf3f3bbfb3sm525674166b.77.2025.03.03.00.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 00:24:30 -0800 (PST)
Date: Mon, 3 Mar 2025 11:24:26 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Archit Taneja <architt@codeaurora.org>,
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
	Jeykumar Sankaran <jsanka@codeaurora.org>,
	Jordan Crouse <jordan@cosmicpenguin.net>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
	Simona Vetter <simona@ffwll.ch>, Vinod Koul <vkoul@kernel.org>,
	cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
Message-ID: <ce9599fb-a798-4f22-b51a-3341e690f8bc@stanley.mountain>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <13566308-9a80-e4aa-f64e-978c02b1406d@web.de>
 <54c30a69-71cf-4582-9086-50eb0d39f273@web.de>
 <k7un3bjavyt4ogscgc7jn7thfobegaguqqiy7gtypmq6vq7zox@l4bsevbsjrud>
 <29b32b0d-312d-4848-9e26-9e5e76e527a7@stanley.mountain>
 <12050afd-ab60-4bac-bd25-0c3cc925b38b@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <12050afd-ab60-4bac-bd25-0c3cc925b38b@web.de>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [RESEND] drm/msm/dpu: Delete a variable initialisation
 before a null pointer check in two functions
Reply-To: Dan Carpenter <dan.carpenter@linaro.org>
X-Loop: cocci@inria.fr
X-Sequence: 2505
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/ce9599fb-a798-4f22-b51a-3341e690f8bc%40stanley.mountain>

On Mon, Mar 03, 2025 at 09:15:14AM +0100, Markus Elfring wrote:
> >>> The address of a data structure member was determined before
> >>> a corresponding null pointer check in the implementation of
> >>> the functions “dpu_hw_pp_enable_te” and “dpu_hw_pp_get_vsync_info”.
> >>>
> >>> Thus avoid the risk for undefined behaviour by removing extra
> >>> initialisations for the variable “c” (also because it was already
> >>> reassigned with the same value behind this pointer check).
> >
> > There is no undefined behavior here.
> Will any software development concerns evolve further also according to
> undesirable null pointer dereferences?
> https://wiki.sei.cmu.edu/confluence/display/c/EXP34-C.+Do+not+dereference+null+pointers
> 

It's not a NULL pointer dereference.  It's just pointer math.  It was
a common way to implement offsetof() before we had a builtin for that.

samples/bpf/test_lru_dist.c
# define offsetof(TYPE, MEMBER) ((size_t)&((TYPE *)0)->MEMBER)

regards,
dan carpenter
