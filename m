Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0DF6CFD2F6
	for <cocci@archiver.kernel.org>; Sat, 29 Nov 2025 17:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=f0Vu68x40Ea44XEvVQJZXQPZauCGSttE39EfAMwcpYU=;
  b=Ig/P1WXYLbgzD2eQ7vFR01wjXDjMRVJBcJFhkxDGQIswtMHC4iaUntqN
   6Bo2EyGw3/TMJsD1aV/TlZabmJDfxr8G6ilvH/AFWVLjzi/sRKu88sjHE
   DPJy5LaUCi89wd23JBLuoiru/rjUww8twywUnb9cdfcrach8sB+TLPdXL
   w=;
X-CSE-ConnectionGUID: isKL9v9TQ8eCwQnGTwMxyQ==
X-CSE-MsgGUID: JI+vv4s1TE20GTg3iD4poQ==
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
X-IronPort-AV: E=Sophos;i="6.20,237,1758578400"; 
   d="scan'208";a="251899985"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Nov 2025 18:38:55 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1A4DEE0260; Sat, 29 Nov 2025 18:38:55 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id B8E30E0157
	for <cocci@sympa.inria.fr>; Sat, 29 Nov 2025 18:38:51 +0100 (CET)
X-CSE-ConnectionGUID: /CbxHCQjTqiG6HYfpNxHjA==
X-CSE-MsgGUID: 3AzSJ8QuSCGQZrU5K0ZTHg==
IronPort-SDR: 692b2fab_SF6sdV2dIW+YsTy/RRc823qNJiEUwPFxC0krxVc9Lu4069H
 HOX88DqAjOhoEiHYNGeVqa5LDX/hS3vbUyQ541g==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0F3AgDmLitpgwsR49RaHgEBCxIMQIFFC4JAZSNYMwQLS?=
 =?us-ascii?q?YRVj1OCJIQ7hzyHVYpOgX0CDwEDAQ1OAQIEAQEDBIFMQIJqCgKMZQIeBwEEM?=
 =?us-ascii?q?AkOAQIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABAQE6Bw47h?=
 =?us-ascii?q?k8NgmIBgSSBJgEBAQEBAQEBAQEBAR0CR0QBAQECASMdAQERJgEECwsaAiYCA?=
 =?us-ascii?q?lYGFQEBgn6CIwEGEAEDDycHsW6BMoEBggwBAQbaXx8sIlmBZAmBHC6FboJlA?=
 =?us-ascii?q?YpmJw+BVUSBPAuCRzE+hEODW4JpgiaBDplWUngcA1ksAVUTFwsHBYEgQwOBC?=
 =?us-ascii?q?yMPPAUtHYEjIR0YEWA9F0CDSR0GZw8GgREZSQICAgUCQDqBZgYcBhwSAgMBA?=
 =?us-ascii?q?gI6VQyBdwICBIIWfYIKD4gLgQkFLoENAgELbT03CQsbBj2VDVCEN6Uxons0B?=
 =?us-ascii?q?4I4gWeBZAyfbAYTL4NxAZNgDgaTBZkGqUGBaDqBXDMaJIM2TwMZD44hGSWDd?=
 =?us-ascii?q?cR2QjU8AgcBCgEBAwmFRgEBjFaBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 N0AUYf6NRjAYA==
IronPort-HdrOrdr: A9a23:QGnhQKxEfV1OS3fJAQaZKrPw+L1zdoMgy1knxilNoNJuA6ilfr
 OV7ZEmPHjP+U4ssRAb6Km90cy7Kk80mqQb3WB8B8bEYOCighrPEGgA1+XfKl/bdxEWn9Q1vc
 pdmupFeb/N5DNB7foSjjPIcOoI/PnC1ry0juHDyHpXQRhtcLwI1XYFNu/WKCxLrBItP+tDKH
 Nw3Ls8m9IqFE58UviG
X-Talos-CUID: =?us-ascii?q?9a23=3AmbOEBWsC9axwGQVJS/9dYhJ96ItiWXfN7FzpIXO?=
 =?us-ascii?q?hCEk3aIybUXmA2KFNxp8=3D?=
X-Talos-MUID: 9a23:2YsRhwQKy5/OVkeGRXS3rSNZFpdR/p+FJ3k/i6hbmJG2CQx/bmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,237,1758578400"; 
   d="scan'208";a="132289002"
X-MGA-submission: =?us-ascii?q?MDG0odSfvOKm1Z/n2WKo4pz4e2Y5a81HUBis+R?=
 =?us-ascii?q?zvCjKqgOjobnla5RqOsoULPYhIpcroAlQFvgbYtJHQXkkWDc0bcty9mc?=
 =?us-ascii?q?d+U0FYk2BaOAD8x6NGNu8b+yZ8VWrIwW7hijxVadGCgbEEh6fSTY6Qvs?=
 =?us-ascii?q?jUVKnX12SpCBrPEO2K7JvLTA=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2025 18:38:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1764437930; x=1765042730; i=markus.elfring@web.de;
	bh=f0Vu68x40Ea44XEvVQJZXQPZauCGSttE39EfAMwcpYU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=JjI9vo1+IUkKvYi9qq54OvMo7x6cizBhU9pIqiPFzh2PSDvfI3MRDZ9gJT9W6wc9
	 BmssdVjWiy3ZRJMITX05EX97BfJT5+C7axmmd07crwzl6Gv8bVLwiTbHp2aSYNa5+
	 QlTO5SjLMzC342oHsQyfVxRWsTdrfjfGLc6Ma7nLjA5jBLSJsxElKZ80i/X/pDkS1
	 RARIezXPrR8BULvX5GSXUSsgDD0Iowmih4zk749Q+sneHXTo3QL5pfEHkbzJgjE/q
	 0NAlag8ECGozMBKyqpaBOL1vG7H627Qnc8qj9ICdySPTGA4ipuI0Uy8a0mg65N9DV
	 a40lb33mMD4pq0OZbA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.187]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N5lj7-1w8wwU3PmF-00smXY; Sat, 29
 Nov 2025 18:38:49 +0100
Message-ID: <06f4ef11-3b9a-4116-a835-6acfc6b63021@web.de>
Date: Sat, 29 Nov 2025 18:38:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Tobias Deiminger <tobias.deiminger@posteo.de>
References: <4f6e259891de0666aa1fa10b810a5dd3@posteo.de>
 <b4884a21-4a59-c549-8466-164a20a76abe@inria.fr>
 <2897bda0c438111e967017f6bb3422f0@posteo.de>
 <caf02577-eee9-d55d-1f42-7b1f3bd2f60@inria.fr>
 <3ae5bc93f8cae1f28a068d89d3d1b070@posteo.de>
 <67f9e0f2-fa4e-c7a-d388-3732d8aec1e6@inria.fr>
 <67d1e00d2e22a4655cb10ec55d1a99db@posteo.de>
 <83c8a7aa-9b98-8ac1-d563-e8fe2588f9a@inria.fr>
 <fd7307f8024706d4bd128d0b7f43bb96@posteo.de>
 <29c204aa0f1f08074279425b7de42dd7@posteo.de>
Content-Language: en-GB, de-DE
Cc: cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <29c204aa0f1f08074279425b7de42dd7@posteo.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:V0Rrqgc2Rau02AfOSbO+KTWvMu9YsuqfP5tSPfo9jsoBd8qf8ll
 i06bCHyMld4jgASKSyDemf0aYHliiUMBNcDenCAnFRgvEsTOK2Cn1tt6lNSNz4JVnAFD+Hy
 xrTn/5srx61gIKcB/S4y/tA3oKY+RxjjVE6eIFoAuL37WOITtzcKmlHvNTuaJsK5c/mZz66
 beVwZOp7wWFqxf354djMA==
UI-OutboundReport: notjunk:1;M01:P0:6upQYZN8aDA=;qwCrllERZ9fJ5qy/zGjiW93w6Ch
 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
 UNVBbo2Cba3UN1H7GCthl2DMMEnVHgufYrU1zl
Subject: Re: [cocci] Can we match a known macro by macro name instead of
 expanded function name?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3216
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/06f4ef11-3b9a-4116-a835-6acfc6b63021%40web.de>

> Somewhere=C2=A0either=C2=A0me=C2=A0or=C2=A0coccinelle=C2=A0is=C2=A0wrong=
.

I got the impression that you stumble on adjustable software limitations.

Regards,
Markus
