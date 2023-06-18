Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 166D3EB64D7
	for <cocci@archiver.kernel.org>; Sun, 18 Jun 2023 05:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=k6DsaBsm4WHhnda9qsjV1Z8urnnTChPbZx40Zyin4zg=;
  b=s97sDUqXITARmKTS3KWBwP6oeGfkWI/wtKu+Ir7liPzOWU6REEa1G9Dm
   vPhALlLPrWICkH8fqAWNFDXakQpQMFhx91x26Fm102RPxbFY8o+bwQf4U
   ygJIX6o1IVoB+Obc+l18BO8Atdq5fLSfkBweL7Rzjaj1amP06B/eO/NrF
   c=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
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
X-IronPort-AV: E=Sophos;i="6.00,251,1681164000"; 
   d="scan'208";a="113391971"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Jun 2023 07:47:51 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B4AE4E03AB; Sun, 18 Jun 2023 07:47:50 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 4F774E0157
	for <cocci@sympa.inria.fr>; Sun, 18 Jun 2023 07:47:47 +0200 (CEST)
IronPort-SDR: 648e9a82_qgEPntNQXDOoNIRq6XNla3JEwrWbJoBC3fViR+TH3pGiDJR
 Nt/Hu4nzg5kcR5XovRNLQeYGQg4ZWPaUNLAuhAQ==
X-IPAS-Result: =?us-ascii?q?A0HaBQBCmo5khw4P49RaHgEBCxIMQIFEC4IvdQNTMAQLR?=
 =?us-ascii?q?wOET48tgXYxhDaOd4hsgVaBQD4PAQMBDT0EAQIEAQEDBIFMgm1GAoV+Ah0HA?=
 =?us-ascii?q?QQwCQ4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBQECEAEBASMXBw4QJ?=
 =?us-ascii?q?4VoDYI3KQERZIEIAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQESAg06PwECAgEjH?=
 =?us-ascii?q?QEBESYBBAsLGgImAgJXBgEMCAEBgnoBgicBAw4jBw2vOoEygQGCCAEBBpwOH?=
 =?us-ascii?q?ywiVYFfAwaBFS2NL4M3eicPgVVEgTwMgng+gksXBBiBRoNbgmeLMA4MgmeDN?=
 =?us-ascii?q?IIxB4s7gShvgR6BIn8CCQIRZ4EICF+BcUACDVULCzsogRxSPB6BKAICESkTF?=
 =?us-ascii?q?AVNeR0DBwOBBRAvBwQyCRYJBgkYGBclBlEHLSQJExVBBINYCoENPxUOEYJaJ?=
 =?us-ascii?q?AIHNj8bUYF4JQQOAxkrHUACAQtwPTUGAwsfBiYBHgIpgVcwWHQkJKAcA4ROg?=
 =?us-ascii?q?U3FBDUHgjCBW4FdDIoTlQkGEy+DbgGTJg4Gki+SVIVFII07ml2BYzqBXDMaJ?=
 =?us-ascii?q?IM2TwMZD44gGYQOhGGKKD8/NAIBAQssAgcBCgEBAwmFRgEBgQWEewEB?=
IronPort-PHdr: A9a23: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
 A==
IronPort-Data: A9a23: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
 T3Tx5EoAiWM/w==
IronPort-HdrOrdr: A9a23:e7eOvaCIvDUY+HPlHel455DYdb4zR+YMi2TDGXoBKiC9Afbo8/
 xG+85rrSMc6QxhIU3I/OrqBEDuexzhHPJOkO4s1PKZLW/bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QEZSWY+eAaGSS4/yb3CCFM5IH3MSN9ryuiNzT1nF3UGhRGtxdBktCazpyCSdNNXJ77HcCZe
 ChDkErnVCdRUg=
X-Talos-CUID: 9a23:sl54rG09CRv+n5nIufj8RrxfHeoVUULs7lDrBGiAGXxraOGqGEGWwfYx
X-Talos-MUID: 9a23:R/87EgjKe2ywWLT+QRxs7cMpCd4y07+fFG00o5w9iY69KjxwKXSmtWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.00,251,1681164000"; 
   d="scan'208";a="113391967"
X-MGA-submission: =?us-ascii?q?MDGrflSXY+upmkrr3JZlMkTtvRwvumeNj3LnTy?=
 =?us-ascii?q?PQBsIA3n4t5c5k9k+MyhLh8OdvwEvCOQT2f7/SsTMoJXpRsytskFBhV2?=
 =?us-ascii?q?S/0s1+/zch9O3lR+rKc6wWaOzoLaOm/XMcyQt8kUKBT6ejbAybnr1AeT?=
 =?us-ascii?q?Nnu8htD4dcf0VqWbbzhsLxyg=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2023 07:47:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1687067265; x=1687672065; i=markus.elfring@web.de;
 bh=k6DsaBsm4WHhnda9qsjV1Z8urnnTChPbZx40Zyin4zg=;
 h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:In-Reply-To;
 b=Bcv44wpv+ZSBXxuVTYzEAY6GkYgnMqxlvahkoG3kJ9vDLOMlnS4LRBItsbx24CAIFRCebmI
 fbfbYOu1c/MK9syErJ1il9brYhQtQGRBoauOjHEcRuxOxjYX851dv5CUBKRwXzL1ObYselhEP
 BJWSuZs/QdddmeSgoJl4EqWJqKOapCgvOsgobqDkruYWQvrxVbkgCQAs895M8WAjc8uWT2OrV
 1ZntTq/QFUCTzf8Q4YX0VLXolghpLFJisdE3lrCDQOK/Fu1NxKTHRwafC5iLny4341TaeSEwm
 Nk8gg27L4cPNvJHdY/tEfgwwRmgYnFbASpkKGRxagFFcnSpM8+SA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MqqPN-1pouzA2nOj-00mUAv; Sun, 18
 Jun 2023 07:47:45 +0200
Message-ID: <78cc123f-3899-5102-09bf-b00d95311475@web.de>
Date: Sun, 18 Jun 2023 07:47:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio
 <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <20230617204118.61959-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20230617204118.61959-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:H8BDX8NVqjEoaCNEw9j1izDudmQjh/Nsy2icWuLwKstqDO0xIcs
 oMs9Cv+jXnPIt8b99xz3QhoAvzkVwJLagb6lauhK4jey5fov3QJVW+u6pq9OmIcIGNhTstM
 97IdrxanjG7rN8i/v57S+hrK6HUyym4KmikGwUPOU8i3p9fdW7lxhCCCUZyjaX2qmJRxZ1T
 1CsQLcyFYNVKQw4YWGNJw==
UI-OutboundReport: notjunk:1;M01:P0:rs1uSPQg09I=;de87RjEBTJWZWV3+PANp3uObjTf
 jAbHJOvSAs0Urp4r/LjPtW/boitJ1XXtaamq8hy5PfWgWDFrXsokv1oSZ/rIF8H0tAf2LBRm+
 TGPz4o4WFX73TTH/ziXz4rwhvNEfSn/ney2w0QZZwsoCCQiB3/Lbc1b+5cT9AXUsbcJVXwbrE
 54XWUR6fzLZcCStxVaW2E/kv7iBCc5tdmqKbSzZDu7iRxdfE9E3FejlU3V+Tj0gVKkMEQIl3D
 PyPlJ9MxafCp9r2YN3ikem5dDVTrHY3vffOQKFznZ8EdWTSkPBNot/u5TOp8tD4GaHBKjWCrg
 eeUKxYjiu8TxXHKJgmbZ8ZoHlzWXCbFYne3Bzx1MwILsaefZn4JkqGkKhM/Fm/PkUsM/WdVw5
 OT3JXWnx1ce4FIfkT/FxnT34+l5dXO1FWIIju4Gn5u9+P/Zit0QHXky3LFlu63VyFqu/8jrL5
 Ra5cgbJ8rcBinWkUlKVfyhSd4hO8uCeP30CzCVjg3pcgsDEO2s6kNiMbasHQSehMUWK+h4C7x
 fn5hC3dir0TV3yhYGg6alHQPOL3jplknSaOvrVPU7uNKnHQxbAhVHqa/5Pw2fDUHSvaQN8bMr
 ymEZW8808SRzqDQh6Ccxr8VDE9pHH6jRU/qUDDt8YdBks30VT3TAMAC9lmYGOrv+6gd3GgNQS
 AxTJWxW22qDiy6aGbOlNFXAHWt5/dy6nhyH7uBRPLOdlEsl171C2j87p5Fo8dAEVrcYRpWtWS
 nQ3FcQChtWskWF3ruf272aYWF5e/BHbledp9QjgECon0/sfmkBZcz96oDekMEnLlUdsv5qHx5
 Yhe+sXwU6/qGAk1v8cxtB/lS9ug1cRYkvSrEMAS6aZm2X2HMuEt9OMa0sUJoo50xchvZnwDoD
 4KnCR2cPRy9S4zW4M+Ae4qh676pfW8FLf4rxgAyvqPPspAHO4caw+OaAmrHvuqj6e5JB6+RPm
 1rObZg==
Subject: Re: [cocci] [PATCH 1/3] arm64: dts: qcom: sm8150: Fix OSM L3
 interconnect cells
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1190
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-06/78cc123f-3899-5102-09bf-b00d95311475%40web.de>

> Qualcomm Operating State Manager (OSM) L3 Interconnect does not take
> path (third) argument. =E2=80=A6

Can such a small patch series become a bit nicer also with a corresponding=
 cover letter?

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.4-rc6#n312

Regards,
Markus
