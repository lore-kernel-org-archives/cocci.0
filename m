Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B3FC282EC
	for <cocci@archiver.kernel.org>; Tue, 18 Mar 2025 10:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=d6boJSRxN0mLYlu6pwzdCyZOaYtMszoiLGTAYoiFXzc=;
  b=bycjeFpE7pXcDY/e6Ky60Ebatoe1rN0hsBXc6SeMj31cFOI+uMB4BINd
   kLyZfpjEreL0It3//ykATq1XRngngRUMZvKV+U34NTgSY5KqvksysjR9N
   DUvaX6ZJNsslpyzoG/AkXPdL+DjmZ2InUVyb5OPwFQRcAa/xG9nYHTTgd
   A=;
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
X-IronPort-AV: E=Sophos;i="6.14,256,1736809200"; 
   d="scan'208";a="213455359"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Mar 2025 11:55:46 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 355D4E0261; Tue, 18 Mar 2025 11:55:46 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id BF0BEE0260
	for <cocci@sympa.inria.fr>; Tue, 18 Mar 2025 11:55:44 +0100 (CET)
IronPort-SDR: 67d95130_Ai/NZwv6e//o9s5BOT2hKo4zqlOzjUC7CzZ+aY7oK8ONRr5
 8maYh/P+01PGUvQqIM1/O5h48f65sWuAyRB+auA==
X-IPAS-Result: =?us-ascii?q?A0F+DACJT9lngAMP49RaHgEBCxIMQIFIC4JEYhtaMwQLS?=
 =?us-ascii?q?AiETo9QgXQwhDuPDoh1g1QPAQMBDT0EAQIEAQEDAwGEOkYCix8CHgcBBDMGD?=
 =?us-ascii?q?gECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQE7Bw4KMYV7DYJiA?=
 =?us-ascii?q?YEkgSYBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QINOkQBAQECASMdAQERJwQLCxoCJgICVgYBFAEBgn4Bgi8BAw4jBw0GrUWBM?=
 =?us-ascii?q?oEBggwBAQaBWEHYQx8sIleBZQMGgRouhW2CYwGFawE7hDwnD4FVRIE8C4J4P?=
 =?us-ascii?q?oJhAQECgV6DW4JpgjOEQ2eOWIgcgweQHFJ7HANZLAFVExcLBwWBKUMDKjQxI?=
 =?us-ascii?q?4EiBTQKKg44KYFjaUk6Ag0CNYIbJFiCKGoEBYEkgjeEPoRBhVCCEYFdAwMiA?=
 =?us-ascii?q?YMfdRyDSHY+hGQtUIFNHUACAQttPTcJCxsGPaMOO4RDD1NZIsg9NAeCOIFmg?=
 =?us-ascii?q?WMMiimVNQYTL4NwAZNVDgaSfZh+Io1jmy6BfSSBXDMaJIM2TwMZD44hg3ozg?=
 =?us-ascii?q?Qu1V0I1AgkxAgcLAQEDCYVGAQGKVIFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 A==
IronPort-HdrOrdr: A9a23:7afA8qrAzVWw5vNFJgc3nZ0aV5o+eYIsimQD101hICG9E/bo8P
 xG88576faZslYssRIb6LS90cu7MBDhHPdOiOF7UNuftWLd1ldAQrsM0WKb+UyEJ8SEzJ8+6U
 6+ScJDNOE=
X-Talos-CUID: 9a23:piZCNmCyZu7IXFD6EyZ9/24VN9t8Tizm83TpGUmlVEJWULLAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3Ac9ojwgy3S3Mv9UK0PygbPMhlO1qaqJ+IKH0OsMR?=
 =?us-ascii?q?ah+nHLQVPCifehS6rfaZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,256,1736809200"; 
   d="scan'208";a="111889653"
X-MGA-submission: =?us-ascii?q?MDFKRN41RA1Qw/aUn1RzDJ6yj+AQ4UeaPCzssx?=
 =?us-ascii?q?0LXf0AhmE80eCZUdqoXJWzFbpyAIbtUSPSwDgxypJAAeFMObOJqhSBXQ?=
 =?us-ascii?q?mwwo1yfJvlk0yEvap2IEs/CnexCFdRdBcZwvxJmtaDk/19loos/xuCCc?=
 =?us-ascii?q?Gdh8KFjnAnJWRqeUmjuK8ASg=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 11:55:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1742295343; x=1742900143; i=markus.elfring@web.de;
	bh=d6boJSRxN0mLYlu6pwzdCyZOaYtMszoiLGTAYoiFXzc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=v1k7J6WEe45OVaX36YjGBLs+bQbQEtddAuW0d8b+KjLK1NmjzaZyNRadhliYluFp
	 /Xzfbbh/ZWABvaBOpWrpT7feSgd3jQ2Qo5qNlXasQN4gYcNoqx01IOMche/cYFehG
	 AhWW1AnensERf+CW1YwxR4gtAjQZQZzU4smihQ8vMYwiooKSkFBXQAFBzCC8PJJ/c
	 raV3dFbagrmkVBSkFL0yAKeyOLlimqU09tl0C1dnV7A/pBUhUBYSyBkd1h1NlmxUQ
	 0alf1DCTqGQx8TRTFkRZtk/+6/z6OwP0wAHuXeK+pcj2VKP6i0lYwhWrSIUPEvwAB
	 iZYbm7Fq3Fer+lIHBQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.69]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MKMA7-1tc0wr3bv5-00IZBT; Tue, 18
 Mar 2025 11:55:42 +0100
Message-ID: <5653df64-be2d-4b78-8521-070e871ea78c@web.de>
Date: Tue, 18 Mar 2025 11:55:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Olaf Hering <olaf@aepfle.de>, cocci@inria.fr
References: <20250317150941.32415-1-olaf@aepfle.de>
 <2e62e29e-b1da-4493-81a1-61ffc2489c56@web.de>
 <20250317232430.44cfc68a.olaf@aepfle.de>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250317232430.44cfc68a.olaf@aepfle.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gjN7rKN6fpqo8R0L2N88fxhtu8KeN8BRKNM9ZzxImA7Mk2IzSC+
 KWVTjp3syALu863cSZ57TpRgaeT6WU7PvMh4hTm00OtAReMaHYCYtlneG9NRGERNK0fUSMt
 xZzRl4+eTC8T6hwdZcUQnBxCLadR963FtXuTu1AxiPyNZWGISqVBdXGlkhrLUcct9Rxfe5W
 shT6EvhBm9CmB6hNJTRlw==
UI-OutboundReport: notjunk:1;M01:P0:OaFZTzFrh4Y=;4sM3YwwqqBiJFZyAUY5I5CfaDin
 iUWBE5aCZXO+y0B5TGdMnUAt8Sovclw23KidSBMNfBrKorROm4eAPpjFUlfDZxdUg8M/GhQC7
 HHGDPdoHQZnF1p7iX2ziTgCyylXS5tSpbP+FPhDefPSgwcgymx60GxE04CagVB7omvbSCkjKK
 z8XzbDWTHWkDZ7ra8bn+B7E2px9RhZDTO2btbqYAlCfYkoEYB1ilnEAcn91qCImEA2bjJz3nF
 LsGz8yXUqfvipwTePmFwOsi2ZXG4LDc3mZS20TmYNTN0Vb9lqxyXS/K2Pe5Gn1yizJYyAIx1q
 Q/wQndTiqne9iTTnLbG0MCe2IAC6Mf5IQsnVvDO7CY05Kk+U2OwqtNqGK8ieI49VB39bRlDDg
 E19q+RJG3B5oDuYBFwhzeBRiA74Q/89uKYWvh+nz2uqjcx1jFrmh3ssbzTOyxfC3BSNGGHWHJ
 VrRu1tUR6TdGr/WEztXVj8iarp5wSTlX6IEWz6z4VFMSsT25wHeEThKY+hTR8BwPA6Q0veozE
 snhg4sNEhvoK2SdWrcq9GlYFqAW7Yg6NUxFDYNc3jXfZgo/OGNwgeJy7LedxkbXXPsP0VtI9Z
 csLcE8kAh0RS5DDt/PWASgDkig0BX0hTc8pgfyvZitMjO7zpB3BqRYTiTkz+QYjYHZZcK3vGH
 eTxRqvjzDVNND9jobEsHa/PL5DRsc8TcXuUoGdfsxvgXRLA7liBmUcUb5yUu/WsOA1yAzqaa6
 tkDrPNEHVfS6eWOkkFXUMpqbpiKAbCxWX8PqAoTHrEWvBfEVO4xynadwtv5ujVI7isjiTaZeM
 JYuU9l9ObVKKlK0/7R8hZbdWJs2B1jdKaRFeY+Sa+K2NkmQYrZyK1G/HybqvRoIDcUyKx/Mr5
 Plz2d89ejkuWZVQ4dybPXyw/6NpvnJi62b2FDlHdCXyj4tOHjzLQBIee1SceazinUR8Qgba4x
 QbZQ9mqSqTPcpKKBpbZa6fOCMzI5ZSMkMnt4eYDpy0633e0AroabYiLjttjlfVEjceaI3Tea2
 SsQ1PkrrGQCKpLq0kVDahHdgBXvqGaVxjs2leMKXh9AjBVHYAhGr2O72FKVJYAg1NVtBAkrwv
 n8fRbLiIWWLCnDKgXgGYRz1ap/FWfflFWwDg5VsNAD72k+s9KsTNvptGuTGnpOMoSfHcCNSi3
 hr7Rzn8c2BOR/VP5le7wg5h5VsOnifAIt+Lpy1H8BZc27aJJXfb3aUaT83l1fpJ2x/evkGzsc
 iDP7GJeJcfxqvDWMsqHqzHCHja4VrwSLr2cY4oixO1RCo91/fKH8889wQkxbCqiQMZmb455h2
 wFHSGLkrSdZYiGv81b31npT27oz3D5+xUltEjys8ctn70AGpsHNGRHnUhzHJJyU2PSXKNLKfp
 +JK7bLsleEcpYoYWMX+FTnZ0PxLOoGmc07LAPkXtX8q48+TTCJ2X8mgvVW/mGwOWoi1iY59QP
 sfg+BJJdx8Nyyq49/VBsnG9L/5/hN6YwScSolP0DdK3qmLLQTfmr/gghJlWZE1hu32/BjKLKc
 ZfE9el7r75b3bSrvgLc=
Subject: Re: [cocci] replace pcre with pcre2
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2612
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/5653df64-be2d-4b78-8521-070e871ea78c%40web.de>

>> https://github.com/coccinelle/coccinelle/issues/149
>
> This was closed as completed. Was this closed prematurely,

Change interests and available development resources might not fit togethe=
r so far.


> where is pcre2 used?
See also:
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/4093aad2da23ea5c86916=
de0a71f43032fc2bb2f/docs/manual/cocci_syntax.tex#L543-545

Regards,
Markus
