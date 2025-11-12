Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41165CCFA1A
	for <cocci@archiver.kernel.org>; Wed, 12 Nov 2025 06:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=qr8hi0CjJJ5N1Cjuco7530OiWMIbYavs3t5gIRedf0I=;
  b=MvAL4Dn4mMJWELmBKToXPtEm7G4XteW/AIzdyR5fOU8itrhBNVpYMdLM
   sbj2JbMpm7QP+dP2Wy2NYw8JOGBNoD9f/vWO5U+TekxjtR2RIEJvsZoZz
   fvroUEUjNV/SHFXE0ZOwFnDm20TgZfsS2R2mG5cnWDiBLel8jGYmMXri6
   Y=;
X-CSE-ConnectionGUID: Vg4p4dSZRnuzHNLT0ywozA==
X-CSE-MsgGUID: RuO0gi1UTPCQGOJ2iiSoSA==
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
X-IronPort-AV: E=Sophos;i="6.19,298,1754949600"; 
   d="scan'208";a="248653131"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Nov 2025 07:13:00 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E9C67E0BE9; Wed, 12 Nov 2025 07:12:59 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 8C69DE0171
	for <cocci@sympa.inria.fr>; Wed, 12 Nov 2025 07:12:53 +0100 (CET)
X-CSE-ConnectionGUID: dAB6z23sQLuDfmfKhKYteQ==
X-CSE-MsgGUID: ldSspofQRQy3IhisS+aSng==
IronPort-SDR: 69142555_frQLfEnVkIvdBen1d81agcsZHKQZ89fwV1XHTCw2Yx2vJ18
 bSjKH4w4g83VF50Qxhi1Qewuc6qmhnWaSGOEqtA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FVBAARJRRpeA4P49RaHgEBCxIMQIFFC4JAZSNYMwQLS?=
 =?us-ascii?q?YRVj1OCJIQ7hzyHVYpOgX0CDwEDAQ1OAQIEAQEDBIR3CQKMWwIeBwEEMQgOA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABQw4KMYZPDYJiA?=
 =?us-ascii?q?YEkgSYBAQEBAQEBAQEBAQEdAkdEAQEBAgEjHQEBESYBDwsaAiYCAlYGFQEBg?=
 =?us-ascii?q?n6CIwEGEAEDDycHr1GBMoEBggwBAQbaXx8sIlmBZAmBHC6FboJlAYlseicPg?=
 =?us-ascii?q?VVEgTwLgkcxPoRDg1uCaYImgQ6RBAaIUFJ4HANZLAFVExcLBwWBIEMDgQsjD?=
 =?us-ascii?q?zwFLR2BJCIfGBFgPRdAg0kcBmgPBoESGUkCAgIFAkA6gWgGHAYcEgIDAQICO?=
 =?us-ascii?q?lcNgXcCAgSCGX6CCg+JW3ICAQttPTcJCxsGPZUOhjo5xj00B4I4gWeBZAyfb?=
 =?us-ascii?q?AYTL4NxAZNgDgaTBZkGqUGBaQE4gVwzGiSDNk8DGQ+OIYQzv2lCNTwCBwsBA?=
 =?us-ascii?q?QMJhUYBAYxWgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:HyCDua90oi3mDRYWiEZuk+AMI+orL9Y04lQ7vn2ZhyYlEPBw5P
 re+MjzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNCftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIObeEYZmIbsS+V2njaL/8d4J2g7L2ig/vYwkxgVAdwdshbnnpE40qgc3GfX2N9dOEE/X
 enl7B6T7HMQx4qUvg=
X-Talos-CUID: =?us-ascii?q?9a23=3AmhwNTGs2JEsqIt0eb0bQUQpi6IspW1eD3i2LOHa?=
 =?us-ascii?q?cFEpnTbO2SXyh5K5dxp8=3D?=
X-Talos-MUID: 9a23:y9rVpwgcNkXdNkUwLBqBosMpMMtT+LypBnk3qIRdmsmFLhczMgybg2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,298,1754949600"; 
   d="scan'208";a="248653114"
X-MGA-submission: =?us-ascii?q?MDEqRSVFNcs7Lui0Kr6wk4iSogWm2oCMVK3LCy?=
 =?us-ascii?q?uJR30uucN7Dq5O3rkEjZAZtDEdnSoap4LMuxhZpilMQ0jvNZvO8bMS9x?=
 =?us-ascii?q?mWA5gxszEhvXTY4rNv0zq1bUrZKcT0P/DWU7rG+Cj8mfN+csVcbe/qeG?=
 =?us-ascii?q?0XjKdTAIB+srsK/I2MDIyhTg=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 07:12:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1762927956; x=1763532756; i=markus.elfring@web.de;
	bh=qr8hi0CjJJ5N1Cjuco7530OiWMIbYavs3t5gIRedf0I=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=JTxRV1rM/o6/9f9j9otFjJlIRkMO/mC8gqDS95aB9RAKbf8iJrj5Pkmwb1/ytSAZ
	 Atxgh7kYHWGU7C/scEpw5yohIZMYtST9SiOsEWE5+knKPtCrb+WovGjrqXZ5PCmFM
	 meNhwWcRdxFuM+kqKF0Af585UAjR+9qfoVzGK0LiwFloOeMvpflZaJy6KN2JtSXFS
	 Gr30CT5MjbXo720uYGuroJXHDyhNwo35My7chWCqApmNxo2EQY1FZQOCAp4NFEdXw
	 0MWpk679ZfLre5UOZDFQQZrvcQCpsP45UimPBD+wae5KcdXkJxsv7/2B/r9CrAtX0
	 zChGs9SzTxVkjTUwOA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.246]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1McIki-1vtVNI2lBs-00fKlG; Wed, 12
 Nov 2025 07:12:36 +0100
Message-ID: <2c82cd3e-6190-4f6e-ab86-5eb047349f04@web.de>
Date: Wed, 12 Nov 2025 07:12:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <ca1862a2-8a84-49b8-bbfd-fca9f15c6787@web.de>
 <c5aa7f4a-4efc-5384-3295-823dea0ea10@inria.fr>
 <92736910-a93f-4a91-9356-f6f6c1aebd8b@web.de>
 <3177bcc9-773-393d-edf4-8fb67a59115@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <3177bcc9-773-393d-edf4-8fb67a59115@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7X1q5EwUzG3/0MOxC9ySKYkZwn3G2tOYsHZlwNi0KZu39tw/96o
 yGeDlx+PGsKQG3lIMWO4rcFOYsHyb7BQ1IUWVTXWf+uTsg+0rq7Z0Ab+10Ie9WBKfhTZQcO
 74XTQVEPSjIdViITQ4Mdnv7nsW6BJKohAIuiMkhO0y22A4t2utzruUIOEOjMeBFDvyZjuEh
 JUCukP9krOmrBKJcgmgtw==
UI-OutboundReport: notjunk:1;M01:P0:maPlvle1V6M=;jHBdUr5V0u2qwfPnRV7BCyEfs1x
 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
 4jOXAS5Gd8c2JoROZObzjnHe9c=
Subject: Re: [cocci] Checking SmPL support for two special expressions
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3166
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/2c82cd3e-6190-4f6e-ab86-5eb047349f04%40web.de>

>>> Coccinelle doesn't know these types.  You have to declare them with ty=
pedef.
>>
>> Are type definitions really required for the handling of casts?
>=20
> Yes.  There is a potential parsing ambiguity otherwise, I believe.

How interesting is it that I can recognise casts also without extra type d=
efinitions?

Regards,
Markus
