Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 737C6CEB2CC
	for <cocci@archiver.kernel.org>; Sat, 15 Nov 2025 13:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=cFE+vQMOuo60iq1xEFW8H4o+w11gj3Rc0cuXDjdbQMA=;
  b=OAwiB/9iICsvLqAoiyIuPL+xFk1GNyG/SegWv5pYGHimwRD1mQlhSapH
   PhmVdiDzI+ukrs2GKYiXIx6pMVsAevuzX25vlIntvdh8Ok8Xziqcwmw3g
   1kJMhW85uQW7e25589R5TRl3zDBVfAfwpo/5Wag22QoVmYgfKA6dKL/jW
   k=;
X-CSE-ConnectionGUID: nkVBDfbrTNm+vYBO93p/mQ==
X-CSE-MsgGUID: Q5GCQuHKQHCc/EVGaOvtSA==
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
X-IronPort-AV: E=Sophos;i="6.19,307,1754949600"; 
   d="scan'208";a="249323971"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Nov 2025 14:14:25 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8D2FFE0BE9; Sat, 15 Nov 2025 14:14:24 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 4FA4AE0171
	for <cocci@sympa.inria.fr>; Sat, 15 Nov 2025 14:14:23 +0100 (CET)
X-CSE-ConnectionGUID: 6T1eold4TG66yb8/BQbdcQ==
X-CSE-MsgGUID: KnUx/9vNTXG8QaAnSoFxBA==
IronPort-SDR: 69187caf_zLrOfq0S1j5gqadPQB3xPO832lky7coxo8dcSpY2qSwlxZH
 mF6KL/J6cGudtk+zikTmB4w6NNgjasF/6n2ylAg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HICgAHfBhpgAMP49RaHgEBCxIMQIFSgj5lHV4zBAtJC?=
 =?us-ascii?q?IRNj1OCJIQ7jxGMSwIPAQMBDUoEAQIEAQEDAwGCDIJ0AoxbAh4HAQQ1BQ0BA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEBgECEAEBOwcOCjGGTw2CY?=
 =?us-ascii?q?gGBJIEmAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QECR0QBAQECASMdAQERJgEECwsaAiYCAlYGFQEBgn4BgiIBBhABAw8nBw0Gr?=
 =?us-ascii?q?xGBMoEBggwBAQbaXx8sIlmBZAMGgRwvhW2CZQGJbHonD4FVRIE8C4JHMT6CY?=
 =?us-ascii?q?QEDgV6DW4JHIoImgQ6QbwaIb1J4HANZLAFVExcLBwWBIEMDgQsjDzwFLR2BJ?=
 =?us-ascii?q?CIfEAgTYD0XQINJHAZoDwaBEhlJAgICBQJAOoFoBhwGHBICAwECAjpVDYF3A?=
 =?us-ascii?q?gIEghx+ggoPiTWBCQUoAgELbT03CQsbBj2VHlGDOyyCMQzGPTQHgjiBZ4FkD?=
 =?us-ascii?q?IoulT4GEy+DcZNhDgaTBR6YaI4IlXOFRoIAIoFcMxokgzZPAxkPjiGEM4ELw?=
 =?us-ascii?q?yNCNQIJMQIHAQoBAQMJhUYBAYxWgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:mtyZTKgRl/nAFBzZ/or7U4MHVXBQXg4ji2hC6mlwRA09TyVXrb
 HNoB1p726RtN93YgBZpTngAtj4fZq4z/VICOYqUotKMDOW31dAabsSi7cKoAePJ8SdzIJgPM
 5bGsASNDSzNykesS+Q2mmF+rgbsbq62ZyJwcHD0nxqUQZmUK146RxlYzzrb3GeCDMmOXIjfq
 DsnfavSgDQA0j+5amAbEU4Yw==
X-Talos-CUID: =?us-ascii?q?9a23=3AKjhFlmvF0rNoRg2tOrIAhgPq6It7TiTQy3Pcf3O?=
 =?us-ascii?q?XVzh4Qu3SY2aa9Khdxp8=3D?=
X-Talos-MUID: 9a23:i+bBDQs3cQ/pcyxp0s2npzdfJIA5/YKSOG9dqJwvvfKDGzxaEmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,307,1754949600"; 
   d="scan'208";a="249323933"
X-MGA-submission: =?us-ascii?q?MDHD+IJNB1hhzLwWBRsqMZHWVkJlwC2vk+cgd2?=
 =?us-ascii?q?mtotS31QlJ4JPTxUpyAkyr1amnLGy7CoXHju/ebLvG1FLH1bGxW/1xwF?=
 =?us-ascii?q?11FwE0s6W3Jc37j/uafsiJ0hmcw9r0kMXXP0YRdLzAsdpwFCvSzCsFFw?=
 =?us-ascii?q?pq6rH3qgwL/cs5Ro3t1os2TQ=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2025 14:14:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1763212462; x=1763817262; i=markus.elfring@web.de;
	bh=cFE+vQMOuo60iq1xEFW8H4o+w11gj3Rc0cuXDjdbQMA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=RP4qB+lyA1fBROiyJVCnbJTwCWnnZUxKzFeSBlPOmWP2EAE30jwSwpVvNuFyE7kn
	 loWdBOfYjmhhK+x04DmT56xDp7o7/O2WrNjs8QatSKJtTBXtfhyWY4RgkEeN2sCAb
	 WzssLmwsNMjGnSFxIzAxsowdpmRTRBy7n/aQ3Ly4rUVLr1liJpodtF4PGe+5sapLo
	 hJ27VnVQOu5SpidQX0seZfUNEOXfJzN2skixu++E1KGjJPpnvL5Npjbe14pyA/gO9
	 yYICGv1RDy6YmwLg3EbuF8a7QNJCDdPLMNbGOdns/Fkqxp8rO12sNHnZkJ9JmLRjL
	 IULpzjISfvAJOKspjA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.174]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MMXx5-1vdiGX0iN5-00Xk0c; Sat, 15
 Nov 2025 14:14:22 +0100
Message-ID: <db4db6ab-2c9a-4577-8377-a513ca6d30ec@web.de>
Date: Sat, 15 Nov 2025 14:14:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <f29ecd7d-5841-4989-b3c9-1055a6df5eec@web.de>
 <6eeb6db9-5726-c0ea-3d1d-e42bd19eeaea@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <6eeb6db9-5726-c0ea-3d1d-e42bd19eeaea@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ordnI1i+C8sTJkAvjjNvfyBaQH4M4722wFTMCvzSPoJGiTBoD3d
 X/v3lDBmmer/+OAgyy69HzO8E7YvVY9eV9EjGBDrT/evSkSmzOLs93m50ywCk3oqhDHfOG8
 j9BD3u3SXrn5lsDgQmmbskSwiw9KOdNS+0jPVCS2zKNs09GazXYTABf9kK6Yt4EHzRyeXuD
 H0WdCJMqR0wAit4rmE+DQ==
UI-OutboundReport: notjunk:1;M01:P0:tFfiVL+AuLA=;l2k6rzooTc4n9Sp5gVV4B/aQLXJ
 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
 1ZCWmDopnmhMO+NAQMUdV7Y1QpdZC
Subject: Re: [cocci] Missing file filters for data processing with SmPL
 scripts?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3181
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/db4db6ab-2c9a-4577-8377-a513ca6d30ec%40web.de>

>> Under which circumstances do you observe the information =E2=80=9CNo gr=
ep query=E2=80=9D?
>> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/e6f8731b851f5d76d2=
731a9d546dc4f0b181526e/testing.ml#L660-679
>=20
> When it seems like the query is too complex,

Can views be reconsidered for SmPL code complexity?


>                                              or when there is nothing
> useful to grep for.

Occasionally, I got doubts on software support for selected SmPL script ex=
amples.

Regards,
Markus
