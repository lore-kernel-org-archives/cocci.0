Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB21CE8374
	for <cocci@archiver.kernel.org>; Mon, 30 Sep 2024 16:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=YqiZQhvEnA3PzfxFm/NktZfI8UBaCurrJjasGzhSrsg=;
  b=SRoj9QYy4LIKJYBznPUvkrdYuOkt0v9S6JxDGXAREABHPU0JfbdBlCaa
   wyfFeru9ifL4XO2GeIhU7bt8uiBpGuNKa+wS2c6wCuEF7q4nMT5AJ1B4H
   P6nea+6292JJjfykxwlmNTLh0nOkS7d5rigFHv1rKBuGX6/JKdsUH4iQN
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.11,166,1725314400"; 
   d="scan'208";a="186046696"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Sep 2024 18:56:16 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 904ABE0145; Mon, 30 Sep 2024 18:56:16 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 12C52E0035
	for <cocci@sympa.inria.fr>; Mon, 30 Sep 2024 18:56:13 +0200 (CEST)
IronPort-SDR: 66fad82d_50eIB3kTfgvki3ExKz7Nlg3ifCtbtHCSYjZgj2YVD1dn9gN
 ynSMaoI5EVzQelfSJPLOvbe67hcRUrkjg/ZKhtQ==
X-IPAS-Result: =?us-ascii?q?A0HHAAD91vpm/w4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T0FAQELAYJDB3xUMwQLSIRWkUIwhDuHOodUiHaBVoFAPg8BAwENQQECBAEBA?=
 =?us-ascii?q?wSFAAKKGAIeBwEEMgcOAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBA?=
 =?us-ascii?q?oEKCAuFL0YNgmMBEIEUgSYBAQEBAQEBAQEBAQEBAQEBAQEXAkdEAQEBAgEjH?=
 =?us-ascii?q?QEBESYBBAsLDgwCJgICVgYBFAEBgn2CMAEDDiMHsDSBMoEBggwBAQbaWh8sI?=
 =?us-ascii?q?leBYwmBGi4BiEoBhiGCWYFjJw+BVUSBPIJmHT6EQ4NbgmmSDYdkhAoliFtwk?=
 =?us-ascii?q?QxSexwDWSETAVUTFwsJBYk4CoMcKYFFJoQVCIErE4NfgWcJYYdnYoENgT6BW?=
 =?us-ascii?q?QFGgnFKg0+BdwU4SYJRa045Ag0CN4IoJGqCWYEnBAWDSSoTHUACAQttPTUJC?=
 =?us-ascii?q?xsGPa4KqUqiaTQHgjeBZIFjDJ9SBhMvlz4OBpJzmHYiozqFQYFuAzOBWTMaJ?=
 =?us-ascii?q?IM2UgsOD44hhC28IUE1OwIHCwEBAwmFRgEBhkGBSwEB?=
IronPort-PHdr: A9a23:bNTefBfBWxJuhLm6es1rCTTMlGM+8NTLVj580XLHo4xHfqnrxZn+J
 kuXvawr0ASRG9+Ctrkd07aempujcFJDyK7CikxKSIZLWR4BhJdetC0bK+nBN3fGKuX3ZTcxB
 sVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBxrwKxd+KPjrFY7OlcS30P2594HObwlSizewb69+I
 A+ooQnMtsQajpZuJro+xxDUvnZGZuNayH9nKl6Ugxvy/MC88oJ9/S9Nofwh7clAUav7f6Q8U
 7NVCSktPn426sP2qxTNVBOD6XQAXGoYlBpIGBXF4wrhXpjtqCv6t/Fy1zecMMbrUL07QzWi7
 6NsSB/1lCcKMiMy/W/LhsBsiq9QvQmsrAJjzYHKfI6VNeJ+fqLDctMcWWpBRdtaWyhYDo+hc
 4cDE+8NMOBFpIf/ulQOtwOzCwqiCuzgxDBGm2H43aM63ek/Ew7JwAMuEskSsHTNttj5KLseX
 f63waTO0D7Nb+lW2TD46IXQdR4uu+uMXbFtccrK1EIhGAfFjluKqYzkOTOV2fkGvm+c4eV6T
 +KviHMnqxprrjagwscshJPJhoMTylDL7ih4zpg6KsaiREFmf9GpCZ1dvDyVOIVqWM0tWX1ou
 Dokxb0cv562ZCYExZsmyhLDa/KKboaF7g79WeqNPzp1h29pdr2jihuy80Wt1vDxWMe03ltOs
 iZIj9fCu38T2xDO5MWKRPlw80Wn1D2S1A7T8vlJLV4pmabFMZIt3KA8m5gJvUjeHiL6glj6g
 aCOekgg9eWk8erqbqj8qpKfOIJ4kAXzP6Qol8eiH+k4NhUOX3OH+euizr3t4Ez5QbRUgfAuj
 qXUto3RK94Bqa6jGQBV154u6xahADei19QVhXwHLFVYeBKblYToNU/BL+viAfiinVugiDZrx
 /bYMb39GpjBMGXPnKn7cbpj9UJRyhA/wc1f6p5OF70ML+r/Wkrru9zZCh85PRa0w+HiCNhl0
 Y0RQ3iPAqyEMKPJq1OG6eYvI+eWZI8Uvjb9JOMo5vDwgnAig1MSYLem0YMRaH+jBvtmOVmWY
 WLwgtcdFmcHphcyQPTwiFKeST5Te2qyX6Uk6z4nD4KpEZvMRoG2jbya3Ca7G4VWaXpcBlCNF
 3fobYSEVO0WZCKcOM8y2gADAIOoQZ47xxGnskfGwqFtKe7d5ioG/cb40t9r5vHUkRUa+jl9D
 sDb2GaIGSU8lWQDTD4e3aZloEU7xE3Q/7J/hql9HMZQ+ugBfwM0L5/awKQuLtnoWR/aOPqNR
 kynRNqOHjw7CN48lYxdK31hEsmv20iQlxGhBKUYwvnSXMRcGsP02nHwI5w40HPazOw7iFJgR
 MJTNGqgj6o59g7JBoePnV/K372ye/E62yjAvHyG0XLIpFtRBSt5S6bYRjYyYkXMrNL2zlzPR
 fmiBOdvKRNPnPaLMbACcdj1lRNDTfbnNs7ZZjeUkn2zGA3O67eCdovsdE0C0S+bBEVX2xsL8
 yOgMg4zTjykv3qYDDFqEgf3ZFjw9OBltH6hZkoz0h3McEBrkba4kvIMrdqbTf5bnrcNuSN77
 i5xAE74xdXdTdyJuwtmeqxYJ9I7+lZOk2zD5UR7OdS7IqZui0R7EUw/tl7y1xhxFoRLkNQ75
 HIswg1oLKuE0VRHPzqG1JH0M7fTJyH85heqI6LR31jf1p6R9MJtoLwdok/goRrvO04s6XRh3
 PFK3nHa6piLRAseXJTtU1omogBgruKSaS086oXIkHx0ZPPt6HmYgY1vXbZjk0rzGrUXeLmJH
 wLzDcAAUs2nKehw3kOscgpBJudZsqg9I8KhcfKCnq+tJudp2jy83gElqMhw1FyB8y1kR6vGx
 ZEAlru91xGESiy6oVOvqMHxlqhbaDtUEmf1mk2GTMZBI7Z/e4oGEzLkBsStxchlwbPpVWRZ8
 lGLGF4MnsOkM0n3DRS1zUhb0kIZpmaikC2zwmlvkj0nmaGY2TTH3+XocBdv1ndjfGB5lh+sJ
 IG1i4pfR020d00zkxDj40/mxq9draA5Lm/JQE4OcTKkZ21lV6KxsPKFbastoNsNuD9UTf/6T
 FSUUL/7rDMF3imlE2YWyD0gdj6ss4n0hFQg0Tjbdiws6iOEP5gsjR7ErMTRX/tQwiYLSEwaw
 XHMC16wMsPotdSYmpHfs/yvAmeoV5lday7unsuLsCq243EvAAXqxanp3Ie9Tk5jjGmii4oPN
 22Athv3b4j12r7vNOtmehMtH1rg849gHYo4lIIshZYW0Hxch5OP/HNBn32gVLcTka/4cncJQ
 iYGhtDP5w2wkmhqNHGU3MTUUnuHw81uT8a3aCUa12huiqICQLfR97FCkSZv9xCdpBjSfOM7s
 zMT0/oo51YFjutPtAdnnUD/SvgCWEJfOyLrjRGB6duz+b5WaGiYer+1zENinNqlAeLKskRGV
 X3+YJtnAT5o45A1LgfXyHOqoNKBGpGYfZcJuxaTiRuFk+VFNMd7iK8RnSQ+cWuvuHo416gkg
 BYo0ZzytdqCLHhxubK3BQRHPyf5Idwe8HfhgMM81o6fjYWoA4kkEDIWWpDlC+2lGnQeuLzuZ
 QOJDSF5oWyRBL7cW1aW7ks/6XnIFvXJfzmednwe0MknTwKWI1ZHxlkdWjlj2JU+E0i8zcjlO
 i+V/xg34Vj14ltJw+NsbVzkV3vH4R2vYXEyQYSeKxxf6kdD4V3UOIqQ9LA7GSYQ5ZCnoAGXT
 w7TLw1VEWEEXFCFDFH/L/Gv49fH6e2RGuu5KbPHf7yPreVUU/rAy4io18Nq+DOFN8PHOXcHb
 bVzwk1YQXVwANjUgR0KTDEL0T3AZYiXqVb0+yF6qNy+7OW+WA/r4tjqafMaOtFu9haqxKabY
 rTJ3mAjc2kej85KnCObrdpXlEQfgCxvaTS3RLEJtCqXCbnVhrcSFRkQLSV6KMpP6as4mAhLI
 8/SzN3vhdsaxrY4DUlIUVv5l4Snf8sPdiuYPUnEGV3NGbCIPzzNzOnobKn6RbAa34A2/1Wg/
 C2WFUPuJGHJjz7ySxWmKv1BlgmeOwFC/p6weFBhBCKwKbCuIg3+O9hxgzosxLQyjX6fLm8QP
 w93dEZVp6GR5ydV6h2aM3NM5DxpILvc8852x/bVINAavKkyasyVv+dd/Wh81LZfqi1JFqQdp
 Q==
IronPort-Data: A9a23:D8yn1qJWkdflc2xuFE+RxpQlxSXFcZb7ZxGr2PjKsXjdYENSgTYCm
 zMXXG6Haa2CYTb2Lo9+Pdjjpk8Eu8SGytVmHVEd+CA2RRqmi+KVXIXDdh+Y0wC6d5CYEho/t
 63yTvGacajYm1eF/k/F3oDJ9CU6j+fSLlbFILasEjhrQgN5QzsWhxtmmuoo6qZlmtHR7zml4
 LsemOWBfgb8s9JIGjhMsf7b+Ug35KiaVA4w5zTSW9gb5DcyqFFOVPrzFYnpR1PkT49dGPKNR
 uqr5NlVKUuEl/uFIorNfofTKiXmcJaKVeS9oiY+t5yZv/R3jndaPpDXmxYrQRw/Zz2hx7idw
 TjW3HC6YV9B0qbkwIzxX/TEes3X0GIvFLLveBCCXcKvI0LuKVu0ksg1KloKMLYm0PwpKH5fq
 PAmJ2VYBvyDr7reLLOTT+5xmoI8IcOtMI53VnNIl2iDS6x8HtaaHuOTube03x9o7ixKNdPXf
 ckEcnxCaBraYhtAEkgaAtQykY9Eg1GmI2MA9AzL9PNfD277jxdY6LG2AoLuXNGzZ+luoEaTp
 FD88DGsav0dHJnFodafyVqngeTEnAvgSYcKHfu58ORriRud3AQu5AY+UFymvb+mh0T4V983x
 1EoxxfCZJMarCSDJuQRlTXhyJIplkd0twZ4ewH71O2M9kYQywOeG3RCUTNLLtAr3CPzqfrGy
 XfR9+4FxxQ22FFWdZ5Z3qiZp3W+NED56EccMDQcQ1JtD8bL+ekOY9GmcjqnOLG4hJv5FFkcB
 txMQDcW390usCLA60l3EZ0rTd5hSlglgzPZPjnqY18=
IronPort-HdrOrdr: A9a23:hUAPL6xkihtdyULH1AksKrPwj71zdoMgy1knxilNoNJuE/Bw8P
 re+sjztCWE7wr5PUtLpTnuAsS9qB/nmaKdpLNhXotLsmHdyReVxcJZnPbfKwSJIVyAygcl79
 YfT0EmMqyAMbEZt6bHCXiDYrIdKYK8gdmVbI7lph8HcegpUdAD0+4eMGmm+yZNNWx77PQCeq
 Z0z/A31waISDA4btmbGnJAZOTKvdvN/aiWGyIuNloI6BSukTjt07LxEwGZ0hACOgk/uosKwC
 zqkxHZ+q7miP2wygbd22jPq7xalcDs0MErPr3/tuElbhvtlye1b8BaV7qOsCtdmpDW1H8mnM
 PQoxApIsR07Gm5RBDHnSfQ
X-Talos-CUID: =?us-ascii?q?9a23=3AnytQvmqMOZM7oJa6oAA7Pf3mUZoFKizgl1HLH0K?=
 =?us-ascii?q?DN0xzFpSKWAKcxqwxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AWYvK1A9bfpfi9OjF+MabYBmQf4RzypynU3JVqrM?=
 =?us-ascii?q?LguuoDhJwMDWvtjviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,166,1725314400"; 
   d="scan'208";a="186046691"
X-MGA-submission: =?us-ascii?q?MDGFtMpycLsMn+qimJqwFGq2wqH/ab1c196Yx2?=
 =?us-ascii?q?wif+8uehLDPnnD+M9pe1ya3MwOL6dAWcPoQPPAt7y6ECeMeagIZ/RgdM?=
 =?us-ascii?q?XXrQP3gu2XaNlzCNNYbk/iSSgItCevhWANRbhbJDesj+cZc2TFnD1I3A?=
 =?us-ascii?q?YZXRqtRVmwzxZea1MIauQQlA=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 18:56:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727715361; x=1728320161; i=markus.elfring@web.de;
	bh=YqiZQhvEnA3PzfxFm/NktZfI8UBaCurrJjasGzhSrsg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:Cc:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=kPN1azQnXvkA1jeKZ1vr4OmrsNFtB047sFaXTKYEvEMDSds2TZEVeI1Qv/Xtm+WT
	 u514WQDwtnX5M+t8m4pJ7FowSvMTF6Wv86QB9+uZCMpttmKkNoium9NLkj+NspHjN
	 rNsw7lkRr0p8ZpXmMeGjovCSnDLpKYZdbMkw6QzOLXVPAuV5b2yV6oou9xVWZ/9bf
	 YI6+diRqDZchBcF6i19fHgOMJS9920Ri8pGkql5T1aZhX+6shMwHjsSiSqYCuEdZf
	 FbMZ+z+IQ84h3i/bA+EI6heOdjdx0Fe0y9+UiCTQzJePmu8TV0UfoNEfl/oTd/8rh
	 gTKr0506I2ZguSjeUg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MpCqh-1s7QLO0vvD-00p5Iz; Mon, 30
 Sep 2024 18:56:01 +0200
Message-ID: <fbd705ff-2c6d-4b96-aa71-114ed8789b99@web.de>
Date: Mon, 30 Sep 2024 18:55:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>, cocci@inria.fr
References: <CACzwLxiohvUHUxm2XM8B08RwY6VCLuK1p32Ek2Y0M+t1wTfX8g@mail.gmail.com>
 <d3f5836b-9a4e-5974-b649-e6f75c5183f8@inria.fr>
 <CACzwLxiaXLLSZH=rufJkkyr07u45W40ENd=BXqU4B1NoyS1iag@mail.gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Cc: Denis Efremov <efremov@linux.com>,
 Nicolas Palix <nicolas.palix@univ-grenoble-alpes.fr>
In-Reply-To: <CACzwLxiaXLLSZH=rufJkkyr07u45W40ENd=BXqU4B1NoyS1iag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PoXFHK3tf2W9YgPQHenfc6zaqCYvIgnzsCOGHGYiedQoxaT60p/
 VwCnspIGOcm2eJe+6Bi9QQIdi9Tk9I0dO9toTS25NpXuBwT9U5IMKMwlLxu1/PB6Y7DY0/N
 f59j+a2xCVel4093OK0NrPt3bpc8bg/dLf1XvM5Wqvzf66R9iGVxp1TXxfMWksme4QJqjLk
 5p2DUg0JAVyA6NVGMKqIQ==
UI-OutboundReport: notjunk:1;M01:P0:IzfS5g4kmlY=;8FAm3e+1ZJaLM02zTemT9uEfauO
 QcAYgojZfdynyCyoH907Ab0SFjmicJSRM3CqKy4Zlcm7oZbUjJO5+JoG9+JLtAVzeqhhY9cfG
 kFskIZKRx5e/avCtwts3hFtLGgMe9L2S4TB+d7pcbz4VECeLyimjKuVejHOvuqcE0AyqeSR+q
 H4uxG17IBp2iyJ8wxSeTF6+aZp2wbgk1io3qxArhhFfRYi6JD3gtyL+KVIfvHWVKYGuXmjXGk
 CH2wqtzhrAjtjVh058ImHXDuipSs6cL79yzYvy7oLu1e/ZWr62y+FBXsbH/QP73aRPy7Vz0hm
 hpt4KYgUiijAKNvbiwAv6QcMiIVA1IuGmP/ibOrqkzj011vLyBfh5RMkEyNicKA/Yp3OOjoc4
 KtLp0puEg5zbOQAXKD4/w7Cq+AftOSVnOUvjesc7dp5h8nX8oOHzfcImlfIDT3KrIVV+Dq6Oi
 7G7wjxrXfEMqLw8rLXqAK6iL1y07WwT9SNYK0Aq9ooAR9JBaL2mDAxFqe+M37/JwxO0bIkRjF
 Ux/H+wl/gCOSVSsbLrtsYjIKlQ0fCzyy90JGn2v1QxZkcnMTpjAPCJWxFzx7JBv6QxA4oUIrx
 FwRx+/foD8AvEIwbFEWRf2KA7twG588oqkBk8AsHspIPxV1vaIzW+bfEV1WXMW8mbvQDIByEp
 ELvLG6X7/jbtmHj8kKZ3P/vIaTjhg7qSoBaGbN78K6Txeyyd60hdXtRdE3mcN2vCgA3WTv2Wx
 Mi8gB459I61OZ4QlBiPGnf6/5JJx3ui6UBroTiea6SZDY5Pz0Zb+tNuhWwf4+Rvlb5kg7rcoo
 Aa1OJmQtiYaF1cvsorLsf54A==
Subject: Re: [cocci] Assistance in Coccinelle script
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1901
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-09/fbd705ff-2c6d-4b96-aa71-114ed8789b99%40web.de>

> Here is the modified script:
>
> // __user exists in parent function parameter.
> @r1@
> identifier f, param;
> attribute name __user;
> expression E2;
> position p;
> type T;
> @@
> f(..., T __user *param, ...)
> {
> ...
> (
> copy_from_user@p(..., param, ...)
> |
> copy_from_user@p(..., param + E2, ...)
> )
> ...
> }

Can an SmPL code variant (like the following) trigger further inspirations=
?

 {
 ... when any
 copy_from_user@p(...,
(                 param
|                 param + E2
)                 , ...)
 ... when any
 }


Would you like to try any fine-tuning out with SmPL disjunctions?


> @script:python@
> p << missing.p;
> @@
> msg =3D "match !!!"
> coccilib.report.print_report(p[0], msg)

Would you like to apply the following statement (instead of two)?

coccilib.report.print_report(p[0], "match !!!")

Regards,
Markus
