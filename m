Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E73FC0218D
	for <cocci@archiver.kernel.org>; Wed, 29 Jan 2025 08:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Q91aViWKg70H4cuVslg+icjMShEtQmcifiSI57zvyQU=;
  b=uqmPAZsreM1/4zzYvQXEMCQz3JVnf7Ysm9pq7vhuPpAiXD13OzknRkYX
   2mqW+FytaQ8NuMrZtR2Djiqxmc3slpsswxChxLzow8LmJRUowOjB4juTY
   sL1cNOVm/AQm8HUiq5ckp7lP6FWRZ+TEJi/aEyZmwwcIoOIoLUZAbQQq6
   s=;
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
X-IronPort-AV: E=Sophos;i="6.13,242,1732575600"; 
   d="scan'208";a="205515518"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Jan 2025 09:37:11 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9B575E0261; Wed, 29 Jan 2025 09:37:11 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id D73CFE0260
	for <cocci@sympa.inria.fr>; Wed, 29 Jan 2025 09:37:08 +0100 (CET)
IronPort-SDR: 6799e8b4_9wFaZ0ooFOh24HBhewZDY6OecCGC/JeYDXUjLg6bz2YmN5I
 E8RRU+a1ltW3qFpNJimE6jo/EiCOfo7a1CJ3gvQ==
X-IPAS-Result: =?us-ascii?q?A0EFAABq55lng07ASNlaGQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RIBAQEBAQEBAQEBAQFAgUADAQEBAQELAYJDgVczBAtIhFaPT4F0LQOBE4Moh?=
 =?us-ascii?q?zuHVYh2gVaBfg8BAwENQQECBAEBAwSFAAKKdQIeBwEEMQgOAQIEAQEBAQMCA?=
 =?us-ascii?q?wEBAQEBARABAQUBAQECAQECBAYBAhABAQE6Bw47hXsNgmIBgSSBJgEBAQEBA?=
 =?us-ascii?q?QEBAQEBAR0CR0QBAQECASMdAQERJgEECwsaAiYCAlYGARQBAYJ+gjABAw4jB?=
 =?us-ascii?q?7QAeoEygQGCDAEBBtpbHywiV4FkCYEaLgGFaoJjAYYmglmBYycPgVVEgRUnC?=
 =?us-ascii?q?4JAOD5pg1qDW4JpgjOETGeXQ4l3UnscA1ksAVUTFwsHBYEpEDgDKjYxI4EmB?=
 =?us-ascii?q?TVBOoINaUk6Ag0CNYIeJFiCK2sEBYEtgjuERYRRgkODGIIUemsDAxYQAYMne?=
 =?us-ascii?q?ByCLB1AAgELbT03BgMLGwY9niSEfoJeHjqSQB2DM5Axnxs0B4I4gWaBYwyfX?=
 =?us-ascii?q?AYTL4QEjQYDhjcOBpJ7LodkkGoioyhGhR2BaQM1gVwzGiSDNk8DGQ+OIRmEF?=
 =?us-ascii?q?MlmQjU8AgcBCgEBAwmFRgEBik+BSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 E7K
IronPort-HdrOrdr: A9a23:r8d4QKg2109yODaqnxwNRt/g1XBQXg4ji2hC6mlwRA09TyVXrb
 HLoB1p726QtN93YgBZpTngAtj4fZq4z/VICOYqUotKMDOW31dAabsSi7cKoAePJ8SdzIJgPM
 5bGsASNDSzNykZsS+Q2mmF+rgbsbq62ZyJwcHD0nxqUQZmUK146RxlYzzrb3GeCDMmOXIjfq
 DsnfavSgDQA0j+5amAbEU4Yw==
X-Talos-CUID: 9a23:cCTEdWMKmhKyOO5DAQRp5mguR4MZflaEkiaML2nhLEBTYejA
X-Talos-MUID: 9a23:JfJp9QaJnylHhOBThxnAhgBtNJtUyb2KEBErtJcpvpnaDHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,242,1732575600"; 
   d="scan'208";a="107620786"
X-MGA-submission: =?us-ascii?q?MDHdOZYDMvbHCe/fsKTzNs42Sk4ov9l6d78jWb?=
 =?us-ascii?q?0jSpffdBBRWex/yS71cDVrum8JPm+tyVm95CHGSWRTr/qKk8RlVuV7YW?=
 =?us-ascii?q?VV7AVTFM0XhQT/JJ97DqFc4Ol5blv/xLY2p+EMhLouK2kIHpIO1Cy6Fb?=
 =?us-ascii?q?wKlGV7kL+0RtdjVP1gq158xw=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 09:37:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1738139808; x=1738744608; i=markus.elfring@web.de;
	bh=Q91aViWKg70H4cuVslg+icjMShEtQmcifiSI57zvyQU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=cxUpFm972FDDsMEkEgb6qfloDGubAKcA3I48oLsRAk6cpwL54ehpAA5IHa4mxAni
	 m2rXoTnz5CVGdi+gbb8DNXJMxVwLOA7IdXOXaeHS4c3ZPouRs8Awvu69V+zcP4QYg
	 mwh0bKI8duHLhFjR/bujC1B2usIiixpboIs/D1dl6Pp5zFvsmP48LdTlHHiHsv/3o
	 GoxidTPntbFggnbFh1zlvPi9xzboIWMPDI+cdR5+dYr91F1EEjPz4wZKHwVqEMBT3
	 NgxSlrTttcBXVAJtL7MvFzpAMz5U6fDDYbFt43+qGWyfUjEDwlyp8g6ntABabvN4/
	 /MVLGYs+N/cnk9DM4w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.19]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MaHWx-1tzndt1FgL-00VFnP; Wed, 29
 Jan 2025 09:36:48 +0100
Message-ID: <fe13604a-2626-4641-908e-87eeaca53288@web.de>
Date: Wed, 29 Jan 2025 09:36:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ricardo Ribalda <ribalda@chromium.org>,
 Easwar Hariharan <eahariha@linux.microsoft.com>, cocci@inria.fr
References: <20250129-secs_to_jiffles-v1-1-35a5e16b9f03@chromium.org>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>,
 Victor Gambier <victor.gambier@inria.fr>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250129-secs_to_jiffles-v1-1-35a5e16b9f03@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sbMEtNKmAC+/Dgfy0WZn6CojtzpwVpi3dE3XLNl/mi+YpZgQUU7
 L9Fp7ycS37/73tPYivccO0QDZjU3/mUArXAiRdV41FeJWjvcnTRCRbI6AyRgiDMSqItV7il
 X69UlFTgWgKDEzktnUXjEFojkAhujOXKaMpG/KugihBFmlGjafaflTD4RreAFJ8n/pTz8F3
 B/ngZwGtJxdGDc16SDjjg==
UI-OutboundReport: notjunk:1;M01:P0:vV5ucOm6pOo=;mRZoVb5JGrGWHThlDqwQ0qNcvsz
 bHl61NdasYfxtjfghCCMjBJeb69oqxPyW2lGMogkhF8pZu+UNBH32oSuMubTb3cn7o55rhs6F
 qp4NepyfNiqpEkqkaHTz47avu15TqiQjrnq4jtB5zezThta7xhnoI4zfUCV4quKeI6i7HkA8t
 HoEGi7Y3RYuDqjqbI5QYd3H4Lr4yT1okpCDlBvSIWJEOhoiUVKid3/ArPL+BUKTdimhKTny2a
 BmvUCpgtpjnXdvmbWyXS8N89IgifkjmwxmstUHCTwib/RJyRS8xEqNaaiqSY5/cEY+nzLY7HG
 AOaLwsshS98ODJAwYO1z2GpWUnaHDwrcyHGZtpMszsBZ37HGp5MaTMRIKHpfmlNZCiCrFOxpg
 ASregLLRjcuydykWbWEfBVRHEOHGEg0b71XjGez4yEhfYGvSuOq2rqDQUBZNu0AiDw/S8eMLI
 EaAz4DRHtTAQqkpVmbyFM5Sb/PjW8UyDg/1Ws/SB6VX4txc89WfNuCo048vrf0VWrq6hZb8AB
 DdXVXlkeJx7XFQtVNKZJD93qrVRI3PvZsjJFVsXpASAkTi82Idd44ArYEB02+XKLlItKUOInR
 +o1HvAf0iVCiQ2kieewaX3vOfg3OzHMrSzm7N+plr+6BidbpuPuhZyCnFwnwlcW+lbjDSuJ72
 EPu0lRhin+DsSMykfBwTGaBkytF5EiKa4jcSWBfinKMpZPMDL+TmglbIO5Qi1m1tm0S4TRMBz
 vXKp5ZxHe1JGuf5wmNEfUN5e1YCKJhAZWeM7j5FFGMqKIZyyvWAV5vLZMwa6Z11WMxlwYF0Me
 idrkyqx7DxKNqTA9ircXF6Zc50jkkh3uS9jgGsO2ZwGnRaVJknKgo2RaZSNe01T3XMn75Hm3g
 TP6uI1pyIOoa1E1h/H1ICNcGVPMbD/aSw9pHzJ6sabcXLOZO3hRv3E3luNmPAwXLPFvBRuSrO
 FQ5kGTVNX5/AO+txauvereyK0E1pnpNAOaGfKcbyQDQemq9rV1rhiZHX1Z8n57GjUIWsejnva
 R7xNh9qfgjprkmkKSTeyIqtN8fKlx4AafqEbu5Uv3Si49HLtzl8a2RlaNaa0rxBAjLCMENNgL
 8UaMRvEC291EIZtrl283KDzApaWpY6luuK/GQ3Ag7Q36rqiPNKU+HcHnA+3IKXNYcaTHYD+2L
 66HOnOB/JJBUL67BNoYsPxYNwTFkBVgTi97bF6MkT2Q==
Subject: Re: [cocci] [PATCH] coccinelle: misc: secs_to_jiffies script:
 Create dummy report
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2300
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/fe13604a-2626-4641-908e-87eeaca53288%40web.de>

> When running cocci in report mode, eg:
> $make coccicheck M=3D"$dir" MODE=3Dreport
>
> It returns this error:
> virtual rule report not supported
> coccicheck failed
> make: *** [Makefile:251: __sub-make] Error 2

I hope that more collateral evolution will happen because of such informat=
ion.


> Create a dummy rule to avoid this error and run the other cocci scripts.

Please add proper support for operation modes around discussed source code=
 analysis approaches.
Will it be more helpful to work with function calls like the following?

=E2=80=A3 coccilib.org.print_todo(p[0], "WARNING: opportunity for =E2=80=
=A6")
=E2=80=A3 coccilib.report.print_report(p[0], "WARNING: opportunity for =E2=
=80=A6")


Regards,
Markus
