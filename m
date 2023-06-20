Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 613D2EB64D7
	for <cocci@archiver.kernel.org>; Tue, 20 Jun 2023 12:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Jeaf7Sscn63PdMrr2gaRXuClTptMcu+EV7f2/cJeeO8=;
  b=g8A+roQVxIkN9IFDvJOoAI48jkpD7H1gjZKd9xTAD/l0WKTSifm4r4P5
   wGrzi3/Qanz855qbe0VK1MH9R77UA3W9ECB7vADXgRMgn8wEo46B+n9ot
   /p9RMcEv2BkZTb3Ef1LWqxOo06PXk300K7HCPl90LSs9TWZ7g8ez0Qurc
   Q=;
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
X-IronPort-AV: E=Sophos;i="6.00,257,1681164000"; 
   d="scan'208";a="113765991"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Jun 2023 14:15:48 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 34F5CE03AE; Tue, 20 Jun 2023 14:15:48 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 25F3AE0157
	for <cocci@sympa.inria.fr>; Tue, 20 Jun 2023 14:15:45 +0200 (CEST)
IronPort-SDR: 64919870_uQ7/2WsyDwtSDrqkv3j/ClWLerqIPCM9Wk9UL/pDp69nqPH
 Fa3+sU4lBJwXbcX/5jSF/3eAT3MjpZwrrfXqYog==
X-IPAS-Result: =?us-ascii?q?A0GkCQDkl5FkhwQP49RaHgEBCxIMQIN+eFMwBAtHhFKPL?=
 =?us-ascii?q?YInhDaHModFiGyDFj4PAQMBDUEBAgQBAQMEgUyDKQEJAoYAAh0HAQQ0EwECB?=
 =?us-ascii?q?AEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQFAQIQAQEBIxcHDhAnhWgNgjciG?=
 =?us-ascii?q?WSBCAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBEgJHPwECAgEjBBkBAREnBAsLD?=
 =?us-ascii?q?gwCJgICVwYBDAgBAYJ6gigBAw4jB68ufzOBAYIIAQEGnA4fLCJVgV8JgRUtj?=
 =?us-ascii?q?S8JhCgnD4FVRIE8DIJHMT6IH4JnjiyFZQeLOYEob4EegSJ6AgkCEWeBCAhfg?=
 =?us-ascii?q?XJAAg1VCwtjgRyCUgICEScTFAVNeBsDBwOBBRAvBwQyHgkGCRgYFyUGUQctJ?=
 =?us-ascii?q?AkTFUEEg1gKgQw/FQ4RglorNj8bUYIBJQQOAxkrHUACAQtwPTUJCx8GJgEeA?=
 =?us-ascii?q?imBVzBYcApHo34ipjegWTUHgjCBW4FdDJ8cBhMvg24BkyYOBpIvmBkgqBiBe?=
 =?us-ascii?q?iOBXDMaJIM2TwMZD44gGYQOj0g/NDsCBwsBAQMJhUYBAYYAAQE?=
IronPort-PHdr: A9a23:uBYnmRckdJtf42DWfbX7YDeKlGM+wNTLVj580XLHo4xHfqnrxZn+J
 kuXvawr0AWUG9mAtrke2qL/iOPJZy8p2d65qncMcZhBBVcuqP49uEgeOvODElDxN/XwbiY3T
 4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx7xKRR6JvjvGo7Vks+7y/2+94fcbglWhDexe7x/I
 Ru2oAneqMUbhZZpJ7osxBfOvnZHdONayH9yK1mOhRj8/MCw/JBi8yRUpf0s8tNLXLv5caolU
 7FWFSwqPG8p6sLlsxnDVhaP6WAHUmoKiBpIAhPK4w/8U5zsryb1rOt92C2dPc3rUbA5XCmp4
 ql3RBP0jioMKjg0+3zVhMNtlqJWuBGvqRJwzIHafY+bKvR+cKPfctwGSmRMRdpRWi5bD4+gc
 4cCAegMMOBFpIf9vVsOqh6+CBGrCuz10D9IhWL23bYn2OouFQHG0hYgH9MIsHTbsd74M6AcX
 vqvzKnL0DXDdOla1zj56IjGaBAhoPeMXb1rfMvf10YgDBnJgUiOpoH8OT6ey+sCvXSB4eV6S
 eKvl3Aoqxt3ojW32ssglofHi4IbxF3Y+yh0wZs5KcG5RUB0b9CpEIdduj+bOoZ5Xs4vXW9mt
 Dg+x7AEupO3YCgExpsoyhPDafGKbo6F6Q/gWuaJOTp0mm9pdKylixqs70StyPfwWtS03VpQo
 SdJit3Bu38X2xHd98SLUPhw80a71TuM2Q3e7PxPL1oumqrBMZEhx6Y9lpoNvkTHGS/7gED2j
 KiLdkU44OSp5froba78qpCBKYB4kgD+MqIwlcyjGek0LBUCU3aB9eiiyrHu/1f1TKhKg/Esn
 aTVqJXaKt4apq69DQ9VyIEj6xOnAjmhytsYh3oHLE9eeB6dgIbpP1/OIOr5Dfe5jFShizlqy
 O7dMbH7H5rCMGDPkLH6crll8U5T1BIzzcxD55JTErwNPer/WlXtu9zAEh85Lwu0zv77B9V6y
 owRRWOPD7SCMKLStF+I/vggL/ONZI8Tojb9KuIq6+TgjX8jyhchevyEx5ocIE+4E/liLl/RN
 XHridwAOWMLpRYlCuH1iFCPVTNJIXC/Q/R4rjo8A4mnJYbFXIGkxrKbjwmhGZgDQ2lcCU2XW
 VrseZ+FXfhEPAebOMx8iXopUba7Soku/Q6jvkn2xuw0faLv5iQEuMe7h5BO7OrJmERqndQVJ
 8GU0mXXCnpxgntNXTg9mqZ2vU16zF6Hl6l+mf1RU9JJtLtSSglvE5nawqRhDszqHBrbd4KsQ
 UylX87gLDU/VNM3zPcRbkw7F9jxxgvb0X+SCqQO36eOGIRy96vd23brIMMo7n/c17Q6yXQiT
 NFOM2KOmaN1sQTeVMbSi0vMsaGseOwH2TLVsmeOyW3bpEZDTAt5SrnIR1gaYVbK68v07AXOQ
 tdCEJwBNQ1MgY6HI6pOMJjyiEleAe3kM5LYan6wnGG5AVCJwKmNZczkYTdV2iKVE0UCnw0Jm
 BTOfQEjGiespX7fBz1yBBruZU3r6+x3tHK8SAc90QiLa0Rr07f99AQSgLSQTPYa37RMvylEy
 X08OV+n3M/NTfeEqRBgeqp0ft43pltKlCrYuwF7Ip28PvV6nFdNOw9zvk7oy1B2EtAayJJs9
 il1ilMvb/7LtTEJPymV1p3xJLDNf2z7/RT1LrXTxkmbytGdvKEG9PU/rVzn+gCvDEsrtXt9g
 Lw3mzOR4IvHCA0KXNf/SEEyolJfrqvZfzJ7yofaz3xqPoGrvzWE199jV45Hgl6wOsxSNq+JD
 lq4NsQABNW1bsEulUKoaB0sI+1YsqI5dZDDFbPOyOugO+BumyijhGJM7dVm006CwCF7T/bBw
 5cPx/zwMhKvbz7nlx/ht8n2ndoBfjQOBi+lziOiAodNZ6p0dIJNCGG0IsTxyM8sz5LqXndZ8
 hakCTZkkIeMcACRcke78Alez0URrlS4lCH+wzE8nzwyr6WZ1TDD2Ky4LUBBYDQUAjA/ywukK
 JP8l90AWUm0cwUl8XntrV33waRWvuU3LmXeR1tJYzmjKmhjVqWqsb/RK8VL6Z4urWBWSLHmO
 ArcEOSi5UJHlX+wegkWjCo2fDyrpJjjyhlziWbHaW12sGKcY8Z7gxHW+N3bQ/dVmDsAXihxz
 zfNVT3ed5Gk+8uZk5Dbv6WwTWWkA9d2eDPo0JjGmS+1/2xsDjWgkvr1ltCtQm1YmWfrksJnU
 ynFtkO2R4Dx1Lmhd89jcFNpAlDU9MdwXI1z2NhV5tlYyT0RgZOb+mACmGH4PIBA2K7wW3EKQ
 CYC39/f5AW2kF0mNH+CwJj1E2mM2sY0LcfveXsYg2huiqICQLfR9rFPmjF550a1vR6EK+Yoh
 S8TkLMv8CJI2bhT/lB3kWPEWO5URBMIenax8nbAp9Gm8PcNPTzpK+LvkhMj24jmVuzKoxkAC
 iygINF4R3A2t5o5aBWWjzXy8t22IoCPK41J8ETFyVGa07gScsNU9LJChDI7azKn+yR7lqhi0
 E0ohdbg4sCGMzk/pvvmREECcGetOIVLvWuyxadGwpTMht/pQc8nQ2RRGsW0Cqj2dVBa/fX/a
 1TeSntl9CrdQ+COW1bEsA9nty6dQ8rtbi/KYiNClZM4HlHYLUhbymj4RR0cmZg0XkCvzc3lK
 gJi4ywJo0T/oV1Kw/5pMB/2ViHeoh2pY3E6UsrXKh0e9QxE60rPVK7WputuAyFV+IGgpw2RO
 ySaYQpPF2QARk2DARjqILCv4dDK9+XQCPC5KrPCZrCHqOoWUPntp9rnyox94zOFLdmCJFFnC
 OAnnFVOVzZ1FoWRmjkCTTAWizOYb8Ofo0TZmGU/pcS+/fL3HQP3sNHWUf0Ia4opok3w3fTmV
 abYnityJDdG24lZwHbJzOJax1sOk2R0cDLrF70ctCnLRaaWm6lNDhddZTkgUakAp686wARJP
 tbWz93v0bstxNs8EVRYThrMns+zZMoFC36wPhXLCQzYUdbObS2O2Mzxba6mHPdIi/5IshSrp
 TuBO0rkIyjFiDTjERyie7Ip7mnTLFlVv4ezdQxoAG7oQYf9axG1B9RwiCU/3bw+gn6i3Y80N
 D9hbwVSo7fW4S4K2p2X/kRe43AjIeTWw05xAMHHJ5xQvfY5W0xJ
IronPort-Data: A9a23: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
 RHyN0Ac5iSM/6w=
IronPort-HdrOrdr: A9a23:HCa5Lq3dRzRmK+UpZe4GUgqjBGwkLtp133Aq2lEZdPUnSL38qy
 nIpoVj6faUskd2ZJhEo7u90ca7Lk80maQFhbX5eI3SOzUO21HHEGgB1+ffKlTbckWSygce79
 YDT0EUMr3N5DZB/KXHyTWZV/A93dKA7KekvuvGyWxxJDsaEZ2Ioz0ZNu6BeHcGPDWu6KBJb6
 Z1bad8zQadRQ==
X-Talos-CUID: 9a23:HbSuKW7YDwXLrOXg79ss9RI4FsAPbFHh8VSJJ2GKOVlsZLa4cArF
X-Talos-MUID: 9a23:nTHW9gnlamsg3DwbpwoEdnpSCO5vsqOWBnspgIgEitKkHy9JFnSS2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.00,257,1681164000"; 
   d="scan'208";a="113765975"
X-MGA-submission: =?us-ascii?q?MDFqFVkMythK330Ed2IQ3iOAAEayuOcYCK9sN1?=
 =?us-ascii?q?+BCzzOEjKLaIipHL7IjBaqrRwmnoUNT+hm5oESWwhPBTJOpRcU3M3xmJ?=
 =?us-ascii?q?5hpIeHNM3XTyrsc51ukCWOdeHNmTR0wwEYHFUR4nwiscPwUSaYAIs+pk?=
 =?us-ascii?q?6ENbghu5aQO0Tokp3g7cYmVw=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 14:15:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1687263344; x=1687868144; i=markus.elfring@web.de;
 bh=Jeaf7Sscn63PdMrr2gaRXuClTptMcu+EV7f2/cJeeO8=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=kTUmqcqIUM29mfcSitUcGBpRVUp8ULWizVMTyoCTbOWomTHhV37g4xGqVo0WgKsGBe4Jy0c
 H+3qlu8ynPeFMr41Lmq4KYTfRBA+MruAcJW3CDin4dGN2KVvooAg6bxs1SNEwv6LQVdH+MzAF
 vKybWaLHLe+vtA7Sakkd+epZhYJMKB0HJsp/dHrJplfr0FzSMvy3BN32noe88wpQ3dzepRypb
 LyUA2R5uVuHvgg7+jlYWVs4rvngCDWbePYxU3dOZEuJMTMMWEBMDnCqV4m1D9o4rojzJ7Cnt5
 IE9xAcv7XZihti4Le/vxFylyESHWkxs32B6N5UXUC+xVDNyhV4cw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mrwrx-1phUpx0MUP-00nabm; Tue, 20
 Jun 2023 14:15:44 +0200
Message-ID: <cfd5ba59-f9f4-8c33-1482-e31cb8af4e24@web.de>
Date: Tue, 20 Jun 2023 14:15:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To: Eric Wheeler <cocci@lists.ewheeler.net>, cocci@inria.fr
References: <b28e953-86e3-a6bb-fc84-1d2794a81135@ewheeler.net>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <b28e953-86e3-a6bb-fc84-1d2794a81135@ewheeler.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:RZ2+MCkHp3THG5meAJCQ9skEDRIDkWsdUBf7JudBMzy380JnysS
 8BCKzdoODN4q/Cfyz6QMBz9EeymLoGJzcaLzeHKx9QGxlzaTwUfPzRGO9zcypSeIeJPmFtm
 uKpBEDCiVw6UCLbVuW6xllG3frCjoV6NhTtGz8dck22p/rHjDevz9bgA5XNQ+BX41gQqER8
 PCh9I8/Q3H0IWZkhvPkVA==
UI-OutboundReport: notjunk:1;M01:P0:irJIkgJAAq4=;PjH4JapUyjpkag03XXhVGw2TpfN
 UqO75Ns6Z4tT5Y4qJozo2bq4XJ2TZpwPiBtjQMjS91wM6gMv9VLU+qkO+QYpRm5i3oCnnb1pk
 DiwQiNZC/u+By1AAh9b1rQ7mWt8GS7h5GPQrgtOyaoLlmb2JYr0sTm2bVC/iJe+EMFlE3QiGU
 O7rCedAetcDJN5DSqqxdB75O0+ODBVsYvZgKlwynkhBeUc7kElwpLHznBf/RJ8cgwdNT0j2Cs
 FW8321hvO4dNhNLsOUqbOLhU3zfj4DL4LzEdBJsGWY4wB8EqjoXGR+kRZiLvvtkOEmeDANWP9
 Wjq9aXMdyEABuRPHAHPhjA3DbZRZdLp3/sD3lprwzEMk/LOk04RRa4ADkV3IPFquKc5+w4qq6
 zl4v1yvk1Gly0rJY5VAqSTGx0xGfB4x6yYF2KVKLDMdvgXjL+yOeyEPZmoQehE7DC8BWyw6IS
 tU9yYmKA30Scqw9mgQXGITmNCq81zBelN7JEV8qu5MMtpT/oISq4yS+ZQYUdU7s1bUMTpZVRr
 Bi2HxxYQZieL2BpbsfKi9UmKluCI3VY3zTzv56/gFdkS4cJ/+cKY2oko+Ai/gCNfONTv6tpgo
 TGoLiV/69CU22oT7XIafuDeHXpxvFI78cnRNvtyZD0IID4l46Yybffp174SUgv7F0iuaZbkfX
 EMNouQ7Kys7YDFoipgseQIS+1Xq+sqhSTElTsqPBnb0JyDTsMj3/YOS3z+eDV5MqqPg3gGLyH
 TY61qYK751tajlkcNER+s7q/jSp1L9ns4JPwnRKTQEIJQKqi1I8HWRFb0o/K4v6nDiyPwifYP
 ZlP/jHLjON2lF9S9A1+iKPCFcFx5M+Evhr+D3C3SWkE02C2fjlSfsIMEpVwq7UmJFVxi2iBp0
 glAa4Ju16kBKhE6BRWJ/0m3DAX+iTJHuW82jzlVdFpnBCmwlbJx+Dsk6thKczv1wsOEB4NUkb
 dubWUJdQcXcs6l0z4J70Xdejlaw=
Subject: Re: [cocci] Strange spatch behavior while patching an array of
 structs
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1200
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-06/cfd5ba59-f9f4-8c33-1482-e31cb8af4e24%40web.de>

> Is this a bug, or an error in my understanding of SML?

I got the impression that there are some factors involved for further possible improvements.

Would you like to try any more SmPL script variants out?

@replacement disable ptr_to_array@
identifier R, X;
@@
+rotor_cal_min(
 R
+)
 ->
-cal[0].
 X


Regards,
Markus
