Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C011DC32771
	for <cocci@archiver.kernel.org>; Sat, 24 Sep 2022 08:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=y88qzrSokX8uJUveX14dgZP0JPxDe5S77TchgXJ1UVg=;
  b=b3AKmso5MJYqEigbIH0DG9dpCDO6g9UIuWjdzDJnh1/VTP2/DQ6wQLrV
   dqgQoRfjHMM/mtMPYq30VU9Cl/iW2xbgDHCDFOy8CnovQA2uLPZUrnyPu
   Tj/euUdR/afw+KVFRAc6W2WaJCGO1ZcvWvU6rILNyb5wsLpKbPeumk9zp
   Q=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.93,341,1654552800"; 
   d="scan'208";a="54323666"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Sep 2022 10:16:18 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6E784E0235; Sat, 24 Sep 2022 10:16:18 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 4924AE0090
	for <cocci@sympa.inria.fr>; Sat, 24 Sep 2022 10:16:16 +0200 (CEST)
IronPort-SDR: 632ebcd0_4QqJCph4uTyvndtDN7WeDIkAvjgy3q+/ZRTiYlSpfJOftCw
 Ls98evS98zH0I90SHBwjgG4tPnHM+pOAQ+QHqMQ==
X-IPAS-Result: =?us-ascii?q?A0BcAAA2vC5jh07ASNlaHQEBAQEJARIBBQUBQIE9BgELA?=
 =?us-ascii?q?YIjgVcuBAtFhE6Ob4IlA4QmhxiHJYRahVUUgWgLAQMBDT8BAgQBAYISgnMCh?=
 =?us-ascii?q?GwCHQcBBDIHDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEARMBAQEXC?=
 =?us-ascii?q?xcHDhAFIoVoDYI1KQGDZAECAgEjHQEBESYBDwsaAiYCAlcGAQwIAQGCeYJtA?=
 =?us-ascii?q?QMNIwerXIEygQGCCAEBBoROHywiUoFcCYERLAGMAIMueicQgVVEgTyDAz6EB?=
 =?us-ascii?q?j6DVoJmlHuEJCYEDgMZKx1BAgELQjQDFQMUAwUkBwMZDyMNDQQWBwwDAwUlA?=
 =?us-ascii?q?wICGwcCAgMCBhMFAgIXNjYIBAgEKyMPBQIHLwUELwIeBAUGEQgCFgIGBAQEB?=
 =?us-ascii?q?BUCEAgCCCYXBxMYGxkBBTInEAkhFgYKBBoNBQYTAyBJJgUKOg8oMWsrHRsKg?=
 =?us-ascii?q?QwqCR8VAwQEAwIGEwMDIgIQKjEUBCkTEi0HK3MJAgMiZwUDAwQoLAMJIR8HK?=
 =?us-ascii?q?CY8B1gSKAEEAwMQIj0GAwkDAiQTSHUCCywTFQUDDRkmCAUjFx0ECDwCBQZXE?=
 =?us-ascii?q?wIKEgMTmXWCeyYHgQgBkwGvEDQHghiBRIFJDJ5NBhMug3aMUIYhDgaSCS2HC?=
 =?us-ascii?q?ROOYWAgp0mBaAcsgVszGiSDNk4DGQ+OIBmEDIotPzQ7AgYBCgEBAwmFRwEBh?=
 =?us-ascii?q?R0BAQ?=
IronPort-PHdr: A9a23:/JpUfhyEG9fmZDDXCzIowFBlVkEcU1XcAAcZ59Idhq5Udez7ptK+Z
 heZvq49xweQFazgqNt8w9LMtK7hXWFSqb2gi1slNKJ2ahkelM8NlBYhCsPWQWfyLfrtcjBoV
 J8aDAwt8H60K1VaF9jjbFPOvHKy8SQSGhLiPgZpO+j5AIHfg9q52uyo9ZDebQZFiDWhbb9vM
 R67sRjfus4KjIV4N60/0AHJonxGe+RXwWNnO1eelAvi68mz4ZBu7T1et+ou+MBcX6r6eb84T
 aFDAzQ9L281/szrugLdQgaJ+3ART38ZkhtMAwjC8RH6QpL8uTb0u+ZhxCWXO9D9QKsqUjq+8
 ahkVB7oiD8GNzEn9mHXltdwh79frB64uhBz35LYbISTOfFjfK3SYMkaSHJCUMhfWCNODJ6yY
 ZURAuoPPehXrZXyqVQVoBuiHAmhHv/jxiNGi3L026AxzuQvERvB3AwlB98At27brM/2NKcPS
 uC+0abGzTHNb/NM2Df97ofIeQ0mrP+LR71wa8nRyVQ0Fw/fgVuQrYLlPymU1uQLvGiW9ORhW
 vy0hGI9tg5+vCGiy8ExgYbGmowb0ErL9TllwIkrP924TlZ2b9CqHpZRqiyXM4V7TMw+Tmxru
 Cs0xKEKtJy4cSULxpkr2xHSZvyZfoWV/x/vSuecLDR7iX95eb+zmxe//Vaux+D6S8K6005Ko
 zJbntXRtH0BzR7e5tadRvdg+kqtxyyD2gLQ5+1cJU05mrDXJpA8zrIqlZcev17PEjL3lUnqi
 qKda18q9fKy6+v9Z7Xrvp+cOJFwigH5Kqkun8u/AfkkMgQUUWmU5/+z2Kf+8kLnWLlKj/s2n
 bfFsJ3CO8gXu6y0DxVX34o98RqzEjOr3MoCkXQFL19JYBeHgJLoO1HKLvD4F/C/g1G0nTls3
 f/GJL7hAojWLnTZn7nhebh961RdyAo1wtBS/JxVBa8aL/7pR0D+qsTUDhkiPAOs2eboFM191
 p8CWWKIGqKVLrvesUWU6eI3P+mMeIgVtS7hJPgi+/HhkX45lEQGfaip2JsXcGq3Eu5nI0Wfe
 3rsg80OHX0EvgokVODqkkGNUSZPZ3auWKIx/jU7B5ioDIjZQoCthKeM3Sa6Hp1TfW9GEEqDH
 W3pd4WCQfcMaTidLtVvkjweBvCdTNoDyBWvvUfewqVuKu6cri8FsZPqktx8+OTXkTkz8yZ1B
 oKTyTfJB1Bpl2VAbDYwlPRuvEV7wV6F+ahliuNVFJpY4PYfFk8xMpXXzsR7DcrzU0TPZISnU
 lGjF/CvGzIsVZocx9EUYkByU4GHhwrAwjHsLrsbjb2NC7Qr/6ia03WndJU18GrPyKR01wpue
 cBIL2Dzw/cnr2A7ZqbMmkSdzeOxcLgEmTTK/yGFxHaPu0dRVEhxV7/EVDYRfBietsz3s2XFS
 bLmErE7Kk1Z08fXD6JQacDyy3hCSu3iPtv2fG+73Wu9Vl6T3r3ZVIPxYC0G2TnFTk0NkgQd5
 3GDYC03HCS8uCTzCDJ0FFTgS1zh+69ypSDzVVc6mieNaUApzL+p4lgViPibHusUxa4BsTw9p
 i9cGVGgw5TJBtDGqwcJkLx0R9Q77R8H0GvYs1Y4JZm8N+V4gVVYdQ1rvkTo3hExC4NakMFso
 ml4hAx1YbmV1l9MbVb6ldj5J6HXJ2/u/Ruud7+e21fQ18yT87sO7/JwokvqvQWgHE4vu3t91
 Nwd33yZ75TMRA0cNPC5GmM+7RtnvPf3Zicn5oXb/WJhO++4v36K2t4kAvck1gf1Z81WY+uPE
 A7/FdFfBtD7crV13QfzKEtVZqYNpP1RXYvubfaN1a+1Mfw1mTuniT4C+4VhygeW8CE6TOfU3
 pEDyvXe3w2dVj66gk3y16K/0Y1CezwWGXKyjCb+A4sELIh7Z4UWEiGDJ8Otx9Nxr4HgUThU+
 RTwYjFOkN/sYheUY1HniEd13F4UvGfhtC+21T1ynBk2o6DZ0CGEkIGAPFIXf2VMQmdll1LlJ
 4O52ssbUEafZA8sjBK55Ez+ysC3vYxHJnLICQdNdinydSR5V7eo86CFaIhJ4Y8ptiNeVKK9Z
 0qbQ/jzuUlS3yTmFmpYjDc1ElPi8rDwhR9nkySwKHhprXzWUd59z1HT6ZTQSOVQ0TwPWCRjw
 WOOWR7jZZ/wrI/SyMeLu/v2T2+7U5xPbSTnqOHI/DC242FnG1z3nvy+nMHmDRlv1Cb609dwU
 iCb5B34Y4Tty+G7Kbc9JxYuWwW6spsgXN4uwe5SzNkK1HMXh4uY5y8CmGb3a5BA3L7mKWAKT
 ngNysLU5w7s3AtiKGiIzsT3TCb4oIMpat+kb2cRwi944dpNDfLeybVenjZu5He8oxjQZ/dVg
 ToXj/cjoi1/4alBqE82wyORD6pHV2xRJy/xjFKl696kraNYTHmie/682QAt+LLpRKHHqQZaV
 nHjf54kFiIl9cRzPmXH13jr453lct3dPpoD8weZmBDag61JOYo8w7AU0DF/Nzu37hhHg6Yry
 AZj1pagsM2bJnVxqeinVwVAOGS9ZttPqGu01+AExJnQhtrxWMw7SnJRAf6KBbqpCG5A7629c
 VzUT3tl9zHDXuCCVQ6HtBU89iiJScr0cSjIYiFel4oqRQHBdhYG30ZLBnNjz8R/TFz6g5awF
 SUxrjEJugyo8F0VlL8ubkSuFD+Y/lngay9oGsLGc1wJtEcYvxiTaYvEsapyB30KpMT+6lPXb
 DXKPUIWUSZTBCnmTxjiJuX8tYOGqrbFQLDkfr2XOu3GqPQCBafSg8vxj808pG7KbJ/He3BmC
 7dTNlNre3d/FoyZnjwOT3ZSjCfRd4uBoxz6/CRrr8e5+fCtWQT15ILJBaEAedNoswu7h6uOL
 YvyzG5wNCpY25UQxHTJ1KlX3VgcjDtrfiWsFrJIvDDETabZkKtaRxABbCY7OMxN5qM6lg5DX
 KyTwsvyzaJ9h+UpBk1tUFv8hoe2aMZML2z8fFLLCUCXNaiXcD3Gx8akBMH0AbZUjehSq1ixo
 WPBShClYW7FzmizEU//YoQuxGmBMRdTuZ+waENoAGnnFpf9bwGjdcVwhnswyKE1gXXDMSgdN
 yJ9egVDtO71j2sQj/NhFmhG9ncgI/ODnnPTyuDCKYsN99ZvDD51ke1y/3kwjbdYpnIhJrQ9i
 G7Jo9hirkvz2PGI0SZiWQFSpyxjgYWWoQN9NK+f+pQKChOmtFodqG6XDRoNvd5sDNbi7rtRx
 tb4n6X2MD5e8tjQ8KP06ODLJcjBPHdzaHIB+RbRCxYZCyGmPyfTih4F+Bl33mKYpN42p8q08
 Kc=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:qggPIanMJ0GymgzbZt2Xa/BGB0PpDfII3DAbv31ZSRFFG/FwWf
 re/sjzpiWE7Ar5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQyVxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK6PoSizPZLz9P+qjlzEnlv4bjJ2wGd3AQV0iM1XYCNu6jeHcGOTWvjvcCfq
 ah2g==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,341,1654552800"; 
   d="scan'208";a="54323663"
X-MGA-submission: =?us-ascii?q?MDHlp60umvB0r0HVMhTbw8hYF5DrX/wbHMzXS4?=
 =?us-ascii?q?S2xFmmatE3nuKNhXiMemLjqx1f2mO2Sy9nj3YWLBMID+R27VfFlAHgrk?=
 =?us-ascii?q?wpHVBdXzs1CSpJEo8bSLBUtZxukdZVgPUQmFFVFFaokkFl5W4FRNv6zd?=
 =?us-ascii?q?EvwQXBLAv5xGa8iVWwUbstxQ=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2022 10:16:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1664007365; bh=myfOSIyvyKQNuPIx3CXsGm0szTxvmdym6AErAX9ktos=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=t3u4yrda618USgTtXhtgnHfPQcL0FeWT7KiIkAAr2wKk++U29lteq/2iO14gAv7Ih
	 i7cFsS+kgu3xIHHuKX6Yi23t/R936R+jU4OuykgTr6+qT0hMFjd52S5gox3zxhMVRF
	 XGgCuSSHIvUDNk3iWZ57LD4jOchSNbXaw8AURfGlwl6+hFluU2DAUjbKX+T6joGC5a
	 sE+Q2NQgG2B35P4H/yV5yhIB3t3YHyX/NdYDtgLE8vuQqucKTROHzq1eFDy5ZQLzOM
	 ZqiGG7wmvD3QKcHn8YT4FFD6rT2CxtvNxF2lwYVE33OA5lxyW3MbL2uRYoa0wIv/vN
	 IubUV8jLgrO2A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.160]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1My6lR-1pTWtW0X1T-00zGy4; Sat, 24
 Sep 2022 10:16:05 +0200
Message-ID: <64bc1278-b783-ea80-9b90-e5da7185425f@web.de>
Date: Sat, 24 Sep 2022 10:15:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
To: Julia Lawall <julia.lawall@inria.fr>, Yuan Can <yuancan@huawei.com>,
 cocci@inria.fr
Cc: Nicolas Palix <nicolas.palix@imag.fr>, kernel-janitors@vger.kernel.org
References: <20220922115535.44132-1-yuancan@huawei.com>
 <20220922115535.44132-2-yuancan@huawei.com>
 <3351dd3d-f55a-10b0-6b35-d5206570e687@web.de>
 <2274a1a9-4b13-7677-9cf7-55ea960d8be@inria.fr>
 <6a0600c7-dcdd-f37d-9a6d-cc734cf88dd1@web.de>
 <54938aa-3629-2bc2-edc-cc1b3246866@inria.fr>
 <2a8b2d3c-26cf-3aab-34b3-1ba402740111@web.de>
 <alpine.DEB.2.22.394.2209232125480.2720@hadrien>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2209232125480.2720@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TLZOfNizaN+aRHhfkbaVEIBUFh6aeeeScINVAuHrzsOssJIzKUc
 yuNMyH9cicv72exNW6E5svFKScgCe9XMgQqXA4veGeIUSVYKKpGCe6oZy9I7GWrDEli+tiM
 tn7+HTDTYWiD7pU54ok76GkcMFpV1ZwpYpY1HnQfarFTS+fiMUwEmGO8ax37vu3rD2zd+KY
 goH+hL34CH2Iy7OHI1A2A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kwLCPxLPmhY=:AuOtI2Im4EeAx806HjMGS1
 gnwq3EjVXslfro1ooUwyeIsqQtHXoaFza4HQQYZ15P+Udn1SVI1eoQxTuW3iGB0NAKoPdHgpc
 5N2q+hK88KbyrI9s/qApAReiObHVTm0O82gh3AMNfmCGx90hP/NwA5DGJ071mMYL0E5zyH2p8
 7D4WKhfQ0ykypBnlme4uab6lwNk37907HBfpoQxbyWNU873QkNCl868p8xvggcEEERBq7Ttrw
 xETVDy7WV2gvADJTS5LNDZGT2Os9N7rr4prjOmjLVsU/UjGwzpgPR37QBvvdRIIktlZpkP9cA
 QIWPZMUJmJ7D4SiLVtu4J1HZmUpm6jizVOMiRs90TPLGwnqkDQx+hoOpkXoYlSyGahyT/F9qh
 5i/hmTJZDMMkB8yAJRljUDR/E+EQDUYXmRa6IF2Y4Ary1uCQCJVWhVXYuref9HJ873bOrMUYl
 27UKcXXPa31O8GmVyIBtP9NWmqAplrCcZQmZbVbdOZJjOhPNuOnhfzVzqO0bVChY8XZRI/OB2
 2cWhCJTdGrbPmFjxY4C5qpEphSwgkfjw0XjUfZ8G5yph7bMt8aRJ0heUqCdGzHmxhalvwXMpZ
 VDysQA8Zi7RGrN+QAQ7yy8xhPmvOH3qioQaj7FvcR0xT9cqsNcoVdYKdq/yqBPQ6d6gcERUmP
 hSzN1nmSOOTkCmNmn1ezYzRmwZdVvGVhdx7uOxd2WvR2yBhx90ea8AtdZ/olMMATlx3NYfyHA
 vgYAiafoKBNEk5Oy95gFOaoY10RC3ch0dLiehXiRxWlET7lNnQV0wf8uv9ooeVqIkrVfSdDEn
 SHQ8AwtswXkCuYPPhOAA/fstnCHjEcWf95yQDJzO92QKglaSp+hBUfZCV1KRjysAdzjvVLtyQ
 geYXut5jKEW5DDr5FjD+9q4J/OaTYgWSYCwnntSOad1KSggaSZP3V/H3Thg9J7WOJ2sqd6oyJ
 6hvNctS/LAMwNQULgphvxydj/Ap29IRfrwcMAGHNXqhfiyKi7o8Zu09y17rEn8Yt4tPZGNlJx
 pU7YjYLlW/AE0mNCxDUwu9Cr93OjufHtYS2dgK1qV0z8sOpy1B9F/oKR4limohukXzzGXnsFE
 wfOsjEuyKqdNl3gG4/FA2GRKZE956AfiUA0e0+ySk9abmcEOfuUeyhN2ntD6KH4of9vYx8IoP
 HuvCCDgw5L0t6HXd8OwKOPja6v
Subject: Re: [cocci] [v3 1/2] coccinelle: locks: add
 missing_mutex_init.cocci script
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 580
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/64bc1278-b783-ea80-9b90-e5da7185425f%40web.de>

>> Would it be relevant to use the SmPL construct =E2=80=9C<+... =E2=80=A6=
 ...+>=E2=80=9D?
> Not in a structure definition.


Will further explanations become helpful for this functionality?



>> Please take another look at mentioned implementation details for
>> the clarification of such communication difficulties.
>>
>> A)
>> position p !=3D {r2.p};
>>
>> B)
>> position p !=3D find_member.p;
> OK, both are fine.  If there are multiple positions that p should be
> different from then the {} would be required.


I got the impression that different test results are involved.

Do you expect that identical results should be produced
(also according to the selection of such a SmPL constraint variant)?

Can this SmPL constraint be omitted because of an other data processing ap=
proach?


>> How do you think about an opposite source code search order?
>>
>> Would you like to search for function calls which require initialised
>> data structures before any additional source code analysis?
> It doesn't make much sense to have a mutex without initializing it.

It is nice that some programming mistakes can be found also by the means o=
f
the semantic patch language.
Limitations of the Coccinelle software will trigger further development
considerations accordingly, won't they?

Can you find a source code search order more desirable than other directio=
ns?

Regards,
Markus
