Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 544DDD29C3C
	for <cocci@archiver.kernel.org>; Mon, 19 Jan 2026 16:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=X8ENKsU3EDDTB6mdbftVdlgSE7gfNB5U2fpyP3FWgeA=;
  b=lw6GrUu6l4EBxNBZFw2jQoLvt5LdVy6mUm+EOhSOalmiS/a0wjMEl+kT
   lmqFe3Nmi9iv4hurUptK1Ixy5kadflw7qqsNtQb//ff+l/Iv8utNGxtM3
   LjLn2rErC9+1UyQrt2APwCaVN6YRE0Yzqo8Zkilv76SVttm8LqaPGVMZc
   k=;
X-CSE-ConnectionGUID: 28Z9M66NTYutHY0zJt4NLg==
X-CSE-MsgGUID: DdF2OsG4Rsidab/eUaSt8Q==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
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
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.21,238,1763420400"; 
   d="scan'208";a="259317523"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Jan 2026 17:25:20 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id BE06F83884; Mon, 19 Jan 2026 17:25:19 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 5BF348387C
	for <cocci@sympa.inria.fr>; Mon, 19 Jan 2026 17:25:14 +0100 (CET)
X-CSE-ConnectionGUID: r7VNen8JR/O0U6mqUAhxmA==
X-CSE-MsgGUID: 72I/fFNESFCeqhBEDi9Tqg==
IronPort-SDR: 696e5ae9_AX3q97jfVgBX+dmIV+C0wbpy4Yf8Qlqev1iswH5pcpFrOmm
 Whsdw4pN18ayRRs0FdylGCDOVfdg494JMSITneg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FjAwD1WW5pg07ASNlaHQEBAQEJARIBBQUBQIFQgkFof?=
 =?us-ascii?q?jMEC0mEWI9TgiSEO4c8h1WIeYNSAg8BAwENTgECBAEBAwSCDIJ0Aox5Ah4HA?=
 =?us-ascii?q?QQ0EwECBAEBAQEDAgMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAQEBOgcOO?=
 =?us-ascii?q?4ZPDYJiAYEkgSYBAQEBAQEBAQEBAQEdAkdEAQEBAgEjBBkBAREnDwsaAiYCA?=
 =?us-ascii?q?lYGARQBAYJ+giMBBhABAw8nB7FcfzOBAYIMAQEG2mMfLCJZgWcJFAGBCi6Fb?=
 =?us-ascii?q?oJlAYYqhD0nD4FVRIE8glIxPoRDg1uCaYImgQ6UDlJ4HANZLAFVExcLBwWBI?=
 =?us-ascii?q?0MDKi8tIw88BS0dgSMhHRcTH1gbBwUTI2whBhwSAgMBAgI6UwyBdgICBIIQe?=
 =?us-ascii?q?4IBD4cOgQAFLm8aDiICQVICAQttPTcJCxsEPZAER4EyyzA0B4I4gWeBZAyfb?=
 =?us-ascii?q?QYTL5dSDgaTBR6YaCKpH4F/I4FcMxokgzZPAxkPjiEZJYN1xzNCNTwCBwEKA?=
 =?us-ascii?q?QEDCYVGAQGMVoFLAQE?=
IronPort-PHdr: A9a23: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
 RcFk+uQxWU7M4rmxwp9Z1M8kImYQyLt
IronPort-Data: A9a23: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
 N0BgKbOx8kwsfSovCgQOOjeYzo=
IronPort-HdrOrdr: A9a23:F7tpAqvO9vye7E/zon++HjCH7skDqNV00zEX/kB9WHVpm7+j5q
 WTdZMgpGbJYVcqKRcdcLW7U5VoLkmyyXcY2/h0AV7mZniAhILKFu9fBOnZrwEIcheWnoNgPO
 VbAspD4bbLbWSS4/yKgzWQL/Zl5sWb+6a1gurkw25qVhwCUdAb0+40MGem+lYdfng/OXPVLu
 vm2iLNygDLRUgq
X-Talos-CUID: =?us-ascii?q?9a23=3A4lQuoGnLupigSGOrrAqt8E/AyhfXOWeC8lHdJR+?=
 =?us-ascii?q?aMyFOEIDLTEat0aN0luM7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3Ae/1A+w/DSTZTwHV35tYnT5mQf5gywuOgJmYgqrs?=
 =?us-ascii?q?tttCEHwFcOmahlTviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,238,1763420400"; 
   d="scan'208";a="136427106"
X-MGA-submission: =?us-ascii?q?MDHQ8WxJl5UHDwfpEUncxF5ND6zU3SPFrDYzp1?=
 =?us-ascii?q?CHUMN89SXeA8M3VDvjjX49oir75tl6d19bjgKjWY5L6h2MolLc6OpOTk?=
 =?us-ascii?q?t7iyxJeQI3h1CQX450qHatbeH1NRorT8ubPitUSf8UuIWuB41/Hi5Xtq?=
 =?us-ascii?q?Gc+krs6OuxL03tXdn6FcTPQw=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 17:25:12 +0100
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.178]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N8Vsx-1vvQnh0goj-014XlE; Mon, 19
 Jan 2026 17:25:12 +0100
Message-ID: <78df0ed3-2bb4-438a-bba5-c858dd20c1f1@web.de>
Date: Mon, 19 Jan 2026 17:25:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <e12b2a95-f1e6-4f8b-ab62-151c9789e798@web.de>
 <3857229-a98-854f-225f-5a63ca19cb7d@inria.fr>
 <15bca19e-5a87-4efd-8da7-c6ea2cad27f1@web.de>
 <ca324487-4858-9054-14e8-dbeabae9728a@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ca324487-4858-9054-14e8-dbeabae9728a@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XuQ8RFHjt2PPrSDV7SH24PjzAhF/Eo0bwsHOGfWUBAhfBW0p8PJ
 i8XoY44DK89clTlRxEoOL+GsA30qKe/6jNb2J1jZSAbxcx8sWA081+J2N/hwGZTb0z8uG8p
 DMWxI4ujoNZMnCznDjXuYbn1ghxnlhs32WjRnq50tYOI12zHFG/dJiAObqUbdCQhdMmiZGE
 2MjbtvoEInKxVirYg9VNw==
UI-OutboundReport: notjunk:1;M01:P0:LcXGiKEymC4=;M2kPTa8cpwPcekf/S8SO2VcRByD
 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
Subject: Re: [cocci] Checking data structure member accesses after function
 return value assignments?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3274
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-01/QR3LDtFUZwSDVFlOW_Joiw>

>> Another SmPL script example:
=E2=80=A6
>> @display@
>> expression action, pointer;
>> identifier member;
>> @@
>> *pointer =3D action(...);
>> *<+... (pointer)->member ...+>
>>  ;
>>
>>
>> Questionable test result:
>> Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> time /usr/=
bin/spatch --no-loops =E2=80=A6/Projekte/Coccinelle/janitor/show_questiona=
ble_statement_combination3.cocci drivers/regulator/fp9931.c
>> [no diff output]
>=20
> OK, then I don't know.  It seems like it was possible to parse trhe
> semantic patch.
=E2=80=A6

Under which circumstances will corresponding software improvements become =
more likely?

Regards,
Markus
