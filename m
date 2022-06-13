Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD38C43334
	for <cocci@archiver.kernel.org>; Mon, 13 Jun 2022 19:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=QHPMmJQ09Ro6T5XeWt55T/O/C8FeI6s+TfA3trDEouY=;
  b=UFVbgwUdvMiZvINgccfzhjfwJtW8IMbG8iR2ZlolZ/pyebLxszUDZkCF
   3R/IF7/FKfVaKUxtlm6j5GZFIXQffHv3oHJVZOvUElC4mTjr8T5PIW2vn
   E+Q3FAxQhlAK7oRBb7CTzue3ZHIQ72AxCIRKowgx9qEwN5pD3rYBBGjPu
   0=;
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
X-IronPort-AV: E=Sophos;i="5.91,297,1647298800"; 
   d="scan'208";a="40825529"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Jun 2022 21:08:44 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9666FE010B; Mon, 13 Jun 2022 21:08:43 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 6956CE0038
	for <cocci@sympa.inria.fr>; Mon, 13 Jun 2022 21:08:41 +0200 (CEST)
IronPort-SDR: AqXPr/donFrmi1cWGGJ0nCLcAvC3Q0aHmDHwAWiJLZcfKVQQaLB6J6C29i1vQlN+SjazIMULZW
 hSgJtHgrUUFfscSRLMCulJr6DnUcXoKZqxQyao/gi48pHesQy9VJiwNN6bxxPa/7hA0sTiNdkP
 /TPKXpw0GvQVrKHVx3+1wKw/st9bCWDNeDbTwMzv1i4PJZbkyeeogO4nX1PptfG3ghqjDQxVZZ
 W1ZoHmQ+kfHT6cY3MhfGIjPQSGYll7Ii+gFBLGRFe0yCIgKW/mopHjPVCS80VFbIV400FzYaM4
 P1jC4P3P3deVgs8Q91Y+/4Pe
X-IPAS-Result: =?us-ascii?q?A0DOAQASiqdihwwR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?U+CJIEBVi4EC0SETo5ogXcuA2mDOJpDCwEDAQ05BgECBAEBgg6CagoChUcCH?=
 =?us-ascii?q?QcBBDQTAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBEwEBAQwNCQUIC?=
 =?us-ascii?q?gcOEAU2Bl4GZASBSwSBdAs0DYI1KQGDZAECAgEjHQEBESYBBAsLGgImAgJXB?=
 =?us-ascii?q?gEMBgIBAYJ5AYJkAQMNIwcLriSBMYEBgggBAQaBPwEDAgwCQ4I0HywiUoFcA?=
 =?us-ascii?q?waBESyKU4MieicQgVVEgTyCUzA+gQ+BUwMBgV6DVoJlmE4mBA8DGi00EoEhc?=
 =?us-ascii?q?QEIBgMDBwoFMgYCDBgUBAITEk0GHQISBQcKBhYOFBwSEhkMDwMSAxEBBwILE?=
 =?us-ascii?q?ggVLAgDAgMIAwIDIwsCAxcJBwoDHQgKHBIQFAIEEx4LCAMZHywJAgQOA0MIC?=
 =?us-ascii?q?woDEQQDExgLFggQBAYDCS8NKAsDBQ8NAQYDBgIFBQEDIAMUAwUnBwMhBwsmD?=
 =?us-ascii?q?Q0EHAcdAwMFJgMCAhsHAgIDAgYXBgICGVYKJg0IBAgEGAQdJBAFAgcxBQQvA?=
 =?us-ascii?q?h4EBQYRCQIWAgYEBQIEBBYCAhIIAggnGwcWGR0ZAQU2JwYLCSEWBgofCwYFB?=
 =?us-ascii?q?hYDI0wnBQo+Dyk1NjwvIRsKcQYiARsCmThSGQYBAYEBNgIJwzg0B4IUgT2BR?=
 =?us-ascii?q?AyJTpRfBhMtllEOBpF3lmsgjQ2aBoF4gX4zGiSDN04BAgECDQECAgMBAgECC?=
 =?us-ascii?q?QEBAo4dDA0JFYNugQuDVoVMPzQCOQIGAQoBAQMJhUcBAYk0AQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:Pk16QKL+auj1oTemFE+RypMlxSXFcZb7ZxGr2PjKsXjdYENS02BSx
 zEYX23VPPqPNjb0KNskYYux8U1VsMXdyNBkHlAd+CA2RRqmi+KVXIXDdh+Y0wC6d5CYEho/t
 63yTvGacajYm1eF/k/F3oDJ9CU6jefSLlbFILas1hpZHGeIcw98z0M68wIFqtQw24LhXVrW4
 YqaT/D3YTdJ5RYkagr41IrY8HuDjNyq0N/PlgFWiVhj5TcyplFNZH4tDfnZw0jQHuG4KtWHq
 9Prl9lVyI92EyAFUbtJmp6jGqEDryW70QKm0hK6UID66vROS7BbPqsTbJIhhUlrZzqhve5S1
 5IXuoeKFDgmEZ3Pyf5aUkR+DHQrVUFG0OevzXmXtMuO0wvZfnGqz/gG4EMeZ9RCvLwtXicXq
 rpBcljhbTjb7w6y6JeyUOpxnYIOKMfxPYUQkm5tx3fVAJ7KRLifG/WQuIIBjF/cgOhBRs7bf
 sA5WQFQUx6Ycx9qYVgUFYAhybLAan7XKmAE9gvM+8Lb+VP7yAVu2bzpGMjUf9aQTINUmFyZr
 yTI5QzRCRYRP9230iuA6nvqh+nVnCq9Vph6KVGj3vttnUHV2WEZThEbPbemnRWnomyAeM0Yc
 UMPwHcRoocC9x2xCdigeQLt9RZooSUgc9ZXFuQ77iSExazV/xuVCwA4c9JRVDA1nJNnHWRxj
 Tdli/u5WWYw7NV5XFrAru/8kN+kBcQCBUMvDcPuZSgM+d34upwzg3ojpf48Tvfu0bUZ9Rnay
 jyHqm0BLGEJkdIG0q+251+vvt5Bjp3OUxJz+QjdGG6ohu+YWGJHT9z4gbQ4xa8RRGp8crVnl
 CZd8yR5xL5XZaxhbATXHI0w8EiBvp5pygH0j191BIUG/D+w4XOldo04yGggeRoxb5ZaImWyP
 RS7VeZtCHl7YyvCgUhfPNPZNijW5fS4fTgYfq2IP4QVOPCdiifdpX0/PiZ8IFwBYGB1zP1hY
 M7FGSpdJS9UUOxmyia7XeEQzfciyUgDKZD7FfjGI+Cc+ePGPha9EO9bWHPXN7xRxP7a/G39r
 ogOX+PXmk03eLCvOUH/rN9DRXhUdyRTLc6t8aR/KLXcSjeK7Ul6Vpc9N5t6J9c690mU/8+Ul
 kyAtrhwkgeg1SSZc17UOhiOqtrHBP5CkJ7yBgR0VX7A5pTpSd/HAH43e8RlcL852vZkyPIoH
 fAJd9/eUOtCQHLL9m1FP5X6qYVjcjWthB6PZnb0PmJgIsQ4HwGZqMX5egbP9TUVCnTlv8UJo
 4qmilHRT60FSlkwF83Rcv+ukwi8sCFFyuJ/VkfFOPdJf0Do/NQ4IiD9lKFlPMwGbxnOn2PI2
 wGTCBYehO/Mv45srIiX3//Z9d/xHrInTERAHmTd4bKnDgXg/zKukd1aTeKFXTHBT2eqqq+sU
 uViya2uOvMwmlsX4ZF3FKxmzP5l6tbi++1awwBjECmZZlinEOo5cHyBwNUJqaBHgLNU4FPkV
 kWK89hcGLOIJMK8TA9PflV4NLzb2KFGgCTW4NQ0PF7+un198o2HZkMObROCvypQceluO4Q/z
 OZ948Mbt16lhhwxPorUhyxY7T3VfHkHTrlhqZwQRoPm01J5xlZHaJ3aKyn3/JDWN4QSaBZ3e
 GfMifqQnalYy2rDb2E3SyrH091dspJS6hpE+1kPegaSkd3fi/5rhxBc/FzblOiOIsmrDg6yB
 oRqC6GxDaCJ4isum8VJGWyhc+2E6Nt15WSpo2blVkWAJ6VraoAJBHIwM6CB8Sj1NkpCKyND8
 ujwJHnNCF7XkQKY4sf2cVFoobrvQLSdM+EEdN+PR6y4InXxXdYpbmJCq4bFR9sLzP7dXHH6m
 NQ=
IronPort-HdrOrdr: A9a23:Cl0oGKnqE+p7zkpxlCRnLhZN+urpDfII3DAbv31ZSRFFG/FwWf
 re+cjzpiWE6wr5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQyVxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK6foSizPZLz9P+qjkzEnlv4bjJ2wGd3AQV0iM1XYCNu6jeHcGOTWvjvcCfq
 ah2g==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.91,297,1647298800"; 
   d="scan'208";a="40825518"
X-MGA-submission: =?us-ascii?q?MDGJDQE3dt0BK9iIRFuYnpODkUty1QtQuJUIwd?=
 =?us-ascii?q?Jkc0SKg9vjDRknxEY75GqhUQ70HSBZvbtLBNUXOdEtiPly7ZNRppYkoH?=
 =?us-ascii?q?/GfbRHCIJsf0j9dk2Dnu5LxWozhgWGafcUD94UW+9k2ivBQoCTeuKMvm?=
 =?us-ascii?q?00xSs/uOsUSIqd7scI+ouFBQ=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 21:08:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1655147319;
	bh=Vsgm+Sz+Jd7k1XSmvYnXp6oWuX/AocwLUBP0nq5TvDU=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=iSH5zovNqqr2tLWTmztE4J5aWoBm9p08WQfnFWT6Z0R/ZPbTKojsAODJNkdxdulNm
	 SKiH1C+cED7hO9Odp5AHMZW2IYbTpaMxAwciYJ2ilFxKc0XMKU4ADm2gzrUkEl3X1I
	 ZDLO2qAcj5CAaLkv+lZaNkWqVSyt03OdXPzeAiCY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.107.115]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MjxiM-1nKv5r0Dxg-00kNBq; Mon, 13
 Jun 2022 21:08:39 +0200
Message-ID: <c332fcb3-29bc-7f99-f3cf-4f961aabbb5f@web.de>
Date: Mon, 13 Jun 2022 21:08:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-GB
To: =?UTF-8?Q?J=c3=a9r=c3=a9my_Lefaure?= <jeremy.lefaure@netatmo.com>,
 Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: kernel-janitors@vger.kernel.org, Nicolas Palix <nicolas.palix@imag.fr>
References: <AS8PR03MB76033CF2848D03651D6E189093A69@AS8PR03MB7603.eurprd03.prod.outlook.com>
 <a8c3479c-c8f1-da57-23fe-657c2f13872b@web.de>
 <AS8PR03MB76031920B2F9E7A0A7A6A97893AB9@AS8PR03MB7603.eurprd03.prod.outlook.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <AS8PR03MB76031920B2F9E7A0A7A6A97893AB9@AS8PR03MB7603.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jXgtTIviOvw580gHDBT2+5F6G0EwHLUoNUooSoOxBfR/q64zjNH
 vvfm/sCbMPCgKLxgVPM4UW2GfgyVO/P0AKqStM5Ah0sTxD1obLGhsJdES4j30md5rPjCQND
 Z2PtngxQyOcfYEGYqvtHU/5BQ+ZjZp2C8mOXLE5MB2rZHksO7hU2yMCw8uHr0tmhemPNwDA
 0EgKKDyU6mQ9Jwi+vV3aA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CfuWjmMUOFM=:04uoJJwHd5x9fwrPQ/4RG6
 b1jZkgZxKD3yYeiPpzp76Gv8K+GJbxGOGDf9neLry5MbDZK6uBiJDdrAdFW4CORZxmvlSmbNO
 IgjMomi6VeXf6vmuZqC15a1rkTkbbAusIQ89+SHxRMsTiEJ7/a920GC65c0Aac7XHVM6L/iIH
 1FyfH4phRFGMTUDw0gXnKbFz8eubg/drSt/XXArXlsOaysTqbeXug6JKCqj2L73OWHgWg0kP3
 /I3qARJICQ+Phx+8CTlq/CQvKfuJbdbZODfoY+pkrH6+ySTOc1b7NjL4UGDlEWRAdzCmL8sv1
 NKNgSs+yCg7KyS6//g9GijBvoILAPiTfVel8ICnxzRfLzcRieBty2h9d3nV6c/IBJ2QP6sW6N
 i0tjaOw+OVW1YuRy8jWBbuQiAwrhvmk6lljANmrC3A2RZCeAkFziyNb4qJtPiPdUsXWso+AMo
 eWFv37AiBvMzwJQnKoI1IkaHZawE9OmvOjlwDs699KMBa1wMw1ePFXCdM4pCLTkfACeN7lovM
 EkODcfLIcHl2O+5ZzjW+BIxi2xRGAbb/77Cn4kmsriZaNlv80n8QtxbEhvMi+Pn20pBYJBTry
 C3r8PwD4JSBvW3Xsj+NI459zZWlUJ2IyYglFVvfO08SZBYzULDLD0PgcYwFbqIMzE0qrPTUGC
 nIe9QwqaGRwEPlN38fMbGLgLPJwzQlZkatxwTXKXH2teTuYpiFzaLifXWp3rbTP1FMAUTg5pD
 N3c0OZIGr3G+VtBZKD17gL+ec4w/YxvOmLbf+gYfCyb+XtEJtpc2+hMzgnXZjed65iKgw0WFr
 QFKLFsNnXpmGqvzRSNfDJfo7PkhSfMq+t1+P+dTvuaf53rEZ1JYxfuMqrmLs7INpdZTmAkMy5
 H2QftJa0xgGTwYc0+pfQEmSx/zNHhZUKX7n+PIQA3zwH9TcVfqyDSh6EEnaY5MuADHzS7mtb+
 R0kKhLdo2V3Sb33J0ChDOyx9KsXincx6xi7vL3hvTzZtQ0+FAv1MZA+JEwk7le6xGveKrG+AC
 RQqv0GXHKd4mGTk0irfJ330Sr9hJ9xY9N1ld4eGy3lv2FYl0PvXRLx7nIYcOqJQ25ZStPruYQ
 wDuFRxj95Dd/7TOVMFywRygtK1DpoAJQO4UEDj2jHKvc63X3s0WygBrYw==
Subject: Re: [cocci] [PATCH v3] coccinelle: Extend address test from ifaddr
 to every test expression
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 442
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-06/c332fcb3-29bc-7f99-f3cf-4f961aabbb5f%40web.de>


>> A)
>> I would like to point out once more that no questionable places were ma=
rked
>> by the software =E2=80=9CCoccinelle 1.1.1=E2=80=9D (OCaml 4.14.0) in th=
e following source code.
>> https://lore.kernel.org/cocci/da86bc36-36af-7bd7-6bee-861e160ba6a4@web.=
de/
>> https://sympa.inria.fr/sympa/arc/cocci/2022-06/msg00017.html
>>
>>
>> void check(void)
>> {
>> int s =3D 1;
>> bool t =3D (&s);
>> }
>>
>>
>> Thus I propose to add another case distinction by the means of
>> a SmPL disjunction.
>>
>>
>> *\( &x || ... \| &x \)
>>
> Unfortunately this creates false positives as it matches address-of
> operator outside of test expressions such as in this code:
>
> void foo(int *a);
>
> void call_foo(int a)
> {
>   foo(&a);
> }


How do you think about to enhance desired case distinctions any further?


>> B)
>> I imagine that generated diff output should be wrapped by a source bloc=
k
>> for the operation mode =E2=80=9Corg=E2=80=9D.
>> https://orgmode.org/quickstart.html#blocks
> This patch does not change the "org" mode output,


I suggest to increase the precision for such a wording.



> it only changes the matching part.


The line is changed while it contains a SmPL asterisk in the first text co=
lumn.

The subsequent SmPL script rules depend on this implementation detail
(while rules are available in other SmPL scripts which express a strict se=
paration).


> Anyway, I am not sure that coccilib supports blocks,


Another bit of evolution might be waiting on corresponding development int=
erests.


> I did not find any reference to block in the code [1].


This analysis result is probably appropriate so far.

Regards,
Markus

