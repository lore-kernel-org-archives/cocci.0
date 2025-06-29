Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11551C7EE39
	for <cocci@archiver.kernel.org>; Sun, 29 Jun 2025 05:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=wQZiQsUgxxxhKyC7U4PWM9mHmRnfiFCQAyu922JKKwE=;
  b=T4IVp8TTIO1x9t5Lu7doZIQBMLN31aJNvEMWBhZ9mH39pP1U/NRQIHZ5
   Q3hW5S9GGtQ5nDO0veVVY9pzWF1Yew+X3Ri2TzE2m+OcfISRvt+BauXDv
   3gK95zXnzVYnScUq1gpZDIOpocBEQpZRSwJLCx8wxjXTZsw1dCjDTs0nO
   4=;
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
X-IronPort-AV: E=Sophos;i="6.16,274,1744063200"; 
   d="scan'208";a="229446025"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Jun 2025 07:31:20 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 28C9CE0157; Sun, 29 Jun 2025 07:31:20 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id D6740E0131
	for <cocci@sympa.inria.fr>; Sun, 29 Jun 2025 07:31:12 +0200 (CEST)
IronPort-SDR: 6860cf9d_G1/cGryWJrZsD446jPQ64/pgrP2zm1CVQkF1EyHDPNnxrVk
 knU0BR/L/euhsFkqwoVniSKkLqFA8SRzIJyDoUw==
X-IPAS-Result: =?us-ascii?q?A0GkBAAGzmBogA4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?VOCRIEABlQzBAtJhFWPUIIkhDuPD4h3g1ICDwEDAQ1ECgECBAEBAwSFAAKLc?=
 =?us-ascii?q?gIeBwEENBMBAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBOwcOC?=
 =?us-ascii?q?jGFew2CYgGBJIEmAQEBAQEBAQEBAQEBHQINOkQBAQECASMdAQERJwQLCxoCJ?=
 =?us-ascii?q?gICVgYBFAEBgn4BgiEBBhABAw4kBw0GslGBMoEBggwBAQbaXh8sIliBZQMGg?=
 =?us-ascii?q?RsuhW2CZAGGJ4Q8Jw+BVUSBPIMDPoJKFwMBgV6DW4JpgiaBFoVNlABSeBwDW?=
 =?us-ascii?q?SwBVRMXCwcFgSBDAyo0MSMPPAUtHYEnf4FOHIMegRuERStPgigBe4F6QRlBg?=
 =?us-ascii?q?10eBm0PBoEhGzZAAgELbT03CQsbBj2TAoQ+FA4Cgj2jO44VlGI0B4I4gWaBZ?=
 =?us-ascii?q?AyKLZU8BhMvg3GTWw4GkwKZBSKNZZs1gX8jgVwzGiSDNk8DGQ+OIYQAM7xlQ?=
 =?us-ascii?q?TU8AgcBCgEBAwmFRgEBik+BSwEB?=
IronPort-PHdr: A9a23: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
 5cEDLNWBgVd/hIyD0N4AJodLZ0xUj52ydam
IronPort-Data: A9a23:wTDFWKxag65MtRYMzZJ6t+fwwirEfRIJ4+MujC+fZmUNrF6WrkUHz
 zYcDWqHO/3ZMWT3KYoiOtjipk4OsZ/Wm9VkSFA9r1hgHilAwSbnLYTAfx2oZ0t+DeWaERk5t
 51GAjXkBJppJpMJjk71atANlVEliefSAOCU5NfsYkhZXRVjRDoqlSVtkus4hp8AqdWiCmthg
 /uryyHkEAHjgmAc3l48sfrZ9Usx5qSq41v0g3RnDRx1lA+G/5UqJMlHTU2BByOQapVZGOe8W
 9HCwNmRlo8O10pF5nuNy94XQ2VSKlLgFVDmZkl+B8BOtiN/Shkaic7XAhazhXB/0F1ll/gpo
 DlEWAfZpQ0BZsUgk8xFO/VU/r0X0QSrN9YrLFDm2fF/wXEqfFPl5fhnXF5qZbdC98coDkgQt
 qIfdh8SO0Xra+KemNpXS8Fpgdk/atbmNsUTtxmMzxmDVKxgG8qcBfyXo4YEtNszrpgm8fL2Q
 sMDaid0KjnEbQdOPFg/F5802uul7pX6W2cC+Q7J+/JuvQA/yiRM8rLfDvf5duaSTMFrr2bC+
 3Kb/mLAV0Ry2Nu3kmbVqin82YcjhxjTXIsNHbm83uxrhVeJzyoSDgcXXB21u5GRgUm1UNN3M
 F0R4iNorK4o9UXtQMOVYvGjiHuDowJaRNdaVeE3gO2Q9kbKyw+/C2FUUWIZUoYrlZA5bGJpi
 FjXsMy8UFSDr4apYX6a876Vqxa7Ni4UMXIOaEc4oe0tvIOLTGYb0UunczpzLJNZmOEZDhnc7
 li3QMUWgrIOkYgU2q/98V2vb9OQSnrhH1VdCub/BzzNAuZFiGiNOdbABb/zs6woEWphZgPd1
 EXoYuDHhAz0MbmDlTaWXMIGF6yz6vCOPVX02AEyRsB6qmn1oyL6IOi8BQ2Swm82Yq7onhe2M
 CfuVf95uscIYBNGkIcsMtvgUJpCIVbITIS8DKy8giVyjmhZL1PXpHo+OiZ8Lkjsl04riukkN
 P+mnTWEXR4n5VBc5GPuHY81iOd1rghnnD+7bc6hk3yPj+DADFbLEu1tGAXVMYgEAFas+lW9H
 yB3bZvSk003vSyXSnW/zLP/2nhQdCZmVM+n9KS6tIere2JbJY3oMNeJqZtJRmCvt/09ej7gr
 y/jCHxLgkHyn2PGIgisY3VuIuGnF5VmoH5xeWRmMV+00jJxKcyi/YUORasRJLMHze1EyeIrb
 v8nf87bPO9DZA6a8BsgbL78jrdYSjKVuSy0MRGIWgMPJ6xbe1SR+/vPXBfeyy0VPy/m6eo8u
 +KB0y3Yc7oiRiNjLp3kV9Oy/XyMvFw2uuF7b23XKPZ9JWTu94lLLXTqr/kVessjFzTK9gG45
 S23XygKgPbrmJAk1uXJiYSvjZabI8EnEmV0R2DkvKuLbw/E9W+d8Kp8eeevfwGFcljr+a+nN
 N5n/9ulPNIpxF914pdBSZB1xqcD5vzqlb9Q7iJgOF7pN12LKLdREkOq7Pl1lJ9m5+Fm4FOte
 0e15NNlF62DO5rlHH4vNQMVVLm/+s9OqAbCz8YeARvc3zB2zoqlQE8JHhiriQ5hFpVXHr4h4
 98cvJ8x11TipDssas2LnwJFxVSqd3YgaZgqhrseIY3sizco9G18XIzhOnf2zq2iO9RoGWs2E
 wCQn5vH1uh9xFKdUn8dFkrt/Ot6hLYSskt0lHsEK1C4m4fGtMQWxzxUyyw8FS5O/yVE0sVyG
 2llDFJ0LqOw5AVVhNBPcmSvOgNZDjiL0xbV534WslbGXm+UVmDpB08sC9anpUw23TpVQWlGw
 eu+1m3gbwfPQOjw+SkDAWhetP3pSI1KxD3owcyIMZyMIMgnXGDDnKSrWGsvrinnC+MXgGnsh
 7Fj3MR0WJ3BGR8gmY8JIKjE6u1IUzGBHnJIft959qBQHW38RiC76QLTF2+PIPFyN9742m7mL
 fdxJ/B/dQW0jwePiTE5OZQiAZFJmNwR2d5TXY+zeEAnteOEoytLoaDg0HH0pFUWTuVElec/L
 YLsdAy+LFGAuEsMpUjzqJhrB2npR/gFewz2486t+sorCZ8okb9hYGMy4JSOrlSXNwprpSyVm
 Ab5Y47X0O1Q5oB+lKT8Eqh4JluVKPGicM+q4QyMo9B1QteXCvj3tiQRsUvCEzlNGLksB+RMi
 rWGteDo0HP/vLoZV37Tn7+DHfJr4fqecfV2MMWtClVnhgqHBdHR5iUc91CCKZBmlM1X4u+lT
 VCabOqybdskZMdP9kZKaiRxEwcvNIqvV/3O/RiClvWrDgQR9SflL9n9rH/gUjx9Rx8yYpb7D
 lf5huaq6tVmt79zPR4jBcx9IppGMVTmCLoHddrwiGGiNVOWoGi+45nsqRlxzgvwKCi0IJ6vq
 9aNDB3zbw+7t6z03clU+d469AEeCHFmx/I8ZAQB8tpxkCq3F3MCMf9bC5gdF5VIiWbn4fkUv
 t0WgLcKUk0RnAiocCkQJPzmWRqDQPMDMJH1K1TFOq9ShzieXOu97HlJr0+MIEuavhP8wevhJ
 dx2FrjYIE2q2p8wLQoMzqXTvAqkr882AloX9Eq7n8Ga79Pyx1kV/CQJITehnhAr3y0AeIsn6
 IT1qa15rJmHdHPM
IronPort-HdrOrdr: A9a23:ecfLWa2qPf2htxdFi0N2BwqjBGwkLtp133Aq2lEZdPUnSL38qy
 nIpoVj6faUskd2ZJhEo7u90ca7Lk80maQFhbX5eI3SOzUO21HHEGgB1+ffKlTbckWSygce79
 YDT0EUMr3N5DZB/KXHyTWZV/A93dKA7KekvuvGyWxxJDsaEZ2Ioz0ZNu6BeHcGPDWu6KBJb6
 Z1bad8zQadRQ==
X-Talos-CUID: =?us-ascii?q?9a23=3A8AHxr2lHLRCXpTkC2w7pYSiil4zXOXT7wX6APBP?=
 =?us-ascii?q?gMzxkaeKaYAHTpqQ6vNU7zg=3D=3D?=
X-Talos-MUID: 9a23:+RSMcAiBYzZ6D0rRZuOKNMMpCeVi0ZqDJEw3iZwChfikb3FgZjabtWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,274,1744063200"; 
   d="scan'208";a="229446016"
X-MGA-submission: =?us-ascii?q?MDH/i3nHPMS0SLeOyvX5l0Ob/fqR2B9bW3u4Vi?=
 =?us-ascii?q?bR9AJbV5NyXipm9vkSOT6yTa+JoPFR6CffFOo4lIOR5WN3EVsaUIW8KF?=
 =?us-ascii?q?APXlhFa5CRQF9ppwSOnPYuHcH4NcIaRCHeamAM3nuDAbD+wOQipLO88z?=
 =?us-ascii?q?HQM7YgjqFvbU1rhhfN9jfkIg=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2025 07:31:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1751175068; x=1751779868; i=markus.elfring@web.de;
	bh=wQZiQsUgxxxhKyC7U4PWM9mHmRnfiFCQAyu922JKKwE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=JE/HsglxUm/s+3KgmGtIwdn7QWoYSDT07OqcEMB0sOqXuyyAKrESk4rq1ri/N+AF
	 Z1O4MUAHpCYfLUcihDm06mHdM08mp6+e+MjxR10GpYie7UJMHFmdixG3ujLI3f6Iy
	 HvRElh043SSGkfh9ktbvhKFB90lkkggyhXuxSL3754c3Nq4pyJitdDt3MpHD3ZNS6
	 WiTTwlrv+M16wV/umkJbix/lnkcgRwvAhPVJWzFHeqrBpb9PgdM+thmnUTNICRXrt
	 NThfcoqqPn9bu7rKP2kvnfosSKu9LOFz3VMAYZP/3DZzO9J3PaOX/2q93rBAH3qBO
	 GyXn7WTQSE4b1j5ukw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.227]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MA4fW-1uPj1i0uYE-0078N3; Sun, 29
 Jun 2025 07:31:08 +0200
Message-ID: <728b184c-a7c5-41f1-8f15-b9fc139c2e3a@web.de>
Date: Sun, 29 Jun 2025 07:30:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <2038c080-a429-44bb-a572-c1f9e733320d@web.de>
 <alpine.DEB.2.22.394.2506281638300.50494@hadrien>
 <1f3bd2ed-0252-4347-835f-5fecda857cf0@web.de>
 <alpine.DEB.2.22.394.2506282132040.50494@hadrien>
 <8737f8dc-a10e-4f2f-8a50-87edc5c2aa78@web.de>
 <alpine.DEB.2.22.394.2506282142200.50494@hadrien>
 <47efbf70-5b53-4e7f-922f-b6405e240134@web.de>
 <alpine.DEB.2.22.394.2506282156560.50494@hadrien>
 <9e81fa9a-57b5-442a-a3e9-eff1a1a9d63f@web.de>
 <alpine.DEB.2.22.394.2506282320450.50494@hadrien>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2506282320450.50494@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5mPGbCsfan0QE4GggO6paSvQr/1MkZbRazcEG+doCUeI7S0PI8l
 z6jflIscHhZNWLV7RM+G13/LUWck1Q1pi73g9xEWUrYeb6SmblMpvlmQSG6OUgbSyMWa9Z5
 gy0lvI1B+cWHz9GnSJ1XheakQz/aMTWqdZXGWvik6fGfgAH+fE/nwvOB5j3VvcqaKQtg55R
 YpKXt/WOvJpdukUrrNoVg==
UI-OutboundReport: notjunk:1;M01:P0:TgaKO4Kbc00=;B62sPMwRSFKzqbKvAtve98VRCOW
 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
Subject: Re: [cocci] Avoiding metavariable confusion for duplicate
 identifiers?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2808
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-06/728b184c-a7c5-41f1-8f15-b9fc139c2e3a%40web.de>

>> Under which circumstances would you put such identifiers into different=
 name spaces?
>=20
> None.  Doing something like you suggest would reduce the expressiveness =
of
> the language,

I do not follow such a concern.


>               and doesn't seem at all like a good idea.
1. Is there a general need to distinguish member names anyhow from other i=
dentifiers?
   https://cppreference.com/w/c/language/operator_member_access.html#Membe=
r_access_through_pointer

2. Do you plan to extend the support for the C++ key word =E2=80=9Cnamespa=
ce=E2=80=9D?
   https://cppreference.com/w/cpp/language/namespace.html


Regards,
Markus
