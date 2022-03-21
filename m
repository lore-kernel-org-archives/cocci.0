Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FC42C433FE
	for <cocci@archiver.kernel.org>; Mon, 21 Mar 2022 09:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:message-id:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=MEWuBHYtNMP/o1cuYWqd8kZORaA+8VTyP1pu9usw2KI=;
  b=c8moxizHYeK5ZWn3ubZSFx2aLeK0Hl/PZmDs3iqSf8ZE9VMJvZNBxqZU
   6zhUh5nX+WaN0HR5Ky8Vfkb6CBEUhDbqWT/QtoiDk64xU+t++PGCLM2CE
   KuHyDgCrdCZygtjaB/2ER+0O3dwzTskdfWCeyD9mzWuNZX9EEKhYsIESB
   I=;
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
X-IronPort-AV: E=Sophos;i="5.90,198,1643670000"; 
   d="scan'208";a="27166575"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Mar 2022 10:02:18 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 53F4CE0219; Mon, 21 Mar 2022 10:02:18 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 66802E0069
	for <cocci@sympa.inria.fr>; Mon, 21 Mar 2022 10:02:13 +0100 (CET)
IronPort-SDR: BEmbUEFyUnXPmT39g3zosFeRfIT/cE12b4Ikzc/lgzjlG2mUvMeue9fMPuiAqt782FfV+jC4Yb
 XJ8QO4dG5qrq0wyUA754YTBzTBLWpmxbO4DAdl4CLFhNuK9SVl1hsFdSayKpJDIXUFSk51T+NI
 WJwKLcWhupp+fqoeKlYOZL8Z1NBKyK1FXFcgZbCB/AMuEmoFuh4re6tuuGMVAWsjwHtnhIU1VJ
 4/G4zrxYa27BtvF8istOKw2uNF8MQ7IbzEZ4QE4ca6sn/OSBWBQ7oaBiKkJwOil4htBkVOSSMT
 4I5nSknRYyormtwdlkS4Kt+d
X-IPAS-Result: =?us-ascii?q?A0BCAwBOPjhihwwR49RagQmBXIImgVUrBAtEhFSQcyiLJ?=
 =?us-ascii?q?IcYjCMLAQMBDT4BAgQBAYISgnUChDcCHQcBBDUFDQECBAEBAQEDAgMBAQEBA?=
 =?us-ascii?q?QEDAQEFAQEBAgEBAgQEARMBAQEMDQkFCAoHDhAFNgZeBmQEgUsEgXQLNA2CN?=
 =?us-ascii?q?SKDbAECAgEjHQEBESYBBAsFBg4MAiYCAlcGJIJzgmUBAw0lrTqBMYEBgggBA?=
 =?us-ascii?q?QaESB8sIlKBWwmBEC2GH4cveicQgVVEgUgBgnY+hEWDGoJllyDEIno0B4ISg?=
 =?us-ascii?q?TqBQQyeNzMDljcGkW2WW6FShTCBeYF9MxokgzhOAQIBAg0BAgIDAQIBAgkBA?=
 =?us-ascii?q?QKONoQMiixANDgCBgsBAQMJhUcBAYwpAQE?=
IronPort-PHdr: A9a23:5WCC9h/9lpz64P9uWUy2ngc9DxPPW53KNwIYoqAql6hJOvz6uci4Z
 gqGua8m1QWUFazgqNt8w9LMtK7hXWFSqb2gi1slNKJ2ahkelM8NlBYhCsPWQWfyLfrtcjBoV
 J8aDAwt8H60K1VaF9jjbFPOvHKy8SQSGhLiPgZpO+j5AIHfg9qp2+yo5pHebBtEiDWgbb9sL
 Bi9sBncuNQRjYZ+MKg61wHHomFPe+RYxGNoIUyckhPh7cqu/5Bt7jpdtes5+8FPTav1caI4T
 adFDDs9KGA6+NfrtRjYQgSR4HYXT3gbnQBJAwjB6xH6Q4vxvy7nvedzxCWWIcv7Rq0yVD+/7
 alkVQXohT8IODA68G/ZlNF+g75Vrh2ipRN/zZTabo6OOfpiZ6PQZ88WSXZdUstTUSFKH4Oyb
 5EID+oEJetWqJPyp0ENrRujHgmnGezhyjtGhn/s3K061eshGhzB0QInBd0OqnfUrMjuNKsIX
 u61yKfIzS/Cb/NQ1jfw84bJfQ46rv2WQL1/b9PcxE8yHAzKklues5bqPy+J1usTqWib6fJtW
 PyrhmAotQx/rCajytsuh4XXhowYxFPJ+Tt4zYs2OdC1VEx2b96lHZZMtSyXK4t4T8IiTW12u
 is3yLwLtIOmcSUM1Z8pxAbfZuSZf4SV/B7vTvidLSl6iX5/Zb6yhQy+/VW+xuHkSMW4zUhGo
 jBYntTDuX0BzQLf58iZRvdn4Eus2TiC2gbO4e9eO080j7DUK5s5z74wiJUTtUPDEzfzmEXxk
 a+Wal8o++a25Ov8eLnpu4GTO5d1igH4LKsuhtSyDfolPgQQRWSX5/qw2b/58UHkQrhGlOA6n
 rfBvJDfP8sbp6q5AwFP0oYk7hayFzCo384CnXkEMVJFYwiLgYftO1HAOvD4DPG/g1u3nTZl2
 f/JJaftDYjTIXTblrfuZq5y61RAxwor0dBf+5VUB6kcLP7rQE/+qMTYDgMlMwyz2+voFNJ92
 Z8CVmKOGaKZK6PTsVqQ5u01OeWMZYkVuCz8K/c//fLug2U5yhchevyEx5ocIE+4E/liLl/RN
 XHridwAOWMLpRYlCuH1iFCPVTNJIXC/Q/RvyCs8DdeDBJ3AW5vlrbiPxia9EdUCQ2lcCU2XV
 1rseZ+FXfgkdy+YZMNsxG9XHYO9QpMsgEn9/DTxzKBqe7K8EkwwsJvi0IMw/OjPjVQp8iQyC
 c2B0maLRmUyn2USRjZw0ros6VdlxAKl1q51y+ddCcQV/+lAByIzL53B1KpXD97oWwTOVsiEQ
 hCqT4buGik/G+o42MRGeENhA5OnhxHH0TCtBuownqaIGYdy36bSxXn3KO5ixnyA2KRyx0I+T
 J5pMmurzrV66xCVB4PNlBCBkL22cK0HwCPX3GKE0HbIo0xSFgJ9OUncdVYYYEae7dHw50eZC
 qSrFaxiKQxZj8iLNqpNbNTty1RAXvbqftrEMSq3nC+rCBCEy6npDsKicngB3CjbFEkPkhwCt
 XeAOw8kAy69omXYRDVwHFPrakno/KFwsnS+BkMzygiLaQVm2d/XslYwjOafVuhV87YKoiYnp
 B1rEVz709+XQ9uMqgx9fblNNMsn6QQP3mbYugphe524evo73BhEKVsx5hyojk8kb+cI2dInp
 34r0gdofKeR0VcaMiidwYi1IbrPbG/74BGobafSnFDYytefvKkVu5Fa4x3uuh+kEk06/jBpy
 d5QhjG574/JERFUfJb/SEcx+DBlqrucbiR3tOa2nTV8dLK5tDPPwYdjIeI/yQu7OfpbPrmFE
 gDaDMAQQcSjYr9P+RDhflcPO+Zc87QxNsWteq6d2aKlC+1nmSqvkWVN5I0VPlukzyNnUaaI2
 p8Ex6rdxQ6bT3Lni0/ntMnrmIdCbDVUH2ylyCGiCpQDLqF1eI8KDy+pLajVjp1bjoTuRmUe2
 VqtHVIA1+e2dBDUY1G10QBL1EsRqGCqgmPilmYyyWt26PPAmnWUi+35PAIKIGtKWHVvgTKOa
 cCvgtYWUVLpJwklmR255Frrkq1SpaBxNW7WEg9Deyn7KX0nU7Pl7OPYJZQVt9Vx7mMOCrfZA
 xjSULP2rhoE3jm2GmJfwGt+bDS2otDimAQ8jmuBLXF1pX6feMdqxB6Z6saPIJwZljcAWiR8j
 iHaQ1amONz8t/CdjZTeqaaTU2y7V5tcWTbmx8WMuWHogA8iSQ36hP21ltD9REIf2DX4ysIse
 CHGthf6baH02q78Pe8tLSwKTBfsrsF9HI95iI45gpodjGMbipui9n0CiW7vMN9f1PG2fD8XS
 DUM2dKQ/Bn91RgpMCeS34ygHCb4oIMpd5ygb2gRwC54881aFPLe8ulfhSUs6lug8VCLOKI7x
 G1Cj6J0tjhD2bFO4ldIrG3VA6hOTxMBZ2q2zUvOto349OINOS6uaeTijhMk24r7U/fb/UcEH
 yymMpY6QX0qt5o5bwiKiSyprNu4KJ6KPLdx/lWVi0uS37ITccxs0KNX1Gw/fjij9Xw9l7xh1
 EMogsv85tDYbT0qpv3xAwYEZGesOIVMoHe03PwYwJrRhd7KfN0pGy1XDsuyC6v2TXRI76Whb
 l3WWDwk9iXLQ/yGQ1LZshw+6SiVW9WiM3XdTJUA5fNlQhTVZElWgQRPGS4/goZ8DQeygsrob
 EZ+4DkVoF/+sBpFjOxyZVH5VS/EqQGkZy1RKtDXJQdK7gxE+0beMNCPpuN1ESZC+5S9rQuLY
 mWFbgVMBGsNVwSKHVfmdrWp4NDB9aCfCI/cZ7PWZq6SrOVFS/qS7Zeoz5cg4DuGcMmCfzFjA
 /A9xktfTCV5FsDeyFBtA2QckyPAadLepQ/poHQt6Jrlr7KyB0S2v9jqafMaK9hk9hGojL3WM
 ueRgH08MjNEztYXwmeOzrED3VkUgiUodj+3EL1GuzSeKcCY0qJRERMfbDt+ccVS6KdplCxEI
 83GkZXY0rBij/g6I0hIXxrtl4v6AK5Ca3H4L17BCEuRYf6eIibXxsjsfa6mYbhXkfkSqBC6/
 zqWWRyGXHzLh3ziUBahNvtJhSeQMUlFuY2zRR1qDHDqUNPsbhDT2DBfkjA8h7E51Cqi3Y80N
 D9hbwVSo7fW4S4K2p2X/kRe43AjIeTWw06k
IronPort-Data: A9a23:2qPUt6zsamfwYoB5dgN6t+c7wCrEfRIJ4+MujC+fZmUNrF6WrkUDy
 GVMD23SPa6PYzP3f9B/boS1pkgCuJTdzdM1TVA5/lhgHilAwSbnLYTAfx2oZ0t+DeWaERk5t
 51GAjXkBJppJpMJjk71atANlVEliefQAOOU5NfsYkidfyc9IMsaoU8lyrZRbrJA24DjWVvW4
 4qq+qUzBXf8s9JKGjJMg068gEg31BjCkGtwUosWOJinFHeH/5UkJMp3yZOZdxMUcaEIdgKOf
 Nsv+Znilo/vE7jBPfv++lrzWhVirrc/pmFigFIOM0SpqkAqSiDfTs/XOdJEAXq7hQllkPhxj
 4hfiby1ajs1I7bjouhAVANDShpXaPguFL/veRBTsOSWyFDaNWThybNiASnaP6VCo7wxWzsRs
 6VHbmlXBvyAr7reLLaTb+B2hdk4auTvMpkevH5I0jzTS/orKXzGa/STvIcDhWxYasZmQ+3ed
 vAmaGFWS1fsM0RRa3Y2E4N9pbL97pX4W2QF9AzM/PRfD3Lo5Ad227PsGMHEf8SDA8RThEeR4
 Gzcl1kVGTkfM8GDjyWI+DSgi4cjgB8XRqoSU+Cqyt5vo2GP23c8MhFLUkGg+MKQ3xvWt81kF
 2QY/S8nrK4X/UOtT8XgUxDQnJJilkFGMza3O7JggDxh2pY48C7EXjRfFGIphMgO659vFWZCO
 kqhwouxbQGDpoF5Xlqx2994RxuXPi4JJGULeDVsoeAtvoe/+dlbYv7ndNZuEaixh9v5XAn+y
 jSYxBXSap0WitMXkbq29xbLjlpAR6QlrCZltm07vUr8sGuVgbJJgaT2szA3Ct4ede6koqGp5
 iRspiRnxLlm4WuxvCKMWv4RO7qi+uyINjbR6XY2QcV+p2z8oCPyId0OiN2bGKuPGplUEdMOS
 BCC0T69GLcIYhNGkIcqP9PvUJ5CIVbIT4m8DKu8giVyjmhZLVLbong3OyZ8Lki03hFkkKcjN
 I2dfNrkBHlyNEiU5Greegvp6pdynnpW7TqLG/jTlk37uZLDOiL9YepbYTOmM7FhhIvZ8V692
 4sOZ6OilU4FOMWgOXa/zGLmBQtXRZTNLcuq8JM/my/qClYOJVzN/NeKmOJ/IdM5x/oJ/goKl
 1nkMnJlJJPErSWvAW23hrpLMtsDhL5z8iA2OzICJ1Gt1yRxaIqj9vlNaJY9O7UqrbQxwflxR
 vgDWsOBHvUWFmWZoWtAN8GlodwwbgmviCKPIzGhPmo1calgcAqVqNXqSQ3iqXsVBS2tuMpi+
 LCtj1uJQZcKSwl4ItzRbfajkwG4sXQHxrBtUkGOLtQKIBfg941jKirQiP4rIphQeEuZmWbAj
 16bWE5Kq/PMrok59MjyqZqF94r5QfFjGkd6HnXA6ejkPyft/l2lnd1KXtGOcG2PT2jz4qijO
 b5YwvygYv0KmFFG79h1H7pxlPts4tzyu/lFww4iEHiSNwanDbZpI3+n28hTt/QRl+ED5lbsA
 hqCqotAJLGEGML5C1pPdgArWeS0061GkDfl6/locl7x4zV6/ebcXEgObQOAjjdRcOl8PI8/m
 L5zvckL90qghxBsPtvf1nJY8GGFL3ohVaQ7t8hGUdGx1VdxkglPMc7GFyv7wJCTcNESYEMkF
 T+jgvaQjbprwEefIWE4EmLA3LYGiJkD0PyQIITu+7hUdhv5av4LMNl59DMqUkJKwx8B3+8b1
 q2H8aFqDf3mwtuqrJErs6OQ98VpGxCTvED8o7fMvHOMVFGmDwQhM0VkUdtgPyklH6Z0YTVRu
 r2VoIogvfAGY+mpthYPtYVZRzAPgDC/GsAuWCxqIihdI6QHXA==
IronPort-HdrOrdr: A9a23:tkwJ3qEmsn6q4tWKpLqEKseALOsnbusQ8zAXPo5KKSC9Ffbo6P
 xG/c5rtyMc7Qx7ZJhOo6HkBEDtex3hHL9OkO0s1PKZLW/bUQiTQL2Kj7GM/9SIIUSXm9K1l5
 0QCpSXzbbLfD9HZK3BkWqF+rgboeVvi5rY/ts31B1WPHtXgkxbnnpEIzfeLm0zYAVdH5I2GN
 6g9tNKzgDQAUj+V66AdwU4t2Ovnbf2qK4=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,198,1643670000"; 
   d="scan'208";a="9110313"
X-MGA-submission: =?us-ascii?q?MDE+UZL1D0OH24ZXsS/CBV9SWqgz5S60HSmMrz?=
 =?us-ascii?q?DGc9EKdIKWNCJl8GLD6XHHZPlf4zd6lnkAhIO4NAdOYZW7w0gxW/ixkC?=
 =?us-ascii?q?9xRDKaKkC/7hwSasFIJwhZ91GPIpJEbY7JaQV8i0hp4qTCdQLlb1hn+g?=
 =?us-ascii?q?EPls4EOwEsPRURgijG8TpFLA=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 10:02:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1647853331;
	bh=LuAPBCTphv0uAYYUEvSDVZfSN73REB/W0mT3ntn+Ypk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CYKi/ozfh2l5eIgZpVw+uNIt/VZUlgKqSkF2fgglPlp5PEt4pYF9oxxYNZaMQKtxv
	 nKkT76+QUMAO1VzknbenR4/RJH7/zGMV78V4NLEE1UCnu0DyM9NIa6V6CGsaICkxV+
	 hOUgFb3PuYAGLQ7rd0mt1wnzQZAfTbSmwJVcik88=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [212.144.252.253] ([212.144.252.253]) by web-mail.web.de
 (3c-app-webde-bap05.server.lan [172.19.172.5]) (via HTTP); Mon, 21 Mar 2022
 10:02:11 +0100
MIME-Version: 1.0
Message-ID: <trinity-aa278557-9b21-4086-848b-218a903ce0ee-1647853331428@3c-app-webde-bap05>
From: Markus Elfring <Markus.Elfring@web.de>
To: Eric Wheeler <cocci@lists.ewheeler.net>
Cc: cocci@inria.fr
Content-Type: text/plain; charset=UTF-8
Date: Mon, 21 Mar 2022 10:02:11 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <a28111b-90ab-1d57-58de-113a50f61f41@ewheeler.net>
References: <a28111b-90ab-1d57-58de-113a50f61f41@ewheeler.net>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:sMfIxoDrH+l6SLfOrANoPnkmqHqCplQcZZ/4G1myY3X6Dgz9ERg/y4CV7B/B7CsIzXaYb
 cEwrb0LiBEhgaePL3L1XGL9CYlT+TKlzEHLLaMfRAis2tSYRjmN5zmpTM9kNJwVBk8Ui2FAn0U2k
 +HcAzCfucQIpyYc1h9Jo59wap8RWNtsH4T6uiOKTwkFPRWLea19DrfN0YmJn7M0IMpvsNoQ7Lq2W
 WEwbsM0CUIRg4LTh4sPa0sPK7ItR78MAJEN+H+XgXK/ugViDecpDUYJasUcMK9ySjGpJRpnqgqVw
 To=
X-UI-Out-Filterresults: notjunk:1;V03:K0:3SBgCo3RNEM=:kXxE+WqJEK6pGaRModGmO2
 ajc6JLKRzq3Dox6bkpX0kc+DexkaNRHP3jV52wykHa4p6q8IKIZLwZvH080pYJdSuQ9PRETkZ
 GoI8tn8t0c7JUu8C5xkt6siLKcW574rz3p8dd1TSDy9vP4U+NG0Kb+Xw4BGw3bksozWaeJTX3
 C/CoydC5Xf+jsHKfLZ8z2+AhMiAcI3vkcuDGPSmIvbui6umSEDF4Bf08IhUCEW/pNI0kEgvuG
 RhCja5uLpVCepVh4iBty6ZA+ZoQRIq2qLtT3auFutEio39i5pCZUXTMJ3QnxhSXGrRQ8S+HvK
 gu/cxKm21uT6gqGwkn5DIZaDIjHobL1HOWkqsSiU0j9z8hQrqKs/nAOR+F1w7IEQoshclN+Xj
 7+yux4Dh+sdsg4NMeXhxTqCCdq61NaKzngfRJCDdr4O04chl0Y6M0l4eqkKFvcIcYf9BmmV8R
 m9LJDes7ab1RkGXzx+B+AtHaF06NS4uLUOtEGAwiXFR0YCGrGMrA8L+gYDafwNSpWrg6NKfNt
 drvlQHhLoPkJh1TfXqYchFuRiJ3dtyMrrL4Ce3xBGQexYWsE//pz5VFcpeB42E+oehaRoQMiG
 xxn+bs7r5t8N908O+m8d8g7u/LjR4tLVq3nC9dQDaODfpjyDGx996yJIR74HTCzpskYD2Ag8M
 1simmAp8uiJHBXBTRbInQg3VI4ybAsDUnytbrmS0TsJnN1AJUmG2h2sI0mFAiLfTFOa1C4Gj8
 f4gs7WcCgQoLGvxrJcB7fuu1Y29jVBPrkHFplBnKGgQy5M/drs1tPNyP/5CUtaJ37YJyfVi1n
 XyDzloH
Content-Transfer-Encoding: quoted-printable
Subject: Re: [cocci] Is there a stringify operator?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 272
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/trinity-aa278557-9b21-4086-848b-218a903ce0ee-1647853331428%403c-app-webde-bap05>

> I keep running into situations where it would be nice to stringify an
> arbitrary metavariable.
>
> For example:
>
> 	@ r1 @
> 	type T;
> 	identifier I;
> 	@@
> 	T I;
>
> 	@ r2 @
> 	type r1.T;
> 	identifier r1.I;
> 	@@
> 	++printf(#I " has a datatype of " #T "\n");

Do you need any extra debug information?

Are you looking for further advices so that more source code transformatio=
n
alternatives will become interesting?


> Not sure of others would find a '#' operator or some other stringify
> functionality in Coccinelle useful...

Would you like to try additional data processing possibilities out togethe=
r with
the scripting languages which are supported by the Coccinelle software?

Regards,
Markus
