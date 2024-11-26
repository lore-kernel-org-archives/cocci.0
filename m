Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70202D65537
	for <cocci@archiver.kernel.org>; Tue, 26 Nov 2024 17:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=/dDwNS/Zf3OaE5A/LdngQzVAgvJWN+izk4OxjUDvPK0=;
  b=C+WGEtBydxwm06jTuzXGow8R7k6Sp02YX7Df7avm2F82m1sSmm57mzoN
   vQWzPXxno64Aci0YaqDQPcN+PtVDV6bIc0XXkZJVBfP7slTiWtIGkgBMa
   Urnpr51SkFSUD0Ac35OR9KdaAnnDGzWwzp/63oI3DcjxDbik3kpznW6qK
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
X-IronPort-AV: E=Sophos;i="6.12,186,1728943200"; 
   d="scan'208";a="195940297"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Nov 2024 18:50:50 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 235C8E0D1D; Tue, 26 Nov 2024 18:50:50 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 7790CE00B6
	for <cocci@sympa.inria.fr>; Tue, 26 Nov 2024 18:50:46 +0100 (CET)
IronPort-SDR: 67460a75_rPU0yedhnnku/vMO7bGNYqr9aGszLyN02/8AQ0VQf4jJ8zl
 ddETKcJ7J1MjTFbOJ5uLuBOE6vA3vJVjnBVv6Mg==
X-IPAS-Result: =?us-ascii?q?A0HhBABYCUZneAwR49RaHgEBCxIMQIFIC4JEYhsGVDMEC?=
 =?us-ascii?q?0iEVo9NgXSEa48RiHWDUQMPAQMBDTkIAQIEAQEDBIUAAopcAh4HAQQzBg4BA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAFDDgoxhXsNgmIBgSSBJ?=
 =?us-ascii?q?gEBAQEBAQEBAQEBAQEBAQEBARcCDTpEAgEDIx0BAREnDwsaAiYCAlYGARQBA?=
 =?us-ascii?q?YJ9AYIvAQMxBw2xCIEygQGCDAEBBtpbHywiV4FkAwaBGi6FaoJiAYYkgkGBe?=
 =?us-ascii?q?ycPgVVEgRMpgwM+gmECgWCDW4JpgkSFDyWIGGibXVJ7HANZMgFVExcLBwWBK?=
 =?us-ascii?q?SEsA4F5Tn+BNoFRAUKCTkqDLoFeBTdHgkppSzcCDQI2giQkWYJNgSUEBYNpg?=
 =?us-ascii?q?QuDXoRbhigdQAIBC209NwkLGwY9oSZHglVsgUGlXaJsNAeCOIFlgWMMiieVM?=
 =?us-ascii?q?gYTL4Nxk1IOBpJ6mHsijV6bKIF9JIFcMxokgzZPAxkPjiGDejPHTEI1CzACB?=
 =?us-ascii?q?wEKAQEDCYVGAQGLVoFLAQE?=
IronPort-PHdr: A9a23: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
 dXF0q7+em8qzg==
IronPort-Data: A9a23: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
 aUIqbh4fXyG
IronPort-HdrOrdr: A9a23:YfuEY6CgVPStw8blHely55DYdb4zR+YMi2TDpHoBLCC9Ffbo7v
 xG/c5rsyMc7Qx7ZJhOo7+90cW7MBfhHNtOkO4s1NSZMjUO2lHFEGgK1+KLrgEIWReOlNK1vp
 0BT0ERMqySMXFHrYLd/BSyFcomzeKK6aaymI7lvg1QpE1RCp2J9G1Ce36m+6BNNXJ77RFVLv
 Ch2vY=
X-Talos-CUID: 9a23:teDzeGO6loXI6u5DdyM7s2AtKvIcLD6F4Cn+fhGJKD0wYejA
X-Talos-MUID: =?us-ascii?q?9a23=3AazvwYw6NMnomZXSTvvxxo0NgxoxZ0ueLAnIVraw?=
 =?us-ascii?q?rqsW5FAddOG6MnSueF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,186,1728943200"; 
   d="scan'208";a="102699817"
X-MGA-submission: =?us-ascii?q?MDG54dyMvcPzS5Te+MdYKVYwx3MhtQf3x+kYyi?=
 =?us-ascii?q?Lhoaw0rpbOBbbltHdQwdCffUeD45EeAKxS2Nv6JlEk9ijZ/BUfEaqVLd?=
 =?us-ascii?q?rrWZagupKvxRxfod1ihZs1K6X3ZFBuT+Ot6dlMh3WeVbY4beXN+mtv8K?=
 =?us-ascii?q?L+iyDl4A2Gs7Z0tQkiaEK0Uw=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 18:50:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1732643444; x=1733248244; i=markus.elfring@web.de;
	bh=/dDwNS/Zf3OaE5A/LdngQzVAgvJWN+izk4OxjUDvPK0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=OZh7zTGrl3RLcfy+so2xWr5MZ5wBl2Jo/qbxc/wcHxdpftPYPlvE7An3gJlC6WOx
	 vHFnsdRVVLf9jm5HOL7YEu68GAwFoSZQnr3qoXVFUEKJRDgiVl/n1OltS9fsbApgC
	 uauQhqh+T6JC6WXiFQfGJiJKCM5W7mkDv6izI0mtMba6P9K5/4vcy4WGT/ZYmySBh
	 FciR7pIJRUBUua3tCTPwJCwkc16eK5fl+Hb+Ykkz4NpxT5VNaz6c/WM3sAkqHWnQ4
	 OPii0Xywu3XqwyDh1RCLIFjRbZsq/OrFi9GZpc9WDrtriUGW7BnPSwJLX5JMLUih9
	 AS0+Cu0+V6e7RpCpfQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MGxMP-1tSy7r37bv-00BAi3; Tue, 26
 Nov 2024 18:50:44 +0100
Message-ID: <81d0c6e4-0d7e-4f40-99e5-d4229613348d@web.de>
Date: Tue, 26 Nov 2024 18:50:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zack Rusin <zack.rusin@broadcom.com>, cocci@inria.fr
References: <CABQX2QM+cBpVhcBYRae+W4n5a6bVJ=sC+zu9GGj0veiqvU2_4w@mail.gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CABQX2QM+cBpVhcBYRae+W4n5a6bVJ=sC+zu9GGj0veiqvU2_4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5/IuIIrZrR5DKfvcooWJjYTSDT7jYeolyawn+/671eU8bgx9VYf
 OqX6/uhIBOlOphQ9Mk7GADluw1saH+I5iQ71enselRn9da9dtSdymM54daw7nZqzMYUHvUk
 z2nD/szNDobJy7i4o/88GByw9CKjNn9ERJtj3Enc4AtevVI1a71dnljnYNXKnIYYgGXVrHB
 VVW1raRowSql8X4CLIyCA==
UI-OutboundReport: notjunk:1;M01:P0:VXuWcGrD72g=;eoot6XKyGQfc/SMBpTpv3Qb47Wy
 srPCcPIyX3DdGQLva4pRDgWSyDJNVfUdBWsTw315XpxP0wROuJxMUjI2cpM9yVkVn5Z/o53ml
 oFkEWgUg1N1QBciEpqSOX/EanNRxcV03WH/54MllZE+5hhbqB/qN8g1gZ8cut2UaKE5wnNGKb
 UzEuytYzSI7UFauHPOGW67whii1UqKbcEgHsmoA6nzneMlQSIaYh7IL56DMo+5k2UFKM/NPen
 2DsSBK+k4bI7aWS+gWTkzgVUdeKpe1ANR2UK1r+s8RnEa4pHDcpYn/kCs9Rm+MUIFIl/43SsQ
 uVlwgIcqIzHapNnTjzPhTzj16byV7LKrU3TOtacgV8bbp23yBmt1vrDIWkYOH8wVsE6neMlhP
 Chjzda1O9mQB44fSjbmHRVORFdi2lGSYRECKPH5UTJrNaL05cfp5meoEBaRrdgjsO4eiVrY+D
 isAGaJ1Ro1qwaccg70SgRXUR0LN7A5haLpbsw0DDUKTtrM5gJKcGdAIMS2dnkL4AFxdfwtGzn
 qQsYdOR4gAK5AwhmGHC4TKgkE3Qw+yPX6X0bIOkL2pIr7VO+60c68txLIUGLdl1jdchzM0asX
 wFu47EipAoaqOhRpNFoESSVlRcdo+hQoLqdOlvbkhGM4+Rht7394uwCpZO9qXGac8Wnjui3bI
 olvEz//Sp/w0AHs7igXQHnophCxpNmd16Cv8/8FXcJomFq8JP+/wQf7WSn/mKOB6a/vudrLMX
 R9hIRyHd9EeqD7d4MipYedmIfoYHgRaFwH1v92spP064eMCPi3ZKagbmkhkkg+OIblaGh3xs7
 41NuGZF1sxxgrofHdZPRqpxeIiiyqHoIO2QDd/AhnJUa5HksNWeSev86/QVCYuspsW0fU6jTo
 XV85x7vpakdUFcBN5trzt+DqbXz/zvA7QkyrKxzzeXteFUOIFMcYthjQO
Subject: Re: [cocci] Replacing type names
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2131
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/81d0c6e4-0d7e-4f40-99e5-d4229613348d%40web.de>

=E2=80=A6
> My input script is:
> https://gist.github.com/zackr/198db11e5e5243adbdc59b9844d8eb6b
=E2=80=A6
> Plus is there any way to transform arbitrary function names? =E2=80=A6
I suggest to take another look at corresponding case distinctions.
How would you usually recognise that a name belongs to a relevant function=
?

* Would you like to search for function implementations so that their iden=
tifiers
  can be adjusted?

* Are you looking for any additional metavariable types?


Regards,
Markus
