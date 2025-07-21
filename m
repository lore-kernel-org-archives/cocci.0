Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 321DAC83F25
	for <cocci@archiver.kernel.org>; Mon, 21 Jul 2025 12:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=0S7XpHlhjCvtW65MU0o1N0Um0uST3EQiboqGdVCzy/4=;
  b=GEngz+fgXZWYo7mVIPGavtD8H9yi8mos3mqCGpPMYVEpsOdmOSKbCV69
   SPpCODwH4XWtKA3ILuK1IB4BghGZh1P7kyBKpXQiCjTvyVSx7BGFZafsf
   QNNHeT88+dApZS16Ev7Yt9u24ulkxNLj3lHE794OKP4beWxLtQAQkBh4k
   8=;
X-CSE-ConnectionGUID: hX4OuKiDQoOHjYdfljZ2Pg==
X-CSE-MsgGUID: EJRMn0HCQCCbwX2T2Wn9uQ==
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
X-IronPort-AV: E=Sophos;i="6.16,329,1744063200"; 
   d="scan'208";a="232460383"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Jul 2025 14:14:17 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 45D7EE0CD5; Mon, 21 Jul 2025 14:14:17 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id D7ECCE0171
	for <cocci@sympa.inria.fr>; Mon, 21 Jul 2025 14:14:14 +0200 (CEST)
X-CSE-ConnectionGUID: P/KwnsBuTk6aBLqTVnDT0w==
X-CSE-MsgGUID: wv62/tmSSyyzAJiJlge1eQ==
IronPort-SDR: 687e2f16_cjei//uHQ7e7OZzaWLcEWsYZoJVve93LxIexFaErSZ0TBLn
 mhy85IZTNssXfH7TYKyD1XcaLYm4FODgoujuBEg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0H4BwAeLn5ogAwR49RagQmBU4JEgQAGVDMEC0mEVY9Qg?=
 =?us-ascii?q?iSEO48QiHiCegNVAg8BAwENSgQBAgQBAQMEggyCdAKMEwIeBwEEMwYOAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABATsHDgoxhUEHMw2CY?=
 =?us-ascii?q?oElgSYBAQEBAQEBAQEBAQEBAQEBGQINOkQBAQECASMdAQERJwQLCxoCJgICV?=
 =?us-ascii?q?gYBFAEBgn4BgiEBBhABAw4kBw2vWIEygQGCDAEBBtpeHywiWYFkAwaBGy6Fb?=
 =?us-ascii?q?YJkAYYnhDwnD4FVRIE8C4J4PoJhAgKFOYJpghEVgRaDZTaCM5IZUngcA1ksA?=
 =?us-ascii?q?VUTFwsHBYEgQwMqNDEjSwUtHYEnfYMNgQ6EKCtPgiJ1gXlBGT+DUx4GbQ8Gg?=
 =?us-ascii?q?RgaSgICAgUCQ0V3QAIBC209NwkLGwY9kmKECVeBRRUqjgOFSpFkoUM0B4I4g?=
 =?us-ascii?q?WeBZAyKLo4yhwsGEy+DcRONEoY7DgaTBJkGIo1mmzeBfiSBXDMaJIM2TwMZD?=
 =?us-ascii?q?4k2iR6CMb4nQTU8AgcLAQEDCYVGAQGJfGphAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:T26mgKpZA+eFjM6GcoXtjD0aV5r1eYIsimQD101hICG9Afbo8v
 xG+85rrCMc6QxhPk3I/OrqBEDuexzhHPJOkO0s1PKZLW7bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QEZSWY+eRMbEVt7eY3CCFM5IH3MSN9ryuiNzT1nF3UGhRGttdBktCazpyCSdNNXF77HcCZe
 GhDkErnVCdRUg=
X-Talos-CUID: =?us-ascii?q?9a23=3AZ6XmdmlAanOzV1aNVNtc/a92pAfXOUWa72jWOGW?=
 =?us-ascii?q?lNWU3QZexUGOu/o9Yy9U7zg=3D=3D?=
X-Talos-MUID: 9a23:XdudrgjopFJuQPchfaniwMMpK9k2ueOyDXs2gIQUkuuFFyh/Nm6QtWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,329,1744063200"; 
   d="scan'208";a="232460373"
X-MGA-submission: =?us-ascii?q?MDFDZ2fI/DxHzmJWgxQDn1cMcBNBB1aRc01Hiv?=
 =?us-ascii?q?ST6/7HyEz+19ntRUD39wygO3xRrsPbuapRBXeV5OtropzXpizkhdGAxK?=
 =?us-ascii?q?OodiizahkPW3Swcb8gQgkX30BNoPhvBDtQ7c1WuT44bAHKV/CsXjjcQ6?=
 =?us-ascii?q?6guG0pmXLJswzFQyt/ROUQww=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 14:14:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1753100053; x=1753704853; i=markus.elfring@web.de;
	bh=0S7XpHlhjCvtW65MU0o1N0Um0uST3EQiboqGdVCzy/4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ILatmYTmeG1tHKVGXkERhuvzNFHHUgljX4TncZK/ioJhMqCoJt5pgKyK4mtBYuu9
	 5lt3oMSwGCnX9s+Im5HvbWESnOtruWVONreyOiT1OkqeN1MxQ3JUpgpSy0zjDxxQx
	 A3cUsm0JHB6tphJQd6VHRPaFZZlyDm+Hg3ceykLGL6dbsDawiOmzGdflELlv/H3Pf
	 sJzzIZwBztyEJcuyf2VWxhmT4eSRRAPL+yEoSsASGDoOh2yNsJPK31N9r9bVOi2Pc
	 Y33LekjCRYmnEIx9x4lnp4QQVvDG8LKh6ucqmq6g7JednsGfdp1dcxgF3JrAgE/VT
	 l6V2uh7uM9UM4+Qurw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.235]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mx0Ij-1uolTy2Fdz-017Ubs; Mon, 21
 Jul 2025 14:14:13 +0200
Message-ID: <1e7473da-cb5a-4583-acb9-271223252e45@web.de>
Date: Mon, 21 Jul 2025 14:14:12 +0200
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
 <9154fc36-842b-4797-9b55-397cfdcba283@web.de>
 <2914d20-68da-a23d-6345-fd48f0b9bed8@inria.fr>
 <457ef653-08a3-48db-89ba-6f0e9153e563@web.de>
 <195a2f45-af9-495d-694-673f7e5fb35d@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <195a2f45-af9-495d-694-673f7e5fb35d@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:0EensyDloYwQPx6OFGQBMjA0/QzrpfSpuCO19iN3GFppRHLmvc6
 wQxYUCdeV/F+tTnVu6shWkwDZwXaQI2hzZs6nsM+pN0hqOgeDVDYncgH4rWcncIMRxU5bTw
 pgSOgXQWmCtuKk8DjA0YNrk7H8qMqfdGCaAC476HvocWMsI7CY74EezsmcoD7XNqMGVWegi
 Y1jPyc+veYv9RThFNPAUg==
UI-OutboundReport: notjunk:1;M01:P0:ae64rNkVs3k=;wKWaWsgv94LWLGE4G+KGawSKa+B
 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
Subject: Re: [cocci] Reducing parentheses (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2896
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/1e7473da-cb5a-4583-acb9-271223252e45%40web.de>

>> How would you determine if extra parentheses are actually required
>> for a part of a recombined expression?
> The pretty printer looks at the context to some extent.

Would you like to document any special software behaviour accordingly?


>                                                          If you have a
> concrete example that illustrates a problem, please provide it.

I hope still that the attention can grow also for the avoidance of
superfluous parentheses.


Can another information source become more interesting for such implementation details?
https://isocpp.github.io/CppCoreGuidelines/CppCoreGuidelines#es41-if-in-doubt-about-operator-precedence-parenthesize

Regards,
Markus
