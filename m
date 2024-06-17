Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14BD7C27C79
	for <cocci@archiver.kernel.org>; Mon, 17 Jun 2024 13:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=GJodRYjw0NUrXOfHFiCYBISEjvYt+NlpCcpFTpE/cvE=;
  b=rbCewGPj1H6zwjx55AeXTjsWP6aWTALt40zn793lYhD4mBdk6645wK2q
   a6CP4cXpluYD3c57CqEVif1ahr2QUQckSQCI5d35bpF7avjGc9bRDakxv
   iBIcNXXnggOITZdR6DUJROxaiIa8mqMfNMk+uKwImkhEd2SAbLUMp4dVE
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.08,244,1712613600"; 
   d="scan'208";a="171066188"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Jun 2024 15:48:23 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 86663E0AF6; Mon, 17 Jun 2024 15:48:23 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 301EFE0157
	for <cocci@sympa.inria.fr>; Mon, 17 Jun 2024 15:48:21 +0200 (CEST)
IronPort-SDR: 66703ea4_vxtq3SpQ8+3UIYl2HuhG21w2ksyOjqtWEvsABMy1hSQeXrD
 5ICj79T6immuRGRUiLNx3sNJNnfp//0rHwsqMhg==
X-IPAS-Result: =?us-ascii?q?A0FGAABaPXBmhwwR49RaHQEBAQEJARIBBQUBQIE8BwELA?=
 =?us-ascii?q?YJDfAZUMwQLSIRWkT0whDuPCohxgVaBQD4PAQMBDTkIAQIEAQEDBIQ5RgKId?=
 =?us-ascii?q?AIeBwEEMQgOAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBAhABAQEjF?=
 =?us-ascii?q?wcOECeFdA2CZwEQgQ6BJgEBAQEBAQEBAQEBAQEBAQEBARcCDTpCAQEBAgEjH?=
 =?us-ascii?q?QEBEScECwsaAiYCAlYGARQBAYJ8AYIvAQMOIwcNrmKBMoEBggwBAQbaWR8sI?=
 =?us-ascii?q?leBYwMGgRouAYgwAYV8hEAnD4FVRIE8glIxPoJhAoFgg1uCaZlcmQ1UfRwDW?=
 =?us-ascii?q?SETAVUTFws+CRYCFgMbFAQwDwkLJioGOQISDAYGBlk0CQQjAwgEA0IDIHERA?=
 =?us-ascii?q?wQaBAsHd4FxgTQEE0QDgTeBUogdDIMvgXQnhBoIQ2wVg26BawxhiApigRCBP?=
 =?us-ascii?q?oFmAUuDBU2EDh1AAgELbT01CQsbBj2peoUtBB7HYzQHgjaBYIFiDIohlScGE?=
 =?us-ascii?q?y+DcgGTRw4GkmsemEcgjVabFIFmATiBXDMaJIM2TwMZD44hGYNhM8kKQTU7A?=
 =?us-ascii?q?gcLAQEDCYVGAQGDWoFIAQE?=
IronPort-PHdr: A9a23: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
 nO6RjtGvFys1OWCmGIPbQ==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:2GGBgqrhq2MiRWkcUyPMyvAaV5r1eYIsimQD101hICG9Afbo8v
 xG+85rrCMc6QxhPk3I/OrqBEDuexzhHPJOkO0s1PKZLW7bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QEZSWY+eRMbEVt7eY3CCFM5IH3MSN9ryuiNzT1nF3UGhRGttdBktCazpyCSdNNXF77HcCZe
 GhDkErnVCdRUg=
X-Talos-CUID: 9a23:3ebNSWwxsYfVcRZz7qgJBgUSAdIYfy3z1038BFXnNkEqSeWZDlyprfY=
X-Talos-MUID: 9a23:zI2dZwv/HNstAU8pjM2nlCt9E9hN85mUE0ExvY0fl5XcaHJTEmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.08,244,1712613600"; 
   d="scan'208";a="89896862"
X-MGA-submission: =?us-ascii?q?MDH9mmLzPU5gfw34cu40rQmT7sj48l11OTmPP9?=
 =?us-ascii?q?evK0fj9SOcYOI1xQSZ0Xzu6nhq30+UvU37XS0EQlBAVC/XfL5Z42r+Nq?=
 =?us-ascii?q?QaboPfFeSvBcDvwWkxNooQpGkW9NrHUlZ8fhoiMg3nTMEmDEpyL1H+rp?=
 =?us-ascii?q?FR7jic4UAhG/Z8xUiEI+enig=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 15:48:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1718632098; x=1719236898; i=markus.elfring@web.de;
	bh=GJodRYjw0NUrXOfHFiCYBISEjvYt+NlpCcpFTpE/cvE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=VtqX/GJgbrQBJPWfQ2ERdFQj6Evzi+HlXPwZnGsDkH36Ag3rH2WwY2NWyMan2/LK
	 hN4TO+dFLPkno2+2CDF7xT+DJllgj4G0dh31Z4oE9jW9DDCWUQn4gJU1N2C2nQcPh
	 E6OzkgoZWwXTc9jcJSAP3QVbs3yXDzvSKNF//bErer+n6oYD28ghofc3Nib5iAHtt
	 1fMIyL5eMiaWYTo6LbXX+joWZgq9ydcPyb9Um/HpAeUpY00IQNmam9li8Nh/PTa0Q
	 5jK7Yr5MYozBeaRqdeQxr8OXKgiE2IdTLBAcBynhXN6KHpJ+vrTAUaOaOpGWaQP9b
	 JCwfHpWprnlvFIicYw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MovjQ-1sj7fw2rnS-00atIk; Mon, 17
 Jun 2024 15:48:18 +0200
Message-ID: <c545b692-de55-4a5c-b6f4-c6f2c7a9b8d3@web.de>
Date: Mon, 17 Jun 2024 15:48:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Thomas Adam <thomas@xteddy.org>, cocci@inria.fr
References: <CAOhcEPY3QqNFMzfGT4Zy8We5Y0+SLaG=A+5YZ5+O0MZAkGEKhQ@mail.gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAOhcEPY3QqNFMzfGT4Zy8We5Y0+SLaG=A+5YZ5+O0MZAkGEKhQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/3GudakYIiUlYlizEEtfYw2kcZ6cVHx2uqauYdAxCwZVxaA8Qec
 34IYbWuyUWhdkjYSfnQDG6d45omFeX8o7hxmZxyW/DMZkr2tAvlEK9XXueM+Fty3G8/8Jj4
 SqydgP0teV4z/6Izyan7uxQP/OH9EX1ssdkYwDtpohaJMlfJStW25q1K8Gw0mgqgf7WkcZY
 CBoxXAXKajVVjNb1evcJQ==
UI-OutboundReport: notjunk:1;M01:P0:BiTeRfm/xII=;Ufs0jim0BFl1ZuaE2EmHpxOTjQ1
 wn/u8jh7ifg9vLfiQaobIWnzRRz3Tdlsw+7JtbIaPHyrW37F53gZnm06+Npc6uxqzy9cUNzyZ
 Sf7aCUW/b6EkHF+6hcR3JGjZvRxkswwjJ4jTCkVOlizThUCal0UPv7C3FbLGNGWdWGuKmiWQG
 8rAEx6r3Z++KS7kvgzoqccvSTA1k+nhCvwv4I54sJ6BcoYhqx8iLVEesPI2EWYEqcVjCF6fkx
 Z9X/0RO5RbVRK/lKFXnCd4kC6jkujzjCCLf0X6mEk/PIJGrxMbfT63dEmdjM13JinE+DEJ8h1
 F6yzZ50Mk94RXSv7l6cQJJooLBGWYS9YUJcsHybI5/2TL9uFKUARgRu93fFUng82hropLj9Ou
 LjGOJgl9QJTYF8RWiyoOh5PnC9V/hcIqNde2Vfh2S1NHNl50+DuNQdDlzAdMUNRvkaVEaykJ0
 xQpgwQOKyruacgnZEuoUTPWljjasMKHyujN5Y8yt8s9ej3g0bO8JJekl4skF6iUI0+kbzOwQi
 8Iley32N4n1pK4ZMZWLINc9HPHxpi1cA/3oXSIXWSwYoWkzscHQkXW97wd0NQQHHxCLsN6veI
 4l5vDvzb+uOQS1KvqK6vzZMWql111IWn+RCDM/7dCOm+5v3rZ4pen6/CGF/VRG6mOBBgZFkjF
 gDms4gnVLL6wmuCF5YE4PF5DF+CRJSFaDGtjmbUf/f6/C8ECzNKu2dYBRwGJ4Iyt1vB/eGV15
 /szScms88sMLB2Tq/tCz4ipUjAeMD3NswdUbcDqGY8nITPPPVWhybxFzoVFEIol5CzJ8r1vrp
 hZzHuF2pc/Af+702IjBfnftJrC3XHSk3Ls3T+xPBrbL1Y=
Subject: Re: [cocci] Disabling code blocks from SmPL data processing
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1792
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-06/c545b692-de55-4a5c-b6f4-c6f2c7a9b8d3%40web.de>

> Such that, for code defined between those two comments, spatch would ign=
ore it.
>
> Is something like this possible?

A similar clarification approach is waiting for related progress.

Exclusion of unsupported source code parts
2014-03-28
https://github.com/coccinelle/coccinelle/issues/20

Regards,
Markus
