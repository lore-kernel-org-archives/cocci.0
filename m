Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57731C0218D
	for <cocci@archiver.kernel.org>; Wed, 29 Jan 2025 08:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=/630C+CIkYuGrn0QRV/2ElPy58L7cgeFfD+7FLwoMKM=;
  b=dDo/vhHBkyuNaBBADTQ+KWC3B0/HqEIPedRh96YhdyCpOc9S+DAHw0xp
   0iLL2roZlGD0C0kxCzE7UVtASeFpg7mmUi7eQzcCGf8P1VfVmeswZwtz2
   jkkLPZTmC6ZcSEBhsI/4llyexRoMGTUkNjdKN1CgkSZ8Oc7NZi8XS2Hou
   A=;
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
   d="scan'208";a="205518681"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Jan 2025 09:46:58 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id BFF62E0D1E; Wed, 29 Jan 2025 09:46:57 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id B853DE0260
	for <cocci@sympa.inria.fr>; Wed, 29 Jan 2025 09:46:51 +0100 (CET)
IronPort-SDR: 6799eafb_AcRF52P5ppaKtP+0S8FHicZJsZ+OJNGqcYt3MBLKzYVdBJt
 Af+f01JUFKnNhJOUBG/9z7n76VNmgxtQTU4bV1g==
X-IPAS-Result: =?us-ascii?q?A0EFAABL6plng07ASNlaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE/BQEBAQELAYJDgVczBAtIhFaIHYcygXQtA4Q7hzuHVYh2g?=
 =?us-ascii?q?VaBfg8BAwENQQECBAEBAwSFAAKKdQIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBA?=
 =?us-ascii?q?RABAQUBAQECAQECBAYBAhABAQE6Bw47hXsNgmIBgSSBJgEBAQEBAQEBAQEBA?=
 =?us-ascii?q?R0CR0QBAQECASMdAQERJgEPCxoCJgICVgYBFAEBF4JngjABAw4jB7QGeoEyg?=
 =?us-ascii?q?QGCDAEBBtpbHywiV4FkCYEaLgGFaoJjAYYmg0J6Jw+BVUSBPIMDPmmDWoNbg?=
 =?us-ascii?q?mmCM4RMZ6E6UnscA1ksAVUTFwsHBYEpEDgDKjYxI4EmBTVBOoINaUk6Ag0CN?=
 =?us-ascii?q?YIeJFiCK2sEBYEtgjuERYRRgkODGIIUemsDAxYQAYMneByCLB1AAgELbT03B?=
 =?us-ascii?q?gMLGwY9niSEfhuCQx46kkCDUK9MNAeCOIFmgWMMn1wGEy+DcRONBgOGNw4Gk?=
 =?us-ascii?q?nsuh2SQaiKjKIVjgWc6gVwzGiSDNk8DGQ+OIRmEFMlpQjU8AgcLAQEDCYVGA?=
 =?us-ascii?q?QGKGywIgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:xjiVzq5yKecZdMzpKwPXwBzXdLJyesId70hD6qm+c202TiXqrb
 HLoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhWotKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkaNDSaNzhHZKjBkWqFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQkjuRRjz7LqVsLjM2fqbR+a
 DsnPauLFebE0gqUg==
X-Talos-CUID: 9a23:DcJeamMs/b31PO5DRwJk6nwXNOwfYF7+4XXZc0DoF2Y5cejA
X-Talos-MUID: 9a23:cykWUwmvWraNrhbcV7v8dnpnBMNxzoGVD3tUgJRZl8SjJwd6JzG02WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,242,1732575600"; 
   d="scan'208";a="107622240"
X-MGA-submission: =?us-ascii?q?MDFuI+yVXvPJu9vI1FX9LP278zRnAGL+QUqHpw?=
 =?us-ascii?q?Yn7RqT/bXOD9deWFGHHI4HjnzK/IWWjn4UEJ71YUFssnr6DdoHhyOuII?=
 =?us-ascii?q?/+l/X88FOEDXzD16Wlq2qT0FEj6kizBWcn8tQZPqFdXRXwpEZH1QCe0t?=
 =?us-ascii?q?3vYHDlzxU59as/ZdP+Vzk0pg=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 09:46:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1738140409; x=1738745209; i=markus.elfring@web.de;
	bh=/630C+CIkYuGrn0QRV/2ElPy58L7cgeFfD+7FLwoMKM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=htAkK86s/S61beDFPmL8eYy88jSodQwQgCsnpy8uwgxO3wL7ZVneMhCtDXLr3XzD
	 ya/ulQvPl/kWDcxYrzJ7eD1n6x8C3fNps9gjq1lCUUb31LX4qqUaq1kHXb6Q+GnbB
	 RZ4Q8+uoIaoEk4Lij64dHWG5b6GOmogmHgN55y6EkQzgMdNjVnj5PTrp0yt17AHNd
	 AXJRsdobl87/bTx6I/zHbpBlsDR2jBG6Ofe9NwjGrf658NgarQ/G3HZs4Z+oRYCzB
	 4ZS1q85fRTP2UtmbfljwWZDCF2oYyJYCtXGcBf9ec40jybsGNuscd+CiHHmruSgVu
	 krkubfslaDxTuGV95Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.19]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MrwsB-1t8w5U3HV7-00lt03; Wed, 29
 Jan 2025 09:46:49 +0100
Message-ID: <fce88885-8c10-4f22-a19c-3b04430aec3d@web.de>
Date: Wed, 29 Jan 2025 09:46:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ricardo Ribalda <ribalda@chromium.org>,
 Easwar Hariharan <eahariha@linux.microsoft.com>, cocci@inria.fr
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>,
 Victor Gambier <victor.gambier@inria.fr>
References: <20250129-secs_to_jiffles-v1-1-35a5e16b9f03@chromium.org>
 <fe13604a-2626-4641-908e-87eeaca53288@web.de>
 <CANiDSCvufe0nK_NLykSRLb9RmttNOhw3-mm6aiC=gj41Hxtgiw@mail.gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CANiDSCvufe0nK_NLykSRLb9RmttNOhw3-mm6aiC=gj41Hxtgiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kcKgRWibP0MRuqDZ3WitnDD2Gm8HrfqOd/QvbiBB2IZFvyaKW3q
 3OUNoCfqyvUyEC/vhS7z3V4wt8Mxb/fwYXeSckvA4/nA2v772aFH4E9RjXYPgSMWNM2p5sI
 4ygUfE63xVtF4NUxF11hRUGoXGgnK4Y+NbdbZX6p7qrIkRvKQ0IxCiZyX75B+Asz/prIhYX
 DcHlMjwdbCqtxsOjYOmdQ==
UI-OutboundReport: notjunk:1;M01:P0:0Hq9ZiBWIa4=;v+dcI54E1H0PZTcRdUYBRUs9R7B
 WH6vy9YGPZF0/vUewsGfFj1xEHU7WSDhiUWlwjl79VYEydI74O84uNvswM1fYRPMbrtbTWY3Y
 Rc0jg1WU87azaHkRJBKdQpH0JT3o9Zi0/lXyZv7ZbCwdtc8mnEq7+JKrRVKXM5+lEV0+/Yiay
 1+xeVk16yG2Wt1zr61Wwf3NDii2VOkWbw6M70qW0faZoC2CgnEoDmJRcnxlduTlChD1y88N3J
 BV0887i8RcDh28E9qSWVR6knJ02xPyQg3cnlSCcNhQhycyrwmU4igK9LlO1s+5vD4GY5qATPu
 TSxzaRM4Edem5FVcLgSLWfukohwtPVPyKpm6Ya+GUre5JxByg92f6uujQVthVXIOd4DPwCCqW
 1ESj2b4W97zAT3artIdlrfVlK7poFZ2qN/B9lG/RVAztTVD1NMYlHXWjw2BtXQzCLt1WmlXvz
 Fv+QdY5vqAyriVaUOfxlocvCQIa8vTFtGdOAe0abuJC5Q8ok5Rhgu2J1hky3CIk8JXBGKBCcZ
 sn97rypWF9b5ItakTRwiqU1Po5Msr+5iLntPeLzI0Z5oOhJZ9UaGgcbOLqcTMAZ/UvYvaefFi
 P9ZhXLnlDAlgJhCtX8zt7na/IsSzQgm8o8B+04scCDgwvUM8p0RiSdyKq10CFOs4kItLkwgm4
 PFKKTNT6e8C5XaQSXjzHfKFe3/r/DzZJrggXwiDLaf5amDOlTrtohZuuAGdv2/hmTSJzbspfG
 d4GSMsk4Ae4lxpKzF76csxpxM+df66+TshkGC5Q6oWSk53T1gdhwSNfRQDQUG12vRgDPT4RU5
 t8F3BD8eeJG26HrJJJthfhWjOp08qj/oCpgLtYlfIAY5MJZT3NE30u+eMR+634JqtFuW3oUPL
 /Yud7Ps98zNnx9QA18yPSFqWCoVj5qSnsTbW6aq8aHgkahl54grJ0lV8Cr9Zzf6jsnWZNe2Q5
 RjdodczSgII2lF2T/PHxgq4r88FSWPS3qndy6YJyOuHNmTOWPJGiutQoii1n7VCdbF66F6LKz
 SxS6sUCyBk3nNN9KRzJeLiqfMx9wMQZys+EYiuMrbEOxXp9NxTmbn1+RgmN1mwejZIQ0k0Llr
 aPaLTAmkILhuklylp0CD/DtKdLDCbWLduIN7n6t9LO8LsXKprJlZADm5/L9q3Aqjg9qxwXAaZ
 4TWkuSeQS7U6/9oC6eR8TeATZUMhBNIetnXtGLfHH2A==
Subject: Re: [cocci] coccinelle: misc: secs_to_jiffies script: Create dummy
 report
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2302
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/fce88885-8c10-4f22-a19c-3b04430aec3d%40web.de>

>>> Create a dummy rule to avoid this error and run the other cocci script=
s.
>>
>> Please add proper support for operation modes around discussed source c=
ode analysis approaches.
>> Will it be more helpful to work with function calls like the following?
>
> My main concern is to fix the CI that was broken when this semantic
> patch was introduced.
>
> I am sure that a person more capable on cocci patches can implement
> the report mode in a follow-up patch.

I prefer to avoid a temporary workaround when a more useful solution
is actually simple.

Regards,
Markus
