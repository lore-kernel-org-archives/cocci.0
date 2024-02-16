Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9DA9C48260
	for <cocci@archiver.kernel.org>; Fri, 16 Feb 2024 12:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=WOvG7GgaBTyYCQ/JwseCsXMxmJ4tum5LNj6iY6SrR5k=;
  b=gHiIUh0399mI02LspCIZDrjflJT7z/KBrjCjooDCU8TsYnHZJBXfemQH
   Ns/0RJhM9Sw9LqMyf2XR4lFN59RIbUfSLNHJqIYFe+n19uLMcb/CpV58X
   M1mXdSygh3m82J1Wm3x/0hX38cvbSpAMp1Y4HVOO+GgrjT+f58P8T7x0X
   8=;
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.06,164,1705359600"; 
   d="scan'208";a="152315492"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Feb 2024 13:47:43 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CFE2FE0CD7; Fri, 16 Feb 2024 13:47:42 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 31405E008A
	for <cocci@sympa.inria.fr>; Fri, 16 Feb 2024 13:47:39 +0100 (CET)
IronPort-SDR: 65cf5960_LTZiZWn/By/0PUHL7Ofo1yBpirLlAgG143A+DwRRJOctZOd
 vN5DQAiDegBXqEA4a2Ft+/0qW6b5daIrOnJ5XIg==
X-IPAS-Result: =?us-ascii?q?A0FEAADKWM9lhwMP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T0FAQELAYI4gVIyBAtIhFOPRIF1MIQ7hzeHTopGgUA+DwEDAQ1BAQIEAQEDB?=
 =?us-ascii?q?IR/AodeAh4HAQQyBw4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECE?=
 =?us-ascii?q?AEBASMXBw4QJ4VsDYJcARCBDoEmAQEBAQEBAQEBAQEBAQEBAQEBFwJHQgECA?=
 =?us-ascii?q?gEjHQEBESYBBAsLGgImAgJWBgEUAQGCfIIrAQMOIwexYYEygQGCCgEBBq9bH?=
 =?us-ascii?q?ywiVoFhCYEaLgGIJQGKKycPgVVEgTyDAz6IHoJohVGDa5YIVH8dA4EFBFoNG?=
 =?us-ascii?q?xAeNxEQEw0DCG4dAhEiOgMFAwQyChIMCx8FVANABkkLAwIaBQMDBIEwBQ0aA?=
 =?us-ascii?q?hAaBgwmAwMSSQIQFAM4AwMGAwoxMFVBDFADZx8yCTwPDBoCGxsNJCMCLEADC?=
 =?us-ascii?q?QoQAhYDHRYEMhEJCyYDKgY2AhIMBgYGXSMHDwkEJQMIBAMrKQMhdBEDBAoDE?=
 =?us-ascii?q?wcLB3iCCYE9BBNEAxCBNIU4hG8MgTYDGSsdQAIBC209NQkLGwYiAR0CozKBJ?=
 =?us-ascii?q?QiTapEXoRk0B4I0gWCBYQyfOAYTL4NyAZM9DgaSX5hYIKhXgWsEL4FcMxokg?=
 =?us-ascii?q?zZPAxkPjiAZhBSPR0I1OwIHCwEBAwmFRgEBg1qBRgEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 YT4eIycfHyGdA==
IronPort-HdrOrdr: A9a23:ZM/haqhiyUXV82jqkQudXDXvcXBQXg4ji2hC6mlwRA09TyVXrb
 HIoB1p726WtN93YgBZpTngAtj4fZq4z/VICOYqUotKMDOW3FdAabsSi7cKoAePJ8SdzIJgPM
 5bGsASNDSzNykesS+Q2mmF+rgbsbu62ZyJwcHD0nxqUQZmUK146RxlYzzrb3GeCDMmOXIjfq
 DsnfavSgDQA0j+5amAbEU4Yw==
X-Talos-CUID: 9a23:WSBQrW8Kd/aCYxsvV0WVv0xKG/8kNXjF92j3Il+TNElDEfq8EHbFrQ==
X-Talos-MUID: 9a23:Vf2+vAUWEe5rib3q/C6rtQ5zMoRx2Y2nJ383oacflcmlFzMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.06,164,1705359600"; 
   d="scan'208";a="152315476"
X-MGA-submission: =?us-ascii?q?MDEsfinYYlFuwk7Q0DYvDVDu8v39h0K3BcijTh?=
 =?us-ascii?q?XqpTUMDfljcUlhZ9BCJKaxwTK4ulzIqBalSSYm3fEnK2bAejEHCyn+vw?=
 =?us-ascii?q?TUCRZu6pZiMeInUilb1O2hatnfBZKdMQPLN+JfSuBL854uVW2Cr49wwb?=
 =?us-ascii?q?ToQRm7Xf1DqbDIsVaQYiWEvQ=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 13:47:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1708087646; x=1708692446; i=markus.elfring@web.de;
	bh=WOvG7GgaBTyYCQ/JwseCsXMxmJ4tum5LNj6iY6SrR5k=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:Cc:
	 In-Reply-To;
	b=qjFUcL0z4iLY4Ix8p3Lmhy1211IY19S7q79f+idOg5/Jc/ILHGCNnwcjK+91rdRu
	 z/7PfAV0tveQp5ldhAZ8vwoFx9pcC4/QnUGsRcdqHFoEOt40vaa7AIQ9mMI5qZ5DT
	 uBDl3S8ljDexRjXmu4iiInLppfugCaMtB/0+6ojTXR0f0My5rBMcgV8hRRdnHwCei
	 KR/MLS9n52RLBfNxvHGSex2VpboBfEFhoo0wXOZ2u6XQc2ZHY02913R9Q5CgT/AZR
	 8GBH8hi78Ui999dRDRzLSz6SJxYThd6PmI1nYmePyM44EWgBr2zGrW+uFF/vRuhJ0
	 LzXtbxlhsNze2pLLag==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M91LW-1rdhRQ1Hmw-0063yb; Fri, 16
 Feb 2024 13:47:26 +0100
Message-ID: <ba6a6de7-1aa3-4de2-a4cc-01ecdfc6528b@web.de>
Date: Fri, 16 Feb 2024 13:47:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
 cocci@inria.fr
References: <162c5e8c-54c2-4b86-9735-887b8ba26f89@linbit.com>
 <654c2ee-755b-d245-d1c9-371b314d9efb@inria.fr>
 <86f82a44-129a-4a84-be4d-4b230c2c018e@linbit.com>
From: Markus Elfring <Markus.Elfring@web.de>
Cc: Julia Lawall <julia.lawall@inria.fr>
In-Reply-To: <86f82a44-129a-4a84-be4d-4b230c2c018e@linbit.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Wn2V4ikE1nv4AVEeKrdm9VTBoJudz6R0zjaC4H9lglysJlHu4o5
 CjdD4fNDHmXAeeG41cDemI0tvnHb3rZOhexjtbeE6yb4oWDS1wczBKVBoUvhlU+OryF7m3i
 naKJHZB1eAu76Bn+f3vmBIJuty3xROXXPjpw6AFTIOzhPFkBkTFX4wiuN+rqLHr4QF40JVk
 9Q8mjtMG1XFR4+9MpNOTw==
UI-OutboundReport: notjunk:1;M01:P0:keBaTPNDhxQ=;ps9UeRNfjtGMPErMHAmdwroHNpI
 16vtODPUvbxRDwd7cNucL5Px9eMPTJG2BMd26ZCGTdz1ZZ2sL7EjfrpxrnmGYT0qO/T41wQpg
 frbClNqnpBdaGiNegF9NXt+FZqVbj8XcCb/UDsvbGahmqq6ieq4L5S0cTLaKjuuYFoUgvhvpy
 9f2rpVVoIdMgrvMxHBFPwXhMhVqQKtZqctxYddjcqWfgMEPjP3s8JL14DmuTht5lZA3qWzTtJ
 /0mxbynXNI+4+32S93az4iYA8rc7HxgdeH8lpnD9cGNePL/JNqXwvgMN/+zj09iXN6bhiJKv1
 6G/rAUx4Q/NAdLG3fvL4o1lIfKGFQcEttrt9mN29Ab3cDRxg4qkGKglIehsy26J+MHlZ67M/9
 jaXDsufdnUBMHJBQPVA04MxAIO9qVD8nebjkaKYLoRjh1Rurpx6m7i54UbqH4jjkUcERys9rX
 2Z86up6y2ca0aXJ90poZdGQwih0H0XR/qxQYEPBddO+MwyCDFsFaIC5TrzC8t4J4NiA41klq4
 juvRMvHl80mW5ZfZ+SBWHXr1guhSs8AguiGD+r84vOAa3yMN8gU/QR2qHYMzpJ1vaqZf6hqqK
 XhUkWwSsApM7aHwaOMPjGcfggAUHO4zts2Sob94yPQLYO/Mybep+EBu5WvPuXR0o8rPlW4m8o
 nUnUCo5/RdsV19ryBxY502kh1UP/vfyzG3tFCNVRKEnD2nCAzb3LvEV7cabkKKPn78Ap60PJy
 /GGur76se67od6MrAhsFADQxJHaRbua/H8Ui+qKzXElyjetZmghIteMHg4g7XJRpG2RCaR+7X
 mSivcjKN5IinTQQqJqAhSBSHFWhIYUpSoP4ilDRuwBfss=
Subject: Re: [cocci] Spatch 1.1.1 backward incompatibility
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1568
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/ba6a6de7-1aa3-4de2-a4cc-01ecdfc6528b%40web.de>

> The latest GitHub version (0df3efff) has the same problem. It also seems
> to have some other issue, because it took 1385.5s (instead of the usual
> ~25) to process the patch.

How do you think about to share any more details about the SmPL scripts
which became affected in your test environments?

Regards,
Markus
