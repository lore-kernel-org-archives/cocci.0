Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F224C7EE39
	for <cocci@archiver.kernel.org>; Sat, 28 Jun 2025 19:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=vfEKsrNIlH9BxZhyTKYrIKQ8Hog2Nk1NFLM7C+NWWmM=;
  b=dBQv9Dv+FdyQhKDTrxrPCdla8OQ4C5Moz0l0ByLpciXWdmHjPoDqCh93
   qUcwqoieKVDj8TSAfr6iXt396+aYYYdzprZLG59zJj41W26gwVIV6xyff
   gZHlKkHOZmwjFBTpevS2qhcde31eM6+h4sss0xZ3L54RxqW/bQmdqhh+P
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
X-IronPort-AV: E=Sophos;i="6.16,273,1744063200"; 
   d="scan'208";a="229433734"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jun 2025 21:22:10 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B9379E0157; Sat, 28 Jun 2025 21:22:10 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 3F5A8E0131
	for <cocci@sympa.inria.fr>; Sat, 28 Jun 2025 21:22:09 +0200 (CEST)
IronPort-SDR: 686040e0_mwsjvTaaNDiiQdT52rlWuzi6dgxxPF/ltUJ03P66Q664hkJ
 pDF3PGDI4KPNW0puu5Xh2J/6X73L8UiweUigHcQ==
X-IPAS-Result: =?us-ascii?q?A0F7BgD/P2BogAQP49RaHgEBCxIMQIFIC4JEgQZUMwQLS?=
 =?us-ascii?q?YRVj1CBdDCEO4c8h1OId4FVgX0CDwEDAQ1OAQIEAQEDBIUAAotyAh4HAQQxC?=
 =?us-ascii?q?A4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBOwcOCjGFew2CY?=
 =?us-ascii?q?gGBJIEmAQEBAQEBAQEBAQEBHQJHRAEBAQIBIwQZAQERJwQLCxoCJgICVgYBF?=
 =?us-ascii?q?AEBgn6CIgEGEAEDDiQHslB/M4EBggwBAQbaXh8sIliBZQmBGy6FbYJkAYYnh?=
 =?us-ascii?q?DwnD4FVRIE8C4J4PoRDg1uCaYImgRaFTZQAUngcA1ksAVUTFwsHBYEgQwMqN?=
 =?us-ascii?q?DEjDzwFLR2BJ3+BThyDHoEbhEUrT4IoAXuBekEZQYNdHgZtDwaBIRs2QAIBC?=
 =?us-ascii?q?209NwkLGwY9kwKDIcowNAeCOIFmgWQMn2kGEy+XTA4GkwKZBSKpGoFpATiBX?=
 =?us-ascii?q?DMaJIM2TwMZD44hhDO8SkE1PAIHCwEBAwmFRgEBil2BSwEB?=
IronPort-PHdr: A9a23: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
 MfCnuT/JWUamzo71dQRDY7YJZDeWEc=
IronPort-Data: A9a23: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
 ajZiF2omH2GdHM=
IronPort-HdrOrdr: A9a23:MdsIsqEuwl3bIYRTpLqENseALOsnbusQ8zAXPjNKOHlom6uj5r
 mTdZUgpHnJYVMqM03I9uruBEDtewK5yXcx2/h3AV7AZmfbUQmTQL2KhLGKq1Dd8m/Fh4xgPM
 xbE5SWZueAbmRSsea/xhWkGNA9x9S9/Lmvnvq29QYWcegnUcBdBxwSMHfiLqSafng8OXKzea
 D32vZ6
X-Talos-CUID: =?us-ascii?q?9a23=3AaWI6xWi5yI7YRgQ6MxtDb0lATTJuLSPjj0yNHUa?=
 =?us-ascii?q?DCH9yGOSpamKR2r59qp87?=
X-Talos-MUID: 9a23:tUiCWQYpTbEX9+BT6xLApDx+O+dR/K2BE0Isn7EKpvuAKnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,273,1744063200"; 
   d="scan'208";a="229433733"
X-MGA-submission: =?us-ascii?q?MDFI7e7olok8/e412saMKItJu5UOuSF/QkwPai?=
 =?us-ascii?q?Jg0jsq9oG7B8pXuMXeKd1B3Qf2dvHX8NiCW8nPn/G7QTW9JF5mhfxI9v?=
 =?us-ascii?q?mpnIK6goBtcCp/nceCW4Vq+zrzy67biF8F19QmRPBQhWmuz74Wt+lefG?=
 =?us-ascii?q?dZqWXsuxiTQxVwa2/T6ZZY6Q=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2025 21:22:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1751138527; x=1751743327; i=markus.elfring@web.de;
	bh=vfEKsrNIlH9BxZhyTKYrIKQ8Hog2Nk1NFLM7C+NWWmM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=NAkcm6lKy9md0dkPcESPTOJ9dfjfkMDIr0o+gCadlrbkMJ408WTilhBSTXUBlnTp
	 1bTNj9+cLbj5nHTiezktw9rpHaLM2COD71f5+hXnkX8j14SBlb3FaHKvhXMR3YCNO
	 hYpLKSkQTgmkqBUHApLhG8X0BBM5Kq3M0kkM0iYlzTiIirQLDqgQ2FhRDINvtX1XB
	 kgn17NHcs4wPHquR1fci6+fjahbeljRSwtLzmCJvEx6Eiy9/kP6yR8FIuFv4XynNX
	 3zJ9/Y1a9j2TJMoih7WsEzx3G1HFbMAll6gIZ4R83Qs8ISjWFO/3V6NaICBujlsDA
	 aZCLGHeECjGhivRyyA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.176]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MCogm-1uMphP1fV2-008fxK; Sat, 28
 Jun 2025 21:22:07 +0200
Message-ID: <1f3bd2ed-0252-4347-835f-5fecda857cf0@web.de>
Date: Sat, 28 Jun 2025 21:21:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <2038c080-a429-44bb-a572-c1f9e733320d@web.de>
 <alpine.DEB.2.22.394.2506281638300.50494@hadrien>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2506281638300.50494@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xs8635ozhA0w6lqaiZMxbzpttpOzFnyoAtVFECwlx9bOsyIiwzZ
 SfSAZpohXyoxZqnlur3rWJps8E+bzGt43GVkNYsK1emf+7wUEmt+RgqsP7xvWWxPPe0vuRu
 FoZUp1mRK6JMfQ8NqNeAgfLtm6/GZHzPumD0t1cPyvOidw9UAhI5KjE/dF6eicIcc+/n32j
 EikTjsMQYj/k1e5LxyKBw==
UI-OutboundReport: notjunk:1;M01:P0:giHu2kXrQ0o=;HQbHGDmgkROn8F/AlHqhywQIxgp
 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
 aUnxG9UpIPw==
Subject: Re: [cocci] Avoiding metavariable confusion for duplicate
 identifiers?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2799
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-06/1f3bd2ed-0252-4347-835f-5fecda857cf0%40web.de>

>> @replacement@
>> @@
>> -msg -> msg [ 0 ] & 0xf
>> +cec_msg_destination(msg)
>>
>>
>> Now I wonder which metavariable selections would be appropriate for suc=
h
>> an use case.
>=20
> I'm not sure what the concern is.

Data processing configuration challenges might become clearer.
I suggest to take another look at corresponding case distinctions.


>                                    If you want a metavariable that can
> match both occurrences of msg,

This is probably unlikely if I would like to refer to a single
function input parameter.


>                                then that would be an identifier.
I would prefer to distinguish a function argument from a data structure
member (despite of identical names in this case).
Can a manual rename be avoided here?

Regards,
Markus
