Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E8F0C19F32
	for <cocci@archiver.kernel.org>; Wed,  5 Mar 2025 08:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=fCDaLEF1BjQDk6gvMN7vVYiHfOJ4vTdNlSKUXs5nPuw=;
  b=Sag/wvSqIbW9RW07lrPVfRKE1RmE82TtaEaWvYCRjkXml9e1GQh9OLRt
   cCBazMP2+cQ6PVP0JZPIIlLb3zm6tHMR52yU2YjqQYBxXVfgzymadQHW3
   VoXuzWvsurOl7yP4Xxv1eYeD4YbKzmvNSSJVBW+N3SvD/AP8qXH6aI2E3
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.14,222,1736809200"; 
   d="scan'208";a="211257842"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Mar 2025 09:42:07 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 21CEEE0264; Wed,  5 Mar 2025 09:42:07 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id BB411E0260
	for <cocci@sympa.inria.fr>; Wed,  5 Mar 2025 09:42:05 +0100 (CET)
IronPort-SDR: 67c80e5d_TW+SLFUS2eRHFSdXHYHEBxahyb+vYSunKxuluqI0nqDK3TS
 JDD2Hbd9/MBwq5rrf3qnW24fWfiklt4YKfxwMsg==
X-IPAS-Result: =?us-ascii?q?A0GzNQBwDchngQsR49RaHgEBCxIMQIQXfVozBAtIhBo8j?=
 =?us-ascii?q?0+BdDCEO48OiHWDVA8BAwENOQgBAgQBAQMEggyCdAKLFgIeBwEENBMBAgQBA?=
 =?us-ascii?q?QEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBOwcOCQExhXsNgmIBgSSBJ?=
 =?us-ascii?q?gEBAQEBAQEBAQEBAR0CDTpEAQEBAgEMFx0BAREmAQ8JAhoCJgICSwsGARQBA?=
 =?us-ascii?q?YJ+AYIvAQMOIwcNkmqcRYEygQGCDAEBBtpcHywiV4FlAwaBGi6FbIJjAYVbS?=
 =?us-ascii?q?4NCeicPgVVEgTyDAz6CYQWBXYNbgmmCM4RAZ5oGjlxSexwDWSwBVRMXCwcFg?=
 =?us-ascii?q?SkQMwMgCjQUHQIUDRAPBhAEagU0QTqCC2lJOgINAjWCHiRYgitqBAWBJII3h?=
 =?us-ascii?q?D2EQoI/UYJCghFxbwMDFg8Bgx93HINMdzuEch1AAgELbT03BgMLGwY9oW07g?=
 =?us-ascii?q?1BzgTmBfpM7g1ABr1M0B4I4gWaBYwyKKZU1BhMvl0YOBpJ9hiKSXCKNY5suN?=
 =?us-ascii?q?YFJI4FcMxokgzZPAxkPjiGDejPIPkI1PAIHAQoBAQMJAYFVg3ABAYpUgUsBA?=
 =?us-ascii?q?Q?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 IT1qa15rJmHdHPM
IronPort-HdrOrdr: A9a23:juZzAqppyt3rp2hNH7rv/UkaV5o+eYIsimQD101hICG9E/b4qy
 nApoV56faZsl0ssRIb9+xoWpPtfZq0z/cc3WB2B92ftWLd11dAQrsO0aLShxfnHDD3/PMY9a
 oISchDNOE=
X-Talos-CUID: 9a23:dWyUQm9VwNwAIUEeyu2Vv0s3BukvWT7c9nLJBWrhGFpQFJexQEDFrQ==
X-Talos-MUID: 9a23:iFwQGwocAHyTbNsM48kezwh4Gv9u/a2cMREcjss4g8mDOyEoCR7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,222,1736809200"; 
   d="scan'208";a="211257813"
X-MGA-submission: =?us-ascii?q?MDFTHQpYjntzXqlWC6+93Y6N/aArSS6s2bxtCK?=
 =?us-ascii?q?iVkrA3f6yn4S/JMGzFZs3vsteoxjRibm1oIbZGK9ASPFYQHy7HyTRfo8?=
 =?us-ascii?q?nWgzNLtwlNOKY97ZFmFi0mr6PKbywAk8VO2AFeuXAd+7AoUxR4Hflk3e?=
 =?us-ascii?q?m+Z8A7hw5VmrnDZP3Tjf9ySQ=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 09:42:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741164058; x=1741768858; i=markus.elfring@web.de;
	bh=fCDaLEF1BjQDk6gvMN7vVYiHfOJ4vTdNlSKUXs5nPuw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=FyL38WzipPEoGUYCtfkJPKsUeSQADSAFq4nNhTF7P+2Uv+w7VuuXPjKrszxmz47s
	 7WExlwuD+KFc4CXaP594d5s5VJne7kXDhHMeuLX2EHe9VGUZw2G2ksajtN06jStjv
	 EtwtxlByz8URebq+vUyWh/+KwwxKi/q2KLizqeaTaUyIpBPYlbZQ+YehxQqursD8M
	 l9d1L16lFo3KZYNQa/R/EhLGrysPeHvI5xPjdKBVoFIYzXfTR6FqlonKjZ6OzkRFu
	 jYHuCHO4Igg3qKQ1DqGrOjPAxtgA/53VYO6dfsEOPRTWO+kLPDonnRUzZbZFaBK1u
	 uIF8ZWy88JP03+C2tg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.10]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MqZQY-1tTw9i2MMK-00fxB5; Wed, 05
 Mar 2025 09:40:58 +0100
Message-ID: <e665514b-5a62-4afb-b267-7c320e4872af@web.de>
Date: Wed, 5 Mar 2025 09:40:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 kernel-janitors@vger.kernel.org, freedreno@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org
Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Archit Taneja <architt@codeaurora.org>, Daniel Vetter <daniel@ffwll.ch>,
 David Airlie <airlied@gmail.com>, Jeykumar Sankaran <jsanka@codeaurora.org>,
 Jordan Crouse <jordan@cosmicpenguin.net>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
 Simona Vetter <simona@ffwll.ch>, Vinod Koul <vkoul@kernel.org>,
 cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <13566308-9a80-e4aa-f64e-978c02b1406d@web.de>
 <54c30a69-71cf-4582-9086-50eb0d39f273@web.de>
 <k7un3bjavyt4ogscgc7jn7thfobegaguqqiy7gtypmq6vq7zox@l4bsevbsjrud>
 <29b32b0d-312d-4848-9e26-9e5e76e527a7@stanley.mountain>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <29b32b0d-312d-4848-9e26-9e5e76e527a7@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Is8r5OqTz1HEt5DAHK+q9bpWIsAC/ftPgUCj2FJLpX8MmfLUBid
 fT2UpE/JSWmezrvupm7xHOXC7YUQsVaEZC0V5+3kNBaub/aDJDNC2yqQbgrscneRvnBq5VX
 VMQxX2+7fAtLBuT/Uboe9GP66LH+LXdN/9wgjWAmtPLeF4ULKk2+AEV7mhfygbzhNi9V9wB
 tkXDOy8yRt6oKzQuoNYUA==
UI-OutboundReport: notjunk:1;M01:P0:MuuCeMBVWnM=;BzFg+FxRcOm4BpAgy0enxRtgIHL
 4qupdcjxA6scJ3cX8W3kBIpdy/H4k+t7A4eNhegIC5Q6XRp9nWJQBpjEoqrBVWV3aH4tD043x
 N0gU9isZlYOwtTS2+LyVl4XTSrwTsx9DGUqM8FclDGpDUzwCX2k0jzWg5RyxTvsZnqJKQCe4u
 JVZTuYJciWMQninqJsMPiUKYGOP00FXKKXKNld2DOhORcvClqkBI2QfRW4VVhKwkZZwITIohN
 oczZRh0+LBz6HVJb6wvF/gdUDVSC6wA0UQSRVGmRuhEHP3tdilb/NDq38+A7X6ie/ca198CGY
 oAomEVGBLJox4XYcY4QknL7NBQ3MnFVBu1ZZBLq2A4jzTeym3S87sf+KERld9cMLN71ZaZDRt
 QqmBh1UbLqQmvai/mDJzSO26qqsemIOf6rxIlEuAJMzIoFjB8NR71+5N0PWrzjpQNE4hSb2uU
 Ez8c79sMcApnHnfe+9EBwBwq6fPsSd0fnYIUY189mQgmb4nRhFg/c604l9Wg03W1tABL2eimo
 rHlDCgJtEa2YT7asXccZOr5+Vh+lS719rBY9ATeYjD20CymYIqFDviVhNOmIPcVZrDAk9ycB0
 fd9+3wj+9egR5Rm8TWep22kj2sqrk8t80TtPvP3SyoHITgIrrQFQDSPgTiiej2xcC6Uvn4ekS
 G5bib8BotNmdMcUBYyx0+iyiMTq/dYaOtHM5VycArSykz4QiKJLSe2QgSlaZA9ewnudX6ojvN
 ovWqLR3GQ5/ITBaschxQkJO5zAdWz7Ksv/9OORtm9iN83sgtdPEYyYrJpapIRS75p3/YONcb4
 YM781c0t19a/FMrXy27nVhTRSItb3lp39Eq8S1Cr1Mc5YWYVK9lVKriOavWh0vfSGv+b5wrtp
 4FxP4/kHn3bejmofRFRHDhydYsF++px1Z15ojeihiJbo5tsFqawhNk06ujULAPg7BewFds+bi
 TKEj4DZrPxdrkO3inYqmFm34uIw4RYfsvC3zUUW+jUsMQxSRSiBzuVp3wVM7Y6YbuPVghbTUw
 JpzrWYGYycUc2jKFuj4pcACdAeklii9U/6zuww4yAxDqYncKhWcLsNwA9omLPovtZVmKRhCsB
 PGkL9tts+aYt9K1JYYWIltzHeoLjzIt2cfs2F4KvQEKy4XhAW7oIASNELcIwklQP6MU+5IixI
 baJTU5mzorsYPb8a1ruASEdY3uOry7NjOUjLoBlgzkH2o8Tc+YG3U2cfn/UMSMdyrQXs+cucJ
 zUzG5qFlhXJbak8Fh/rJrfct5PDE62PaRceFlW/z8jAYf+nAZye5+yMTAq8kyg26/im3np92p
 oeQ9Xn6WleJZtWsVOphZEbFXw03x9jODGJXYF7633qYzfD+pOLMxUZrzYKMozCrd6V9zc/DgV
 IJ7dM6wYNVQXmq7yYsUr8HNhRjW3XZAvSIhs54WzvxvXbY4LTNW9at5SvzPYTfJcM1K2DRVXz
 SgLwmhV+mstgAnG2q0CJRo1aqMEI=
Subject: Re: [cocci] [RFC] Clarification for =?UTF-8?Q?=E2=80=9Cundefined_?=
 =?UTF-8?Q?behaviour=E2=80=9D=3F?=
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2539
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/e665514b-5a62-4afb-b267-7c320e4872af%40web.de>

>>> The address of a data structure member was determined before
>>> a corresponding null pointer check in the implementation of
>>> the functions =E2=80=9Cdpu_hw_pp_enable_te=E2=80=9D and =E2=80=9Cdpu_h=
w_pp_get_vsync_info=E2=80=9D.
>>>
>>> Thus avoid the risk for undefined behaviour by removing extra
>>> initialisations for the variable =E2=80=9Cc=E2=80=9D (also because it =
was already
>>> reassigned with the same value behind this pointer check).
> There is no undefined behavior here.

Is there a need to improve the wording precision?

There are words which denote a special meaning according to aspects of
the programming language =E2=80=9CC=E2=80=9D.
https://en.cppreference.com/w/c/language/behavior

Dereferences of null pointers are treated in special ways.
The system might be configurable to collaborate also with data accesses
together with the address =E2=80=9Czero=E2=80=9D.
Would you like to distinguish supported software functionality any further=
?

Regards,
Markus
