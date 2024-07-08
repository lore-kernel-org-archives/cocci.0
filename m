Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B22C3271E
	for <cocci@archiver.kernel.org>; Mon,  8 Jul 2024 10:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=M/gNla9G4VebEsED8I2BesCy8VRQAkOO4pOj8URtv20=;
  b=INBKpGj5Fj42EpqrcWk/1hseiEPJVBaj6ScfMP9uWFYaznuGDRd02k/t
   p7VJ26vL1f/AjE0tT6k1ja8ZHarPXfbKMTsaGaRXknrFb1WSTj5255iVm
   1p3XUVyF/7geoBI+dfzRg/JFALFQkZAYAOD77q4brwhZqPwTeOFjjnMST
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.09,191,1716242400"; 
   d="scan'208";a="174428804"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Jul 2024 12:23:32 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 53463E0CCC; Mon,  8 Jul 2024 12:23:32 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id E309CE004E
	for <cocci@sympa.inria.fr>; Mon,  8 Jul 2024 12:23:29 +0200 (CEST)
IronPort-SDR: 668bbe21_D1yFv+U2gwpnIynuSS5mOM3BlGAPy9uQuBUC4RKzyz6lJAN
 Ys03tKCEbfYqZMmaRcCla0DT4uLgmyb/WjVuVsg==
X-IPAS-Result: =?us-ascii?q?A0HoCQDKvItmh07ASNlaHgEBCxIMQIFEC4JEYhpaMwQLS?=
 =?us-ascii?q?IRWj0iCIgOEO48KiHOBVoFAPg8BAwENPQQBAgQBAQMDATiBU4J0AokSAh4HA?=
 =?us-ascii?q?QQwCQ4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECEAEBASMXBw4QJ?=
 =?us-ascii?q?4V0DYJgGIESgSYBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQINOkQBAQECASMdAQERJw8LGgImAgJWBgEJCwEBgnwBgi8BAw4jB?=
 =?us-ascii?q?w0GrmeBMoEBggwBAQaBWEHYQB8sIleBYwMGgRouiDEBhXyEQCcPgVVEgTyDA?=
 =?us-ascii?q?z6CYQEBAoFeg1uCaZZGgxGCIIlnJguMfVR7HANZIRMBVRMXCz4dAhYDGxQEM?=
 =?us-ascii?q?A8JCyYpBjkCEgwGBgZZNAkEIwMIBANCAyBxEQMEGgQLB3eBcYE0BBNEA4E3i?=
 =?us-ascii?q?W8Mgy2BcieEGwhDbBWDbIFrDGGIAWKBD4E+gWIBS4J9S4RRHUACAQttPTUJC?=
 =?us-ascii?q?xsGPaoAhD8XWSIsQ4EskxCyPDQHgjaBYYFiDIohlScGEy+XOg4GkmyYaSCNV?=
 =?us-ascii?q?psVgWc6gVwzGiSDNk8DGQ+OIRmDYTOBC8oyQTUCCTACBwsBAQMJhUYBAYNag?=
 =?us-ascii?q?UoBAQ?=
IronPort-PHdr: A9a23:mWT1dhCuHe3zrCV8++b2UyQUXUkY04WdBeb1wqQuh78GSKm/5ZOqZ
 BWZua41ygWWFt+Ho7Ic0qyK6fGmATRBqb+681k8M7V0FCU5wf0MmAIhBMPXQWbaF9XNKxIAI
 cJZSVV+9Gu6O0UGUOz3ZlnVv2HgpWVKQka3OgV6PPn6FZDPhMqrye+y54fTYwJVjzahfL9+N
 hq7oAvNusUMn4dvKKk9xgXGr3BVf+ha2X5kKUickhri4sq85oJv/zhVt/k868NOTKL2crg3Q
 rBfEDkoKWc56tH1uxLeVwWP/HwcUmsXkhpMHQfI6QzxU4nyvCXnqOdzwTGWMsLqQ786XzSi9
 LprRwTziCgbLT458XrYhdJ2galGvR+uvR1/w4rTYIGIKPpze77WcN0GSWZdWMtaSipMCZ6+Y
 YQSFeoMJeVWoYfyqFQAsBWwGwesCuPtxTBUiXH7xrE60/07HA3awAAsAdADvXLJp9v1LqcSV
 uW1wbHPwzrZdfNW2ir96JPVeR4upfGMU6hwccvXyUkgCgjIiVKeppb/PzOWy+QNqHKX4eVkV
 eKhkW4nqgdxoje0y8YilIbGnZgZxU3a+ihgxos+ONK3RlJhb9G+DJtQqz+VN5FwQs46TWxlu
 yY0xLIIt5OmYSQHyJcqyhrQZvCbc4WG7Q7vWPiNLTp3in9reK+yigus/UW9xODxSNS43VZWo
 ydbktTBqHYA3AHd5MiAT/ty5Eah2TCX2gDS7OFEO0E0mrDBJ54v2L48jpUTsUXfHi/2hUX5l
 7WaeVkj+uit7ensf7bopoeEOoNqlw3zML4il86hDegiLwQDW3aX9f6+2bDg5UH0RLpHguc4n
 6XEqpzXIdkXqrS9DgJV1Iso9giyDzO70NQDgXkIMkhFdg+Gj4noJV7DOOz0APGiiFq2ijhr3
 erJPrj5D5XNMHfDlLDhcK54605b1Qoz0cpT5pxKBb4aOv78R1H+uMTZDh8/LQO03/7qBMtg2
 o4cQ26CALGVPLnPvVKM+O4jOeuBaYwNtDb4Mfcl5vrujXEjmV8aeKmkxZwZZ2qiHvRlPkWZe
 mDgjNgFEWcEpAo+TerqiFKZXD9deXm9RLgw6SwlB46+C4fMXZiigKad0yejAp1WemdGB0iRH
 XvwbYWLR+8MaD6OIs9mijELSb+hRJM92hGvrwL60LpmLu/M+iICr57j1d515/fSlR4o7zB0A
 d6dgCmxSDRLmWcGXTYzlJt2p0M1nkiY2OtijvpVDtVIz+hAVAh/OJjTzup3BsrzXA2HddCMH
 hLuSdKtCjAZT9QrwtZIbVwuNc+li0Xm1jCpHqRduriFHp0y/eqI+nHrJNtmjVvC2rMgiVYOX
 cZFc2Gr0P0svzPPDpLExh3K352hcr4RiXalHAaryGOPuBsdSwtsSeDfWntZYELKrNP/70eET
 rm0CL1hPBESgdWaJP5sbdvkxU5DWO+lIM7XNke4gWStHlClwr2WbYzlU3oQ1mPRBRtMiBgdq
 E6PLhN2HSK9uyTbBT1qG0joZhbJ+PN9tWj9Y0s61QCMYGV+2rDz9hNGzeeERaY12bQJ8Dwkt
 y0yHFu52IfODMGcogN6YKhGSdY6/UsBym/T8QBwVnC5B4ZlgFNWMwF+vke0kg5yFp0Fi88h6
 nUj0At1L6ucllJHbTKRm57qaPXRLSHp8RajZrSzuBmW2cuK+qoJ9PUzqkny9ACvGE049nx70
 t5Tm3KC75TOBQAWXNr/SEEyvxR9orjbZGE66ea2nTVJOLO3rySE9tYnHuojxT6/ct0ZPK7FX
 A7+HssGBtS/ffQwkgvhZRYFMeZOsa8sapn/KL3Zgujybbwmw2L16AYPqJpw2U+N6SdmH+vB3
 pJfhuqdwhPCTTD3ylGorsHwn4lAIzAUBGu2jyb+V+szLuV/e5gGDWC2Loi53NJ70tTIUmRb6
 UXlKlcIws6vdjKNYla70QAahiF16TS33DC1yTB5iWRji6OF3zHVhcnmegAGPGFjW2Roy1vha
 9vR7ZhSTA2jaA4nkwGg7EDxyv1ApahxGGLURF9BYyn8K2wKvrKYjrOZeIYP7ZoptX8SS+Gge
 RWATbW7pRIG0iTlFm8YxTYhdjjstI+r1xB9jWucKj50oh+7MYlVzA3c+ceaaPpfxDsASwFnh
 DORClX0M9Sy/NqSnovOqajkDj3nCccVKHixi9zQ/CKgrXVnGxi+g+y+lriFWUAh3Cn32sMrH
 STEoRDgY5X6gqGzMOZpZE5tVxf378t3HJ07k5Nl3shPnydAwMzEpzxYwTSWU50Tw6/1YXsTS
 CRextfU5FKgw0h/NjeTwIm/UHyBw8xnbt38Y2UM2yt74doZbcXcpLFCgyZxpUK16AzLZv0o1
 BIU0/gz8zg3h+8TuQwi5jqQCPYeEAMLWE6k3wTN9N24oKhNMSyKeKKzyVE4sNSvFrCErSlDV
 Xy/dppoTkoSpo1vdVnL1nP08ITtftLdOMkSuhOjmBDFl+FJKZg1m6lClW99NGn6p3Fg1/8jg
 Ekkw8ShpIbeYTYInurxEltCOzbyfc9W5jz9kfMUgJONx472VpwzHzIWQN33QPjuHD9avKbiM
 BuSVS0yrW2EEKDTWxCS4gFqohetW9iiZXSQOWVcx9J/QhKQYlNSikYYUX0zzJs+Cxzvz9frb
 UN6oGkY4FKh7BBLz4cKf1H2AGLYuRvtYSw/T4KHakNf6A0boUzSNISI5+Z3VUm057WHqwqAY
 iyebgVMVyQSX1CcQkrkNf+o7MXB9O6RAqy/KeHPaPOAs74WUfDA3p+p3oZ8mlTEfsySInlvC
 eE60UtfTDh4HcregTAGVy0QkWrEcceaoB62/iA/oNq49bznXwfm5I3HDLU3U50n4xetnaKKL
 PKdng58LitEkIwBzznExflX3VIfjT1vayj4EbkEsn2oLuqYkatWAhgHLiJrYZERsORjhE8Ua
 JSd1YOms9wwxuQ4AFpES1H7z8SgZMhQZnq4KEuCHkGAcrKPOTzMxcjzJ6K6U7xZyutO5HjS8
 X6WFVHuOjObmnznTReqZKtphTuYIQcYlYWzaBdrBkD8QdigZhDxY7oVxXUmhKY5gH/HLztWK
 T9nb0ZEtaGd9wtdhehjXXNM5DxpIKPX/kTRp/mdIZEQv/xxBy1ynO8P+3U2xYxe6yRcTeB0k
 i/fxjaBi06rmK+Dx2g+OPKrgilGjsSHsBc6UU043pxHRGqC4x8Hq2mdWUximg==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:Xerkx69wwlKMRq8d7x9uk+FGdb1zdoMgy1knxilNoENuH/Bwxv
 rFoB1E73TJYW4qKRcdcKO7SdC9qBLnhOhICOwqUYtKMzOW3FdAQLsC0WKA+UyoJ8SdzJ876U
 4IScEXZ7PN5DNB/KXHCXyDYrMdKa68gcKVbInlr0tFfEVPUeVN/g15AgGUHgldXw9dH6c0E5
 Ka+45uuyegUW5/VLXxOlA1G8z44/HbnpPvZhALQzQ97hOVsD+u4LnmVzCFwxYlVS9Vy7tKyx
 mOr+W53NTvjxiI8G6S64bh1eUZpDIn8KoDOCW4sLlYFtwrsHfpWG0uYczAgNl/mpDW1L9jqq
 i2n/5nBbU615qZRBDJnfPgtjOQqgoG+jvsz0SVjmDkptG8TDUmC9BZjYYcaRfB7VE81esMpZ
 6j8ljpxKa/Nymw7hjV9pzNTVVnh0C0qX0tnaoaiGFeS5IXbPtUoZYE9E1YHZ8cFGaigbpXZ9
 VGHYXZ/rJbYFmaZ3fWsi1mx8GtRG06GlODTlIZssKY3jBKlDRyzlcexsYYgnAcnahNP6Vs9q
 DBKOBlhbtORsgZYeZ0A/oAW9K+DijXTRfFIAupUCTa/WE8SgPwQrLMkcsIDbuRCeA1JbMJ6e
 v8bG8=
X-Talos-CUID: =?us-ascii?q?9a23=3AXzTPmWsGuPZyGPVYX7qkql9D6Is1TCPYl0n0BXX?=
 =?us-ascii?q?7CDlqd6WqVASM4Yxrxp8=3D?=
X-Talos-MUID: 9a23:DUjCHQUah8XQ8b7q/D3V1S9wHcg32oaVKkwtsslWspakOiMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.09,191,1716242400"; 
   d="scan'208";a="174428792"
X-MGA-submission: =?us-ascii?q?MDHxH+RaeKjXS7nxuBBRTm78o/C14XPzNmFEqJ?=
 =?us-ascii?q?2sDvoTHi/dSD1Of9J0WM/70H6NFyfuMvohEo7OSfhiR5dRu0R3HxNney?=
 =?us-ascii?q?PosncTIeuxhp2TojodBH7bNHapZBel7YcaRZpkQVY4S6wzPu1Tm6+c5G?=
 =?us-ascii?q?CeVViH/yuAtPRTDDf+GdreTw=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 12:23:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720434207; x=1721039007; i=markus.elfring@web.de;
	bh=M/gNla9G4VebEsED8I2BesCy8VRQAkOO4pOj8URtv20=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ECaRVPljdymsE920EiS89ZSJNmUTbZvMot4NGo9hXEBcZuqfDEk1VjTxN2wZ3IKT
	 iwlLZ5QUBItdssPSJbgb37z1fzWfalJwaD/aAN6yUEV7JL2EL2UJ5H9RiHPqCuZ//
	 G9Jlv7oD0Zd9topqeWW06VrY9ObXVIQJztNkbypNGprLYbsYHp4IoOlgF5NOWIlI4
	 SfNRivkgusEzX8oB1x+V4xJZN0a5xAVbpjEaGdkiuuo+c29PtVHqvBKRzxXozy12m
	 Dsbnz2Q/mc1Da437QCgqBBJ7zE2kbf01r666t0DVE1wzl+hSNu0EwYNqTHzeizhRz
	 xBbpkhzuPWh/v3+wnw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MNwjS-1skbix3TCK-00VKda; Mon, 08
 Jul 2024 12:23:27 +0200
Message-ID: <52a3a068-ab11-4de0-b63e-55319cdb9be6@web.de>
Date: Mon, 8 Jul 2024 12:23:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, cocci@inria.fr
References: <8d145e35-33af-4f81-a77a-2bbc5c734045@web.de>
 <ZoqY5GQlpKwZ3SEo@shikoro> <1d7aa71d-be7e-4750-b1cd-c1ee34e877c3@web.de>
 <Zou37OqG4xxBxKdm@shikoro>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <Zou37OqG4xxBxKdm@shikoro>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sGsirqRN2PMBeeBZQSzwmKaZQ6Dx88uQIFFyW3ATWXvisokWesU
 H5d1gKP8o8KhIyBnmGCCMlwkXUQU4WXuYdBdeLvYea95EYcwssDRlyzCoYO3Fjnx03HGYFB
 pypkMOp+5ySs1+l5K1qjLPKT0ljMvdDovSZj80b7YbQN1NxYQkhQiyeUegZi1Hd/yGGXIZx
 qtYAy8eCtem8zftQao+8Q==
UI-OutboundReport: notjunk:1;M01:P0:6cgYPDrLfJU=;bANPP43ve+SVsWPogGHvnugOzjM
 05aKzLed0KJgZeMGVA931iHsVXIVAQc6J/WbWP4SDzVdxEufAhvdlAhxO5pSD/8qIsjyeooH0
 6sxk+iDmDg9rnHtsdrWEUXvi9073tRR4UwmvTx5seZyZRWyatpKk9Wp0g2uQZKYk0D5kYLmsp
 t88hGQ6xh4mZY9hbhI0faYGTuDtaFyAsENaaKF42UDMHVteHpZIB02/tM4gy1X5qbPnno9FQy
 Jk6RIvGrA44bnPS97N6w7JmyB1aPOvRRqYdCBszNxWVhq6LCikQ2onJdGAT7Y7KhTIBR8uGwa
 DoquZRoGk1C2BWm9rWbRShCb/hdmKw2u/RV2OSoiJ6BmreWjvOD6WFaeWoqLAg/lwrRBPWXW8
 Oi3Bnn71TWcrG5uwaDRL5s1CE0pfl0e+ZBPn1fbIwmcrHPofrx5mNxhZ41XU2uWm7b53pFx7A
 p4Nor5AdIq1myREPPLPLh8FjjTQgTUVRJgnkXRjWz0r77nCjBDvy0x94nxpUxHzqZnw+WL6Q6
 IDPCVlXxpaUxsC520wizziE7HviySReOAQi43r0IUKgT60gkFghwOaOpHNx7PKuhJpI3WkOC0
 pO5J+t4L+tnQ+vT+SfZ5XIa6BXsA4bRlwOv2ST1rkQwISMCjKOenT6v1u1Fzg5LvltXg7Z3A4
 6c/jPhkvR1zOOP0TEDJ++b5qttsrxPXjBcMYlYn+bHiB4due9AxUFRROjH8zOYEI461TGz5p7
 Vbc1lD+U7JAG1UB0/MDsqcvOCs/yPCMWbtMN6r1aMYl2PycNGLEpJlGQfTdzc8MqjmSndOdqx
 gMzj9F2nrW+qng4LO4p9eGRE0FQ1LVqc9scRDPrxHdbyU=
Subject: Re: [cocci] Deleting unwanted semicolons (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1807
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-07/52a3a068-ab11-4de0-b63e-55319cdb9be6%40web.de>

>>> How should coccinelle transfer this incomplete function body to an AST=
?
>>
>> I hope that the support will grow also for advanced handling of abstrac=
t
>> syntax trees and semantic graphs.
>
> What approach would you suggest to create an AST from an incomplete func=
tion?

The semantic patch language was developed to handle the discussed source c=
ode
search and transformation pattern (in principle), wasn't it?

Unfortunately, there are some known software limitations involved so far.
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/d657cc2613877729ae3fb=
f33c5e935f927b23cdc/docs/manual/cocci_syntax.tex#L1771
https://github.com/coccinelle/coccinelle/blob/ac9af0e8b7c76341de1999389ce2=
85b72ebaf81b/docs/manual/cocci_syntax.tex#L1771

Various open issues point further development opportunities out,
don't they?

I became curious under which circumstances corresponding software improvem=
ents
can be achieved.

Regards,
Markus
