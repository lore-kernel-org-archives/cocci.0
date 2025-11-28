Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC04D116E2
	for <cocci@archiver.kernel.org>; Fri, 28 Nov 2025 10:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=4/qiw9V2JCjxiBCzV9IPhPKtIBOwkt7mTg8S47xLCeI=;
  b=gLPAoo1OOtjMzCwObgWLuT73Zx9AJjo444oErbwMLsjg0eB6G4yuz2Qa
   X+EopwkNSkLPW5b6jXIBWztYJFKLaC/rU8QxKsIstZ1OJ+HS3FLDA8Se3
   ONoVvjRTYgvl39kw4maW/wbyzDofqJWi3LOdd5i0E+ySH/7eQwhPGs4yn
   U=;
X-CSE-ConnectionGUID: iJ3JlQDdTUeAbcpEEJFo3Q==
X-CSE-MsgGUID: hxMWewK+QvivqW1kXtUrYA==
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
X-IronPort-AV: E=Sophos;i="6.20,232,1758578400"; 
   d="scan'208";a="251743020"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Nov 2025 11:40:27 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7C989E0AF1; Fri, 28 Nov 2025 11:40:27 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 76B08E0157
	for <cocci@sympa.inria.fr>; Fri, 28 Nov 2025 11:40:21 +0100 (CET)
X-CSE-ConnectionGUID: DiHJOZaPQrezEdcz2DwEuw==
X-CSE-MsgGUID: pbbbx1e9S2andinxbpwxwQ==
IronPort-SDR: 69297c15_l112utfqwc0VCn14KBWr3DCiC70Vb47Yfj0tg1r4UwFgu0z
 bcjEHvJl7M2s/FEFWfTxg2oZ1reX4HAcGoXywgw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EuBAAFeylpg07ASNlagQmBUIJAZR0GWDMEC0mEVY9Tg?=
 =?us-ascii?q?iEDhDuPEYpOgX0CDwEDAQ1ECgECBAEBAwMBggyCdAKMZQIeBwEEMgcOAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABAQE6Bw47hk8NgmIBg?=
 =?us-ascii?q?SSBJgEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?g06RAEBAQIBIx0BAREmAQQLCxoCJgICVgYTAgEBgn4BgiIBBhABAw8nBw0Gs?=
 =?us-ascii?q?FqBMhNuggwBAQaBRgIMAkPYRh8sIlmBZAMGgRwuhW6CZQGJbHonD4FVRIE8C?=
 =?us-ascii?q?4JHMT6CYQOBX4NbgmmCJoEOhiSTNFJ4HANZLAFVExcLBwWBIEMDgQsjDzwFL?=
 =?us-ascii?q?R2BIyEdGBFgPRdAg0kdBmcPBoERGUkCAgIFAkA6gWYGHAYcEgIDAQICOlUMg?=
 =?us-ascii?q?XQCAgSCGX6CCg+IDoEJBS6BDQIBC209NwkLGwY9lRErJYJsewKBRYE1kkOeW?=
 =?us-ascii?q?pRjNAeCOIFngWQMii6VPgYTL5dSDgaTBR6YaIwOgXqbOYFvATKBXDMaJIM2T?=
 =?us-ascii?q?wMZD446hBqBC4NVwEBCNQI6AgcBCgEBAwmFRgEBjFaBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 PrxgKfOxMkzsfmosfkx3Tg7YjqiOw==
IronPort-HdrOrdr: A9a23:v2sjkqHZK4lks8mPpLqEIseALOsnbusQ8zAXPhhKOGdomszxrb
 HMoB1p726PtN9xYgBfpTnuAtjmfZqxz/9ICMwqTM+ftWrdyRqVxeNZnO3fKlTbckWUm4Izu5
 uIMZIOceEYZmIK7/oSlTPId+rIt+P3lZxA692/854nd3AWV0gp1XYENi+rVmlNbE19JaNRLv
 ChDqYrnUvRRZ04VLXFOkU4
X-Talos-CUID: 9a23:kdNdm2CZsg5Z68z6EwVm1GwzKMkdS2fQ3lrcKF3iJXlEVaLAHA==
X-Talos-MUID: 9a23:Bz7PUQZfN5DOi+BTrzXmjiE7OZZTua2oBEELgZ8epNmbDHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,232,1758578400"; 
   d="scan'208";a="251742990"
X-MGA-submission: =?us-ascii?q?MDG/B4tmPCitdKamUVbGb8Ib5VmwyNuuiUp2kx?=
 =?us-ascii?q?6DZGdEFJPb4HydRdtKZ5VAV7Z/MMw6vWe9wR1/nY0lTTPymL1Mnn+Uwd?=
 =?us-ascii?q?QUuwOaKK4ws6aYg7FF6syZTs8T7HKA2/5EqACc9nyZaU1GBO3psco6RG?=
 =?us-ascii?q?8JnLSI0BqG/a438xMyjfXlSA=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2025 11:40:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1764326420; x=1764931220; i=markus.elfring@web.de;
	bh=4/qiw9V2JCjxiBCzV9IPhPKtIBOwkt7mTg8S47xLCeI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=S9QVJuLLzpaHz5xxV2/B+62C+LIGlbHt9lKIgJKrKDMWf9ErEdEktr7oVWTKEvUk
	 n4AVCRjXSKY3MVx7UBcAWG2Qf/rDJWWh1rQkTjVXzOeRrxRIaZV3H4Fx2ipyHak6Y
	 nwn1yqbJ1+2RbrIR6/QBJNApCUvm8WTCVevxwFH3dOE61MLNsC7TIxwshGOAPhJUV
	 vfmeRJ4gD0t40pyFYfP3Axtjc01ni8Qi5FJK8gIIRidCq5sGsIrsC6r8rj2UMRmxB
	 cQ2mUAk9wHqAeoAf1VDLUwJ0tr/1GMfX8I7+MKRHA3eS8bs0DGSYa5+eeVDxaDeaw
	 TpXXjKk9y1diRVzMzA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.222]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MNfU1-1viup51E4p-00SUKy; Fri, 28
 Nov 2025 11:40:20 +0100
Message-ID: <c5653e62-9d5d-4220-9c79-7750cb2ab647@web.de>
Date: Fri, 28 Nov 2025 11:40:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <d08dc115-5c88-4545-8a77-b588382db1e7@web.de>
 <aa45d63e-bce0-47a7-b34f-434311ecd9ed@web.de>
 <6ab5b7b8-9655-67f2-4acd-e78c81e94ed@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <6ab5b7b8-9655-67f2-4acd-e78c81e94ed@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:arR4V2+aTA427JIM7wko5bxwFqOSboiU/p1rabvOeNhotS0kzxw
 4GlPtrzfcUhD85Z4DcpC2gzWHKVGuGffHM+0zS8WpMizegqPl8dNzSPJpTUcinU27xJbIzy
 wh5g9WIM+DlWefbzyjKmp3EyfmWkmZ42PQrYx4cMbNQaxbGcGJKcJzGwq7l/fR5xQblknEQ
 ey2+COkZAJdCKX2ZC8MSg==
UI-OutboundReport: notjunk:1;M01:P0:j7bQBHtKGEw=;3MVVKMVgD6LbuuQ+UkSmFDTqKuO
 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
 u0XCoyTmRiS4MvAvl5Dk1qkzjeaUeqhE1pSlSC
Subject: Re: [cocci] Data processing challenges with usage of not operators
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3200
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/c5653e62-9d5d-4220-9c79-7750cb2ab647%40web.de>

>> How does the generated SmPL disjunction look after the software adjustm=
ent
>> =E2=80=9Cavoid duplicates in disjunctions=E2=80=9D (from 2025-11-23)?
=E2=80=A6>> How long will I wait until I can see a corresponding data proc=
essing result myself?
> I have no idea what you are asking about.

I find such a feedback strange.


>                                            Can't you write --parse-cocci=
?

I became curious about another recent software improvement.
Some dependencies hinder me to build current software components myself.


> Does it take too long to run?  There is no way I can debug a problem wit=
h
> that without having your code.

Under which circumstances would you become interested to take another look
at information from this clarification approach?
https://lore.kernel.org/cocci/d08dc115-5c88-4545-8a77-b588382db1e7@web.de/
https://sympa.inria.fr/sympa/arc/cocci/2025-11/msg00056.html

Regards,
Markus
