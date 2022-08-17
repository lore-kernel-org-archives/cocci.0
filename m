Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81FBDC25B08
	for <cocci@archiver.kernel.org>; Wed, 17 Aug 2022 19:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=kpR/IcZtNjX+UzLeFNETbKvaWeQkb0I2crEQhz/EJ4k=;
  b=NGrLjI6urP0GykD1z7tbVLYIiKN7/p5LkGA2w7j0KxH9Fd2P0joX58+r
   Q/eHhnU63RZ+D+qpvnm/nL33QHTQ2PTckxWrscUtCcOjPKq9eOJV0ybEu
   54rbVkPmzK3LWNcz2/LaRLVtBiz06EBSvE6GAM5MfIJ0K4gdKZabxXXJQ
   A=;
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
X-IronPort-AV: E=Sophos;i="5.93,244,1654552800"; 
   d="scan'208";a="49054046"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Aug 2022 21:21:31 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 63A0BE0385; Wed, 17 Aug 2022 21:21:30 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 86CADE0380
	for <cocci@sympa.inria.fr>; Wed, 17 Aug 2022 21:21:25 +0200 (CEST)
IronPort-SDR: 7AtMLUEMQP7VzN519dr+ZGb666rEPPYioIfDVYqml3+hnKJffUmFObsdvMdtHlRhcYULEzv1JF
 fjshoBExBiwS1u5KJqiF+ib9s3qv5H43bpQtXYgt8DuqrId1/5mxVNZq4wl9rWCJpjWl84uvpW
 q+E895UBJpoHnvgz3jKoYAb1KbCSbt2a++b8lBKdXM5bN+kMzhU86hDIBIKltf3B8YnHnaw9ND
 WAUUnicmDzW1zWXWqmbLe4JZatDD0Oqt8YnpwJTRl3KYQDzMSFCXJ9edUP9CfWd6b6yniokOzn
 OUtgeMvhkRHDDVqdjFbmfZLf
X-IPAS-Result: =?us-ascii?q?A0ADAwA1P/1ihwMP49RagQmBT4IkgVguBAtFhE6OZ4F3M?=
 =?us-ascii?q?YQlhxGTRQsBAwENPwECBAEBhQcChHkCHQcBBDMGDgECBAEBAQEDAgMBAQEBA?=
 =?us-ascii?q?QEDAQEFAQEBAgEBAgQEARMBAQEMDQkFCAoHDhAFNgZeBmQEgUsEgXQLNA2CN?=
 =?us-ascii?q?SKDbAECAgEjHQEBESYBBAsLDgwCJgICVwYNCAEBgnmCbQEDDSUHqFeBMYEBg?=
 =?us-ascii?q?ggBAQaETh8sIlKBXAmBES2OTHonEIFVRIE8gwM+hESDVoJlmUQlBA4DGiseQ?=
 =?us-ascii?q?gIBC00FCAkXEhAQAgQRGgsGAxY9CQIEDgNACA0DEQQDDxgJEggQBAYDMQwlC?=
 =?us-ascii?q?wMUDAEGAwYFAwEDGwMUAwUkBwMZDyMNDQQYBx0DAwUlAwICGwcCAgMCBhUGA?=
 =?us-ascii?q?gJOOQgECAQrIw8FAgcvBQQvAh4EBQYRCAIWAgYEBAQEFQIQCAIIJxcHExgbG?=
 =?us-ascii?q?QEFMicQCSEcCgQaCgYFBhMDIG8FCjsPKDM1PCsfGwqBEiopFQMEBAMCBhMDA?=
 =?us-ascii?q?yICEC4xAxUGKRMSLQcrdQkCAyJpBQMDBCgsAwkhHwcJIiY9BQVfOgEEAwMTI?=
 =?us-ascii?q?j4CmXtGgQmBMwqUCJt8kWR9NAeCFoE/gUQMnj0GEy6WXg4GkXqXAqdZgXeBf?=
 =?us-ascii?q?zMaJE+CZ04BAgECDQECAgMBAgECCQEBAo4pDQmEA4otPzQ7AgYBCgEBAwmFR?=
 =?us-ascii?q?wEBhTgBAQ?=
IronPort-PHdr: A9a23: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
 hBjfkkLorDCtEtl
IronPort-Data: A9a23:Q1666KCj8AlbrRVW/zzlw5YqxClBgxIJ4kV8jS/XYbTApD4n1jFRy
 zAbDWqAOKyKZ2f1KoskPI+380tQusDRyNVrOVdlrnsFo1Bi+ZOUX4zBRqvTF3rPdZObFBoPA
 +E2MISowBUcFyeEzvuVGuG96yE6j8lkf5KkYAL+EnkZqTRMFWFw0nqPp8Zj2tQy2YjgXFvX0
 T/Pi5S31GGNi2Yc3l08sPrrRCNH5JwebxtF1rCWTakjUG72zxH5PrpHTU2CByeQrr1vIwKPb
 72rIIdVUY/u10xF5tuNyt4Xe6CRK1LYFVDmZnF+A8BOjvXez8A/+v5TCRYSVatYow3YwOAtl
 cdViZCPZhcoEKzcxOo9fhYNRkmSPYUekFPGCX24rNDV0EDMNXfhqxlsJBtvZ8tCoLkxWDwIr
 pT0KxhVBvyHr8e/2rGmUa9Bgso5Lc/kFJwSsDdswFk1CN56EMieH/2Wvre02h93tt9iGPrAV
 /MLdGN/bxr5XCQXBkoIXcdWcOCA3ySjLWQB9jp5v5Ef6G/Yxw1Zy6noKNOTe9qQRMwTkFzwm
 47d12H+Hw1cK9GVjzaImp6xugPRtRuqB7JOSa+gyvJVr02S6G0DVBM2eFTu9JFVlXWCc95YL
 kUV/A8noq4z6FGnQ7HBs/uQ/yfsUvk0BIM4LgEq1O2e4vaEslfFWwDoWhYRM4N75KfaUBR3j
 gfhoj//OdB4mJG4IZ533pSdtzepIzUVIAfujgdbE1JevrEPTKkZhx7CSJNcDbSpktDwEzzqz
 Fi3QMUWgrIOkYgU2q/98V2vb9OQSnrhHlFdCub/BzPNAuZFiGiNOdXABb/zs64oEWphZgPd1
 EXoYuDHhAz0MbmDlTaWXMIGF6yz6vCOPVX02AAxR8d+q2r3piX+Iui8BQ2Swm82Yq7onhe2M
 CfuVf95v8470IaCMPMmPdnrYyjU5fGxSIW+PhwrUja+SsEsKFHepX8Gib+4hi602EkqjawlP
 5qHOc+jZUv2+ow3pAdas9w1iOdxrghnnT27bcmik3yPjOTCDFbIF+ZtGAbfNogRsfLfyC2Io
 oY3H5XQl313DrakCgGJqtF7ELz/BSNmbXwAg5cLLbHrz8sPMD1JNsI9Npt7J9I6wf0PyriYl
 px/M2cBoGfCabT8AV3iQhhehHnHBP6TdFo3Yn4hO0iGwX8mbdr95asTbcVlYrQtsuBulKYmQ
 /4AcsSGI/JOVjWep2VDN8ag9tQ6eUT5nx+KMgqkfCM7IcxqSTvJzdm4LAHhwy8DU3isvswkr
 rz8jQ7WGMJRRwlrAMvMRuioyle94SoUlO5oARnXL9MVdEi1qNpmLCn4j/kWJcAQKEyfl2XAi
 FvMWU8V/LCfrZU0/d/FgbG/g72oS+YuTFBHG2T77KqtMXeI9GSUwbhGDLSCcwfbWT6m466lf
 +hUk6rxPfBbzlZHt41wT+Riwa4kvoK9orhH0kJ7EX+NY1nyUuFsJXyP3M9usKxRx+YF6FXsB
 R/VooFXaeeTJcfoMF8NPw57PO6N4vEjnGWA5/oCJkintjR8+6CKUBkJMhTQ2jZRKqB5bNEsz
 es74ZdE7guillw1P9zAgi0NrzaAKXkJUqMGsJAGAda321RxlQwYOcTRWn3s/ZWCS9RQKU10c
 DWas6r1gegOzET1dXduR2PG2vBQhMhVtR1HpLPYy49lRjYYaj4LMBxtHfAfSwNI0lNY3ug1N
 mUD24iZ40mR128AuSSBdznE98J96Nmx5UH7jVcE/IEcZ1f9TXTDdQXRJs7UlH30MAtgkvxz4
 7ySjmroOdovkAcdwQNqMXNYRzffoRCdO+EMdA1L3yhIInXiXQfYvw==
IronPort-HdrOrdr: A9a23:abNc96FC6DCsJ/SCpLqEzMeALOsnbusQ8zAXPo5KOH5om7+j5q
 STdZMgpGfJYVcqKQgdcLW7U5VoLkmyyXcY2/h3AV7mZniBhILKFu9fBOnZrwEIcheWnoNgPO
 VbAs1D4bbLbWSS4/yKgzVQX+xA/DGdmprY/ts2Ik0dNz2DUstbnnpE4o33KCdLeDU=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,244,1654552800"; 
   d="scan'208";a="49054043"
X-MGA-submission: =?us-ascii?q?MDE+OOe3L0a92ie8F5iIvWXA4ydd2cGIlaRDQv?=
 =?us-ascii?q?7wXg93UxuaFdWtalmNWVDsUqVQonynQh6UgVN0kLEuOZ2z9E7sB42mSE?=
 =?us-ascii?q?n7VGTZZ0iO/zztepnJI6nXLSXQEeefBHia/+v3s2Bx86g4z6ul+juEOx?=
 =?us-ascii?q?PwG7hw8NO15tnwBHpDYxmSmQ=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 21:21:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1660764083;
	bh=er1gC+kbtsm6gmr+NY30PYNnFFv4fe9qEHj9YtVTtk0=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=HgETBOVqqU6QqDjsN8RQJlf5FOuxO9oXgED0OgaHna59Jkkii87YX6LEwJIOcXXPG
	 dw5230wEE1ULi1wTo6edp+QB9BPsCRq/s1eY6YQ2sFkbasEOYmXfVpfo2atAAlJz5A
	 qsbfQVRaDm4Nxf77PHyfCcZXs2ABAJC4/jzXgeTw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.20] ([93.133.2.60]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MsJTC-1nW91d2SYk-00tw68; Wed, 17
 Aug 2022 21:21:23 +0200
Message-ID: <1686c000-31ec-106d-583b-96e8292f26d3@web.de>
Date: Wed, 17 Aug 2022 21:21:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
To: Jakob Koschel <jkl820.git@gmail.com>
Cc: cocci@inria.fr
References: <20220816085416.1542114-1-jkl820.git@gmail.com>
 <alpine.DEB.2.22.394.2208161337001.2561@hadrien>
 <29F3BFF3-ADB0-4E8C-BE30-298D0ABB8F1A@gmail.com>
 <5c4fc14e-bf4e-8bbc-cc9e-0b04c849eca5@web.de>
 <8080D5E0-2491-47A0-AEDD-3EB84661917F@gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <8080D5E0-2491-47A0-AEDD-3EB84661917F@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:e5XVzwoMtABD7fpQf265OazXMpn/MNQBhFHj/WXK0FsB1QhjNwj
 HA0/4EUpIOg5zf7ZzyCnTpqQb2daYYFFqQ73ZEOtvxnIr89V7x2xn79UI9zJDiZEY2+hUXC
 Z1kXXCE0F4bwPAo9YrFggaz4uyQrg1ziFoQk7omNV5Hycv6VCXCMmVAIsfIA5DNxmauvHtM
 JuO1MbaQ0FHtqbRmw48Lw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mpJYT+Qfw6k=:7jxyAHurFzedEPti7xUI4R
 h4MxevL2Sg7ixSQhoseRMo+etOQISRRhQXCI4qiu542fh8ftAEB9EiuuNt7kUr959veWEKxXZ
 HTEm84jDxV1tOgtztea1l0v1yBQTVDvElQbALSWp2n2jm61S6N93Nas5ySSLvw8vkBRs0P3t8
 pritawMvnzWsPX0Kbo3IRKWF7JnasReCOismTAk72bWW5IzZ0cJg65/FNHi/b82VI4kmHGL6c
 1pEFdqtK35AQhebILdsEDBGWMuuWDYoZA0PnkJnF3CtFbCB5zzWIBkidJ5oS8kh4tKmrkA4Hl
 iHGok+iXYJj3zvnV1m3Z3gc48QbPJol8C7zMn8+x04KuqFFOBAQ3pc/3vU1GMLqJ7OwiQAL7I
 kJ7r2+2fZYz36ZU5J+oU8e97jZzChn6rTm1zB1JNHEU62/KtPNaVzOZb5DCzoM7YHn0v7TKVR
 XJhA5qUZT22beO3R1FAp2LT8VelCcPD1CiUNoNLHO6IzNXswRawn4FzvH/L+o0da3shPdkhSm
 wXmmOAyIHRCpQP5vWjcvf44kt5kwYNrrpUTfSDhyWsaLPRJXC9HPaVP/c2U83W4/Irz1k2+40
 pOsdp1yc5b4qyxPxGEhy6s/iegv9tNghhWqcL8+MbCo6wxDgpiOL/KF5ez5OSlKdi/jT1+s5k
 f89SeJK5lJYYrCD24jh0XISTDeZqZ84sAIK8+AFfvE/zs/oPvsDL9IitzU9dhNs45/ayrl6mh
 1NEA4DGtrEB3AwTwnEc6GpX5kJMKOxhnRT7LpgRv+E9UC4ighzN4tPDhZX0qOlP2wTFLSCpLB
 3kWPVwb5I40eh7dquL1HqrldZ5DeSsNRFNhjMbOX3Wp1eXp+UtaExs+nIwCFWbpMg18uMOo0Z
 86T/TobVeWlIf5UtgAZZynTW762ZaOJbbBFGpnz7xSjSJSb1dVXFoQLoIzlhNpBxMKuM+NaAM
 DGIXe/pPr1tZIqqKThJpIkTJirLwi3ndqGN6fRqf9U1Gk2Qgq8v03HOsjQojLruNw3QWp/QMR
 vdvue/2DHE1iXdd0YEWgbA8N/Xk5YSIrwBqHVPRBsDENjzs8WX/7UPWzei7QYPnL7OmlrPVCt
 iClcza0goR+xTd9X8xyNFsied/QfNXcNiQXWoFr/Jqsag87lbesc4aYZg==
Subject: Re: [cocci] match arbitrary argument position
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 516
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-08/1686c000-31ec-106d-583b-96e8292f26d3%40web.de>

>>> looking at the following code snippet:
>>>
>>> test.c:
>> =E2=80=A6
>>>      func3(argc, argv);
>>>
>>>      func3(argv);
>>
>> Would you like to handle function overloading here?
> I'm not exactly sure I understand what you mean here.


I suggest to take another look at the implementation detail that it was sp=
ecified
to call a function with different number of expressions.


> Finally I would like to archive something like this:


You would probably like to achieve special source code transformations
instead of archiving items.



> In the end I want to, for example, turn it into:
>
> void func(void) {
>
>     int x =3D 0;
>     // 'x' was used as first argument to interesting_func
>     int y =3D 0;
>     // 'y' was used as first argument to interesting_func
>
>     func1(x, 0);
>     func2(0, y);
> }
>
> void func1(int arg1, int arg2) {
>     interesting_func(arg1);
> }
>
> void func2(int arg1, int arg2) {
>     interesting_func(arg2);
> }


Will any filters (or related SmPL constraints) be relevant for such functi=
on names?


> Basically I want to flag create the matching from 'x'/'y' to the argumen=
t to interesting_func.


How do you think about further possibilities to choose which function argu=
ment
should be passed as an expression for corresponding computations?


> I was imagining if I could match the parameter list of any function call=
ing 'interesting_func'
> then I can also create a matching from x to that function call and do th=
e rest of the correlation
> in python somehow.


I propose to reconsider also the need for extra scripting according to
the discussed use case.



> However I'm still failing to detect if any argument (arg1 or arg2 in thi=
s case) is used as
> any argument in 'interesting_func'.


Multiple SmPL rules can be applied on demand for desirable data processing=
 results.


> I hope this makes more sense?


It can be challenging to express special imaginations by the means of
the semantic patch language.



> hopefully the example above makes it a bit more clear.


It seems so.

Regards,
Markus

