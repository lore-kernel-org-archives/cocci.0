Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E771D116F3
	for <cocci@archiver.kernel.org>; Fri, 28 Nov 2025 12:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=yhMX7HQ5zcfOJqndF8fKUCnwhS3ww8ZvCSvQerITlOo=;
  b=bqFKBaoi7BkULZgIJyg+uV7pPKVOukKaAlT4pGDYssCfgZPPLHNm05cB
   55lPbF+eeNy97mU2cHqXBJa2YCcWEfCJC6bdANCTmcC/GQDnNMmRI6oH7
   bOHUjdU3UYA0R+ocV7oEu3RTYemf4oTTfljIRQxZoGz4a2hDBWD07q7mO
   Q=;
X-CSE-ConnectionGUID: kV3brl+aTzaErRgkWGEKnw==
X-CSE-MsgGUID: 1OW3DijtQE+GDPQiIo+iLQ==
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
   d="scan'208";a="251760921"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Nov 2025 13:03:26 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B2122E02E4; Fri, 28 Nov 2025 13:03:25 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 3D973E0157
	for <cocci@sympa.inria.fr>; Fri, 28 Nov 2025 13:03:21 +0100 (CET)
X-CSE-ConnectionGUID: WYbOCHJfS0utzvqda/sU4g==
X-CSE-MsgGUID: HVNGXnjAQSiDxQpp1EG4dA==
IronPort-SDR: 69298f89_COr8l1BWD0ENb+wH2lolmzcTjrjhrZ/T8dXASSK/UPWGQ1G
 rK0QUPVv/hVOVQVv7C8o4M68VNoYqTkiuNXLK1Q==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0E+AwD7jilpg07ASNlagQmBUIJAZSNYMwQLSYRVj1OCJ?=
 =?us-ascii?q?IQ7hzyHVYpOgX0CDwEDAQ1OAQIEAQEDBIIMgnQCjGUCHgcBBDAJDgECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAQEBOgcOO4ZPDYJiAYEkg?=
 =?us-ascii?q?SYBAQEBAQEBAQEBAQEdAkdEAQEBAgEjHQEBESYBBAsLGgImAgJWBhUBAYJ+g?=
 =?us-ascii?q?iMBBhABAw8nB7B6gTITboIMAQEG2l8fLCJZgWQJgRwuhW6CZQGJbHonD4FVR?=
 =?us-ascii?q?IE8glIxPoRDg1uCaYImehSZWFJ4HANZLAFVExcLBwWBIEMDgQsjDzwFLR2BI?=
 =?us-ascii?q?yEdGBFgPRdAg0kdBmcPBoERGUkCAgIFAkA6gWYGHAYcEgIDAQICOlUMgXQCA?=
 =?us-ascii?q?gSCGX6CCg+IDoEJBS6BDQIBC209NwkLGwY9lRFQgi89gSxdx240B4I4gWeBZ?=
 =?us-ascii?q?AyfbAYTL5dSDgaTBR6YaKNwhVGBaDqBXDMaJIM2TwMZD446hBrEVUI1PAIHC?=
 =?us-ascii?q?wEBAwmFRgEBjFaBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 w0hoIfv5esRkNiEndjBDAzfYzqi
IronPort-HdrOrdr: A9a23:IEcPbqvyADgz5MM2MN3RGU0i7skDotV00zEX/kB9WHVpmwKj5q
 KTdYcgpHvJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniAhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfD1HZK3BgDVQfexQo+WvzIDto/vCxHFwSgxQZ7hn9BoRMHfnLqQ7fmh77YFSLu
 vm2iOrnUvbRZydA/7QOkU4
X-Talos-CUID: 9a23:XCCYQ2CcgmVLnXr6ExZW/mk/OuIrSSXA0GXOOkOxTn1UFLLAHA==
X-Talos-MUID: 9a23:/QRRyAqmEjVR30+4y4QezxFcEuhY5aaHMXsMvYU/o9HdGAMsNx7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,232,1758578400"; 
   d="scan'208";a="251760904"
X-MGA-submission: =?us-ascii?q?MDHd9RsmNfWTz1fgFZ1MMLv3o8WPkgznX5Ke1R?=
 =?us-ascii?q?sRz7bJEuI4YYlnCXSsUJZ7LaWlNFM8Rp2OiWiu8FyoBdfBcEhszPbb5S?=
 =?us-ascii?q?yuNIt+eqEEaRytyLrImZf1LZkTb81f9lwIcHIDuzhXvstu94JYyzmA6p?=
 =?us-ascii?q?rWA4qUD+Mq1rJbLjLq4Nx0dg=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2025 13:03:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1764331400; x=1764936200; i=markus.elfring@web.de;
	bh=yhMX7HQ5zcfOJqndF8fKUCnwhS3ww8ZvCSvQerITlOo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Q7ditp/+8oZ9k0EfGZwlwM6dOPq3K0TtI1zVPO/qXvYbyw1R3k5M3Sm3dCTdTrsf
	 +53Yv7bEkQQMbX9H0Q0J39+kwpSA+EAVpXS2u2ySho7hUMm9FgKGeYyDVX9xZZlRK
	 ADzTIY9ZX7zLXZK2I0q4FYonCrVCQqNyZZP8ZQ6vg9fRf9iYIvtqj2q7PmsoRVeOg
	 deDnLjDmzBnRqfz0+F9yNjDDX0YP6c7XvCirW8EMb0I22VyFJKuP1QIzv8wZ34B1i
	 NjZhkN6UsqYe2LZSrVf/p4aX6RG83xE9OFsAAYMXt1U8xtxeUIZJR+dxe35sSNRl4
	 2Ro1JP6G0jes/rTdXQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.222]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mdf8F-1vxjmT0H9F-00q2e7; Fri, 28
 Nov 2025 13:03:20 +0100
Message-ID: <c44835b0-5dce-4ab2-bff8-48b0d9b97e6d@web.de>
Date: Fri, 28 Nov 2025 13:03:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <d08dc115-5c88-4545-8a77-b588382db1e7@web.de>
 <aa45d63e-bce0-47a7-b34f-434311ecd9ed@web.de>
 <6ab5b7b8-9655-67f2-4acd-e78c81e94ed@inria.fr>
 <c5653e62-9d5d-4220-9c79-7750cb2ab647@web.de>
 <7fcab8f9-1a55-3ba9-858f-6ed333ac9b4b@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <7fcab8f9-1a55-3ba9-858f-6ed333ac9b4b@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/+ZBPyoxCXcIeL6zvCMhH4CIcgj0O/N50AU5pbQK7UE0CitCq3d
 X6ZDkRhC5eKH/oMBkf2L1KdAjnOsCqDPcG9FRlq+G3ju2Qm7ne7Y+v8p9euPOxPN4Cbs04Y
 FfimzxYyMHDuC1SL1w6fcLhsqIfz4I6XdVJK/DaofewJcY6hlHDfzJ4Bx1wbX1eTYMeWhmU
 za+e4RqYwwndvyxS4vNsA==
UI-OutboundReport: notjunk:1;M01:P0:WZDIWv5iXP8=;dwhYzYw0vsWU2cVRvsJvrHN1c8a
 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
Subject: Re: [cocci] Data processing challenges with usage of not operators
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3202
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/c44835b0-5dce-4ab2-bff8-48b0d9b97e6d%40web.de>

>> I became curious about another recent software improvement.
>> Some dependencies hinder me to build current software components myself=
.
>=20
> I don't know what depdencies have changed,

???

You published a few commits which are not connected with a corresponding o=
fficial
software revision (or release) so far.


>                                            but if somethign has changed
> that could be something to fix.

Would any more developers become interested to clarify remaining challenge=
s
for the software build system?

How challenging can it be to keep involved software dependencies consisten=
t
and even up-to-date?



>> Under which circumstances would you become interested to take another l=
ook
>> at information from this clarification approach?

Reminder:
Would you be so kind to share another test result for a command like the f=
ollowing
according to the current development version?

/usr/bin/spatch --parse-cocci --sp '! 2' | grep -E '^\|' | wc -l

Regards,
Markus
