Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB00C87FC5
	for <cocci@archiver.kernel.org>; Mon, 21 Jul 2025 09:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Z/2dSa95SPKhQNOa/Wk+93nr4Yr6rrhYBrcgVxBayr0=;
  b=AeW62FHL2X8CnRGkRj19Bo27qg9qZGGAPJkuQffuXsAucJN3dDRY5M++
   1QtS44R7iFyAIQ0PDUrgZ3DUva7qzXTZD91G8ahKnxd9Tm/nsV4van+EQ
   1Y5mfJr0yDhgRKlY5ReOlSpLli6zrKbnUjIyu0ZH2Y9HszAHKtQWGE7Ts
   k=;
X-CSE-ConnectionGUID: kaVlw6dbTIqzsN3h9bkU+Q==
X-CSE-MsgGUID: DsfaB30XRgKgkirhV6pgsw==
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
X-IronPort-AV: E=Sophos;i="6.16,328,1744063200"; 
   d="scan'208";a="232437726"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Jul 2025 11:51:09 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9BD4EE0264; Mon, 21 Jul 2025 11:51:09 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id C7E42E0171
	for <cocci@sympa.inria.fr>; Mon, 21 Jul 2025 11:51:04 +0200 (CEST)
X-CSE-ConnectionGUID: O60g925BR2KR9SphLrcWCA==
X-CSE-MsgGUID: OmUy0bppTWeLpzKE5nzaVA==
IronPort-SDR: 687e0d88_ZoNE4ZkMmDQpE3t06l7GZkMvBP9XkuTM+SWXYqr3N6WU25g
 W8ZVldj//LwKN714zmvmrWKKpJ5T5idFc3ZIIcg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HqBQDrC35ogAwR49RaHgEBCxIMQIFICwKCQoEGVDMEC?=
 =?us-ascii?q?0mEVY9QgiSEO4c8h1SIeINSAg8BAwENTgECBAEBAwSFAAKMEwIeBwEEMwYOA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABATsHDgoxhXsNS?=
 =?us-ascii?q?QEQAYIHAYEkgSYBAQEBAQEBAQEBAQEdAkdEAQEBAgEjHQEBEScPCxoCJgICV?=
 =?us-ascii?q?gYBFAEBgn6CIgEGEAEDDiQHr0OBMoEBggwBAQbaXh8sIlmBZAmBGy6FbYJkA?=
 =?us-ascii?q?YYnhDwnD4FVRIE8C4J4PoRDg1uCaYImgRaDZIZyjhBSeBwDWSwBVRMXCwcFg?=
 =?us-ascii?q?SBDAyo0MSNLBS0dgSd9gwqBDoQnK0+CInWBeUEZP4NVHgZtDwaBGBpKAgICB?=
 =?us-ascii?q?QJDRXdAAgELbT03CQsbBj2SYYYlpXChQzQHgjiBZ4FkDJ9rBhMvg3EBk18OB?=
 =?us-ascii?q?pMEmQYiqR2BfiSBXDMaJIM2TwMZD44hhDPBAkE1PAIHCwEBAwmFRgEBhRaEZ?=
 =?us-ascii?q?oFLAQE?=
IronPort-PHdr: A9a23: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
 /4g3r7ya4geZNWTM6NKdVRw2ojHSRO4YA==
IronPort-Data: A9a23:NsRacK07JfCoclVQ8PbD5Q11kn2cJEfYwER7XKvMYLTBsI5bpzEOy
 WRJCGvXaPrbZTOgeNsgaorl9B8O7MOEzdZjQARv3Hw8FHgiRejtVY3IdB+oV8+xBpSeFxw/t
 512hv3odp1coqr0/0/1WlTZhSAhk/zOH/ykVbOs1hlZHWdMUD0mhQ9oh9k3i4tphcnRKw6Ws
 LsemeWGULOe82Ayazx8B56r8ks14ayt4mtA4jTSWNgS1LPgvylNZH4gDfrpR5fIatE8NvK3Q
 e/F0Ia48gvxlz8xCsmom6rMaUYDRLjfJ2Cm0hK6jID/6vTqjnVaPpcTbJLwW28P49m6t4wZJ
 OF2iHCFYVxB0psgNwgqe0Iw/ylWZcWq8VJcSJS1mZT7I0buKxMAzxjyZa2f0EJxFutfWAlzG
 fIkxD8lSU7biLPsnZiBEMpW1/87LO3xN7w0kyQ1pd3ZJa5OrZHrRqLX+ZlH0T12is0m8fT2P
 ZNDL2A1M1KZPFsWYD/7C7pm9Ausrlz2aT5FsxS4oaQt4m7c5BN82v7hPbI5f/TQHp8JxRnH/
 jiuE2LRJRQnJYSV0SK5zX+Inv3ssH79SossPejtnhJtqAbPljRIWEJ+uUGAif2wlUe6X/pNK
 kke4CNorK4o9UXtQMOVdxa/q3WFlgUNXsJZVew88gCEjKTOizt1HUABSSNdLsMrvok6SFTGy
 2NlgfvOW2Rg4efIY0jH1Y3FliuyHTIeEkQrMHpsoRQ+3/Hvp4Q6jxTqR9llEbKogtCdJd0W6
 2/SxMTZr+pK5fPnx5mGEUb7byWEirWhc+LYzgDQQ37j8Q5zIoKoD2BJ1bQ5xacYRGp6ZgDf1
 JThpyR4xL5XZX1qvHLXKNjh5Jnzu5643MT02DaD5aUJ+TW34GKEdotN+jx4L0oBGp9bJGSxO
 xGI51kJtM470J6WgUlfPNzZ5yMCkviIKDgZfqyEM4MmjmVZL17erXowDaJu9zq3zRJy+U3AB
 XtrWZ3wXS5BWfsPIMueRuAb1qRj3S1W+I8gbcCT8vhT6pLHPCT9Ye5dbjOmN7llhIva+lm92
 4gFaaOilU4FOMWgOXa/zGLmBQpaRZTNLcqm85QPHgNCSyI6cFwc5wj5mOx9INU/xPUKz48lP
 BiVAydl9bY2vlWfQS3iV5ypQOmHsU9X/Cxlbx8/d02lwWYiaouJ5aISPcl/N7o++eApibY+Q
 /AZco/SSr5CWxbWyQQ7NJPdlY1FcAj0pASsOyH+XiMzUaQ9TCP0+/jlXDDVyg8wMgSNu/ED/
 oKQjjHgfcJbRiBJLtrnV/a0/lbg4VkfgL1TWmXLEPlyeWLt0tNYFA3svNAKIuUnCxbK9h2F3
 Sm4XDYaoujspdcu0d/r3KqrkaagI9FcLGF7QVbJyKmQDjbL2Fajzatrcve6TRqEWEzaoKydN
 PholdfiO/g5rXN2motbEYcz65kh5tHq9oRo/i49EFrlN12UW65deF+Y1sxyt4pI9L9TmS2yf
 mmtotB6G7G4CPnJIW4rBjgOT7q8jKkPuzzo8/4KDl3w53Z38Jq5QExiBUSwpxIHHoRlErEO4
 LkHg9EX2TydmxBxE9ehjwJozUquAEEEcZ0assA9PNe2pCstkkpPcL7NOB/QuZuvUehBAmMuA
 z2ThZfBuYhi+1r/QyIzO0Tgjet5rrYSiS9O124HdgiomMKap/oZ3y9x0DUQTyZJxE55i8Z1N
 mxaNhB2F56v5BZtvtBIBEq3KjFCBTqY203/8EQIn2vnVHuVVnTBAWk+GOSV9mUL2jh4Uh1E2
 oqH2UDZUTrOV+Pg7BsYAEJKhaTqco1sy1fkhsuiIfWgI7A7RjjU2omVemsCrkrcM/Mb3UHoi
 7Fjw7dtVPfdKyUVnqwcDrua35Q2TDSvBjRLYdNlzZMzMVDsQhOA8hnQFBnpYeJIHeLAzmGgA
 c83Js5vaQW35BzTkh8lX5wzM51Gt993wuEde4HbB38M6JqeiTtLjKj+1AbDgE0TftE/tvpld
 63wcWqZH32ylElkvTbHjPN5N1qSZfgGYwzB396JztgZKqJbsMxRdRAd77jlmVSULwptwDyMt
 izheaL97rJv2KZsraTWA4RBAAS4c+3ycOGy9CGyrNV8QtfdOujetw4uiwfGPiYHGZAzSthIh
 bC2n9qv53z8vZEySHL8t6SaMqt0ufWJQ+tcN/zoIElgnSetXNHm5z0B8TuaLaNlvcx85M79Y
 SeFc+q1KMAoXulCyE1vayRxFwgXD4L1ZPzCoQK/t/G9NQgP4zfYLd+I9W7bUk8DT3UmY6bBM
 w7Tv+qiwvt6r44WXR8NOKxAMq9CeVTmXfMrSs31uTymFVKXu1KluIb5tB8e+DrOW2ilEsH73
 Mr/fSLAVi+O4YPG8NIIlLZJnEwnPC4oy614NEcQ4MV/hD2GHXYLZ7ZVe4kPDpZP1Df+ztfkb
 TXKd3EvEjj5QS8CSxjn/dD/RU2KM4Ti4DsiyuABpCt4qhtaBb9sxJNk8Tp8pWh7cH3vwYlL7
 D3YFmLYZnCMLlNBHI7/JcBXRc94y/mcyn9gFYXVjZnpGxhHaVkV/CUJIeeOPBAr1+nSmU+NK
 WVdqaWohq2kYRaZLPuMsEK51P3UUP0DAtnogeqyLA7jhrim
IronPort-HdrOrdr: A9a23:W1rB4KN4Opkfd8BcTuijsMiBIKoaSvp037By7TEUdfRUGvb2qy
 ncpoV96faUskdrZJhOo6HjBEEfKUmslqKdjbN9AV7AZnidhILLFvAG0WKK+VSJcEfDH4Vmu5
 uIBpIfNDSGNzlHZKjBjDVQWOxQpuVvuJrY/Ns24U0dNT1XVw==
X-Talos-CUID: 9a23:w2jscW15UQ/pShph6x3u0LxfPZ59fSyHkV3qeWyCWF1xSJmPQmC70fYx
X-Talos-MUID: =?us-ascii?q?9a23=3Ar5O6VAxWx2gXx5c/c9lv05gpkwCaqIOrNVFVm40?=
 =?us-ascii?q?eh/aJETRiGBrAiia+fKZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,328,1744063200"; 
   d="scan'208";a="232437702"
X-MGA-submission: =?us-ascii?q?MDEOcuogt81H/4vJ+IZwW/51E+Zj44q4QZwSFK?=
 =?us-ascii?q?pX1U2zNj4bCpQgrjeNIXJMtd1CvMoM+tIOixjEIMMR/LAJu/s8Zo0VE+?=
 =?us-ascii?q?5WBK99aPRW3cb2KCH9FQz0OGIAVUReZxgrjci7S7RcWXeZHXd+bygBvC?=
 =?us-ascii?q?Haf1YFECujLhP96VXuDFKA7g=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 11:51:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1753091463; x=1753696263; i=markus.elfring@web.de;
	bh=Z/2dSa95SPKhQNOa/Wk+93nr4Yr6rrhYBrcgVxBayr0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=kcguodyqLvYX61vugBKfrnDKtqKPeFk8S1+ZULrjLqfoS2ktAVRSSLsFQN2HU0Vq
	 WEltmupwOaItvCcX5lHsJtNq/CZ9ddOaTxeZXoNtC5Aa4R/rHxQM+o5B46O9qHg90
	 A98yT9lHk4BOsJ4pa96Tdj7gFLZ3UD9sFqmVu/LsLxn9ypkfMnHSiv6Ebk8b11rSV
	 I3r4qYuhok1GzOVxUMFhYNJkrPmW2mMM5Ry4sixE4ff/hLBwwjwrPPJ+hgQ6BVDbv
	 95VIMQVMs6Y7rptyQadVgDxX1aSFPdJ6jTEx06cZxksuGj+U2nbzndG5ROtYo2L2H
	 NbpY4/vm4VsND/K/gQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.235]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N7xeb-1uiAx20ckt-00w6dA; Mon, 21
 Jul 2025 11:51:03 +0200
Message-ID: <9154fc36-842b-4797-9b55-397cfdcba283@web.de>
Date: Mon, 21 Jul 2025 11:51:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <0830325b-6697-49d1-a0a4-d06814c6450f@web.de>
 <21f78cc-6034-2b33-c2fb-cdf6d3694d2@inria.fr>
 <fafd85e8-9d04-401f-a4a5-d4286a911264@web.de>
 <alpine.DEB.2.22.394.2507201608390.3477@hadrien>
 <bf7d6619-92c5-4471-a6fd-df4af8b97e39@web.de>
 <alpine.DEB.2.22.394.2507210747070.18950@hadrien>
 <6fa377f7-0612-42aa-afbc-cdeab8bea314@web.de>
 <8a4b47e2-725e-769e-6bb-43e01113f9fa@inria.fr>
 <52ce78f5-8141-46dc-9ad0-5cbfedfd92a1@web.de>
 <cd40be57-cdef-7834-5c8d-eda49eb3a8b@inria.fr>
 <9083cb34-5f8a-43d9-b908-43a9fe2a4281@web.de>
 <4752963-ce2-3e23-fe61-9cbd1acbbdc1@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <4752963-ce2-3e23-fe61-9cbd1acbbdc1@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:sya/NenFxB1pMenU9orwsLJDZeLS4u8PoNk4hXU6R6r8XUBWvu0
 mhDrXiF/49KDPotrOaHXncCSDF1bMB2476KOsY5V+rA1xv5kihXOOkXdSzNkXhaHM/BSlCr
 e5ZdJEqsQWdoRLDc9ct1/lfVD7/dPfAmq8XWpYEwiUO3sCILgH8ednjRExUro2SOVxnWnEN
 P1YAWZ5803Hb31LPkwUAQ==
UI-OutboundReport: notjunk:1;M01:P0:C/oLesNhvos=;i4oq1szEYvPUO575aACOME3C3ID
 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
Subject: Re: [cocci] Reducing parentheses (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2892
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/9154fc36-842b-4797-9b55-397cfdcba283%40web.de>

>> Would you find it really easier to clarify known data processing challenges
>> with the help of another SmPL script example?
> I at least understand th script.  But I don't kjnow what problem does it raise?

Can you recognise development concerns better from another SmPL code variant?


@adjustment@
expression e;
statement s;
@@
-if
+my_result =
    (e)
+&& true;
-   s


Regards,
Markus
