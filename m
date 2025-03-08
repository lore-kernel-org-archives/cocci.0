Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2992C282EC
	for <cocci@archiver.kernel.org>; Sat,  8 Mar 2025 09:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=8eYsEaIqhduSn8S0gAKbhUmY6cmbv2qNkivM+Za7SKU=;
  b=Ti0/hl0mqs6ISfiN0gMGC1VuLhY/ubFCRfgrv2eaJvgisMVQonLC5He9
   kQOQ0civ3vRT1mu8iA9t3UpCBhDcJpjYCHsv/qc1P+bq9qVIjNiPRuCFq
   oPslbFS6Gxnj8tRji9Bu96sqRtLgpuTXq+oU6OlPVe/JBuyyubVQxUjzn
   M=;
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
X-IronPort-AV: E=Sophos;i="6.14,231,1736809200"; 
   d="scan'208";a="211873438"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Mar 2025 10:07:46 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0E46AE0D1D; Sat,  8 Mar 2025 10:07:46 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 59BD1E0260
	for <cocci@sympa.inria.fr>; Sat,  8 Mar 2025 10:07:40 +0100 (CET)
IronPort-SDR: 67cc08dc_leztzntCB4N5GskZhvATiZ8voNrdaQNeqYnzlZmjVBZjRsk
 wPGLHoXyqOzTGlR2eU4C9iNHbLc9slFz4vrC39A==
X-IPAS-Result: =?us-ascii?q?A0HeDQDcB8xngQsR49RaHQEBAQEJARIBBQUBQIFCBQELA?=
 =?us-ascii?q?YJDgVczBAtIhFaPT4F0MIQ7hzuHU4h1g1QPAQMBDUEBAgQBAQMEhQACixoCH?=
 =?us-ascii?q?gcBBDMGDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQE7Bw4JA?=
 =?us-ascii?q?TGFew2CYgGBJIEmAQEBAQEBAQEBAQEBHQJHRAEBAQIBIx0BAREmAQQLCxoCJ?=
 =?us-ascii?q?gICVgYBFAEBgn6CMAEDDiMHr0+BMoEBggwBAQbaXB8sIleBZQmBGi4BhWuCY?=
 =?us-ascii?q?wGFWxA7CYM5eicPgVVEgTyDAz6IHoJpgjOEQGeaAY8gUnscA1ksAVUTFwsHB?=
 =?us-ascii?q?YEpQwMqNDEjD4EUBTQKNzqCC2lJOgINAjWCHiRYgitqBAWBJII3hD2EP4VSg?=
 =?us-ascii?q?hGBXQMDFg8Bgx93HINMdjyEaS4yHUACAQttPTcJCxsGPaJXhEFatGCUXjQHg?=
 =?us-ascii?q?jiBZoFjDJ9eBhMvg3CTVg4Gkn2YfiKpETWBSCSBXDMaJIM2TwMZD44hDBaEC?=
 =?us-ascii?q?8cxQjU8AgcBCgEBAwkBgVWDcAEBilSBSwEB?=
IronPort-PHdr: A9a23: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
 EPv
IronPort-Data: A9a23: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
 YT4qa6oja17pYPM/R5cRkNo
IronPort-HdrOrdr: A9a23:u5vP3KgSeDZfmqEOBzebeLbHB3BQXg4ji2hC6mlwRA09TyVXrb
 HNoB1p726RtN93YgBZpTngAtj4fZq4z/VICOYqUotKMDOW31dAabsSi7cKoAePJ8SdzIJgPM
 5bGsASNDSzNykesS+Q2mmF+rgbsbq62ZyJwcHD0nxqUQZmUK146RxlYzzrb3GeCDMmOXIjfq
 DsnfavSgDQA0j+5amAbEU4Yw==
X-Talos-CUID: 9a23:JQUApGM2lLHxru5DRhR9+xEFGvseXT70wmrBEUKkO2lFYejA
X-Talos-MUID: 9a23:HYvRKgh+XynEhfWpT1gsU8MpGsdmuISkUWUxk7JaouKNFXVXfDGig2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,231,1736809200"; 
   d="scan'208";a="211873435"
X-MGA-submission: =?us-ascii?q?MDFo/lot9f3BxgU6emoNJ0pYgBb7wZ2F+TyKba?=
 =?us-ascii?q?lKhVNFPpHjopeFEwmO4hE7tDLNOrZpCVzPI9kASVFZxhzQ9WAb94+H7v?=
 =?us-ascii?q?DnkS/8gOZnSMYRQeog0bFXOpVWxbxmWa5L0NXmtQcYFtUXYoiOrs1wlM?=
 =?us-ascii?q?ydybS9zjxrDo066Z+jDPONCA=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 10:07:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741424856; x=1742029656; i=markus.elfring@web.de;
	bh=8eYsEaIqhduSn8S0gAKbhUmY6cmbv2qNkivM+Za7SKU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=wGYTLhTgHK/vqQKxNvwQch3yRa4zV/82s2qX9S63kflvODDFLG+zYpJPSn6QyDgz
	 FOuTVnw3Q0MOSKGq+zwkpyt6PPQXMw62R6MMq61vmk39OwFei2ZiCHSFuyOkO5vQG
	 iJSmfoJl8inZCP/2p45wpVgZa9RjU566CP7OrNRi/cyDnS0f3iIxMnHidvExzyvO+
	 dE2BrpPU9OfByezlhkgLpAmCzgopc/I4PEo5ytrrJbw3qUnqofEfgB4/QLjgZGOin
	 J970Fpg7+E4M2UDrLGt/GSL0KW36ZeGUbHx9lHD0bpUBcWUqoUI44cjRcui1fTw+/
	 2jalr95/Hgc6BKgWjw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.79]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MuVKK-1t0njW08VW-012aOa; Sat, 08
 Mar 2025 10:07:36 +0100
Message-ID: <fdf1c4b6-9f0d-4c27-a668-65cc5926ab3d@web.de>
Date: Sat, 8 Mar 2025 10:07:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jacob Keller <jacob.e.keller@intel.com>, cocci@inria.fr
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
References: <67642477-5f3e-4b2a-914d-579a54f48cbd@intel.com>
 <c3991582-ecb1-4b7a-b2d9-057a6be1d7fd@web.de>
 <90c4769b-0247-492f-a137-fec1c970eaf5@intel.com>
 <8bc6d266-cc33-4f77-93d8-b12f2086449e@intel.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <8bc6d266-cc33-4f77-93d8-b12f2086449e@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:V2mBY5a3gGwNMUiRieIEEy8RK0yTh8fG4N0MyVigmk3d2HbCdlp
 ZV3h75mHatXdFhzJbd3hlaBLPksF+C/3xhBxlTH+A/uKWrqHk/DgkAXq0CfHcOWH086i6y3
 5jX17TyQE62aZFzFCFQY/XZhcr6U56HUCSCmLqEycuALwPEk6pxFv1cmGVkdr8Bx/d1Xp0Y
 s8kCzhs6F/An8PXNprUXA==
UI-OutboundReport: notjunk:1;M01:P0:KKEJBICOf3M=;iBPfs5Wc6XB2wCgA1lDwS9897Wy
 4v5PjKF0fqrSIR8xDQoW6XC6yOQGalGJj5cLOxhBv3ODLoPkEjI06GLzIHFCvGFJE7NemX5OR
 STgW1SlCu+GTDpb+DNl2U4WorttkGE1L7y2NM9oAtgblLvVgEsOdxHiEUNHo8UwEFtoUtRCEM
 LmFUYUFvupuOBwb0biWzCTRNYo2Y9zqJYBBnDuqYzikzA+Ha06a3I8V5r7touGc1lX2oCVyvF
 3Qc6Jg9XJCyrNSTVBXpW4SzhcTHTYiOTBZC6xtK6W+HUtd3sep0Eucd37ZZMH6sq4dbuSIcrb
 fwRcTFZdU9tHxySTweJE2utykmiTmm5Q97Yw9nw411UT/ZCP5HhRqgcvM1HPZh9zfkR+0/8OM
 ziBvdD3WQqhpkSH+nND6je34R0ZjB3y7FMtWe6fC6wofSF1pphjmLTpmdfMxtyUMpIRD4URBi
 HUwsFhVIEdgHyP/ZzICUGicClaaz5RkMoyaW6rZ9UFuLXO7c8WnLwmsvomgaY0FOQoVssAhd5
 jfcr3k/oY20TaZxmFNzA8YDJ7k8sSuzvQdJezWsuVEOMsMR7MoehUs91Reg+jgZ+wqT5MFE4p
 PrQkM+fc3Bzqn/1mWaeMVWK7mqMbgYCdeI9DB00TNK+HykNIyXPVnzrLuk19c6EfZ8i+zUNO+
 8/6FXDlMjEeY5HvwCgj9L/vjH5jH67Ti9h97gZAWmhLFwl06Re+uBBFigzfr8q/uujqNrT956
 pozs6O1vW6aU/D7Gryt4TUDdoSGlB5wifbkhHpNvzcYYLV6Mp135lQyPaSnl7k3+Pw5zdVkdD
 1v17hygLgXPVcF7KO7MuVPVGA3weB+elnS2g88/TYqLsWxm1k8dLWKlDugG5FX9NcdVnUTag5
 g0NbsHfnp1vGL6Mng8ELWLJoRzU0M90WgQRuzZQwwWv0ohUWWp2xzQf5estWPbaOi2bR5UwUH
 ZkI5oJJkxzsrZG2vAs1y7RhIJlRRpMnwdTczPcTeEZE6OdzJWwL7Oohj5JLamQrX9nUtK0c1w
 puwqzVgNhwNBE3QT7y2rtDtjxhxClPS10pbk7aW9beBUi3z6kCM9BIbgaTbIayDqTu0CohMPf
 20BQkpE3OUqA7k9JfpAMC0aukotErkPOArVx92p3Fz3ufaqlo3+w8D5rvmzJMKitgsdVFeUz2
 YuyrpoJQ/zwcqOaBqbUHerPSQvugejWGCteSN5NRVNNeHKJgmCrIn8gwJUlsbAwG2W2iPVxgw
 +zVWYmrfcV06ny0ct0zbKEOYdAHYOy93hbvsVX5wlUAC3ikZHGGIeUfDe3md7Ix+/vVihtsm2
 wPESIcwHDoh0fFDnHWVFeYcIEO0qTJpXL++rsTzd1ZP0CInTsr/l6PdJSMRzBvDqLopJRYbDm
 4CnL8g2wxIudGOy4cWMOUcgCBnwRHKnzDL2KPW6MpymDGAmZy6KROTvJcb2pD0b8EmxZXMCTb
 TCodaGn/ooukFYGClicMdalezBXo=
Subject: Re: [cocci] behavior change in semantic patches since c36b51ffc889
 =?UTF-8?Q?=E2=80=A6?=
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2577
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/fdf1c4b6-9f0d-4c27-a668-65cc5926ab3d%40web.de>

> For what its worth, I was finally able to get things working pretty much
> the same as before with the following semantic patches:

This is a nice feedback.


>> @@
>> expression hw;
>> @@
>> -ice_free
>> +devm_kfree
>>  (
>> +ice_hw_to_dev(
>>  hw
>> +)
>>  , ...)

Did you observe that the omission of a semicolon at the end
triggered desirable effects?



> and
>
>> @disable drop_cast@
>> void * void_ptr;
>> type T;
>> @@
>> -(T *)void_ptr
>> +void_ptr

Would another SmPL code variant be occasionally helpful?

-(T *)
 void_ptr


Are there cases to consider where casts should be preserved?

Regards,
Markus
