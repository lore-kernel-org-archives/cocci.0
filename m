Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72EDEE77173
	for <cocci@archiver.kernel.org>; Mon,  9 Dec 2024 09:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=hSjFSW8VFWqm7KB9K7LCjbJQfdT57AMuW6ht9BxPpgI=;
  b=qjUTz28hbKHX+k6FuESzP8hYGy8dlvh7kbftOEj7cRXf1Psvc16r3juq
   XziL4uo55iHfY4mNXW38/WPOyJLUP+oTm9Gu8zJ3CFPm67xV5YDP+MBHf
   4TYm+ecj3sDz82xnMNJ2EsP0dp2lYBBXDIs/5f6d1r9X9PZL7JqAGsiFN
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
X-IronPort-AV: E=Sophos;i="6.12,219,1728943200"; 
   d="scan'208";a="198116799"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Dec 2024 10:31:08 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 45413E013D; Mon,  9 Dec 2024 10:31:08 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 360DEE00B6
	for <cocci@sympa.inria.fr>; Mon,  9 Dec 2024 10:31:05 +0100 (CET)
IronPort-SDR: 6756b8d8_cYi4/8IHqnvPT7kpu63H8TKvUTZzxIx0x10qXci5FIXXt3q
 t2sJW//995lNNQNATjg7Z7vuBu63C9f4AN3MW0g==
X-IPAS-Result: =?us-ascii?q?A0F6AQDkt1ZngAMP49RaHQEBAQEJARIBBQUBQIFCBQELA?=
 =?us-ascii?q?YJDYhsGVDMEC0iEVo9NgXQwhDuPEYh2g1QPAQMBDTkIAQIEAQEDBIIMgnQCi?=
 =?us-ascii?q?mkCHgcBBDMGDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQE7B?=
 =?us-ascii?q?w4KMYV7DYJiAYEkgSYBAQEBAQEBAQEBAQEBAQEBAQEXAg06RAEBAQIBIx0BA?=
 =?us-ascii?q?REmAQQLCxoCJgICVgYBFAEBgn0Bgi8BAw4jBw2vNYEygQGCDAEBBtpbHywiV?=
 =?us-ascii?q?4FkAwaBGi4BhWqCYwGGJoNCeicPgVVEgTyDAz6CYQKFO4JpgkGFemecDFJ7H?=
 =?us-ascii?q?ANZMgFVExcLBwWBKiEsAy45MYIFgVsFN0eCSWlLNwINAjaCJHyCTYElBAWDa?=
 =?us-ascii?q?YELg16EWoYmghkVHUACAQttPTcJCxsGPZtZR4NSHYEkpxWhODQHgjiBZYFjD?=
 =?us-ascii?q?IoolTIGEy+DcQGTUQ4GknqYeyKNYJsogX0kgVwzGiSDNk8DGQ+OIYN6M74fQ?=
 =?us-ascii?q?jULMQIHCwEBAwmFRgEBinyBSwEB?=
IronPort-PHdr: A9a23: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
 5cEDLNWBgRd/hIyD0N4AJodLZ0xUj52ydam
IronPort-Data: A9a23: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
 QAIeIyPfK13pYMd3yqtl7651Sz1ZA/S8gg=
IronPort-HdrOrdr: A9a23:nrMwyK0BDe8bJolkr5NJSQqjBGYkLtp133Aq2lEZdPWaSL37qy
 ncpoV+6faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SOzUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyUMbEQt6bHCWeDYrUd6eWmtIa1mOzZ03Bhdg1ybbp8hj0JdzpzXncWeOFcb6BJb6
 Z0C/A33QZJ8hksBPiGOg==
X-Talos-CUID: =?us-ascii?q?9a23=3AmT+ED2rAUB3tU/xv+iom7aPmUcU/XXTZyFrrGEu?=
 =?us-ascii?q?hCFlSFZK/YgWd16wxxg=3D=3D?=
X-Talos-MUID: 9a23:0eNTsgZuADqqvOBTtTK0jQlTH59S6Z+SCRpSzKkhoumNKnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,219,1728943200"; 
   d="scan'208";a="103798697"
X-MGA-submission: =?us-ascii?q?MDGj8y0A6anYZ5NxM7VWPU70EqsMDJbpGTrvQj?=
 =?us-ascii?q?cVX2wYysggNyduCERQrMjxMH24+0rREkEKp/vgqw8DaD3Evaa12oihIp?=
 =?us-ascii?q?FNfgo1gDrZQtoigkXAxz37H20PiYKJ4dRHexHVaBNT/qGccNVpFHMdea?=
 =?us-ascii?q?S6icb+e72P2/sFoFqHYDDwEQ=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 10:31:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1733736663; x=1734341463; i=markus.elfring@web.de;
	bh=hSjFSW8VFWqm7KB9K7LCjbJQfdT57AMuW6ht9BxPpgI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=HUwxQQJ6H0hgeCi9vOhUAxTliV0QEnYLwzK2S9tywspo/se3HKS5/M/h1xoQfWYn
	 yqJG8NB3dNTAwo3stmNv9zhdH5IUBbj5cCrRja9IOUzKYp2J41UEzzbVRYK1I0epf
	 aXLgZnCMNl+K2XXhIhNs0hG+BWDqbPadwXXNLX9Rqj/Q3QfU3lOQeKIUSyHcBgVQg
	 PUZaJuGNoW+oacWpGqw9zhd2NmXH0ia5+4CMVcFRbE4Sc2NEFbfUiCS0m4qkXZzAL
	 HzSAAQRVw+V2RkMcOJryGfGB5ZFeYYCb7QAHMQFsfIPyBmON5B+rNXNCNVxHr9JSU
	 vNkQK13OuRtZu4dhfA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MumNL-1tbq4a2VHv-00tIE3; Mon, 09
 Dec 2024 10:31:03 +0100
Message-ID: <6ece782a-5cf2-47a3-bdf8-188c315152af@web.de>
Date: Mon, 9 Dec 2024 10:30:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zack Rusin <zack.rusin@broadcom.com>, Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <CABQX2QM+cBpVhcBYRae+W4n5a6bVJ=sC+zu9GGj0veiqvU2_4w@mail.gmail.com>
 <6b81d431-36e9-7a7a-687b-2d7fc7aa6c31@inria.fr>
 <CABQX2QP0Vk5UZPDFDXThvzuw-gkam-4wU_xq3rbSmwi9x7cBHw@mail.gmail.com>
 <dff4cbd9-00c1-47a9-b2f7-fb2e98d04433@web.de>
 <CABQX2QPZB9uHMxKKoZA6f=+4f0ifHfft-rHcqd-Ck9rjo7-ShQ@mail.gmail.com>
 <1995b696-6825-a144-fcb-c5f9f3b1094@inria.fr>
 <CABQX2QOb9C4G3Kejo_ght3Dgo0qxHW5A6it4GB6TdgoU0Bo7sQ@mail.gmail.com>
 <alpine.DEB.2.22.394.2412081042370.3332@hadrien>
 <CABQX2QMwBGJHnehxy4j0gHgmUWBBuFqncLWbDZWEdENtGOrZ3w@mail.gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CABQX2QMwBGJHnehxy4j0gHgmUWBBuFqncLWbDZWEdENtGOrZ3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:XtnwJGa/tvU8WN5Nrnq9guD95vwYmwZKd2TSV9RtJ6gyBUZll0A
 Oltb1ktwwPfShwr2u04b2ho899rWwdu82Cy12MSD1nNAFtZVT+SRfTTowoP6KcUDvShOllb
 7FBNlr3mXUv73jmZRYXO3k8FpwqznvOz1Yh7UrfueDIUzM94IATkz6kKbs6d1Xf8CxUyGnP
 MfAeJtzLpTGn3BCLBaZIQ==
UI-OutboundReport: notjunk:1;M01:P0:JXJOYFXlwlw=;51j4necr0e0CMHVOsZANj29/tpY
 MAkYmdiDHDiX5sWPkBzvA2SVR9VyHRaPsb3NmrVkEm3WmlYd+juNRyRW1wuQcWJtQpgwxKgVa
 2hIIyyuYiH2Aivr+CaQAjHk5MzA3S5TaVD55/GoxQVcZAdtRnhatCPsUE36+5Ce2wMXZwJ6tT
 jM7Smm87oP8Az7dbmaC4mRo9we96hHrrCMboOWR5lXehkzcSTwaApjkhQqEL1z5LYXINjZZLt
 8KWz1vFPiERqFgU5RLgDz+vuUp6kUgOvNIKYAooTsBu2CJjl59vXsft7Kl1TwMCWFVivuqqX7
 MBVulN/JeXabW+P3kaDcIOR26FZnghusTdPUvQaerU+8ZEqYrNmoGnq9gnuJn/tm/DBPgE+oE
 OpoGx6NCGBGcV3FZs7jKjsVQWBykwe7AsPTuO4zTjAMxsaZet9mzHneqergV2UlIXBwyVnXCB
 BeBndV17y6sUOulx1n2aP9nZmIzKxa6zC0WszG37YkELSBsFT1fypuCIpA02cmm6HSgUEMIUz
 MVrzTYXcDZZMo7d68vEhodcnvV9i7orWdFcx05qKzf3JP/m3pwPwJAWjjNRFvwYKglSmWEsVH
 q9TvTp41P52tfmFw2tEHipU9jcFobd4wZFJ4it+C6uaMr+cPQa5S/9HpdglQV+0udKIpwv6+h
 BH4z2JV5DjxjYGNWKa0AdNV62djAMm8kRFRNCWleRPuCrcgRQEnkJTq9MExzbGHIx0YFo4HnB
 pycXQGWkoqt8f2Rnos2xXvE7sD29yM0qK3AZ/82TLFW6kqnLpTG2SE///zTp98J+7SWV8xtCl
 KtsdB/UBA5wVQYX7CwR9znPjqHTJxW6V6YAYTM+crAgha6aqcOS5uXUADWZnZ0+K5ouWdkFE7
 Yq19xKdipypF6gmv1KwLnXsYs/c9toqkxN7ZYoqlXdey+HCmck1K2YEKmYNTG+b1RlBoKTs0Y
 cK6bUQDo1L3Mx5URdo9Ezqh5aNGTjYKKzi7Dd3KrUqqRJJkPXYI42wEe13aezW9L1UbmCV5lh
 DXpbVgll600rAYvT1TUi6NFHPf9HAWR1XLKO1o82lQmQI9t9bOPxe8/RfKP+bNuK20LKE3gMr
 JIZ16Atps=
Subject: Re: [cocci] Replacing type names
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2171
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-12/6ece782a-5cf2-47a3-bdf8-188c315152af%40web.de>

>          Based on that I added type replacement for parameters:
> https://gist.github.com/zackr/85ab3864fb70905738cdead35d787f9f
> is the most complete version of the script but it's not there yet.

Under which circumstances will you begin to care more for nicer
software run time characteristics also according to the discussed
use case?

Regards,
Markus
