Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC6ECCFA13
	for <cocci@archiver.kernel.org>; Sun,  9 Nov 2025 12:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=z7rOsXfmOuRfMZPjdeJ6rBxMLwAJDdNFy9N0NnPeymc=;
  b=EZJKnbylGOFHcmAYdgZbo5Ak/GRT1lmuDinKU5Zx/LaxPIkp4G5ZjxF0
   j2BNjdkf+OkIuK6NUkehXMlmcrRKkepJLatXTaJTnqQhp32EGSLKx4Shl
   F+J6Mp0wIL5paYLX/ElFSTDw8jk0Tzv7B/HTntoJcsTGJsGO79VARK2Kp
   k=;
X-CSE-ConnectionGUID: 9V9l8z5nRTaQG7tibJpCSA==
X-CSE-MsgGUID: eC8gwljSShKH7rDWeKAvJA==
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
X-IronPort-AV: E=Sophos;i="6.19,291,1754949600"; 
   d="scan'208";a="248359866"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Nov 2025 13:52:06 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id EB721E0B0D; Sun,  9 Nov 2025 13:52:05 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 90B3FE0171
	for <cocci@sympa.inria.fr>; Sun,  9 Nov 2025 13:52:01 +0100 (CET)
X-CSE-ConnectionGUID: 7hsfnsZ2T7i5s5bWj8LK+g==
X-CSE-MsgGUID: QXnI9qZPTZqR+Z+wz+ifug==
IronPort-SDR: 69108e71_Sz3wKvuq5zSNIB5BZED46vu0PwAyLeJj2acTkr/h68IP1nE
 g2JKyuito5YN0g5xgFk97uUQvEuWw9FKyxelt6A==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FZAABZjRBpg07ASNlaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T4FAQELAYI/ZR0GWDMEC0kIhE2PU4IkhDuPEYpOgX0CDwEDAQ1KBAECBAEBA?=
 =?us-ascii?q?wMBOIRIAoxaAh4HAQQyBw4BAgQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBA?=
 =?us-ascii?q?QIEBgECEAEBASEZBw47hk8NgmIBgSSBJgEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAg06RAEBAQIBIx0BAREmAQ8LGgImAgJWB?=
 =?us-ascii?q?hMCAQGCfgGCIgEGEAEDDycHDQauTYEygQGCDAEBBoFGAhBB2EYfLCJZgWQDB?=
 =?us-ascii?q?oEcLgGFbYJlAYlseicPgVVEgTyCUjE+gmEBA4Feg1uCRyKCJoEOhieCU5BOU?=
 =?us-ascii?q?ngcA1ksAVUTFwsHBYEgQwOBCyNLBS0dgSQiHxgRYD0XQINJHAZoDwaBEhlJA?=
 =?us-ascii?q?gICBQJAOoFoBhwGHBICAwECAjpXDYF3AgIEghl+gUpAD4lwQAIBC209NwkLG?=
 =?us-ascii?q?wY9lHuDXS0BK4FRpC6iezQHgjiBZ4FkDIoulT4GEy+XUg4GkwWZBowOgXqbO?=
 =?us-ascii?q?YFvByyBXDMaJIM2EzwDGQ+OIQwNCYQRgQuDVbdeQjUCAQEBBjECBwEKAQEDC?=
 =?us-ascii?q?YVGAQGMVoFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:fUEEcKIYbD2k8rmIFE+Ri5ElxSXFcZb7ZxGr2PjKsXjdYENShDxTx
 jYfXWyEafaCZzH0eIpzPNy28BtTvZPdy9A2Twcd+CA2RRqmi+KVXIXDdh+Y0wC6d5CYEho/t
 63yTvGacajYm1eF/k/F3oDJ9CQ6iOfRAOKhVYYoAwgpLSd8UiAtlBl/rOAwh49skLCRDhiE0
 T/Ii5S31GSNhXgtYwr414rZ8Eky5a2q6WtB1rADTakjUGH2xyF94K03fvnZw0vQGuF8AuO8T
 uDf+7C1lkux1wstEN6sjoHgeUQMRLPIVSDW4paBc/XKbrBq/0Te445jXBYuQR8/Zwahw7id/
 O5wWamYEm/FCEFjdNM1CHG0GwkmVUFPFSSuzXKX6aR/xGWeG5fgLmkH4Ojb8uT0984uaVyi+
 8D0JxhSbguNgfmEmo7kS7R3284cLpnPH8AQ7yQIITHxVZ7KQLjGRLjWo8BV1nE8i6iiH96EP
 pVfNmApNUWaJUIfUrsUIMpWcOOAo3DlcCBD7n+Rq7A25Wf70wF7lrTgWDbQUobWFZ4IzxbF9
 goq+UzAMhc7ZcWt8Qa360jvtKzQj2D6Vp8dQejQGvlC2wHDnjdDV3X6T2CTpfCmg0q6c8BeL
 kYO82wvq7Iz/QqlVLHVVBqzq3+spQ8ZQ9MWEusg6QjLxLC83uqCLm0DUyIHd9Es8sM7LdA36
 rOXt4zpHjJpq4/PdS2cq6zJpwywaQw2bmBXMEfoUjA5D8/fTJYboj+nczqOOKuyk8GzBjz6h
 TyHxMTfu1nxpZ9Uv0lY1Qqf695JmnQvZlNkjukwdj/1hj6VnKb/O+SVBaHztJ6s1rp1sWVtT
 FBfx5jGt7BRZX18vC2KRuIWVKqkj8u43MnnqQc3RfEJrmzzk1b6JNw4yG8lfy9BbJ1bEQIFl
 WeI4Gu9ErcIZSPyNceaouuZV6wX8EQXPY2/Dq+JP4QWP8IZmc3u1HgGWHN8FlvFyCAE+ZzT8
 7/CGSp1JSdEV/ZU33CtSv0D0LQm4Ck7yCmBDdr41hmrm/7WLnKcVb5PYhPEY/Eb/ZG0hlzf0
 +9eEM+WlDRZcun1ORfM/aApcFslEHkcBLLNkfJxSNKtGARdNV8EN+7w2pIkIoxsoLRUnLzH/
 1a7QU5p92D8jnzmdySPM25vWIryUcxBrFY+BygNPEmp6Vcnc42A/KcSTLppXLgFpchI7+94c
 OkBQOqEWs9wczXg/y8PSLXMt6lwXU2PqSPXGAT9exk5XZprZzKRy+/eZgG1qRU/VHumh/Uxs
 5iL9139Q6NaYy9AEcyPSvak723pjEgngOgoAnf5eIhCSn7NrrpvBTf61MIsAsc2Lh7G+DuW+
 iCWDTocpsjPu4UFy8bIt4/Vs7aWF/ZCIWQCE1n59bqWMQzozliny6JEU8eKemn5f0Hw86OAe
 +5U7q/dNNsqoVV0iLd/Qo1blf8G29jSprFh3ltFGlfPZA+VEb9OGCSN8vROkaxv/YVnnzWKd
 HiBwOQHBoXRCvjZSAYQACEHctW80eoln2iOzPYtf2T/yixF3JuGdkRwZCuzqTFvA4Z0FKgHw
 u4RntEcxCLiqxgtM/eA1jt18UbVJFM+cqwXjLMoK661tRgO1Xd5fo36Ni/6xLqteud8GBAmD
 RHMjZWTmokG4FTJdkQCMETk3M1ftMwogw9LxlpTHGa5sIPJqdFv1SIA7AltaBpeyyhG9OdBO
 mJLEUlRDofW9hdKgPlzZUydKztjNja4pHOok0AokVfHRXaGTmbOdW0xGdic9XAjrl5zQGJpw
 6G6+k3EDxDRY8DD7gkjUxVEqtvib+BL2C/spcSFJ/mBTr4GOWfLo6n2fmcZiQrVMeVojm39m
 ORa1uJRa6r6CC0un5MGG7SqjbQ9dRTVC1FBENdA/bwIF17yYDud+yaDAGHvd9JvJ87ly16ZC
 ctvKphxVjC77iKvry8aN4EIMbRbjP4k3/tcW7LJdEotkaqTkSpti73UrhPBvW4MR858tOoAM
 abTSm6yKXORjn5qhGP9lslIFW6ma90iZgen/uSK3MgWNpAE6sdATFoT1+aqgnCrLwdXxRKYk
 wfdbavwzeY564BNnZPpI5pTFTePNtL/e+SZwj+d6+0UQ4v0Dv7PkAcJpn3MHQdcZ+IRUusqs
 4W9iof82UedsYsmV2zcpYK6KJBIwsePR8tSDNP8KShLvCmFWfK02SA5xUKDFcVrnu9et+6df
 CnpWPvoIJRRE51YyWZOYidTLwcFBu6lJu38rCe6tLKXBgJbzQXDK8i9+GT0aX1AMBUFIID6F
 hS+rsPGCgq0d2iQLERs6zBa755EzJvLXKw7a5vuuDPeAmTAbpZufFf9vUJI1N0JIiDs/AXGD
 VbtWRX0Mhi/0E0N5M8MqJR853X7E14k6dTdvSshFxpelD2wSmILRQjY3VPqFbkM+hHPOFrEi
 P0hoYfs5egRndiJTPkk3OneYw==
IronPort-HdrOrdr: A9a23:UPPce6HoHkr7UQ7EpLqEPMeALOsnbusQ8zAXPo5KOH5om7+j5q
 STdZMgpGfJYVcqKQgdcLW7U5VoLkmyyXcY2/h3AV7mZniBhILKFu9fBOnZrwEIcheWnoNgPO
 VbAs1D4bbLbWSS4/yKgzWQL/Zl5sWb+6a1gurkw25qVhwCUdAc0+40MGem+lYdfng8OXPVLu
 vn2iLNygDLRUgq
X-Talos-CUID: 9a23:LNUzX2AJgsXUVSD6E3Zn70ASAfJ/TiLckWyNKXC6WUJKC7LAHA==
X-Talos-MUID: 9a23:s4jI8wtsDNZfuXThoM2nvQFkFZZx0ZySOlk30qdFpNvHNCJtNGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,291,1754949600"; 
   d="scan'208";a="248359858"
X-MGA-submission: =?us-ascii?q?MDEwv1OxEuvICtovAhdFJCfOpXnH2QtVnEaF/7?=
 =?us-ascii?q?REo27Lenhgy9CXypsb3cZxenfwqMKMBLxbcw6ywy1jwztYDHKuzywSnm?=
 =?us-ascii?q?ixN0YHx1PJXKCpy2zCc2WE1CS90pHiFBk38QJaImvt7sIARqRaSTJL7t?=
 =?us-ascii?q?AMC6uaitapsJsK6i1R1tzmqw=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 13:52:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1762692720; x=1763297520; i=markus.elfring@web.de;
	bh=z7rOsXfmOuRfMZPjdeJ6rBxMLwAJDdNFy9N0NnPeymc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=mHCTYdePp5kMDRWNTvH/0OSeAnzqCuuD9jOpF4HgkubPlyeT1RzuFRjxr0Ojbvpn
	 GP+OJBaGOLhXrcgCyVPNTd95Vz4z52VAoyyTu9uXQr+IYfYAlM4XzHEnNeo9UWETU
	 P0KteB6owcsBE3inw/4bTXkSB/AXGir6dIVJQn6cqkmkSe2a2WvjlOYmpvxPl/9H2
	 nNWoso2kYBrf/bIguYRlt3RmeFJXiNWJOQBQZGUqpwN6OlLmaw9jps3CALKqXVk/0
	 UoREmn2B6fQRBjR0+YFPrMPioOSr2RtnZfhRRw4ZSg5ZDc2GLFjnjAZ+oN73xr9pI
	 xEq3TVv1/mRidBJEeA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.232]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MZB07-1veTM91FTt-00XidT; Sun, 09
 Nov 2025 13:52:00 +0100
Message-ID: <e27551b2-34e9-40ad-9a14-f7b5cdf9a02c@web.de>
Date: Sun, 9 Nov 2025 13:51:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <f32da236-a8bf-4ff9-a18f-f8536ac5d5a3@web.de>
 <1ccd768a-a1c8-2858-e084-b42f764cd6f@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <1ccd768a-a1c8-2858-e084-b42f764cd6f@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AkwzzFQT9ktj+SINKF2OWmpnmGAJpSAUae6XSPtM6P1dbuwfvS9
 K25vMN36OnDzy9BwVuCLL41gJq2BDwZkl39RyEEHNEm8M5yElY0D3I7yqoF6KaTYEeT7kAW
 cfpj1Ghz3wi1miTjM6r265JgX4qxRq1i5B3Yr5dz0Es9FhFAPEc70OJ5t0nWEhMipxHKTg9
 bImNwzaMPOcPBvhNns4+A==
UI-OutboundReport: notjunk:1;M01:P0:RGo09XQKm7Y=;bXkSDseHZ4Gbw7gYxgbt+EXkY4z
 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
 S0KFbQxQLQERCcmM8=
Subject: Re: [cocci] Restricting information search for header files
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3152
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/e27551b2-34e9-40ad-9a14-f7b5cdf9a02c%40web.de>

>> Some information was provided for the clarification approach =E2=80=9CS=
ource code
>> analysis for header files=E2=80=9D.
>> https://lore.kernel.org/cocci/alpine.DEB.2.10.1501071549410.3328@hadrie=
n/
>>
>> Did interests evolve any further also for such a development topic?
> You can also use script code to exit if the file name is not suitable.

Would this programming interface mean that the parameter =E2=80=9C--includ=
e-headers=E2=80=9D
should be passed to the program =E2=80=9Cspatch=E2=80=9D before?
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/e6f8731b851f5d76d2731=
a9d546dc4f0b181526e/docs/Coccilib.3cocci#L253-259
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/e6f8731b851f5d76d2731=
a9d546dc4f0b181526e/docs/manual/cocci-python.txt#L39-40

Will related system configuration options become more interesting?

Regards,
Markus
