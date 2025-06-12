Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05E63C71136
	for <cocci@archiver.kernel.org>; Thu, 12 Jun 2025 10:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=CokD4HFUTdZVZscP2YreIAKEbIojliJKzo1ZeZSn0SQ=;
  b=vIC5SNTGpUkym9OzbLjTWMBKRKyEwRP+M/SeqxDBUQyrDwCBF3/QKqJA
   9tjEsW1B+SklK9BCOyZAuGJ7I8kFRKoQoKmELgG/epBwpzFEmw6hL/WN0
   Tfmx8Idb2rfaYnzdY8X6uJwP1zd+3V2BhkFerL3kENJi0oTg6HZDfde1W
   I=;
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
X-IronPort-AV: E=Sophos;i="6.16,230,1744063200"; 
   d="scan'208";a="226790941"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Jun 2025 12:40:33 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E080DF1838; Thu, 12 Jun 2025 12:40:32 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 4E7A2E8DDA
	for <cocci@sympa.inria.fr>; Thu, 12 Jun 2025 12:40:30 +0200 (CEST)
IronPort-SDR: 684aae94_+YwdJoeA1OCu9TBo1sueggMiyZRLPIJiOZQB+NPzz6qA1wt
 cRs8Ns2Q5NL/skdx32M6lxNLhK8fEOFfKSEiLjA==
X-IPAS-Result: =?us-ascii?q?A0GnAwAQrkpogAwR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?VOCRIEAWjMEC0mEVY9QgiSEO48PiHeDUgIPAQMBDUoEAQIEAQEDAwGEdgoCi?=
 =?us-ascii?q?2cCHgcBBDQTAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABATsHD?=
 =?us-ascii?q?goxhXsNgmIBgSSBJgEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAg06RAEBAQIBIx0BAREnBAsLGgImAgJWBgEUAQGCfgGCIQEGE?=
 =?us-ascii?q?AEDDiQHDQaxEoEygQGCDAEBBtpeHywiWIFlAwaBGy6FbYJjAYYnhDwnD4FVR?=
 =?us-ascii?q?IE8glIxPoJhAQECgSU5g1uCaYIogRaFZYcxh02MO1J4HANZLAFVExcLBwWBI?=
 =?us-ascii?q?EMDKjQxIw88BS0dgg2FGR+Bc4FZAwMWDwGCJIFeHINCgSOESStPgyKBf0wZQ?=
 =?us-ascii?q?YNfHgZyDwdKQAIBC209NwkLGwY9mQGEZRorgQVAlB2zCTQHgjiBZoFkDIotl?=
 =?us-ascii?q?TsGEy+DcZNaDgaTApkEIo1lmzGBfyOBXDMaJIM2TwMZD44hPoNCM4ELthtBN?=
 =?us-ascii?q?QIJMQIHAQoBAQMJhUYBAYozNIFLAQE?=
IronPort-PHdr: A9a23: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
 klQqY4=
IronPort-Data: A9a23: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
 IT1qa15rJmHdHPM
IronPort-HdrOrdr: A9a23:vRkYU6Cac5Emt57lHely55DYdb4zR+YMi2TDpHoBLCC9Ffbo7v
 xG/c5rsyMc7Qx7ZJhOo7+90cW7MBfhHNtOkO4s1NSZMjUO2lHFEGgK1+KLrgEIWReOlNK1vp
 0BT0ERMqySMXFHrYLd/BSyFcomzeKK6aaymI7lvg1QpE1RCp2J9G1Ce36m+6BNNXJ77RFVLv
 Ch2vY=
X-Talos-CUID: =?us-ascii?q?9a23=3A80WMQGk8/PidlAsNRd9z/x5hDH/XOXzU8krdPEy?=
 =?us-ascii?q?3MkxoTvrFUnGOwrtAr9U7zg=3D=3D?=
X-Talos-MUID: 9a23:Fl3H+wR7octFCm9QRXS2pDVrd5Zp3p+rEVkdz48nh46YdgJ/bmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,230,1744063200"; 
   d="scan'208";a="118874872"
X-MGA-submission: =?us-ascii?q?MDGk7y1rka0X+YMkv7UKIyxLVC4oAXNtrgtZNe?=
 =?us-ascii?q?PCuWcRHd0uBRf8TXAkYIhrnPMXGp0DzRtWVpDsIik67JOwYonZqFeurQ?=
 =?us-ascii?q?vvR7RFwjYLGaTysABWbAr37U6Dq5KYl0EKewBPtzH0cHB/o2jg2dLj2d?=
 =?us-ascii?q?IoGn3vcjCe6HOVaRZRsjYZdA=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 12:40:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1749724819; x=1750329619; i=markus.elfring@web.de;
	bh=CokD4HFUTdZVZscP2YreIAKEbIojliJKzo1ZeZSn0SQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=s+zHLD6yw/js+m7fxXP4JHMjCQXIPO/iv4ep+NGDU0yR0JxMmGkmU7PhH1v8Qpur
	 2BksLG22/kgH3txCLxurbErupoe3A1oRHyBUTgCvJfne2sqOjwUUYePz3XFaOIk/v
	 7tsLLpUdSWCkb/rQKzCPwgzTo1nygsjUrIeM8YLB7K3u4Gye37vqcsid14oWz9Ohs
	 Vj6f6RQSiZywHwlHIjxkDO4aH77fdAg+6j3HYTAKXczZloszuyO9BwERbRXe+z7oT
	 RHU3X1tGkXTWqiRTwL29WHedTfU7xRj9lKl/mEPRGE9M5D6rFJzCpKWa3EV7MuD/K
	 aRu39e3MdHliCDvohQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.213]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N5CUp-1urKh53eM9-00ri80; Thu, 12
 Jun 2025 12:40:18 +0200
Message-ID: <a3dc6387-aeb7-4c42-a043-0e86f3ec86fb@web.de>
Date: Thu, 12 Jun 2025 12:40:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <90822099-5434-4421-a611-785511926ecb@web.de>
 <alpine.DEB.2.22.394.2506101739440.4658@hadrien>
 <629fa64c-ccd0-46ba-907c-97bebc00fa0c@web.de>
 <alpine.DEB.2.22.394.2506101831510.4658@hadrien>
 <be43fd17-4386-4ddb-bb14-72d2d33d793a@web.de>
 <alpine.DEB.2.22.394.2506101850030.4658@hadrien>
 <3f9b8788-e9fb-4643-aee7-5ce5400e94e7@web.de>
 <alpine.DEB.2.22.394.2506101925310.4658@hadrien>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2506101925310.4658@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cPoPJKi19LNGDuukoIMY6qEu75VzlRs5CMQAgcF/Ssa4v9c5Gla
 /a39hrvPCTo5jMXAhL85ORdjbNlsA3Jzjqf5MdP6Le6Up5TXu91XRHk4jqYX0woH6J1wwst
 RgpkgXC55d9qIuocz8U3uT/id7LV/LBGSAZqpfH+hurUtkhatapEA51CZqnSHFeKilb1vWA
 tccT0PxfOOD91vqcB9Q7g==
UI-OutboundReport: notjunk:1;M01:P0:LgeoIdAvE8E=;g7l8iajc3k5onhC1Xogo77WnOjg
 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
 fwlGBeqitT9zARFMKS7HAzZxe/OvA==
Subject: Re: [cocci] Checking another deletion of redundant null pointer
 checks (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2761
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-06/a3dc6387-aeb7-4c42-a043-0e86f3ec86fb%40web.de>

> The number 7675 is not going to help me understand what the problem is.

Can the corresponding message =E2=80=9Cfiles match=E2=80=9D (which would b=
e provided by a function like =E2=80=9Cgitgrep_filter=E2=80=9D)
be essential for further development considerations?
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/e892609c351f889e013b9=
977a413d5b97415e4de/enter.ml#L974-983
https://github.com/coccinelle/coccinelle/blob/4093aad2da23ea5c86916de0a71f=
43032fc2bb2f/enter.ml#L974-L983

Regards,
Markus
