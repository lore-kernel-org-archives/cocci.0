Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59C77C433FE
	for <cocci@archiver.kernel.org>; Fri, 20 May 2022 15:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=/nVzyQHmcvZy2tMyUPdYmW+3HKd185U+nsyUJ54cRuM=;
  b=naDhuUUxpIZUoVGsQPqTD1ZscSQtSrPW1yjtaMnplZmQX2nMtaN86z3Q
   EeASd0y9zcfQE8BHQX41z4vbWtl5qlJGY8GNheujDvprEurhrmKViwSI7
   yizQBwGkpzR3kLUto2ZxI9wqscUw13enw/ehusuiy6NS22JLigQJ+0jtj
   8=;
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
X-IronPort-AV: E=Sophos;i="5.91,239,1647298800"; 
   d="scan'208";a="37384762"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 May 2022 17:56:39 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 363B0E0096; Fri, 20 May 2022 17:56:39 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id F187FE0094
	for <cocci@sympa.inria.fr>; Fri, 20 May 2022 17:56:35 +0200 (CEST)
IronPort-SDR: vFqtM9rAb3a76QFHZTWBMvvlZ8/QQ1uwYX4jhzl8UxXLX/N+IKxUbPksEzwasr/+ilZ0e6eRgq
 FgYveF9lwbFhAsjtZwJu/MIN3Uo4s5upYZ+njRpD1YiTDCCmrH3lVe/jzSkQ0YHBQklnwGbGq6
 oFevMl2To/exa5AnFNJRIHz+WY5Q1t/+BQFlh6v2EEkDG15RqaizNovneMCfVAyWlVqvLG+U0L
 Vj9Kx4cr+0GInppVcFrfD31GxrC0fkz+O/bYDmMmErPMrR0vfJoOcV7aJTh6c4XyG4rxb2cJs7
 FsKCBmotyRGo7GMPB2ziOPY9
X-IPAS-Result: =?us-ascii?q?A0AGAAC/uYdihwQP49RaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE+AgEBAQELAYIjflUtBAtDhE6RDQOXFIdMCwEDAQ07BAECB?=
 =?us-ascii?q?AEBhHgKAoU/Ah0HAQQzBg4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEB?=
 =?us-ascii?q?AETAQEBDA0JBQgKBw4QBTYGXgZkBIFLBIF0CzQNgjUpAYNkAQICASMdAQERJ?=
 =?us-ascii?q?gEPCQIaAh8HAgJXBgEMCAEBgnkBgmIBAw0oC5ApnBGBMYEBgggBAQaBPwEVQ?=
 =?us-ascii?q?YI0HywiUoFcAwaBECwBihgvgjhpeicQgVVEgRUnDIJHMD6BD4FTAQECgSU5g?=
 =?us-ascii?q?1aCZZVrKAQPAxwyNRKBIXEBCAYDAwcKBTIGAgwYFAQCExJNBh0CEwUHCgYWD?=
 =?us-ascii?q?hQcEhIZDA8DEgMRAQcCCxIIFSwIAwIDCAMCAyMLAgMYCQcKAx0IChwSEBQCB?=
 =?us-ascii?q?BMfCwgDGh8tCQIEDgNFCAsKAxEEAxMYCxYIEAQGAwkvDSgLAwUPDwEGAwYCB?=
 =?us-ascii?q?QUBAyADFAMFJwcDIQcLJg0NBBwHHQMDBSYDAgIbBwICAwIGFwYCAhlYCigNC?=
 =?us-ascii?q?AQIBBgEHiUTBQIHMQUELwIeBAUGEQkCFgIGBAUCBAQWAgISCAIIJxsHFhkdG?=
 =?us-ascii?q?QEFNicGCwkiFgYKIgsGBQYWAyRRJwUKFQYiARsClUgLggFgGhskgh8eESmSE?=
 =?us-ascii?q?a4oNAeCE4E9gUMMiUyUXQYTLZZQDgaRdS2RDIUuII0LmgKBd4F/MxokgzdOA?=
 =?us-ascii?q?QIBAg0BAgIDAQIBAgkBAQKOHRkegzszgQuJIj80AgkwAgYBCgEBAwmFRwEBi?=
 =?us-ascii?q?DiCSAEB?=
IronPort-PHdr: A9a23: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
 3M1
IronPort-Data: A9a23:fTwMWq5llXDCZn38XMFiBgxRtBXBchMFZxGqfqrLsTDasY5as4F+v
 mMWDD+GOvrZYTOjf9ByaNviphxX7JHWmoNgS1A5qCpnZn8b8sCt6faxfh6hZXvKRiHgZBs6t
 JtGMoGowOQcFCK0SsKFa+C5xZVE/fjUAOK6UoYoAwgpLeNeYH5JZSlLxqho2+aEvfDjW1nX4
 Y6o+5WGULOY82cc3lw8u/rrRCxH56yaVAMw5jTSstgW1LN2vyB94KM3fcldHVOgKmVnNrLSq
 9L48V2M1jixEyHBpT+Suu2TnkUiGtY+NOUV45Zcc/DKbhNq/kTe3kunXRYRQR8/ttmHozx+4
 MtIicXoVl8nB6Tvu+cjfjxKDHEuFJQTrdcrIVDn2SCS50jBbmeq3PhkSk07VWEa0rwuWycUr
 6NecW1LMnhvhMruqF6/YsxlnMc+N4/GOI0Fu3dv5S7UB7AqTPgvRo2RuoQIgGht26iiG978Z
 eweShpFdi7Gfjl+N34OWa44tf+n0yyXnzpw8Q/J+/NuvQA/1jdZ27/mO9v9Yc2PXcwTn0CCp
 2uA8X6RKhUTK9WbzRKX83emnOaJnCXhWYtUGqfQyxJxqFiU23BVFxAcE1e2yRWktqKgc8xaF
 xVM5XIglKER10+VY/zvQE3oiUfR63bwROFsO+E97QiMzI/d7ACYGnUIQ1Z9hDoO65VeqdsCi
 QXhoj/5OdB8mOHEESrGrd94uRviZXJKcQfucAdZFVNt3jX1nG0kpj7iJjqJOI28lNnuAyzwz
 lhmRwBh2exI0qbnO42R9FzKhXeTDUzTUhI44w/aRG3N0++UTIuiepDu9lXRq/pNRGp4crVjl
 Che8yR9xLlQZX1oqMBraLhddF1Oz6vUWAAweXY1Q/EcG82FohZPh7x47jBkP1tOOc0ZYzLva
 0K7kVoPucUDbSv0N/EoPd/Z5yEWIU7ISoWNuhf8MYsmX3SNXFPblM2TTRPMjj62yiDAb4llZ
 cvCKK5A8kr2+Yw+kWboHr5DuVPa7nlwnCvSQ4z21RKqzfKXaxaopUQtYDOzghQCxPrc+m39q
 o4BX+PTkkk3eLCgPkH/rNBCRXhXfCBTLc2n8KR/K7/TSiI4Qj1JI6GKm9sJJdc695m5Y8+To
 xlRrGcDlAGg7ZAGQC3WAk1ehETHDMwm8iJlZXF3VbtqslB6CbuSAG4kX8NfVdEaGCZLlJaYl
 tEJJJeNBOphUDPC92hPZJXxttIwaxmhww6DZnL3bD86dp9mZgrI5t69IlqxrnZTVHLvuJtsu
 aCk2yPaXYEHGVZoAvHWX/TznVm/in4QxbBpVEzSL9gPI0jhqdA4KyH4gvItDdsLLBHPmmmT2
 wqMX0UHqOOLr4JsqIvFgqWNroGIFepiHxMGTjeBsuvsbXHXpzPxz5VBXeCEeSHmeFn1oKjyN
 /9Iy/zcMeEcmAgYuYRLE4FtkfA06ezpquII1Q9jBnjKMw+mB748cHmL2c5D6v9EyrND4FLkX
 0WS5p9FNL/PNM68SAwdIw8sb+Ki0/AIm2COvKpvfxigvHd6rOidTEFfHxiQkygDfrF7B4MSx
 7tzssAh7QHi2AEhNcyLj3wP+mnQfGYMVb4r6sMTDIPx01N5z1ZffdrDByWw7JzWM4dANUwjI
 zm1gqvehu0AlxSYLCdpTSDAjbhHmJADmBFW11tcdV6HrdrygKNl1hNm9zlqHB9eyQ9K0r4oN
 2VmX6GvyX5iI9u1aAl/s2GQ98VpARqE5gruxlFPmGCxo4xEkIDSBDVVBApP1BlxH6Fgkvxz4
 7ySjmroOdovVN+kxTM8ACaJtNS6JeGcNWT+dASPAMmPWZU3CdYgbmlCekJQwyba7QgNaIEra
 AWkECucqUE2CMLIn5AGNg==
IronPort-HdrOrdr: A9a23:0oa9mqkHJBEj/SicibtzR2wwWtjpDfII3DAbv31ZSRFFG/FwWf
 re+cjzpiWE6wr5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQyVxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK6foSizPZLz9P+qjkzEnlv4bjJ2wGd3AQV0iM1XYCNu6jeHcGOTWvjvcCfq
 ah2g==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.91,239,1647298800"; 
   d="scan'208";a="37384755"
X-MGA-submission: =?us-ascii?q?MDHp8zGJ00BJonQFlyxOBwreyxXrUeBvVTaKI+?=
 =?us-ascii?q?4ZBfjVYfP7f9pFcFc6RdwwCEnWc1y0T7Fxg2WTi6LEIzi/xbk1TsiUFn?=
 =?us-ascii?q?87dWYshcXZzvGEsraaktlDiKX5o5zfBJLzYiQgzgMRyhu5ijxR7VoyOR?=
 =?us-ascii?q?BhKh/6nhVIJC0X5KelyYEk6g=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 17:56:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1653062189;
	bh=/nVzyQHmcvZy2tMyUPdYmW+3HKd185U+nsyUJ54cRuM=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=NE2sjK7hU63Bp+ycM/3AnMZcVzRybMIGl3JGW8QMcch77hRKFHli53aCOeuKK2Y+n
	 z1KeJnkHroi5Jwla5dsrMkFqrHZj/gdadj98ewcgctdFccf3TyolaK8Ceh4MX867tw
	 rYGmZc2AvFWEYqRkpOH+tWCG71NSibmq1NO/rQPY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.155.23]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MdfCH-1nITFs0n7B-00ZbOM; Fri, 20
 May 2022 17:56:29 +0200
Message-ID: <46c9b89a-a97f-1955-e231-de42be1d8e35@web.de>
Date: Fri, 20 May 2022 17:56:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-GB
To: Phil Edworthy <phil.edworthy@renesas.com>, linux-clk@vger.kernel.org,
 cocci@inria.fr
Cc: Julia Lawall <Julia.Lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
References: <20220517133556.6934-1-phil.edworthy@renesas.com>
 <c1d5d00d-d770-530b-abfa-0c1f462e5f22@web.de>
 <TYYPR01MB7086773272C8B95C344E663FF5D39@TYYPR01MB7086.jpnprd01.prod.outlook.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <TYYPR01MB7086773272C8B95C344E663FF5D39@TYYPR01MB7086.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:njqB4nr28JF7v2W39vkf8zmZk46NuLeDETISXZsLy52JbizfZNa
 mszmwlYStj8CF43jcelvpUntkbT2RPnuo+reMzq9acj7m8KLqcbCNwWLcRjTGXrXBtSnRNn
 ltH120wPwYKs81pOYzQxkGLGQ2LoauCbD/SpBOe3THmMKchK2tBHJsoZl7KFuG1pwU8akZo
 v8zTKoNgjUKCxYWDg+hXQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SDADUYobEF8=:kjniT+NgLLNnrMlLa2O1gV
 GKZ1zyxx7gKQWSVxvwr1QcOaTUgw1mChMmwL1i1VeQ7TwW1Kq0auJNPvQ5rJH3VyHhLJsVuGn
 ZqOlfyPyGtu2sQbs05+337nYzha4EpfHDMlhU2eXoAfrZ88H5vQb7vjSOimEZdoKJC+iCDcWo
 15KpTStD+84nXO5lL6D6x4H2yA/8W39DSTDSum2bIS2J/CFAB2ujMteV1uSIO3E8peAZfmZqR
 lx8BfN35LXCANykInIAkHwlGO9eWNUErbYRQIkhSifa1VKUlaOCjFJ3zvscU6SAjEk2VirKag
 c/umIuxkeSCv+veTjPgFD6IcBORPfP2aYO0vIRCnxjyJ6t7xt2Mkn3ttWf2MGj0RYavSNIGZ+
 RboEeT8vm1LW3CHfUY/J4WVJOIE7vP5JXVELvTTk5yaM+4HLqzTVS3uYQKStncUZUlAAAQRTg
 V+mnCjUr4wsNETfUHE4SS61Jy+tGsvo+6rBKbn8dyaRAp7VoWm58EhDOPm4liAHR/LMi6AppX
 En01xP3HJUbXoCXbbUXjIctcBCVLFPz0GBHdR+agDb3pVkly7YFeJ9G9J80qMIVTj4qDEBj9m
 FcU6jEgFiv/5hrqLDvjt8g8T/ag3wczYVLi0NxI301yvI6FZ0w2MGpf/juxnaopiTUre7jLIS
 bG86QXZVwtSzedQ7zAuu8u8pH6Ld5wLsdxj1CRQUrw7bgMjphZjtrdMpO5tv8ylMSFjOJ/Kdi
 7T/afsbFwYnqGRnY5Q+rggb5oMPa9VJWRy6HrZbJc7yzn4pkKWTvlpvACNsg9lwQt/o8jQY+J
 c8A9whIR/2yaCDboYUt96DNY9/mQzsV1r2KltHW1yeAxk4nht8QvLylnFf/xVvoQIKugCpaG5
 4O34TARFvInf9BERT5vgfNrrTCA14auVF+sQe4KB7kYcV9vJdNHhe7GNULyuKNEfM4XxsbUk7
 y2IvgdsZOj+bVQT7shUypsbvZfbXE/UkCS92tauWs0HWodSQ6zcxlakz6h3UL0ekdkwJOLG1J
 aTzKU+zC1GiZywQ/50KyyXB3E8TEqjWOzPoDhdIOptsCemt3IQxkEpAV/Y01rMP8vGa8sGffG
 J95CfFVG48FHSWlO5gcqTU/4hda0td0x+KjU/FShDB8D8PBDUfnwRTnUQ==
Subject: Re: [cocci] [RFC] coccinelle: Add test for unnecessary check before
 calling clk_disable_unprepare()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 406
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-05/46c9b89a-a97f-1955-e231-de42be1d8e35%40web.de>

>> I guess that you would like to mark the curly brackets also for deletio=
n.
>>
>> How do you think about to handle simple and compound statements with yo=
ur
>> source code transformation approach?
> Since we only want to transform code that just calls clk_disable_unprepa=
re
> and nothing else, we tend not to have much code like that, but point tak=
en!
> Sorry, but my coccinelle skills are only a few days old so I'll need to
> work out how to do that.


I suggest to become more familiar with applications of disjunctions also
together with the semantic patch language.
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/82e87d4b0a9c978b00151=
1270c652a93e72fe64d/docs/manual/cocci_syntax.tex#L1039
https://github.com/coccinelle/coccinelle/blob/ae337fce1512ff15aabc3ad5b6d2=
e537f97ab62a/docs/manual/cocci_syntax.tex#L1039

Example of SmPL code:
(
-if ( \( !clk \| clk !=3D NULL \| !IS_ERR(clk)=C2=A0 \| !IS_ERR_OR_NULL(cl=
k) \) )
=C2=A0clk_disable_unprepare(clk);
|
-if ( \( !clk \| clk !=3D NULL \| !IS_ERR(clk)=C2=A0 \| !IS_ERR_OR_NULL(cl=
k) \) )
-{
=C2=A0clk_disable_unprepare(clk);
-}
)




By the way:
Would you like to add a SmPL rule for the operation mode =E2=80=9Ccontext=
=E2=80=9D?



>>> +@script:python depends on report@
>>> +p1 << r.p1;
>>> +p2 << r.p2;
>>> +@@
>>> +
>>> +msg =3D "ERROR: clk_disable_unprepare already checks for valid ptr so
>>> +check on line %s is not needed" % (p1[0].line)
>> I imagine that it can be a bit clearer to split the message into two
>> sentences.
>>
>> Can a line break help here?
> Sorry, I don=E2=80=99t follow you. Perhaps you could make a suggestion f=
or what
> you want?


The support might be unclear for multi-line messages.

How do you think about the following code variant?


coccilib.report.print_report(p2[0],
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 "ERROR: clk_disable_unprepare() already checks fo=
r valid pointer. Thus the repeated check is not needed on line %s." % (p1[=
0].line))


Regards,
Markus
