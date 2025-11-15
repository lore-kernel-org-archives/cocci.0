Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CF87CEB2D8
	for <cocci@archiver.kernel.org>; Sat, 15 Nov 2025 14:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=zUP35DETRhHtd+L6RiIfw91d2owAKWLMHlyFk2wYVkA=;
  b=tl1Qk9EB3dqPDZm+M7/SgzC+a8X3k37WJG6G7U2TMODUhCNiFkVu5pYQ
   1TQeNJhpqEwGzVQphiHf8/f2dRhMbkSqdh0epzGvBN0P8t5Cq3UwXt5As
   bsnVHwDnUIxiu6oXyQpebFK3WwE+t0bbpVcja9mAJ3HWdpq6v1cAJHDdm
   4=;
X-CSE-ConnectionGUID: oxwhqX49Q0SAa4rnwpchhA==
X-CSE-MsgGUID: bcMl3ck6Qy6H81/7XmSuig==
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
   d="scan'208";a="249327937"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Nov 2025 15:28:14 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2CF21E0BE9; Sat, 15 Nov 2025 15:28:14 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 14DD0E0171
	for <cocci@sympa.inria.fr>; Sat, 15 Nov 2025 15:28:11 +0100 (CET)
X-CSE-ConnectionGUID: +IjULHtpSsye8MeOzU2DpA==
X-CSE-MsgGUID: qYFjUcP/QImb2G+tvVsw7A==
IronPort-SDR: 69188dfa_sEuQo3MdVY+0hEpoXIjv+IHrU3yBiZiacAwmaTNHbWa24ZJ
 tJ0nsyc0Pvs5aKz0O5ytRVqxS7fwT3dnrAoZJ6Q==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HxBwBEjRhpeAQP49RaHgEBCxIMQIQQZR1eMwQLSQiET?=
 =?us-ascii?q?Y9TgiSEO48RjEsCDwEDAQ1KBAECBAEBAwMBhQACjFsCHgcBBDQTAQIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABQw4KMYZPDYJiAYEkgSYBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQJHRAEBA?=
 =?us-ascii?q?QIBIx0BAREmAQQLCxoCJgICVgYVAQGCfgGCIgEGEAEDDycHDQavHYEygQGCD?=
 =?us-ascii?q?AEBBtpfHywiWYFkAwaBHC6FboJlAYlseicPgVVEgTwLgkcxPoJhAQOBXoNbg?=
 =?us-ascii?q?kcigiaBDoF0l3BSeBwDWSwBVRMXCwcFgSBDA4ELIw88BS0dgSQiHxAIE2A9F?=
 =?us-ascii?q?0CDSRwGaA8GgRIZSQICAgUCQDqBaAYcBhwSAgMBAgI6VQ2BdwICBIIcfoIKD?=
 =?us-ascii?q?4k1gQkFKAIBC209NwkLGwY9lR5RgzsslVGzKTQHgjiBZ4FkDIoulT4GEAMvl?=
 =?us-ascii?q?1IOBpMFHphojgiVc4VGgX8jgVwzGiSDNk8DGQ+OIYQzgQvDMkI1AgkxAgcBC?=
 =?us-ascii?q?gEBAwmFRgEBjFaBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 t3SRDNKNBgRlgiovfkxDBoPk+tf6iEz1g/FGwEU
IronPort-HdrOrdr: A9a23:K9LlKawtCncL18cftGf4KrPw+L1zdoMgy1knxilNoNJuA66lfr
 OV7ZAmPHjP+U4ssRAb6Km90cy7Kk80mqQb3WB8B8bEYOCighrPEGgA1+XfKl/bdxEWn9Q1vc
 pdmupFebjN5DNB7foSjjPIcOoI/PnC1ry0juHDyHpXQRhtcLwI1XYFNu/WKCxLrBItP+tDKH
 Nw3Ls8m9IqFE58UviG
X-Talos-CUID: 9a23:zjFvWW5BpgzQl3QHmNsst28WJ+QFbmXm12bdc2q1LnRUEpGNYArF
X-Talos-MUID: 9a23:oSuZ+gndEczDjm35kN0adnp7Belq3q+WT3kslJ9clIqYKxJrJGi02WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,307,1754949600"; 
   d="scan'208";a="249327934"
X-MGA-submission: =?us-ascii?q?MDEBQmzLsU1I04E+WKxqroToN7Hsmt4mwB2Vo3?=
 =?us-ascii?q?rREWTs4dWTyG66JNT7sNA5WE/Po/cT89XXi/DzEobSfAH0TEyLRhtoFw?=
 =?us-ascii?q?L+7IBCf0kr1CSD70AYGlXU+63egC+X7X++Q193ueK0ZMHJ2pU+7p8d5u?=
 =?us-ascii?q?GvX8N8SLIKRZRuAx96gYleRQ=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2025 15:28:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1763216890; x=1763821690; i=markus.elfring@web.de;
	bh=zUP35DETRhHtd+L6RiIfw91d2owAKWLMHlyFk2wYVkA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=pizY7wiycOKEyk295sB+aoOxb6BwZnIsvM7P3SxxLMRbksoaZO+C08M1mu7QeDB1
	 GleXLrfasPdXqvzVdvoOtTNN27V4LLjcZdQDkadfsQh0TcYcObPp4MT6ilSWSxk/5
	 qDKebF2VHsZXQ49ZTR8tAw6NVa6EFblOjsqQQZGKH+oHEFgDVU9vZFgH4XdeR68tQ
	 uOPhpxBPAcnYIspmLWqQEoMwChCbmK8RI3iIFA6pgc3mG69abk0z5yUNG5DrYQ6pe
	 gL1AfFNy04hDAYvAbR23ZVuXaKjx3aa1eztW+iKbz+OZ99b0OoZTR1Ba143Yxf1LQ
	 uU+295HlH6+3Q2nTJw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.174]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MsaWF-1w9ccj1fkB-00rLUg; Sat, 15
 Nov 2025 15:28:10 +0100
Message-ID: <64055641-bd2f-49dd-81c7-f1f02c7a0ed6@web.de>
Date: Sat, 15 Nov 2025 15:28:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <f29ecd7d-5841-4989-b3c9-1055a6df5eec@web.de>
 <6eeb6db9-5726-c0ea-3d1d-e42bd19eeaea@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <6eeb6db9-5726-c0ea-3d1d-e42bd19eeaea@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Mi1SNuqDSXp/fbQ+Mt3Nwm+aKDGEDG9wnOqtLhWXeSW6YzoL54+
 EI0tv+vqxSMsKLB3fgtidvPSJ3jm4MRwwtRrWLbH8cudafLssnqwrpOXQfagkv96B3dGpSD
 XiOBWt4yOa8if3Accyatoqb0uhD9rBqU5QkapVNoFHd10Fn3ONaErCke1yIvx8FmtlsUTYE
 0ldlRwvuSWekX9Y0Lvwlw==
UI-OutboundReport: notjunk:1;M01:P0:TltrM0myEmg=;T/sMkGSytaVoMRvjzmYgkkcZO/3
 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
Subject: Re: [cocci] Missing file filters for data processing with SmPL
 scripts?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3183
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/64055641-bd2f-49dd-81c7-f1f02c7a0ed6%40web.de>

>> Under which circumstances do you observe the information =E2=80=9CNo gr=
ep query=E2=80=9D?
>> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/e6f8731b851f5d76d2=
731a9d546dc4f0b181526e/testing.ml#L660-679
>=20
> When it seems like the query is too complex,

I doubt that such (grep) queries can become too challenging so far.

But I got another development idea which indicates concerns in the opposit=
e direction.
If a source code search term would be too simple or just very generic,
I imagine that it could exclude filter possibilities from other code parts=
.


>                                              or when there is nothing
> useful to grep for.

Which implementation details would be treated as =E2=80=9Cuninteresting=E2=
=80=9D so far?

Regards,
Markus
