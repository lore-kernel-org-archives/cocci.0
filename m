Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B769C02196
	for <cocci@archiver.kernel.org>; Tue, 28 Jan 2025 09:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=aTaxPFgQM55bDHS78eogiTvJhLtaU3Z7B8f3qhFYzHw=;
  b=UNo+au7NfDlPdUsIEsy5OdT1oYMaPuavwexvTVldiOY6+z8SP2zbLFX4
   LhbeSav+SDRT63ZWvwPIhcsnPG7XvKQf0L/3PZ4Nbm9lMlkZtqsDuMq5o
   61mLAR1odC6xxhuiFGULd1f49Nzb5at1fN07JDtPyazM2MR9z4G81inY4
   8=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@collabora.com
X-IronPort-AV: E=Sophos;i="6.13,240,1732575600"; 
   d="scan'208";a="205325357"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jan 2025 10:13:20 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 814F0E0D92; Tue, 28 Jan 2025 10:13:08 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 97913E0035
	for <cocci@sympa.inria.fr>; Mon, 27 Jan 2025 04:56:24 +0100 (CET)
IronPort-SDR: 679703e8_052iKw+6vRRsXaDbUFuhOLI+FEZi1Oj+pWn+9D+AF0dhVIZ
 JI9Kikpx0kmx5fTfYcPMNsGthVapFpyQ2oLIb9w==
X-IPAS-Result: =?us-ascii?q?A0EUAADUApdnhcNp+5RaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBQAUBAQELAYJDgVczBAtIhFaPT4F0MIQ7mV2Bfg8BAwENQQECBAEBA?=
 =?us-ascii?q?wEDhQACinUCHgcBBDEIDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGA?=
 =?us-ascii?q?QIQAQEBAUBJhXsNgmIBM4IWLAhjAQEdAQEBAQIBIwQRCAEBNwEPCxgCAiYCA?=
 =?us-ascii?q?lYGCwgCAQGCfoJCIwIBBbVgen8zgQGCDAEBBtwfgWQJgRouAYVqgmMBhWuDf?=
 =?us-ascii?q?XonD4FVRIE8C4J4PogegkcigjNLgSmCNCVnhmaFZ4EvgxKEZ4phUnscA1ksA?=
 =?us-ascii?q?VUTFwsHBYEpSAOBEiOBJgU1Cjc6gg1pSTcCDQI1gh58gitrBAWBLYI7hEWEU?=
 =?us-ascii?q?YVeghSBZQMDFhIBgyd5HoFNHUACAQttPTcJCxsGPZ0wPIRhglaXCY4TaKBSN?=
 =?us-ascii?q?AeEHoFdBgyfXAYQAy+EBJNUknuYfIJYpiQxgWkCNoFcMxojgzdPAxkPjiEJE?=
 =?us-ascii?q?AmDWMdXOzU8AgcLAQEDCYVGAQGKUIFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 E4bjFdhL4xbNrL/dEfpVx8UbXdINM+2
IronPort-HdrOrdr: A9a23:reAF864EUyaCf1DYSwPXwPHXdLJyesId70hD6qm+c203TiXqrb
 HKoB19726MtN9xYgBHpTnkAsK9qBznmaKdjbNhWYtKGTOW31dAT7sM0WKB+VDd8kTFn4Y26U
 4jSdkdNDSaNzlHZKjBgDVQX+xP/OW6
X-Talos-CUID: 9a23:p1MDzWG6hxHuMw9hqmJc+W8eKOcZSETfxXX0fGK7BUVgSba8HAo=
X-Talos-MUID: 9a23:pZRJIghj8ov+jt4EnLSH1MMpa/xT84OPB0Y31pQskMq9awxaJjmFtWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,237,1732575600"; 
   d="scan'208";a="205075188"
X-MGA-submission: =?us-ascii?q?MDHLeexcJmoGsNJ3Cf/iuCB7wcw+ZKYmIYHNjz?=
 =?us-ascii?q?5XFKGcOWTTca9lZFbk/bP4WQffOQdTN16Fhf63Z6WC32bhcaZA50FwKi?=
 =?us-ascii?q?El0adyLzdL8fmvUOBTbTZwNx72o03kK9RedMrmg12sMYdrdNxxwDP2ZX?=
 =?us-ascii?q?J1FH1ChT73YOAa95+QkaQ5fA=3D=3D?=
Received: from bali.collaboradmins.com ([148.251.105.195])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 04:56:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1737950183;
	bh=IObs1/3ftVIXcrcHAAaEO9FHqrki8Lsf9n0KXWbAnH4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FD0JVqwuCY7goV2eSFKvQ9Ma3n/rm9HCWDy/ljIWZyjXbpYkX3L59auKgQcm3oO00
	 8k5ZSt6oB7JpqV0rkK+45NMZoqhpXbE7xoyODimPbFff2aPEiRwy6jY5ZfjAZVmqDS
	 WnM+w/SMrGzO7F4SWskUqzkr6BMYOSakoVMkJZfbCkN9wguQdsXTZ5YQhd21knoE7U
	 ZD7ageo0jO5rZs5xmGXdki03e06ZhBdpOAUiJau9WtVnh+SfWfVGRO+btx1BuifKLA
	 iDGRyy34W2gZlOoDQcw/KQ/b88BKMBoHLYOb6qVYKvF8Lo90tS5oAXPuBkvro8Hfkr
	 3nn7wfTD2U64g==
Received: from [192.168.50.250] (unknown [171.76.81.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3D93317E0B25;
	Mon, 27 Jan 2025 04:56:14 +0100 (CET)
Message-ID: <47538328-670e-4c71-a07f-b313f99e56cd@collabora.com>
Date: Mon, 27 Jan 2025 09:26:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: kernelci@lists.linux.dev, linuxtv-ci@linuxtv.org,
 dave.pigott@collabora.com, mripard@kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kselftest@vger.kernel.org,
 gustavo.padovan@collabora.com, pawiecz@collabora.com, spbnick@gmail.com,
 tales.aparecida@gmail.com, workflows@vger.kernel.org,
 skhan@linuxfoundation.org, kunit-dev@googlegroups.com,
 nfraprado@collabora.com, davidgow@google.com, cocci@inria.fr,
 Julia.Lawall@inria.fr, laura.nao@collabora.com, kernel@collabora.com,
 gregkh@linuxfoundation.org, daniels@collabora.com,
 helen.koike@collabora.com, shreeya.patel@collabora.com,
 denys.f@collabora.com, nicolas.dufresne@collabora.com,
 louis.chauvet@bootlin.com, hamohammed.sa@gmail.com, melissa.srw@gmail.com,
 simona@ffwll.ch, airlied@gmail.com, Tim.Bird@sony.com,
 laurent.pinchart@ideasonboard.com, broonie@kernel.org, leobras.c@gmail.com,
 groeck@google.com, rdunlap@infradead.org, geert@linux-m68k.org,
 michel.daenzer@mailbox.org, sakari.ailus@iki.fi, jarkko@kernel.org
References: <20250123135342.1468787-1-vignesh.raman@collabora.com>
 <20250123135342.1468787-6-vignesh.raman@collabora.com>
 <CAHk-=wiWcw-aPcMvWYqJDqxopPYXnPnVgFYAUSkvkRPTjO83uQ@mail.gmail.com>
Content-Language: en-US
From: Vignesh Raman <vignesh.raman@collabora.com>
In-Reply-To: <CAHk-=wiWcw-aPcMvWYqJDqxopPYXnPnVgFYAUSkvkRPTjO83uQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v2 5/5] kci-gitlab: docs: Add images
Reply-To: Vignesh Raman <vignesh.raman@collabora.com>
X-Loop: cocci@inria.fr
X-Sequence: 2263
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/47538328-670e-4c71-a07f-b313f99e56cd%40collabora.com>

Hi Linus,

On 23/01/25 21:16, Linus Torvalds wrote:
> On Thu, 23 Jan 2025 at 05:56, Vignesh Raman <vignesh.raman@collabora.com> wrote:
>>
>>   Documentation/ci/gitlab-ci/images/drm-vkms.png | Bin 0 -> 73810 bytes
>>   .../ci/gitlab-ci/images/job-matrix.png         | Bin 0 -> 20000 bytes
>>   .../ci/gitlab-ci/images/new-project-runner.png | Bin 0 -> 607737 bytes
>>   .../ci/gitlab-ci/images/pipelines-on-push.png  | Bin 0 -> 532143 bytes
>>   .../ci/gitlab-ci/images/the-pipeline.png       | Bin 0 -> 62464 bytes
>>   .../ci/gitlab-ci/images/variables.png          | Bin 0 -> 277518 bytes
> 
> 
> This seems excessive.
> 
> We have a few images in the tree, but they tend to be either the
> penguin logo or various source SVGs.
> 
> Not a set of random screenshots or whatever.

We will remove this commit and update the documentation. Thanks.

Regards,
Vignesh

> 
>           Linus
