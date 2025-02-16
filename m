Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99957C02198
	for <cocci@archiver.kernel.org>; Sun, 16 Feb 2025 09:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=q94pdTXfeGnmCO/5vrCv7KyCB6IlIsoWbABMYhZNOKA=;
  b=cabv3WqUw9or/p5YdyX130ey7lpeNCvKh/KjXK+iCVz2levUCkKXZO/j
   D5rYuvmYX0SpqT+A6+MaiPe4K70WjdFfE7iGY8wlS3raM6vx5OBpDwahU
   vpoPoGeAkZX75mKg5tRrOywTKkZpusRoN4RvlmOaMXQp1dwh25Sd4TKmB
   Y=;
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
X-IronPort-AV: E=Sophos;i="6.13,290,1732575600"; 
   d="scan'208";a="208483055"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Feb 2025 10:05:39 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A0CA1E0D1D; Sun, 16 Feb 2025 10:05:38 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id D5520E0260
	for <cocci@sympa.inria.fr>; Sun, 16 Feb 2025 10:05:30 +0100 (CET)
IronPort-SDR: 67b1aa5a_V6ROiqbcEHjr9VYNhqDYrF8lstV/yQ34RdiVGbUr5pwzKFV
 bmwBdZWJ2Vp59W7AivKqN4PQSZskxxuk69XXqoQ==
X-IPAS-Result: =?us-ascii?q?A0EuEQCZqbFngA4P49RaHgEBCxIMQIFIC4JEYnUzBAtIh?=
 =?us-ascii?q?FaPT4F0hGuHO4dTiHWBVoF+DwEDAQ1BAQIEAQEDBIIMgmoKAosLAh4HAQQyB?=
 =?us-ascii?q?w4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBOwcOCjGFew2CY?=
 =?us-ascii?q?gGBJIEmAQEBAQEBAQEBAQEBHQJHRAIBAyMdAQERJw8LGgImAgJWBgEUAQGCf?=
 =?us-ascii?q?oIwAQMxB68KgTKBAYIMAQEG2lwfLCJXgWUJgRouhWyCYwGGJoQ8Jw+BVUSBP?=
 =?us-ascii?q?AuCRzE+hEODW4JpgjOER2eJZ4hqh3uLBFJ7HANZLAFVExcLBwWBKUgDKjQxI?=
 =?us-ascii?q?4EjBTRBOoINaUk6Ag0CNYIeJFiCK2oEBYEtgjqEQ4RLhVqCEoFdAwMiAYIxc?=
 =?us-ascii?q?Hgcgx41gTmBGR1AAgELbT03CQsbBj2gLs4+NAeCOIFmgWMMn10GEy+DcAGTU?=
 =?us-ascii?q?g4GknuIQ5A6IqkMgW4BMoFcMxokgzZPAxkPjiGELcYZQjU8AgcBCgEBAwmFR?=
 =?us-ascii?q?gEBiniBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 VQIeF0=
IronPort-HdrOrdr: A9a23:9BPoLK93LimUKGe/Wuhuk+AGI+orL9Y04lQ7vn2ZOiYlF/Bw8P
 re5cjztCWE7gr5PUtKpTnuAsa9qB/nhPpICMwqTNCftWrd1ldATrsP0WKK+VSJdhEWtNQtt5
 uIGJIfNDSfNykYse/HwE2fD8sqxsWB/ZulnOHE0h5WPHtXgu1bjjuQEWygYzVLreR9dOEE/B
 Hw3KB6mwY=
X-Talos-CUID: 9a23:aj6dSWwBSu1QEUK/lIh4BgUdIe4lW0GC7U37CFSkL3Y3GbqYdUO5rfY=
X-Talos-MUID: 9a23:oSBZngWaMn7WfuXq/GfH3hNeZZhH2K+rKW8rwI83hsDYEyMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,290,1732575600"; 
   d="scan'208";a="109232106"
X-MGA-submission: =?us-ascii?q?MDGOXblmhkxl0FBKwbtIY/bNms5m3erfhjTdEi?=
 =?us-ascii?q?mRme+7XB+ffcUcBV5MdyjkEuxEEl4OlFPWrS3Wlvv89RoILzlwwhQtUn?=
 =?us-ascii?q?z3Xxf5JH4MvSF2Wbu46TatCLYVvOFpiRPtPsUE0E6YzbVgIIMPRVHtV2?=
 =?us-ascii?q?72dP9Cr8Y0KF4Y1mV8UDDWeg=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 10:05:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1739696729; x=1740301529; i=markus.elfring@web.de;
	bh=q94pdTXfeGnmCO/5vrCv7KyCB6IlIsoWbABMYhZNOKA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=i4LYz5/u1NhTor11LO9tQj4iDn42ysp3IUmUMCNMtaDzoRFIS4m1THYZaI6c3jbb
	 XUomS2yga2QHuu7GpyF6/x7ZyOsLHtt9W0BBT0/MwJEH9msT4+QcSktEVdgxtVQXh
	 vc/FL2Gm8idC8D97mpcWtGsAMzzip+ME5S771DgZoej8xeCnKuyyn22yEP2H8f4Wv
	 0J2yIh1GM3UZFAQhQY02xmfjMV86KPpqut+DMbkqFNn/xhxmxKg3z1JrZGX4YNuWe
	 T+nlMMfOih58KsVnCfco3LwB5gz/1X55cIo9C3MSAJSoz03etqJ0bssE1SPd6ozqr
	 ZY/JofhepvyK4yYdZA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.29]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MOUxu-1u0iWs49M6-00VD7x; Sun, 16
 Feb 2025 10:05:29 +0100
Message-ID: <7d25383f-dc4b-4341-a821-1560c04691ba@web.de>
Date: Sun, 16 Feb 2025 10:05:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Mats Kindahl <mats.kindahl@gmail.com>, cocci@inria.fr
References: <592e3d24-4d42-43c7-9874-8c8eb1e12deb@gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <592e3d24-4d42-43c7-9874-8c8eb1e12deb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/Tka0ORQRujiZr0+wHCBjJmi2aCFuy/iy6TZE+19zLgybnEDUmE
 hm7hJeRITw/dd+Rf/UjQZCMCGQLxstEpNzWeGXEVI8X2e8FfZvlfqjMgan4U74oEpVVgA1Z
 YdDbzAZnz9yBaXa1FQl5joa5HzmiRQcazoi240fXYP72ViemvXzYKiAohzcQCh/5jkGEVi5
 tVLW7s35ZALy1RjeVyDgQ==
UI-OutboundReport: notjunk:1;M01:P0:GqHESNJZqMg=;WqUBjHtYLLROMWVT9hHkEltIHvT
 5JaHM99JmYSg0lMF2GYlpJqHQ/h7ng31hXwZMi+8MOCRZWs/D7cl9PVLHl8uyKo54GYUFcOjr
 nnnpQOQxTbYeTcZ+vpaB4sDfAo+a2U608/qq2Uxve75mYWkf55cQ0YlSf/370eoGDrgh/LLxT
 Rex91HuISsXqz0yqZWzkXMo0weaWXhv4ymqAheEgpag7zg74YNpKvXqr55KaB0biLHkGY2LFX
 uTN6SLajg2pnY7l3excfA94EcAFqT2upL/gOPs7pzKmjiDXpmfoCPXmw0DHg253OkJiIHMSc4
 44ShLD9Uw0fdNf65ycuE8F8mwvvursPTiCmznBfjO4DRZxFBbPONDLd/ubH+J/9WLpEPOlgIV
 Zqn/MNBUcZ35G1mXAy8reOqh51AxtVkhOS6a1Vmpt/yHTDT9GHyGyGEqPRUpexBc1t+69+FPG
 40VKrbJDCXGelxwHggz6ooiIkD15qR8aXxKYce1RbWXeHBdQK1aif4B3fPee4x/D1YiYvbEnL
 Z5eqsnam624gy3kk5nZFKpr/3iI993ISEsOmYy3ZeCYHh6pF7DI+f0RpYPruNNWlHRDPtAuhw
 sDQt5QhKStiioqsZRMMU9yjhGNa7ZDyJcOEhX2p8hbJiYVccrp0SmtfuEaH1N/ssVbLXwg2Jp
 6Ha4LxQd8TpWJNi1MRQHCTQXtTllEW01i0SZrlSPZddJ1hgp/NywvQKXGbPzn+asY++u/LGoP
 YQMGFCEG203SN4tnb5QYh+0zN6nvTT7coWLCdvMl5qEmmuB5Rk/lPSgX5j93A7VYRh0cslkAD
 BoKtPzRRn1Wtv5KvCZ2ib7oi0Wx8SfWpQ8ZSdwDtIgWaLYwutgQlsBdsVW3fWdn41LJ1vW5+7
 r1c5bJLHy8bPh2P9VsRJK+//U6LuIS9xcmfuSIzYrSIu+bG7aQKRGATfdHwbsKoVWQBDxHMgF
 4a1Kfn+aXbouNifFSRKoo4AteR7M/C3L2i6xgxai9B7yUXJyUlLTJlEIS/2RczvZnhYSqxJBf
 tQqOliHQ24mFA4Cjr/NoWPmQSqAV1Eh/jNXUQgv5zI3ZamWncsuHFbWtZPjDbyi+y8n935tg1
 iQbGAj+a30VbsbF79Nrh+fPQxp7+nbUDKYdlVkGIw8PVe2hNt5ShJmJ17EuPDuo9fvHxwJ4gC
 a7YFdQM7k5n1AYNtNOHcH/BlKa38HbGlkyjhqun1seAB2jV4ItpKvYd+INtDfS1YGlAq0oV1d
 ptCfCMd51Y6OzDXtPEqG5oD3ZVzRwMY8tyNd6TtcakUBJqPyYZRYpvpKbq2ul3Oc+pee7QwiY
 PyDLjg3nU2LDjaNA8p9G33D0ZcgYPHEq0khsYd5w/Z9/s6f53NtCN+u9t9U3PfyrnxKB/c8ho
 5FPmvRyBiHRrplFLSDtBfSFZHUewXuXmpGlyN1V2PY/A8yQNVxshnifcW7dQ2Os6coQdRzftK
 JqmXsZxqrFeAuKHwHb6kdKjQVeLg=
Subject: Re: [cocci] Adding statement after declarations with zero-length
 match after
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2421
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/7d25383f-dc4b-4341-a821-1560c04691ba%40web.de>

=E2=80=A6
> However, if we for some reason return the pointer, we do not want it to =
be rewritten.=E2=80=A6

I guess that such a data processing requirement will trigger various softw=
are development challenges.

Regards,
Markus
