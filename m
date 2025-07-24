Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE27C83F1A
	for <cocci@archiver.kernel.org>; Thu, 24 Jul 2025 09:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=CgFYwKUIQRiQBxox5xxeR6YMYFvymrDTLhnGoQwDVhc=;
  b=kMi0D8y9nVzn2oFRjU2VEhHLvA/ZQrADaex8zcUv9D16A3MSv/h6f0X5
   wo0/v10t2AAKP/6GNUtXY3JvznzSsAKHt7+STDl417dnFtSlXMqenyHf7
   b1xFwkyT3VbaH0+qSb296Tbhgxc499RN3w98ZDePAhdBHKIGTtIARfK69
   E=;
X-CSE-ConnectionGUID: g3UxJLpISAikDyRfevudvA==
X-CSE-MsgGUID: Tv0pkilMSsCBootAz2PdYw==
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
X-IronPort-AV: E=Sophos;i="6.16,336,1744063200"; 
   d="scan'208";a="232923075"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jul 2025 11:30:27 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4C69AE0C55; Thu, 24 Jul 2025 11:30:27 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 3C85FE0171
	for <cocci@sympa.inria.fr>; Thu, 24 Jul 2025 11:30:25 +0200 (CEST)
X-CSE-ConnectionGUID: VmHt0PUaRWqfkX6cPH5fxw==
X-CSE-MsgGUID: 769DXQgWSSClL8jHEjrKPQ==
IronPort-SDR: 6881fd30_srVpgvAxgAPv+I3FmmJuQQNH1cgkdvsXtPggAyxsaZS7vdy
 Kj7fOLv6LM3qba2/PLaMib19kuu8CPfa3aiQV/g==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FNAAAk/IFog07ASNlaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDgQZUMwQLSYRViByHNIIkhDuHPIdVik6BfQIPAQMBDU4BAgQBA?=
 =?us-ascii?q?QMEggyCdAKMFgIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECA?=
 =?us-ascii?q?QECBAYBAhABAQEhGQcOO4V7DYJbgSyBJgEBAQEBAQEBAQEBAR0CR0QBAQECA?=
 =?us-ascii?q?SMdAQERJgEECwsaAiYCAlYGFQEBgn6CIgEGEAEDDiQHtGGBMoEBggwBAQaCa?=
 =?us-ascii?q?dd1HywiWYFkCYEbLgGFbIJkAYpjJw+BVUSBPIJSMT6EQ4NbgmmCJoECFINlh?=
 =?us-ascii?q?nOGE4gvUngcA1ksAVUTFwsHBYEgQwOBDyMPPAUtHYEnfYMNgQ6EKCtPgiJ1g?=
 =?us-ascii?q?XlBGT+DUx4GbQ8GgRgaSgICAgUCQ0WBRUACAQttPTcJCxsGPZMVhynFKIEKN?=
 =?us-ascii?q?AeCOIFngWQMn2sGEy+XUg4GkwWZBqlBgWg6gVwzGiRPgmdPAxkPjiEMDQmEE?=
 =?us-ascii?q?b9SQTU8AgcBCgEBAwmFRgEBijGBSwEB?=
IronPort-PHdr: A9a23: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
 8SJi6/5bjtPoYq8wA==
IronPort-Data: A9a23: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
 VQIeF0=
IronPort-HdrOrdr: A9a23:X9varajoYowCvLhNhgvI7vK0LXBQXg4ji2hC6mlwRA09TyVXrb
 HKoB1p726StN93YgBZpTngAtj4fZq4z/VICOYqUotKMDOHhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfDxHZK3BkWqF+rgbsbu62ZyJwcHD0nxqUQZmUK146RxlYzzrb3GeCDMmOXIjfq
 DsnfavSgDQA0j+5amAbEU4Yw==
X-Talos-CUID: 9a23:UM15D2DPmmSH/M76Exdi1FJMIv0sSELEwnTgfUSAKTtnWKLAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3AEvWAEg8Xc/7fGvhaum+vRkyQf5g2soieMU8yqq4?=
 =?us-ascii?q?tv+3UNwxdOS2+tA3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,336,1744063200"; 
   d="scan'208";a="122097775"
X-MGA-submission: =?us-ascii?q?MDFYUd3zUg5mv9R4n9iaQPjSQannHIreDeZtdN?=
 =?us-ascii?q?Q9AgGHjM3nO6ll1Oh45OZDrCbH7lCyVthYwYzgnJiS+PIcLinPf/mJRk?=
 =?us-ascii?q?wETrhhVGD8QbDd+9XpT9rGDFlSEMLK5X2dQsiiUETUIhyDDDHb5RGDkB?=
 =?us-ascii?q?bbJhzPWa8UQz8zMZ9/FmYaDg=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 11:30:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1753349423; x=1753954223; i=markus.elfring@web.de;
	bh=CgFYwKUIQRiQBxox5xxeR6YMYFvymrDTLhnGoQwDVhc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=LSaNw6MtPTPjaAqXOaUWTByWIaH4xbVv/7hjgbgXXibOvuA0Wg0wnQPCLp3y1hv7
	 7PuOtU9w+Pb1jFYYWnE9RZPakM8bEd0sCua++Zbo5F3rkEfclPduAxMDdN1y95Dct
	 QxF+3Fjp043GDHgc9+iT6tpe/KLiGHCuGVsDQEJaotSecQ0dlebYItcsyNa2GUS6U
	 o34VqTyf9P7VA/d6qX3QI7WeVRRVR7ea9TV8pFFs0WUKumEvoE/FHi+JNlbSCTJaW
	 jgQhsyONQrxOPMvL1PuY2cut/xZdCyFflKmWErYL1+2uFpfe+TO/tm+bjNWsdssji
	 /juXxo0vAo+UY5UUAQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.250]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MqqTb-1uIPYk1QYL-00dszp; Thu, 24
 Jul 2025 11:30:23 +0200
Message-ID: <ed3aba00-d6b4-48f0-bb67-fe3d9e65bbec@web.de>
Date: Thu, 24 Jul 2025 11:30:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: Anon Anonson <anon@chud.cyou>
Cc: cocci@inria.fr
References: <0ddb6d0c-b974-490f-b498-52e41c319368@chud.cyou>
Content-Language: en-GB, de-DE
In-Reply-To: <0ddb6d0c-b974-490f-b498-52e41c319368@chud.cyou>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:solgsVQaWwXkYe/norcrlZwXOwICj8nXwEIiQU31WyV8Fur58cn
 LmdMXSL7/lW7gSJUHSoQKENhXOUM4rYexaCRK5WSJSmPIPssD556TyluAOMOha8/Hg1NGLQ
 39Uqb0f1y5fpLPFxQMiNZzXR9rW5xF6hDZB3kRZbMLXYJgUUd353tKTqWeGo12/zDsu3n+W
 iye5E5Z97+g+BtzbOuyRw==
UI-OutboundReport: notjunk:1;M01:P0:Z/f+4DqUpdo=;dsotBj3UXAQLBKaXVCAQRTzRCbV
 +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
Subject: Re: [cocci] Replacing function declarations by pointer variables
 (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2904
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/ed3aba00-d6b4-48f0-bb67-fe3d9e65bbec%40web.de>

> @ depends on decl @
> type T;
> parameter list ps;
> identifier F;
> fresh identifier F_fn =3D F ## "_fn";
> @@
>=20
> - T F ( ps );
> + T ( * F_fn ) ( ps );

Another SmPL script variant can be tried out.

@replacement@
type T;
parameter list pl;
identifier F;
fresh identifier F_fn =3D F ## "_fn";
@@
 T
-F
+( * F_fn )
 (pl)
 ;


=E2=80=A6

> Example C input:
>=20
>=20
> void f(void) {
> =C2=A0=C2=A0=C2=A0 puts("...");
> }

void f(void);


=E2=80=A6

> SP line 25: Not found a value in env for: T
>=20
>=20
> I would like to know what I'm doing wrong or whether on off chance its a=
 bug.

Another test result (by the software combination =E2=80=9CCoccinelle 1.3.0=
=E2=80=9D for example):
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> time /usr/bin/sp=
atch convert_function_declaration_into_pointer_variable3-20250724.cocci ex=
ample_for_Anon_Anonson-20250724.c
=E2=80=A6
@@ -2,4 +2,4 @@
=E2=80=A6
-void f(void);
+void (* f_fn)(void);

real    0m0,050s
user    0m0,034s
sys     0m0,012s


Regards,
Markus
