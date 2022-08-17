Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 559B7C25B08
	for <cocci@archiver.kernel.org>; Wed, 17 Aug 2022 19:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=EHHsVO7S/6D6nwp/jlQsD1CqVFQNrGP319jmFOuFJqY=;
  b=HSmedxutM20v0OnDPa3W/xVBj/RhWQIoFP/XDzNhTgPBPwsmQTompbal
   tcva+S/Xp9lG71DV4lA3QHKYE4B389Tl/Qbn7wHFMlHmM2BUtQoKAMrLK
   0ZOynLNM4LOEPqly+n53bGWk86a4S1rpHqozsb/u9exB775n0djuj1ym2
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.93,244,1654552800"; 
   d="scan'208";a="49055227"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Aug 2022 21:48:54 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3AB3BE0381; Wed, 17 Aug 2022 21:48:53 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id CD758E0380
	for <cocci@sympa.inria.fr>; Wed, 17 Aug 2022 21:48:45 +0200 (CEST)
IronPort-SDR: P+YP2qet9SufiiAXrR4cVflHL4KgrefFTN5moO+NKd5XAaG630SsTXR5hk00yoRBk0yM2lgzri
 AYTuf4hGrFv2m6k9yg1kMH6gzU5RBAQ0Y7KlC1XJHjz7WV9PGbBJdnTWxx2ae9H+O8b8NoVtv1
 Ydahkk0M4Aq4X+XNa/CPm9I6kglWufz8swe/bYmFoQ/L9D55MLbDmqI6yUEP6WH6kEOIXvOEgm
 lZ+DTIKjqObQplED6JMpQvZi62VfoAbD1z7YlaB6I9AGcqI7vzJdzPdGtpDA+tPczDxud3SE71
 1VLeMEPZF3GtU3qD+uDntxr8
X-IPAS-Result: =?us-ascii?q?A0CsAgAaRf1ihw4P49RaHgEBCxIMQINzgVguBAtFhE6OZ?=
 =?us-ascii?q?4F3CCmEJYcRhx+MJgsBAwENPwECBAEBhQcChHkCHQcBBDQTAQIEAQEBAQMCA?=
 =?us-ascii?q?wEBAQEBAQMBAQUBAQECAQECBAQBEwEBAQwNCQUICgcOEAU2Bl4GZASBSwSBd?=
 =?us-ascii?q?As0DYI1KQGDZAECAgEjHQEBESYBDwsaAiYCAlcGDQgBAYJ5gm0BAw0lB6hcg?=
 =?us-ascii?q?TGBAYIIAQEGhE4fLCJSgVwJgREsj0cnEIFVRIE8DIJ3PogagmWZRCUEDgMaK?=
 =?us-ascii?q?x5CAgELTQUICRcSEBACBBEaCwYDFj0JAgQOA0AIDQMRBAMPGAkSCBAEBgMxD?=
 =?us-ascii?q?CULAxQMAQYDBgUDAQMbAxQDBRgMBwMZDyMNDQQYBx0DAwUlAwICGwcCAgMCB?=
 =?us-ascii?q?hUGAgJOOQgECAQrIw8FAgcvBQQvAh4EBQYRCAIWAgYEBAQEFQIQCAIIJxcHE?=
 =?us-ascii?q?xgbGQEFMicQCSEcCgQaCgYFBhMDIG8FCjsPKDM1PCsfGwqBEiopFQMEBAMCB?=
 =?us-ascii?q?hMDAyICEC4xAxUGKRMSLQcrdQkCAyJpBQMDBCgsAwkhHwcJIiY9BQVfOgEEA?=
 =?us-ascii?q?wMTIj4Cm0MTmEyMUZ55NAeCFoE/gUQMjSWRGAYTLoNkknoOBpF6lwKnWYF4g?=
 =?us-ascii?q?X4zGiRPgmdOAQIBAg0BAgIDAQIBAgkBAQKOHRmEDIotPzQ7AgYLAQEDCYVHA?=
 =?us-ascii?q?QGFOAEB?=
IronPort-PHdr: A9a23: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
 jAqvL3+InFO/oCMlfY=
IronPort-Data: A9a23:WEQ3JaIkkwE++iWyFE+R/ZMlxSXFcZb7ZxGr2PjKsXjdYENS1WYBz
 mEXDGGCO/+IMDD8eYx/b9i19RkA6MXXmtVhHgcd+CA2RRqmi+KVXIXDdh+Y0wC6d5CYEho/t
 63yTvGacajYm1eF/k/F3oDJ9CU6jefSLlbFILas1hpZHGeIcw98z0M48wIFqtQw24LhU1rS4
 YmaT/D3YTdJ5RYkagr41IrY8HuDjNyq0N/PlgFWiVhj5TcyplFNZH4tDfnZw0jQHuG4KtWHq
 9Prl9lVyI92EyAFUbtJmp6jGqEDryW70QKm0hK6UID66vROS7BbPqsTbJIhhUlrZzqhg8BW1
 dBmireJSDh0PYPQqrwlUzp7DHQrVUFG0OevzXmXtMuO0wvZfnGqz/gG4EMeZ9RCvLwtXicXq
 LpBdFjhbTjb7w6y6JeyUOpxnYIOKMfxPYUQkm5tx3fVAJ7KRLifEv2XuIUCgF/cgOhEDN2Pe
 cgdOAZuNkXbUx4ePnpJNLAHybLAan7XKmAE9gvM+8Lb+VP7yAVu2bzpGMjUf9aQTINUmFyZr
 yTI5QzRCRYRP9230iuA6nvqh+nVnCq9Vph6KVGj3vttnUHV2WEZThEbPbemnRWnolKufM9aA
 HM/wysR8Ksc6H7zdtnefALt9RZooSUgc9ZXFuQ77iSExazV/xuVCwA4othpN4VOWCgeGmVC6
 7OZoz/6LWA/4ezJFBpx4p/E9mzvaUD5OEdfPXdscOcT3zX0iK0e5v4lZvVqCqqulMD1FFkcK
 BjV8nFl2t3/YeYh3qm2+xX4niiwupXMRAMv6W3qso+N6wRkeMi6aobu5VWzARd8wGSxEQnpU
 Jsswpn2AAUy4XelynXlrAIlQujB2hp9GGeA6WOD5rF4n9hXx1atfJpL/BZ1L1pzP8APdFfBO
 RGN4VwPvccIZyvxNcebhr5d7ex1ncAM8vy6BpjpgiZmOckZmPKvoX0/OxXKt4wTuBF9wfhmU
 XtkTSpcJS9HVfo+lWTeqxY1iPFyjiE42W7JQ53nhx2ouYdyl1bFIYrpxGCmN7hjhIvd+Fu92
 48Ga6OilksDOMWjPHi/2dNCdTgicClgbbir+pw/XrDZfmJORjp7Y9ePmuxJRmCQt/8I/gs+1
 irhARAwJZuWrSGvFDhmnVg5NO2wA88l8S1rVcHuVH7xs0UejU+UxP93X/MKkXMPrYSPFNZ4E
 KsIfduuGPNKRmiV8jgRd8evs4FoMhim3FrcMy2gaTk5XphhWw2Qpo66JFSyrnFWA3rlr9Y6r
 p2hyhjfH8gJSTNiO8CKOvih+FW84CoGk+VoUkqUedReIR2+8IVjJyHroOUwJsUAdUfKyjeAi
 VSJDB1eqeSU+90599zAhKalqYa1ErIiTxQAQDSBte67bHCI8HCizIlMVPezUQrcDG6kqr+/Y
 eh1zu3nNKNVllh9s716T+Rhw5U46oa9vLRd1AllQC7GYln3WLNtJn6KgZtGuqFXn+YLvAyrR
 gSQ99McNbjQYJHpF1sYJQwEaOWf1KhIy2eIsqlveB33tH1t4b6KcUROJB3S2iZTG7tCNt93y
 +kWvsNLuRe0jQAnM4rdgy0IpX6AKGcMD/cuup0AWda5jw021hddbJaaBiKvuMODbNBFM08LJ
 D6IhfOe1uoGmReYKyI+RSrXwO5QpZUSoxQUnlUMEFS+nIaXjPEA2hAMoy88SR5Yz0kc3u9+U
 oSx25aZ+UlTE/ZUaMl/s6SEHgZcGFuG90a3x1ZheKg1iaW3fjSlEYH/Eb/lEIMlH6Z0YTVRu
 r2VoIogeSi/Z9n/h0PeRmY8w8EOjrVNGsnqh82tWciId3X/jfwJnYf2DVc1R9Db7Q/dSaEJS
 SSGPAq9VEEjCRMtng==
IronPort-HdrOrdr: A9a23:NVaCxaGUqkheYiOSpLqEzMeALOsnbusQ8zAXPo5KOHtom7+j5q
 OTdZMgpGfJYVcqKQgdcLW7U5VoLkmyyXcY2/h0AV7mZniBhILKFu9fBOnZrwEIcheWnoNgPO
 VbAs1D4bbLbWSS4/yKgjVQX+xA/DGdmprY/ts2Ik0dNz2DUstbnnpE4o33KCdLeDU=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,244,1654552800"; 
   d="scan'208";a="49055224"
X-MGA-submission: =?us-ascii?q?MDGu1pZ4tUDdA5FH9dX15zFdkGoYnohppqJonU?=
 =?us-ascii?q?5ft5cYOXCIgW5DUqQOIm2fZSxEqGOdgeFLnpCHECB+KJjL/C/4GVa4if?=
 =?us-ascii?q?HewHUI0wSCrJecakI7RAZBr3Zu1XXaXf8TfWy/PudgQkrrZWX7EwHVoj?=
 =?us-ascii?q?CJIUxKbVBj5957+ENl0QZwQg=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 21:48:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1660765724;
	bh=tN9bI+ZDkL1Wuv1ZfbO19zaWkfQ2cIHFM2g5yy/d1Zc=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:Cc:In-Reply-To;
	b=WE/+nMWijYIfHC/fUoJRDgEcIEWD0kJ9v42GNOJX2AKUVjN1SVgfhZG/isPQApgHc
	 UaK3fGPL6BkuNKCuEUBY1SRxTMg/7nrmMnSZZPklcmri5aBzvnjPW/aOsONevuzaSi
	 K0bA/6LKjOAwJHEwnr7W3M+ysSiRKbpsNILHnMaU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.20] ([93.133.2.60]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MZSBG-1nt20j3wNK-00WkC9; Wed, 17
 Aug 2022 21:48:44 +0200
Message-ID: <92b5eb33-9c76-7e45-7651-6296c9795a67@web.de>
Date: Wed, 17 Aug 2022 21:48:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>
References: <20220816085416.1542114-1-jkl820.git@gmail.com>
 <alpine.DEB.2.22.394.2208161337001.2561@hadrien>
 <29F3BFF3-ADB0-4E8C-BE30-298D0ABB8F1A@gmail.com>
 <alpine.DEB.2.22.394.2208162306410.2625@hadrien>
 <A564705D-53D2-44E9-BAF4-AE99E78B09ED@gmail.com>
 <alpine.DEB.2.22.394.2208171631050.2482@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Cc: Jakob Koschel <jkl820.git@gmail.com>, cocci@inria.fr
In-Reply-To: <alpine.DEB.2.22.394.2208171631050.2482@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:xHKn3MoamVUu3CO+OyWSohmjaOYO8T/UD7xb2E6STAqzcEIO6RT
 KMeLUv1QoBIwwoIGEzQLZCwqr9sWdxzicYotpPi/2aSRlMMbeJ+2SFud4/Weog2LEC7r+12
 KUJ5Rd2V/Lh1WljlRpxYD1MxyhLIXt5XjQUsXucVsJM4zgAbQGu+qsRsTcAuWEJEnE9/eG+
 +urktJ++On0P6MLBf1tpw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:K4iHZeK9ggo=:gn2XVFlFVKtpbjzsqhSSzn
 pbDS4s4qGZCqhdXEIsaz6gvZr4kWkDLjCmyEBqsY3uNXX1xiLKEbl0ZfLlDiEc/spg6Qdim4Q
 RkJ1dfb0ZAA4kGsAQv17gmCjdVDLR2yyepdhBteiG7NbBnxpvPMrNOBqMrNwy3VENnvnw8QzH
 6u8BDK2guRDsXWl3iEZCefDOvF+CzhnPDWeGL6za9D1Qb9HanIb18N2ssvwfcYkXdg688Qvup
 QxOQZ5MuzgTxKJP0svaDmeQCnp8aB7fXP2/M91TdomR0i1xNm85Adh51Z97ImoDx2za4am2CW
 r400Un9NY0hME/vOm5/bB04KIpuSoiGWnPFiF8+vZ872Bch9aY4iQ+xzglqb/Tx+mdBrjR/IF
 2oUmk8CtWggno/JZrN8PG9gx5kTC7MCIkPF/5oZ5M9hdtTmvSxSFQJCZx4ww61LvAL7lUrr2P
 nptooTrFikujWy2DRMreEX74JM8KbzDq91WYCCyst0csmdEi089X1v6ZGievAV3j1PB0r8kU1
 5iH7ed32BK33mGc5bsYDj6xRKjXeehRQw9vli2KkfsCIi8bzyEqMWb42jcS0HmW8KBJ94Yn8V
 wmy68cxvNjRhAjYDaK+PEjqzVGbxgrpOrTLqFNQchr43e2HqTypyJE35AjLkGrI45EKc9S5MV
 2RyELiI6NdgNNaQAzhnR9XxqeWVOrrLQ0/hIV9iPw05R9MFIIHy15Z0+NQt012i/brJzxDky0
 m9x2x93bPdMqiS7yc+6WvO5rEvMEU2IP2/G2iRC6S7+faeROc5vNb3EAFmCu/SI3QBn7MkLoz
 8LrxCYYbRsUxjqoGZStaIypFLqPFnA061b6xYn3Ie0aP3oWMOyXCx4jciJkP/REMKDNTqFCjv
 KcDa5lQHX7Q1Uagx6Vj5ABwzVdgBR2SNiLEpC9nO7R/t4ktxEMSwso0xEYS3DwS/BykA8SisU
 PyT+zlYs6omlZBVDrMuy8ZJcAYkdPxHwtvq8/1WkHv+naAjR4mRfpxzjgGj0yu8uS0Yl3Ki0V
 YqPkmTMM238oi9ny0j1V2e2gdZJ1KcR0cf4CzrulqSSTX349KCGFC4FEttHYsAgrtKrudQLLY
 wkEQAdVHbAHfctII9o3UOXPe8TNQ7nN69DlEmLDXKI+0iblvX6zsS3Qiw==
Subject: Re: [cocci] Working with parameter/expression lists by SmPL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 517
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-08/92b5eb33-9c76-7e45-7651-6296c9795a67%40web.de>

>> I just tried:
>>
>> @main4@
>> parameter list Ps;
>> @@
>>
>> int func1(Ps) {
>> ...
>> }
>>
>> @main5@
>> expression list main4.Ps;
>> identifier func;
>> @@
>>
>>   func(Es);
>> + // add comment
>>
>> but that throws:
>>
>> meta: semantic error: incompatible inheritance declaration Ps
>>   File "test.cocci", line 45, column 24, charpos = 539
>>   around = ';',
>>   whole content = expression list main4.Ps;
> OK, there is a specific context in which this works, but it is only for
> generating semantic patch rules.


I would appreciate further explanations for such information.

Regards,
Markus


