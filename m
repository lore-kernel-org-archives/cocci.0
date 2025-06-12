Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CFB4C61CE8
	for <cocci@archiver.kernel.org>; Thu, 12 Jun 2025 20:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=l//TA/wIxUleMp15iIiBD/Mnz0+P2PcGzVXJQCu7cgo=;
  b=oJ2rJXeTkO/BfPEAHvFeeLkkwjdXke7pXVnIT3+Z+3u140mNhNYldHvv
   vAjQM0XYGs13Q9wN+iFHTGma2S54R6BJohI56YpdIuIpjOW014WyE8Xy1
   y6WCMRjxKRMMCrWToGc0R0oiQHydS2HJ9rTjSrZ/qko87dZnVoan7KEKk
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
X-IronPort-AV: E=Sophos;i="6.16,231,1744063200"; 
   d="scan'208";a="226952513"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Jun 2025 22:25:25 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 594EEE0AF1; Thu, 12 Jun 2025 22:25:25 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 0DAB9E0131
	for <cocci@sympa.inria.fr>; Thu, 12 Jun 2025 22:25:20 +0200 (CEST)
IronPort-SDR: 684b37af_Etouegb0H/jCTOkFiM0YXYiaulHM+2/xEhg3CzTYvAJ2Y3I
 QfKRqSrv4rxuLP9umF6wxFMu6rwrEyFGbq9fwEA==
X-IPAS-Result: =?us-ascii?q?A0EiAAAQN0togA4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAQGCQoEAWjMEC0kEhFGIHIc0giSEO48PhHCEB4FVgX0CDwEDAQ1EC?=
 =?us-ascii?q?gECBAEBAwQ4hEgCi2cCHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBA?=
 =?us-ascii?q?gEBAgQGAQIQAQE7Bw4KMYV7DUkBEAGCBwGBJIEmAQEBAQEBAQEBAQEBHQINO?=
 =?us-ascii?q?kQBAQECASMdAQERJgEPCw4MAiYCAlYGARICAQGCfgGCIQEGEAEDDiQHDbBbg?=
 =?us-ascii?q?TKBAYIMAQEG2l4fLCJYgWUDBoEbLgGFbIJjAYVsO4NCeicPgVVEgTyDAz6EQ?=
 =?us-ascii?q?4NbgmmCKIEWjRaUCFJ4HANZLAFVExcLBwWBIBAzAyo0FB0jDzwFLR2CDYItT?=
 =?us-ascii?q?4IdH4FzcGkDAxYPAYIkgV4cg0KBI4RJK0+DIoEDfEwZQYNhHgZyDwZHQAIBC?=
 =?us-ascii?q?209NwYDCxsGPZh/hSqZDAGvXjQHgjiBZoFkDIotlTsGEy+DcQGTWQ4GkwIuh?=
 =?us-ascii?q?2WQcSKLbIF5mzGBaDqBXDMaJIM2EzwDGQ+OIT6DdYRgskZBNQIBOQIHCwEBA?=
 =?us-ascii?q?wmFRgEBiGGCAIFLAQE?=
IronPort-PHdr: A9a23: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
 fIz
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:5lzqtajFRgMmch2QfPz2rF06XnBQXg4ji2hC6mlwRA09TyVXrb
 HNoB1p726RtN93YgBZpTngAtj4fZq4z/VICOYqUotKMDOW31dAabsSi7cKoAePJ8SdzIJgPM
 5bGsASNDSzNykesS+Q2mmF+rgbsbq62ZyJwcHD0nxqUQZmUK146RxlYzzrb3GeCDMmOXIjfq
 DsnfavSgDQA0j+5amAbEU4Yw==
X-Talos-CUID: 9a23:Jb53qW+pfTfl5wNarD2Vv1AVIfomVyTX8Fn7PUWKMmY5eaWFDkDFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3AHonqLw2KIbOFgswz1eKJG8rIBTUj74iuB2dSq8o?=
 =?us-ascii?q?8qvbeDHBWPmzEvBC0e9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,231,1744063200"; 
   d="scan'208";a="226952511"
X-MGA-submission: =?us-ascii?q?MDH1fyQAgmUzT4BhC3wiGeSBTyf3bAiVUdGzV1?=
 =?us-ascii?q?0wbfqTbvKrXwXviCrck+hUO4xn/ymJi2/JM9ZaDfgi93rL0Foeb1TgUu?=
 =?us-ascii?q?/IbnaMl/hmY7lJIf4NmEdYieNqOOayAby4QxZogPRTp+zAXSqKf1NXxy?=
 =?us-ascii?q?pmh3oFlh8VGPW6hoXTs4AhlQ=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 22:25:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1749759910; x=1750364710; i=markus.elfring@web.de;
	bh=l//TA/wIxUleMp15iIiBD/Mnz0+P2PcGzVXJQCu7cgo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=JtxOZU0Bb0KCjL9undv45j90FKoU0oXbT5ZXeDKxESLRRyeH27izkwlNfCqD/xB1
	 eupaVVNcSWV/pQ5BhiRZHjMWjCixqahN1FpSa7sIWJVYdr8G52EoSJWxsZ0mooDr9
	 lpGPPzZDW4LhS8yYosXle0boqUmhmoZ8PmflJebw70C/P0VomAnJT16DrUIbnuvMj
	 G49qSrG0iDoIxjo50WIbu+EX2ynnadglzcglZnAqpSrx2ZqnT11na3mp5MxPrSDrr
	 2jt7p3m7HwjbOw8lbp4pTKyUz8uEwFwZKuqcGGvHQRTHB3TxKaf1sL34EmOamX5RR
	 8ZOVnylZ05HUdBQA+w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.213]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MK574-1u6dTM0xYc-00YXDn; Thu, 12
 Jun 2025 22:25:10 +0200
Message-ID: <a0f391bd-4bea-41c9-8c4c-cc1237261e0c@web.de>
Date: Thu, 12 Jun 2025 22:25:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Melissa Wen <mwen@igalia.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>, Alex Hung <alex.hung@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Dominik Kaszewski <dominik.kaszewski@amd.com>,
 Fangzhi Zuo <Jerry.Zuo@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Mario Limonciello <mario.limonciello@amd.com>,
 Roman Li <roman.li@amd.com>, Simona Vetter <simona@ffwll.ch>,
 Tom Chung <chiahsuan.chung@amd.com>, Wayne Lin <Wayne.Lin@amd.com>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 lkp@intel.com, oe-kbuild-all@lists.linux.dev, llvm@lists.linux.dev,
 cocci@inria.fr
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <e6656c83-ee7a-a253-2028-109138779c94@web.de>
 <ea0ff67b-3665-db82-9792-67a633ba07f5@web.de>
 <32674bac-92c2-8fc7-0977-6d2d81b3257f@amd.com>
 <da489521-7786-4716-8fb8-d79b3c08d93c@web.de>
 <8684e2ba-b644-44c8-adf7-9f1423a1251d@web.de>
 <5ebybqjohsoz7qhsenufkpkkw52w6tgikkbrzpegwotmefhnpn@m2cnzvsfai7v>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <5ebybqjohsoz7qhsenufkpkkw52w6tgikkbrzpegwotmefhnpn@m2cnzvsfai7v>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CwmAqMJtLC/WOX/lrln3aBeTTfzPJqj7veTvO0d7RPoT+Y3/0x2
 AUU2rmDO2pYs/7lyefDrbNyuFHKGmp7+SKOtv9CFLhYt8x5gCete32jmT96nsZqLwM9BCAM
 JoihQ6ARUa6+c1VrSTcPQNxBSw3tiwIhWuMvjzIJk8oXZLyWr6ahx/ai4C4md4+8I8EVlKw
 sBja6Xq/hztnkH89OaHjw==
UI-OutboundReport: notjunk:1;M01:P0:ktVqxSortBc=;8nMd/P9Mkb4oM6NrEJRSTJVAxNq
 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
 1j8v78ikg+0Dj83zdoN+HSdtzmCmn4nvu+NpSA==
Subject: Re: [cocci] [v3] drm/amd/display: Fix exception handling in
 dm_validate_stream_and_context()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2786
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-06/a0f391bd-4bea-41c9-8c4c-cc1237261e0c%40web.de>

>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202506100312.Ms4XgAzW-lkp=
@intel.com/
>=20
> As the patch wasn't merged yet, don't add these two kernel-bot-related l=
ines.

Can such information eventually be omitted also by a final committer (main=
tainer)?

Regards,
Markus
