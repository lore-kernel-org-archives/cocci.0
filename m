Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 617F4C43334
	for <cocci@archiver.kernel.org>; Sat,  9 Jul 2022 05:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=7BJPt0mFL/a/tuyqbuPbhGgG8i9zEw/1aG84YfNY8AE=;
  b=k/mPiKwqu75lHWrIxXOXKwJZIM9QyE/m5ROA5tX4hpN/DsPzW1jsv4tR
   LtPEckFfBShSBNiPLkuS9PdAdYO8EPoDP7rWvjiN0WIetMg7K3+5itNcV
   axRVnePsSTLp4jRKw59SU1clcQaIHbXJpT4aVON+5ddu8lg1J2SS1l175
   o=;
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
X-IronPort-AV: E=Sophos;i="5.92,256,1650924000"; 
   d="scan'208";a="44936620"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Jul 2022 07:31:16 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 25420E034D; Sat,  9 Jul 2022 07:31:16 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id D3D51E015F
	for <cocci@sympa.inria.fr>; Sat,  9 Jul 2022 07:31:09 +0200 (CEST)
IronPort-SDR: Cfbi6a2qDZUV20eXWCSHUktwi9aKN06f3AO3Eo65KrXqb16Tl/vhTe08TlAVAa26SRisPASZkC
 ZWPDLV7pUwL+LKridEsSZ8MnBPcrSf6Yc4rTFiMT0oZafneII58l48J5w99D/e7yfHE+KjwS8r
 Vky0e4orZk2kC7wSF4Bq2RcZkhSs03Xp8QEFvyh5CaXV/oRxIrEJTgyhnAq/leKZPSXA1elpeE
 ev7ij3f3fnTFqBaCs4Wq/N0OVYnYOgYjhurV7aDJ6G82JIfm6eS3gn9u9WB2bDI8bHjc8w4trs
 GlMVPR+m0IGOIAnevLMcqD8d
X-IPAS-Result: =?us-ascii?q?A0AFAADdEclihw4P49RaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBOwYBAQELAYIjgVcuBAtFhE6IIYZHgXcuA4Qkhw6HHIongXwLAQMBD?=
 =?us-ascii?q?T8BAgQBAYUEAoULAh0HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBA?=
 =?us-ascii?q?QIEBAETAQEBDA0JBQgKBw4QBTYGXgZkBIFLBIF0CzQNgjUpAYNkAQICASMEG?=
 =?us-ascii?q?QEBESYBDwsaAh8HAgJXBgEMCAEBgnmCZQEDDSMHr0F/MoEBgggBAQaESx8sI?=
 =?us-ascii?q?lKBXAmBESwBil0JhBUnEIFVRIEVJwyCdz6BD4M1g1aCZZp8JgQPAxotLxKBH?=
 =?us-ascii?q?2wBCAYDAwcKBTAGAgwYFAQCExJNBhYCEgUHCgYTDhQbEhAXDA8DEgMPAQcCC?=
 =?us-ascii?q?RAIEiUIAwIDCAMCAxsLAgMWCQ4DHQgKGBIQEgIEERoLCAMWPwkCBA4DQAgOA?=
 =?us-ascii?q?xEEAw8YCRIIEAQGAzIMJQsDBQ8NAQYDBgIFBQEDIAMUAwUkBwMhDyYNDQQbB?=
 =?us-ascii?q?x0DAwUlAwICGwcCAgMCBhUGAgIYVDkIBAgEKyMPBQIHLwUELwIeBAUGEQgCF?=
 =?us-ascii?q?gIGBAUCBAQWAhAIAggnFwcTGBsZAQUyJxAJIRYGCh0KBgUGFQMhRyYFCjsPK?=
 =?us-ascii?q?DQ2PCMJHxsKgRUsCSIWAwQEAwIGGgMDIgIQKQYyAxUGKRUVGhMJK4EBBiIBG?=
 =?us-ascii?q?wKcLWsGWoMewRg0B4IVgTyBRAyeMwYTLZZWDgaRe5Z3IKcngWGCFTMaJIM3T?=
 =?us-ascii?q?gECAQINAQICAwECAQIJAQECjh0ZHoNuii0/NDsCBgEKAQEDCYVHAQGJPAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:XRkdAqMLIW0o+vPvrR2LkcFynXyQoLVcMsEvi/4bfWQNrUolhWECy
 TcfUGHSM66CZmfwKtwjaNy/9k4G68KAy9diQHM5pCpnJ55ogZqcVI7Bdi8cHAvLc5adFBo/h
 yk6QoOdRCzhZiaE/n9BCpC48T8kk/vgqoPUUIYoAAgoLeNfYHpn2EgLd9IR2NYy24DmW1PV5
 bsenuWGULOb824sWo4rw/nbwP9flKyaVOQw4zTSzdgS1LPvvyF94KA3fcldHFOkKmVgJdNWc
 s6YpF2PEsw1yD92Yj+tuu6TnkTn2dc+NyDW4pZdc/DKbhSvOkXe345jXMfwZ3u7hB2L2OJz8
 vVvpKWfSAoOI6bnx7kzXxNhRnQW0a1uoNcrIFC6ttGPiVLLeT3gzp2CDmlsZNdeoLwoRzgTs
 6VEQNwORkjra+ae5buhSfR3wOknItPqOow3pXxqiz3UZRojacyfEv6Uu4YHtNs2rsNOTdTQQ
 5YDUydqTC7RZwIQIHlMC6tryY9EgVGmLmEG8QvLzUYt2EDYywd60ZD2Id/Nc5qLQ99UlwCWv
 Aru+23mCxUeHM6ezDCf+zStgPXOlGX1Quov+KaQ8/l3nBuMy2ZVBBB+uUaHTeeRiAmMWeh/C
 V0t1SsjirU53xP2YNX3ZkjtyJKbhSI0V91VGuw8zQiCzKvI/gqUblToqBYeMbTKU+dpHFQXO
 k+1c8DBWGQz6e3NIZ6J3ujE/WziUcQABTVaPUc5oR05D87LjKxbYvjnbttiFKS4lMb+GTzxz
 1hmRwBj2elK16bnO42B/V3GhTaloJSMdgA84he/Y45IxgZ+eZLjeIGir1TWhRqhEGp7Zgbc1
 JTns5HPhAzrMX1rvHLUKAnqNO/xj8tpyBWG3TZS82AJrlxBAUKLc4FK+y1ZL0x0KMsCcjKBS
 BaN5FwKvMILZyLyMfcfj2eN5yICkvmI+TPNCaC8UzaySsQpHON61HwyNBDLhQgBbmB2yf5iZ
 f93jvpA/V5DVPg5lWPoLwvs+eZln2g/w3/eX5b201yu3tKjiI29Gd843K+1Rrlhtsus+V2Lm
 /4Gbpfi40gBDIXWP3eGmaZOfAhiBSVqXvje9p0HHsbdeFYOMD96UZf5n+h+E7GJaowOy48kC
 FnmBhQHoLc+7FWbQTi3hodLNOu/Dc0l/SxjZETB/z+AghAeXGpm149HH7NfQFXt3LULISdcQ
 6ZXdsOeLO5ITzibqT0RYYOj/pNvflKniFvWbSaiZTE+eb9mRhDIo4O1IFGwqXNWVifn59Ejp
 7CA1x/ARcRRTQpVDPHQNKClwWS3sCVPg+l1RUbJfoJedRy0oohnIiD8lNEtJMQIJUmRzzeWz
 VjEHhoS4+XA+tdn/N7MjKGCjoGoD+onQhsERTaGt+7uOHCDrGS5wIJGXOKZRhznVTv5qPe4e
 OFY7/DgK/lZzlxEhIpLFeo5x6wJ4day9aRRyR5pHSmQYlmmVuFgL32B0ZUdv6FB3OYA6w6xR
 17J5dRQf7mEYZu3HFkULQsjT+KCyfBNxmiMt6toeh2i6X8l5qeDXGVTIwKI1n5XIox1B4V5k
 +0vj8gbtl6kgR0wP9fa1S1ZqzaWInobX/l1v50WGtay2A8s100EfpHWTCP7ucndZ9JJO0gsA
 zmVmKub2+UCnBWfKSJrGCifx/dZiLQPpAtOkg0IKWOJrdyZ1PU56xtcrGYsRQNPwxQbiO9+N
 wCH7aGuyXliItupuCRCY4xoMwRGGQHf5UH7jVcE/IEco49ESUSVRFDR+87UlKzaz46YVidW9
 veUxQ4JlB70Kdrp0HJatVFN8pTeoB8YyuEGsN+qFYKJEvHWpNYjbrCGPQI1lvcsPS/9aIAra
 wWnECacpJAX7RItnpA=
IronPort-HdrOrdr: A9a23:tucPRKxwc+YvzI4vy/aaKrPwCL1zdoMgy1knxilNoNJuA6ulfr
 OV7ZcmPHjP+U4ssRAb6Km90cy7Kk80mqQb3WB8B8bHYOCighrPEGgA1+XfKl/bdxEWn9Q1vc
 pdmupFebjN5DNB7foSjjPIcerIjOPnzEiy792utEuFoDsaEZ2J1m1Ce3um+sYafmN7OaY=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.92,256,1650924000"; 
   d="scan'208";a="44936617"
X-MGA-submission: =?us-ascii?q?MDEO7gqhTj/KwcWZno2cDdoohRSCB++Gg8w8lY?=
 =?us-ascii?q?S3LWyZXUdrADqEnICBq6aaar1NOe4v1/ko7q+rDpQXxwf4H5NpPneM4z?=
 =?us-ascii?q?DCP6PuoheMRj+3zQg0hQG2TsQfA+TMM5xvegvkIfU6Ri6Bi5lMppw5J4?=
 =?us-ascii?q?B2oQG5/N7/VWVFZfEg915TyA=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2022 07:31:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1657344666;
	bh=7BJPt0mFL/a/tuyqbuPbhGgG8i9zEw/1aG84YfNY8AE=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:Cc:In-Reply-To;
	b=WKlQs6YFNIQ1WzaNfNxRh5I7dBGqdgT4FAkddgp327F9SqFD0U9SspdgBD9YAIInW
	 fd22/PARM4LwUYTcsQUmlIssNh5y3WTpSIOFcfXnX5m25PBuWjQ2bwTQBDJG1SOxrq
	 /3+enqwDDwiwZCFnWSECWAMhYkeXh630h7THcdA4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.20] ([78.48.136.110]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M4KNZ-1o9m4h1UAb-000QUe; Sat, 09
 Jul 2022 07:31:06 +0200
Message-ID: <612d0d85-9bfa-8dc2-8888-80eee1c8769f@web.de>
Date: Sat, 9 Jul 2022 07:30:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>,
 =?UTF-8?Q?J=c3=a9r=c3=a9my_Lefaure?= <jeremy.lefaure@netatmo.com>,
 cocci@inria.fr, kernel-janitors@vger.kernel.org
References: <AS8PR03MB7603EE9F885BA2573CD56CF993BD9@AS8PR03MB7603.eurprd03.prod.outlook.com>
 <alpine.DEB.2.22.394.2207032345230.23263@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Cc: Nicolas Palix <nicolas.palix@imag.fr>
In-Reply-To: <alpine.DEB.2.22.394.2207032345230.23263@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pPUSD2hOmb1burK0bIn3py5N12/ygUQ88QYpOE6YEBJ5kyMDj8j
 UgLL8T2J2/ql4dpEg8r8GPJ+Us0OekGHBkm7WHRlQX7Jk7c4UJ0/aVFm0nmoB0jlHs2i87n
 +BCdVc7jZ8fuVcJZ9WSLG2s53e4Z5eyJjrKy93nQqExCzW52qmsnNHxxRP49GxrbI6+q7Bd
 jwDO6ik3CY14PwIy6fLDw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UZ0RQDP6pgI=:cU/gC4VXNOIApRvFCoxWBk
 Ri0PxT7zIjVO/ek54YY6RQ5ZRxwL16PGkZuanoI6GpIDrLUTj0ww0A4q8R+exzQdACADpENVI
 rHItSa6dgcHg9U+qOxihYDIBasYCXNKQoiIcIqWPwhoETxhN+qxp4ySSj40O9WLgc1d9JwDho
 U+g1X5v7zjhvSeepAaie2EiESuLU1WlpRe7ak73BMrIgvtxXYwCnSZg+x2YVbuUR6M2eaDbkA
 Pf0w3KZadVL4syq4IoKRgqaDq5232zjqhIWFNk3Q3lqm5NXZoaT13sUzQy+4Zjbey0HcjdX0P
 cCxWT75VL9YiaspkNzs0PIj8pxHN2lwbJTo8LNi+3xIDInFPFpL/tYQakho0eUyLi312fJVI6
 KVKG11Ly3J45JIRAsO6XcHQ604Yhd/LNVRImRHHjeh0KW48W++QKsBkZxDxJxqeSs2z88MSIH
 taVPvBXhmNeKjhGUnmgiGUR6sF3zNLg0G8k4IEqLqSlJwhOqogugUu2S2AuinwT9CMwF0c6+p
 O6QDfZidyg/C2lxWQ7IdQS4RH+S42ITY6maEFtPi6GcyMYbTkbD/TwJvSsIBSkbvKYdO8J8BZ
 plD73OF2ADqCB3ipTyPxeckW6tQy/emkbwc9DzxJxnRdTMEsXJNQEmy1Jbk18gjbFsN3K4vuH
 9dMg9RU1Pnm6jMMuFwADQX17z2TFNhI+CpOOnTZmOPbanf35cVqjM65XmqWO25xsj4pPXy5mX
 5cW9biUJgN5kujUVhGHX10dpNUQ4ye7OkuQFkEKER0nzHJFwtetudTfo03xnV3giN+Qm3Jr9U
 tOxl2jt0GSDsm4vHT1dkDGw8cuwyena7UFvfnhnMStSVgRWV7PgaTN+CRZ85WySJ7+naNpipk
 SqWNjQ2elDL8vmsXakieBlRHXLkXbFy2vY2GvTQNQLbqzyWc2tWu0zloW/Zxn7OmBxfuiGdAz
 lIEBJxrlSXVvs8vwkHlmRbZQ51dZBhXj/FlcdooIF8w3I38O4eo2PLAfhs0HAgMZTRnTnc7zz
 e7HN5OaSres3xhCjvpy/YbYgPevI+ZQklsX3NA8irHodRKQVUFAbM5JxI8Q/2NB01s3sQyfqv
 5B1kw8tI0Mpfu0zGKi0tEt3cZXbtp0xpG89ACDdOStifi563cAmyfvwOw==
Subject: Re: [cocci] [PATCH v5] coccinelle: Extend address test from ifaddr
 semantic patch to test expressions
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 488
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-07/612d0d85-9bfa-8dc2-8888-80eee1c8769f%40web.de>

>> This change aims at detecting an address test in more complex condition=
s
>> and not only in if statements.
=E2=80=A6
>> v4 -> v5: Change semantic patch to match explicit tests to NULL +
>> improve commit message
=E2=80=A6
>> Applied, thanks.


How do you think about to support more case distinctions for the discussed
source code search pattern (including also the detection and special handl=
ing
for pointer data types)?


@display disable decl_init@
type t;
statement is, es;
identifier i;
expression x, ix, ex, z;
binary operator bo;
@@
(
*if (&x)
=C2=A0=C2=A0=C2=A0 is
=C2=A0else
=C2=A0=C2=A0=C2=A0 es
|
* &x bo NULL
|
* NULL bo &x
|
* !(&x)
|
* (&x)
=C2=A0 ? ix
=C2=A0 : ex
|
(
=C2=A0t* i =3D &x;
|
=C2=A0t* i;
=C2=A0... when !=3D i =3D z
=C2=A0i =3D &x;
|
=C2=A0t i =3D
* (&x)
=C2=A0;
)
|
=C2=A0(z =3D
* (&x)
=C2=A0)
)



Regards,
Markus

