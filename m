Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 717F3C25B47
	for <cocci@archiver.kernel.org>; Fri, 27 Oct 2023 10:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=35lF/tc/JtUpyFG8FgIAuU+ymxn2ZpeseIWKelXbwBY=;
  b=ZUniMOXMKATVHb+81T2CRxqpEsiBW1a4p6KKRZVmXYJd7R+3cPX+AJGi
   Xoj6+qXhgHZcqKTr3nUsFI7zu/HdEwfrh/cLM/PCuTthWDd3hraiMS2zj
   r94h7SsRj63KNZQvwX98xdLUgSzd79qYgIas8vXgC/78xbR2D1cpS4OPL
   Y=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.03,255,1694728800"; 
   d="scan'208";a="133542669"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Oct 2023 12:02:30 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 777C2E0205; Fri, 27 Oct 2023 12:02:30 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 22CC4E00BA
	for <cocci@sympa.inria.fr>; Fri, 27 Oct 2023 12:02:18 +0200 (CEST)
IronPort-SDR: 653b8aa9_ySN9HCWP9VIsHZP7h42NV34rbEPPxx/l6fs55ECHipENVsL
 3aGIjYT6UJuJ2/3e9uy2RrtGbL+eQbczUMWNjSw==
X-IPAS-Result: =?us-ascii?q?A0EtBAAZijtlhgsR49RaHgEBCxIMQIFEC4I5gVAwBAtIh?=
 =?us-ascii?q?FOPPIF1MIQ7hzSHSYhvgxY+DwEDAQ1BAQIEAQEDBIILgnQChxoCHgcBBDMGD?=
 =?us-ascii?q?gECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQFAQIQAQEBIRUEBw4QJ4VoD?=
 =?us-ascii?q?YI3KwERgQyBHgEBAQEBAQEBAQEBAQEBAQEBARcCR0IBAgIBIx0BAREnBAsLG?=
 =?us-ascii?q?gImAgJXBgEUAQGCeoIqAQMOIwerXoEygQGCCQEBBq9UHywiVYFfCYEaLogKA?=
 =?us-ascii?q?YVRhDUnD4FVRIE8gwM+iB6CaIN3mB9eJAVCcBsDBwOBAxArBwQwGwcGCRYYF?=
 =?us-ascii?q?SUGUQQtJAkTEj4EgWeBUQqBBj8PDhGCQys2NhlLglsJFQw1TXYQKgQUF4ESB?=
 =?us-ascii?q?GofFR43ERIXDQMIdh0CESM8AwUDBDQKFQ0LIQVXA0cGSgsDAhoFAwMEgTYFD?=
 =?us-ascii?q?R4CEBoGDScDAxlNAhAUAzsDAwYDCzEDMFdHDFkDbx82CTwPDB8CGx4NKywCI?=
 =?us-ascii?q?QQOAxkrHUACAQttPTUJCxsGPgInnl+GLjIGo2ugezQHgjGBXoFfDJ8jBhMvg?=
 =?us-ascii?q?26TLw4GkkkemCAgqDGBeSSBXDMaJIM2TwMZD44gGYQSj0g/NTsCBwsBAQMJh?=
 =?us-ascii?q?UYBAYNagikBAQ?=
IronPort-PHdr: A9a23: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
 chWIoI=
IronPort-Data: A9a23:g9QlAaLpZpXyxdMNFE+RWJElxSXFcZb7ZxGr2PjKsXjdYENS0zEFy
 TMXUWmDb/aCYjGkKNpzPIqw9RwGvpfVy4dgHFYd+CA2RRqmi+KVXIXDdh+Y0wC6d5CYEho/t
 63yTvGacajYm1eF/k/F3oDJ9CU6j+fSLlbFILasEjhrQgN5QzsWhxtmmuoo6qZlmtHR7zml4
 LsemOWBfgf+s9JIGjhMsfna8Ekx5K+aVA4w5zTSW9gb5DcyqFFOVPrzFYnpR1PkT49dGPKNR
 uqr5NlVKUuEl/uFIorNfofTKiXmcJaKVeS9oiY+t5yZv/R3jndaPpDXmxYrQRw/Zz2hx7idw
 TjW3HC6YV9B0qbkwIzxX/TEes3X0GIvFLLveBCCXcKvI0LucGn94v5VIlEMOIgB+PddKDEVy
 9g8N2VYBvyDr7reLLOTT+5xmoI8IcOtMI53VnNIl2iDS6x8HtaaHOOTvLe03x9o7ixKNdPXf
 ckEcnxCaBraYhtAEkgaAtQykY9Eg1GhImwD9QLP9MLb5UD6lixd077ybuH2Uc6jRZRMz0Snq
 k3JqjGR7hYybYHDl2PcrBpAnNTnliTwU4M6D6y97vcsgVuJx2VVBgd+fV+yvvC9jmasWtdVM
 UVS+yw0rKF0+lbDczXmdxi/vWLCoRMWHdZdewEn1O2T4qnG8ieSPUYUdDtEcd43nuZmHgIO8
 kDcyrsFGgdTmLGSTHuc8JKdojWzJTUZIAc+icksE1ttDz7L/tBbs/7fcjpwOPLk1oalQ1kc1
 xja93hg3t3/mOZRj/3TwLzRv967jrTkJuLfzibeRGa+9B55aeZJjKT3twGHvJ6swK6zR1WMu
 j07htKC8O0LB5yXm0SwrAglGba0+7CaPTeajVMH83gdG9aFqy/LkWN4uW8WyKJV3iAsJGGBj
 Kj75Fw52XOrFCH2BZKbmqroYyjQ8YDuFM7+StffZcdUb556eWevpX8/NRXMgji2zRN8zMnT3
 Kt3l+7zXR727ow4nFKLqxs1iuFDKt0WmD2JG8Ckp/hZ+eDFPiLMIVv6DLd+RrlksP3d+Vu9H
 yd3boXTgxRZTODkZCTLuYccRW3m3lBrba0aX/d/L7bZSiI/QD9JI6aIndsJJdQ494wLzLug1
 i/mASdwlgGg7UAr3C3RNhiPnpu0BsovxZ/6VARwVWuVN48LONb+vfpFLMpmJNHKNoVLlJZJc
 hXMQO3Yatwnd9gN0211gUDV/dI8Jie4zxmDJTSkazUZdpttDV6BsNz9cwelsGFEAiOrvIFs6
 /etxyHKc6olHg5CNcfxbO7w7lWTuXNGpvl+cXGVKfZueWLt0rNQFQrPstENLfsxdCrzngmh6
 17OADMzh/X8nIsuwdyY2YGGt9iIFsV9LGp7Hk7az+2ECgjHzEWewKtrcuWBTRbCXkzapYSgY
 uR0yannEfslxVxljat1I4xJ/4kfueT9gqB89Rt1OknLY3CAKKJSElPf0eZh7qRyl6Jk4y2oU
 Uexy/xmELSuOvK9NmUOJQAgP9+x5dtNlhb8tf0KcVjHvglp97+6UGJXDRmGqApZCJBXaIoF4
 +MQiPQ62jyFqCgBE4i513hP1mG2MHY/fb0ttcgaDK/VmwMb8Ax+TqKGOBDmwqOkSotqCVYrE
 A+2laCZprV7x2j+SVQRO0XJ/9JggcUphEgX4n4Ef0+Ei/jUtM8RhRdxywk6fi5R7xdA0t9wB
 FRVCl1IFf2O0QtF1MlndEKwKj5FHyycqxDQyUNWtWj3THuId23qLU8hM72zpGQf/2Ztf2VYz
 oq500fgay7hJ+vq7xsxWGlkiv3tdsNw/Qv8g/KaH9yJMp05QDj9iIq8TDAshz74J/gulWv7p
 eVO18RhW53RbCI/jfUyNNiH6O42VhuBGl1nfdhg26E4RUfnZzC43Gm1GXCbI89iCaTDzh6lN
 pZIOMlKahWZ0RSOpBA9AYonAed9vNwt1eo4VoLbH0w0mJrBkWMxq7PVzDb0u0EzSdY3kcodF
 JLYRwjfLkOu30lri03/h+gaHFGnYOs0Rhz2h8G01+QrK6gtks9RdWMK77/lmEnNbSVG+UqPs
 RLhdp3m6bVo6b5RkrvGFoRBAASJKu3PatmYzTDrs/lzaYLgDMSfkSIUtVjtACpON5QzRdlct
 OqAofz37mz/rZc0VGHVwaeAM6xz4eSzQ+tlHcblJ1ZKnSa5eZHN4jlS30uaOJB2gNdmyc3/f
 DSBaey0bswwd+pG4X9oNxhlDBcWDproYpfapS+Sq+qGDj4f21flKOyL2GDIb2YBUAM1ILz7V
 xHJvsix6uBirIhjAAEOA9dkCcRaJH7hQa4XSM3jhwKHD2WHgkKwhZW6rEAOsQr0M3ijFNr2x
 bnnRRKkLRS7h/zu/eFj6od3ukUaMWZ5jewOZXkiwt9RiQ2hLWs4PO8YYIQnCJZVr3TI76vGR
 grxNUksNSaseg5/U0TM0Iy2FEPXTOkDIczwKTEV7luZIXX+Tp+JBLx6sDxs+TFqcz/k1/uqM
 swa5ma2BBWq35V1XqwG05RXWwu8Ki/ynRrkOHwRkvAexz4bBqgWkmNsFkxBWEQr1i0LeFrjf
 QAIqaJsGSlXinId1e5/dnQTFBxxUPbH0WAzdSnWqDrAk9zz8QCDocET/8ns37dFYMliyHvig
 5/obzPl3l16EUD/dUfkVxzFTEO05T+28hCGEZLe
IronPort-HdrOrdr: A9a23:/P212KlFB5svq3lrUqlUgYmQtJ7pDfLy3DAbv31ZSRFFG/Fw5P
 re/8jzsiWE8Qr5OUtQ/+xoXZPqfZqyz/FICOUqTNOftUzdyQyVxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIObeEYZmIbsS+V2njbL/8d4J2g7L2ig/vYwkxgVAdwdshbnn1E40qgc3GfX2N9dOIE/X
 enl7F6T7HMQx4qUvg=
X-Talos-CUID: 9a23:FWmP627jeHwx8DktXtss91wFO8seXG3nyXLJIV6SIDYydpmxVgrF
X-Talos-MUID: =?us-ascii?q?9a23=3ALus/Aw0JzeUS6zdugiS72kluhDUjyv6OJEMLjss?=
 =?us-ascii?q?9mOKWHCwhImafsziYTdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,255,1694728800"; 
   d="scan'208";a="69935829"
X-MGA-submission: =?us-ascii?q?MDF6k/N8FKGVmcLDH4plhxfAlPClP4uz0832v+?=
 =?us-ascii?q?EHLnVMa6QUwuhV/cq244GvFVmNPL9NuaZSE2E7mE2siZL8nibCyyT2wt?=
 =?us-ascii?q?B92u3ACiP+DQusSVUJt4ws3bz2jhL5GNQXE3k91ZwXQwJ53Xx++6JCXq?=
 =?us-ascii?q?WksQN0j7e9dyKMslh0Hav6UA=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 12:02:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1698400936; x=1699005736; i=markus.elfring@web.de;
	bh=j2Kgl/t2a237fc7yBFS7vY018f+nNbX3WXupaeULsus=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=hknVo9+QDVy8odT4C1a2avwgw4J8qPHOXz8I85Hb9s1Wmf/Q8NyNqS4WxQoNQ2TC
	 wiradV1eJEdOv+1/zQQE05iA6lKlDnyRTht8fYxPvj3Xf1e3jUc+s0Ze7/Zc+/m2a
	 wx1yvZxAGt0aE/gwZKIy98ARuVk4mUNQKOMSipHKHrLiPYs45lgAgO5MtmzBjfH3L
	 ZFUsediOJFDgrpMukHvlYh7OMLsORYx0eEuJRtuuMk5z9yK8ANWxKUi62IrX5QMV6
	 6cowFiCXH+mw5Ac1GVOuTrIXN3y9ninLwZf6ghgttZlqKV6TO9V3Jfqvj1/i7U/gG
	 7k0H6viHwZTvdx9PMA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MF2gM-1qgxaS08bY-00FoAD; Fri, 27
 Oct 2023 12:02:16 +0200
Message-ID: <348231cb-e444-4c5a-a6fe-8ac2bc8188d0@web.de>
Date: Fri, 27 Oct 2023 12:02:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <d5bd4be2-9a50-4e67-b924-2c3bdc736a9d@web.de>
 <cb825a4-1229-438d-5f14-46cc7cc3b4ee@inria.fr>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <cb825a4-1229-438d-5f14-46cc7cc3b4ee@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:eSbTdq3QWY5emd7Lfvpf/Ucb0hhGg3D5FjKYWTKmQVqRrfeMDlD
 UIx+Yy42n1hge7Cwm68KSCnardWwY5+RhiZAVwCqJfkgcHBdcVaV7ycYE0/kWrUHRt8h2xa
 UeTgeo2snoiuVxKfV7+ohFxOvnorpO0AEVotTAW7cNmFYMN2Nk7Zh9ljNDhk71GamhqDm27
 K/45yj68zcTp5QUNbX/2A==
UI-OutboundReport: notjunk:1;M01:P0:lg7y91AfMXk=;hVceY92iM3PsdbIqkP+SHRidRDA
 hLEaW+qTt8Y9oho8POnVJ+niXT7PJAZ/0TrqLKx82P5Tnnvp6RLvIVUSpaIcGaJ4WJ0cSHWYG
 PxQF7PeMW0AeRi/fGZtQbw/JBkH34M9MX/NUNwLvVIm7g6yQowNxyf13zrmOpw7JseQGAyBoc
 MB7QFcgLZVnxSQv6/oATycLhnsaZsr1R0FYSeOJNiDcPMmfm9hrO3lR8iUXZZ08qb3716BpV8
 YDOTqJuIT3hQv46CTiYnjes+Gu1VYUmIgH3ydoQShxzKV7qRmyxutDQUtfU4YpoHbWseRqf6r
 Bh0ca5BuBLijHFPL2ZBz8HK7KfusxA4YSzvd0bzAd1/aqdUWbEDANMrXgSjw0dS3Hlx6On6pb
 kYHCu/iRAXjC+1yap+nHLyihz3pdW13dvXabWc1fRi/nC+5YcMifhJIed/2uM+91J2BIZTT/i
 nOpi2Y8IjGmkppfprO33rnviGJ6r1DfMtcA8Oxj2ji3RbhvbLsdiqrPO3JzgrpOPEn2kuSOS+
 Lkdx+sK1hFAujO29k//SKXr/aHKObUV59S+W/EvJr/4tmiMjXiCl7gCpO3KCNaTgKO8Kr54UR
 qWejVFSc9fRXkirLluYB7Pia2eldg/4+I10MctL2tsqZn5bwDk3x2yLzVLIjK3knexCgtHMY8
 +ryIosmKNvJCPPJWCw9hU2zdVloqIyFQkzn2Kvt8ncYQDjxUTdulIIJmF3jXpTUi2ELifUKzM
 Li9rmlSzA+8S5GCg/bfcngRTgejNJSkAbd3Zb2LnhaE0wQ2QkPynA5yt5RyaUqTwpFnw0S3Ys
 gO
Subject: Re: [cocci] Designing data processing services
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1281
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-10/348231cb-e444-4c5a-a6fe-8ac2bc8188d0%40web.de>

> I have no idea what you are asking for.  Coccinelle is a tool for matching
> and transforming code.  We don't do anything else.

Your software components support valuable data processing operations.


>                                                     If you want to acecess
> the parser separately, it is possible to do that, but it requires writing
> complex OCaml code.

I hope that development resources can be adjusted somehow also according to
such a task.

By the way:
This programming language came along approaches also for the application of
better parsing technologies.

Regards,
Markus
