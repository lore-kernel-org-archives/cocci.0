Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE74FC3DA6E
	for <cocci@archiver.kernel.org>; Fri,  5 Jan 2024 19:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=RVEOZPAaT55a1ao0hakLdb0n0CpuhRKPtHkxLHYhwgM=;
  b=EEZsUe7Jhx7VqfXtGp+4wNepXiSVOmc5RX3uNdAhnPgjyKVj2mNjJOso
   i+FPQf0Q6tfRZ1MtZmPemcmtp5NWWpYNHAdn6W3ZG4579zRmWvVfCu3nG
   7X7pqBuhXiYgJw3c2cv7A6lu9HUcw2/841DAwXDivVKTpVPv/2CU2DFuR
   k=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail02.safebrands.com ip4:128.93.142.0/24
  ip4:192.134.164.0/24 ip4:128.93.162.160 ip4:89.107.174.7 mx
  ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.04,334,1695679200"; 
   d="scan'208";a="145138326"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Jan 2024 20:22:42 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 90943E0CCA; Fri,  5 Jan 2024 20:22:42 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 349B7E004E
	for <cocci@sympa.inria.fr>; Fri,  5 Jan 2024 20:22:39 +0100 (CET)
IronPort-SDR: 659856fe_7T+JZWZ2aAsOg4zwRgq9u0udGBTfey9kPGEus1zWqtOsNZL
 a4mII2ZHaTAU05TOT8F9WZrFR0MkjOWcfQmFu2g==
X-IPAS-Result: =?us-ascii?q?A0EpAAD9VZhlhwQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYI4fFYyBAtIhFOIHYkZLQOEO48BiG+BVhSBLD4PAQMBDTsGAQIEA?=
 =?us-ascii?q?QEDAwE4hEcChzoCHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBA?=
 =?us-ascii?q?gQGAQIQAQEBIxcHDgULJ4VsDYJcARCBDIEeAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQECDTpCAQICASMdAQERJgEECwsUBgIRF?=
 =?us-ascii?q?QICVgYBEgIBAYJ8AYIqAQMOIwcNBrETgTKBAYIKAQEGgUUCDAJDTqxyHywiV?=
 =?us-ascii?q?oFgAwaBGi4BiBoBhWeDQXonD4FVRIE8C4J4PoJhA4EYRz+DHIJoghyDQoohh?=
 =?us-ascii?q?RxSfx8DgQUEXA8bDx43ERATDQMIbh0CMTwDBQMEMgoSDAshBVUDQAZJCwMCG?=
 =?us-ascii?q?gUDAwSBMAUNGgIQGgYMJgMDEkkCEBQDOwMDBgMKMQMwVUIMUANlHzIJPAsED?=
 =?us-ascii?q?BoCGx4NJyMCLEIDEQUQAhYDJBYENBEJCygDLAY4AhIMBgYJXSYHDwkEJQMIB?=
 =?us-ascii?q?AMrKQMjdBEDBAoDFAcLB2kDGSsdQAIBC209NQYDCxsGPQKUSQGCNwGBDikCg?=
 =?us-ascii?q?hPFODQHgjSBYIFhDIoYlRMGEAMvhAGTJQ4GklSYTSCCMYkjgXaafIFjOoFcM?=
 =?us-ascii?q?xokgzZPAxkPjiAZhBKBC4NWiigBPUA1AjkCBwsBAQMJhUYBAYNagUYBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:jaQ2taOvRiROFMBcThWjsMiBIKoaSvp037Dk7TEUdfUnSL36qy
 nIpoVi6faUskdpZJhEo7u90ca7Lk80maQFg7X5eI3SOjUO21HHEGgB1+ffKlTbckWSygce79
 YGT0EUMr3N5DZB/KPHyTWZV/A93dKA7KekvuvGyWxxJDsaFp2Ioz0ZNu6BeHcGPzWu6KBJbq
 Z1bad8zQadRQ==
X-Talos-CUID: 9a23:/cGfKGDyNMNwZ3z6E3ls7GQqBMcBSWTyzlvhHU61UEZydJTAHA==
X-Talos-MUID: 9a23:bsPiXQtBS6IE5o0io82nozdCP+ttyqWVA2sOto8UnMKvbCV9AmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,334,1695679200"; 
   d="scan'208";a="75982146"
X-MGA-submission: =?us-ascii?q?MDH8Ht+GqrpWTccKcqoxm83dnruByySURVcULO?=
 =?us-ascii?q?TGIZBO0QIkRxnPrKzPkOHdBM+mLuGQAXiny+TLgLctd/4dAOBE9mrQkd?=
 =?us-ascii?q?XQD4gwzritnBXDpu8bZyxG2igXSuJw8SsHfiwFVVAtvlpnv/k7xHnu3E?=
 =?us-ascii?q?o9ihd2gKi9DXg0KPSKFG+L3g=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 20:22:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704482482; x=1705087282; i=markus.elfring@web.de;
	bh=HUSZWsUiGQOC/YkUR9iqXdqwdp4kixzaBeZcE5ri/Gw=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=sFrkJbmSup7D/LvjP3hYO2WjT4up6gCpjH2vXExnVY0ydzcCiTYkCAFKMVVWXi8j
	 MrXtEbRtJd2hyzBqOwnWRDm2K00YIJQU1k02yHufR1EuuieO0MGBYUdln95ceBN6d
	 V9PMtwfAOzuXP8BmFcdhoH4jjIyxG44hfqsVyVsq1fctqgKPpmAaHtsqK9lgL7HHv
	 pAAiNwRH4wSoLAB2NxCCHdecOxrhjp0mpQA2ymo+JdSmS27AoUn2JULH8YPhGK6fk
	 56iT0+OoXY3dqRSjAmOfAgmT3otYFV0TWrUJ1QBYNnjS678seErytdGsNWT509NEF
	 7QJkmKbfmBdOcV3Pjg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MW9vi-1rg8aG29tK-00Y4pr; Fri, 05
 Jan 2024 20:21:22 +0100
Message-ID: <34068514-27e5-4faf-9b82-2a25bdce9321@web.de>
Date: Fri, 5 Jan 2024 20:21:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Alan Liu <HaoPing.Liu@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Alex Hung <alex.hung@amd.com>,
 Alexey Kodanev <aleksei.kodanev@bell-sw.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Bhanuprakash Modem <bhanuprakash.modem@intel.com>,
 Candice Li <candice.li@amd.com>, Charlene Liu <charlene.liu@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 David Tadokoro <davidbtadokoro@usp.br>, Eryk Brol <eryk.brol@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>, hersen wu <hersenxs.wu@amd.com>,
 Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, Jun Lei <jun.lei@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Mikita Lipski <mikita.lipski@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Stanley Yang <Stanley.Yang@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Tom Rix <trix@redhat.com>, Victor Zhao <Victor.Zhao@amd.com>,
 Wayne Lin <Wayne.Lin@amd.com>, Wenjing Liu <wenjing.liu@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>,
 Zhan Liu <zhan.liu@amd.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <2258ce64-2a14-6778-8319-b342b06a1f33@web.de>
In-Reply-To: <2258ce64-2a14-6778-8319-b342b06a1f33@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7BEoYkau02QTSNEGbr+lcjHZLdsk00FLyCbaxSUukTKrCYX15Hr
 J/M0C0rCpFuqzOWWas0eRRHRRo6pz2a0sVdU5glBU5fHOxUsaAQiiJ8oycLsVI+KmBX+V3V
 3IgW3hUvw972A1pyu8KyvOfdI0J9j552K4rahvu9wJEQAr2Q7ivnaZsdXraHkLemcN6y7/C
 PC3hJ3gE78VaioUesvBKg==
UI-OutboundReport: notjunk:1;M01:P0:6EmgwCH2oOE=;tO9aap8qByf+p7NbHIm8z1VCpLP
 VEInKE3iDL9hkz52w+6uel79EqVXEPE6JARy3lDjJQWO1SZxsEV/Hp3Ti5NBcnCuI3aYYmf9Z
 Y+cysq3iYMXzwAA5w8KlkhDtkQ4X12yfZvwL+AVCcBC+AQFKwUHUoHFIfDFQ5OAURoTxTS9+d
 jxgi+oFqgOXIBUq7flQEc+9Zt4tq+BNJrU4qzcy5q6SgS8jhSHWqbP6GnRXSY6Waa+tXvtK19
 X3ToL58H5kJdLNQW0aJCofLoHQJh2RSsE6jKaONyGpSQ3OtovztcpDG2f4Zng/hHo80knDRm7
 jkaqsXMLHcqKpssa9Yv4EHa6wKaSebq3Y8WVNFe09iR9soLXDnSXOwMP0pezWUTJEjBGntSSq
 2Eh0PgRQS9ZuBKbjRPH1fKuYKw3LH2jp5EC036m3nCHw0YRX0FYeDjuv38JhsNB6Cf5v+KIV0
 tmBJw5SNQdfVOVdlDNlLOpsP7fElP6563rXAAsYo3AC+KO3nB8D5ziAz3rV05f7VokncFr0V5
 1q7YzlzXUc7CNX2trDyjjUr5uvjibK6d8OycPmGbVRiKettQ2JSMDYcT9ETgIsAKCUWp5IeTt
 9la+Ema3KZHHyrwqi0LPdP8cePtgDTD/jUWbaL0Wyl8xXM8N9iVm0uXofwURX5IU8PMNw5Mjk
 oqbk8j6mXM5ivnYepjPoVE3ibnjhPniiLWmJeo/EdY2+0kCqiNq1yilZSR/Wb9gnWrm8+5uVH
 f8k5L57VL1aQP5JJ/1ptrIKFPaQmCZcPH2VN8K9pf7BOq06Zb4zLhDuHbbSk4V73q1HAX7+2B
 aFZR8oSvWcJK+QJm6P+7uqjrmF4DYIAGGeXBayljRSBcW3OSI6umck/8z5dUjf1sbfnzFtbXh
 x/Dk4BdxeAFgZbGrh8uEsL+yg/zk9FqDxK5CRa6uawOWDZzmWfEVf3HQ5IHFxZ5CASP915Vx7
 hdhrRQ==
Subject: Re: [cocci] [PATCH 0/5] drm/amd: Adjustments for three function
 implementations
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1434
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-01/34068514-27e5-4faf-9b82-2a25bdce9321%40web.de>

> Date: Tue, 11 Apr 2023 14:36:36 +0200
>
> Some update suggestions were taken into account
> from static source code analysis.
>
> Markus Elfring (5)
>   amdgpu: Move a variable assignment behind a null pointer check in amdg=
pu_ras_interrupt_dispatch()
>   display: Move three variable assignments behind condition checks in tr=
igger_hotplug()
>   display: Delete three unnecessary variable initialisations in trigger_=
hotplug()
>   display: Delete a redundant statement in trigger_hotplug()
>   display: Move an expression into a return statement in dcn201_link_enc=
oder_create()
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  3 ++-
>  .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 19 ++++++++++---------
>  .../amd/display/dc/dcn201/dcn201_resource.c   |  4 +---
>  3 files changed, 13 insertions(+), 13 deletions(-)

Is this patch series still in review queues?

See also:
https://lore.kernel.org/cocci/2258ce64-2a14-6778-8319-b342b06a1f33@web.de/
https://sympa.inria.fr/sympa/arc/cocci/2023-04/msg00034.html

Regards,
Markus
