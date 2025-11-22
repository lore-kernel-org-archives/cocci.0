Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B43ACFC539
	for <cocci@archiver.kernel.org>; Sat, 22 Nov 2025 14:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=dH9At+e+gZoo5QokQZYH6PWpd4a0IQWgJoIbFGtzQ4I=;
  b=tEEhPe8Ck2p5X5WMtgWVa1c6AkSjI63y+nNF5j8/eo3jNQ6w/D32PIs6
   j7R97kHopoTZeuwngr6d94NvFKOGe6+6nzg+xFkvhuOobXxfRJkZxkkZg
   spoO/cTWxSvITL78qlawHbI79dHnSUTjNyqgx32uCHGsBYCzN5RJZlHZT
   0=;
X-CSE-ConnectionGUID: dU+7k5tgTcWqHLNVi6GtJg==
X-CSE-MsgGUID: xgBIBpfuSyetePSCmqu5ag==
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
X-IronPort-AV: E=Sophos;i="6.20,218,1758578400"; 
   d="scan'208";a="250641514"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Nov 2025 15:54:19 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DE83BE0BE9; Sat, 22 Nov 2025 15:54:18 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 407CDE0171
	for <cocci@sympa.inria.fr>; Sat, 22 Nov 2025 15:54:15 +0100 (CET)
X-CSE-ConnectionGUID: 4gakWHqeQxGgylDnKBkN/g==
X-CSE-MsgGUID: VJn4x8lXRRCuZVDOusPhoQ==
IronPort-SDR: 6921ce96_BmD5Knc6xVCa9BCxA38iPJfBMMzDWNcSTFwEn6dzTy/Euld
 6AmTj71vvbGO/E/hg5n2A0Z1Yzng6YWMjC0P/Tg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FNCADkzSFpgAMP49RaHgEBCxIMQIQQZR0GWDMEC0kIh?=
 =?us-ascii?q?E2PU4IkhDuPEYxLAg8BAwENSgQBAgQBAQMDAYIMgnQCjGACHgcBBDQTAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABATsHDjuGTw2CYgGBJ?=
 =?us-ascii?q?IEmAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQECR?=
 =?us-ascii?q?0QBAQECASMdAQERJgEPCxoCJgICVgYVAQGCfgGCIgEGEAEDDycHDQayR4Eyg?=
 =?us-ascii?q?QGCDAEBBtpeHywiWYFkAwaBHC6FboJlAYpmJw+BVUSBPIJSMT6CYQGFPIJpg?=
 =?us-ascii?q?iaBDplnUngcA1ksAVUTFwsHBYEgQwOBCyNLBS0dgSQhHRgRYD0XQINJHQZoD?=
 =?us-ascii?q?waBEhlJAgICBQJAOoFoBhwGHBICAwECAjpVDIF3AgIEghh9ggoPiFaBCQUuX?=
 =?us-ascii?q?gIBC209NwkLGwY9lRxRgzwsIm+mJKFFNAeCOIFngWQMii6VPgYTL4Nxk2EOB?=
 =?us-ascii?q?pMFmQaOCJs5gX8jgVwzGiSDNk8DGQ+OIYQzgQvFVUI1AgkxAgcLAQEDCYVGA?=
 =?us-ascii?q?QGMVoFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 FnwUYfpNckxsfmov/kxDBQPkzpz3tAzB+o=
IronPort-HdrOrdr: A9a23:5gM1YanHfTt5VBflC/X60bNZc0vpDfL43DAbv31ZSRFFG/FwWf
 re+MjzpiWE7Qr5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQyVxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK7/oSizPZLz9P+qjlzImVpaP502pnSx1sZppt9gFjF2+gYzBLrUV9ZKbQD/
 Cnl7F6TtebCA4qhk/XPBM4Y9Q=
X-Talos-CUID: 9a23:oMlh+W2s6a4lQ7WmTgv9kbxfRs8scUL91XrpM2C3GGJFTp6/SnnX9/Yx
X-Talos-MUID: 9a23:TrnP1wUFQG+DmVvq/AHOgm1yZMNY2Z6FFXIzvbIboPGEMhUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,218,1758578400"; 
   d="scan'208";a="131618777"
X-MGA-submission: =?us-ascii?q?MDFyToX2HdvwS96UwPKyL4jdJAXANudiDpX/yy?=
 =?us-ascii?q?gYc7TCHM0X96CxpUQks1urCbHiqqXJtGv/t2jZQ++87dqBJ2y4eSFbsF?=
 =?us-ascii?q?ck2cO9eAqCS3EiZTkGgRO50aSkDrOR2S5zX9LnHeNxI858oDGXFWR/sp?=
 =?us-ascii?q?wcBA5aWnCY39OjLB9kMV07Kw=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2025 15:54:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1763823253; x=1764428053; i=markus.elfring@web.de;
	bh=dH9At+e+gZoo5QokQZYH6PWpd4a0IQWgJoIbFGtzQ4I=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=KRKmYz/ZglhuD8aLpPk19O2YOg8piGjJ1jtVfLx2vviz0GxDadc9C8Z3AHYjP0pt
	 hm/buctMHoblxoMPjzclZYq4/i3TUn2Ybnm955i5sjWRR+e8q3+ofVwERvydubu5M
	 7forxYANXuefV9UKLqpiBV5V167G5gJFMok5yJDcAuxlyxGy9Hz/Ggg3VWuBKCLTJ
	 w9Ilo+ZVdCAPAz2bKC1stE8/xGcyV4N5nVH9rPlYmq2AKRlI7oevZwdge0bz7wUmw
	 g6HmX8MChXGu0lO4OZlqpcSKLptuSAmyzlcipihR13UZaCUNxOAZxVUnUhtvgzVYY
	 MGIJ3vqh5PDH2gC6Ew==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.246]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MDMzC-1vFhT92uko-000BuU; Sat, 22
 Nov 2025 15:54:13 +0100
Message-ID: <3c6cf880-301f-45f6-afd9-a4e696d4527e@web.de>
Date: Sat, 22 Nov 2025 15:54:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>
References: <228c50a2-bb15-4abe-bef9-b0f9b95f6992@web.de>
 <7cea8a1d-31ad-4475-be80-ef1cb1e3b2d1@web.de>
 <188e41fa-91c5-b09c-51d1-8f69f5d8cea@inria.fr>
Content-Language: en-GB, de-DE
Cc: cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <188e41fa-91c5-b09c-51d1-8f69f5d8cea@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:KIlp6OIQCypsV+ryK0VNUSAOIhAq6b68shxoY0pZLVa5ORBfAJ7
 /v4VJrWBJKqRZLky5DPHAaUr3g2ZScOQTluJe2R6qMhFfc7vfINiwbnDSGvr3jqBWzLWrSp
 JpZnwEHsrd4bg5HzDRldOPWTARKWtA4BlG526DofNPEJ+FFAaWNS3Y6EU6U0Z9EzZdtKLkc
 ktntlVwA5mcHQcuBLRpMA==
UI-OutboundReport: notjunk:1;M01:P0:O21kZqXQxeU=;EipmFeVCjczvSLl5qOIXpnpkAkR
 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
 s6MupLDU=
Subject: Re: [cocci] Avoiding duplicate elements in SmPL disjunctions?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3192
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/3c6cf880-301f-45f6-afd9-a4e696d4527e%40web.de>

>> Which components of the Coccinelle software are responsible for such
>> data processing results?
> iso_pattern.ml

Thanks that you pointed this OCaml source file out finally.
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/2d5df416a939c5c7b9d958559be3b63e0b1414fe/parsing_cocci/iso_pattern.ml

Unfortunately, I find that such source code is not directly adjustable
(by me).
Thus I hope that algorithmic properties can be clarified better
also according to reported remaining open issues.

Regards,
Markus
