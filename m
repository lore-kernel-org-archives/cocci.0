Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C4E1C4828E
	for <cocci@archiver.kernel.org>; Fri,  2 Feb 2024 12:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Az8P8oZrXb9g4KikO31PGfJgXV4zVt+I7TcMIkiMNmI=;
  b=ifHcpWr2fR+9XtxBtBdNdiS3orqzG3Y8OgO06D9zKx/HODdjPMCGIn50
   t46TpGAc0xrK/dmgSJSOIIpmbeSC497ug0fhY7x9BGHONFc2C5LLc4N7c
   /Omj9X4gyhjurMO3TZ5by2V9625wSE7AI54B3qz+3/5w82KAHnIjK3FyJ
   8=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.05,238,1701126000"; 
   d="scan'208";a="149973463"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Feb 2024 13:27:15 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1E497E0CDB; Fri,  2 Feb 2024 13:27:15 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id A6AF6E008A
	for <cocci@sympa.inria.fr>; Fri,  2 Feb 2024 13:27:12 +0100 (CET)
IronPort-SDR: 65bcdf9f_0yoakmBcnllXwh+oq566qPp8179thy7QdWnvOTXKwdiJ0cw
 /9rcSiYFgaB547UGLo3BjMxpDYKDOdWB5D7XFYw==
X-IPAS-Result: =?us-ascii?q?A0G9AgCZ3rxlhwQP49RaHgEBCxIMQIFEC4I5fFYyBAtIh?=
 =?us-ascii?q?FOPQ4F1LQOEO48EiHCBVoFAPg8BAwENOQgBAgQBAQMEgguCLkYCh1UCHgcBB?=
 =?us-ascii?q?DAJDgECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGAQIQAQEBIxcHDhAnh?=
 =?us-ascii?q?WwNglwBEIEMgR4BAQEBAQEBAQEBAQEBAQEBAQEXAg06QgECAgEjHQEBEScEC?=
 =?us-ascii?q?wsaAiYCAlYGARQBAYJ8AYIqAQMOIwcNtXyBMoEBggoBAQavWh8sIlaBYQMGg?=
 =?us-ascii?q?RouiCYBhW6EOycPgVVEgTyCUjE+gmEChTuCaIVWlTpUfx0DgQYEXA0bEB43E?=
 =?us-ascii?q?RATDQMIbh0CMToDBQMEMgoSDAshBVUDQAZJCwMCGgUDAwSBMAUNGgIQGgYMJ?=
 =?us-ascii?q?gMDEkkCEBQDOAMDBgMKMTBVQQxQA2QfMgk8DwwaAhsbDScjAixAAxEQAhYDI?=
 =?us-ascii?q?hYENBEJCyYDKgY2AhIMBgYGXSMHDwkEJQMIBAMrKQMhdBEDBAoDFAcLB3iCC?=
 =?us-ascii?q?YE+BBNEAxCBNIVQCQMZKx1AAgELbT01CQsbBiIBHQKbIwGCPAaBOwkZLIFvp?=
 =?us-ascii?q?AyhFjQHgjSBYIFhDIoalRoGEy+DcpM7DgaSXphVII1NllCEM4FjOoFcMxokg?=
 =?us-ascii?q?zZPAxkPjiAZg2Ezj0dANTsCBwsBAQMJhUYBAYMmLAiBRgEB?=
IronPort-PHdr: A9a23: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
 m3eo4w2y7lJuvaCwHxrXUgXwgs=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:D/GIz6CzGtz5r6rlHely55DYdb4zR+YMi2TDpHoBKiC9Ffbo7v
 xG/c5rsyMc7Qx7ZJhOo7+90cW7MBfhHNtOkO4s1NSZMjUO2lHFEGgK1+KLrgEIWReOk9K1vp
 0BT0ERMqyTMXFHrYLd/BSyFcomzeKK6aaymI7lvg1QpE1RCp2J9G1Ce36m+6BNNXJ77RFVLv
 Ch2vY=
X-Talos-CUID: 9a23:2KPb1Wzrts0wjAAKuqSMBgUzHuYpInuAk076HHSmTkhZE73IVmeprfY=
X-Talos-MUID: 9a23:PQpTpgoFR2247IOcNp0ezzReDu135YSNMk9Xtb8it+racgN6JA7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.05,238,1701126000"; 
   d="scan'208";a="78569314"
X-MGA-submission: =?us-ascii?q?MDFkzeZyPRsm/WnjIlyScl2qUxLntHlWFCR1Tm?=
 =?us-ascii?q?MQf/p3RswotiCipe42LVOZLRCK3f4YSNkAsu/zgxArMgdc9Djqi5sAi6?=
 =?us-ascii?q?tm+ym0JIfQZhmoFI3PKUG8c9A4U7PzeQhqaXu8Ronh6e8REjnhb/csnP?=
 =?us-ascii?q?E/9SW2IY0vi5xuPkVT13YwyQ=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 13:27:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1706876830; x=1707481630; i=markus.elfring@web.de;
	bh=4BFUXdYgTwsAUaj7pfob/fduHWIW6qzyigKvvh3grq0=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=K4dV3C517BYjzDnV99Nj087Ep1aUDVbUZ46sbASC6AvlrpAwDN5eoRf1Jj7wWUse
	 6sRzVQoWg2QNLSdf7YZawXn/OFBNmfUSo5ziLn+izl/Yalad2Z51mF9zGTvOe1z66
	 BTjgbdR3SjFUmUp9lM3trBK1mIIeF/SVA5UIz47uredRHzBV1KJ87biuIdon+2ssj
	 +9t3xAK8ia/Kjz0nwZJVxcXtrMmRtzVF5SicEf3Brkek4ysams6cEvkfKXRs+GxJg
	 3SaPcc8o7lAlGRbRObNL7YrX+mHxhp4Ry9uiw+XKkrZVqPQyoJf2dBsihUBIgTrcb
	 ZehNSndm30BP9BnRRg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M4sXj-1rVb7R1J39-001y2H; Fri, 02
 Feb 2024 13:27:10 +0100
Message-ID: <f9c578ed-b25b-4dc9-acc8-429ccf182dc8@web.de>
Date: Fri, 2 Feb 2024 13:27:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Lorenz Bauer <lorenz.bauer@isovalent.com>, cocci@inria.fr
References: <CAN+4W8jQeU70dRrEokYxomCBdM3cFmbxBe2mXnsTg4nijTJ3Sg@mail.gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAN+4W8jQeU70dRrEokYxomCBdM3cFmbxBe2mXnsTg4nijTJ3Sg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:o0dPkTp6Z+FbxrHxldR/sSKmSJ8VvFcpVM6pOuPQRUm8y8Tjxf7
 2EOmGOF/DEBHgdKV2WILBjDKrhlgBFDNXN1xya+6nuXluqHVY4IJK5vxBFVtqa2IFAu6NLF
 GxPAkrjIBm3kv5VnOS8SId2lFT8aOT2B1i0Q4ENHND5IyNx3LJjg12MmqceKrdMcwwyndBb
 1AC18wR2AR/0NB5v6HfXg==
UI-OutboundReport: notjunk:1;M01:P0:62JTF1oFhaI=;YJZQQ1qYYiz7HUVvPG8OBayjEyM
 I1wdPyXALNvhiY9K4tuxUr4cmrt1PmPkhJHD2XGj5dmMXMhgu8KzeDWg5z4eVkl7B8zaRpy8e
 sskUT7AtY4bFf2NQuPAe6LsnrDSY1n/GgE/dw/ZzR8p0LGCm+kDYwsuFKsHVODshu3e3+FrZl
 LLBeVccnWdUyY35o/ncYDplV0+pmYJYADpkHtOoN5t4diuLSf7tEN9GLdpat1INOwG15rtyjV
 kywr1CnESrPiWYHCrT0yb8xTbbuuex/ZKI4AXAB9JRcoERbunNRnMov/ZUVUDCYhcPQJYMZfZ
 SFxRUXpd4Yv+uX7aAomDS1BxwZDeGPdJuXa9/OvTboN4ZjIHH9xUNVaOu1FMDUNGcN+on0tzF
 6xzqcO2LxPb+/4sqIbzU+98R1949Ihnjc2mDL2FZ0Cf5gaRDE/xKiTk6l0eKvNfNLc1p5th7R
 OE2Q8x/iSPe4b9b85MBZoyJARxwojVeVnn5bx9ay2e2fWZ79j7Tp+lDzjCL+npzR1dQFzAiPZ
 ddRvkk/0Dymbr8WbCwgyD8bVbQpMR+FDsK+ACZtH4+119wJH+6/pqbm8zF6gdSYS97HBFHJ2t
 NZkBi+VTSoIl0uf1d73b8KrUtPZOCpIiNATkISpeN2fkAVrfUAFwAg1hO1nM4HF0kSZaQJPa7
 qM8QJLTA+6BwvJcUL/NQV9gYzMZ5b+xEi7eAUiq6Hx/iAV1ZIsYYMIH38pchDVAiRtRB1LsVh
 JCrgqi1/6/ETmw6WNN1QcRHaAuJqwoYrTAlzkTgvu+hVUCYtiLrmFjoN1BFyXuYjCC/EfAZSU
 m9pE0c3CQgZa5ewdfjcpZu4gfo+4WZB/RoV5xwgGkpJmw=
Subject: Re: [cocci] Refactoring C preprocessor code with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1495
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/f9c578ed-b25b-4dc9-acc8-429ccf182dc8%40web.de>

> Are such transformations possible with coccinelle?

Theoretically, yes.

I suggest to increase the awareness for corresponding case distinctions.

* The discussed software is evolving.

* There are some (temporary) limitations known.


Examples for further development considerations:
* Improve support for the handling of #if conditions
  2022-10-29
  https://github.com/coccinelle/coccinelle/issues/293

* Inclusion of preprocessor statements into SmPL change scope
  2016-08-06
  https://github.com/coccinelle/coccinelle/issues/72


Regards,
Markus
