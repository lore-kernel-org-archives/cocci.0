Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59EAACA101F
	for <cocci@archiver.kernel.org>; Fri, 12 Sep 2025 13:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=f8XhiKpsz03WaNyRyZCXMzKln7mWJhkpGIJviAkM4Tg=;
  b=U3Q7Q0TxFNhlx7TZxS3VHhdRcmeM6Fwt7H9+S7NGWWdCaTQFDGtI2a4w
   WircayYg/xmxUiOSnof95xaS1881mfvMDm3gwGgzroFm050tPgo6mepGh
   VlwQo/GHjxaaegaMrZXR8DnyCfimKsKU4oQ1YAcbGqK745Wiu5zFg4sFI
   U=;
X-CSE-ConnectionGUID: PCJQohVuQjGmqfDV8SfZ0w==
X-CSE-MsgGUID: pNUZKKWRRiWOOKIq0v8rHw==
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
X-IronPort-AV: E=Sophos;i="6.18,259,1751234400"; 
   d="scan'208";a="238816014"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Sep 2025 15:43:32 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9F48BE0BE9; Fri, 12 Sep 2025 15:43:32 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 398F1E0172
	for <cocci@sympa.inria.fr>; Fri, 12 Sep 2025 15:43:30 +0200 (CEST)
X-CSE-ConnectionGUID: iOwVKZxATOuUkXq3/eaY7A==
X-CSE-MsgGUID: kq25OgRCQGG/NnJeD0op/w==
IronPort-SDR: 68c42381_EvWx1wono5upkZjwxaNuM+CqPEqpFpkMYnieVaexlKqvrsg
 O/QSXY/kEatCwey6i3fmqp1SSrh/goBgUYv6gcQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EQAADIIcRogA4P49RaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBPwYBAQELAYI/gQJaMwQLSQiETYgchzSCJIQ7mAqBVYF9Ag8BAwENR?=
 =?us-ascii?q?AoBAgQBAQMEhQACjDACHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEBAQENAQEFA?=
 =?us-ascii?q?QEBAgEBAgQGAQIQAQE7Bw4KMYZPDYJiAYEkgSYBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEXAg06RAEBAQIBIwQZAQERJwQLCxoCJgICVgYBFAEBgn4BgiIBBhABAw8mB?=
 =?us-ascii?q?w0GsEt6fzOBAYIMAQEGgmnXdh8sIlmBZAMGgRsuAYVrgmQBhieEPCcPgVVEg?=
 =?us-ascii?q?TyCUjE+gmEEgV6DW4JpgiaBFoNYhleGAotWUngcA1ksAVUTFwsHBYEgQwMqN?=
 =?us-ascii?q?DEjSwUtHYEneYMHgQ2EHitPghxygXQ+GUGDUx4Gaw8GgRUZSQICAgUCQz6Ba?=
 =?us-ascii?q?yIGHxICAwECAjpXEIF8AgIEf0ACAQttPTcJCxsGPZYJgkOBGhA+Eyy0F5RjN?=
 =?us-ascii?q?AeCOIFngWQMii6VPgYTL5dSDgaTBZkGIo1mlXOFRoFoOoFcMxokgzZPAxkPj?=
 =?us-ascii?q?iGEADO5DkE1AgE5AgcBCgEBAwmFRgEBjFaBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:nAzf6q0WMGtv8bwOy/bD5Q11kn2cJEfYwER7XKvMYLTBsI5bp2dUm
 GBLCGiHOK2KMWPye9Bxa9zkoRwC7JDQztAyQAJr3Hw8FHgiRejtVY3IdB+oV8+xBpSeFxw/t
 512hv3odp1coqr0/0/1WlTZhSAhk/zOH/ykVbOs1hlZHWdMUD0mhQ9oh9k3i4tphcnRKw6Ws
 LsemeWGULOe82AyazJ8B56r8ks14ayj4WlA5zTSWNgS1LPgvylNZH4gDfrpR5fIatE8NvK3Q
 e/F0Ia48gvxlz8xCsmom6rMaUYDRLjfJ2Cm0hK6jID/6vTqjnVaPpcTbJLwW28P49m6t4wZJ
 OF2iHCFYVxB0psgNwgqe0Iw/ylWZcWq8VJcSJS1mZT7I0buKxMAzxjyZa2f0EJxFutfWAlzG
 fIkxD8lbzecucGE0JuHbfRRhfQ6d47mNbJAkyQ1pd3ZJa5OrZHrRqLX+ZlH0T12is0m8fT2P
 ZNDL2A1M1KZPlsWZj/7C7pm9Ausrlz2aT5FsxS4oaQt4m7c5BN82v7hPbI5f/TQHpUFxxjA/
 juuE2LRAQhAafuQ8xG83V3roOntkA+jX5pVC+jtnhJtqAbPljRIWEJ+uUGAifK+gUW/c8lOL
 lQdvCsot6k7skKxJvH5VgKxpHqsrB8ZUcBZVew88gCEjKTOizt1HUABSSNdLsMrvok6SFTGy
 2NlgfvoIiNRk4+FYE6664qXnSrpfiUcHDArMHpsoRQ+3/Hvp4Q6jxTqR9llEbKogtCdJd0W6
 2/SxMTZr+pL5fPnx5mGEUb7byWEirWhc+LYzgDQQ37j8Q5zIoKoD2BJ1bQ5xacYRGp6ZgPQ1
 JThpyR4xL5XZX1qvHLUKNjh5Jnztp643MT02DaD5aUJ+TW34GKEdotN+jx4L0oBGp9bJGC3O
 RKO4FsNv8Q70J6WgUlfPN3Z5yMCkveIKDgZfqyLPoQmjmVZL17erXowDaJu9zq2yBRy+U3AB
 XtrWZ3wXS5BWfsPIMueRuAb1qRj3S1W+I8gbcCT8vhT6pLHPCT9Ye5dbjOmN7llhIva+lm92
 4gFaaOilU4FOMWgOXa/zGLmBQpaRZTNLcqm85QPHgNCSyI6cFwc5wj5mO95JNI8w/gEy48lP
 BiVAydl9bY2vlWfQS3iV5ypQOqHsU9X/Cxlbx8/d02lwWYiaouJ5aISPcl/N7o++eApibY+Q
 /AZco/SSr5CWxbWyQQ7NJPdlY1FcAj0pASsOyH+XiMzUaQ9TCP0+/jlXDDVyg8wMgSNu/ATm
 YaQjjHgfcJbRiBJLtrnV/a0/lbg4VkfgL1TWmXLEPlyeWLt0tNYFA3svNAKIuUnCxbK9h2F3
 Sm4XDYaoujspdcu0d/r3KqrkaagI9FcLGF7QVbJyKmQDjbL2Fajzatrcve6TRqEWEzaoKydN
 PholdfiO/g5rXN2motbEYcz65kh5tHq9oRo/i49EFrlN12UW65deF+Y1sxyt4pI9L9TmS2yf
 mmtotB6G7G4CPnJIW4rBjgOT7q8jKkPuzzo8/4KDl3w53Z38Jq5QExiBUSwpxIHHoRlErEO4
 LkHg9EX2TydmxBxE9ehjwJozUquAEEEcZ0assA9PNe2pCstkkpPcL7NOB/QuZuvUehBAmMuA
 z2ThZfBuYhi+1r/QyIzO0Tgjet5rrYSiS9O124HdgiomMKap/oZ3y9x0DUQTyZJxE55i8Z1N
 mxaNhB2F56v5BZtvtBIBEq3KjFCBTqY203/8EQIn2vnVHuVVnTBAWk+GOSV9mUL2jh4Uh1E2
 oqH2UDZUTrOV+Pg7BsYAEJKhaTqco1sy1fkhsuiIfWgI7A7RjjU2omVemsCrkrcM/Mb3UHoi
 7Fjw7dtVPfdKyUVnqwcDrua35Q2TDSvBjRLYdNlzZMzMVDsQhOA8hnQFBnpYeJIHeLAzmGgA
 c83Js5vaQW35BzTkh8lX5wzM51Gt993wuEde4HbB38M6JqeiTtLjKj+1AbDgE0TftE/tvpld
 63wcWqZH32ylElkvTbHjPN5N1qSZfgGYwzB396JztgZKqJbjsZSdRAd77jlmVSULwptwDyMt
 izheaL97rJv2KZsraTWA4RBAAS4c+3ycOGy9CGyrNV8QtfdOujetw4uiwfGPiYHGZAzSthIh
 bC2n9qv53z8vZEySHL8t6SaMqt0ufWJQ+tcN/zoIElgnSetXNHm5z0B8TuaLaNlvcx85M79Y
 SeFc+q1KMAoXulCyE1vayRxFwgXD4L1ZPzCoQK/t/G9NQgP4zfYLd+I9W7bUk8DT3UmY6bBM
 w7Tv+qiwvt6r44WXR8NOKxAMq9CeVTmXfMrSs31uTymFVKXu1KluIb5tB8e+DrOW2ilEsH73
 Mr/fSLAVi+O4YPG8NIIlLZJnEwnPC4oy614NEcQ4MV/hD2GHXYLZ7ZVe4kPDpZP1Df+ztfkb
 TXKd3EvEjj5QS8CSxjn/dD/RU2KM4Ti4DsiyuABpCt4qhtaBb9sxJNk8Tp8pWh7cH3vwYlL7
 D3YFmLYZnCMLlNBHI7/JcBXRc94y/mcyn9gFYXVjZnpGxhHaVkV/CUJIeeOPBAr1+nSmU+NK
 WVdqaWohq2kYRaZLPuMsEK51P3UUP0DAtnogeqyLA7jhrim
IronPort-HdrOrdr: A9a23:1zVdJam+Fvzb0j+6/Lo16Ixd4d3pDfL13DAbv31ZSRFFG/Fwz/
 re5cjy1XfP6Qr5K0tQ4exoWZPwPk80mqQFhLX5UY3MYOCighrPEGgA1/qd/9SDIVybygc178
 4JGMISZOEYT2IK6voSizPZLz9U+qjkzEnev5a8854Cd29XgupbnnxE406gYzdLrAUqP+tFKH
 Oz3Ls6mwad
X-Talos-CUID: 9a23:KaIvAG3r4UrPKNWb/Lj0MLxfG+c6TF7v3F7sBFKFClZwE/qYQG7P0fYx
X-Talos-MUID: =?us-ascii?q?9a23=3Aug8QlgylEonirlhIaeyxVa1becuaqKe3Uh0qnq8?=
 =?us-ascii?q?tguarcgp2GTqx1DOvBZByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,259,1751234400"; 
   d="scan'208";a="238816001"
X-MGA-submission: =?us-ascii?q?MDHLQjBY1lV2Uae1Tb0eSvp49LTYY3Cd6yD9AA?=
 =?us-ascii?q?ZkLFhLpdv3LjP+1/ATDoY9kFGSdGf6TI48MxywRU6sG9s+d3+IhIMyem?=
 =?us-ascii?q?bnNXbCtBS9nPt/GfP4I7E8+ajaReeymlc9U4aoGugAuTfib5pcM3fsk+?=
 =?us-ascii?q?DKsL4W7kySBRF3E439QtddpQ=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 15:43:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1757684608; x=1758289408; i=markus.elfring@web.de;
	bh=f8XhiKpsz03WaNyRyZCXMzKln7mWJhkpGIJviAkM4Tg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=BESnL52mxCpDwResJbaX5OVrNtSD/4VX/qZYKErVw5lD+RYji/LvmP0wpBAvxQMS
	 b2kBdwXVTV11xVv1ZWCuyKegCOjWXWij2c9OTdh6X6tXTzC+TGaWhg74+0FEbSBNn
	 mN580xbc08P79rL0tpiXR+0yEGSx5ymLTpR+Xaq9lbxW+sjXDD9jUUk1vko8Mj+zl
	 vMu77k9GL5VKwgu6zAzViQXG1K39LpOp3KSXmjUwRVLsJFFm/TeJQ71tspQFCHKso
	 ZqodI/NUbgJRxXoNQEyZ9Co3K54v1DljWP7mtEk9IVsNvCluRNScq75eumTF1YCkp
	 CfwXCpWZzuavAMkoRg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.219]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MPaMQ-1ukV1e3PX8-00LTwI; Fri, 12
 Sep 2025 15:43:28 +0200
Message-ID: <5d405955-ccd4-4f55-bdad-a15599f08d65@web.de>
Date: Fri, 12 Sep 2025 15:43:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <6c2e0db1-033f-4f66-9cf7-dc0eae4bcde7@web.de>
 <1bfe79b9-f7a4-c20-f116-75d9fe1642b2@inria.fr>
 <504107f9-09eb-47fe-96ea-53e375b17eac@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <504107f9-09eb-47fe-96ea-53e375b17eac@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:07S4pQj48yCyaZl70Xcg7bozLkV8t6vaV1m7DoAyOItT+APxOaE
 1dlMoesY2jtMcOy7pcgKhZIAsMHo9tbxXg+2m1k3sH+esr2JX1rc0jaqswY60/ArdxkNOWv
 yjjC1YjZcyLoAWd+ySxx7WtgROvx8+tIWmZ29IP6qDW+aV5qROxX7DYnLJEXLMxa/TgBJB9
 Kpk2N3BybOQggNgIAOclQ==
UI-OutboundReport: notjunk:1;M01:P0:MctMEZodcA4=;EkdlF4DeToJkhGLwPKX4PyJ81W7
 zFF1oKYXd6AIpZGj0DXcoIHFNPL/i3/QxPQoILkV9GbVX70tFptFumlYhx99vHrjqVPcCULUZ
 Hw+zvy8QUDnEE2MnAv/BlElY+zfqe9kevuRcbIkK2DvOt3za9wJXNzvnU44SPXmmsTV+lf/r6
 kyB5fHqDi9cv7ZKmRN406yx+r96wZuyY8zC/B9eZrsLOQAT80BRxv2lv3EMWqTc9r0ISn9kvc
 e/tlNAVuBjA5aHDIK005X7NKAQ9Rb+D0blGtdDPEhC2u7oDHsMoHqxWQn5f2N/4zzivzzE14p
 QJVPWFSh/wS8Fu2+e2HxoinelkGuv1DI8wuvYoSKT9ocgcMerhUT6BdywoanDw/ry7WA17hSW
 8ZhiUDjOaPdXXnBFdMlnkLXBxE5lMWhYi4SZTVXzbhMw9HL1gqUcLs4COtBFNVcxwgGDT3NuV
 Tt70QG5YSCJMVTkZryYiSiONh04NiBPu6QhkyCSdHNZUegAttc+8LxYayGEEhMdvGUHGKm6Gr
 LYK70jqA6YwYltxvEkrAaLxw3X2WfXwv2P/DTf6buvyHQVU3n6fNDok8N/u8VzIijQeluDLOf
 XNKq9Lsggw/qvWZNG/7qHoecYvTy9naPfa27wYwE6/mg9E107v1FZDAZjieT2bPF7svg19Ce/
 vIr9dBAjLNB2MHPzF/7WE1oabIU/rUIMv+4JmYcTwaEuJXC1s1AvWxziutjg1rrh3XDj7f+i5
 TVxNOrb4XjNQzAAgJMe4Bxe7v3NNMTtqV91JA3wJztW3R5xpEGJMvPz5R7RRHhsNIy363yWZr
 I+iN/IRhipu2ZAXza0r806pslxvHbRTDNOosLiUQy9z6/D7f5sS5zyaN8GvSkb2mbraBPxNKw
 nnGM2cz/FCcH+1MQdRBCesIduSwmE0sMfI4XVpgpECz5/UxL7Xc4UiML2mMTZkmjM6vgQAQhn
 GPamTS6JBakDLybDh2DU1TRTN07WHoUvQYDUZDw14eqTy+hAc00sJvba5QquAT5oFvL7VowV1
 W92orT7OvMDHTeNg+G67WR5oQoE6QnrimkgcQVMaq17pHT971qvRrV+cQitbkQwOzuAsJmOnX
 SDK/c+L9f8LeKC1MH1lYtKV5ETUp/uVtWPmyYZyJD5XPSd9M9MYK0T+CgyfUgcYSCriTX0i43
 LhY3s2xBYq6jY+vAj82dFvmw3ndDGAGbO4IsCi3o1ggcWkKPXMIRJOofLq3dRbaiQJxJxQ19o
 SwlUD1vVBw7U6p/oJxwtJNT5jXylXy0maHBdF7xSHKg6lz4zH0X0eIfXLgIlyaiozV7u4IZwq
 YJ9fJtBx0x7uJhdfIbwk4/hCO6vxFmb0ayToMJpj9i+/CI+4JtqKFIyn9lPIEzHiQVFxfIWQ6
 WG3EdZUBzTOT0vUD43RaF8xgh7fnX+tBmNYhQu55FZAfDmOqBNhk72VIsr262myyfzJcgX1kG
 kaPXubWzwtEvHWi/oqWcRU6ZIHnsrIG4B+ADOIjqoWzFa/u5n4hvaf/FaXuVkQYfkHx5N5FBc
 6eUp2gb8Gw/q5gMJS4xxAF5+fr8LwPtgip3JeAH+/SnadEkl1zn6c/O+5sAZYX730wO14u6v6
 qd2lsi/l3v4z3Az6WKqwK9k48sLKjd6g+aHwfY5rncinN/oRxdVar2v3eSQB+R62vAsfWuAMp
 SiFaR7HBTu4bgdpQnVPxn4wAQN3dNhbTxBL7pHxI39fqf+p9nItXAG0pxKSioCzmMMDW6KSXL
 TsidQMFhYlqYZnhFTFeB0vburJTJcdoIqC6CsuCbU9sYkxGZoZBJTKb/wAy0E9UjHBKr4Z921
 hBpbLBT6dkWBvG+OaquIiSaWFPpysmlsthvwTlYTFpZsF2mDmUOnPH/sfMOFUgsgL+/k6UkRE
 SwswFHPumTf7Yfn9oIZEZd5Hd0okvovjxrSXWy55fRl/ZYqy8vqNz4lcBlgQwSWMeGp3Whod8
 NE4l3WlSftLLoskthh7bJNAuVJLRfNAzBfjnSycWnHHx3pGEYTftGIhsORTr/JlSTE5NPlnmY
 8SRelubxCFtgcj+zWffeVI/qCbuvFPuxQO6xFg+XneBMW8R2ANgfZnONszVqyXSHAtSxbtxGG
 7anzdyK5Ss/EmUJpl09ABRsmj/VYStpn9+eIP45o52Im8NxKDRYk5fJ3acM04FeQ4W9WFBsNR
 ozM/amj8h3XPBT6AdlvZikWSakHOBivAw/xdFQYKc5j9+SwQ2Yb8f31KW+zsuKcALagqMzGRS
 HGcELHtkQKBDZGITMY61aMcCzCV8KebVIy9DIPXLw8+vYgXT2P462t8Jh9cx3dLk0NgMQOJ3j
 Rd2BgwnoJf4D1XWL976y+OkxCHJr9aOdQgyRurtsWBoqptvqNl7F7+cYPgVr8wMXUM2bTk1vg
 GpSafOZiJm/qpaxcaoZzNneJ+6C1+Vqo5mPOBShN0SL4P08UvZayVytd9xWQOOyUAxLPIf6ux
 fCnvCmq21rUmdqJJ9E/gGlASjoWsYA12BfZKNykVDBEZCRmp0NNjBK1aEpGEEDUIW9LzCuHaL
 7gTcuDbqbH5ty+ih723ZxzsCdZpfPhPn7S8kwMPNydpzw1UZFN47WXXAmY7VuZ+mvEppLmubt
 AkYmlKYwJYccfYW7PmM5ZIgHObHvUHzM6eAVlba+TLvU53aMtT3TE+49OEk/s1THMiv1DBMAE
 c0N6PsXfcuZbZ6nrwqclnsxiZouMz0C/C9nDcx0Ai19PeAIzVloibG8h3UwvBNCLpiXM87FLK
 IuWUafdilor8xvXH2cZaV7oxaxDCuaMPb3k045vTjoY8NLbziGcSwPl4kYZ/bVnAeCnzPnbJn
 l7wvDbdjBC8fWx/GBm5InBTwXZJVgflyHhd+Wr8rRFbAq6BeTPxBlgeRzS3apc2DmPVAtCflx
 miYeuFXB6ZArRyczsR9MmlWN7efkz10rmZPsQt07CPYeRd+RYnZOb1TvhT9GG8G2CEhRitoew
 d2RkRg8mWImZnXOwqfK/rdCfOrhgEDnn/eQbByzg5+X+ckm3zAuGRJhLLjCNqSnuuUMn+rdUl
 LB/RpqVPt/AXUM/SF/naBG0DSKhCFT47CZ4bKh3+XO37b/J/DyP81waK6gAq3faQ05Ewaz+GR
 4OEvGdSN/Bxst88w+1ikDCX0lhCP1tWbhTZNnTD154q2iDDvbnWTzrTu8u3umnCRcWxsfq153
 NJ1I6UrptNB9+gDclylmNzqqKY7xYCwSjm+PJ2x8QBMnn0Pk4hLRqAe2KynDIBDDHLcpTyn1p
 Az9IEuxMs7spmIeb5+Q51cNtgexvllI3tu9NBnrks4Wt9z+/1eDtqp9YCScBJF4qUqnZ8yV+h
 ZKWZx1SMu4fv0jcxHuj+Tgpj8/hBSfFtGdMglHCVdDxLb32WQXSCPRf/O92LcNurlKLCTDYXT
 TWPsCJahfY2eMPW4yyktL8gjmmEAhC19oRTswrje2zz136Zo54sL96QfT+acbol/7uWzL44Oe
 Omj8BgAjDQLwog/tjRuikrXKsZOgi4Jg48ggRQ3+t4Y1MaQZ3oHHwIOxNtsI1dzBW9t1BpJ1+
 QzXaHU0k4sh91G8eZkCC4NOsrIFGGQbTXyoIBoQzy4PtMaRhAx2JY0ZGrJhfMrZ0BYpDXQAUx
 HMFf84S6EP7CkyU9laapVwILB3XgfoN/ZXM8rVwnRx005JoCLNW49zVuGW2T5KxTszgf2wUA0
 r7sRZidD4FTH6a5LY6UC0yWUKai18DYfosS/kDYJ/CySJfbpNpBCRRYCVlXho5MrSQa4MOGlv
 XLNvTJ7z8sgxXRPhe9xNQgcc+MdOlXW0FRWH2XRfIQb8OuldNAe8/ctzh5Obh1rgITEFVPLxS
 NaoeIPREqq286GEf0nGGj9YAtTz8YPWe/vJKyuaCxjzKk7+AqQE9M+Bu2x70WWlpLlE7bVntZ
 zGoDl0U+2NbHVBbqNOwXAQY1vdziIy2gCgClshvNlgVESSZxjErWHzwCMVRZ84nGqvfkhL8Cn
 ygXvodomfCwihe4uASKeDgxSDTQQakSMR4bp/wI5a1+JnYQqc9HzbGx6UvXnNfFXelElQPW6s
 CPOf3gTYduwbKyL2o3pD5AC0Zklx5Ximmqdx6PajsQ5lRzTj00cq301YsL/QflSPqOZ3yCYhY
 NJj7rjJaxUkOBOD5JspzsnXUoXSMxIYai12Us0BMCgnHGmR5IzGDOEdJa9btNXHa91LDcOLSm
 dc1QLNBb1XGqeTHgSIiwScNlS7qPNC3C0Gn7e3szOEpgR0SRLgwNSjCqrOd/FrmZJXpeeV+AH
 gxMXqCVhAgSbPk2qk2l68cPcDqf5QHOq4mvsXy6idIpb2BelVMluPc+HCvpSwl3PPhe2Rbret
 LvoCcQr8gLQ7tTCad+vINxOCnvvCAzzqM32X+mNyv0zonU7jRQ4jOZTqUvHjs8+gi0RLjaETM
 qQKxeIkM8c8QlFojz6EXKtU/Olo6ffiQ46cPQefAEpqiFPL6+YDXsQvLkcjUSXJVL+s8ks29t
 CtvKkemDLSiu+hl01gnhmyFYX4FX+sKP1K3nRUg8+Kb5kNpzNK/w/oHOf7sFCoKqmuojg3jKY
 yQ3Rq9GvCDxaZem6JwXm0RiYzmZQR1Nb2bpzv8QssnYq43mPWJDfJjsNrX18/rNrWrA+GPGlb
 q0BuEVWS9eQlFufBRkZlP6n3AzdByVwausr1p8ZdXv1lH8Z+WtseM7UBQVA/hWNU4dVzl8J7d
 uwrE2wJywPaHtvybs7AsaA9NipVZVt1W6WioUNpLW1BP3ip7i+mtOavS0ytLL+gClkCAG80=
Subject: Re: [cocci] Searching for missing cleanup function calls (with
 SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3016
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-09/5d405955-ccd4-4f55-bdad-a15599f08d65%40web.de>

> But it seems that the code is still improvable.
I recognised another improvement possibility.
Thus I hope that it can be achieved also with the help of
a corresponding SmPL script.

// See also:
// fsl_rio_setup()
// https://elixir.bootlin.com/linux/v6.17-rc5/source/arch/powerpc/sysdev/f=
sl_rio.c#L439-L731
@addition@
@@
 if (rio_register_mport(port))
 {
+release_iores:
    release_resource(&port->iores);
+free_priv:
    kfree(priv);
+free_port:
    kfree(port);
    continue;
 }

@adjustment@
@@
(
 release_iores:
    release_resource(...);
|
-release_resource(&port->iores);
-kfree(priv);
-kfree(port);
-continue
+goto release_iores
 ;
|
-kfree(priv);
-kfree(port);
-continue
+goto free_priv
 ;
|
-{
-kfree(port);
-continue
+goto free_port
 ;
-}
|
-kfree(port);
-continue
+goto free_port
 ;
)


Unfortunately, the following error information is presented.

Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> /usr/bin/spat=
ch =E2=80=A6/Projekte/Coccinelle/janitor/avoid_duplicate_code_in_fsl_rio_s=
etup.cocci arch/powerpc/sysdev/fsl_rio.c
=E2=80=A6
SPECIAL NAMES: adding for_each_child_of_node as a iterator
    =20
previous modification:
MINUS
  >>> gotofree_port


According to environment 0:


current modification:
MINUS
  >>> gotofree_priv


According to environment 0:


exn while in timeout_function
adjustment: already tagged token:
C code context
File "/tmp/cocci_small_output-8646-5461f6-fsl_rio.c", line 213, column 4, =
charpos =3D 5621
  around =3D 'continue',
  whole content =3D                               continue;


I would appreciate your advice.

Regards,
Markus
