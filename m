Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB38BC30653
	for <cocci@archiver.kernel.org>; Sun,  7 Jul 2024 13:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=xB2JIsjbv0Fhuqq5EnN9Sk4WS6OW8DsqBLF1WAfPjyM=;
  b=tI9BDDZE8LWNEFPefIVK6VK19U9ppqSDQsn/OxjwOJpyTWeZ5J1V0jt4
   MGjl0N/ypeXh+B1xd5aX60zaDayfMTy6iSdterZj5yTGiRm+y8zZyEwmW
   umzJpGPDxYEVo7t8hBR7Tn4SzHySAUN9pegkcGHxaKGkag8QeVyjgrw/W
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@sang-engineering.com
X-IronPort-AV: E=Sophos;i="6.09,190,1716242400"; 
   d="asc'?scan'208";a="174321501"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Jul 2024 15:32:24 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C88A6E0CCA; Sun,  7 Jul 2024 15:32:23 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id D1459E004E
	for <cocci@sympa.inria.fr>; Sun,  7 Jul 2024 15:32:22 +0200 (CEST)
IronPort-SDR: 668a98e6_vWeswuItx5SbtRdS5Up+O68E1IEEtfFd+uZ5HXIh07BL9UI
 GLA8oQLu4UnW1YpuugedJaNsIaVsakmCiC76cMg==
X-IPAS-Result: =?us-ascii?q?A0E4AADcl4pmkCH+dcJaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYJDgVUxAwcISIxzX4hRIIV6jGuLKYF+CAcBAwEIBUQEAQEDAQOCC?=
 =?us-ascii?q?4J0AokTIAYBBDAJDgECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGAQIQA?=
 =?us-ascii?q?QEBAQEBIB4QCgQnhXQNgmcBgQWBEQEBAQEBAQEBAQEBAQEBIisCgQsBAQECA?=
 =?us-ascii?q?UABATcBBAsLRhBGBgqDCQGCQSMHrVaBNIEBggwBAQbcHYFcBwmBSAGBVoZPC?=
 =?us-ascii?q?wGBU4dveoJPhD8+hAqGfZlVghaJcSYLjHtUgRcDWSETAUsKNVsCFgMbGDAPC?=
 =?us-ascii?q?QsmKQY5AhIMBgYGWTQJBCMDCAQDQgMgcREDBBoECwc4P4FxgTQEE0QDgTeJb?=
 =?us-ascii?q?wyDLSmBSyeEZWyEAIFrDGGIY4JNgWOCf4EVhFMdQAN4PTUUGwanPS+BEYV+y?=
 =?us-ascii?q?S2EHqIRg18Bk1WScphponyGD4FnOoFcMxojgzdPAxkPjiEZg2HLdUQyOwIHC?=
 =?us-ascii?q?wEBAwmIbjSBSgEB?=
IronPort-PHdr: A9a23:YLbfphKFg5Ke3EDB1dmcuM5sWUAX0o4c3iYr45Yqw4hDbr6kt8y7e
 hCEvbM30RSXAM2bs6sC17CH9fi4GCQp2tWojjMrSN92a1c9k8IYnggtUoauKHbQC7rUVRE8B
 9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUhrwOhBoKevrB4Xck9q41/yo+53Ufg5EmCexbal9I
 Ri4sQndrNcajIttJqswyhbCv39Ed/hLyW9yKl+fgRLx6t2s8JJ/9ihbpu4s+dNHXajmcKs0S
 qBVAi4hP24p+sPgqAPNTRGI5nsSU2UWlgRHDg3Y5xzkXZn/rzX3uPNl1CaVIcP5Q7Y0WS+/7
 6hwUx/nlD0HNz8i/27JjMF7kb9Wrwigpxx7xI7UfZ2VOf9jda7TYd8WWWxMVdtKWidfHo2zc
 ZcAD+sZPeZZsYb9oUcOrQCjDgWoHe/j1yNEimPz0aA8zu8vExzJ3BY4EtwAsHrassv4OroRX
 +C7w6bH0SjMYPFN1Dfy9ITFaAosre2QUb5ud8fa1EkhFxnCjlWVsYHqPzSV1uADs2iB9eVgU
 P+khXM9pAF3rTik28Ahi4fSho0PzVzE7zt2wIArKt2jUkF7esWpEIBKuCGcOIt6W90tQ2dnu
 CY7zL0Jp4C0fDILyJQhyB7TceCIc4+N4h/6UuuaPDh3im5/dr2lmxay7Vavyvf6VsSs31hHs
 CtInsXNu34NyxHe5caJR+Z980qlxTuC1ADe5+VHLE0oi6bWNoIsz7ozm5cXv0rOHjP6lUH1g
 aGYdksp/u6l4PnkbLX+vpKQKot5hw7kPqgzh8CyA/40PhYOUmWU4+ix2rPu8EvkS7hUiv02j
 7LZsIzEKsQBu6C5Ag5U3Zg75hqjCTqtzc4WkmMdLF1ffRKKl4jpNE/KIPD/Ffq/hk6jkDZvx
 /zcP7zuHIjNLmPfnLrvZ7py9lBTxBIyzdBZ+Z1UFqkMLO/3V0L+rtDUEwI1Pg6uz+r5CNhw2
 ZkSVGyBD6OBNaPdq16I5uYhI+mWY48VvS7wKvY+5/H0inM5g0ESfa+30psMcn+4Be9rI16Db
 nrqjdcNCHkFvgwxTOzrjl2NTyBcZ2yzX6I66TE3Ep6pDYDGRoy1hryOxz+0HodKaWBeFlCMD
 XDoep2ZV/sUciKdPtdhkiAYVbimU4IuyRauuxPmxLpmNefU4S0ZtZf71Ndv/eHTlBcy9SZ1D
 8uHyW2NQXt0zSs0QGoT1bp8vFc151ONy6l+jLQMMNVJ5O5SFCo+O4TdyeNSFN34HA7MKISnU
 lGjF+qhBT8rR9d5+NYIbA4pBM6rzQrO2SexCqQ9jLWNC9k59K3d2XX8Pcd7xDDN06x33Apue
 ddGKWDz3v03zAPUHYOc1hzBz85CFIwZ1S/JriKYyHaW+VtfW0h2WLnEWnYWYg3Xq8747wXMV
 ezmEqwpZy1Gz8PKMa5Wcpvxl1wTW+zqe87TZW+qknyYHh+OyfaBaoXrfWgQxiTbBw4PlAVAt
 W2eO10GDzy663nbECQoEFvuZ0329uwrt2iyDVU5yQyRZlZJzLOz9VsYg/OdTf4exLMCt2Eqr
 DAnVE2l0YfuAsGb7xFkYL0aYd455wJf0nnFsgVmIpG6B6Vrh1pYYQlqpBu1kRl6YmlZue4tq
 n5ijA97KKbClUhEayvdx5f7fLveNmj1+hmrLa/QwFDXltiMqO8J77wjplPvsRvMdAJq+mh70
 9RTz3qX54nbRAsUX5XrV08r9h9877jEayg57onQ2DViK66x+jPF3tsoAqMixHPCN59AK6rHD
 gL0HtYTHOC1Ieol3lWvYRMCMe1I9ag7ecihcrrO2aKmOvphgCPzlX5Os+UfmgqH8ytxTPKN3
 o5QmqDEmFLeCHGm0Qvn6Zuk/OIMLSsfFWe+1yX+UYtYZ6koOJ0OFX/rOcq8gNN3m5/qXXdcs
 l+lHVIPnsGzKn/wJxTw2xNd0UMPrDmpgyy9mnZriDhqtKeZ0TfH2Mz5fRwIf2NNS2hkgFr2I
 I67ydsdWQL7Cmph3Avg/kv8y6VB8e5gNGCQW0pOcjP/NEl5W62/87eEbM9J5Z4ysCNYFu+7Z
 BrJL9y16wtf2CTlEWxEwTk9fDz/oZT1kStxj2eFJWpypn7UES1p7S/W/8eUBftY3z5cATJ9l
 SGSHF+3ed+g4dSTkZ7H9OG4TWOoEJNJI2HnyoaJtS3z4mMPY1X3gOu62cfqFwUh2DTTzNBsW
 mDFqhn9ZITmzaW8PqRseUwgCFLn6sV8E51zicNp1c1WgCFFwM/IoTxcyi/6KrA5kermYWAIR
 CIXztKd+wXj1EB5bzqIy4//SnSB055kbti+bHkR33FYjYgCA6OV4bpY2Cpt9wPp8USIOKc7x
 GpBj6B1uxt4y6kTtQEgzzuQGOUXFEhcZ2n3kgiQqsq5p+NRbXqudr650Ax/m8qgBfeMuFI5O
 j6xd5E8ECt39sg6PkjL1Si59ZrtO8Pda98Ivwa8iB7GgK1YLp0wkPcHnythNiT2unhvmItZx
 VR+mIq3uoSKMTAn47mwQQRVMDDubtg74TjrguNTmMmX2Y2iBJRnFXMAW56iHpfKWHoC8P/gM
 QiJCjg1rHyWTKHeEQGo40Bjt3vTEpqvOiLfNDwDwN5lXhXYOF1HjVVeQmAhhpBgXFPPpoSpY
 AJj6zsW/FK9thZc1rciKUzkSmmG7AK4Ii05RJmFIRFKuzZZ/0mTLMCb4+5yFmde84HrxOCUA
 lSSfB8ATWQAW0jeQkvmIqHr/97Lte6RGuu5KfLKJ7SIs+1XEfmSl9qj1Y5v/jDEMcvqXDEqF
 /ogxk9KRmx0AezckjQLDT4aijmVNIiXqV+w9zZ2oca27PnwEFu+uc3WUuQUa4gzvUvtya6YU
 ozYzD50MzNZyo8ByTfTxb4T0URTwyBiej+xEKgR4C7ASKWD0qRTDhMdd2ZyLJ4Rvv56h1ASf
 5SG1pWuje0d7LZ9EVpOWF3/l9v8YMULJzv4L1bbHAORM7/AIzTXwsbxaKf6SLtKjewSuQfj3
 FTTW0LlIDmHkCHkEh61NuQZxj6ANV9EtYewaR92IXPqSt2jZxu0Mdl6gCc3x7JyjXTPfz15U
 3A0YwZWo7uc4DkNyO14AHBE52F5IPOsni+Y66/KJ4sN6aAtDik+xIc4qDwqjrBS6i9DXvl8n
 iDf+8Vvr1+Rme6K0jN7URBKp2UDlMeRsE5lI6mc6ohYVCOO4kcW9WvJQUdvxZMtGpj1tqtX0
 NSKiK/jNGII7YfP5cVFT83EetCKLWF5alzlFXaDBQ8BB1ZD2knEjkpS1fyU+XyTo5Ugq57j3
 pEJT+0CPLTQPugTDEsgEdoNIZF6Uykll7Hdh8kNtyLWRPj5QcxbutbVW++JWa6pJDvL1NF5
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:51HZ6a0k6tJPjp4xRMnYtgqjBIQkLtp133Aq2lEZdPWaSKylfu
 SV7ZImPH7P+VEssRQb8uxoV5PufZqxz/BICMwqTM6ftWrdyQ+VxeNZnOnfKlTbckWVm9K1l5
 0QFpSWY+eAbmSS4/ya3CCIV+oMhOOC7bntv+vF1XdqSmhRB51d0w==
X-Talos-CUID: 9a23:Hy8bQmzV2x9bQ4sKjQECBgVTEeR/V3js00vreW/nKHdbbo+nWEOfrfY=
X-Talos-MUID: =?us-ascii?q?9a23=3AAtKe0Ax0JhEKSIdPFqzmcwMm19qaqKqTCmMcqI0?=
 =?us-ascii?q?YgcSvZSdBYBDNjGubbIByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.09,190,1716242400"; 
   d="asc'?scan'208";a="174321499"
X-MGA-submission: =?us-ascii?q?MDE9FUqaMxcJvNd+E/4dHWXmfZVvpMfu9ptXJc?=
 =?us-ascii?q?F7oHbZbzH02OwlsoPt22erVP1YSz82re/1ffXxaah+9q75O40fxdcytc?=
 =?us-ascii?q?1nKCZMzdezLKa/PYbCh7b1i2jBibmRc7REXlponGzjLWL9P9ovV/w8on?=
 =?us-ascii?q?kNucrRIQT+tWCjXK58tSGxBQ=3D=3D?=
Received: from zeus03.de (HELO mail.zeus03.de) ([194.117.254.33])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2024 15:32:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=xB2J
	Isjbv0Fhuqq5EnN9Sk4WS6OW8DsqBLF1WAfPjyM=; b=CaQeZzrMdz5plkQYMdO/
	pMRVZOqWZU/7rHeFNjx/Z9Zt96W+0P8MuuysZjbeJxAoB4XF9VqdXlA+FUenLi1X
	UIVtHadGLE3GBaH0eGizlqw64RgUJRCe/TZJx898ZJwIGy0zX8HaKC24UAq+3wC8
	6nCbcT+JRYJqO2AtOkSgynK8S/pdDD9430oX699gpqBDSy0PL0i4glYkCWTKJoGi
	ToWbol/DWQ3PMw5cOxLIHraT1t8JcK6MUCAVwxqzBdglpyElEqrixDGJZiUwoiiZ
	4qgjtDOVRRKohf40o+gKMl4vyp7Nb3APOomFBf5C/xj6Q9grJFOFwIsCRJbEDOzJ
	Cg==
Received: (qmail 4104571 invoked from network); 7 Jul 2024 15:32:21 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 7 Jul 2024 15:32:21 +0200
X-UD-Smtp-Session: l3s3148p1@wOCAU6gcApVQT+F6
Date: Sun, 7 Jul 2024 15:32:20 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: cocci@inria.fr
Message-ID: <ZoqY5GQlpKwZ3SEo@shikoro>
References: <8d145e35-33af-4f81-a77a-2bbc5c734045@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+9a0sqk4GzP0J6Yk"
Content-Disposition: inline
In-Reply-To: <8d145e35-33af-4f81-a77a-2bbc5c734045@web.de>
Subject: Re: [cocci] Deleting unwanted semicolons (with SmPL)?
Reply-To: Wolfram Sang <wsa+renesas@sang-engineering.com>
X-Loop: cocci@inria.fr
X-Sequence: 1802
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-07/ZoqY5GQlpKwZ3SEo%40shikoro>


--+9a0sqk4GzP0J6Yk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> @deletion@
> @@
>  return ...;
>  }
> -;

How should coccinelle transfer this incomplete function body to an AST?

> Will the shown source code transformation approach ever become supported
> by the Coccinelle software?

Wrong tool. I suggest AWK for such changes.


--+9a0sqk4GzP0J6Yk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmaKmOAACgkQFA3kzBSg
KbaM2hAAr7eS9K3Oe5sILfX+nuQce2n50Ncji8SJWuKho3KGZ1QgjoaSmXn2l5MS
NOeJOyUHj0USm88pF3FIQJMLtEQF0mbUSyQ6SrsgiJ+CuBeuIsmNw4BSjNFSelGA
VDnk/BWIWkALdzfoVNeVfM5rYYLJsnqDIYLAg6V98DyYvRNIC2nPGnoj189HoplE
p/qadoyoqnGv9VYSxMbhbfuBMdaI/DaeUCuOQeDJo9WdKngQ9R875Q/f6z4PiJRh
N7n0k7o9Pdb6b4jJ7TuBc9kNxlUjrkc12tjzyy+QSHcvu8r99lDmwkSrd7sh0ROt
lqW/+AyOysnraRRgthGim8dBkE3DcnWBrtkbTGhRcWImfjxBTx//h1pVQCEDC3qU
WIMDFkjMWnfRSNsYb5pBBLm0yHbd5zJb8KeE1M9lBSJkXEcTf0egxQsbmm9q7QbK
WmbwWisZrqjHU93ZfUrkUZg/Fw6SO+MACNmYwoXI9jZYxLj6cxiu8N/cxNOW6bo3
V35U3OFn1p2B+YU/OROMf3Ar1iee51T/Z5zU5W7v5yIPVbjDVfPhF+k/Yt9gHmSk
SsvE0kTg/Np+ahqjs93+yl7/1E9vS+jGXJqgjgKKyMoTSmWiCJUzcpyjekliTP87
enWqP9oBfv/KN4EOhC3pC0P+4Ke+eIG++m1OBWoBiu1qsABw5DY=
=mB3I
-----END PGP SIGNATURE-----

--+9a0sqk4GzP0J6Yk--
