Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF5BAC3DA4A
	for <cocci@archiver.kernel.org>; Mon,  5 Aug 2024 16:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=kh4fhHmLO8iZAjllPEYMGaA4z7grBCVny/46sIW1Uyo=;
  b=NT5Yq1ExHImtpCQCyOe/d86MsP3xFWO4ohpUM5uxLz5zoloXYWR+eMMt
   Phjd7AG0T1g7OIO3djC6g+HmNdRY3vqz8UT8g1j6ybMo8qhjWOHzExou6
   pY3BTjBg6ZPbfEHqqI7ys5Fr5UIuPRDFse+V2qa9WZmgoyW1Ry/UHgaut
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.09,265,1716242400"; 
   d="scan'208";a="178173018"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Aug 2024 18:32:18 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 158CBE013D; Mon,  5 Aug 2024 18:32:18 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 4D4F4E0035
	for <cocci@sympa.inria.fr>; Mon,  5 Aug 2024 18:32:16 +0200 (CEST)
IronPort-SDR: 66b0fe90_3BzrB658A+TNCaVACheXLUva8XzT7HCuzyPtkSst5Daq6RX
 DHLOHwaQzJipJCPoXeGs2Z5y4a+a+IZ3TiTjkzw==
X-IPAS-Result: =?us-ascii?q?A0EgAAAO/rBmhwwR49RaHQEBAQEJARIBBQUBQIE7CAELA?=
 =?us-ascii?q?YJDYiFUMwQLSIRWiB2HL4F1MIQ7hzqHUYh1gVaBQD4PAQMBDUEBAgQBAQMEg?=
 =?us-ascii?q?guCdAKJSgIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBA?=
 =?us-ascii?q?hABAQE6Bw47hXUNgmcBEIESgSYBAQEBAQEBAQEBAQEBAQEBAQEXAkdEAQEBA?=
 =?us-ascii?q?gEjHQEBESYBBAsLGgImAgJWBgEUAQGCfIIwAQMOIwetYoEygQGCDAEBBtpZH?=
 =?us-ascii?q?ywiV4FjCYEaLgGISQGGHoNBeicPgVVEgTwLgng+iB6CaZImnF1SexwDWSETA?=
 =?us-ascii?q?VUTFwsJBYlLCoMjKYFLJoQYCIEtFYNlDYFeDGGHcmKBDoE+OIEnAUmCd0qDZ?=
 =?us-ascii?q?xyBY4EDgmNYHUACAQttPTUJCxsGPalfpyKhLTQHgjaBYoFjDJ9PBhMvg3IBk?=
 =?us-ascii?q?0kOBpJuLJhEIqh0gWc6gVwzGiSDNk8DGQ+OIRmEFMc0QTU7AgcLAQEDCYVGA?=
 =?us-ascii?q?QGGXIFLAQE?=
IronPort-PHdr: A9a23:1ZN+mB2TpqF4MLNMsmDOnw4yDhhOgF0UFjAc5pdvsb9SaKPrp82kY
 BeHo6UzxwaRBs3y0LFttan/i+PaZSQ4+5GPsXQPItRndiQuroEopTEmG9OPEkbhLfTnPGQQF
 cVGU0J5rTngaRAGUMnxaEfPrXKs8DUcBgvwNRZvJuTyB4Xek9m72/q99pDdfwlEnjmwbLJ9I
 BmrsQncuNQdjJd/JKo21hbGrXxEdvhMy29vOVydgQv36N2q/J5k/SRQuvYh+NBFXK7nYak2T
 qFWASo/PWwt68LlqRfMTQ2U5nsBSWoWiQZHAxLE7B7hQJj8tDbxu/dn1ymbOc32Sq00WSin4
 qx2RhLklDsLOjgk+2zMlMd+kLxUrw6gpxxnwo7bfoeVNOZlfqjAed8WXHdNUtpNWyBEBI63c
 okBAPcbPetArIfzqVQBohWjCweyGu7vxD9GiX3q0qM1yOkhDQPL0RY8E94SrnjZrtP4P7oSX
 +Cvy6nIyC3OYfRM1jfn64jIbwshquyDU7J0f8rR00gvFwXKjl6NroHrOCma1v4Os2iG9OpsT
 +2hi2opqwFrozivwMgsh5LHh40L0V/I7zh2z5gsKNC+VUV0bsKqHoFKuCGGK4t5XNkiQ2dwt
 Ss41LAIuZ+2cSYUxJg5yRPSZPiKf5aH7BztSeqdPDl2iG5qdb6imRq8/0etx+PhWsWo1FtGs
 CpIn8XRu34D0xHe7NWMRPhl/kq5xzqDyh7f5vtaLUwql6fXMYMtz7wqmpYOr0jPBiv7lUrsg
 KKYa0ko4Oyl5/j9brjippKRMZJ/hx/6MqQzgcy/Hfo3MhITUWia+OWzyqXu8VH/Tb5XlPM5i
 LPZv4rfJckDpq62HQtV0oE75ha6CDemzcgYkWMJLV1bYx2LlZXmNE/WLPD5C/ewnUisnS91y
 /zbILHtGIvBImbBnbv7YLpw6VRQxBctwdxH4pJbELABIPb9Wk/rs9zYCwc0PQuuzOb9C9V9y
 5geVXiADK+dPqPSq16I5uQgI+SXao4api3yJ+I46PHwlXM5n0QScrGz3ZQLcHC4AuhmI0KBb
 HbymtsBC3sFvhIiTOz2j12PSSJcZ3GuUK0g5zE2E5mmDIfGRoC1mrONxia7HptMZmBHEF+AC
 3nod5+cV/cWdC2SOtNhkiADVbW5T48uzx+vuxX+y7pjNefV+ywYtZf429hv/eLfjxAy9TpuD
 8ScyW6BVW90nnlbDwMxiYJipU10gnOKzqF8h7QMF8FX5voPVg4lPJrY5+18EdH7HAzbKJPBQ
 1GtSdSOADcrT9t3zcVdTVx6HoCHhwrAwjHiLrsbjb2NC9Rg16vG3GXqYet5xWzH0qYJkFQsB
 MdCYz71zpVj/hTeUtaa236SkLynIOFFhHalHAaryGOPuBsdSwtsSeDfWntZYELKrNP/70eET
 rm0CL1hPBESgdWaJP5sbdvkxU5DWO+lIM7XNke4gWStHlClwr2WbYzlU3oQ1mPRBRtMiBgdq
 E6PLhN2HSK9uyTbBT1qG0joZhbJ+PN9tWj9Y0s61QCMYGV+2rDz9hNGzeeERaY12bQJ8Dwkt
 y0yHFu52IfODMGcogN6YKhGSdY6/UsBym/T8QBwVnC5B4ZlgFNWMwF+vke0kg5yFp0Fi88h6
 nUj0At1L6ucllJHbTKRm57qaPXRLSHp8RajZrSzuBmW2cuK+qoJ9PUzqkny9ACvGE049nx70
 t5Tm3KC75TOBQAWXNr/SEEyvxR9orjbZGE66ea2nTVJOLO3rySE9tYnHuojxT6/ct0ZPK7FX
 A7+HssGBtS/ffQwkgvhZRYFMeZOsa8sapn/Lb3cgvHtZbkmxWj16AYPqJpw2U+N6SdmH+vB3
 pJfhuqdwhPCTTD3ylGorsHwn4lAIzAUBGu2jyb+V+szLuV/e5gGDWC2Loi53NJ70tTIUmRb6
 UXlKlcIws6vdjKNYla70QAahiF16TS33DC1yTB5iWRji6OF3zHVhcnmegAGPGFjW2Roy1vha
 9vR7ZhSTA2jaA4nkwGg7EDxyv1ApahxGGLURF9BYyn8K2wKvrKYjrOZeIYP7ZoptX8SS+Gge
 RWATbW7pRIG0iTlFm8YxTYhdjjstI+r1xB9jWucKj50oh+7MYlVzA3c+ceaaPpfxDsASwFnh
 DORClX0M9Sy/NqSnovOqajkDjjnDMcMN3C0i9ra/CKgrXVnGxi+g+y+lriFWUAh3Cn32sMrH
 STEoRDgY5X6gqGzMOZpZE5tVxf378t3HJ07k5Nl3shKnyJA2dPMojxeyzSWU50Tw6/1YXsTS
 CRextfU5FKgw0h/NjeTwIm/UHyBw8xnbt38Y2UM2yt74doZbcXcpLFCgyZxpUK16AzLZv0o1
 BIU0/gz8zg3h+8TuQwi5jqQCPYeEAMLWE6k3wTN9N24oKhNMSyKeKKzyVE4sNSvFrCErSlDV
 Xy/dppoTkoSpo1vdVnL1nP08ITtftLdOMkSuhOjmBDFl+FJKZg1m6lClW99NGn6p3Fg1/8jg
 Ekkw8ShpIbeYTYInurxEltCOzbyfc9W5jz9kfMUgJONx472VpwzHzIWQN33QPjuHD9avKbiM
 BuSVS0yrW2EEKDTWxCS4gFqohetW9iiZXSQOWVcx9J/QhKQYlNSikYYUX0zzJs+Cxzvz9frb
 UN6oGkY4FKh7BBLz4cKf1H2AGLYuRvtYSw/T4KHakNf6A0boUzSNISI5+Z3VUm057WHqwqAY
 iyebgVMVyQSX1CcQkrkNf+o7MXB9O6RAqy/KeHPaPOAs74WUfDA3p+p3oZ8mlTEfsySInlvC
 eE60UtfTDh4HcregTAGVy0QkWrEcceaoB62/iA/oNq49bznXwfm5I3HDLU3U50n4xetnaKKL
 PKdng58LitEkIwBzznExflX3VIfjT1vayj4EbkEsn2oLuqYkatWAhgHLiJrYZERteRmhFYLY
 JGd04mms9wwxuQ4AFpES1H7z8SgZMhQZnq4KEuCHkGAcrKPOTzMxcjzJ6K6U7xZyutO5HjS8
 X6WFVHuOjObmnznTReqZKtphTuYIQcYlYWzaBdrBkD8QdigZhDxY7oVxXUmhKY5gH/HLztWK
 T9nb0ZEtaGd9wtdhehjXXNM5DxpIKPX/kTRp/mdIZEQv/xxBy1ynO8P+3U2xYxe6yRcTeB0k
 i/fxjaLi06rmK+Dx2g/OPKhgilGjsSHsBc7UU043pxHRGqC4x8Hq2mdWUximg==
IronPort-Data: A9a23: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
 bAJeF15
IronPort-HdrOrdr: A9a23:NNOPgqksi7CVvsdug+prPOmUH2PpDfL43DAbv31ZSRFFG/FwWf
 re/sjzpiWE7Ar5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQyVxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK6PoSizPZLz9P+qjlzImVpaP502pnSx1sZppt9gFjF2+gYzBLrUV9ZKbQD/
 Cnl7F6TtebCA4qhk/XPBM4Y9Q=
X-Talos-CUID: =?us-ascii?q?9a23=3AhEZ2imvmRcL/TkhZLLJMdjv76ItiVU3ynEvSJnW?=
 =?us-ascii?q?xLj9KTbrSdFCNyZF7xp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3A0oEIkQznVy5vovEkbn1dc2ZpOKmaqKCMEgdSq9J?=
 =?us-ascii?q?agtDHNS8hITSA1xqGSaZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.09,265,1716242400"; 
   d="scan'208";a="178173017"
X-MGA-submission: =?us-ascii?q?MDEAWDFvgE+KM8H+Y00LTZiH3J+tUYppeAAQPV?=
 =?us-ascii?q?AHYlXeiyYVbsNTyi5ynZmEuU/lpwV8Vv5swvMYLFteov4CzhZXbObMFw?=
 =?us-ascii?q?Z6jC9tIohJMx1tfBvLATyOpJyKk5M7io9dZe0/w1rWPtqveJ6UqldB/K?=
 =?us-ascii?q?3VpTUY5kSklTSfZCS2bIeyPg=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 18:32:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1722875535; x=1723480335; i=markus.elfring@web.de;
	bh=kh4fhHmLO8iZAjllPEYMGaA4z7grBCVny/46sIW1Uyo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=MyV/I70zW3iSQKXdHPyy1CN/6qlab0NIJJpc9UqT7aO2SPPiexSKnpTgTi4P2C8D
	 mNqNI9mPAYT+VXEQUPubPlyq4U0Xqf6cGtwvyuYq4wD52ZCOAj9RT9L3HsOoaicqc
	 CfY0OiVrCKqecIlkZ5spDT5tIsyxF+qs1MI8K1ifB3Bb2HSzqbug0JaeheMorGuza
	 n9Tcj4MPKz1asePAKy8VSLzk3auBPZcHq90z1PpdfD5AXhImYMtP5v07EVlWCyXLF
	 9nxG9YLeCGE1o/Dz0+v3o7BMmr8VqAQVcZ+lyhu6PKm2aa53U2ByYJVU/ZjYtu46q
	 1L/sWVRATynj8Y8SrA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MdO5C-1s1foM40hs-00jpeB; Mon, 05
 Aug 2024 18:32:15 +0200
Message-ID: <f1dd2db9-09be-4691-b635-8cc7e944efa4@web.de>
Date: Mon, 5 Aug 2024 18:32:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Ricardo Ribalda <ribalda@chromium.org>
References: <CANiDSCvmboKBK=Z7uS9tnN_LcPA16rx0j_iWeEoQ=jO+pEgLiA@mail.gmail.com>
 <98a94966-14c6-45c4-99d8-471f65b292ea@web.de>
 <CANiDSCuJHTsHsFLbMGC1S47myfReZX7JBfGZFVknj8y=4-QLCA@mail.gmail.com>
 <fdc397c4-8823-46c3-b471-382ebb483900@web.de>
 <CANiDSCuqX7yRyJfvEJeV99fr1wEwANtg2Ak7MNogfYNEqMJ6Hg@mail.gmail.com>
 <c05b066f-af9b-49c1-9bdb-9167d24e3d3b@web.de>
 <c48956e7-f98f-407b-a4c1-29aa417c7474@web.de>
 <acb79b2d-a040-bdc4-9d5a-faafc3fc7d66@inria.fr>
 <583a6ed8-16db-4a5d-8a07-3f8b7c2c752b@web.de>
 <a3eef460-b292-bbac-417e-a8bee451c38b@inria.fr>
 <21d8ddc7-e8ad-4a72-a245-2df98d87dc3a@web.de>
 <f6ee43ea-4ff5-7ca-a2bd-884a7b6d9c3f@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <f6ee43ea-4ff5-7ca-a2bd-884a7b6d9c3f@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:n9fNDk5/FSfSTnwbP1MGDYD0zDIIZqBB4W88z/g9m+pBpPjlFmd
 CWtdN+T4pcrqUxRZtpGv09q4HuY1fSM1ds6YEByS3tkHJcI/WgG1LsCQPF7agkHKf+TD+pu
 dVva+D6AREevvj17LtncglmLVq0eS51oHhLOcje0LlA7O7SQdMTx6EGmTgb8fsWEXzVkQh8
 aRHtXgtF1TYzskc+vEksw==
UI-OutboundReport: notjunk:1;M01:P0:2yn8/OxSObo=;ViZ9qfRQRoX7hFjZhZZGp9VYq3B
 x0u2te+NEK6TF8sQaUeFEFX6InqY0CpefLfgGHMz89Yk+q78+UX/EtUGGpGfpGj2PQQHgrWOq
 92YX/oEC+MIE39ZDIdAjAAl23ylTyXdMULQ2RYmwoSkAcvy5UVw63frwbekzvBm7utKlHkM2e
 3wvPEHtezib9uTAnI//LFeB3hTuC9/KOckSxF8pRJ2bmn+oJPyeXNGXRRk+mhGdCjegMCsY6l
 jUfuK7zTMDm8B1guIGZR/L7JTZUBs2m0VMlbaiulpUQmhmaUhJXy6dMxMi8RKB2+iOAIW1GzE
 zNnKs3EsRMsxklPkFxItMjmPg7VipPNIRqIubgs1pw2JjnVSaXydD2c8UyEVjxmXg+pIBtLBY
 nos70wRiXjN9E4102Hi/8DgNVIymFB6qycXRBYCjweICKeceHaJbULpZUMDiX841MZJ/VU9o8
 aN4CAMdXZUTypXecngx9rOlWEBGy9VlnqPpI0yLSuu9wSzB1DYGt2rVqOBdLKxoEc+51N0qge
 3FxbGT658huCXjpdrZamBKVNaYIx5XMDx2+DGyrYpLRG1XWakct3IpfpQchImgN1ff0Svt9Mm
 h+phJTYU1GxWQLXTmr2XOWWs1zHzX7rVsG3oNQfkMJMvaN3+KVAlQ41ECOG139m4nHfd4JK1U
 b3t9rJg8sWNgS80OOwxqxgf9lsiRxe53OHygL+eCImOQ/lfQKUbC8NjA0aT/tpzEyt2nZUWWY
 gFMMV4uTz4xZYTzIkyewLUhECd3qXL6NI3tkMFLrrZ4Q2PEiE3gA8LnyBZcN2ZDSqcBIabTtd
 tX1cI0VgxBaKN8pzd87jKf0A==
Subject: Re: [cocci] Questionable run time characteristics for SmPL scripts?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1845
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-08/f1dd2db9-09be-4691-b635-8cc7e944efa4%40web.de>

> If you look at the output, for kmerr.cocci, there is a timeout on every file.

Do you point any special information out from your own software analysis
and build system?

Regards,
Markus
