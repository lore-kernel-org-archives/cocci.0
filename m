Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87772CD37B2
	for <cocci@archiver.kernel.org>; Sun, 10 May 2026 17:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=+vhheajot9yAyOb68pvND0dQ4AuFHicgSl9CIoaVtF0=;
  b=omDboPS48TS9wv3YJdaSJvRBvtXBUfR99tQHz1K3AgU4FyTAeqxhvxC4
   PAPTFOwR8oLoh4/Lh2IFphw0W04rXA8gus0bbpXnI6fGH4ehu+7MwEtLw
   YTQP88MRmlfxiB8afT/sPUHkHPmcDQT3V7J6N7wnEoZrOSFluMVZDK/As
   0=;
X-CSE-ConnectionGUID: AXWFZbBSQtaIVXbV73P9AA==
X-CSE-MsgGUID: HGtuUkg2RjK/Mhfcdur25w==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.23,227,1770591600"; 
   d="scan'208";a="276044751"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 May 2026 19:34:37 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id C848081549; Sun, 10 May 2026 19:34:37 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 1649980436
	for <cocci@sympa.inria.fr>; Sun, 10 May 2026 19:34:32 +0200 (CEST)
X-CSE-ConnectionGUID: 9K9ltFujRRS1oALd8/RayA==
X-CSE-MsgGUID: UjE5G037TSWnyLMMNVzEGQ==
IronPort-SDR: 6a00c1a7_XnwO1hOm7lVfAb9GfXKwDUhYkmCcSQ5QmG8Jhr25FGWYG1f
 kMBN5plE/GguYqvtj/bET9nLgD0FWr7VZHGkMag==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HGDgCcwABqdxMP49Q+HINEgVZnDgESXjQEC0mEWI9Tg?=
 =?us-ascii?q?XQwhDuEc4IZRYdAAzUCcIY/hFkJAg8BAwENLg8RAQIEAQEBAgSEfwKNMwIeB?=
 =?us-ascii?q?wEENBMBAgQDAgMBAQEBAQEBAQEBAQsBAQEEAQEBAgEBAgQDAQEBAQIQAUMOE?=
 =?us-ascii?q?CuGTw2CPQiBQoEmAQEBAQEBAQEBAQEBAQEBAQEBFwIUGD8BHwEBAQIBIxUIA?=
 =?us-ascii?q?QE4DwsaAhgOAgJWGwEBgn4BgiIBBhABAw8nBw1HqRKKQ3qBMoEBggwBAQbaZ?=
 =?us-ascii?q?gVGCIJbAwaBHy6IWQGKcSeBGIEQgTwLgkcxPoJhBBiCE4MOgmmCJoEOhS+JU?=
 =?us-ascii?q?1J4HANZLAFVExcLBwWBI0MDgQYjSwUtHYEjIR0XFR9YGwcFEiEqbktkLFwaA?=
 =?us-ascii?q?wMNISQRWXULSQWBdAKCHhlfIy8DToEFAgELbT03CQsbBD2LPB0Pgi+BKxCCS?=
 =?us-ascii?q?IEGAQEBo2Roi3qUXzcBBgKDZjiBZYo5jBmJJgYTL4NxAaZ5HphojgmbOIF/I?=
 =?us-ascii?q?4FccIFugUlQAxkPkiNqwyQ6MgI7AgcCBw0DC4VEAQGMVQGBSwEB?=
IronPort-PHdr: A9a23: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
 LanpmhJ3gtiaJg+IqmCfMJ0
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:y0o2QKmppWQJgrM7Anzs3G35dK/pDfLy3DAbv31ZSRFFG/Fw5P
 re+cjzsiWE8Qr5OUtQ/+xoXZPqfZqyz/FICOUqTNOftUzdyQyVxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIOauEYZmIbsS+V2njaL/8d4J2g7L2ig/vYwkxgVAdwdshbnn1E40qgc3GfX2N9dOIE/X
 enl7F6T7HMQx4qUvg=
X-Talos-CUID: 9a23:9XbgqWMUgeLCZe5DCQo28FI6B8IfSEaEy170Lx//M294YejA
X-Talos-MUID: =?us-ascii?q?9a23=3ArnVC4AyyTBGgVfZjRyPvxs6qJ6CaqJmsJR0iyc5?=
 =?us-ascii?q?Zh/K7Mz1UHhK7siaabbZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,227,1770591600"; 
   d="scan'208";a="276044729"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDEihlHCGRdp+LndtiGqpRSSQTV5Zlk7aBa/Vf?=
 =?us-ascii?q?MoYFb9o5mlGHaH1qdwjO1sllDmbQFJwUI8aHkv1CemegrFYPV1GIIhu4?=
 =?us-ascii?q?Wsk8FStX1OIslyWNmhWD1Gk6cfajT3gH34Ci6+WQegdQ+z5+1pf3/I2J?=
 =?us-ascii?q?8GKjOHFJ6Zckk4P1wIx6oEEA=3D=3D?=
Received: from mout.gmx.net ([212.227.15.19])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 19:34:31 +0200
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mz9Yv-1xHxhO39iV-014v6k for
 <cocci@inria.fr>; Sun, 10 May 2026 19:34:30 +0200
Message-ID: <804cd214-3771-4e45-bfe8-8ec34f39ea7b@caramail.com>
Date: Mon, 11 May 2026 01:34:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
References: <ffd64e55-beb3-4030-8b7d-763ba6f8f563@web.de>
 <1f97d99-bf20-44f9-8781-26162f5824b@inria.fr>
 <ef0539dd-b1d5-49b0-9c20-74c5e5d977b1@web.de>
 <e5a66d9c-5462-2f54-6abf-d2ec2cfd1d9@inria.fr>
 <26e1d3aa-13f1-4e55-88d1-68b9d027ded0@web.de>
 <806afe75-8e1-17d8-dc3e-c2e33f4ab64@inria.fr>
 <049a046d-3952-4192-9b9f-a7c2162c6ea9@web.de>
 <2437833c-e02c-736c-e96f-7ded7eb263c1@inria.fr>
 <569a2fa4-d655-4c26-836d-a86aedf4e0b9@web.de>
 <6614c14-3844-9774-24c3-e891ad57e9a@inria.fr>
 <f3e6a976-2ab6-428c-ac42-ccd2281774aa@web.de>
 <44e0e8aa-f4f5-be2c-3956-a15d1989eec6@inria.fr>
 <80eb8b28-fe71-4d21-b154-646d425fea46@web.de>
 <cdebe356-d9a9-36d6-aec-94673979520@inria.fr>
Content-Language: en-US
From: loopily_ <u1049321969@caramail.com>
In-Reply-To: <cdebe356-d9a9-36d6-aec-94673979520@inria.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:mA88OEkPfiGkeFh9Nb+sstoh+iMv812QXuovc181ZwX6wOdP23D
 +b6IqNFICZQA6iuo/AV/vwgru9p0steGXfvvf7xTX/AUun7L4kRJ/qajun7nEzq/QAAjcwd
 QzZxQod5rJFZ5JhgPmWuqxvd8j0aVi2ujoVe9wova/aEmk7/KD1gc+gL2jdT3WMzGQYuxkI
 OFpflRDQltdaTqUUkvZHQ==
UI-OutboundReport: notjunk:1;M01:P0:QeHETl+XM6s=;ECliWu3fvSSq1RXImY9kNaQiPkY
 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
 Ek
Subject: Re: [cocci] Merging results from parallel data processing?
Reply-To: loopily_ <u1049321969@caramail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3500
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-05/AI-gDJT0hWj_RqrZ61xrTA>

Good day all,

>> Will development views evolve further accordingly?
> No/.  I see no reason for the default behavior to change.  It works fine,
> and Coccinelle has no more information about what the user wants.

https://boinc.berkeley.edu/forum_thread.php?id=15619&postid=117251

Thank you very much.

