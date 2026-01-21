Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94EE1C44536
	for <cocci@archiver.kernel.org>; Wed, 21 Jan 2026 15:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=hu8SkbiLHEiQakiQa1HdxBkBDdFn2CxP7Htp2D7U7oE=;
  b=Khu30yvNidHPgaWRFxRIVHoK/F0CabYY5oANwfVHu6HMz2kb4NREgMb/
   9ON6Gnrsp8zRp2rRrDg2TXwKtcFmIzG1n0Chf2GjziZEJQfVAn7O3dK2S
   PlQKzEyIDOhGf1F+2ldX9hHOC9X2zZ2MK02TGAglH++nAR+X/FUucKy5G
   Y=;
X-CSE-ConnectionGUID: +OwE2MPTSmq/Khjh8DpXzQ==
X-CSE-MsgGUID: LjCD6NPnRWKRZFKcKabXdw==
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
X-IronPort-AV: E=Sophos;i="6.21,242,1763420400"; 
   d="scan'208";a="259692722"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Jan 2026 16:43:29 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 3272B81A2F; Wed, 21 Jan 2026 16:43:29 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 66AB381A27
	for <cocci@sympa.inria.fr>; Wed, 21 Jan 2026 16:43:27 +0100 (CET)
X-CSE-ConnectionGUID: F7smc/5mSlue0ha0xLsWZA==
X-CSE-MsgGUID: jAYmB9b8TeysAn+Z8CSklg==
IronPort-SDR: 6970f41e_lX3WMG1o99wIEj+tAt4vy5yLTDMGQw6NgovcjTwlus7YcC+
 WhNk8tPf/+/kYhFFcda1gpbTUmVWmk384IMzedw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HyBQCH83BpgAMP49RaHgEBCxIMQIFFC4JBaB8GWTMEC?=
 =?us-ascii?q?0mEWI9TgiSEO48RjEsCDwEDAQ1ECgECBAEBAwMBggyCdAKNBAIeBwEEMwYOA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABATsHDgoxhk8Ng?=
 =?us-ascii?q?mIBgSSBJgEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAkdEAQEBAgEjHQEBESYBBAsLGgImAgJWBhUBAYJ+AYIiAQYQAQMPJwcNs?=
 =?us-ascii?q?VGBMoEBggwBAQbaZB8sIlmBZwMGFYEKLoVugmUBimcnD4FVRIE8glIxPoEFA?=
 =?us-ascii?q?YM9g1uCaYImgQ6UCFJ4HANZLAFVExcLBwWBI0MDgQYjSwUtHYEjIR0XEx9YG?=
 =?us-ascii?q?wcFEyNTBhsGHBICAwECAjpTDIF1AgIEghB7ggEPhwWBAAUubxoOIgJBbgIBC?=
 =?us-ascii?q?209NwkLGwQ9j3dFgzcZGCKCEEXGAzQHgjiBZ4FkDIoujjSHCwYTL4NxYJMBD?=
 =?us-ascii?q?gaTBZkGjgmVdoVCgX4kgVwzGiSDNk8DGQ+OIReEHIELxgBCNQsxAgcLAQEDC?=
 =?us-ascii?q?YVGAQGMVoFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:rjGwqq3P/j8f6s1+o6Am0wqjBGYkLtp133Aq2lEZdPWaSL39qy
 ncpoV/6faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SOzUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyTMbEQt6bHCWeDYrUd6eWmtIa1mOzZ03Bhdg1ybbp8hj0JdzpzXncWeOFcb6BJb6
 Z0C/A33QZJ8hksBPiGOg==
X-Talos-CUID: 9a23:emY90G7L/JyMZtbD9Nss2hEPH8tiL3jmyGrde0+xUXZNU4KnYArF
X-Talos-MUID: 9a23:H73WdATO+YSlT061RXTurQBnHpZis5ijGVskl9Y06+K/Nih/bmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,242,1763420400"; 
   d="scan'208";a="136633362"
X-MGA-submission: =?us-ascii?q?MDHnE1aCL14DGBzMU4u6mprwwUbbG/T5htK5oK?=
 =?us-ascii?q?FojOppuW73Y4RhMAfkrQxHVRBzJ+TVZdgfiuAjUH/wQBT8CTVz2B8QGV?=
 =?us-ascii?q?aoWfjZPdposN6pD0IJCrCRtIRZS0uAD2RZeIHUhC8y6IgCtzPo5oPTEZ?=
 =?us-ascii?q?BmjnRFEMQ6oayxbGObKUuJEQ=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 16:43:26 +0100
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.226]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MkEhR-1wBIU01z7B-00hQsa; Wed, 21
 Jan 2026 16:43:25 +0100
Message-ID: <f222ef51-388a-441d-b9e3-c7abebc0a2d7@web.de>
Date: Wed, 21 Jan 2026 16:43:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Victor Gambier <victor.gambier@inria.fr>
References: <87v7i7g615.fsf@mmap.at>
 <af6a88ac-fe87-47d9-8e55-b570f205afc4@inria.fr>
 <c393376f-a5b7-4e7c-b593-052528b9fcb0@inria.fr>
Content-Language: en-GB, de-DE
Cc: cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <c393376f-a5b7-4e7c-b593-052528b9fcb0@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HVM0+uGpm0/PBU6RRBKpn46wwmBopBCdZ+xzr/YELYouVrrGTMz
 lyREzhMnO+l1w3Kl/suBlR+GyNIrf1cLg7HDZdviHbYqykX3G47i6Z8Pd15E+jKQoCTkr/H
 vTwUMWQiJrfC9To0RHE8NEl5rfYjT8hXkz5l8MNXJ9Pj2LbXPSnT6W17WGOofBzO9IsDZ1O
 fGZsdL/dV4/+bsSEm3pIQ==
UI-OutboundReport: notjunk:1;M01:P0:zdHZWjZEkmY=;u41RwSVZnGFpL/uIJEcKOATMIo2
 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
 oL0Mqet9/RkWWn0m6Uq2GQ7AZJjW6
Subject: Re: [cocci] Pre-compiled spatch links against EOL PCRE version
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3296
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-01/dwBygrfEmdNw4wA0IYMq-g>

> Work on PCRE2 has been completed - I've finished what Olaf's started.
>=20
> The patch is on master (b231de0db). Feel free to send feedback if you no=
tice any issues once this becomes a release.

Thanks for another remarkable software development progress.

Unfortunately, I would miss further improvements for the software build sy=
stem so far.
https://gitlab.inria.fr/coccinelle/coccinelle/-/commit/b231de0db3f9513f6ea=
936caea5428fe627af1b9

I tried also to influence corresponding adjustments somehow.
Will development interests grow accordingly?

Regards,
Markus
