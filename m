Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E375C83F03
	for <cocci@archiver.kernel.org>; Thu,  3 Jul 2025 13:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=zTTlnKHCCLTLik290uNqzmqFVZE3Pz9jfCI7pCIZEGk=;
  b=GXi8U9KtzqMOtJqrBiG3KY9cuUVPyPtfDhMTE7SJDB6kr4u4CtIIrBKc
   Wn0iXvQECMEyepzg6MLR7hT+jAg1PRVg/4OL/n4d0qkw3c3CHqjD1nDse
   /N0E+UahpNDTDdl9rxFpscXbslmXWrYwj6SkvZ4RNk+Lk/dSEJ8Oug3sh
   w=;
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
X-IronPort-AV: E=Sophos;i="6.16,284,1744063200"; 
   d="scan'208";a="230184699"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Jul 2025 15:25:48 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C4F70E0AF1; Thu,  3 Jul 2025 15:25:48 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id F1929E0131
	for <cocci@sympa.inria.fr>; Thu,  3 Jul 2025 15:25:44 +0200 (CEST)
IronPort-SDR: 686684d8_vWYnx9tunOxJ2WsOk/y6BrH191TQAn0Cx5tE8wHzVzNVJ7H
 hAExGcm75ifndkSEdfWGtzggOjXmXarjyGSjM0w==
X-IPAS-Result: =?us-ascii?q?A0FLCgDhg2ZogwsR49RaHgEBCxIMQIFIC4JEgQZUMwQLS?=
 =?us-ascii?q?YRVj1CBdDCEO4c8h1OId4NSAg8BAwENTgECBAEBAwSFAAKLegIeBwEEMwYOA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABAQE6Bw4KMYV7DYJiA?=
 =?us-ascii?q?YEkgSYBAQEBAQEBAQEBAQEdAkdEAQEBAgEjHQEBEScPCxoCJgICVgYBFAEBg?=
 =?us-ascii?q?n6CIgEGEAEDDiQHriaBMoEBggwBAQbaXh8sIliBZQmBGy6FbYJkAYYnhDwnD?=
 =?us-ascii?q?4FVRIE8gwM+iB6CaYImgRaEepNrUngcA1ksAVUTFwsHBYEgQwMqNDEjSwUtH?=
 =?us-ascii?q?YEnfoFNHIMJgQ6EKytPgiR1gXlBGT+DUx4GbQ8GgR8bTgICAgUCFUACAQttP?=
 =?us-ascii?q?TcJCxsGPZJyrBKhQjQHgjiBZoFkDJ9pBhMvg3EBk1oOBpMCiEOQQiKpGoF+J?=
 =?us-ascii?q?IFcMxokT4JnTwMZD44hGYQawFJBNTwCBwsBAQMJhUYBAYgMgUsBAQ?=
IronPort-PHdr: A9a23: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
 7Dy
IronPort-Data: A9a23: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
 VUIqat4rI1XhKI//QuMu5KYJf3BgA7S8g==
IronPort-HdrOrdr: A9a23:oTp5equ/iV8hgagb4REj+6XE7skDqNV00zEX/kB9WHVpm7+j5q
 WTdZMgpGbJYVcqKRcdcLW7U5VoLkmyyXcY2/h0AV7mZniAhILKFu9fBOnZrwEIcheWnoNgPO
 VbAspD4bbLbWSS4/yKgzWQL/Zl5sWb+6a1gurkw25qVhwCUdAb0+40MGem+lYdfng/OXPVLu
 vm2iLNygDLRUgq
X-Talos-CUID: 9a23:jsOWomF/tYyPEseqqmJ2/m4TGv4bYkHUzSz9IB+yL2oxFZC8HAo=
X-Talos-MUID: 9a23:wX0KTwgIhN9TT0OC/m3LgMMpDJ1UyPyFIwM30rY75dmVLTdsZR7FtWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,284,1744063200"; 
   d="scan'208";a="230184692"
X-MGA-submission: =?us-ascii?q?MDEll9G0/ZFT3xGcAO5dwkYwYDZpyfiyy+BJM2?=
 =?us-ascii?q?6Pyt2EeTvyvJaxWmRGI0Xy+n0BLmC0+OYUsGv/+ZWKrGBaYOPpHtHgcO?=
 =?us-ascii?q?DxNdGiswnaqFNV/QXulyXtbvPkAxEKH+HlMGsr7MHeHjXPsIpVwZXRAW?=
 =?us-ascii?q?XbKdY7Ejf5CA4QWCz4CJRWZQ=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 15:25:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1751549143; x=1752153943; i=markus.elfring@web.de;
	bh=zTTlnKHCCLTLik290uNqzmqFVZE3Pz9jfCI7pCIZEGk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=BSgvo+qA49Wmd9wVs1ms3TOC5fPnUoFmj2Miu776+sJfPy4ptR+RjkTBxJ8XxC2g
	 tTEPG7HYDmN5OewkPcbmpI5DzfJA7KBVlUojslOFx+B488H5TaWAkvYH+JSplaIFY
	 gCHqhLuSZWSKJxf7zCBuM/l4yJlQTjGGMVbnTxboI1dT/AkyNp/1G2EjGfwugBDCH
	 WWpZQTAWaPN77Oyr2eAzR8KhbZHYRw33Ad7er185RUHgZopGHfTVHsuv+5kdcFLhl
	 w9vRi3UDPeJkbDDqfyooVKXD8L/x7543/tJMvbX6s7/q3BUvap4CIHjLLPCSLe7HV
	 bdkc6PuiEs3TutxF9g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.211]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MumNN-1uoZue1WHj-01163W; Thu, 03
 Jul 2025 15:25:43 +0200
Message-ID: <e6cf1ea6-232b-4dfe-bc0a-6da1f6a194e9@web.de>
Date: Thu, 3 Jul 2025 15:25:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <3675aefe-7163-4b02-a4ad-07b7a23a4b13@web.de>
 <38ed2bf4-4bb2-4ace-87c8-191e19f8445b@web.de>
 <5ce5048-db22-67f-aceb-a358c54a62ee@inria.fr>
 <65638cec-fc36-44c0-88ce-f9678a0a1d53@web.de>
 <d0fb31c8-2888-47e6-c527-57f0e828f32d@inria.fr>
 <20d8778f-27fa-43ff-97e1-44375755d952@web.de>
 <8a69338-c049-cce1-2d66-a9607c175270@inria.fr>
 <ab0209a9-fbf7-4bd8-ae78-d6fb337ee294@web.de>
 <44735e62-2ed6-730-6ab3-b2251d8b6723@inria.fr>
 <7a1ae793-7f9b-4ec7-9cc7-db176207369a@web.de>
 <50208889-e99b-28ad-cc61-af8f92511192@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <50208889-e99b-28ad-cc61-af8f92511192@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:3Gpitb9yb5K54Q3uZ/IFE82unb2pRw+3kNffDbFu7GIN/piMkh/
 K/AY2RQU8drfU6KM8g+KJjY1xJ+Yj2dCNWvBX4KGPAccYbgkqWrCsCcwzlFKLLksE71NCHQ
 rdnhinv0pn4dFPsVRAcdkx3A2JAgSu1M65ITSWIkHUT4NxAkLF5mnbueXljniQfevb5UAk0
 PE4zq8zdWX3NrDjUSkJjg==
UI-OutboundReport: notjunk:1;M01:P0:huDyDec9Zbk=;h8pK639SLOyJUreqNZCH6x6F/WI
 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
Subject: Re: [cocci] Using statement list combinations?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2852
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/e6cf1ea6-232b-4dfe-bc0a-6da1f6a194e9%40web.de>

>> I am curious how often this code pattern could be found finally.
> Probably never.  People don't often make a {} between two other statements.

I imagine that source code analyses would occasionally care more for
the implementation detail if curly brackets should enclose extra compound statements
(or not).
Is there a need to mark data processing scopes better anyhow?

Regards,
Markus
