Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D41C5CEB2CC
	for <cocci@archiver.kernel.org>; Sat, 15 Nov 2025 13:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=j10ee37EYYvRGCni8yEarDJw4XDqk/jEUASMo6HGvs8=;
  b=HS4wDUJ01iK6i5cr5kPa0UXQ4pSYKQy4h0DLf0ZHXQ2Qr8B+8HxGdZqx
   ERUHH0QENrdTs6fu8mM0Wiobp+V+OSBMOjrswTOKPleBjtrNG4YX7YyJv
   2Gc2rj0XLXqZveNL7BhN+39gkJJOEbJ08At7RLV5BVZ6W88EwUV0ZJwaU
   k=;
X-CSE-ConnectionGUID: P/4k7x7nTh2AmYgQ5+FCPQ==
X-CSE-MsgGUID: w3rbrCtgRiSYqWYI2bp9KA==
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
   d="scan'208";a="249324467"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Nov 2025 14:25:37 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 74316E0B0D; Sat, 15 Nov 2025 14:25:36 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 1EC04E0171
	for <cocci@sympa.inria.fr>; Sat, 15 Nov 2025 14:25:34 +0100 (CET)
X-CSE-ConnectionGUID: YvYCPPN+Tn+QWj1Fr+0k0w==
X-CSE-MsgGUID: eYEg1v+gQcGxVkpKR47odw==
IronPort-SDR: 69187f4d_kH/fWRCsWUWN478fFX7uecCH18Wcmtu9N9YtAiPWvEht4YP
 BKJ122N5ycKfMxT9bMrDVmRSClYL4Z70tL2JK7Q==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0H6CAADfhhpeAQP49RaHQEBAQEJARIBBQUBQIFQAoI+Z?=
 =?us-ascii?q?XszBAtJhFWPU4IkhDuHPIdVimKBaQIPAQMBDU4BAgQBAQMEggyCdAKMWwIeB?=
 =?us-ascii?q?wEENQUNAQIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABQw4KM?=
 =?us-ascii?q?YZPDYJiAYEkgSYBAQEBAQEBAQEBAQEdAkdEAQEBAgEjHQEBESYBDwsaAiYCA?=
 =?us-ascii?q?lYGCgsBAYJ+giMBBhABAw8nB68ugTKBAYIMAQEG2l8fLCJZgWQJgRwuAYVtg?=
 =?us-ascii?q?mUBiWx6Jw+BVUSBPAuCRzE+hAU+g1uCaYImgQ6ZZFJ4HANZLAFVExcLBwWBI?=
 =?us-ascii?q?EMDgQsjDzwFLR2BJCIfGBNgPRdAg0kcBmgPBoESGUkCAgIFAkA6gWgGHAYcE?=
 =?us-ascii?q?gIDAQICOlUNgXcCAgSCHH6CCg+JNYEJBSgCAQttPTcJCxsGPZUeUYNDgkPGW?=
 =?us-ascii?q?zQHgjiBZ4FkDI4KkWIGEy+DcZNhDgaTBYgqkFypQYIAIoFcMxokgzZPAxkPj?=
 =?us-ascii?q?iGEM8QuQjU8AgcLAQEDCYVGAQGMVoFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 FnwUYfpNckxsfmov/kxDBQPkzpz3tAzB+o=
IronPort-HdrOrdr: A9a23:lXxjiKpflF7de/m5YDU8ifgaV5r/eYIsimQD101hICG9vPbo9f
 xG785rsSMc7wxhIE3I+OrwQZVoJEm2yXcb2+Ys1NuZLW7bUS6TXedfBOjZrQEIeReTygc178
 4JHpSWSueAaGSS5vyb3ODXKadC/PC60OSPmfrUyWtrQDpncqd68m5Ce3um+wFNJTWvHvACZe
 GhDyd81kCdkf97VK6GOkU=
X-Talos-CUID: =?us-ascii?q?9a23=3AD/kIc2q4HzN9bNWO481vMGLmUfE7Q1bl9FGTH0n?=
 =?us-ascii?q?7MFlrEZOPCgeToLwxxg=3D=3D?=
X-Talos-MUID: 9a23:K580eAg7NK22DvzCD+jKtMMpOfZF7P2wS080mroWhcqcFhYsZDCRk2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,307,1754949600"; 
   d="scan'208";a="249324436"
X-MGA-submission: =?us-ascii?q?MDG8cqp4/XNHK365OntbGrX+a0vyeEnAyJRgUY?=
 =?us-ascii?q?7HxaINizlSW0NBha56spW/xWPill9HNrIxIPg/X+8J7B5jpG0u9glC/W?=
 =?us-ascii?q?1WDGyvdXLe6+QWJoYhCG8qo+IpkqABUHW2zrpUL9e28zwKvzxyt/B1Ia?=
 =?us-ascii?q?LHaf0s38fi4z9A/UZkd53nTA=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2025 14:25:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1763213133; x=1763817933; i=markus.elfring@web.de;
	bh=j10ee37EYYvRGCni8yEarDJw4XDqk/jEUASMo6HGvs8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=pVXmE9LmIcS/Nqrd39xzax1WxUeH+776LPY68p7TlEwo/fPINr4n8Qlt4ZwPwz73
	 7IYx31+VAd2SbcWc7pHZ1lO0uw6wCvZNld3gtiFxqEmlgIdBYZAMQtWEWudds88aW
	 9vkjvNZvk7S5NxpbPjDLdU/hzuLJVAut243f0oeUbq2/LVZp0G7Pvl6L+Zm0GONa1
	 g78GfjNr1uePbmCbPEVxKig0UZbWgSWQ/IJW56Jc7NUIVXmWltJdlYdsiqqdDXlug
	 XZD0e1VQlcplbAYUY4XGpADzF8oce6Ed0stbplmptQKJs6edpIDCJSFP4gox/nnFG
	 Ieb+S5ApK8MgVfswLw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.174]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MwjK2-1w53950U1a-011ZCf; Sat, 15
 Nov 2025 14:25:33 +0100
Message-ID: <5e33f173-1aa4-4954-9fa0-ff213b3d088d@web.de>
Date: Sat, 15 Nov 2025 14:25:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <a66f4836-8161-4d3e-b588-7990035ec436@web.de>
 <2010b4b2-9710-4501-9c51-3b3ccc30d6af@web.de>
 <5598c4eb-8c8b-4fbe-918d-78509448cc22@web.de>
 <9d2415fd-116b-32bc-4f0-5b4555e5e752@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <9d2415fd-116b-32bc-4f0-5b4555e5e752@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/GilImmwkPSobG5UNJM1hzOjRnRuRwFMuH/X8mRxlgomVIYcd+i
 RWH3zDjR0fl8fTjsHQHwnAu3tJA3cmzoFBjE0Mb7wVflQ2QJs1uanXrnNVZiodTXQrbRWNT
 bMARJ9+jgN+K1NvV5buzKry7Lz2tRyZ1NvjyQsK/KJM8uL+LwWtvKfubjR7J2kuG8ULyTcb
 IESpUYng7cdN1qskJllmA==
UI-OutboundReport: notjunk:1;M01:P0:CGk+dd78EuM=;E1Bjrcz0Pnsg8/Sz1Zhlm7jpX3I
 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
Subject: Re: [cocci] Reacting to negative source code search results with
 SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3182
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/5e33f173-1aa4-4954-9fa0-ff213b3d088d%40web.de>

>>> How will chances evolve for further software improvements?
>>
>> Corresponding development ideas might follow another SmPL script exampl=
e.
>=20
> I have no idea what this is supposed to be an example of.

Does such feedback indicate undesirable communication difficulties?

Otherwise:
* Search for function (or macro) calls

* Demonstration of an SmPL rule combination

* Usage of SmPL inheritance

* Application of SmPL dependency specifications

* Data transfer to Python code


Regards,
Markus
