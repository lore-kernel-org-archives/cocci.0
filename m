Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E011ED29C46
	for <cocci@archiver.kernel.org>; Mon, 19 Jan 2026 16:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=PFlEZZzyd008R+pYxsskZqqan+5KZEOnkEcjdiTVYjU=;
  b=FbtOX4gavyeHv4MWBuM9r6eC29jjp0247G9/8mIGF5WFBIItrkT+K8bF
   dWphrgrwf98MGbRoBfIK/vi9DNjAD71+Y2gKep0uBIzcHBPHJRjpHTFsb
   7YGMVYk4aN/3KU+lSjA/UtWsNY2VyB1RI13RcwcxW06/R8NPB4BNZdtE4
   8=;
X-CSE-ConnectionGUID: rjyyDC4pTmO+nKPg274ltg==
X-CSE-MsgGUID: Kw61V36bSlitf6uGw2LcMw==
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
   d="scan'208";a="259319303"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Jan 2026 17:33:35 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 6954583884; Mon, 19 Jan 2026 17:33:35 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 0121081611
	for <cocci@sympa.inria.fr>; Mon, 19 Jan 2026 17:33:26 +0100 (CET)
X-CSE-ConnectionGUID: v2HJp08zSoOxLrirB5XmJg==
X-CSE-MsgGUID: /z1MK3qeRtWPFDEl8C1A/A==
IronPort-SDR: 696e5cd1_S9MYq93btDjroutwHv2OgEz7NAbXQRZElehll4vL8dsLalz
 FO01uEoTe/MBHM/CdRZUA6l2BU1dqAz6NMevp8A==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FZBwBQXG5pgAwR49RaHQEBAQEJARIBBQUBQIFQgkFoH?=
 =?us-ascii?q?18zBAtJCIRQj1OCJIQ7jxGIeYNSAg8BAwENRAoBAgQBAQMEggyCLkYCjHkCH?=
 =?us-ascii?q?gcBBDQTAQIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABATsHD?=
 =?us-ascii?q?juGTw2CYgGBJIEmAQEBAQEBAQEBAQEBHQINOkQBAQECASMdAQERJwQLCxoCJ?=
 =?us-ascii?q?gICVgYBFAEBgn4BgiIBBhABAw8nBw0GsTmBMoEBggwBAQbaYx8sIlmBZwMGF?=
 =?us-ascii?q?YEKLoVugmUBhiqEPScPgVVEgTyCUjE+gmEEgV6DW4JpgiaBDoQ5j1VSeBwDW?=
 =?us-ascii?q?SwBVRMXCwcFgSNDAyovLSMPPAUtHYEjIR0XEx9YGwcFEyNsIQYcEgIDAQICO?=
 =?us-ascii?q?lMMgXYCAgSCEHuCAQ+HDoEABS5vGg4iAkFSAgELbT03CQsbBD2QBEeDPBwQI?=
 =?us-ascii?q?IIoxjI0B4I4gWeBZAyKLpU/BhMvhASNE4Y7DgaTBR6YaCKNZ5s4gX8jgVwzG?=
 =?us-ascii?q?iSDNk8DGQ+OIQwWHINCM8c8QjUCOgIHAQoBAQMJhUYBAYxWgUsBAQ?=
IronPort-PHdr: A9a23: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
 lgphwE4bel/rF/R
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:lEPaWa9TgdUofKou915uk+AGI+orL9Y04lQ7vn2ZOiYlF/Bw8P
 re5cjztCWE7gr5PUtKpTnuAsa9qB/nhPpICMwqTNCftWrd1ldATrsP0WKK+VSJdhEWtNQtt5
 uIGJIfNDSfNykYse/HwE2fD8sqxsWB/ZulnOHE0h5WPHtXgu1bjjuQEWygYzVLreR9dOEE/B
 Hw3KB6mwY=
X-Talos-CUID: 9a23:wePmIm+0ph1uO/ce3wuVv1BOOuI9Ki3P93D3M2uiCHxDFY2Qa1DFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3AwAilIA1q10o0rfD5PVi07i4mhTUjpLb3LWNWiJg?=
 =?us-ascii?q?8p/a8GwBdP2e21R3wa9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,238,1763420400"; 
   d="scan'208";a="259319250"
X-MGA-submission: =?us-ascii?q?MDEn30NNCR64JocWoQiRnU+i/UwOwagBBsyZ9l?=
 =?us-ascii?q?ZWvqs4Y5qOHXcaAfj5MaDRUTio2pkaBo85FpzIZLmPWwOORPSXhjux+2?=
 =?us-ascii?q?Lf6fC0uB+AcR5+KtxyRnkkpMHFdmbnGSwLY/9NOsJieKrs1YSmT4n8ri?=
 =?us-ascii?q?DzyO4EP0ucyCjAFRDGk863kw=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 17:33:21 +0100
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.178]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MbTGt-1wFH8T26Ib-00o6L4; Mon, 19
 Jan 2026 17:33:20 +0100
Message-ID: <24a80cfc-04b7-47f6-ac75-45b35c200ab3@web.de>
Date: Mon, 19 Jan 2026 17:33:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <e12b2a95-f1e6-4f8b-ab62-151c9789e798@web.de>
 <3857229-a98-854f-225f-5a63ca19cb7d@inria.fr>
 <15bca19e-5a87-4efd-8da7-c6ea2cad27f1@web.de>
 <ca324487-4858-9054-14e8-dbeabae9728a@inria.fr>
 <78df0ed3-2bb4-438a-bba5-c858dd20c1f1@web.de>
 <176fb6de-f5c5-de7c-db91-ab5b81661f77@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <176fb6de-f5c5-de7c-db91-ab5b81661f77@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:t29NviRWV3o4c4EZZkmfJaVcFzqq9186EeI6cAr+rco2oHtVTwu
 SuzLUmFcDffzLu992Xlwe6O5j27EAGHsfx3iQMOpYvRFdXPtWx3QAUU7HgCVYUazoGVDODE
 2KVzX2vOQfgbnu92d18cv32r8mzAEcvm61+as8BZxEpPazRJTKdIqd5ZGGmd3bNhh3IKIxx
 1+obkw/lLDF0HSGSm4BqQ==
UI-OutboundReport: notjunk:1;M01:P0:YHAcL2reELg=;PGbrXSnyIjbXcqrZdhz7NmWIGGq
 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
Subject: Re: [cocci] Checking data structure member accesses after function
 return value assignments?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3276
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-01/WFoGV3Pog0wsZXDfODvV5Q>

>> Under which circumstances will corresponding software improvements beco=
me more likely?
>=20
> If a semantic patch doesn't match when you expect it to, the most likely
> issue is that the C code you expected to match doesn't parse.

Please take another look at a linked information source.
https://elixir.bootlin.com/linux/v6.19-rc5/source/drivers/regulator/fp9931=
.c#L441-L442


>                                                                Did you t=
ry
> spatch --parse-c on that file.  You have to see if there is BUG or bug a=
t
> the beginning of the relevant lines.

Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> time /usr/bin=
/spatch --parse-c drivers/regulator/fp9931.c
=E2=80=A6
nb good =3D 553,  nb bad =3D 0 =3D=3D=3D=3D=3D=3D=3D=3D=3D> 100.00% good o=
r passed

real    0m0,057s
user    0m0,045s
sys     0m0,009s


Regards,
Markus
