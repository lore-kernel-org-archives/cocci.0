Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DC49C87FD2
	for <cocci@archiver.kernel.org>; Fri,  8 Aug 2025 08:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=zI256zg/cDqrrrzEnaYFJjTemkEnMhVI+ef4q4j6izE=;
  b=AU5w3M3M3FW10FRGbk3MzbmiMdAoNQPowOWFdm2eYt7k52D02ZhdvtVV
   CjhHCO2pcaeV3W2c4SCUb3e9S5cSAyEQTEfAuIemiaOU6poXxnIIPbL09
   pJGAukvAxZ/ft1ebEO7W8nuMLfawqo+3mBLB36W+apePbeNj0ttS1nZes
   M=;
X-CSE-ConnectionGUID: bgtTPLjFRhS156nd6iVfdQ==
X-CSE-MsgGUID: LFpvYR5rR/ykoysMRHOUig==
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
X-IronPort-AV: E=Sophos;i="6.17,274,1747692000"; 
   d="scan'208";a="234523428"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Aug 2025 10:15:25 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B0643E0BE9; Fri,  8 Aug 2025 10:15:24 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 7172EE0171
	for <cocci@sympa.inria.fr>; Fri,  8 Aug 2025 10:15:22 +0200 (CEST)
X-CSE-ConnectionGUID: TwYM8E5KSpap1tAfbnReVA==
X-CSE-MsgGUID: M0zJDUr9Tz+lkX+9SsRG7Q==
IronPort-SDR: 6895b21a_1L2HXyiV0DizfeHnMAPl0+PvbAac3AnAAcrKjntUeRPv5WE
 RgaqfUFNebvsaJowAXgFY2psRUcqqZBk+3jIK0w==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FLAwB6sJVogAMP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UEFAQELAYJDgQRUMwQLSYRVj1CCJIQ7hzyHU4h3gVWBfg8BAwENTgECBAEBA?=
 =?us-ascii?q?wSCDIJ0AowiAh4HAQQyBw4BAgQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBA?=
 =?us-ascii?q?QIEBgECEAEBOwcOCjGFew2CRQEEAQEBAQEBAQMDAQEMAYEhgSYBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEXAkdEAQEBAgEjHQEBESYBBAsJAhoCJgICVgYBFAEBgn6CI?=
 =?us-ascii?q?hUBAw4kB5oRnEWBMoEBggwBAQbaXh8sIleBZQmBGy4BhWyCYwGGJ4NCeicPg?=
 =?us-ascii?q?VVEgTyDAz6EQ4NbgmmCJoEWg2ONBIIAhxhSeBwDWSwBVRMXCwcFgSBDAyo0M?=
 =?us-ascii?q?SNLBS0dgSd9gw2BDoQnK0+CInWBeUEZP4NTHgZtDwaBFRoeLQICAgUCQ0WBY?=
 =?us-ascii?q?BkGHgYiEUACAQttPTcJCxsGPZNuhx/FIYEKNAeCOIFmgWQMn2cGEy+XSg4Gk?=
 =?us-ascii?q?wKZAyKjdYUggW8GLYFcMxokgzZPAxkPjiGEM7ZOQTU8AgcBCgEBAwmFRgEBj?=
 =?us-ascii?q?EEBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:0EP2CqGfrz2/O7wMpLqEPMeALOsnbusQ8zAXPo5KOH5om7+j5q
 STdZMgpGfJYVcqKQgdcLW7U5VoLkmyyXcY2/h3AV7mZniBhILKFu9fBOnZrwEIcheWnoNgPO
 VbAs1D4bbLbWSS4/yKgzWQL/Zl5sWb+6a1gurkw25qVhwCUdAc0+40MGem+lYdfng8OXPVLu
 vn2iLNygDLRUgq
X-Talos-CUID: =?us-ascii?q?9a23=3Agym3w2tBjCZ8iAhlGuSa+KYn6IsZbUz4nFqNAHS?=
 =?us-ascii?q?gAH4wVJSbQ1mq9Z1Nxp8=3D?=
X-Talos-MUID: 9a23:6OwHYgoXH2KCObPICGkezxQ6JuVE3r7/NFJOlZY2+Ji/LhZfZA7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.17,274,1747692000"; 
   d="scan'208";a="234523424"
X-MGA-submission: =?us-ascii?q?MDErs3Sdn/9X/uskLWziuqwyj6vnVjeXOQyY11?=
 =?us-ascii?q?Rj0kRV2c8CmkkdShRzwXOTZDQS0+GHuMoG2ZF9n/8prbolv3r4ytW/Pi?=
 =?us-ascii?q?kHMDlSzK9Pj9bQyuMbVTD8EyXUcC18cNzxtnmtUhbmLncUvv8Pt0gwtr?=
 =?us-ascii?q?+A1ah2TcCP+3slH1Z0To8cKw=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 10:15:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1754640921; x=1755245721; i=markus.elfring@web.de;
	bh=zI256zg/cDqrrrzEnaYFJjTemkEnMhVI+ef4q4j6izE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=W7rTQ+yck0RMKEFc7CtYnL/SR5AVViGki/PxAwpZk0zCHRVHsSCUusYJ1pwbhwRQ
	 xWmyvJP+VhLaCe3eChvQ0lyBUR2kTFqCnsDhX3JJiT0E37/54B4zLCmGivl+rgyLG
	 yQQmY/JNw5a7g+378+F1OjSwKvXhn0r5vY3GTJUgkjvhdEnnSLtRY2OG0rpcSazSZ
	 sd8lFkDcSmyCZVLS4tpPkBOPKcdjY3jUdUWrdZa64qm+WIn1ee3gU6GWqrKoIceqk
	 viFltv7aMiA2Ip/XcGXAI7bLSIbyiw7i0ALDYztMfYCKyR5psxxOMzkLk53hU+ip5
	 KtUbImu53sqQ+8r9uw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.242]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MdwJO-1uAPXj2K5G-00n6q7; Fri, 08
 Aug 2025 10:15:21 +0200
Message-ID: <22cfa841-e385-4d02-be5e-ae7c88188d5d@web.de>
Date: Fri, 8 Aug 2025 10:15:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Michele Martone <michelemartone@users.sourceforge.net>
References: <0bf5c015-bb4b-42ff-9734-d7de549417e1@web.de>
 <3a88b6dc-cdca-79d1-9a4-72ca8c465c5@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <3a88b6dc-cdca-79d1-9a4-72ca8c465c5@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IVuQhyKURzseHhQPmpxbHRKKaSxYJe/OzhM7RlDLWPPk5wiWNxv
 UrvGHIfyp2B4hVQgYocYi13iROJ3CRoeorfpefulMgD1gcgbuVWrLmVnAnwTaKoBeIEgGFy
 gAtmS5CWz2XP3jPm1aMlJgEhIMWcGOqRRzVa5hpuf1vTwg0hTPHZZR7dsv/BwVQsYhCPGhu
 FBe/ti3K4noEw+SBzDUUA==
UI-OutboundReport: notjunk:1;M01:P0:WPkvg5iLycM=;5LCFJYiAXd7cUt+Do0M8Cd+n2XH
 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
Subject: Re: [cocci] Searching for C++ delete expressions (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2969
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-08/22cfa841-e385-4d02-be5e-ae7c88188d5d%40web.de>

>> Another SmPL script example:
>> #spatch --c++
>> @display@
>> expression e;
>> @@
>>  delete
>> ?[]
>> *e
>>
>>
>> Questionable test result (by the software combination =E2=80=9CCoccinel=
le 1.3.0=E2=80=9D for example):
>> Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/janitor> /usr/bin/sp=
atch --parse-cocci show_delete_expressions.cocci
>> =E2=80=A6
>> warning: incompatible arity found on line 5
>> =E2=80=A6
=E2=80=A6> In general, I don't think you can put ? on random subterms.

How will the support evolve further for key word variants of the programmi=
ng language =E2=80=9CC++=E2=80=9D?


>                                                              You could d=
o
> what you want with a disjunction.

Under which circumstances will the mentioned =E2=80=9Cwarning=E2=80=9D be =
reconsidered better?

Regards,
Markus
