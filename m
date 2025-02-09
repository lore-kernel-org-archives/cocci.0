Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07EBEC02199
	for <cocci@archiver.kernel.org>; Sun,  9 Feb 2025 08:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=YYjlvQBxsHOQrhPSbjNBbWzvMD7tWRk6L3IIHT3i2Mc=;
  b=YWpmZNg+yDvC7K1lDzGQLigIbPrIHeyxOpos3wt/OF+qZgK33Hlp9Z2h
   VSoqbHodUH5LRIXTaLFCvlbje9Fmy97fUuz15nkB7AOD3iiJqo1q68ZKa
   6rZOfizbTha1Yq+FhQEWgxi/NB/p4wmgOmmuP4YIxBy6nvAaRaZDmpiqo
   E=;
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
X-IronPort-AV: E=Sophos;i="6.13,272,1732575600"; 
   d="scan'208";a="207326796"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Feb 2025 09:42:34 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D57D9E0D1D; Sun,  9 Feb 2025 09:42:33 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 5C0C9E0260
	for <cocci@sympa.inria.fr>; Sun,  9 Feb 2025 09:42:29 +0100 (CET)
IronPort-SDR: 67a86a74_PcQhQRB/SuU5w3twItpCdOAF1g4SiSvj7ALCNcyos8BFfNy
 BxR15UvCer506aJFVTYUzImqP6MPDaiJE6CSRtA==
X-IPAS-Result: =?us-ascii?q?A0GvAwD2aahngAQP49RaHQEBAQEJARIBBQUBQIFBBgELA?=
 =?us-ascii?q?YJDgVczBAtIhFaPT4F0MIQ7hzuHU4h1gVaBfg8BAwENQQECBAEBAwSFAAKLB?=
 =?us-ascii?q?AIeBwEEMgcOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABATsHD?=
 =?us-ascii?q?goxhXsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CR0QBAQECASMdAQERJgEPCxoCJ?=
 =?us-ascii?q?gICVgYBFAEBgn6CMAEDDiMHr3+BMoEBggwBAQbaXB8sIleBZQmBGi4BhWuCY?=
 =?us-ascii?q?wGGJoQ8Jw+BVUSBPAuCeD6BD4M0g1uCaYIzhEdnmleJL1J7HANZLAFVExcLB?=
 =?us-ascii?q?wWBKUgDKjYxI4EjBTRBOoINaUk6Ag0CNYIeJFiCK2oEBYEtgjmEQ4RNhViBO?=
 =?us-ascii?q?liBYAMDFhABgjFweByDV3kdQAIBC209NwkLGwY9nzebIrMLNAeCOIFmgWMMn?=
 =?us-ascii?q?1wGEy+DcAGTUg4GknuYfCKpDIFuBi2BXDMaJIM2TwMZD44hhC3FGEI1PAIHC?=
 =?us-ascii?q?wEBAwmFRgEBiwCBSwEB?=
IronPort-PHdr: A9a23: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
 NTCxvqbwNhq7N/eu8cRVZG8FQ==
IronPort-Data: A9a23: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
 IT+eYyIrIxXh6I8/QaMtkO5wC0kgQ4=
IronPort-HdrOrdr: A9a23:0xt28KgM0CIYDoT5IqxILYdxfnBQXg4ji2hC6mlwRA09TyVXrb
 HLoB1p726QtN93YgBZpTngAtj4fZq4z/VICOYqUotKMDOW31dAabsSi7cKoAePJ8SdzIJgPM
 5bGsASNDSzNykZsS+Q2mmF+rgbsbq62ZyJwcHD0nxqUQZmUK146RxlYzzrb3GeCDMmOXIjfq
 DsnfavSgDQA0j+5amAbEU4Yw==
X-Talos-CUID: 9a23:duDa2m+/Be+fUNc/9QOVv2NFM8cnc1Dl9mWTEgiBGUBXYr2ebVDFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3A4EUVHwwH4jDPrN7qTBZeK+jKSQCaqIKfGkIzg5U?=
 =?us-ascii?q?jgOerbA1SZQyZsm7oRbZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,272,1732575600"; 
   d="scan'208";a="108582440"
X-MGA-submission: =?us-ascii?q?MDEy/7nTQdOKGtG5hiFEl6BtL7mxprQTL7tIzS?=
 =?us-ascii?q?yPGRe4mRTG8+v5z7DHBEsjd85srQ5r0+eXuPLgGU5pg+eQffuovuiimg?=
 =?us-ascii?q?vbK00GYPR0GiwxFZXNY0/d6QnFqXhjsil7o2h+crCsskKLqHp7ob8sC3?=
 =?us-ascii?q?20e0HWWhhbwEXFY8NrMSedzg=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2025 09:42:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1739090547; x=1739695347; i=markus.elfring@web.de;
	bh=YYjlvQBxsHOQrhPSbjNBbWzvMD7tWRk6L3IIHT3i2Mc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=QjpfxLyF6rlMYQ6a3j7CcKLv6DyYO50Q9qTL9xEkWYIvg69bpzuO0H9NhiCWp1L7
	 DRuX2vsqdR+tEpYjKoBK05YyaYF02NSmz6cZhnFmZLRiDz9KxnEefM+XuNzXqcIIu
	 G8Yb1lMPdMr3JRlYHeapHyV7LtvWmIXRzKEx0V6SueBjspXRA+PbIbqXfS1PPH+uF
	 EPJY7b4t+NSdkxOvw5yQOVeTQM07vThHgmvnKz6Hndvd/GT0Uamh/ew23/UAMMdZ5
	 9JHZxGEqYuoGuU3ffxXbVMdnHq6eLv4LI5v5DacbplKAqrOFg+DxIBat0v/eSTi3a
	 egXpJTGbO7kgXEo08A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.5]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MgibY-1tBIZr1XPI-00nM4i; Sun, 09
 Feb 2025 09:42:27 +0100
Message-ID: <63fb712a-6736-4f58-8c27-8c3cd32a9115@web.de>
Date: Sun, 9 Feb 2025 09:42:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <381b5a9cb89cc068ca13546f69636291874010b3.camel@sipsolutions.net>
 <061f1b6b50d305671c02742382a3df0ff95f9c6b.camel@sipsolutions.net>
 <ca7c1a14-522a-9c2c-4f85-2fda289b83e8@inria.fr>
 <9063a6e6c83f9169456bc009cc35426889cc46e1.camel@sipsolutions.net>
 <6bbdaca7-2fa0-4bdf-bdc7-ba76a5a1d171@web.de>
 <alpine.DEB.2.22.394.2502081257090.15422@hadrien>
 <e25d4a68-1ef5-4ceb-b3d8-b05dd9ed512c@web.de>
 <alpine.DEB.2.22.394.2502081642570.15422@hadrien>
Content-Language: en-GB
Cc: Johannes Berg <johannes@sipsolutions.net>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2502081642570.15422@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lj4y2+i0Q11ajZ+AmVe3D29a7ir+R+vdTIg6roQrxEn8OKyCyWM
 v3E10d488ixzNke1t7GsgVgpbkX5dh+nQ73NgvQtx1i8e92l17uyYnhMLWhCBJu5xp9f4Vv
 KH03Nc46fVhss6uno04pkBkniX91lZYfiqwzcJN0b2Y88gbKzhoQ3K8NAYaX2NjAyjzAvlS
 PKamHYpcVXAbO6z4aYKcw==
UI-OutboundReport: notjunk:1;M01:P0:5tOsbLFlrQw=;K8GjPyAHj+RSqKELc5hW2D1ybLv
 9TGpgz+ITxhaTCTFAFtmPZ+fser7gJLkBWZzsFY3EBTHwYEoRMOO/p5mqTzA6ZJAIWbJAEkQ8
 kHB7+sTMAo6QLxIDAHwZ7D7U2dbM/ipTo3IcUrCbFuXUUa+fcgHKHiz+XyrewiwZQBd36gWBf
 ZGXfcvbr3sFwQVqNjUBb7YPZiElA7WcRczZ0t+I2YJCbWC/BPabCDN0v0nXFNE2DsKO4W3PQ1
 fTkCWF9JifwXVEx4a7A+nvKRs8gXKhI2pP+YQa/qXcDhuFvxU1ACxhrtpT8HS/eDVDRqO+a3S
 OqQVGw8CyQrmIbTVPaTn6eTXWtE/E53cVq2MBG7UmBH6kG4GA1FcXxvsfKJmW9yVg1z+qwC3d
 x/4JVnJAhHeSdPEulHeCq36LhlQfqM0fbxgjGcDTX8cZCkHOzq/R30ntHRyp97dyjqeT2X/7P
 7SCIAr98yV53PMJOA7BeEYY0sGJ9EruMsWH5NPgrfJzyBDysn7uLr3dL/cCdC7l/ngtV97/G/
 8vCFFLET806tYd0FTJJumpzZkU1bd3NSei4RUYY9Tjns3r6rqfP8UVlWcu40JJpT/ZFx9W0uB
 dOKge2pgchdsyPdXxC1/SOhcX4xojPI/v0oNeGrBVyZ1Hfo5BhWryCfMVEaoHzr1meNMXzweR
 E+7nmTeDXUsKQD15nTUG2VQSyPUSfHkETmwfqE2YdxS6zYZ5j7u7QJv4Z9OI8PQLr9Xr/OAwK
 uXR7Yvi5j5bEK0UcgYeYGNsPlocU4WGC2ZduReM3C2E328dUcyMVf8+03v34zXlsstriEhCqC
 7P9cuFrlLzbpw13cImYEnfbtGDkZJk+X7gz1tJBd6pImloVza5uQnunanmbeYyM/DdWiT/DK2
 r6S5cT69AvhAQ8deRSGsWN6GvSktEIwFMYEccu6kIeIak/esx1TAg3k4nmdrhNykRCXWCb0fG
 LgsMUoQnLAuiedSeoU3VMDzoDmlqQXC+XNHqXUjuwAGz4gf8YP22+OYyCQMLtzPMVOmLMk1jY
 QFUZjKdhncQLXVQ6ma/yiB1chk8H2bLULyUTbESB4mzrfCG25qyQN1B5CVigq0BgO7fG2XNZM
 WDZcFZyLXdqFVihmBeFLmE7TyRyYAdsY+R1JmQDu8oWLDAyGwHqw6vvUTAwmyYaY7BlU7IsgE
 KjzdpKbiLCorcLqDBJKzEBdPXpUCXUQBLzszOG9HHKLdo7wf0MPGmhjZaHjSa6IbxoOpVhqkE
 8t2tY8WU2LzYZBZqHJTN47aZepeW1yD7cGpUp529pNvllbazIA4wNl2bk6ZbvtDZs21L1Gc8+
 z7YTZAwnlESqF414FeSbhLzTIDI/j6baThAp4/AXBfrVVjLejdYOAOAuWJuLtwedia2TWR/Yn
 2wcB3Nkvu+DUfjXp68q9M9THMyRklfTp3sf/v14fuEC3WASlyOUgYv8MwUvdcbkmdvWHKjRpS
 ceayPBg==
Subject: Re: [cocci] Checking SmPL test cases?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2376
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/63fb712a-6736-4f58-8c27-8c3cd32a9115%40web.de>

>> Will further collateral evolution happen according to a test result lik=
e the following?
>
> Now the pattern occurs on every control-flow path.

I wonder still about involved implementation details because mentioned tes=
t cases
demonstrated different data processing results.

Regards,
Markus
