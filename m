Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B456CD111A8
	for <cocci@archiver.kernel.org>; Sun, 30 Nov 2025 08:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=zPtX0Ms3hgG6liAbfFPzy9BGlGaLmFMTj70luufNhJ4=;
  b=OgyvW8QGGexPhd8M1IOHXra9+fbbOAfWeIxKHUmxH0zYQrmuxHH84vjq
   Eg7NqaCoRrByrUcGffopZjtzbJkJzCt21IKCenwYq8rrAyl0eTxUFPX+d
   UnesyhJIOHTZKfOfv3Xmi3qLP/Tre7OTlqZJ2btVwOPNOCKj6/SvOvaCF
   M=;
X-CSE-ConnectionGUID: xrYvVexPSN67Ic3x+b/OzQ==
X-CSE-MsgGUID: 4JFCdpI0R2GiIXiq0HecSQ==
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
X-IronPort-AV: E=Sophos;i="6.20,238,1758578400"; 
   d="scan'208";a="251932355"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Nov 2025 09:06:08 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D1D79E01A8; Sun, 30 Nov 2025 09:06:08 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 4961DE01A8
	for <cocci@sympa.inria.fr>; Sun, 30 Nov 2025 09:06:05 +0100 (CET)
X-CSE-ConnectionGUID: DejorwMcSNurDeILQDhcpA==
X-CSE-MsgGUID: 8cQXHcdET4ywcm0GweKRBw==
IronPort-SDR: 692bfaed_7ZWcKVsV9EmMBLkcEXErgkYt7Ipjt2Ug2KHW2PagQyu3dXT
 WhA+8nFYJizJa6mG5rjoo7ANrsU8IE/U9vU5DtQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EOBQC4+StpgAMP49RagQmBUIIYKGUdBlgzBAtJhFWPU?=
 =?us-ascii?q?4IhA4Q7mV8UgWkCDwEDAQ09EQECBAEBAwEDOIEUQIJ0AoxlAh4HAQQxCA4BA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEBgECEAEBOwcOO4ZPDYJiA?=
 =?us-ascii?q?YETEXQBAQEBAQEBAQEBAQEBASICAQEBAQEBAQEBAQEBHQJHRAEBAQIBIx0BA?=
 =?us-ascii?q?REVEQEECwsaAhEVAgJWBhUBAYImWAGCIgEGEAEDDycHDbEAgTKBAYIMAQEG2?=
 =?us-ascii?q?l8fLCJZgWQDBoEcLoVugmUBimYnD4FVRIE8glIxPoJhAYEaRz+DHIJpgiaBD?=
 =?us-ascii?q?oYkkzNSeBwDWSwBVRMXCwcFgSBDA4ELIw88BS0dgSMhHRgTYD0XQINJHQZoD?=
 =?us-ascii?q?waBERlJAgICBQJAOoFmBhwGHBICAwECAjpVDIF3AgIEghZ+ggoPiAuBCQUug?=
 =?us-ascii?q?Q0CAQttPTcJCxsGPZUPUIM0NYIfSQ+SWpAuons0B4I4gWeBZAyKLpU+BhMvh?=
 =?us-ascii?q?ASNE4Y7DgaTBZkGjgiVJECFVYFqAzWBXDMaJIM2TwMZD44tFhyDdVHEPEI1P?=
 =?us-ascii?q?AIHAQoBAQMJhUYBAYxWgUsBAQ?=
IronPort-PHdr: A9a23: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
 klQqVsZBYEUK5G9xEFoLFV3ztyiJg==
IronPort-Data: A9a23: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
 AzwUQ==
IronPort-HdrOrdr: A9a23:8Zc/AqDjn6tQWmblHel455DYdb4zR+YMi2TDGXoBLSC9Afbo8v
 xG+85rrSMc6QxhIU3I/OrqBEDuexzhHPJOkO4s1PKZLW/bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QEZSWY+eRMbEVt7eY3CCFM5IH3MSN9ryuiNzT1nF3UGhRGtxdBktCazpyCSdNNXJ77HcCZe
 ChDkErnVCdRUg=
X-Talos-CUID: 9a23:1SD8ZG7FZK7EkemZoNss2EMWHdo6V3bm6mrKD0KZLV9FSLaNYArF
X-Talos-MUID: =?us-ascii?q?9a23=3AtUOUOg3YNXPM04V7x2JWmJwvGTUjs6+XOGAGnbg?=
 =?us-ascii?q?659ibPikoFCiQrw6dXdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,238,1758578400"; 
   d="scan'208";a="251932350"
X-URL-ContentFilter: 
X-MGA-submission: =?us-ascii?q?MDGQB0PFln4lz3Ifh15OscXCI83c1AngRei+8I?=
 =?us-ascii?q?alZ4CCraNgEn7Zfew9E8NH2er/i5FU2FQSyRfRz1OALfeBcgXJqy0TNg?=
 =?us-ascii?q?CDYVtZ50kMb5zCtit3H8bhJJXZRLOBG0BY7B+pScvIcyPVqM/T4XXG+6?=
 =?us-ascii?q?jGBABIJi+mCaT5CdrhXDNNXg=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2025 09:06:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1764489964; x=1765094764; i=markus.elfring@web.de;
	bh=zPtX0Ms3hgG6liAbfFPzy9BGlGaLmFMTj70luufNhJ4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Zg8mudehHNjqXyWUzzRCl20skX3X+qEoEC585Wg8jkhEX6XYJRHwcijKTaOlmL32
	 6eya+1NUn7z8+zwgVqIWWT6uGr5Y9OGIZnZZQdxz8b9xttjzpNHReSltJgOfJH/Ur
	 DdnkPwQLk7zvnEBIf8owSyGyGfn1MA6zr9FTI7clrZP6Hx0Yaw59KCFf21nFyc21C
	 z57dBUIxUvp2ixxqUUEcCEnyhzX8VOnl7HNIM89pMr6Z2fP0RYBRlnYO6kYHiZjBz
	 b5PGN32qGZsvAX7Y7Jr6Hd3B1KP7iKvXRLZoP/iag4SmkQhzG32Wpajd94Ayw4iAB
	 Hbb1x1FiHIf1jQPRIg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.203]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MFJjZ-1vIgYH0OO9-00EZdB; Sun, 30
 Nov 2025 09:06:04 +0100
Message-ID: <e88c503c-b2a1-454b-a4a4-ae2dedd79daf@web.de>
Date: Sun, 30 Nov 2025 09:05:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Tobias Deiminger <tobias.deiminger@posteo.de>
References: <4f6e259891de0666aa1fa10b810a5dd3@posteo.de>
 <b4884a21-4a59-c549-8466-164a20a76abe@inria.fr>
 <2897bda0c438111e967017f6bb3422f0@posteo.de>
 <caf02577-eee9-d55d-1f42-7b1f3bd2f60@inria.fr>
 <3ae5bc93f8cae1f28a068d89d3d1b070@posteo.de>
 <67f9e0f2-fa4e-c7a-d388-3732d8aec1e6@inria.fr>
 <67d1e00d2e22a4655cb10ec55d1a99db@posteo.de>
 <83c8a7aa-9b98-8ac1-d563-e8fe2588f9a@inria.fr>
 <fd7307f8024706d4bd128d0b7f43bb96@posteo.de>
 <29c204aa0f1f08074279425b7de42dd7@posteo.de>
 <825ab32a-2544-d2a8-bc48-38f26c62bc@inria.fr>
 <ded004b275d73e35c46c3d30c057d58e@posteo.de>
Content-Language: en-GB, de-DE
Cc: cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ded004b275d73e35c46c3d30c057d58e@posteo.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cOxg6ekitoUAlIXxi0m6x/Fsn1MscQbDs1LCB+OY+BWuC0o2W7V
 PoGs5Sfq+S+5P6MGFnYErX3z8e+yRMQPaxWfyULkato30Aa62udTpXpC8fGtzsCiQtPofRm
 1lrRTCvE/dQlAk2ntf7QBm7d9RVcM+pvV2+R5SmiDEHzyA9zlkw7bNIhCNCxTekdZuJM9DH
 DK+c8vwLD4PXzVQIbsYDA==
UI-OutboundReport: notjunk:1;M01:P0:pmBLHIsZI2s=;HeNQPUQiuVdFp2yv/akKdzu1XH/
 Y+cbRgeM35m79HwT9sBrKL1Hj0g8zIDChhTyKf9zP1Mu65E3qJutiWnWbixBuz8cE5R/D3+N5
 Gw0vS5vudhVR3xn6RATyBeVPQ1m1dn2piOpcXeoCBAhWXMKwxl5xD3UHcFdUqrMH/ZKJ3FIJn
 k8BeOLtnGhAQAFd6J/AlNuV94myANWvJOhSCGY/jGgKTeY/rPboGlIhFSU67McLerTeq7d3G+
 H3IZrQAkytFmJ4/Nn7zZ1YnPqb2Y0PDdwmQSSHsHsbG8ACVcO4+UkZCOKnZAtDBtrKlQTnEgq
 2hGoPO+2PIKqXmQ4u8aAnXWmLcpJhF45B++nn9gpYnxK6KEgNGAQQTLEETUUXe4iqQLMsnbfN
 nLJ1PfT0RLPQHTjwRfFEWxIHqgiw2WZqa5lS/VRIzBciY+jLkNms+2+tlgg4NimJ0A2nXvXEq
 8vOT/V7Zj88Ns04ZESpp9Hj8Mqa6h+JYIXSwNtQPgLh05xHDQHvVTTq/FCX0pUx7SJKryocNQ
 5uSJa9OzqPCzFFOku7p4jNpR/nQYOIAGK8sWOJzo5SI7kCcB2/hUhfCMphO/kllSANfwBuu8E
 eetQxbJtuZMZceH6AaYjgNNjy6FtUT0SWodi5E50cI+iY+P9WdpzWgBbCYA9D10itvuNPmZUC
 aS+4BPLOJ1AONbNQqJOPBmyK3Un3iuNHpYbpeqGuHPWFOa56YVEgwr2OC4jz3ey4+4qx5CPYq
 IY0FYzKsbQPI6OYzH5Z47D7H/dW3NMP4JjHFTOewupCMYmxP4zcN6twu1cEWDOs/bz+/80pnt
 tqS12y+zGBv3tyExQ3TvcoY2RpzAUNXj3CwgnoRctdspWCgrOWmIaQ1SEWUDmXREV0eb+JshV
 TDdNiPVPSuT48GH6AJFh5Swkzd2qikJoS1KXQGhavr6k/jz2603q5xkGiESgKkHPoowg689aW
 +zS/E1bM/nSNyXO63tU8E66q+oS0NOaJwwzPO7l8vQmv6YLkEIDyJ0ZSsOIrpnES7AOYfj+XT
 oI3V2J5KG38ACP2Ogp0S+GB9RclDsXj/3bzguTwIITLAmbz/3ELsbjXW23Db/BXLzK99ofaXJ
 lRdeuwW4pfGV4PogJ9w9aECxA0qiPqP7q9m1ZFMOU6EGX3RtT2Bbenw9/oJMeeCgIShA7VWRO
 TJ36qvrbLl2jeyAYyzW/HpzhHUGyQLv8fbfGvUm55PPrjiIcVt+ST/w2VvoBVD0FosZhPuwBz
 LJ3Di+YYTLUg3/YRc9FohURjC2PTurpFS0p0eEfgcTkLjGN8g7S5GdKrQkH1r4+xCTXPrgL52
 mnKg/7xSIYU9jVuZvA8s9kI6eHGru2W54Ys5uqP/xZ3XC93xSOtUw7sMZ65vAoGoRMutwSDpV
 Z5KTn3Rd/V1Z7xiB0ubzaxNR/nFcILnGPANE8iQixx4kT9SOy4Mm9C83/NH0CAqgn60mXwc+Y
 tIboXHGyQw3bN06C+zLRyHA98nBmc9th/k+MJACGGxXscp8qEsGmPJJ8RRXjiOVYdNUImZn90
 W+JeIxQUurDMxWVgRax3zjjdRx3+GM7/uiulDBkkLJRd1ksIKiW30BNgJWZQ41w0FKLhagzSu
 rhiAm/KJng3ERhhwV9siedhzeDNLbzdfF5+S4DnEBC+UjHMc0f1EEffnE+piWc+i2oGoGINzU
 qXyPkK3mMJKwEnLApv+Z5A4ryOqMU+rSoaVl4chSlHIKu56gLCbxaKgA8Feg2lqiXTBeUfHXo
 xoxdlZYEGXOtw/FuegZaNZjsPa4x5XiFAJcS5kfWbRQZCiN3agg7YBD63PpjktHUslNPY5NQI
 8eCp3VSbDUiy+/evuMkdVIT+OI5PRLbh4v7imdDBOnT4pHAZDrhyzK+M+m598sn0GhAOfW7x/
 ohlRg8tMLYn98IQXpfZZ2zc84yyf/RSLO0VczVrS5E041hBuFS8L+bC7xz44w3enbRvvuRizw
 58iT0fw5yi+D7E+6Qe2vSl1QJBP70kpO+0LeWz4209mHWmRGjkjCK+ov1OsaEhTaOB0yyuqLS
 9kFwTnZPIYeZnNp7mBrl0+c90fsja1umN7IGI/uD+AAs1WT411r34kirOhyI74kaVfvLlpdtB
 Edcr0C43FiW1ADrmhgtF78GsmeJ2rAAd8MyneavdoWgvdWPatwFhi+9RqSLCnMNxxfWQWtE1L
 qJi2dAV+HHKkz7KoeOyoy7KFnP2nSLTzANrHh1tv48qqiGMpHbRPtjVzbuM7VgrL8CaPsVYCM
 rjOJFxpF5n5dcq6A0CxXYe+QsHIz+Qi76EcH/5MJVHJHeNABFBa/JbZ5mKZQfAS5fW/4q0kUk
 4DfgTloQGzgR0m/2/U1LuGksIauX+9e2SPVOEJRoSN9g74zilRfZuwG41rRjNnsYFJZDeTkYh
 LNstluxItKdg3o7aAS5cvRJQito9mc2Z3fxTy8BkxqCeGXOgbcCmvC78ThEG3Ftdgqj3+C9er
 avS/atIyLCrHEY7OAo4fCDzIPuLe45L5hHfAIhwhrnmcKLU6qpfQ3rrV6qqbZTwhtEhRdeFmS
 Zgyw65zKAs88xhVlSvkhKtF8YtCXuBb92VL/r69a9qqpVnC0FEe5puuLF/HCl9lBcSCaw83lS
 M3UEp1CiBDacOOVW8A+t5i9abEZ8z7PCo6sQyIqb2dX392Ljy/Up5FAuQpiR4N360p6IeorBS
 BF6U1i7fwSARBoai1bLSCR+/jgB1haSSFFXQ+ZuVlOHNVnLicAAaPpplEVdYFa08J8OjgcDc9
 bHELWtGkhQdrgbP/xy5zWHEWeMfUV2hcwl8l/HpEanLanni0nDYXTt1S0AVkEUrdu+HrwwDxb
 UQBjZUgTkpTH+55A8ERuLMQbD1+F7Kt3pYTuRylY4gQRJ9CH0Wz9EjR9oqllKdsSHRC5LZW4B
 hwMIwmAn7x6QhnZUznQsxu3mYKsFo/lt5MDRAxjs8JzyGgQZkS9h1MC+qfnyAuxSRE26n+X40
 DqGyLAvW7yCts1wDWdCKWa/YL8kKpzGhAu/yGnpulfVC/kBcJMcjDL+RfWsLxKyG9LRiQjYoI
 JwOV7h+TPIwvzodlu38q7XuBkqCr8fXTwCMgIImc7+3iYipmdo7kf87aAp28uiFWs/lAru1Pa
 babiPYdmukV5REqr4aGX23RBCpQQNhHurSbUG8wgmvIxRDLldsSTJRtGszCukGasV+NCDSqep
 GS7pCA/0S7f82mj4PYgd4D6cGQE0A7r6bxFHaLTZJ3kCiek0s7VwCC9i90CXwoUlJphRyn8MG
 vWYT7U5avODXmufTDou3Kpce91NuNVrQtKwnMBRWQx6iYDOQjfyGr6k/Qf5Dhzbl3FehYJI+r
 zIyO8LBJyzlnqXMa66sKrSdn/xC75sFlfXXN5P0ipqRBuTWzOPy6GZ6Jbc5v7IlsTk/+/xpZT
 VdAhBryLMSBtkCD5bVl96ku/Xs7vOBwFpPNPNzBeUQRBZBuLElut4zJe9+xA8dz0UShodj43v
 Cakm5UJCm3AQdRnF2nCCdKQTZWzBhG90N3owTip8TuPuZhSNemaOfnZhEPCUVpbY6ERc2aK1P
 DsFZ2jnQ6HMnyxTqgxF5+VFcgrTDyQrOME7PvgvdAAPNhuQQgLlrfCDZEJzV0acRuaAzxyoN8
 1oOcFHkO16FX4D5I+AGDKGEFJBEoLgExZPtMAdsaba+hacZ4lyOuRT7Eep3ks63aip5O50QAU
 7N304H+1Ww4Or494UC+ZPytqt2dk/QGOty94Z/tWjSGk+URQ7KMyodw+LGuLrNxPcpL4m/sXT
 tyZcI32mXv8mDy28nCRZtm84uFOc3xsyOD3fbiVMkyCMdtlPsEuQe9PiP+XyWoBoJYMFlSfZc
 d7yPENC0aao9OMFfIs8gTNalg88+4i2KD8Va7MYV3yNjGhjSdHKSKrrqTSKexa8hUgTD6WeCe
 thpZdrMGgpFk772Zol+wu4bWSBPOYXaUPzLTsP4muyK3UsS+1wLuCtnfYUkdm5AhuHeg1LRFY
 sjKjs+ADeP7ecHOg5EHDh2FSRxlVsvIsYYaOIcGha8Uy0GpXXmzc22lbDTzjJnRpY+u6/nTFS
 jpQHpqvuikN2MwQqQjGhE8Z+RPBT9NpHlLERxP413Rk9Vo+pRWcjtbPkqvGKCxsgh1CjPUHqf
 QqRNusibPCa80SpRToDaSaEHoXcEHDSTmlNnzv6qwYZcq2Drty3hRiQ+5UZ+OK/lnjEdwE0g6
 3G3QHWq70qaFSvuOMBHPsJhc1QNW+n64Web8oQBd+2atheaCQQGtKVE3bgH5HFOywNXQM6uqn
 cL7/GceqOU7aseok7VM6y07T/Rhe9sOOeL6MDRPKIhHM7HPg+xuK95QfsVRZWIsPtSMT7k89W
 v27DQYnmxwjEm0+LXwmKnFA91urrtaS+IFFoHPNvl3eZsGfOG2Fs6cHTZrPi3wXjzKFRMFkxz
 TUJf4dAw5Y6MdiItGMln6MIPI7cdEuc6i1LDBndmu/Qflsas5h5MyMetum+taexzlExBWJ75B
 wfVDY8MOHj5C1N1SokESPTDlg76Xs384gEv29vpR/r66i8uUT+4+OYGjHGswNKmPKMxp2OzYr
 SDz++5a+q5VDiAXdoyeLLwdX8ngiolJxqHNzJXp3qMlekF0kVSnp+RHxwsZFtQ2Kzs6UCCmf/
 ADA0N9XTpNLr2XVcpIuuuLqm5SOObiTia4DMhBG+Q9/fEzcDgMkhhT32qwp1LKqkXoUNpVf8l
 hymV5QjWRGAw8N0rcOTOA9KJB/hKOSFBxWSyGCdw13nv7aI+AA5GXdcSamjjkFE3TarRqaDEW
 wwumxj9ezvjVLJgVAqvziPbqQhJFqm89CayovdE4Af2xYLU6uo0O5RoewqFcI3d92UnKv4QpF
 YTiD1TxhvX7OyVoL+UfQOrhnE6JdBRmnL8DHPqEEhg3etnTLpZjbXV9SlRkdu506Xtcd6gBg6
 CLpW9Z3hhvc2iiuowfQjfawvVxZImJbM21Yl/6k9gkN+xEoqLvkeFCfVr4lOV1/9H5VAq7d60
 0GI6T0CLKmrfsrtBE8ipX3lrLj5WNUPgtEsOlJdCiiis4F0SRaWlWzx3LCaqQi5UROKDql/Tk
 shZdQWI8uwmJ+Eea3jBdW+qPOg16Xrs04am1GYSJgN0SAMFY3323/CuXnOJZqLuDk9BTsKJiA
 DZDts8KHr9Fmtop9ndxqXX0X06DKT74FtH82zW7Nj/ena+flQA5wYi+a4nwSpobeJxQaUIc6r
 7U5IdPp4=
Subject: Re: [cocci] Can we match a known macro by macro name instead of
 expanded function name?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3223
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/e88c503c-b2a1-454b-a4a4-ae2dedd79daf%40web.de>

=E2=80=A6>> .c
>>
>> SYSCALL_DEFINE1(foo,int,x) { return 0; }
=E2=80=A6> yep, that worked.

Thanks for your indication of an usable outcome.


> What also works is to fake the return type to syscall_define_t in standa=
rd.h,

I became curious if such observations can be clarified further.


> and then do 'type t =3D~ "syscall_define_t";' in the rule.

I would like to point out that mentioned implementation details can be ref=
ined.
I suggest to reconsider the need for the specification of an SmPL constrai=
nt
as a regular expression just for the selection of a single identifier.


> But as said, I'm not in a position to make such suggestions

Please reconsider such a view once more.


> and believe I understand how it's not well suited if the engine is desig=
ned to match on the AST.

The understanding is still improvable.
Various development challenges are involved.


> *) There's an ongoing effort to add testable code expectations / require=
ments to important functions in the Linux kernel [1].

Thanks for such background information.

Linux Plumbers Conference
Adding Testable Code Specifications in the Linux Kernel
https://lpc.events/event/19/contributions/2085/


> I'm involved, and one thing that IMO would help is if we could quantify =
what "important" exactly means, i.e. how many functions are to be document=
ed (100? 10000? 1000000?), and where exactly are they.

Software documentation is also a known challenging topic.

Special constraints can become more interesting when even macro definition=
s
need to be taken better into account.


> Raw grep is obviously not well suited. Coccinelle is already used for si=
milar tasks, so it's an obvious candidate. tree-sitter queries could also =
work.

There are promising software tools available.

Regards,
Markus
