Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1DD1C021B8
	for <cocci@archiver.kernel.org>; Sat,  1 Mar 2025 13:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=gc4KxkPouDAb5h9niEE/6HfREvdTQqDTNSVYEU0/tbQ=;
  b=KoWfao4PZIAT/zIjDjs2GCpX0VxvCp1D1RcehmEeW/DtYhdYNv0f/eHy
   6fjsqOtjhXgTHyEDRGAp5xPA6QG/VHNTFkdgaupuSBDSClo5cYB7uFdea
   yfpjoojfHhXEbChiSpgQP2qHQhLBbBgVaGwEUx5XSxlc9sIoYx4MaMFib
   w=;
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
X-IronPort-AV: E=Sophos;i="6.13,325,1732575600"; 
   d="scan'208";a="210690078"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Mar 2025 14:36:25 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E3C68E0261; Sat,  1 Mar 2025 14:36:24 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 06A67E0260
	for <cocci@sympa.inria.fr>; Sat,  1 Mar 2025 14:36:23 +0100 (CET)
IronPort-SDR: 67c30d56_8vS/qcPSiDPeHoaJtLw9HXvvd1aTxVCOAyzX3gvDXrt14/G
 tIz08/Y9J7V2ORcG8ZbPfDVZMDbkCaRUV/58VXw==
X-IPAS-Result: =?us-ascii?q?A0FKFgCnC8NngAMP49RaHgEBCxIMQIFIC4JEYnUzBAtIh?=
 =?us-ascii?q?FaPT4F0MIQ7hzuHU4h1gVaBfg8BAwENQQECBAEBAwSFAAKLFQIeBwEEMAkOA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABATsHDgoxhXsNgmIBg?=
 =?us-ascii?q?SSBJgEBAQEBAQEBAQEBAR0CR0QBAQECASMdAQERJgEECwsaAiYCAlYGARQBA?=
 =?us-ascii?q?YJ+gjABAw4jB69agTKBAYIMAQEG2lwfLCJXgWUJgRouhWyCYwGGJoQ8Jw+BV?=
 =?us-ascii?q?USBPIMDPoEZgyqDW4JpgjOEQGeaDo5bUnscA1ksAVUTFwsHBYEpSAMqNDEjg?=
 =?us-ascii?q?SMFNEE6ggtpSToCDQI1gh4kWIIragQFgSqCN4RDhECFUoIRgV0DAxYPAYMfd?=
 =?us-ascii?q?xyDT4EthHUdQAIBC209NwkLGwY9ojSFPBMLyH00B4I4gWaBYwyfXgYTL4Nwk?=
 =?us-ascii?q?1UOBpJ9mH0iqQ+BZzqBXDMaJIM2TwMZD44hhC3HZ0I1PAIHAQoBAQMJhUYBA?=
 =?us-ascii?q?YpUgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:K8re8aAGbI8n79DlHel455DYdb4zR+YMi2TDGXoBLSC9Afbo8v
 xG+85rrSMc6QxhIU3I/OrqBEDuexzhHPJOkO4s1PKZLW/bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QEZSWY+eRMbEVt7eY3CCFM5IH3MSN9ryuiNzT1nF3UGhRGtxdBktCazpyCSdNNXJ77HcCZe
 ChDkErnVCdRUg=
X-Talos-CUID: =?us-ascii?q?9a23=3A7IUHRWhBmEHkE8q/v5cj6Z72TDJuI0Leym3IP0m?=
 =?us-ascii?q?ELGtXUoHFW0Kt5opZqp87?=
X-Talos-MUID: 9a23:d5XAjQmzu23VN+9na9mndnpNZZdru66OCnomvpkslpKfPnBuGGmS2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,325,1732575600"; 
   d="scan'208";a="110394634"
X-MGA-submission: =?us-ascii?q?MDFZncZVUU0TikcKtTvmE95ca26cx0B2QhTb+l?=
 =?us-ascii?q?FpsrFiCF194JvUiL7cNRLR+TKaA7CuZOdTVXXuuj/7LLvGtmNsPTLn9R?=
 =?us-ascii?q?pJfoFrOV0T/QbnjnY7b9Zj7y6gqNjuiMICCvRJXr3uTKaFVPrXlpctkV?=
 =?us-ascii?q?dxPGcEWfRkquFFNBAJXgUbEg=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2025 14:36:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1740836174; x=1741440974; i=markus.elfring@web.de;
	bh=gc4KxkPouDAb5h9niEE/6HfREvdTQqDTNSVYEU0/tbQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Z3GGFUP4dlHfXG7W3lh2sQFPq8gxwsFzt0mhBzOyaAjTySQv2K+RQJBxTvruvamm
	 bvNdNYzXHep5U8vzUyVVTKBs1hpmgjS7NediulNqRE1JuYwAkdytavYZ93zp0GYMQ
	 9ffCE8Do3GRKvzS3cVN9LXB6tt+I7EoOTbEl8/a9HwYAMkgEJMvTpDVdKjC3QgGS3
	 CmfQbJoN/guXF31i3O/0SPDlBuDQojJWL0KPRBeOkMokH2y0xBwrwhtycgZId+L4d
	 j0TYROsiWcVjiuH9I1CHlEq5uM70xH4C+te3IFPZT3OYi0brAF6QvfxjW0MBONdqu
	 2TLFmQxBMfkbKIGWNg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.42]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MQxnv-1tbWpN2MT9-00X90E; Sat, 01
 Mar 2025 14:36:14 +0100
Message-ID: <410c55e5-0a41-4c7e-84ba-55e936795813@web.de>
Date: Sat, 1 Mar 2025 14:36:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <Z7zjkyOeoPNYeOR3@blossom>
 <alpine.DEB.2.22.394.2502252132540.3444@hadrien>
Content-Language: en-GB
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2502252132540.3444@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RkSr684dPg1ZD/n4FbpIz91Qzk1gIBEcrT5ghHBREnPz7PmUuI0
 Xvqk7hZlM4WuhjHj9K4+ao0SoFbHbt6YWPu6C8qxwT18OMYnmArqEEX6Gt2RZSSES8HGrUk
 3dxRz9RFEQuOCaasqdiiyw3cf9WyOSvp5nT4JJhk5xV5y978PJYBX8Qe4DrHHRy12O0cMCV
 4Ej4HTUwKNU/IX5SQ6WXQ==
UI-OutboundReport: notjunk:1;M01:P0:HSlFTqROjgg=;4AIRNgdw3uMHT4+bWgeSunz0yZl
 zc6wkcS85UrjrKIq52XbZJhpP3nK7snsEILX01T0GBJ1Yf07sglo2B0gyl+MwwtWEioCzXYru
 bS4jUQZpwAENWV7+L0MzequlIEnnhWiXlPfY5CCDuwVx9nJp8qRZo60Y523oZ0ukI6jOFreWa
 J/likJdC9KSm6GMTHiaZylIJqru4UftaUXHoZj5zOVX2x4c7P9vWLN4IKTC/9ZBFF5LsTdFMS
 2zwJSH/cqO2RtQCXarulvtBuHodHfL/EWt2PM5cfz1JnQFwvHtnF85SO4o4lzIUOjKswAjTjw
 KVxF64vn5gs4NvsvVSba9T7vppOB0Z8nlH4l54bdJZ+FgECbBZzsi7DevfBrDUvGKy3l7LPgV
 AWbBX4bIpYNS6q0izAWRUto8VemVP04+OBR312rWD5/HJ6rPS1guKCSQ4KRWH0QxOu1PGDtP7
 bB7barxqH1XEOC0gWGG/N9tFgFCc+YSAQdOnwPYj0ozvQCl0l8Osxmw2qxwhhQrlasrffMQM1
 4Ev889YPQPbaz8wUtdvF06lGPcyljf/48mNXBkcnL7v1IWayy4kiqB5K/kuDJvJj88RUknyr+
 +VF+IBXbB08uZdm4KURVjTYiDhO99eMrc71noM7aaf99CqZvn393qKauR2WIY9C4OxuBCbmqY
 kDots4ZgTO0UeqmLUmuQxtoZA49oT+t5nDKLdAfDRuWTYlfRcL+XzadQUH2ZE2iYlqlycj4b0
 5vis5nPDRCte7SaWsiwLxt5xnXR8PEsLFNpsYDA2VbhbRKDxzsY5/wBSnx3Yxa1/VogTHRKdJ
 zXXyQoHcqZPURxpCABB95kFRE5c/t0gSiggSZb0oq3cQFs8QQsHe7ghGWqK+QVK6LfjG1I6by
 NHUKFTKy0cKr8OjqrGH6ZpxGUXfsMbja8xRTsGopIkjTDdP9MpfHRgHjSZGIHPsr3t6yeY0D3
 ZNbSxCxEj5JU9WRlTxdNy2pRaFoK2Jgc8YRIZhH8jSsygBEb1X/fh1BEhAxcoz5z5H0lQ8EXs
 RtcuxqQPtQU2VhGhaTQwAp6D9s+5LgyU93Rs2kKDBaQnuzos9oDhEyQi/p7UStNMk0HNVAANF
 XY23L4N5tDS5ddhIOPSilGOfIcaLAmKGxBuufRnfDlt/AB2e2s1srSg6QBCkfRo8YCgG/3u56
 938vTR8F7bwyT3xe2HF2103k3ebBZ3n05GOLh2CJuDdkY9yjnAtRzzlZ1EpOm4Cwnx1kAD6z3
 V5C4Mpj7UMJCDrdV/3T7Zwx0oZRAECH2CSd9tnx3tfc9DYafmJG90wckjxySlh/HIH5tB97GB
 e4Wqt2WklxfoqGEybU4lAE5Yrz2+RKMl4xGEx3kZm72KL5G46t1NrpV9zhlb6+IQYP9RCujm3
 nW0aQkvjGMNn36YFEewPlo5zdeb1KpOx5DkHpui15AOv59jkxc/JBJ5MwiklamBCVXjiUOiJQ
 0bgXuYQ==
Subject: Re: [cocci] Replacement of the form `x |= function()`
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2463
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/410c55e5-0a41-4c7e-84ba-55e936795813%40web.de>

> What version of Coccinelle do you have?  For me it works fine...

Under which circumstances will a transformation approach (like the followi=
ng)
become better supported?

@adjustment@
expression lhs, rhs;
@@
 lhs
-=3D
+|=3D myfunc(
 rhs
+         )
 ;


Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> spatch --version=
 && spatch --parse-cocci suggestion1_for_Alyssa_Rosenzweig-20250301.cocci
spatch version 1.3-00043-gcca22217d-dirty compiled with OCaml version 5.1.=
1
=E2=80=A6
plus: parse error:
  File "suggestion1_for_Alyssa_Rosenzweig-20250301.cocci", line 10, column=
 1, charpos =3D 227
  around =3D '|=3D',
  whole content =3D +|=3D myfunc(


Regards,
Markus
