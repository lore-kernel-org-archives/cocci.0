Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B9EEC4829C
	for <cocci@archiver.kernel.org>; Fri,  9 Feb 2024 09:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Ap81ZcoAIZSUVBypib9xgxXkVVxhPVjNI0LRzM8mJa4=;
  b=PvhpIM35kKnUgf17ubVt0oFtT13iVYLbGiNxqxyovYotLRHbmcQUnfUq
   ZXNwhvWwJtGHl9FZO+JFuTdhjhsRBXgtUlF9O6xoeLhGZ1wTWMYARoePb
   VdCU6nFHiD/1HEBMWVfmSVgI9Y8BYUeIyyRPj39i0mbQmU6ovaoENdwQw
   g=;
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
X-IronPort-AV: E=Sophos;i="6.05,256,1701126000"; 
   d="scan'208";a="151145362"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Feb 2024 10:48:29 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 285D2E0CD7; Fri,  9 Feb 2024 10:48:29 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 55067E008A
	for <cocci@sympa.inria.fr>; Fri,  9 Feb 2024 10:48:24 +0100 (CET)
IronPort-SDR: 65c5f4e7_q1wcSBQWrHzxRg3+5jhgKYT5LzzNYNGhafIHKouq1CVE663
 MLcxv2tPrHGrpUi19yG5SlbY+WbFtqGtis7P3Pg==
X-IPAS-Result: =?us-ascii?q?A0H+AAB29MVlhwsR49RaHQEBAQEJARIBBQUBQIE+BQELA?=
 =?us-ascii?q?YI4fANTMgQLSAiES5E6LQOEO48FiHCDFj4PAQMBDT0EAQIEAQEDAwGCC4J0A?=
 =?us-ascii?q?odXAh4HAQQzBg4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECEAEBA?=
 =?us-ascii?q?SMXBw4QJ4VsDYJcARCBDoEmAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQECR0IBAgIBIx0BAREnBAsLGgIfBwICVgYBFAEBgnwBg?=
 =?us-ascii?q?ioBAw4jBw0GtWmBMoEBggoBAQaBV0GtQh8sIlaBYQMGgRouAYglAYVuhDsnD?=
 =?us-ascii?q?4FVRIE8gwM+gmEBA4ElOYNbgmiCGIM8mAZUfx0DgQUEWg0bEB43ERAFDg0DC?=
 =?us-ascii?q?G4dAjE6AwUDBDIKEgwLHwVVA0MGSQsDAhoFAwMEgTAFDRoCEBoGDCYDAxJJA?=
 =?us-ascii?q?hAUAzgDAwYDCjEwVUEMUANkHzIJPA8MGgIbGw0nIwIsQAMREAIWAx0WBDIRC?=
 =?us-ascii?q?QsmAyoGNgISDAYGBl0jBw8JBCUDCAQDKykDIXQRAwQKAxQHCwd4ggmBPgQTR?=
 =?us-ascii?q?AMQgTSFPoQOAxkrHUACAQttPTUJCxsGPQKdWwGBWWwGYlmBBYEaK8UaNAeCN?=
 =?us-ascii?q?IFggWEMihuVHQYTL5cuDgaSXphXII1PmwiBeSSBXDMaJIM2TwMZD44gGR+Dd?=
 =?us-ascii?q?YELjjxCNQIJMAIHCwEBAwmFRgEBgyY0gUYBAQ?=
IronPort-PHdr: A9a23:cSVPQR0YhDcVrF3NsmDOXg4yDhhOgF0UFjAc5pdvsb9SaKPrp82kY
 BaOo60zxweXFcWDsrQY0bqQ6/ihEUU7or+/81k6M6ZwHycfjssXmwFySOWkMmbcaMDQUiohA
 c5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFRrwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/I
 AuyoAnLqsUbgIRuJrowxxDUpndEZ/layXlnKF6NnBvw/Nu88IJm/y9Np/8v6slMXLn1cKg/U
 bFWFjMqPXwr6sb2rxfDVwyP5nUdUmUSjBVFBhXO4Q/5UJnsrCb0r/Jx1yaGM8L4S7A0Qimi4
 LxwSBD0kicHNiU2/3/Rh8dtka9UuhOhpxh4w47JfIGYMed1c63Bcd8GQ2dKQ91cXDJdDIyic
 4QPDvIBPedGoIn7u1sOtga1CQ21CO/y1jNEmnr60Ksn2OojDA7GxhQtEdEAvnvbotr7KbkcU
 e61wqbK0TrNYOhb2Svk6IXSbhwtve+AULB2fMHMyUcvDQTFjlCIpILiJTyVzOcNs3WA7+F9W
 uyvj2Anqxtwojipyccnl47EiIUPxVDe9iV53Z01Kce3Rk5/b96kCppQtyeVN4ZtTMItXXpnt
 DwnxbIYoJO2ejUBx5s7yRDFcfOHb5SI7Qz5VOaXOTp2inZodbaxihuz7UWtxe3xWMmw3VtEs
 idIk9jBu3IN2hHS9MWKRfVz81mh1DuN1w3e6PxILE8omabHN5Ms37E+m5wOukrNGS/2nV/5j
 K6Qdkg8++io7f7nYrT8qZOGOY90kAfzObktlMynGek0LBUCU3aB9eiiyrHu/1f1TKhIg/Esj
 6XVrYjWKMAUq6KjDQJZz5wv5hW/Aju81NkVnX8KJ09bdRKDkojpIE3OL+7iDfmiglStkSlky
 ujaMrDnH57DNGLMkK37crZ480NcyBQ8zdRY559MD7EBJ+/zWlPruN3WEBA2KBa4zPv5B9ll1
 4MeX3yAArOBPa/MrFOE+PgjL/eSaIIXojrxNvoo6+TzgXMkgVMdeLOm3ZoTaHC2BPRmJECZb
 GLrjNgbC2cKvRc+TPfwhFONVT5TaWyyX6M65jE0E4+nA5nMSZu3jLOcwii3BptWaXteBVCWD
 Xjob5mEW+sLaC+KPMNtiiYEWqS5S489yRGusxf3xKZgLuXI5iIYtInu1MN15u3WjRE97yZ4D
 8Wb02GXTmF7hHkERzEs3Kxnu0xy1k+D0bRkg/xfDdFT4+lGUwkgOp7Yy+x3ENHzWgPEftiSU
 lapWM+qATA3TtIrwt8BeVxxG9u4jkOL4y3/IaIRlrXDIJUr+6bYlyzzOsJ8wjDC3bYoi10OQ
 81VNGTgiLQps0DYAIXCkm2YkbyrfOISxn3j7mCGmE+HpkJFS0ZdVavfXHYQLh/zpM76+1iEY
 rugE7UhPSNexMTEJqYcOY6htklPWPq2YIeWWGm2gWrlQE/QnttkDaLvcmQZh2DGDVQc1hsU5
 TCAPBQ/ASGopyTfCiZvHBTheRCk6vFw/VW8SEJ81ASWdwt5zbPg3xcPhuGHDd4X0KgFvigJt
 Dh+WlqwjJrNE9TVnwN6Z+1HZM8lplJO1GbXrQt4a7mpNaN/nRgzdwptvkXh/wp6AMNMnJtit
 2skmSx1L6/Qy1Zdb3WY0JT3b6XQMXX39QuzZrT+31bDzJCJ961J5PlQR0zLmgavGwJi9nxm1
 4IQyH6A/tDRCxJUV5vtU0Ex/hw8prfAYyB76ZmGnXtrebK5tDPPwbdLTKMs1wqgctFDMaiFC
 B66EssUANKrIfArnF7hZwwNPeRb/qo5d828cP7O1KmuNedm1DWo6AYPqKV0yEGR7GxRTuDS3
 pAK6+6V1E2LWna0jVustNz2hZERfSsbTSK0zSnpApIUZ7UnJ99RTz30fIvumZMn3s2IOTYQ7
 lOoClIY1dX8fBOTawe4xghMzQEMpmThnyKkzjtymjVvr6yF3SWIzf6xEXhPcmNNWmRmik/hZ
 IauiNVPFm2hdQs0j12I4Ujgxq5UjLtyJS/fTA0bGkq+Z3EnSaa2ureYNoRq4YkrrD4RfeCye
 1GcRZbirhFc3y6pTA48jHgrMjqtvJv+hRlzjmmQeW1yoHTucsZ13R7D5dbYSJa9xxI+TTJjw
 XnSD1m4ZJyy+MmM0ozEqqa4Xn6gUZtadW/qy5mBvW21/z8iDRq6lvG10trpdGpymQryzdp3T
 mPlqBjmY4/k/7u3O6RrcwFkCUT95MxzBoxl2tFp3tdKgydc38rTpCNPmHy7KdhB3KPicHcBI
 FxDi8XY5gTowgwrL36EwZ74SmTIx8JgY9egZWZFkik57s1MFOKV9OkexHEz+ADn61uOJ6Ekz
 VJ/gbM05XUXgv8Eol8oxySZWfUJGFVAeDfrj1KO5sy/q6NeYCCud6Kx3Qxwh4PEbvnKrwdCV
 XL+YppnEzV365A1FVvW02DorKzgdsPRa907qRCe1RvNxbswStp5hr8RiCxrNHio91gs0e0ml
 lpD2Z+gvY6IA3pg9uS1D1QLU1+9L9NW8Tbrg6FEm8+Q1I36BZRtFAIAW57wRO6pGjYf5rz3c
 hyDGzompjKHCKLSSEWBvVx+oSuFQPXJfzmHYWMUxtJ4SFyBKVxD1UoKCS4ikMdxH1Kvw9H9N
 lh07HYd6xbx+B5L1/4tJxf4SHjWvgvudTo+DpSSSXgepggQ4kDILYmU6f91FCwe4ZCr6gCAY
 mXJYgNVESQCQUaZA1OlZ7Co6YCG+O+dY4j2Z/KcZLKTtalVTPyP34rpi4Jg82/KPcKKdm9rC
 /lxsqZadVZ+HcmR2zAGSihM0jnIc9bevxCkvCt+ssG49v3vHgPp/4qGTbVIY51p/FitjKGPO
 vT15m4xICtE1p4K2X7DyaQOlF8UhSZ0cjCxELMG/SfTRaPUk6VTAlYVcSR2fMdP6qs92EFKN
 6u5wpvt0aVki/cuF1pffVnmh93vesEAZW2wdRvGCEuNKLWaNGjLzsXwMsbeAfVbiORZsQH1u
 C7OSRa5eG7ZyH+wCFb2aLIp7mnTJhFVtYCjfww4DGHiSImjcRinKJpsiiVwx7Qoh3TMPGpaM
 D5mckoLoKfDiEEQyvh5BWFF6WJoaOeenCPMpczRMJULqr1GBipuluRVyGs3wf1Z4WsXIZ490
 DuXtdNor1y8x6OXzSF7VRNVtjtRrIeMoFkkJqjTsJVNEyWhnlpF/SCbDBIEoMFgA9vktvVLy
 9TBo6n0LS9L79Pe+cZ07y38N8+NdnYsY0KB8NH8EwYPCzKmZzi3b611lfaP6juKo5J8ppW+w
 PIz
IronPort-Data: A9a23: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
 4T4qaCojXxXkXLMLPs=
IronPort-HdrOrdr: A9a23:rE5kX6Pgdoikg8BcTh+jsMiBIKoaSvp037BZ7TETdfUzSL3gqy
 nOpoV86faQsl0ssR4b9uxoVJPwJU80sKQFhrX5Xo3NYOCFggeVxehZhOOO/9SjIVyaygc378
 ddmsZFeb/NJGRbyeDn/QK/D9Es+9Wf9ru07N2utUuFATsKV0l6hT0Jcjpz/3cGPzWvjvcCfq
 ah2g==
X-Talos-CUID: =?us-ascii?q?9a23=3Ak4RZgWn43MyvR/cSrzGBnxkHqN/XOUfe9EzPek6?=
 =?us-ascii?q?jMD5wRpmkcG6T4J1AnvM7zg=3D=3D?=
X-Talos-MUID: 9a23:xIypKwR9v2xPBMdDRXSznxBkO/4v7J71UmA1mK44po7HG29JbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.05,256,1701126000"; 
   d="scan'208";a="79193432"
X-MGA-submission: =?us-ascii?q?MDGOo/TQmwqlGa6uc5deN98Upgroh6C9Wh9O0R?=
 =?us-ascii?q?1hNAx76aZeh8QWznI1C2AYE0O/y8sj+1ozTuAtkR/hKwyRxbkQcoaBYs?=
 =?us-ascii?q?9PEWo6ORMhdqbzo5Wpe9QnAV4XDvJkN2V5NcXYDfb1Yb49BQCr/pthtW?=
 =?us-ascii?q?4gmc+5SLi08rN+eTduT5DpJg=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 10:48:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1707472102; x=1708076902; i=markus.elfring@web.de;
	bh=Ap81ZcoAIZSUVBypib9xgxXkVVxhPVjNI0LRzM8mJa4=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=GZfwPGvxwIpHIsVzpSZJ92HSHzf6P1H2eUncPx52hGI/kKbzX7ZUgZMGD7bX4mDU
	 uuOsB8fN0XrR82RAQzzHt8ww1ifnnJLiHV4Z0MWNbs/4dpZRN8Hu9SXCHVvbguzvb
	 HbZiZjKEhXvMgTOmZQcTABtiW9Jpywj+MnUz4fLDGbJILqoRRjgrm+BFBtbMnGvP/
	 14G4zuGtG7kioKEpmjxOAu8PM1zl57uwLBPGdHj4TlY10GjnJ2uTtfHyf03mW1+GY
	 sbbLP24o74xSN3gChx8JeXPSi0EvGEC2Pm/Uu99EzXoBwm2ybPyj5UQ7qgIo3fQBr
	 ndM30oNiXLsquI4eWA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N2SP7-1qrWP31p0h-013sAy; Fri, 09
 Feb 2024 10:48:22 +0100
Message-ID: <bab9b73c-9f9d-43db-9fbe-5bbd736a29d5@web.de>
Date: Fri, 9 Feb 2024 10:48:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <41052adc-2065-4cf2-9160-2e986de1bf9b@web.de>
 <289a052b-86ff-4ecd-ae55-89fc0238373e@web.de>
 <alpine.DEB.2.22.394.2402072108500.3138@hadrien>
 <d983ec62-2e0e-4102-bddc-4c420a75601b@web.de>
 <51feebc2-751d-4e1b-bf72-28dc8ed975c9@web.de>
 <eb10beb1-c8b-47e5-ab28-5c1bba502d2a@inria.fr>
 <70dc14fc-5e21-4eee-be17-c9fd30b99cef@web.de>
 <856ae5f3-f31a-2661-90ae-6041c3318893@inria.fr>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <856ae5f3-f31a-2661-90ae-6041c3318893@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XiFABkQ+cNZRfwZyT6znM9wmgWK8YUSNLc3VBzjI1H4Ef+WnRV1
 zcC9tZwEOkUVmWiGa7mO9lV6ieCcARl7YmXyEihAMEOVg6bZp92HhV8toNBuXp5ggIQVwMe
 8EFmcFzTFd6l46O+JYm72SDhfya52VrptBPzfsI9CGGfPoKAguvFXYa/8dh52km9lX/2WXS
 Qu7PuYUfBmuq6E2mE63kw==
UI-OutboundReport: notjunk:1;M01:P0:TuTBM5h5TOQ=;7BOpfnKgcCxSna9+V1206M5fQa7
 /w7MiPvweRkJy3YQ7lbFlSbK8lL8lw0JQhu2JfXRsycfDCM3aTzBfckuUii3TxQcf3k4rk1az
 bmX2Fwz9JR/6/ZEJ/kZZ+GokjFwUhwPO+sTgn0TSzfLxp5hGKNMclaoi0MYWbOuFCladsXQGQ
 F3iWZ7N4UotfMs4+MYiaZoPubKoZAchl/p1HuXo5q+J5OhIJXgTkA9coxh99BVhGZaAn0qkeb
 4DJE0PQoW0oigKZFJ/zj+pK7Djqk+V8tL26Lv8lhUQ8Xxt23HlvrnfTvf74rLVhu9F6n3DOKa
 uWMSN/sIUR7D5c1m+PWfe+EZ40CxGYydTUGHUPGZsXVu0bIYJ5yp6VIF8DOItAHRqvppZnZ10
 USIUcawT4RA8k6HaBeTut5hGKdGkKYi6IPMZNFMGMN3CYur2qi7tQeyf6LaDoA1VO8+huoEns
 23a9cgbzx0t21yvC/ijI4LK2bEGgn8Mp0b2GKpp9A5DVKpEjfadSg/5sui8Bl7ohDzgPsECyl
 FJnUh0Hg/oqKAj5pXqYW3VfD5ib0QdbmrPehPh8wx9xMi2BfBkH1KHNpKiLAuKxE2P820PLnQ
 2RNytAqnuc4Nw/t8cJYNvHyZmm4e/Osl7nuLtZZXxSHQNQtCZtdjBycB9/+Aht+iNQb6YIsfF
 r3Ey4WkP8dGpILcTqSLbOxdN3YDi1yF9Xl6aQQJzzuZAtZhMZ1sx10tUvPdoJkMWQ1MYQiphj
 YQDgPwuR68uzFMmlAug6mO3Hxj0/uClCeP6f2xLJzrO8dQBc5mj+rYjmExwD2RrqWa9MVNl3Q
 RBZPk5q8wQLGE115oB3vrw7u9mOtFIhDRvxTpXV8mMsKM=
Subject: Re: [cocci] Supporting transformations better according to reduced
 number of function call parameters
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1529
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/bab9b73c-9f9d-43db-9fbe-5bbd736a29d5%40web.de>

>> The case distinction is essential here that a variable declaration
>> must be preserved for one function/macro call while it may eventually
>> be considered for deletion according to an other function/macro call va=
riant.
>>
>> The semantic patch language supports some metavariable types.
>> Special restrictions can be achieved by combining them with the means o=
f conjunctions.
>> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/4965f42eb94d2d67f7=
375c66b268997457cbcefb/docs/manual/cocci_syntax.tex#L1041
>>
>> Can it be that a branch of a SmPL disjunction can not directly benefit =
from
>> metavariable matches in previous branches by reusing their contents so =
far?
>
> I don't think it is useful to do anything for this.

I assume that additional users can influence the software evolution
in proposed directions.

Would you like to confirm that metavariables are used within SmPL disjunct=
ion branches
in independent ways so far?


> It may be simpler to just make a change, and then delete all variables
> that are never used in a separate rule, given that normally all variable=
s
> are used, so unused ones are likely ones that you made be unused.

Programming interfaces are evolving.
Thus it can happen that one of possible code adjustments should only be ap=
plied
if a corresponding precondition is fulfilled.

Regards,
Markus
