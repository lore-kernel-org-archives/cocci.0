Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03FFECAC598
	for <cocci@archiver.kernel.org>; Tue, 16 Sep 2025 08:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=2vTPhdGPka4t/80Yf/t4lq+DhxDzL+r/USmHv9Q7KJE=;
  b=Y8DKDzgPn+02/YQql7WaLkKdGOT6G7Q/Y6QaN+KcE516B92SzyOGh+Lq
   x6AnYQFpYjA/EnLtRDbuD82tlvPkg9DcpQviOAMaSg8RGOwDZ37elABcI
   ++uoXG22t9thTetfXKwHx4/xAeltjSFT3KNNVd2IwvwNeoQi8GFVLZt9L
   M=;
X-CSE-ConnectionGUID: 7QpV0F2yShaEHXZFMS9jtQ==
X-CSE-MsgGUID: n3WjuqxuRR2nPTS8OgrIQA==
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
X-IronPort-AV: E=Sophos;i="6.18,268,1751234400"; 
   d="scan'208";a="239291492"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Sep 2025 10:25:49 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2FAB9E0BE9; Tue, 16 Sep 2025 10:25:49 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 0851FE0BE9
	for <cocci@sympa.inria.fr>; Tue, 16 Sep 2025 10:25:44 +0200 (CEST)
X-CSE-ConnectionGUID: y1sZHi41R/uzNave7ERjEg==
X-CSE-MsgGUID: a4gqq86HSYik/iuYinIgqg==
IronPort-SDR: 68c91f07_oKTuGqfDdtQJ/xYUV/RJyNTpUJAVfT78jsAZRT7luwqyvIO
 gm3TibwoaynbQeIMwQRcHhEJe8o71hCnOEy4SIg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0ETAAD1Hclog07ASNlaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBPwYBAQELAYI/gQhUMwQLSYRViByHNIIkhDuHPIdViHmBVYF9Ag8BA?=
 =?us-ascii?q?wENTgECBAEBAwSFAAKMMwIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQEBAQ0BA?=
 =?us-ascii?q?QUBAQECAQECBAYBAhABAQE6Bw47hhUGNA2CW4EsgSYBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEXAkdEAQEBAgEjHQEBEScECwsaAiYCAlYGARQBAYJ+giMBBhABAw8mB?=
 =?us-ascii?q?7VYgTKBAYIMAQEG2l8fLCJZgWQJgRsuAYVrgmQBhieEPCcPgVVEgTyDAz6EQ?=
 =?us-ascii?q?4NbgmmCJoEWg1iMWYt4UngcA1ksAVUTFwsHBYEgQwMqNDEjSwUtHYEneIMHg?=
 =?us-ascii?q?Q2EHitPghxygXQ+GUGDUx4Gaw8GgRUZSQICAgUCQz6BayIGHxICAwECAjpXE?=
 =?us-ascii?q?IF8AgIEgUJAAgELbT03CQsbBj2WL4dixgM0B4I4gWeBZAyfbAYTL4NxAZNgD?=
 =?us-ascii?q?gaTBZkGIqkfgWg6gVwzGiSDNk8DGQ+EKYl4GYQavWhBNTwCBwsBAQMJhUYBA?=
 =?us-ascii?q?YxWgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 A==
IronPort-HdrOrdr: A9a23:AbkAV6yn6HdxmSBKRjwbKrPw8r1zdoMgy1knxilNoG9uA6mlfq
 eV7Y0mPH7P+VAssRQb8uxoV5PufZqxz+8Q3WBVB8bEYOCEggWVxeNZgbcKqgeIc0DDH6xmpM
 VdmsNFaOEYY2IK7vrS3Cn9Nco8y9+a962Sif7Z1GoFd3ARV0gt1WZE4h3wKDwPeOCqP+tDKH
 IWi/Asmwad
X-Talos-CUID: 9a23:GlTOg2zmGJuP9G/ltfh4BgUFQ9sXUnyBlU2XPl2eAHhkF5CvS3KfrfY=
X-Talos-MUID: =?us-ascii?q?9a23=3AzspTeQ2e8SIDhQxqQDuFpZ0HwTUj6vihEVldz7U?=
 =?us-ascii?q?9isiHci1tCjabrTuuTdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,268,1751234400"; 
   d="scan'208";a="239291444"
X-MGA-submission: =?us-ascii?q?MDHNylZus35nEHY5vfTorAq8ZKgbhdyqH40sfU?=
 =?us-ascii?q?zyhzDfbbVheWZlhgZnQ96fBoWp2/yMy6SFV0MZHucM/HnRp+rztHR+Al?=
 =?us-ascii?q?1iDKXh5OE20IsXodgK2CoixdaPRSxEmmQbdi59umkYU2wpYlnDnBYAdV?=
 =?us-ascii?q?WZbFPy0CoOBxikHIUT2BVLPg=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 10:25:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1758011143; x=1758615943; i=markus.elfring@web.de;
	bh=2vTPhdGPka4t/80Yf/t4lq+DhxDzL+r/USmHv9Q7KJE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ZnSHJzJYLCt+GDKeJ6U1+EZ9Wcg3mPgI2ce5zY738LLI7qsIfjnjIRHLDR+P9GM6
	 2DihP0Yl43s0Ba12PSzxGzn410mTeDiz89XYXz7ecawr2aqqoKCbqmeIvfnkryQ8X
	 eec35esiMsJ4gwjDYFa5wUbZv/XgAHYEDXVqAvO6flKwUHoxk6xmZ8dKa/XbvO0Di
	 3mFwo5MDj423EW7KSynt9qWydwqC+bERKDNEOKNrRSJDSDaN+bKgdsNQrQIOR2Jxg
	 //yL2Pw3jk57xJd1lBDnq36modMOsY6p++nuNdlmb2RI7pZ+d3bDnsAmgr1exYoib
	 lWSvfNS9KnvYYOUMNg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.197]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Myv72-1uCm8a2xb0-00wTNP; Tue, 16
 Sep 2025 10:25:42 +0200
Message-ID: <76442e22-a848-45ba-8d6c-96d544b8f906@web.de>
Date: Tue, 16 Sep 2025 10:25:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Anon Anonson <anon@chud.cyou>, cocci@inria.fr
References: <d04274ea-7bff-4c63-8fc6-55a19ab45b55@chud.cyou>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <d04274ea-7bff-4c63-8fc6-55a19ab45b55@chud.cyou>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2d51fuxdDP9ykUoPSpRxtTIF6YtuuCrzaq58AT7PSTFbc09uaNw
 +x+twwDqMXtDkU0f+XIYRH47al4cEV3hVnVr0jWR4wNYP9oZsSTe0w9V/oZUYPNerdpGXAw
 DuSqncobo0Pr8u90SUMKleZhpJ0BCmSTvg3ji3xcHsE+8mn8euUzkgbB8KI/Cb0fBDdh/ZQ
 T2+wQAuiwqyK0X0iNowsA==
UI-OutboundReport: notjunk:1;M01:P0:Na/ieTU9PoI=;K8jyK1ETuyk/OMQNi13x+SEK1uQ
 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
Subject: Re: [cocci] Renaming identifiers with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3021
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-09/76442e22-a848-45ba-8d6c-96d544b8f906%40web.de>

> Given the following script:
> @ rn_dec @
> type T;
> identifier I =3D i;
> @@
>=20
> - T I
> + T b
> ;

Can such a source code transformation approach ever work without the speci=
fication
of the semicolon?

@Renaming@
@@
 int
-old
+new


Regards,
Markus
