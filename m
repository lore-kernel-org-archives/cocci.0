Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48830C0015E
	for <cocci@archiver.kernel.org>; Thu,  3 Aug 2023 10:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=AmC3rbHtp72uDtPwK/wTpdztjD31NxMTETZqnPbrqXc=;
  b=UWKaYUmEsp+1nAUbFDISfu6AGI36xB1CSM6NeqKw67b8feCz8UvRAUVQ
   702eqmobyidbnp5smPt1SelH04ShS4vDE0/5/rBIqNnQaVNEaGiDjvSzq
   yfyZPvrdlLXFVExtVUecwy8fXnkzbIGi3SkeJUV3cGeo7BQ/ZH2U1pvPn
   o=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
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
X-IronPort-AV: E=Sophos;i="6.01,251,1684792800"; 
   d="scan'208";a="120060160"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Aug 2023 12:10:41 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 237A6E0145; Thu,  3 Aug 2023 12:10:41 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 2E900E0133
	for <cocci@sympa.inria.fr>; Thu,  3 Aug 2023 12:10:36 +0200 (CEST)
IronPort-SDR: 64cb7d1c_6cBCXIi47OdJbEDjpsWJRpoDKGz6iX8UQgcKTneJe6H8MIg
 L0JepKWYmr1ZQw3oS56VWgWAqBNH8fyNp6cXoyw==
X-IPAS-Result: =?us-ascii?q?A0F+CwAvfMtkgAMP49RaHgEBCxIMQIQCeFMwBAtHhFKWF?=
 =?us-ascii?q?oczh0mEaYQEgxY+DwEDAQ1BAQIEAQEDBIR/AoZIAh0HAQQ0EwECBAEBAQEDA?=
 =?us-ascii?q?gMBAQEBAQEDAQEFAQEBAgEBAgQFAQIQAQEkFwcODimFaA2CNykBEWSBCAEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBARcCRz8DAyMEGQEBESYBDwsaAiYCAlcGARQBAYJ6g?=
 =?us-ascii?q?igBAzEHrhd/M4EBggkBAQavVB8sIlWBXwmBFS2IAQGEf0SDO3onD4FVRIE8D?=
 =?us-ascii?q?IJ4PoQLhBSCZ4l1hUwHMoI1igMrgQgIXoFvPQINVAsLZYEXgkgCAhEnExMFR?=
 =?us-ascii?q?XMdAwcDgQUQLwcEMhsHBgkYGBclBlEHLSQJExVABIF4gVYKgQY/FQ4Rgk4iA?=
 =?us-ascii?q?gc2OBtLgmoJFQw0UHgQLgQUGIEUBEsnHxoePRESBRQNBQh/HQIRJz8DBQMEO?=
 =?us-ascii?q?QoVDQsdBA4DGSsdQAIBC3A9NQkLGwYlAR4CJ55bgkDIKjQHgjGBXYFdDJ8eB?=
 =?us-ascii?q?hMvlxUOBpIyLodAkDogqCCBeiOBXDMaJIM2TwMZD44ghCePSD81OwIHAQoBA?=
 =?us-ascii?q?QMJhUYBAYMmgloBAQ?=
IronPort-PHdr: A9a23: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
 sfCnuT/JWUam+8=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:JXvjn6HB4xUVbGD6pLqEPMeALOsnbusQ8zAXPo5KOHlom7+j5q
 OTdZMgpGfJYVcqKQgdcLW7U5VoLkmyyXcY2/h3AV7mZniBhILKFu9fBOnZrwEIcheWnoNgPO
 VbAsxD4bbLbWSS4/yKgjWQL/Zl5sWb+6a1gurkw25qVhwCUdAc0+40MGem+lYdfng8OXPVLu
 vn2iLNygDLRUgq
X-Talos-CUID: =?us-ascii?q?9a23=3A81+V0GoRta96k7n+Ju6a1VbmUcwKS0DgwlnLGQi?=
 =?us-ascii?q?XVU03UqbSGGChqYoxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AZTlYXg2qBZdxje2/NMdUlPdByDUj3Y+QJVkykKg?=
 =?us-ascii?q?/muK8BC9INzCYsA2Ne9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.01,251,1684792800"; 
   d="scan'208";a="120060150"
X-MGA-submission: =?us-ascii?q?MDFdshX3YDtunf3X0A8EnARolTuzm49t2+pAcT?=
 =?us-ascii?q?UdHCcEVRSV9ECDewgBR7HNKsNZR3t9EG1uHTD8jdMPxoJPeYOqUgeyhP?=
 =?us-ascii?q?Qnx6hzALkA6UjSjvP1rz6a6T2f8ihj0GhyWcNYx+WwPpyaXCvcQLPsmz?=
 =?us-ascii?q?mwZd3ggWcx8zbYHfLEt8VQXg=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 12:10:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1691057425; x=1691662225; i=markus.elfring@web.de;
 bh=wTx6KOG6AXBOCLGKv9AdsGjAHGOAX161OdqPQbYMp44=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=W0oFBlc7dRnQW+pgUyy2r/WwGBnVxtRJlBRGjkHjR3Gy0dscP5Gj2M5hoYNBlGxA7xioHnU
 /z6FAzdrmUBB218wo060a6cLUl3plKbMzVvpg2m9U2QqGc5av6KzBc9hPzU5tnjkiKFHBq6zJ
 9NeMmgruINkAsQK7Y533w+8ZPEWRxRfxXbbQ6dreM2rh0E219aSd/EpwC81Sx2WrIb1SH0ntX
 EvVU+lM6fh78XUndhNRHVR7HGCEq7W33iCuIE4Jze+bHpW7D37GYLP6BXPora44JaHRrStbdv
 P9puIosyiswzMkkq8WiuiFARLnzJ2dLk1SuiGYdMAhLZ7Rvx2lyQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N9LEG-1pp1ID2BSG-015Y1o; Thu, 03
 Aug 2023 12:10:25 +0200
Message-ID: <81b8eea8-95be-4d22-9600-a24c12ceac4e@web.de>
Date: Thu, 3 Aug 2023 12:10:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Li Zetao <lizetao1@huawei.com>, cocci@inria.fr
Cc: Julia Lawall <julia.lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>
References: <44d5062c-f525-4994-a11c-57687c6597fe@web.de>
 <20230803094241.733300-1-lizetao1@huawei.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20230803094241.733300-1-lizetao1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0s7hYECzXraiychHTJLyRlz0mLIgR8rRrGMq+H1LNZOTjyf2aU7
 I4rE3vGg9Lkfay0rvVFE9kktIv67bY3E3VyM5Kaj5kb9KdNtnDbsWuEISiKURq9D2yrHo2E
 xNPuF1zkotDda3RNmhNAC6X8P3RSlJ29GjW7fV29nGg1z7TZ1lUKvl/CKvAKpqfV1Vpjvik
 IQHuKBAmKFTfpoBMBl/uw==
UI-OutboundReport: notjunk:1;M01:P0:oyfn0d79yFU=;tRUbMfLKKclGEmwz3sOCqEdKRHU
 YjGReCaOTBmebiGxSHncFy2281prB0j5MK/mOqJLm2H9sqPBDrLPCG2j8/ZTvLKiUSZhLoJhk
 yX0+3BeROcSpzy5ibBkgbFB6IWvM1eUC6rQ/Ds6+LE4o4CMq43f4nAubXDXDhbfNSAA1C0wMb
 Ly/x23gz4gJ9faRCa2wc0N6vx2WPlk2L9veQViQT9kFEqf+qwid4pVxOzioj32ZA7bs7qge7u
 zUlQOVbcVBmz7mbpAhAMqGVKQuQ85SKpGKjbJac5222EadAy5IRNVy6WD3/pHVtEqbEe5LKA4
 2dqFqS0Rqxlo03DYlmrjqD6Vbzts1Y3xdZIelkfGEOVINy5iH/DAFu9Diz0jbL6NVnBVu+gAa
 trTiC//2bUTbeQySayoyEi2NzhJ76TrwPyB/gZ4x2+/4c83VICdaYpBsPkHg0CmnJIPceFMpl
 uTiF7XpRbIxBBpBIQ3Gunl3j4tpzY23pDn2ijZQ3izelAWY6BdWCFM/9WsWvo6U+VA3CRX6yU
 gLBY2rxNVjzL0yYD/egk7WTygtg7+3wtw7W1+IfG4RbGwV/kghk5GEEhvCLOoOllf+1092311
 RR2elVhLk/aIrnvdDgd93cxhmPo6ygN/QXa2NoJmJbydDfHft02VH9PlbwKD9E3qfzIRoJzpp
 +0JLurOjN7WfJVbdSa7z8XkbV6vXPtKS1MQVgmWkAz9Fhr6UHsNcnMYfnn7oCtOQUK0+RcSBV
 de6NPmThVX94nffSOdtANwZ3Y4d9DWdf2AyehXv/pGHypYgoYey5exglO5r1YwVb6gdVV358o
 ZpVhlwzeDeJW7Tj05HR4uhuxJtTpzi9UtuPTKfJpEwdC0Koq9F9AWx+MQZ7usO50sdvHh+dLJ
 J1kWlBEVDfzH9dh32jjiOS20JWkaVLfoiNyOTxZa6q1n9elOYnwsLQRpxPlAO/xi5EebiEOVH
 cWzogA==
Subject: Re: [cocci] [PATCH -next v2] coccinelle: platform_get_irq: Add
 dev_err_probe() check
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1225
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-08/81b8eea8-95be-4d22-9600-a24c12ceac4e%40web.de>

=E2=80=A6
> ---
> v1 -> v2: Modify the return statement for the adjusted SmPL
> disjunctions in the patch operation mode

Thanks that you would like to pick a part of my adjustment idea up.


=E2=80=A6
> +++ b/scripts/coccinelle/api/platform_get_irq.cocci
=E2=80=A6
> @@ -60,6 +70,17 @@ if ( \( ret < 0 \| ret <=3D 0 \) )
=E2=80=A6
> +if ( \( ret < 0 \| ret <=3D 0 \) )
> +(
> +-dev_err_probe(...);
> ++return ret;
> +|
> +return
> +-	dev_err_probe(...);
> ++	ret;
> +)

I tend to prefer a different SmPL coding style.

* Thus I imagine that unneeded deletion and addition of code
  (which affects also semicolons) should be avoided here.

* Space characters should be preserved in the first text column.

 if ( \( ret < 0 \| ret <=3D 0 \) )
(
-dev_err_probe(...)
+return ret
 ;
|
 return
-       dev_err_probe(...)
+       ret
 ;
)


Regards,
Markus
