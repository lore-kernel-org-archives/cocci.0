Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B81BEC83F1A
	for <cocci@archiver.kernel.org>; Mon, 21 Jul 2025 06:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=JS4d7NkkT6fV+IVdOdxZh83O2iD7qj2C9R3mmf7/Qzw=;
  b=N/JDTk82OBuX0jRvgjIenhTJvdSfuHCwPYd0+Wu9QBGSdCvSjMYuVwhw
   LzQwfeuNp9+ezYN0JK+9pP77hIX1ScpT9GWnBWM/TCpAegT+jlGQruqIr
   UDk9TzZbND7hmSf5/v+VrYE/ERcyG5HbEpsLLSPxgrMYDCqxWVaGiNO4h
   U=;
X-CSE-ConnectionGUID: /xImiO/DTrmOaqB0PVT4Og==
X-CSE-MsgGUID: lIue0WTZT2qEQsjhKuh2mg==
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
X-IronPort-AV: E=Sophos;i="6.16,328,1744063200"; 
   d="scan'208";a="232392547"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Jul 2025 08:30:37 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id AF409E0C55; Mon, 21 Jul 2025 08:30:37 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id B905DE0171
	for <cocci@sympa.inria.fr>; Mon, 21 Jul 2025 08:30:32 +0200 (CEST)
X-CSE-ConnectionGUID: K8VUbsRuRHuYPrfKnS4BjA==
X-CSE-MsgGUID: H9xKYFJMSKiIP6MtoQN6WQ==
IronPort-SDR: 687dde88_z1aKZ29MWdjMhbjSNUbCFpT6WsrcMraILyW11ofVqI00uML
 sekV5bV8XUdIL613Bn5TyLWXd1uaMr+oHtZ38Nw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HdAADM3X1og07ASNlaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UEFAQELAQGCQoEGVDMEC0mEVY9QgiSEO4c8h1SIeIFVFIFpAg8BAwENTgECB?=
 =?us-ascii?q?AEBAwSFAAKMEwIeBwEEMgcOAQIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECA?=
 =?us-ascii?q?QECBAYBAhABAQEhGQcOO4V7DUkBEAGCBwGBJIEmAQEBAQEBAQEBAQEBHQJHR?=
 =?us-ascii?q?AEBAQIBIx0BAREnBAsLGgImAgJWBgEUAQGCfoIiAQYQAQMOJAevJoEygQGCD?=
 =?us-ascii?q?AEBBtpeHywiWYFkCYEbLgGFbIJkAYYnhDwnD4FVRIE8C4J4PoQFPoNbgmmCJ?=
 =?us-ascii?q?oEWg2SVBlJ4HANZLAFVExcLBwWBIEMDKjQxI0sFLR2BJ32DCoEOhCcrT4IiA?=
 =?us-ascii?q?XWBeUEZP4NVHgZtDwaBGBpKAgICBQJDRXdAAgELbT03CQsbBj2SYoY6V7Fll?=
 =?us-ascii?q?GI0B4I4gWeBZAyfawYTL4QEjRKGOw4GkwSZBiKpHYFvAzCBXDMaJIM2TwMZD?=
 =?us-ascii?q?44hGYQawTZBNTwCBwEKAQEDCYVGAQGGcYYigUsBAQ?=
IronPort-PHdr: A9a23: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
 BYCh7/1f9x73mjTxEFoLFV3ztyiJg==
IronPort-Data: A9a23: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
 FXZjlyojK12pYAd3Cqgl7No9MklgQ7S
IronPort-HdrOrdr: A9a23:0OAGDKqRDfq8tHqa2iDo+MsaV5oZeYIsimQD101hICG9Kvbo8v
 xHnJwguiMc+wxhPE3I+OrwQJVoLkmslqKdjbN9AV7AZnichILLFvAB0WKK+VSJcEfDH4Vmu5
 uIBpIfNDSGNzlHZKjBjDVQWOxQp+VvuJrY49s24U0dND1XVw==
X-Talos-CUID: 9a23:X5MYdm4q/cgI3OWge9ss1x4qJ8o+SGDn7GrhG1W2KmBSFJeXYArF
X-Talos-MUID: 9a23:Vxu00wa9AQKiFOBTl278pwBMFuJTwKWPMB4ojZI/nZe7DHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,328,1744063200"; 
   d="scan'208";a="121810688"
X-MGA-submission: =?us-ascii?q?MDGISjpwax/L0OjKuMALkfoVSGDjts4mKt1dZL?=
 =?us-ascii?q?X+2r88M4LzewLobQzw3zjcCyUOdsuSH2QqYUcSEjYNRxKOQ/qpgf2gUm?=
 =?us-ascii?q?Rin07NjxdRo5N6EWZh3gvovynVqDjRLdE+WaKvY5IL9DAqswHvg8xLXC?=
 =?us-ascii?q?P4gsyjgIh6T1yQsX6n9gobTQ=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 08:30:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1753079430; x=1753684230; i=markus.elfring@web.de;
	bh=JS4d7NkkT6fV+IVdOdxZh83O2iD7qj2C9R3mmf7/Qzw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=OsDTbb4iZ3UJg+2Tt/kw8idb1BfYJgNJPT0Tq0g1PvdPzyRj0PumqJASpTiT8tYQ
	 h0OR3593ObCUki0Cus8y5iwRHe4sVoln+BBemL5D68MWlAiAG+MMbiGhcLF8NUs1f
	 2Xzkvq37eBb1htER/vAaakywVyEHeCyLp5O1Ggc0FIuajqXBx2kVLMtjW36jt5Bsm
	 wsdjA1IVlpGLU3jQELrS3a6antH+gBJAR6uV06wuuoTy/mcr1yzzdopW482JnGrcV
	 CRwmUiicrwobE6ifVC3VDsGHHvR24IzojRgUasUwcWtyAmd4MG7RT/f+lnC2Ni+IA
	 YtbishraqPOwCh3V+A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.235]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MSqXM-1uAXou2UjW-00K5Jg; Mon, 21
 Jul 2025 08:30:30 +0200
Message-ID: <6fa377f7-0612-42aa-afbc-cdeab8bea314@web.de>
Date: Mon, 21 Jul 2025 08:30:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <0830325b-6697-49d1-a0a4-d06814c6450f@web.de>
 <21f78cc-6034-2b33-c2fb-cdf6d3694d2@inria.fr>
 <fafd85e8-9d04-401f-a4a5-d4286a911264@web.de>
 <alpine.DEB.2.22.394.2507201608390.3477@hadrien>
 <bf7d6619-92c5-4471-a6fd-df4af8b97e39@web.de>
 <alpine.DEB.2.22.394.2507210747070.18950@hadrien>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2507210747070.18950@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/X/DuJ8WyaYKPVdY6MJWEk2dNIcS0vC/XL4NhaUH6+vGiJ9dGvz
 Fdxyy/+P18s9D49mQEDPniflTQEs9onszQSxR9u9N2T+Ckyq8Wcut8yT6UZCP46X/q8lUsf
 36dzzvvA18SfS7Ve1wbEKbeFniBbyQxUUKDzsQNHFk57neufHOZMPa9XxMiYg2lLN2O8N+c
 UxbGT9EBmEgac3eoAbYuQ==
UI-OutboundReport: notjunk:1;M01:P0:U4r2GbE9g84=;JYK1h4rbZpF6wBxVzSAtJvH7b8X
 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
 L6Vp+m50fqwt+1AE+5ltj6E=
Subject: Re: [cocci] Reducing parentheses (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2883
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/6fa377f7-0612-42aa-afbc-cdeab8bea314%40web.de>

>> * Metavariable contents can be reused for plus slice specifications.
>>   Desirable source code adjustments should be =E2=80=9Cexpressed=E2=80=
=9D here.
>>   Which control can we get on the advanced handling of parentheses then=
?
>=20
> I have no idea what you are trying to do,

I find such feedback strange.


>                                           and you are never going to
> succeed with your strange way of expressing yourself.

I hope still that remaining communication difficulties can be resolved bet=
ter.


>                                                        If you want to kn=
ow
> how to do something, please provide a concrete and minimal example of C
> code and show what you would like it to be transformed into.  That is th=
e
> only thing I can precisely understand.

Your public activities seem to indicate that you are capable for more.

* We would occasionally like to transform selected expressions
  (which were captured by instances of the metavariable type =E2=80=9Cexpr=
ession=E2=80=9D),
  don't we?

* Do we care then if it would be needed to specify extra parentheses (or n=
ot)
  for plus slice specifications?


Regards,
Markus
