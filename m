Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C5D7C35FFA
	for <cocci@archiver.kernel.org>; Wed, 19 Mar 2025 07:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=uqnlMLCkLgHvxemcnj0ZA0ydlBSw0xjyWTK3redUfMQ=;
  b=I47ov7MGcNOwCvya1vsEMfSCCMj2ZVC9MUHPcZ+HKxanke/R3MkpfiBX
   gfOBFHk3t+pZEYs9eP6vKnVjXL7zOKT50/JCS1+h76ypmUpgCbB/D9piJ
   k+1PffSwV/O8ZjkvakcwV5Jgb9RpHoMTnkNe9w48UfFkXaIxVoI94rAAV
   4=;
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
X-IronPort-AV: E=Sophos;i="6.14,259,1736809200"; 
   d="scan'208";a="213615349"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Mar 2025 08:20:45 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id EFDFCE0D1E; Wed, 19 Mar 2025 08:20:44 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id A09A9E007A
	for <cocci@sympa.inria.fr>; Wed, 19 Mar 2025 08:20:41 +0100 (CET)
IronPort-SDR: 67da704a_CMVMyKsAGruG+JaJg0UZvHpVKa7DVUdaLgH/bM61d0AhD31
 v2J+RvrBV6AShItB+p3Zqz+pA8gGKvxjn82htCg==
X-IPAS-Result: =?us-ascii?q?A0FTAgAGb9pngAwR49RaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBU4JEgVczBAtIhFaPUIF0MIQ7hzuHU4h1g1QPAQMBDUEBAgQBAQMEg?=
 =?us-ascii?q?gyCawkCiyACHgcBBEcBAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECE?=
 =?us-ascii?q?AEBOwcOCjGFew2CYgGBJIEmAQEBAQEBAQEBAQEBHQJHRAEBAQIBIx0BAREmA?=
 =?us-ascii?q?QQLCxoCJgICVgYBFAEBgn6CMAEDDiMHrh+BMoEBggwBAQbaXB8sIleBZQmBG?=
 =?us-ascii?q?i6FbYJjAYYnhDwnD4FVRIE8glIxPoRDg1uCaYIzhEFniU6BF4c9h1aQR1J7H?=
 =?us-ascii?q?ANZLAFVExcLBwWBKUMDKjQxI4EiBTQ/OCmBY2lJOgINAjWCGyRYgihqBAWBJ?=
 =?us-ascii?q?II2hD6EQIVQghGBXQMDIgGCMG93HINLdj+EYS1QghYdQAIBC209NwkLGwY9o?=
 =?us-ascii?q?2yGH2/HTjQHgjiBZoFjDJ9eBhMvg3ABk1UOBpJ9mH4iqRGCIYFcMxokgzZPA?=
 =?us-ascii?q?xkPjiGELbRmQjU8AgcBCgEBAwmFRgEBilSBSwEB?=
IronPort-PHdr: A9a23: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
 4qX/J8=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:em09e6trsTibBzB/gNTUHWgZ7skDjNV00zEX/kB9WHVpmwKj5r
 qTdZUgpGLJYVMqMk3I9urwX5VoLUmskaKdpLNhWItKPzOW21dATrsSlLcKqgeIc0bDH6xmpM
 VdmsNFeaXN5DZB/L3HyTj9PNA63tGd/aykwcvYxWx8VBxnZshbgztRO0K0FglYSAFaGYE0Dv
 Onl6x6jgvlV3BSQMrTPBc4tiv4yOEjVqiKXffLPX8aAcC17Q+V1A==
X-Talos-CUID: 9a23:TbJog2PKpahVd+5DZhY+yVIrFZ4eL3z94nnzcxa4UztuR+jA
X-Talos-MUID: 9a23:S90qvgbkFotQ9eBTlQDIgRpzZMhSwv6SUWAyt5oolMugDHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,259,1736809200"; 
   d="scan'208";a="213615345"
X-MGA-submission: =?us-ascii?q?MDE7u13jnkdCsbWVkRwC9cibv9GOFzNPEkAYz0?=
 =?us-ascii?q?AUfBO7oqphyTs4fSY7NlLB2LwBmtoTAmbwSJ80uCsx21fnDftntftjcH?=
 =?us-ascii?q?osCM9TSDhz9n4sjojekSNETheUZPm1KHoxJNB6e6y2ODZtnJtz+2Wkqp?=
 =?us-ascii?q?7ry9//7VIiWOhUnHUK4IwE1Q=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 08:20:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1742368830; x=1742973630; i=markus.elfring@web.de;
	bh=uqnlMLCkLgHvxemcnj0ZA0ydlBSw0xjyWTK3redUfMQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Hqn/ebcdKKEb1vSP/uNofLYfj/ve5Q2T1MpqyK3aPd7dLu21aVZeekEBhdMqu7Ta
	 UNI59NxYQXwyr1ZxYKuYkq3bReKt1I1CJp3CmVX7AW5Id+PywkQNuq+9cyaLMEO9N
	 cdftolZGgZQrq6dn5Er5mKyKVJpMOcm2JqCTCMgBw/7giRp+xz0skeys90H7NVT/a
	 M77LNaPsNYLkSXNzdCou6d3XHKhrpaLns3zlV6/iJ8BSrxRLvhZFmjAf1gQ9cXCpm
	 vn3xFjtWT5sWrAh0Ti88LhL/k9A2O9pG0/QTdFo5icSoJLmKs0S6BbaEr4WHwGZne
	 r6gpdGqbc1k2w5eiuA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.16]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MEUW8-1twPTQ0hZK-00GEut; Wed, 19
 Mar 2025 08:20:30 +0100
Message-ID: <7473aaa1-db5c-4c7f-abf4-864055c2618e@web.de>
Date: Wed, 19 Mar 2025 08:20:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <Julia.Lawall@inria.fr>, cocci@inria.fr
References: <202503182023.D7C4D91@keescook>
 <0F8C28C0-B4BD-4806-8094-51B04BD649C7@inria.fr>
Content-Language: en-GB
Cc: Kees Cook <kees@kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <0F8C28C0-B4BD-4806-8094-51B04BD649C7@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/drSRdJDetk9V9Wvd3EN5yqAtwaAdeNj8rwEcLdb3h3s+GlU26K
 RX27Ro5Yzo3wHMZpo5tZeY+ieWZwwmY667qj312EDA76v7EpNl46IJYDYMeW8ELg3EZdfFu
 1CGVBj52Lhz36G432O6haFGnwZeIZ/NoHcAsgr7LbGyU9cNjSZmPFV3iNyVOWa4I26PiVmd
 mmKIDlZTxB6X6rJ+Nv7GQ==
UI-OutboundReport: notjunk:1;M01:P0:VYRI762MQyQ=;naMQLb4QWgBKrDSCeqsZYRSehdm
 TsdZ4Pbf4M7orL6BOVH4JbNmarqCmTDWMNgmaXiUyILgLJO6sDp+WtH+Hw1D8/uV/AvkKOmHL
 A8YYNxT0Mgk1Ar9SeL02kusZjdksobwUPE743oZdi4gIaQFlZv1fmv5uAfRVuOEMARMJ+w+7t
 xwusSh6wfxE5KkiEgXkgDNM32kNPY3gSs2Iu6T3DKJwQv2fXgaLiQl5W6ZHPeLSLHOW4IP5IO
 HTlJJbJrjmzfcfl0MwWnMGodT3zuFMaXCAxxpTS+4ZUmx8uyaR5teB02AWRaRSJoQzn4gH736
 u8kF+XyY1jOU7JDSWtPtZMa0HSXGpScHI+kDlMjxjiuqzhcOIQTQdVlgd4rT6aBy7IQCAd4cW
 9JagTP3f4XBJw0iKbrnV1V+TVG4ucuXTVwNk8Dcots/Mz0EEY8hEUJjZBpYCLwOomdkcv1oxm
 jsJuYZfodqVIWzlBuG+cHfP0QvLEglOtl/5gtlf8EFYrPljjG6GCFH+jJ1luBu1JQCb44ExIV
 /tC7NN1yrDn89wp8PYg6PmUf8ONDwcXNiqnOgwqtpu9Cqn5S/1gUcaQf3mqxyX0Gv6BIAxYks
 qAsODkpgagsdyHEjcTsrZsff7QACy1gwWAQf2Yjtjbz3qU/9i3HnJdRhved500YsJ3BCi3OjD
 8Ph6tU4YJyzc9C+PF8+zmEqgrJicuczu5Z+EJ9QVcPzk3vkpa1+gPifYTwuU9yLTflXPRuLxl
 j/+czHrzVTPqsMXl2EwqviYwojJ9f8avXU5Wnt3gprVHBImaL2BvuFa1+0RYm/Ms//siFeW4w
 2RiYWYY53QYGZeBaq8gKOGLQhdNG9NDgdOSu/YRV4fqSYYlwKqNxZ9Lz0wb6Z2RU1JwqVloVv
 0ntlzSnzyQEKS9yrY7ynjz8Qq9JaJU7cWqJtzpFOz8V718JP8oEmmWOAvdQM+rEUlj8kvWaEg
 6RO++JLTtDOqnNNMnn4DVw+1NAYWF2kP5vaHAo+0x4XNHh1g8gE9HzkyTnZH9jnUJPRZez5PH
 zrJy7+skhD4zMhEmaSiS1lWhCPot961hVs0NJ3T3Qvp5LXMroX4k9zTprf6VUthYrn+4FxP0B
 /7kjujcdbsr9COkXlbEfb9bg6U0mxAGObmSYbb4PoBkrr5iq7mfdHPOLFaobkwXlsQLRBKSQH
 80Xy73kcpjmyM+IAzOPdH1icV4+TbMwphzz2fAAxqRiOY/8tsWzjuG1TROMMJwsSG7p6eao90
 gZKENWh19vYfZf9g+LYq9mDGZXvjHwq/MrNzXvsC4jlU/U+63EaHQnAkbanHoeMMj1kbNYAbJ
 tje34zpJiamwckrWLjqgkcveUDXjSZUYfC6lTuFI8bUGUFkzCy9FEOWi98APY7aoOO2FDtyJ1
 USV63OwW9OUXtp9yxReb6sm0dCwvlby2Ss+3q5ZPZfRoFnewwmWh2r2U9M/LyJ9PR8lsrrMH3
 WtlvaGUsUhQ3amD/par1NmRwGjD95lsWOx+n4uJyBCvPsjLkY
Subject: Re: [cocci] Checking the determination of type information?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2634
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/7473aaa1-db5c-4c7f-abf4-864055c2618e%40web.de>

> If it doesn=E2=80=99t match then it doesn=E2=80=99t find the type inform=
ation?
Can desirable software behaviour be clarified in more constructive ways
(even after reported open issues according to parsing of C source code)?

Regards,
Markus
