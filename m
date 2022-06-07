Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31419CCA47C
	for <cocci@archiver.kernel.org>; Tue,  7 Jun 2022 18:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=N7Iq9TM3QgzWvAOOsrP7enPE4AWH2ZL/iuBUwOTygGE=;
  b=nJMtSU0uUcTTYwte24PwXYk8gmre7Rdhe7ZZdwwTrszDiaQMDZO+1w7M
   +uezSFlNZKe+F3y8YT2kA8fP0Kqt7sLh8Nbhpbn6T7b8Zi24SY8sZ9MB8
   vdObstmBJ3ja5UxWVLeSMipZg+fide5kxBnItQMS86u3k9Ygu0esgLZJl
   E=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.91,284,1647298800"; 
   d="scan'208";a="39892226"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Jun 2022 20:33:47 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 35231E034F; Tue,  7 Jun 2022 20:33:47 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 3E9E5E007E
	for <cocci@sympa.inria.fr>; Tue,  7 Jun 2022 20:33:42 +0200 (CEST)
IronPort-SDR: zDbmFsJ2A0KwvIxSp4Bg0drxwzL3fKp1jiAOvP6kWi5ljbBXJx+47U51m64G5LmA0inZ65kWSz
 ekX+cRkUKfj7+arZvjajH4QIdcmu2F+WGS9bIAETboL2Jqny++4OZosOYZ5M4qmW8AzH44i+8V
 cSH3jeP6VZsjlAXG2WXHRF90nAD90KTHn5obe7O+wAPA34pXkkbZ9AXvVTJLp1M6rgLGoKoFOO
 k+dChJIGONG+VBnfdlFoox2Xjvu1hRI/SoTTJRTKmE2zqC91rDkrEQGURdDlo5F3W8kwJO7zl9
 6QaS7h+52u4wAk1JegXyjfYj
X-IPAS-Result: =?us-ascii?q?A0ACAQAUmZ9ih07ASNlaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?U+CJIFXLgQLRIQRPY5ogiiEIYcJhxqMHgsBAwENPwECBAEBhQIChUYCHQcBB?=
 =?us-ascii?q?DQTAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBEwEBAQwNCQUICgcOE?=
 =?us-ascii?q?AU2Bl4GZASBSwSBdAs0DYI1KQGDZAECAgEMFwQZAQERJgEECwkCGgImAgJXB?=
 =?us-ascii?q?gEMBgIBAYJ5gmUBAw0jB5BKnBJ/MoEBgggBAQaESh8sIlKBXAmBESyKS4Mhe?=
 =?us-ascii?q?icQgVVEgTwMgQmBPjA+gQ+CfDmDVoJllVCCCygEDwMaLTQSgSFxAQgGAwMHC?=
 =?us-ascii?q?gUyBgIMGBQEAhMSTQYdAhIFBwoGFg4UHBISGQwPAxIDEQEHAgsSCBUsCAMCA?=
 =?us-ascii?q?wgDAgMjCwIDFwkHCgMdCAocEhAUAgQTHgsIAxkfLAkCBA4DQwgLCgMRBAMTG?=
 =?us-ascii?q?AsWCBAEBgMJLw0oCwMFDw8BBgMGAgUFAQMgAxQDBScHAyEHCyYNDQQcBx0DA?=
 =?us-ascii?q?wUmAwICHAcCAgMCBhcGAgIZWAomDQgECAQYBB0lEAUCBzEFBC8CHgQFBhEJA?=
 =?us-ascii?q?hYCBgQFAgQEFgICEggCCCcbBxYZHRkBBTYnBgsJIRYGCh8LBgUGFgMjTCcFC?=
 =?us-ascii?q?j4PKTU2OhYcFwYiARsCmEVxAYEOw2Y0B4IUgT2BQwyeLAYTLZZRDgaRdpZpI?=
 =?us-ascii?q?KcTgXiBfjMaJIM3TgECAQINAQICAwECAQIJAQECjh0ZhAyKLT80OwIGAQoBA?=
 =?us-ascii?q?QMJhUcBAYdjgkgBAQ?=
IronPort-PHdr: A9a23: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
 Z0TVvlEWVZzGv5IUixY
IronPort-Data: A9a23:tdiEKa8+HtBBQo1n0S8SDrUD6HiTJUtcMsCJ2f8bNWPcYEJGY0x3y
 GcaWWCGPP/eNGvwKosiao+y9E1V65HSz9MxGgts+CFEQiMRo6IpJ/zJdxaqZ3v6wu7rFR88s
 Z1GMrEsCOhuExcwcz/0auCJQUFUjP3OHvymYAL9EngZqTVMEU/Nsjo+3b9g6mJUqYLhWVnV5
 4ut+5e31GKNglaYDEpEs8pvlzs05JweiBtA1rDpTa0jUPf2zhH5PbpHTU2DByOQrrp8QoZWc
 93+IISRpQs1yfuC5uSNyd4XemVSKlLb0JPnZnB+A8BOiTAazsA+PzpS2Pc0MS9qZzu1c99Z+
 fNQlpucZAoVPbDsvec/CjlxT3luBPgTkFPHCSDXXc27ykrbbz3zzv8oAExe0Y8woL8oRz4Us
 6VJcnZSPnhvhMruqF6/YsxlnMc+N4/GOI0Fu3dv5S7UB7AqTPgvRo2RtI8Jhm1p2qiiG96HW
 M88bR9JVS7AajRNeXspVrg6oO6R0yyXnzpw8Q/J+/NuvQA/1jdZ27/mO9v9Yc2PXcwTn0CCp
 2uA8X6RKhUTK9WbzRKX83emnOaJnCXhWYtUGqfQyxJxqFiU23BVFxAcE1e2yRWktqKgc+N5N
 m8T1gcjkasv1GmobIDddkHgsEfR63bwROFsO+E97QiMzI/d7ACYGnUIQ1Z9VTA2iCMlbWFzj
 A7YxLsFERQ+7OzMERpx45/O9WvaBMQDEYMVTQMpJTbpDvHmp5wvyA3CRJBvHcZZb+EZ+xmgn
 FhmTwBk393/aPLnMY3lpTgrZBry/PD0ovYdvFm/Y45cxloRiHSZT4Kp80PHyv1LMZyUSFKM1
 FBdxZXCsbxWV8vdxXDcKAnoIF1Pz6nVWNE7qQE+d6TNCxzxoRZPgKgNvGAgfx0B3jgsI2S5M
 BS7VfxtCG97ZSb2M/YuPepd+uxzg/GoFNL5W+rSY8YGa5cZSeN01HEGWKJk5Ei0yBJEufhnZ
 /+zKJ/wZV5HV/gP5GfoFo81jO5zrghjlDi7bc2qn3yPj+HEDFbLEuhtDbd7RrtkhE9yiF6Jq
 Ik32grj40k3bdASlQGNoNJMfAtUcyRibX00wuQOHtO+zsNdMDlJI5fsLXkJIuSJRoxZybXF+
 G+TQEhdxAatjHHLM1vYdX1pLr/iBM4toXU+NC0qHFCpx3l6PdfxtvhCLcNvcOl17vFnwN51U
 +IBJZeKDMNPfTKbqT4TWp/w8d55fxOxiAPSZCeoOWBtf5NpSwHT1MXjew/jqHsHAiat65khr
 rfm2g6CGcgPQAFrDcD3bvOzzgrt7CZHx78oBxPFe4ABdl/t/Y5mLz3KosU2e8xcew/ewja61
 hqNBUlKr+f6o7gzrIvDi5eCotr7COB5BEdbQzLW4LvqZynX+m2vnd1JXOqSJGmPUWTp5OO9a
 O8Tw/ylaK8Lm1NDsoxdFbd3zPtitoW1+OIAllxpTCfRclCmKrJ8OX3Yj8NBga16wOMLswWBX
 E/SqMJRPq+EOZ++HVNNdhApaP+PiaMdljXItK1nJULn+Glo8bDBXUgLZ0uAjylULb1UNoI5w
 L596ZBMtFHl0kInYoSckyRZ12WQNXheAa8pgZEtBtO5gAQczFwfM4fXDTX74c3UZthBWqXwz
 uR4WEYfa3VgKkv+n74bEH/QwaxCiJ5ItB0iIJru4biWsoKtuxP19EQ5HfcLosB90RhNle5+U
 oSuH1MgPr2Apl+Em+AaN11B2Gh96Nmx5UH7jVcE/IEco49ESUSVRFAA1S2xEIz1Po6SkvW3P
 F1V9Yo9bQvXQQ==
IronPort-HdrOrdr: A9a23:DZNdIK3GZxX8YTzw0ZkVQAqjBJYkLtp133Aq2lEZdPWaSL38qy
 ncpoV56faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SOzUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyVMbEQt6bHCWeDYrQdKZW8kZxBno3lvgxQpOxRGttdBz4SMHfnLqX8KTMtOaYE
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.91,284,1647298800"; 
   d="scan'208";a="39892214"
X-MGA-submission: =?us-ascii?q?MDHzcocWoXGql4dDWZy0nELWa3YsdoLzlhuzi2?=
 =?us-ascii?q?wUJ8PpNm7KZIl3HE2ZJ7owHNjE5+opB7HZosP2veuCSCYbPcC/JiJ6Eu?=
 =?us-ascii?q?aBzM5rYuco4ci486Z/VA1m4LUXR+u+Ruj4df/DajxAVAICMaJADh9V1h?=
 =?us-ascii?q?tyCl2NZtvhq9Gv+6YDzrSNrg=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 20:33:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1654626810;
	bh=qdgSrQEGgFCGFKObmdpFsL9/DBrk+CzEx+8NILVUOEI=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=nRd8urrrRCKgz2GZTn+cgW3QQDiEX46wNyQOSxPGV+mIDdJRHfiagIW+q09YSLHx9
	 cAEQqLPX4EYE5wMOB9DrkrkjTPPi0qjbTGAF8jZPDz2+KJJsP4NUTnWvRZOuhv7M3H
	 Pb/CvgCr0tA81QurVs0UW86NbxkcDNtAans/AAac=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.150.237]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N62uQ-1njBUA0S2C-016V8y; Tue, 07
 Jun 2022 20:33:30 +0200
Message-ID: <415ca02b-9618-b447-6471-6bcd0e2215e8@web.de>
Date: Tue, 7 Jun 2022 20:33:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-GB
To: =?UTF-8?Q?J=c3=a9r=c3=a9my_Lefaure?= <jeremy.lefaure@netatmo.com>,
 cocci@inria.fr, kernel-janitors@vger.kernel.org
Cc: Julia Lawall <Julia.Lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>
References: <AS8PR03MB760365A0DE3A8522136471BE93A59@AS8PR03MB7603.eurprd03.prod.outlook.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <AS8PR03MB760365A0DE3A8522136471BE93A59@AS8PR03MB7603.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lMBADnLZWj2zcsivtOJaoc2Mjc4xuaQmKp0/r1tgDoK118GL20r
 Y6eYiD78vnAqAnrQVZY+dnkphWI7lsGYRFLx0tU4WAyzBiHlhp8WHW2gDHoRNoOmrCofTGz
 3j4JIXHNcBmjbnLT0l+i3QRfernkmnN4P1Bdu+CgffkSIJj29ARo9RO/FJQx2m5EqBT9/SY
 kXoOVW/g8yDwYS6WzyRmA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bXfnzEPndhU=:G4t1bpaz64nHr809Jt3SR4
 Ysa4JYU5HVvkZXvB+spmIMLCrMJhYIlouexXCvJ356SJXTRIUWYDBN65oxD9yfzIb1QfDCjMt
 0C9YZDSTc53C6uP++Szoj9yeP7DRD4ajRv+Z1DdWyurossP9KGGLK7O0k71H911kMTRsaP13J
 qCSFiX3/+kDtCGMbMmOc33OcK+Ep+gNtidCLwT3S3JylZ2zQ64QxD50t2I6ZlJjuodRSc7XFn
 G+y9IdTWoBFK4impV7B+PLpigF/N2rBGORLhwD7CSLn2UrifEmf6FcRyAMNr2vaSFcWs4DTR0
 Jui31zrtCAI9xU5O907FbR+6FL/7GOB59Lln9oCibxgJmmPjJLXMmWS39sKrHkdNJx7ju+LkQ
 mODxK5tbvxJmd/bD76pi7Azz17ocgIth3YHSpVlWBHSwoev8dYFH1a0o2eo+H1EMAA5O+bWaM
 +b+B5IFgYABd14tdqdnlNcForJRoqeYk6pGDfXnKGXBIl8eD+ZMbqMO5CYOyEmkgkbl867o34
 SlnYTsvVJJe6WOZ2dBp/ZuQ8I1l3YUyfKZ0GE9/gVgzRbE1GrO5faQVuUkCekBJePpy21N2CC
 hdxghYVZhk90rDVgaoH5gnDE+AaX2GtnzN0GNBLn7Jz+U9g83Cxlqkdb65Lt7ljX706yYq7Jj
 Eyl2msHVV7QOAJW96RRJG+HcfzXvoj6XtDiNbyop39Q6Kj/dHsRlaPwYxUe561cRV+k2yusGD
 iM2Bkb/NTKcjVub7BrjDo/6fj8nxC2TaGxO0ANrtgLZ+A55SAoK8ewDMnwXLa4a0eZYdr5OjY
 Y+KlfXbYpG/CnUuhwE5C2U1SZIJyBcmh9C89SVbSpiRlE7UI+UcnuDwe1dfHU7153o+iYbAoV
 cl4eCfzQ+euC+RwYgP4zjHT+aanxCTL3ssYq2wg1rU0gxOp1v4yWou3gaEUuNPLNtX30Ii3Um
 NHhmRYp91nyQAYiiVidn+sEdwvxOhdFfRV8slH+JyT9sS7mL4gEx5Ag7QoMPLFXupbzYoIpJ4
 noMOIxIvOF2p2equvM1NVRbIHC8zcNFbLEq6dgrB3Lkdw0yHS1PCfZ5eyaVzftqnQHp11fC68
 Y5CaAL/BzfsTky+DeDf0bBBunXAnRxozRmfYzAm2P0tFuHw/vhYhPeGuw==
Subject: Re: [cocci] [PATCH v2] coccinelle: ifaddr: Find address test in
 more complex conditions
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 421
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-06/415ca02b-9618-b447-6471-6bcd0e2215e8%40web.de>


> The test of an expression's address does not necessarily represent the
> whole condition, it may only be a part of it.
> This change aims at detecting an address test in more complex conditions=
.
>
> Signed-off-by: J=C3=A9r=C3=A9my Lefaure <jeremy.lefaure@netatmo.com>
> ---
> v1 -> v2: Moved disjunction on the condition itself instead of being on =
the if statements
>
>  scripts/coccinelle/misc/ifaddr.cocci | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/coccinelle/misc/ifaddr.cocci b/scripts/coccinelle/m=
isc/ifaddr.cocci
> index fc92e8fcbfcb..14dbf3131a3f 100644
> --- a/scripts/coccinelle/misc/ifaddr.cocci
> +++ b/scripts/coccinelle/misc/ifaddr.cocci
> @@ -18,7 +18,7 @@ statement S1,S2;
>  position p;
>  @@
>
> -*if@p (&x)
> +*if@p ( \(&x || ... \| &x && ... \) )
>   S1 else S2
>
>  @script:python depends on org@


Would you ever dare to adjust the specification another bit for such
a source code search approach according to the difference in the selection
of the operators =E2=80=9C||=E2=80=9D (disjunction) and =E2=80=9C&&=E2=80=
=9D (conjunction)?

Regards,
Markus

