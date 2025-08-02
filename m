Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D96A3C87FC9
	for <cocci@archiver.kernel.org>; Sat,  2 Aug 2025 16:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=H7aNBaL80jaFVQ4f5vAumUh+nUJby29NZ1S4v3Y76uI=;
  b=RmPmS3pnq/3Z5eQykHVF5K6H0IzKtOuHL50iUTlG4L6nzLu/H5tMIcCL
   /2KphlC/pOopVHyGUZGKWQ/dPokIMAPHHTMLDh1h64WW6UUpdbBcM4yjL
   C4EHTuqzbYR20/G4E18XUuFUcNTzrWyLCOyFR256R6IQZ1yKhxTpngIM+
   c=;
X-CSE-ConnectionGUID: bA/W4AMSSfa+LB4JOuMz2A==
X-CSE-MsgGUID: nIuQ/KkySz+8f78e3ohuDA==
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
X-IronPort-AV: E=Sophos;i="6.17,258,1747692000"; 
   d="scan'208";a="233964606"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Aug 2025 18:02:01 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 352C6E0BE9; Sat,  2 Aug 2025 18:02:01 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 3B13CE0171
	for <cocci@sympa.inria.fr>; Sat,  2 Aug 2025 18:02:00 +0200 (CEST)
X-CSE-ConnectionGUID: Eyufdc8tT0yBnLQjOypb4A==
X-CSE-MsgGUID: oOcBCASKTUKF0vm/HZ0QGQ==
IronPort-SDR: 688e3677_ng7ijDItn9zGOa5O8KlMMU3VGTFBNS6FLlAysRxsQyB4b44
 /q8TsDMYpylbFdrlhIoKtOuvnegCk/ls7oZeDKw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GRAQAUNY5ogAQP49RODB0BAQEBCQESAQUFAUCBQgUBC?=
 =?us-ascii?q?wGCQ4EGVDMEC0mEVY9QgiSEO4c8h1WIeYNSAg8BAwENTgECBAEBAwSCDIJ0A?=
 =?us-ascii?q?owaAh4HAQQzBg4BAgQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEBgECE?=
 =?us-ascii?q?AEBOwcOCjGFew2CYgGBJIEmAQEBAQEBAQEBAQEBHQJHRAEBAQIBHQYdAQERJ?=
 =?us-ascii?q?gEECwsaAiYCAlYGARQBAYJ+giIBBhABAw4kB7BVgTKBAYIMAQEG2l4fLCJZg?=
 =?us-ascii?q?WQJgRsuAYVsgmQBhieDQnonD4FVRIE8glIxPoQBAUGDW4JpgiaBFoNjjQSIc?=
 =?us-ascii?q?FJ4HANZLAFVExcLBwWBIEMDKjQxI0sFLR2BJ32DDYEOhCcrT4IidYF5QRk/g?=
 =?us-ascii?q?1MeBm0PBoEVGh4tAgICBQJDRYFgGQYaQAIBC209NwkLGwY9k1SENoEAgTRgl?=
 =?us-ascii?q?iavbDQHgjiBZ4FkDJ9sBhMvl1IOBpMFmQYiqR+BfiSBXDMaJIM2TwMZD44hh?=
 =?us-ascii?q?DO9PUE1PAIHAQoBAQMJhUYBAYtbgUsBAQ?=
IronPort-PHdr: A9a23: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
 UNgKVLQKIMOKsvk1kYkZlQoxOz3
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:kpWrdq2JoY3FklfbGRzqwQqjBGYkLtp133Aq2lEZdPWaSL37qy
 ncpoV+6faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SOzUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyUMbEQt6bHCWeDYrUd6eWmtIa1mOzZ03Bhdg1ybbp8hj0JdzpzXncWeOFcb6BJb6
 Z0C/A33QZJ8hksBPiGOg==
X-Talos-CUID: 9a23:DAwI6mMm2fTwOe5DdTh6+kIfStwZKmz3ylPpIWipEWw1YejA
X-Talos-MUID: 9a23:ot9X6wQG+zWKnds6RXTrozpIH+5TwJiTK25Vj5BBm/vcDANJbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.17,258,1747692000"; 
   d="scan'208";a="233964602"
X-MGA-submission: =?us-ascii?q?MDFHuOmIs/jgHiWo9gk+hdQLu/x8EmMLDqh0Q2?=
 =?us-ascii?q?F/sNGAs2G1NczRHqe+S/2GbURxqaxb/GvDcZ148irf3GjvGpOn5VkWoj?=
 =?us-ascii?q?BFhJe+K198xlYozoTerWYueFUmnlt5HKeSeQpIO/lwLbQbiQHYMSvtAh?=
 =?us-ascii?q?pRAPHQkm/ELO6sO52PmEHFHQ=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2025 18:01:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1754150518; x=1754755318; i=markus.elfring@web.de;
	bh=H7aNBaL80jaFVQ4f5vAumUh+nUJby29NZ1S4v3Y76uI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=R15sHwo95yfSZcekwlw3bZVsrkqvfbSFehns7F/tWF+65pvA0uXVstTzNdg8QOca
	 o2SSl/4rh7yKy+ZdO/56ziKMZ2EhOB/6FxM1fcE3IxCIMX3ewc+CfkYhScS/gD78V
	 dt6fUMtJlS/n2UCi+Ygi2N2rz3N5ulo/4JN2c69TohJbz/y4UbZxY5i3R0kjAmMze
	 0rUDe2vDJ+atGw72ozK501orAfsUs9oqOsBxg+fp5fLW6nl3vnbdmCSq8CzsDXyEK
	 h1jRjYuclZ3wNYiNbCAb6gdV3GG+2mKeq6EPMCH0KTaZu04a227zwepMaWTLP0sbl
	 Uyd0eVPXBDjE9ljdBQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.1]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MOm0x-1v0iKn0emV-00S0F9; Sat, 02
 Aug 2025 18:01:58 +0200
Message-ID: <2130ab11-8ec0-4e57-9a73-5e1ac9e41f7f@web.de>
Date: Sat, 2 Aug 2025 18:01:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Erick Karanja <karanja99erick@gmail.com>
References: <6daf83a9-abbf-45f7-b82e-c6207364fd8b@web.de>
 <fc1427ca-c2a6-4c12-a8d9-c8c692f1544a@inria.fr>
 <b0a5a727-c972-4cd5-baef-adf5dda72992@web.de>
 <41b71929-b32d-507d-eff6-ca19ea3c965@inria.fr>
 <b7298dde-48c6-4e0a-87af-2046ab999ec3@web.de>
 <3cdb1e5b-72bf-475a-a83b-c469e0225c84@web.de>
 <23a375dc-e768-f2b2-1036-909be61596d4@inria.fr>
 <70a43c52-f898-4fa3-a4b3-16c54bd4f9cb@web.de>
 <c1d74aa4-44db-4618-ba59-e9b6dab28c0e@web.de>
 <alpine.DEB.2.22.394.2508021326250.3428@hadrien>
 <7560a81f-ba29-4b16-b8ed-95cb4d72f3f4@web.de>
 <alpine.DEB.2.22.394.2508021353080.3428@hadrien>
 <e0519749-0043-4cb0-a12d-6a34e2076f58@web.de>
 <alpine.DEB.2.22.394.2508021409080.3428@hadrien>
 <c5042d2d-43df-4276-9611-da4f30763940@web.de>
 <alpine.DEB.2.22.394.2508021502250.3428@hadrien>
 <6239d52e-3213-4083-8d97-9b1f59d2d5b4@web.de>
 <alpine.DEB.2.22.394.2508021745180.3428@hadrien>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2508021745180.3428@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fTZnw9unogvsPWOQxxchBZdUKO6vJhnQ1wLgQeQHKpBpyYg7KBK
 DLNWpJePK93TLezHQ6F5ji3M36yRtxFwyuAjnx30mg8zWaHpsbKAUjlS0P7zUyzgt6VnqdH
 PNb8fQl1k9v/Gp0kGQ5c8gdM/EVd9/2yyRMy5Pj8zi5vU19/CbzIgDrsOyk8q2ph0fBs7NY
 8kUl8jXS0nyPs30+lwyOA==
UI-OutboundReport: notjunk:1;M01:P0:FBLI9iZLIS8=;0GiAZ9IGGAqmdr/+vFF/DgI3pHW
 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
Subject: Re: [cocci] Searching for lock calls without unlocking (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2939
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-08/2130ab11-8ec0-4e57-9a73-5e1ac9e41f7f%40web.de>

>>>> How does the =E2=80=9Cshortest path=E2=80=9D fit to the statement =E2=
=80=9Caction_lock(&blockage2);=E2=80=9D
>>>> from the if branch in your software view?
>>> I explained it already.  If you have A ... B, Coccinelle doe not allow=
 A
>>> or B to occur in the code matched by ...
>>
>> How many lock calls are close enough for the searched first lock call?
>>
>> Should the lock call from the if branch be excluded then
>> because another lock call was found before?
>=20
> No.

I would like to resolve this data processing disagreement somehow.


>      The one in the if is matching with the call closest to it,

I interpret this hit as a false positive.
(The first call lock call in the if branch is not the relevant companion c=
all
from the function implementation.)


>                                                                 not the
> call at the beginning of the function.

This is an essential requirement for the discussed source code search patt=
ern,
isn't it?



>                                         There are two matches at two
> different places.

I would expect that only one match should be appropriate here.


>                    Each leads to highlighting a different lock call.

The source file example =E2=80=9Ctest-action_locks-20250725.c=E2=80=9D con=
tains only one lock call combination
with matching expressions, doesn't it?

Regards,
Markus
