Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA970C369D9
	for <cocci@archiver.kernel.org>; Wed, 30 Apr 2025 14:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=cEJB9Q5Fkuhxgz8qNErRlBdu4n0EtXgJ4ZIB1eWECRQ=;
  b=R1rTnMODIopdv9y5tElTNaZAd6n+5vfhPVUYSqH2k6sqWZK02OnNseVh
   WWy0d85APjANrcr2E8FhiDBhyC80QClKzSOKzbRaXZg6oTKBxo2GGKIKv
   mVv/hBmkS2vRjjp11JiljuqyG+uxibUVD+uNCVQB19d87oclHl55kxgCi
   I=;
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
X-IronPort-AV: E=Sophos;i="6.15,251,1739833200"; 
   d="scan'208";a="220198610"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Apr 2025 16:21:29 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 43131E0D1F; Wed, 30 Apr 2025 16:21:29 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 02A23E007A
	for <cocci@sympa.inria.fr>; Wed, 30 Apr 2025 16:21:26 +0200 (CEST)
IronPort-SDR: 681231e5_gdHORR0adNP0BB+O6XDQrwD+4/CfsvdrfMfd/Av+9G4sPuO
 boNwCguO4Yj2nUvo8xWAw7B1WdmHkDXixxM0gvg==
X-IPAS-Result: =?us-ascii?q?A0GfAgB8MRJoeAwR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?VMCgkKBVzMEC0iEVY9QgXQwhDuHO4dTiHaBaYFqDwEDAQ1BAQIEAQEDBIR2C?=
 =?us-ascii?q?gKLNAIeBwEENQUNAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABQ?=
 =?us-ascii?q?w4KMYV7DYJiAYEkgSYBAQEBAQEBAQEBAQEdAkdEAQEBAgEjHQEBESYBBAsLG?=
 =?us-ascii?q?gImAgJWBgEUAQGCfoIwAQMOIweyXYEygQGCDAEBBtpcHywiV4FlCYEbLgGFb?=
 =?us-ascii?q?IJjAYYng0J6Jw+BVUSBFSeCUjE+hCkag1uCaYIxgRaNOZBnUnscA1ksAVUTF?=
 =?us-ascii?q?wsHBYEmQwMqNDEjDzwFLh2CEYUhghGBXAMDIgGDE3Qcg0aBI4RQLU+DL4ICT?=
 =?us-ascii?q?hpEI0ACAQttPTcJCxsGPZY/g2SBCYJpRsVsNAeCOIFmgWQMn14GEy+DcAGTV?=
 =?us-ascii?q?Q4Gkn2YfiKpE4F/IoFcMxokgzZPAxkPjiGEM7sEQTU8AgcBCgEBAwmFRgEBi?=
 =?us-ascii?q?nyBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 VUIqat4rI1XhKI//QuMu5KYJf3BgA7S8g==
IronPort-HdrOrdr: A9a23:/7MuRa88B2jxvHYQLehuk+AMI+orL9Y04lQ7vn2ZhyYlEPBw5P
 re+MjzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNCftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIObeEYZmIbsS+V2njaL/8d4J2g7L2ig/vYwkxgVAdwdshbnnpE40qgc3GfX2N9dOEE/X
 enl7B6T7HMQx4qUvg=
X-Talos-CUID: 9a23:YKfU/WEqfr10X1ORqmJrrHAvCu4+f0eFzWrVCFW8GXd0dLCaHAo=
X-Talos-MUID: 9a23:yKUd5gVs9rNB4Sjq/DLFngw5NcdF36CVKUMjqrIp4efcJwUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,251,1739833200"; 
   d="scan'208";a="220198593"
X-MGA-submission: =?us-ascii?q?MDGWTkcTFkQSM8xUXDmjne4LijfW4EF/kT41Q/?=
 =?us-ascii?q?VlQNIRpseSZPBl3dnKCra8IxzlvZpjcURcRbmv1xbR0QZxQeIobLuaqu?=
 =?us-ascii?q?+lm+hoMPWBtNmCJcdcaSVP8rM3Wcg9mpx4J+0aOFtv1bVVKET+iXiHnU?=
 =?us-ascii?q?2bKSXRL24rixD7zh/sC3fAuA=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 16:21:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1746022885; x=1746627685; i=markus.elfring@web.de;
	bh=cEJB9Q5Fkuhxgz8qNErRlBdu4n0EtXgJ4ZIB1eWECRQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=V4k+YjWVL0FYUINERBbJqNmHfjfcFCpnd2RzfsL6KZfWGLbCzIpJhferF8Jf2nJm
	 pZwjaNKrbcTXG88BLfNsOZ/5PxHJkSNH6U4HayeBLZHRw1wD2iUrV3/2JbwIhTnoW
	 Vrz7AkWcW3y6SC4Ft+AQmHEm8dhEkOvNebdbOzEPAaq8Qb7MRH/VxrZU8IxEZLvXB
	 c72Uc/C7IhmK3Z1P3eQ1Rcmv+XWnxKSTJP+iBzQI/9ffEBeKXYsyP9tzU3IQqyYVa
	 EJj9HgcCK76+Xl/Inu+V5emkmHK/sjCa7SCv7CEU074tFtTiE9qRlHWtktZc361n5
	 x/Og3DsLa9LpVIEusQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.59]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mrfp8-1uov6e3tSe-00m4db; Wed, 30
 Apr 2025 16:21:24 +0200
Message-ID: <168d3944-871e-4a08-9bfa-b1a1f597e93c@web.de>
Date: Wed, 30 Apr 2025 16:21:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Dan Carpenter <dan.carpenter@linaro.org>
References: <09b11b9c-21af-4c9d-b818-b0029bca5b9d@web.de>
 <101ac934-7955-4266-4691-d834aec286c@inria.fr>
 <9c26bec1-887e-48dd-a72e-20dd13e41a95@stanley.mountain>
 <825f5062-6790-217c-4c57-d4b5b13c38d5@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <825f5062-6790-217c-4c57-d4b5b13c38d5@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GAA0nFCIDad57ELX5itFohDCqA7s5MG3d/ga6GJIjrUP52YLhj0
 +kAkDAqfzkIxEvdFfobZpfUss6Slrn0qmP2DICqd2F/8Do8IEAUzJFOAuEY5/0nzuVL//Zx
 XnRJJEfwoo6M45i84v0lr4Bm3ney50gLCGpJbv0Q6wtxEdToB4fibaBLVD1A0uMPq9yZJN2
 W2tZZTPmFA4QhEEXQgs9Q==
UI-OutboundReport: notjunk:1;M01:P0:IhPAVt1te8s=;JP2v81+HlLj6gykG/gTK+r1Rewf
 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
 feQ9rwDs1zSnfLsUNN01N8=
Subject: Re: [cocci] How to delete selected redundant null pointer checks
 with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2730
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-04/168d3944-871e-4a08-9bfa-b1a1f597e93c%40web.de>

>> Any NULL checks should be removed, I believe?
>=20
> That's not what Markus asked about,

I tried to express something in this direction.


> but one could do that similarly.
>=20
> - pointer =3D=3D NULL ||
>   ...
I would prefer to use the operator =E2=80=9C&&=E2=80=9D (logical AND) for =
the shown test case.
Can it eventually work better?

Regards,
Markus
