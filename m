Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF59CCA1012
	for <cocci@archiver.kernel.org>; Sat,  6 Sep 2025 10:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=zqwYO4C7NUGcA+F/yI6P8CcmjgNbPkhSbBuFhB/+tp0=;
  b=msaxIRA1t/3AY6ErxRW5IEO8B10H44Q6vaTxbFbWpDNKHdOq0ikx7v3A
   as+eTG8RqtUcZFvO86hbTQKxs5CwaSZ7tcgGVDNfX/BTSVvqmEg3xT9sE
   ruEK3HOKBU4wLYekw5jdRc4zpbET71Mck9nwKDMn6sMVnfmaJrEreVdrx
   4=;
X-CSE-ConnectionGUID: mG0AO4EATC+sPr8MW1rJxw==
X-CSE-MsgGUID: OheOJI3aQ7qlwoiYM4lvQw==
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
X-IronPort-AV: E=Sophos;i="6.18,243,1751234400"; 
   d="scan'208";a="237809948"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Sep 2025 12:25:42 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2F5C4E0264; Sat,  6 Sep 2025 12:25:42 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id EFCE4E0171
	for <cocci@sympa.inria.fr>; Sat,  6 Sep 2025 12:25:38 +0200 (CEST)
X-CSE-ConnectionGUID: Vu4ZBMwzQXmj4kqJox0WFA==
X-CSE-MsgGUID: Dts68LA5T4SGSKT2ZGq+hQ==
IronPort-SDR: 68bc0c22_VTZceiiTFrA6/WpEqJ9k4sPuqDt93YGhp/Ic9+fJJVqTcmz
 x1x9hkU82ndbmQEh2KTBvBhQhYlewNRyxYJMXpw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0ElAADrCrxogAwR49RaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE/BQEBAQELAYI/gQEGVDMEC0kIhE2IHIc0giSEO48RiHmBV?=
 =?us-ascii?q?YF9Ag8BAwENRAoBAgQBAQMEggyCdAKMKQIeBwEEMAkOAQIEAQEBAQMCAwEBA?=
 =?us-ascii?q?QEBAQEBAQ0BAQUBAQECAQECBAYBAhABATsHDgoxhk8NgmIBgSSBJgEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBARcCDTpEAQEBAgEjHQEBEScECwsaAiYCAlYGARQBAYJ+A?=
 =?us-ascii?q?YIiAQYQAQMPJgcNBrEdgTKBAYIMAQEGgmnXdh8sIlmBZAMGgRsuAYVrgmQBh?=
 =?us-ascii?q?icJhDMnD4FVRIE8C4J4PoJhBIFeg1uCaYImgRaDWI9PiEVSeBwDWSwBVRMXC?=
 =?us-ascii?q?wcFgSBDAyo0MSNLBS0dgSd5gweBDYQdK0+CHHKBdD4ZQINTHgZrDwaBFRlJA?=
 =?us-ascii?q?gICBQJDPoFtIgYfEgIDAQICOlcQgX0CAgRLQAIBC209NwkLGwY9lXODXCtig?=
 =?us-ascii?q?jGTILIfgQo0B4I4gWeBZAyKLpU+BhMvl1IOBpMFmQYijWabOYFoOoFcMxokg?=
 =?us-ascii?q?zZPAxkPjiGEADO6MEE1AgE5AgcBCgEBAwmFRgEBjFaBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:ZCAFFaDfXC8eI0/lHely55DYdb4zR+YMi2TDpHoBLSC9Ffbo7v
 xG/c5rsyMc7Qx7ZJhOo7+90cW7MBDhHNtOkO4s1NSZMjUO2lHFEGgK1+KLrgEIWReOk9K1vp
 0BT0ERMqyTMXFHrYLd/BSyFcomzeKK6aaymI7lvg1QpE1RCp2J9G1Ce36m+6BNNXJ77RFVLv
 Ch2vY=
X-Talos-CUID: 9a23:zD3862NSu3Nr8+5DZjQ7xmQxBdIcQnjfkHTJAUioUVlHYejA
X-Talos-MUID: =?us-ascii?q?9a23=3A8DYufg24SpLNc5+qD7+xdq0qsTUjz7i1VhApuMg?=
 =?us-ascii?q?65/KrDg9MYQWylXe3e9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,243,1751234400"; 
   d="scan'208";a="237809944"
X-MGA-submission: =?us-ascii?q?MDFhy6ZPZe6gYa4kfd7hC7SOJB1uvEJOTIsMWY?=
 =?us-ascii?q?v0j5gUR/PrByVto6TPF8XC/43crt/KiHKqBP10cEqzmI315LVUcSh1Gr?=
 =?us-ascii?q?yRrPfxi4AsHdZWnHbwqQ2e+BWYqF7FeenRYE049+d8ainx67zqr1lQ7c?=
 =?us-ascii?q?gUOh2ZJqknTimJnecU0WkTgQ=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2025 12:25:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1757154337; x=1757759137; i=markus.elfring@web.de;
	bh=zqwYO4C7NUGcA+F/yI6P8CcmjgNbPkhSbBuFhB/+tp0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=q9F/xrB1g3wzGhfboC4a6hhr12aeQTuJnWd4NqaNwhQ1gsmhndrFXXCkEFXBwvpf
	 IjCJZcx8p8o6PMfxbt730SaVRf7oO6yHcOSOZtf4Lt1gbNd6gz+oTInKTh3+M/GYI
	 DHMSrqMG2P68wf7ZNtLKu8S0HMKmUUQdwPQN0Va7b2Wg/MqFSrcfx6eSrOKxeSzH+
	 gb4sX6XwhylDYOYyUBNOaEnGL9tuvUBRXmOrVwQZsk1TomhWzP5ba1vPVcU/tQOQ/
	 t4yLsPTyo0/P5wUJoaQ7SmtTa+QMcGUSg00EPxeM6xi8XHyjgmZRmA/SYRVUxkFtw
	 fNjQFURjdMqW5KRbvA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.215]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N5UkC-1uOdyN27as-0157yO; Sat, 06
 Sep 2025 12:25:37 +0200
Message-ID: <ce7a7254-bbb3-4666-8a57-2e6cccaa51fc@web.de>
Date: Sat, 6 Sep 2025 12:25:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <6c2e0db1-033f-4f66-9cf7-dc0eae4bcde7@web.de>
 <f798ce14-0401-4116-bbee-2b78ad0f774b@web.de>
 <4c46da9-1fa9-9b4f-f0c7-6c7fd094e163@inria.fr>
 <b0221946-43a5-43c0-8573-32c12e149681@web.de>
 <ba87aeca-594d-10b6-960-cd4aa1fcd1e6@inria.fr>
 <d28c6f76-6708-4dba-a446-910170e27572@web.de>
 <b2e58328-97f3-4f1-e588-4647c6ff30d3@inria.fr>
 <13ed7845-6fd9-4a8e-9670-3d2b7e7a0f4e@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <13ed7845-6fd9-4a8e-9670-3d2b7e7a0f4e@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FqIRJXaBpjF1YNo7GQwGMuC2sfToR7QCaNQos36vIdGifXMdx7E
 xOzC4liPA6KwfnYmU0Tyq1vZ1EHIPUYbppmjWY4ZZ3LSovWdsnFVUf2WagC07fvOnVIwbE5
 lzSwiGfKgFB5f1DMmLwQXWmGNxxxcOKLoLmLyzZNvgyEsMF47ZnbZuqvn3HNbiM3W+cuMfW
 +akpLpIFs4fwLdyT2VDdQ==
UI-OutboundReport: notjunk:1;M01:P0:A3JbtNXkiSA=;yAhGLoWhQMswIW/WWWbaVrmC7GA
 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
Subject: Re: [cocci] Searching for selected variable assignments (with
 SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3003
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-09/ce7a7254-bbb3-4666-8a57-2e6cccaa51fc%40web.de>

> We might not be able to continue a search directly after a known source =
code position.
> But I assume that it would be possible to direct a search repetition to =
the place
> which was determined before (according to a semicolon for example).

The initially mentioned SmPL script pointed the implementation of the func=
tion =E2=80=9Carm_dt_init_cpu_maps=E2=80=9D
(besides others) for further development considerations.
https://elixir.bootlin.com/linux/v6.17-rc4/source/arch/arm/kernel/devtree.=
c#L59-L165

I tried also the following SmPL script variant out.


@find@
expression e;
position place;
type t;
t * pointer;
@@
 pointer =3D e(...);@place

@display@
position find.place;
statement s;
type find.t;
t * find.pointer;
@@
*;@place
 if (!pointer)
    s
 ... when !=3D pointer


Unfortunately, it does not present the known implementation details.

Questionable test result:
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> /usr/bin/spat=
ch --no-loops =E2=80=A6/Projekte/Coccinelle/janitor/show_unused_addresses_=
from_variable_assignments.cocci arch/arm/kernel/devtree.c
=E2=80=A6
[no diff output]


I would appreciate corresponding software improvements.

Regards,
Markus
