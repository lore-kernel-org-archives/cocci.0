Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C889FCE8E91
	for <cocci@archiver.kernel.org>; Thu, 24 Oct 2024 16:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=lLndr8TJZ3Rc1N8o1/AB1dqRjlv/agHr/AfSVMmHfGQ=;
  b=Bzp6xiVpqcMywYRWqtHOo9ZKUcTiWjipr8vvJfGkKGks7O8AoOAGzCVC
   2wU0i3ukMxnnuB5JWq1nS3MKaxu7Stx4a1FVrgkumKjdfZlGl6fcwThoQ
   VpSt+/jxXH4u5dqNd1iEvrVhJxz4h5ol8h2Km7ZJd6YCsKfKUvixHysq4
   M=;
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
X-IronPort-AV: E=Sophos;i="6.11,229,1725314400"; 
   d="scan'208";a="190602564"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Oct 2024 18:07:23 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 20F5EE0D1E; Thu, 24 Oct 2024 18:07:23 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id B3F31E013D
	for <cocci@sympa.inria.fr>; Thu, 24 Oct 2024 18:07:17 +0200 (CEST)
IronPort-SDR: 671a70b5_qQs77K+1ekUW7qbOdUVeqlfUGYgND1hzA2aYhWIdQZvINNe
 CXMgzuz7IvkTXjaOZCOMtRVYZkvsS5b0aULBLyg==
X-IPAS-Result: =?us-ascii?q?A0FcAABScBpn/wwR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UAGAQELAYJDB1t1MwQLSIRWj02BdDCEO4c6h1SKS4F+DwEDAQ1BAQIEAQEDB?=
 =?us-ascii?q?IIMgnQCiiQCHgcBBDEIDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGA?=
 =?us-ascii?q?QKBCggLhTVGDYJiAYEkgSYBAQEBAQEBAQEBAQEdAkdEAQEBAgEjHQEBESYBB?=
 =?us-ascii?q?AsJAhoCJgICVgYVAQGCfYIwAQMOIweTa5xEgTKBAYIMAQEG2lsfLCJXgWMJg?=
 =?us-ascii?q?RouAYVpgmIBimAnD4FVRIE8gks4PoRDg1uCaZIJhWBthg9Whx5uh1CKElJ7H?=
 =?us-ascii?q?ANZIRMBVRMXCwkFiTUKgxwpgUUmhBEIgSsTg1+BZwlhiEKBDIE+gVkBgzhKg?=
 =?us-ascii?q?0yBYQU4SYJNak43Ag0CN4IkgQCCT4ElBAWDPIEpHUACAQttPTUJCxsGPa4bg?=
 =?us-ascii?q?nl5J39Wji2RJacSNAeCOIFlgWMMmFGHBAYTL5dADgaSeJh3qSCBaAE7gVkzG?=
 =?us-ascii?q?iSDNlILDg9YjUmELcoMQTU7AgcBCgEBAwmFRgEBiVlqYQEB?=
IronPort-PHdr: A9a23:0VPWMxBp4YoNp0Rntf/DUyQUAEkY04WdBeb1wqQuh78GSKm/5ZOqZ
 BWZua41ygWUDM6Cs6IMotGVmp6jcFRD26rJiGoFfp1IWk1NouQttCtkPvS4D1bmJuXhdS0wE
 ZcKflZk+3amLRodQ56mNBXdrXKo8DEdBAj0OxZrKeTpAI7SiNm82/yv95HJbAhFiiaxbalsI
 Bi2qQjdudQajZdhJ60s1hbHv3xEdvhZym9vOV+dhRHw6Nuu8pV+6SpQofUh98BBUaX+Yas1S
 KFTASolPW4o+sDlrAHPQgST6HQSVGUWiQdIDBPe7B7mRJfxszD1ufR71SKHIMD5V7E0WTCl7
 6d2VB/ljToMOjAl/G3LjMF7kblWqwy9qRNh34HUYZmVNPtgcaPbYdMaXndKUsJIWyBcHo+wc
 44DAuwcNuhasob9vUMDoxiwCwajCuzh1yFGhnH206Ak0esuDQ7I0Rc8H9IXqnnYsMn5OLkQX
 O2z0aLGzS/Db/RT2Trl74bHaAohofKRXbJrbMHfxk0vFw3fjlWRr4zlMC6e2+MKvWeB9epgV
 v+vi3U9pw9+pjivyN0siojPhoIa0V3F+zt2z50vKdKlVkF2eNipG4ZfuC+GLYV5WN8iQ312t
 yYgzL0LoZC1cScLxZg7xxDSdvKKf5SW7x7/SuucIip0in15db+/hRu/7VWtxOP8WMSwzFpHs
 yRLn9bSunwQ2RHe5MqKR/l780y82jiPzxje5v9ZLUwqj6bXNYAtz7wqmpYOs0nPBDL6lFvug
 KKSeUgo4Oal5/n9brjlu5OQLYt5hwH4P68zhMG/Bfk4MhMSX2eF4+Syybzj/EznT7hSkvE7l
 LTSvorAKsQBvKG5BhdY0oY95Ba7CDeryNEYnX4aLFJZYh6GgZbmNErULP/lE/izm1WskDF1y
 PDaJrDtHIjBImbZnLv/Y7pw6VRQxBcxwNxF+p5YFKkNIPfpVU/wsNzYAAU5Mwuxw+v/D9tyz
 JkeWWGSAq+CKq/cvluI5uw1I+mNYo8Vty3wKvY76PH1l3M2hEEScbGv3ZQMcH+4BOhpI12FY
 XrwhdcMCXoGshIkTOP2kF2CTSJTZ3GqUq0g4TE0FJ6pDYbYS4C2gL2B2T+7EYdMamBHDFCMC
 3boeJ+eV/cCciLBavNmx3YoWKKsSMcEk1mMswn30PAveubZ4CAbnZHl08Ny6avYklcv9monI
 d6a1jSoRnt3g3hAajs4xqF5rgQp716Z0rVjxdFcG8ZS4fxhTQowc5LRmb8pQ+vuUx7MK4/aA
 G2tRc+rVHRoFopZK74mZk98H4/nlRXfx2+wBLRTkbWXBZsy+6aa3n7rJs87xWyVnLI5gQwAR
 c1CfXajmrY57xLaUqvAiUaEjOCHcaoG3SjC3HiOxyyCsRIQSxZ+BJ3MRmtXfU7KtZL870LGQ
 aWpDOECOxFC1NXEB69EcNzvgn1ZSf2lNNmNK3mplTKWAhCFjqiJcJKse2gZ23DFD1MYlgkI4
 XucHQ05GzvnvG/USjBjfb72S2Xr9+Q26HayT0tuihqPc1Ukzb2+vBgcmf2bTfoXmLMCoiYo7
 TtuTh672JrNBtyMqhAEHu0UaM4h4FpByWPSthBsdp2mIad4g1cCcgNx90rw3hRzA49EnIAkt
 nQvhAZ1LKuZ1htGeVb6ldjVM6fUN3K00RShca/Q1XnB3dzQ9qpOoPU0plP/vR24Q1I4+iYv2
 N1U3n2Ao5TSWVBLC9SrCBlxrkc8/uuJB0t1r5nZ3nBtL6Su5zrL2tZzQfAg1g7lZdBUdqWNC
 A71FcQeQcmoMu0j3VazPXdmdKhf8rA5O8S+er6IwqmuaaxFlSilkH8BzYRzyEOK+AJjR+SO0
 5tPkJT6lkOXEizxilusqJW9vIleZiwJWEe7xzLlAoF5eaB4O4oGQzTLQYX/1pB1gJjjXGRd/
 VioCgYd2cOnThGVakT0wQxa0Ul/TWWPoSKj1HQ0ljgoqvDaxynS26H4cxFBPGdXRW5khFOqI
 I6ujtlcUlL6JwQukRKk4w79yc057OxaJnPQXFwOUiz4NWBkXYOvu7DEb8MH5J4zsCpRWfixe
 hjAE+S7+UFFlXq8WTIEjDkgPymnoJD4gwB3hAf/ZD5ooXzVdNsxjRbT6drAROJAiz8PRS12k
 z7SVRC3O9ik+8nRlo+W6LnkETj7CdsKLm+yl9Dl1mPz/2BhDByhkurmn9TmFVJ/yirnz5xwU
 i6Oqh/gY47t3qD8MOR9f0AuCkWvjqgyUox4jIY0g4kdnHYAgZDAt18Oi2TuKpN23azkbXwCb
 SEGyZjZ7UK2vS8rZmLM3I//WniHl4FEbsO5f3hQ9yYz9cFMB4+L4bYCkSY/8T/a5UrBJPN6m
 Dka0/4n7nUX1voItAQaxSKYGrkOHENcMH+kh1GS4tu5tqkSeHe3fO36yh9lhd74RuLnwEkUS
 DPjd5wlByM18shvLAeGzijo8o+9MNCCaNUOqluLnh2Gg+UdIcA0kecWwDppPnjitGcpjfE2h
 1pi0PTY9MCOeWBq4b78CBlFMDb4Idwe8HfhgO5XzMORwpzqFY5rBzEIGsLhS/7xVjkVsJGFf
 06HQjg7t2veEqHUGhWHrh5vqX6WVZusMjmBLX0dh72OXTG7I0pSyEARVTQ+xNsiExyygdbme
 wF/7ywQ4Vjxrl1NzPhpPl/xSDWXogDgcToyRJWFSXgepghf+0fYN9Cf5eNvDmlZ+JOmtgmEN
 m2cYUxBE2gIXkWOA12rMKOp4JHM9O2RB+z2KPWrA/3GsetFS/KB3o6iyKNj+CuQcNqCND9uA
 rxz20ZOW2x4B9WMmzgLTH9y9WqFZMqaqRGgvyxv+5rmqrKxAl2pvNTJUuEBVLcnswq7iqqCK
 eOK0SNwKDICk4gJ2WeN0r8UmlgblyBpcTCpV7UGry/ECqzKyco1R1YWbT1+MMxQ4ucyxA5Ib
 IT+g8n2y6U+o/o7EVZDWnT+l8vvacFAcATffBvXQV2GMriLP2iB28bsfaa1UqFdls1RsACs/
 ymWGQnvM37Q8luhHwDqOuZKgiaBORVYs4zoaRdhB1/oS9f+YwG6Ott65dXZ6aI5jDXGODxFW
 dCZW1xApPuc4HEA6h2eM2lG82YjMuSO3SqUvbGwFw==
IronPort-Data: A9a23:JKkSsK1qvEoJ3UQb3PbD5cRwkn2cJEfYwER7XKvMYLTBsI5bpzAAm
 GpLCm2HPvqKZGbzKot2PNy/8hgBvcLSytRlGwVq3Hw8FHgiRejtVY3IdB+oV8+xBpSeFxw/t
 512hv3odp1coqr0/0/1WlTZhSAgk/vOHNIQMcacUghpXwhoVSw9vhxqnu89k+ZAjMOwa++3k
 YqaT/b3Zhn8glaYDkpOs/jf8Us14Kyo0N8llgVWic5j7Ae2e0Y9V8p3yZGZdxPQXoRSF+imc
 OfPpJnRErTxon/Bovv8+lrKWhViroz6ZWBiuVIKM0SWuSWukwRpukoN2FXwXm8M49mBt4gZJ
 NygLvVcQy9xVkHHsLx1vxW1j0iSlECJkVPKCSHXjCCd86HJWyHmwfBiPUQNBNEz9MpnXiJgy
 cxFGD9YO3hvh8ruqF66Yuxrm9hlM8Theo8S0p1i5WuAV7B8G8+FGvqMvIUwMDQY3qiiGd77b
 tAadCEpQRDOeRxJNX8IBZh4kOrAanzXKmwA9grP+PZri4TV5A5Y7J73INDrQ9OtZ9hljnq7g
 iH7w02sV3n2M/Tak1Jp6EmEjejEliLTQ5MXDLT+9/hwgVTVyHZ7NfENfV68vOX/lUO0Hd5SQ
 6AJxhcTQWEJ3BTDZrHAs9eQ+hZoEzZFMzaMO4XWKT1hy5Y4Jy6cAXUYCCFMYpoquafagNDsO
 kChx7vU6f5H6dV5ik5xMp+LoDn0NSV9waoqe3ofVQVcizX8iNhbs/8MJ+qP1Iaqg9ezFTyYL
 /VmasQhr+17sPPnHJlXMbwKb/xAa3QJosMICt3rY1+Y
IronPort-HdrOrdr: A9a23:3j0y4aiqKtjXcQadYl8GrSKdMHBQXg4ji2hC6mlwRA09TyVXrb
 HIoB1p726QtN93YgBZpTngAtj4fZq4z/VICOYqUotKMDOW3FdAabsSi7cKoAePJ8SdzIJgPM
 5bGsASNDSzNykZsS+Q2mmF+rgbsbq62ZyJwcHD0nxqUQZmUK146RxlYzzrb3GeCDMmOXIjfq
 DsnfavSgDQA0j+5amAbEU4Yw==
X-Talos-CUID: 9a23:SOwbXmHBwqGH40cgqmI9/kwRFvEgSUSB53n8MxD7J1pZFY2aHAo=
X-Talos-MUID: 9a23:kxzPwQs3q5YfvvYzrc2nhhheEt146ZqXB2cvjKUWh+qgdhFMEmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,229,1725314400"; 
   d="scan'208";a="190602544"
X-MGA-submission: =?us-ascii?q?MDH7GTfs0vWfocAnGVRVPFLTo6GQd7y0TGslPB?=
 =?us-ascii?q?Ps5pnFFCrrZoKOm1hC2Bn3vemw+g5TA9H+xk3frcH8zwHKCMEJS7Cqlb?=
 =?us-ascii?q?nYAHBnwlWKfwfxG1BVQMsFRoKIRn380/hPyHHFS/slJkPk2L8x8XgQFn?=
 =?us-ascii?q?B4TQxSW83K9c7UkvE7jbOJow=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 18:07:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1729786026; x=1730390826; i=markus.elfring@web.de;
	bh=lLndr8TJZ3Rc1N8o1/AB1dqRjlv/agHr/AfSVMmHfGQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:Cc:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Ml17imOWeCggicZ3RTw5/vloDkCd2PgqZ08c5o6UnSsh41BvBS2qepIs/hHZvagP
	 WEq8+fol3QW6UqBjOxQWt3CWE4mIfGK49VcwWnlDzsL7syAq7C7jMZ6Y7ylRPKx6t
	 NovUrjJ2GdUfZImDj/9VrM5FjfmLGbTPA3aFoOpH6bkVlSZsC4wqGLGAS6yrqXEXA
	 9zZef78boIiv5t98CPnpE62SXiM23lTDgh/4OJ5MsbPmMFcsCqEnJMACfBzTHLmtD
	 ePjBqBaRenm5SyfGPRVZcOAR25zb46UanBS4mOQsgv5iA+0iDWy8+Ysd/cwS/4YW7
	 KRl7Mcu81j+Dwahv1w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N4eGT-1u4T2T2xrr-00vtmh; Thu, 24
 Oct 2024 18:07:06 +0200
Message-ID: <95d1401a-bc19-4ed8-b6aa-389e2f6f4d04@web.de>
Date: Thu, 24 Oct 2024 18:07:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Derek M. Jones" <derek@knosof.co.uk>
References: <11e0e0d6-a20f-4740-adb0-2f72b79df5e8@knosof.co.uk>
 <alpine.DEB.2.22.394.2410241646040.3352@hadrien>
 <de874a79-09cd-49cd-bfe4-b5efff4b7e57@knosof.co.uk>
 <alpine.DEB.2.22.394.2410241728210.3352@hadrien>
 <4872cc2f-3ca3-4bfe-b48a-ebbe5ab8a534@knosof.co.uk>
 <alpine.DEB.2.22.394.2410241736480.3352@hadrien>
 <3d11c8fb-6503-4a29-8889-03a91ca14088@knosof.co.uk>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Cc: cocci@inria.fr
In-Reply-To: <3d11c8fb-6503-4a29-8889-03a91ca14088@knosof.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TMDnOu0UDuuJ8gNUYj0lFfVlkZ25lmnKbPLYXrJxyykgrc1xIBH
 6OlZfcfPFpRS5hzDUBZdHtUzsUQJm1srmPVlgqPeNoWt8bgGfA2CHExzTm4rpeC3XeC+mGE
 /nI1Kvyb2iBtrsY/cco9CS++HWs8m/u5+NzYu0yGyVpk/E5JnJVj2EN1bcujV2+Et6mK4rY
 QZCtllElElEFw1LJseoqw==
UI-OutboundReport: notjunk:1;M01:P0:6Uw403j/ygM=;fLqqZmg2CeHwu/+7VggY7J8uBTP
 EGii+JLFp2OIHptwnSEYxdbgV2TUp4cAmvwOxZetj1UaxC9mc3CduYRnDp7XPXQff7ds94wYd
 fPgFFWbHlubWl96oStyABTIZEYO2xME9C9YWhtpKM0XU+UxRWajig0prA6ApcEFxlWDrGw9bF
 3i03QaOqFlRVGKgbwU1FXHIdAFgHXC3a6fUhRY0sFC4OzAfjx6t1Zs4s900LCigjofMbg1YKE
 /nDiRk4mUE3Crur57riBvLd/nPErJy7ZGWZM3MUkFhFpmCifpmDvuwkS8bCmlcCRK4w0hUxjn
 9CLTYcdV3APTRisIN64SaMbRNoS/gP/vFIF4Ia/1QZuUHJe0+NsVDicN8gEdNtpe+zcNxQg4k
 NqcY0AFqe68iDin2LBsZ2DfisW0qfHJ90TP+QDMKlByXPeJe0rGxedCskWuaq0hrJ9VjJLauo
 8hNDjH8F5jdzihmp+EpjI169Vb74YPZPAmDEI1T4s/VY4kqm0BDuhZA4WkO3OLr47zhlw+k8U
 WGpafrvv9XX7abJdOiT/EZzLmmjL3AHp4TYbYptFQjQxmlwL5Eu5cJ6IbXNOSn2pC+ED6K+b8
 zk5giru3oPFKoaJptcmcwnfcTExwmgo/Cn3oXeQAPs7B4X7ajr3Rr588aHD9MRASp6okx+v1i
 gS3TJoqPgQfneA7CLvVy9GGzb2zrZ24elZ82+oWzfIb1rD5uroWz4t5wWZ3IkZkwfr+fu6R5m
 bu2VqsmWK5zzMqAWqpHtCYsqp0LQ3Ao7M0uJrqOLx2E7hY0MOxKQdeXCY/ZSsH0KJu4EPr7at
 I8JjxOUJPlo142usVXePpZxw==
Subject: Re: [cocci] Multiple returns significant performance impact
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1928
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-10/95d1401a-bc19-4ed8-b6aa-389e2f6f4d04%40web.de>

>> ... when exists
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 when any>
>> might be faster than what you have now.=C2=A0 But it will still b slowe=
r than necessary.
>
> Just tried
> ... when exists
> on a couple of files that timed out after 600s.
> The reported time was 0.209s, so it's a lot faster!

Such an effect on the software run time characteristics is nice.

Will a program parameter like =E2=80=9C--no-loops=E2=80=9D be also helpful=
 another bit?


> I will kill the run that has currently taken 16 hours, and
> still going.
>
>> Every position variable contains complete information about the enclosi=
ng
>
> Thanks.=C2=A0 This will simplify the scripts.

Will the attention grow also for a specification like =E2=80=9C@finalize:p=
ython@=E2=80=9D?

Regards,
Markus
