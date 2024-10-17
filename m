Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84EE7D3C522
	for <cocci@archiver.kernel.org>; Thu, 17 Oct 2024 16:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=H0wyPUuACaMNy2Sy4290W36s9r8/vVuL2naBFYeZsUs=;
  b=gzSJIAfDQeV5lAdSlBHhjR1lt2I8ksKQsowDrse3eftQmaFJW7zJNwMx
   3qtuid84tQRDVNAQnbkm645FNogJpjmWjRTz20bWJcVyVADXzC7chpkeT
   HKz4Z5d952dVuavidx67lHC7hjNG8XtxUIUfTXDZRGwT2+BxxaBs6/+kz
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
X-IronPort-AV: E=Sophos;i="6.11,211,1725314400"; 
   d="scan'208";a="189454790"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Oct 2024 18:34:38 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id EA185E00B7; Thu, 17 Oct 2024 18:34:37 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 14A78E004E
	for <cocci@sympa.inria.fr>; Thu, 17 Oct 2024 18:34:36 +0200 (CEST)
IronPort-SDR: 67113c8e_lcnqrZRMcT23Y10w7pUlrcwBWBKSaxRMWwxYgVSLM0/wCwn
 M5jGcfEOcv2ADM1IOIi+yqBSbzXdU0tqy09DaEQ==
X-IPAS-Result: =?us-ascii?q?A0ElCAAYPBFn/wMP49RagQmBT4JEB1shVDMEC0iEVpFBM?=
 =?us-ascii?q?IQ7hzqHVIpLgUA+DwEDAQ1BAQIEAQEDBIR2CgKKJAIeBwEEMAkOAQIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBARABAQUBAQECAQECBAYBAoEKCAuFNUYNglsYgRSBJgEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBARcCR0QBAQECASMdAQERJwQLCxoCJgICVhsBAYJ9gjABA?=
 =?us-ascii?q?w4jB7AFgTITboIMAQEGgmjXcx8sIleBYwmBGi6FaoJiAYpgJw+BVUSBPIJSM?=
 =?us-ascii?q?T6EQ02DDoJpkgmLaoh2bpFNUnscA1khEwFVExcLCQWJNQqDHIFuJoQRCIErE?=
 =?us-ascii?q?4NfgWcJYIYggiKBDIE+gVkBgzhKg0wcgVEFOEmCT2pONwINAjeCJIEAglGBJ?=
 =?us-ascii?q?QQFgz2BEh1AAgELbT01CQsbBj2uF8xJNAeCOIFlgWMMn1UGEy+DcpNODgaSe?=
 =?us-ascii?q?Jh3qSCBZz2BWTMaJIM2UgsOD5JOxkdBNTsCBwEKAQEDCYVGAQGHBIFLAQE?=
IronPort-PHdr: A9a23:IjIfeByXM17JwyDXCzJ7wVBlVkEcU1XcAAcZ59Idhq5Udez7ptK+Z
 xSZv6g0xwaRBM3y0LFttan/i+PaZSQ4+5GPsXQPItRndiQuroEopTEmG9OPEkbhLfTnPGQQF
 cVGU0J5rTngaRAGUMnxaEfPrXKs8DUcBgvwNRZvJuTyB4Xek9m72/q99pDdfwlEniSxbLNvI
 Bm5sAndqtQaipZ+J6gszRfEvnRHd+NKyG1yIl6dgwjy7dqq8p559CRQtfMh98peXqj/Yq81U
 79WAik4Pm4s/MHkugXNQgWJ5nsHT2UZiQFIDBTf7BH7RZj+rC33vfdg1SaAPM32Sbc0WSm+7
 6puVRTlhjsLOyI//WrKjMF7kaBVrw+7pxFnwIDabo6aO/RjcK3dY90aS2hOUdpeWSFaHoO8d
 pECA/YdMepGrYTwoUYFoxukBQmrAePi0jhGiWXs3a05zuQhChzN0gMkH9IAqnTUrdP1NKgPW
 u2yy6fH1y/Db/BL2Tfm8oTGfRQhof+WXbJxd8rRxlIiFg3bgVqLs4DqIi2a2/0LvmOG4OVuS
 fihhHQ7qwFtvDev3MEsh5HIi48XxV7K9Tt0zoY1K9GlVEN1b9GqHIdMuiyVKoZ7QsAvTn1mt
 Sg1y7ALvZ+2cSwIxZonyRPSZeKLfYeG7B/nUuuaPDR2hGp9db6hmhq+71KsxvPiWsS2ylpGs
 ypInsPCu3wV0xHe5dKLR/Vg8ku72juDyhrf5+VELE0yiKHWNZohwqMrlpoPr0vDBDL4mET3j
 aCIbkgo5u6l4Pn9bLr8vJ+TLYp0hxn+Mqswnsy/Bvw1Mg0JX2iG5eSwzrPi8lPiT7lQk/I5j
 LHVsJHcJcsFuq60GxFZ3ps95xqlETuqztYVkWMaIF9FYh6KgZDlO1TUL/D5Cfe/jU6skDBux
 /3eObPuGI/NLnvekLf6Z7pz5EpcyAQpzdBe4ZJUBaoMIfztVUDqrtDXEwE2PxSyw+n8ENp9z
 J8RWXqTAq+FN6PfqUKE6vo1I+aQfI8VpCr9K/896vHyin82hUMSfaiy0JsMaHG4G+xmLF+Db
 XrthNcBC2YKsRAkQOzkkl3RGQJUMn21VKk9zjA9EoOvS4nZFa63h7nU+S6hHYBNLk1CBEqNF
 3igI6CNQfQRc2S/JsF7kzoLfaesQckt2Ef950fB17N7I7+MqWUjvpX52Y0tjwWyvRQ79DguS
 t+Yz3nIVWZ/2GUBWz4x2ql750170FaKl6Zi0LRDDdIGwfRPX08hMILEifRgAoXXUxjCY8zPZ
 VKoWNSgDhkuQ9h3z9JdK11lFYCahwvYlzGvH6dTkrWKAJIu9aeJ+nHrJNtmjVvC2rMgiVYOX
 cZFc2Gr1eZk7waGIYnPng2CkrqyM6QR2CmY7GCY0W+Hp11VSiZ1VrjZG28SbA3aoLwV/2vkS
 LmjQfQiOwpFk4uZL7dSL8fuhhNATeviP9LXZySwnX2xDFCG3OHEao2iYGgb0CjHbSpM2wkO4
 XaLMxQ/DSa9sirfCjJpD1fmf0Lr96F3tnq6SkY+ywzCYVdm0vK5/RschPrUTP12vPpMnS47q
 ChvWnu50cjXDdWouAdrOqlRIJs87FpByWPFplllJJXzZ6tmh1MYb0F2pxa0jk8xUN8f15F36
 ih5qWg6YbiV215AaT6CiJX5O7mNb3L34AjqcandnFfXzNeR/K4LrvU+sVTq+g+zRS9Auz1q1
 cdY13yE69DEFg0XBNjUW1w06gM8irXUeCg76KvL2HcqPaT+4Vqgk5o5QfAozBqtZYIVFaqeF
 xLpVeAeCdKvLuMChFWjKB4JdrM3luZ8L4atcP2I37SuNeBrkWe9jGhJ14t611qF6yt2TuOgM
 48t+/iDxUPHUj79iA3kqcXrgcVeYjpUGGOjyC/iDYoXZ6tofI9NB338a8Gww9x/gdbqVRs6v
 BaGDkkFxdTvVB6cdV370iVP2E5RrXHvlSajzjNymi0kteLFhXaImb69MkNafDUDTXIqlVr2J
 Imok90WOSrgJxMkkheo/weyxqRWorh+M3iGRE5JeybsKGQxGqC0t7eEf4tO8MZy6H8RCr7jJ
 wnHDOWuxnlSmznuFGZf2j0hIjSju5Gj2gd/lHrYNnF46nzQZcB3wx7bot3aX/9YmDQcF0waw
 XHaAEaxO96x8JCajZDG56qbXniiS4YVXC3l14KGuwOk6GcsDRD1zJXR0pX3VBM31yP2zYwgc
 CzSrwvnJKTv2b67N+1PYURiQlPxoZkfeMk2gs47g5ce3mIfj5Oe8C8ckGv9Bt5c3Lr3cHsHQ
 TNYi86Q+gXu31dva26Y34+sHGvI2dNvPpPpBwFekjJ49c1BD72YqaBJjTcg6ETtthrfOLB0z
 DIa1Odo93MQxe0E8AN/yyKAHvUCE05CIiX2m1KX4tr4oKgyBi7neOq101di2NqmEbeJr0dDV
 Xy/dppqFH116dhjdVnX2mD36ce9cd/cNJQYsRjx8V+IhrpQL48t0/ERji19ISSktHspkqgwi
 hkmy5i+uMLvx3xF2qW/D1YYMzT0Y5lW4TTxleNEmc3Q2YmzH5JnEzFNXZ3yTPvuHihA/fLgf
 x2DFjExsBL5UfLWABOf5UF6rnnOD4HjNneZI2McxMljQx/VLVJWgQQdVjE31pAjEQXiyMvke
 UZ/rjcfgzyw4gNL0f5tPgLjX333oQC1dnErRZLZIBcXpgBO6kHJMNCPu+J+GyYLm//p5AeJK
 2Gde0FJFTRTAxbCXQq8eODzo4KTlorQTvCzJPbPf7iU/OlXVvPSgImqzpMj5TGHcMOGInhlC
 fQ/nEtFR3FwXcrDyFBtA2QakTzAa8mDqVKy4Cpy+4qa+e7oRRmpyI+BEbpUPv1w9hrwjarJZ
 IvyzG5pbC1V0J8B3yqC0L8EwFsbkD1jbRGoFqkc8zHARuTcl+UEanxTIzM2P8xO4aUm2wBLM
 sOOkdL52IlzifstAktEX1js8ilMTdMHKSexOQGfbK5kHKuLL3vHzpOuCUtdYbhXkfkSqBC6/
 zqWQReLAw==
IronPort-Data: A9a23:hRXxUKwz9mZGay6QF+96t+cjxyrEfRIJ4+MujC+fZmUNrF6WrkVRz
 jFMDGrUb/veajP3fNl1atix/BgC7JTcmIVnSAY/+VhgHilAwSbnLYTAfx2oZ0t+DeWaERk5t
 51GAjXkBJppJpMJjk71atANlVEliefSAOCU5NfsYkhZXRVjRDoqlSVtkus4hp8AqdWiCmthg
 /uryyHkEAHjgmcc3l48sfrZ9Eo35auq5Fv0g3RnDRx1lA+G/5UqJMlHTU2BByOQapVZGOe8W
 9HCwNmRlo8O10pF5nuNy94XQ2VSKlLgFVDmZkl+B8BOtiN/Shkaic7XAhazhXB/0F1ll/gpo
 DlEWAfZpQ0BZsUgk8xFO/VU/r0X0QSrN9YrLFDm2fF/wXEqfFPznP9kMFo2HLFFwb1yMEZzz
 sBHEQoSO0Xra+KemNpXS8Fpgdk/atbmNsUTtxmMzxmDVKxgG8qcBfyXo4QwMDQY3qiiGd77b
 tAadCEpQRDOeRxJNX8IBZh4kOrAanzXKm0J9A/J+vZsi4TV5AgyyoHpNP/xRtq1X/QNkHfBj
 WHZ52usV3n2M/Tak1Jp6EmEjejEliLTQ5MXDLT+9/hwgVTVyHZ7NfENfV68vOX/lUO0Hd5SQ
 6AJxhcTQWEJ3BTDZrHAs9eQ/hZoEzZFMzaMO4XWKT1hy5Y4Jy6cAXUYCCFMYpoquafagNDsO
 kChx7vU6f5H6dV5ik5xMp+LoDn0NSV9waoqe3ofVQVcizX8iNhbs/8MJ+qP1Iaqg9ezFTyYL
 /VmasQhr+17sPPnHJlXMbwKb/xAa3QJosMICt3rY1+Y
IronPort-HdrOrdr: A9a23:6ABur6xG/MBT5U+/NhtzKrPw8r1zdoMgy1knxilNoG9uA6ilfq
 eV7Y0mPH7P+VAssRQb8uxoV5PufZqxz+8X3WBVB8bEYOCEggWVxeNZgbcKqgeIc0DDH6xmpM
 JdmsNFaOEYY2IK7/rS3Cn9Nco8y9+a962Sif7Z1GoFd3ARV0gt1WZE4h3wKDwPeOCqP+tDKH
 IWi/Asmwad
X-Talos-CUID: 9a23:fQLeLmxHZxqjCEGr07sTBgULRcovTmbd7UuNGBS9OEFUc4HKcGWPrfY=
X-Talos-MUID: 9a23:NOi6UwQrZQHcbeymRXToxytbMMNNx5ioN1o8yZs34uKHKjR/bmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,211,1725314400"; 
   d="scan'208";a="189454743"
X-MGA-submission: =?us-ascii?q?MDGZ0X/8+szPRGPh8UNg+6/LfIZJ60bBYpXxAC?=
 =?us-ascii?q?SWDUAiJJcYt3qCFX5mEik0xirXJXq0MEBN94s/rtjPmhLWY7/xE0TDde?=
 =?us-ascii?q?ekohsPDVxxmoRoD7HHIdwfp4BmjJNkmCpuCQWPybsgA7jWdnYNk/EZkb?=
 =?us-ascii?q?Vaktp4RpN34CLKuhYYHYoP2w=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 18:34:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1729182851; x=1729787651; i=markus.elfring@web.de;
	bh=H0wyPUuACaMNy2Sy4290W36s9r8/vVuL2naBFYeZsUs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=pX0jpr8pgx8oKAWS/NO6s+SXfuqaSg9JSSXK11TjTdRKbi6JkAuJ0xn29TH8uXO8
	 W5t502KobxTi9UhMCFsmXS1X+U9dpPP18NuTkIt4y1KRA5MErBvfCIqe+sUga69M7
	 KXzjxvLmC3Hc9iSyZmfMVSYRMICHCsbS+yMK/WnCZ9G5irWMHtjOQ9/ap37KmPh2c
	 tqT5gmLRxUOdbJKn23UiN0hV1CGGS+xqrAJFLvocbxXnZ0KwFUfsKGciYu6v/bTJu
	 R579Umswe3d+e4TEfD2gUb1PwsYkRDcK0mBNdLnvyfWo9FWgYTFcUSqYx/jwpdNSf
	 dQBqkXYXIOogJwQ+6A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Myezp-1tr4Zi2KRJ-00yzUc for
 <cocci@inria.fr>; Thu, 17 Oct 2024 18:34:11 +0200
Message-ID: <ced9a857-0da6-4cfc-ad35-9095ea20771d@web.de>
Date: Thu, 17 Oct 2024 18:34:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: cocci@inria.fr
References: <9c059950-a17c-49e4-ad4e-ffab2d6c0ea9@web.de>
Content-Language: en-GB
In-Reply-To: <9c059950-a17c-49e4-ad4e-ffab2d6c0ea9@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AKuwuOFRezCLbKJl2NdYUaa/XZjyXo9ytUfExVkrQ84Ka9rUTX9
 8NE1/w4s4geJ6Lh52aKbQgE5LLE7rHYU1ruRn1uVoKPJCpvYEwJo3wbl/OsrVxppuq6ZMta
 mrYtjZL4qOYTK+TOLf75UMp/zwlyibSKs/ans0eniBHnpd+olkh7AJ5e004DE1w0jA2U6Tr
 mm5u2RKnIwIq3/n+Vk6+A==
UI-OutboundReport: notjunk:1;M01:P0:xd9imPwQZW4=;jj0NfeZsUjOHxXGKCaogiQpCRnz
 ewHZl6Rwvb8GqQZtidRgJAk/IiirvdwGjVJqf1z9I7NlknbqllKcoEVxjiFKOVsRi8H461tX9
 CnqIsVNHozTnB/XZL6i5GqfOz2m77ZDUB5Bpc8iTuxrxGRiP95ONKY0Pk52gJc8TE51LK5P3U
 kKRUdObByRrAaK0s0/LkEgjrUzuG5+TNHPlJzsbME7T7UV9kMEmaCgwAWZL89ro7yNDdzq0Cc
 QHd5VPrPlKiSZAxs+ylHX02LlYebeJ8E6n7JPRs9wriS2qE+L7HeDS6ZaUKC91zFtVJWQtG/+
 QMvlaOOkV/h1NZXqPDsdX1+KGBHkkcOgbeNauISjHxI8642NkFcpx1lJmjfcLgO4SBBP6yZcK
 MN4eo4kYfIwDNLIDdBRB+ixYd0B4Lka58g22lTswMpKZ7r1lTrjqUa4VcdBQtSX/Q3ycrHqzJ
 vPUigmbUdYAKp9Y2DpaSVnCxm6fvK4zjvt3tXkGv0YIE4TruAizLDC3Uon1Q+1GhUQB/tCv7o
 h8+27BK1dJR/uN90jBiysbM/Er/NS3OUWpT1912rGyRMQerN1fvl4PY2SNQ1ZpZ3FYmdOzCiv
 NKZc2gGxAjjQFKQuumVoh1ZARsT/UVuuPIEuF2PbWAq0It9t/AP4Sdnf396PtXF4HFzJ+DMyz
 wK7gYBi5XNPcVU36AuNfzpoac4BISn0wwE+r26QtUFjsPaDAQIWmnOn8hHHaw+vquaTZy0s0V
 dED2hgDYKTOabIqkSeFPLwjE6cxIgTX+xLkxf/BuwGtFfful70OQ1imzEwLx3YlLN+zj37Msd
 TKjIWhHs9yTXdVCPrtycw+/A==
Subject: Re: [cocci] Challenges with selection of an SmPL Python version?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1912
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-10/ced9a857-0da6-4cfc-ad35-9095ea20771d%40web.de>

> I adjusted this SmPL script for another source code analysis approach.
Another command parameter should eventually be specified for the desired
data processing.

Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> spatch --pyth=
on /usr/bin/python3 drivers/base/auxiliary_sysfs.c =E2=80=A6/Projekte/Cocc=
inelle/janitor/list_free_attribute_usage_incidence.cocci
=E2=80=A6
SPECIAL NAMES: adding __free as a attribute
Using SQLAlchemy version:
2.0.32
HANDLING: drivers/base/auxiliary_sysfs.c
variant|incidence
kfree|2


Will any corresponding discussions become more interesting?

Regards,
Markus
