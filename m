Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C19F3C02194
	for <cocci@archiver.kernel.org>; Thu,  6 Feb 2025 13:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=2acuujd5HMEIoFU9GQM8rpfoWaKoke0LFRljbJg1D3c=;
  b=P9ZAhtJQbfyLE1nxUN98zmdRFyf9IWZqS+wH7ZVyaTqTjwlA3dOncOUo
   cZq4kvASecsi3CdT87V2tlM3U2q0YwhqcRJBlN22u8cag3drdF51rouJA
   GAF/idMNhhUmH9303gPWjRp/L74Een0Oj106B4TCTS0B/J8cGsnbyTgQu
   Q=;
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
X-IronPort-AV: E=Sophos;i="6.13,264,1732575600"; 
   d="scan'208";a="206934832"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Feb 2025 14:34:34 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7F11CE0260; Thu,  6 Feb 2025 14:34:34 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 27AD0E0D1D
	for <cocci@sympa.inria.fr>; Thu,  6 Feb 2025 14:34:23 +0100 (CET)
IronPort-SDR: 67a4ba5e_GILMloQAX3if0nG6xfR6Cl9/gy/jGEpkKfaL+dkDpxcNIvs
 kuVX5N6QCx6J1j5+IaoyPlS9/ByA17AkjGKltlQ==
X-IPAS-Result: =?us-ascii?q?A0HzFAAEuaRngAwR49RagQmEF31aMwQLSIRWj0+BdDCEO?=
 =?us-ascii?q?48OiHWDVA8BAwENOQgBAgQBAQMEhDpGAosBAh4HAQQ0EwECBAEBAQEDAgMBA?=
 =?us-ascii?q?QEBAQEQAQEFAQEBAgEBAgQGAQIQAQE7Bw4KMYV7DYJiAYEkgSYBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEXAg06RAEBAQIBIwQZAQERJwQLCxoCJgICVgYBFAEBgn4Bg?=
 =?us-ascii?q?i8BAw4jBw2wKH8zgQGCDAEBBtpcHywiV4FlAwaBGi6FbIJjAYVqATuEPCcPg?=
 =?us-ascii?q?VVEgTwLgng+gQUBgVsChTuCaYIzhEhWEaJ2UnscA1ksAVUTFwsHBYEpEDgDK?=
 =?us-ascii?q?jYxI4EjBTUKNzqCDWlJOgINAjWCHiRYgitqBAWBLYI6hEOETYJDgxiCEnRuA?=
 =?us-ascii?q?wMWEAGDIXocg10QHUACAQttPTcGAwsbBj2eRD2FUiKBKzDGWjQHgjiBZoFjD?=
 =?us-ascii?q?IoplTMGEy+DcJNTDgaSe5h8Io1imyqBfiOBXDMaJIM2TwMZD444g2Mzx1RCN?=
 =?us-ascii?q?TwCBwsBAQMJhUYBAYppgUsBAQ?=
IronPort-PHdr: A9a23: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
 RcFk+uQEA==
IronPort-Data: A9a23:wsQ8AKK1DRdkm4dOFE+RAJElxSXFcZb7ZxGr2PjKsXjdYENShDNSx
 2oWUG3Tbq2PNmqmeogib9uwoEIFv5PTzdMwSQUd+CA2RRqmi+KVXIXDdh+Y0wC6d5CYEho/t
 63yTvGacajYm1eF/k/F3oDJ9CU6j+fSLlbFILasEjhrQgN5QzsWhxtmmuoo6qZlmtHR7zml4
 LsemOWBfgb+s9JIGjhMsf/b8ksx5KSaVA4w5zTSW9gb5DcyqFFOVPrzFYnpR1PkT49dGPKNR
 uqr5NlVKUuEl/uFIorNfofTKiXmcJaKVeS9oiY+t5yZv/R3jndaPpDXmxYrQRw/Zz2hx7idw
 TjW3HC6YV9B0qbkwIzxX/TEes3X0GIvFLLveBCCXcKvI0LueVjzyd5+LXANZYgcpcsuJWFTy
 qMWN2VYBvyDr7reLLOTT+5xmoI8IcOtMI53VnNIl2iDS6x8HtaaHOOTv7e03x9o7ixKNdPXf
 ckEcnxCaBraYhtAEkgaAtQykY9Eg1GmK20D+ALK+ftfD277j1ct7+nPb//sStXRRIZzpk24m
 zn81jGsav0dHIfDmWLeoi3EavX0tSj8U4kTPKap8+ZjxlyV3G0aThMMPXO/qOawjkqWSdNaI
 VYdvCsot6k7skKxJuQRRDW9p2OY+AERUZxcHoXW9T1h1ILewBmTLXglfwUZbdh5mZYSRSEVi
 VGWyoaB6SNUjJWZTneU97GxpDy0ODQIIWJqWcPiZVRfizUEiN5q5i8jXupe/LiJYsrdNRyY/
 txnhC05mqlVksMBkam2lbwmv95OjsiWJuLWzlyJNo5A0u+fTND+D2BPwQaAhcus1K7DEjG8U
 IEswqByFtwmA5CXjzCqS+4QBryv7PvtGGSD2g4wT8F6q2/3pi/LkWVsDNdWexcB3iEsJm+BX
 aMvkV8BtcE70IaCNv4uMtnvYyjU5fG9SI60PhwrUja+SsMtJFfcrH4Gib+43mfrl1NkiqxXB
 HtoWZbEMJruMow+lGDeb75Fj9cDn3lirUuNH8yT50r9j9K2OiXPIZ9bawTmUwzMxPnUyOkj2
 4wPb5PSo/ieOcWiChTqHXk7dA9bfSdjWMms8aS6tIere2JbJY3oMNeJqZtJRmCvt/k9ej7gr
 yHnCHxLgkHyn2PGIgisY3VuIuGnF5VmoH5xeWRmMV+00jJxKcyi/YUORasRJLMHze1EyeIrb
 v8nf87bPO9DZA6a8BsgbL78jrdYSjKVuSy0MRGIXh0Dbr97ZgmQ+tbbbgrlryYPKSystPoBm
 b6r1yKFYJ9aWQhSNdvaMsyu61aLuVkch+NAcE/aKfZDeEjX0dZLKg6gqtQVMs0zORH46T/C7
 DmvADAcvvvoj74u1tvClYSoipiPKPRvOHZaE03wz6eEBQOD8kWNmYZ/Afu1JxbDX2bKyYCeT
 ORyzcCkFsYYnVxP4rFOI5wywY0Qv9LQ9qJnlCJ6F3D2bnOuOLNqAl+C+eJt7qRt5LtoiTGaa
 3K12OtxGOu2YZv+MVsrOgAaQPyJ1qgUlhns/P0FGhjGyxEtzoWXc3d5HkeqszNcHotXIYl+4
 OYGuewq0SKdpCcuEO67inFzyzzRAF0GC74qp7MLMr/N0wAL8GxPUbbYKy3x4ayMVelyD1kXE
 meUqZfG1pthxRvkUnssFHLy8/JXqrYQtTtrklITBVS7teDUp/0w3RELzzUTSz5R7xRY0tBcP
 npgGF11KJ6voRZppplndEK9Fz5RACa2/hTK9GIIs2nCFW+6e3foPkRkHcqspWc3q3l9eBpf9
 5GmkFfVay7gJpzN73FjSHxbpOzGZv0v0A/7weSMPdmPRrs+ahrb2p6eX3IC8UbbMJlglX/8h
 LdY+chrYvfGLg8WmaowDrea2Zk2SBypIG9jQ+lrzJgWHFPzKS2D5jyTF3+fIs99BeTG0UudO
 fxcIshiUxef1iHXihs5AaUKAaF/nd93xd4kV47oG1U7sOqknmI0iK7Tyynwv390YtNMlc1mF
 JjdWQjfGUOthFxVuVT3ku96BkSCb+M5OTLMhNKOzL1RFrYokv1dTkUp477l41SXKFRG+jyXj
 iPiZojX7bdQ9qVxraTRE4FoJQa9GfXsXsumrSGxtNVva4vUEMHs7gk6lHjuDz50D5AwBetlp
 O+oi8Hl+W/4p5M0bjzpoIaAHKx3+smCZupbHcbpJn18nyHZesvTzzYc2mK/c7plrch845S5e
 g6Gd8eAT94ZdNNDznlzaSIFMRI8CbzyX5jwtxGGsPWAJRgM4zPpdOr92yfSUlhaUSsUN7nVK
 Az+4a+u7+8FirV8PkYPAvU+DqJoJFPmZ7AdSOTwkjulFUitvEKJv+rztBgn6AyTMEK+LuTB3
 cvnSCT9JTOIg4OZ/OEB5sY29lcSAW1miOY9QlMF9pQkw3qmBWoBNqIGPY9AFphQlTfo2YrlY
 C3WKlEvEjj5QS8OZCCUDA4PhetDLrdm1hbFyj0VE4e8biCrGMWfDbEn+ioID7KavNf85LnPF
 D3c0iSY0tuNLlVBWusZoPC26Qui7u2P3WoGoCgRjOSrayvzwtw2OLhJAwdHEyDKey0IeIMnO
 kBtLV15rIqHpYId3Cqul7O52P3Ugd838wgVUA==
IronPort-HdrOrdr: A9a23:rFesh6sV0cB7cjoXfkLoPtuN7skDqNV00zEX/kB9WHVpm7+j5q
 WTdZMgpGbJYVcqKRcdcLW7U5VoLkmyyXcY2/h0AV7mZniAhILKFu9fBOnZrwEIcheWnoNgPO
 VbAspD4bbLbWSS4/yKgzWQL/Zl5sWb+6a1gurkw25qVhwCUdAb0+40MGem+lYdfng/OXPVLu
 vm2iLNygDLRUgq
X-Talos-CUID: 9a23:Mlo7P2MHviavVu5DUgp4/mUEO/EeKnjZk1qJB0+lNjlnV+jA
X-Talos-MUID: 9a23:YWVmJgjNLMQtaD5V2/qucsMpd5w03PWMV2U0oZxduoqiDSdQBmynpWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,264,1732575600"; 
   d="scan'208";a="108388749"
X-MGA-submission: =?us-ascii?q?MDHcFvqQ65lWNnA6tS2Z0lYt0cOGCeQ2GKFpmt?=
 =?us-ascii?q?eoOmrRvpgThR1PFyPesUYc1HtaF3ZPmDTrTeb//boIeBoQ2I2sbvsaZL?=
 =?us-ascii?q?D+uD9Uctuw78lFEw1YCY85JQxl2UbEU7m9c/x+l3ceMK/LaEsO1o4Tzy?=
 =?us-ascii?q?qEFrqGanfBdoMV7JzFNLh0WQ=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 14:34:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1738848858; x=1739453658; i=markus.elfring@web.de;
	bh=2acuujd5HMEIoFU9GQM8rpfoWaKoke0LFRljbJg1D3c=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=U6DnMgxk6rTihk3oDQHHvs7SHedX0DD/g5EfD7rxZSGFV4FeNwYKvb7Rx77C4lN7
	 sQAwTZAXBZl/E0hKiodqn/9HS+b+xrlLHN+YvLd0KRfznnU3xaAF7QPP2Gjx7gcEv
	 H+P2xRo3EGeaqjO44VjgJgVthATItZjX0hXiHYvYfm6DH0GO5yTd4ZW1zbYj75iS/
	 RPbxBYz4zVu1azCxvt8auN29N66CzLfCCIqPawf0azca5U4ounOcNS91KTYGvi4dA
	 EnD5xGSS6XkKtoRkQ+7n4q3JMN+RGuFmTXetByOZ/xTTg4MO5mx6P6zWRgsTRRhvS
	 M+1b8VDnrzjSmeLqRQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.8]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N3Gki-1tG4vA2XUg-00tktu; Thu, 06
 Feb 2025 14:34:18 +0100
Message-ID: <fffaabbc-dc86-4516-998b-65777ac97372@web.de>
Date: Thu, 6 Feb 2025 14:34:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Johannes Berg <johannes@sipsolutions.net>,
 Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <381b5a9cb89cc068ca13546f69636291874010b3.camel@sipsolutions.net>
 <061f1b6b50d305671c02742382a3df0ff95f9c6b.camel@sipsolutions.net>
 <ca7c1a14-522a-9c2c-4f85-2fda289b83e8@inria.fr>
 <9063a6e6c83f9169456bc009cc35426889cc46e1.camel@sipsolutions.net>
 <12d36f971e2f3d2141a27a00b9b4fc7f44ea1d17.camel@sipsolutions.net>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <12d36f971e2f3d2141a27a00b9b4fc7f44ea1d17.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fBb2G2v8E/+Nimsi7d0+PFSTspP7qigEHjOBPC5TWllaxqYbCTd
 5tDlKP0+6C85ZWZgsv9FaQrXrTiNvJyOCKgCsgMphcepFN41REZ7R1Y1dbx0cGMOz8tnkvz
 zajuDNNFH9AExL4K8ag8IhNDr/lenvfPtkpejWZ/1ZGUv4A152VGWvhO3vq6jqXISrrMWvZ
 6+05sooYHJkJCFkcm5ABQ==
UI-OutboundReport: notjunk:1;M01:P0:mDdJiJplwGM=;fDWhcvYpd1/N4Lo1nGScgv4WFda
 g8MGXvIx48MOseLaMasszf0kchOmHr7H/46eXZteu1i+UonrVKaRxbLhyce/dkMchTBAs/0SW
 dlChMIypP/RfTive/UFsq6+VUnDHrcU57OK9LL1q1vf6u4//vrMZOyRA8lxGGCKinqev9ozvu
 H8H6tEe3SiKCAz5eIVdBAgGsW+gMMeBFkjPQ5Q/FOlCxO4L9osO7FBAzQDBSeFiB+JiX485/u
 fbAyAa5+0NYwfBcgod0AdWs7E7GttweFndR7yLaUfw14ZSOxIFwcomAW+i4ppzKPCf/nC/xEF
 4UFOZxupqwtTCoVEVAO2zHhlzYpkb51xU3qNPujsFwGAmkOpVSz0jn3ch/e/rMnZZZpXXlvaz
 jaTqtwkcR34G/Eb5OVDj+6N/YR9l7gW0k6gX7SwqQToEQys1uNnndeQBZIZMwH1itfCKEbNxV
 geX76VFjJizKG4B1AHfMp13fet/+ievb/NsY1vge7osoUpJlOgvH8avl2vsj5zPhaWidjTCeu
 +GC2Zrx8FxyDn6Ygvse4AsqsnHDY6FuW3zSXWRVafoZQFfbP+JmI2WoslVe+0F8kkSWvwgCUu
 jAPwT/26onwU2+QfReim76tP6IITaU6SWdNjkiqoCzeH6ibxpM06zNB/ya40pSn1LQl5701c9
 1cNwFdyqmW/ExBSyO7JXYiqvC+wwP26iWy0zT3jd4ayjwbR1OIU6FrOXDeoIUvwz7+b+GjnP/
 Qy0jyeaYXW2foUnWvxC96V0dcuZ/+hMh6NIxi/7LVUJgqp0laMXRF8rrUFA2qT5aZafojm4rR
 PXyiy3X75EwKLVEVQiR3A+ZPeNWUQyRGJATxuxCZJ+UvQVHaRhE45iIq6LUY0gqGagili9i4T
 PlktlIDKDr7NqF2SF/Zkazr1WfsWxorbtFJblOnYlImIFUWA/1+EABVWks4wpj5toUjaEQhIA
 o3eL9Q6OpRt0vTTF9psW+Xr/zZiN7BXDNyDEuts0YuflBkHtgTivd8eF3od/HgDQJXFXCsP5o
 axmTKpPCMfeH8q0S1AzHD5cPSDY0t4DY2xvWaMuyRtLqX6M2F4fbMxAQCNJ55ecotNO2r+STb
 2lfnh/UQ0JQDdd+ZCQg57aoJM4ojE/sJ8pyQusmPizyouKitLc9znMIfOq6isLTtrpoD9muCr
 d4Sa4yt3g0JPkujL0Wx397Xz0ccTaGaRyLlAqylYZtPvi/tD/CSpPiInuPT/1OHVQjzhtf5ab
 UOWOajL9hfCiQGRMT/wTOSi20ls0/DBGPKhMlwe+putnkhizlosrN+3JNUUfledKVXOEjfYUw
 6tY1LsQeN22m2/xOprJJ4urU99MSro+zW+rlMnPHiAMLwxHXd1xLJnGljU9Mw9Ka/u+B5Cdde
 zbZE6bsrYXLaq1/4o0ENtHZ0SkH1fBxnPCxJXllVUpLVnLj6KiMlArJOWetjnBDpa9gk0FJ2Q
 JQLiPypebhOeooknHmbUwmVq1qUZ+F6rOaeW7JbltlTkCsWwzr+wLIodAyRazIMAnBxNoYg==
Subject: Re: [cocci] possible regressions in 1.1.1 -> 1.2
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2362
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/fffaabbc-dc86-4516-998b-65777ac97372%40web.de>

> They do seem to remove *both* instances, however, modifying the spatch
> to be
>
> @@
> @@
> static inline int
> ieee80211_get_mbssid_beacon_len(...)
> {
> <+...
> -if (rnr_elems) {...}
> ...+>
> }
>
>
> makes both versions process it pretty much instantaneously. :)
Would you like to reconsider source code transformation approaches
any more also with your SmPL script variations?

See also:
Get the non-optional nest construct completely working for SmPL
2017-08-18
https://github.com/coccinelle/coccinelle/issues/114

Regards,
Markus
