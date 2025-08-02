Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD9FC87FD2
	for <cocci@archiver.kernel.org>; Sat,  2 Aug 2025 19:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=+Ox203jxpu9cjv3fkgO+xNhs3OfZ7xqpcKlP32S5qtQ=;
  b=hSsm7i3kqmFGTanFcYFscPL7mhjgl7tp2b15ro8hEqm5TI9qp16knA6o
   zpTwb+8NsXTxi7AVSWLU9c0MrmJxBcdOmCasVYHx1/H9ZpC96gTsJnO9b
   nHbiH7mmqnjvXR8WKg8fk+bcRbnXmhIIoW3uPleLyLgnppMbMlBqPkLQ9
   A=;
X-CSE-ConnectionGUID: 3opMW4o3RRirs3EZRot9lA==
X-CSE-MsgGUID: bxRqitFeS+OBfw3HIi0HRQ==
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
X-IronPort-AV: E=Sophos;i="6.17,258,1747692000"; 
   d="scan'208";a="233971546"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Aug 2025 21:26:52 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C8AB6E0B0D; Sat,  2 Aug 2025 21:26:52 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 16163E0171
	for <cocci@sympa.inria.fr>; Sat,  2 Aug 2025 21:26:48 +0200 (CEST)
X-CSE-ConnectionGUID: 4ESnimuFS1SQzV1XB8QOXQ==
X-CSE-MsgGUID: pCHVzWpDTYWeSx9gwAQ6Aw==
IronPort-SDR: 688e6677_C1jaJpjm8v6MAPEOYb8FSxOoigUdBpfLK/J8v1MMRgErDys
 fqpikjtlKcyJAWN6xS4oPl8DoV5bLYKB2MOu0FA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FmAAAnZY5ogA4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDgQAGVDMEC0kIhE2IHIc0giSEO48RiHmBVYF9Ag8BAwENSgQBA?=
 =?us-ascii?q?gQBAQMDAYIMgnQCjBoCHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEBAQENAQEFA?=
 =?us-ascii?q?QEBAgEBAgQGAQIQAQE7Bw4KMYV7DYJiAYEkgSYBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQJHRAEBAQIBIx0BAREmAQQLCxoCJ?=
 =?us-ascii?q?gICVgYBFAEBgn4BgiEBBhABAw4kBw0GsDSBMoEBggwBAQaBRgUNQdhFHywiW?=
 =?us-ascii?q?YFkAwaBGy4BhWyCZAGGJ4NCeicPgVVEgTwLgkcxPoJhAQOBXoNbgmmCJoEWg?=
 =?us-ascii?q?2M2gjOKG4hwUngcA1ksAVUTFwsHBYEgQwMqNDEjSwUtHYEnfYMNgQ6EJytPg?=
 =?us-ascii?q?iJ1gXlBGT+DUx4GbQ8GgRUaHi0CAgIFAkNFgWAZBhpAAgELbT03CQsbBj2TV?=
 =?us-ascii?q?IMhaFlUgSk0ll2vbDQHgjiBZ4FkDIoulT4GEy+XUg4GkwWZBiKNZps5gWg6g?=
 =?us-ascii?q?VwzGiSDNk8DGQ+OIYQzgQu8IkE1AgkxAgcBCgEBAwmFRgEBi2WBSwEB?=
IronPort-PHdr: A9a23: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
 BI72FMWXA==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:JWko2q3DabXLCekCGmHn7wqjBGYkLtp133Aq2lEZdPWaSL37qy
 ncpoV+6faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SOzUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyUMbEQt6bHCWeDYrUd6eWmtIa1mOzZ03Bhdg1ybbp8hj0JdzpzXncWeOFcb6BJb6
 Z0C/A33QZJ8hksBPiGOg==
X-Talos-CUID: 9a23:OzTYkW0lGeCtzbkTyFWeQLxfRu0edHzY0VnrenSBG1gweJfFcHigwfYx
X-Talos-MUID: 9a23:5127cgoEMijje4Ho5cwezylJFPl63LyCNHEynK4W6sabHBUuEijI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.17,258,1747692000"; 
   d="scan'208";a="122667948"
X-MGA-submission: =?us-ascii?q?MDEjHTE8AfNEUqfrWltj6AS0cNEHJXtRIHfmeQ?=
 =?us-ascii?q?T4cnqwdK1RXBeS83JP80eIZ6ib6g47OKy5eI1MKSdhguF401xzJa5tnu?=
 =?us-ascii?q?1hEbydWJLOXVxGi0BB6paZq3pUmsVV0gM7T83gTAogaAUNYRG/oZzHPA?=
 =?us-ascii?q?rxZqcZRCCvbxOerxe3gNlxng=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2025 21:26:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1754162806; x=1754767606; i=markus.elfring@web.de;
	bh=+Ox203jxpu9cjv3fkgO+xNhs3OfZ7xqpcKlP32S5qtQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=awIR0DOLdhYhjm40kTcj8Pk26PPW1AVkg5o42sq0OMjWeAfp9ubrUETWB5uDYssS
	 y3C6/Kw+bqclvRO1YAl9dOoQ/B7NGlmvvHf32QBUh5fG0p9Mo7P9T5+IKyP5P7CEi
	 Yica2bO6JCvjGDoQQRrSAcbyUCtPg/8ymINo0/Qr6EmnSsFMbqHGIAm8qFdsHLbD1
	 bJZggpvd8xknzd4phS9i37/+lCm7hQ2FubdGwv/EXwZ2990Rux4Tn4U0Oc0kP8aGP
	 /nCJdZ7DwbzuV+uq7ZV67pyuDwsE1Ty2SyS0YCJ3gSNqmWSQk7gPmsyn/g0dXyy1z
	 jvmMUpdPCm01raQY+A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.1]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MODmf-1v2Jpf1eFV-00RSkw; Sat, 02
 Aug 2025 21:26:46 +0200
Message-ID: <7743d469-fc0e-4575-b05d-72a072c1bbb4@web.de>
Date: Sat, 2 Aug 2025 21:26:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Erick Karanja <karanja99erick@gmail.com>
References: <6daf83a9-abbf-45f7-b82e-c6207364fd8b@web.de>
 <70a43c52-f898-4fa3-a4b3-16c54bd4f9cb@web.de>
 <c1d74aa4-44db-4618-ba59-e9b6dab28c0e@web.de>
 <alpine.DEB.2.22.394.2508021326250.3428@hadrien>
 <7560a81f-ba29-4b16-b8ed-95cb4d72f3f4@web.de>
 <alpine.DEB.2.22.394.2508021353080.3428@hadrien>
 <e0519749-0043-4cb0-a12d-6a34e2076f58@web.de>
 <alpine.DEB.2.22.394.2508021409080.3428@hadrien>
 <c5042d2d-43df-4276-9611-da4f30763940@web.de>
 <alpine.DEB.2.22.394.2508021502250.3428@hadrien>
 <6239d52e-3213-4083-8d97-9b1f59d2d5b4@web.de>
 <alpine.DEB.2.22.394.2508021745180.3428@hadrien>
 <2130ab11-8ec0-4e57-9a73-5e1ac9e41f7f@web.de>
 <alpine.DEB.2.22.394.2508021803360.3428@hadrien>
 <51664351-746c-4d7a-ae45-2a610ba45176@web.de>
 <alpine.DEB.2.22.394.2508021822490.3428@hadrien>
 <5e8e1f8a-6832-49af-bca5-41d2a13b1322@web.de>
 <alpine.DEB.2.22.394.2508021935250.3428@hadrien>
 <a86ce687-61a5-4e52-92fa-6a0d53db9360@web.de>
 <alpine.DEB.2.22.394.2508022111230.3428@hadrien>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2508022111230.3428@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XMftMpR0fm61EwkcBfDKheDNrqf/6vwUJwrfwJxXD/XOcB6liNB
 cRnHMTSaNj73nrAeaOHuaeY70oYNprH6CBZ5az7beGCwnOPPB4I4dKWUcC+xKUlTl4MpbqU
 mUQzE8QeAe7v7Ka5ATaPb7VIj4aA7FcWB0k/5GafycLFHBY5U9io0ayZ5E3RPpNwP6aAufA
 82VTZb+xL7dgJ2vHNsvEw==
UI-OutboundReport: notjunk:1;M01:P0:gjarS7Oc2rU=;eBcAo2cwruEEikhqsnCTMNxHdxA
 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
 UYsH1xWuhfNEKQ=
Subject: Re: [cocci] Searching for lock calls without unlocking (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2947
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-08/7743d469-fc0e-4575-b05d-72a072c1bbb4%40web.de>

>> It seems that this software behaviour (according to the functionality =
=E2=80=9Csemantic match=E2=80=9D)
>> was not officially documented so far.
>> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/3aa9a6ab3b035e3129=
2be31399b99a8857480aef/docs/manual/cocci_syntax.tex#L1214-1225
>=20
> The cited text seems totally irrelevant.

I hope that the SmPL manual is relevant so far for the determination
of known (and mostly desirable) software behaviour.


> You do know that
>=20
> @@
> expression x;
> @@
>=20
> - a(x);
>=20
> would remove all three calls. right?

The software behaviour might be unclear also according to
the modification incidence for this source code transformation.


>                                       Why do you expect * to do somethin=
g different?

I am trying again to achieve more clarity for better software documentatio=
n.


>> It should be possible in a simpler way to point source code places out
>> which start with a selected function call combination.

Which development ideas will evolve for this use case?

Regards,
Markus
