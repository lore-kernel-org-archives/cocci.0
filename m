Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DC75C36002
	for <cocci@archiver.kernel.org>; Sun,  6 Apr 2025 15:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=K6UXdRXl9MHFPtosnw5TDjv8tKjgmiiclUDgOIc7zrI=;
  b=je/xec6aHuyfHmBlcLnPVxSFDIR64ms39G54/an4ou1Bmxz+PVS+jIHa
   WvgikLjBNW/jDBZAPDb6UVDEGOltAsN4vw7aGDz0rrO6VBEi7LE18eurE
   rwcoNaUE6pEfySohZFzkMvuD3RIRFahwi0io+3m63ei9+6rz7yv6GMJT+
   0=;
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
X-IronPort-AV: E=Sophos;i="6.15,193,1739833200"; 
   d="scan'208";a="216553583"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Apr 2025 17:00:44 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CE722E0D1E; Sun,  6 Apr 2025 17:00:43 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id B636EE007A
	for <cocci@sympa.inria.fr>; Sun,  6 Apr 2025 17:00:40 +0200 (CEST)
IronPort-SDR: 67f29718_3sQP97d6gyDeopupN7nm4XgPY4TC1FDHDvkaywP+f+u+t8M
 5Zv0jwAwKEaYQ82HQMF3+ZA4NTocB0E/aJsogew==
X-IPAS-Result: =?us-ascii?q?A0EnAACMlfJngwsR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDgVczBAtIhFWIHYc0gXQwhDuHO5BHgVaBfg8BAwENQQECBAEBA?=
 =?us-ascii?q?wSBawGDFAKLKQIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECB?=
 =?us-ascii?q?AYBAhABAQE6Bw4KMYV7DYJiAYEkgSYBAQEBAQEBAQEBAQEdAkdEAQEBAgEjH?=
 =?us-ascii?q?QEBESYBBAsLGgImAgJWBgEUAQGCfoIwAQMOIwelcnqBMoEBggwBAQbaXB8sI?=
 =?us-ascii?q?leBZQmBGi4BhWyCYwGGJ4NCeicPgVVEgRUngRSBbz6EQ4NbgmmCGheBGpBuk?=
 =?us-ascii?q?AxSexwDWSwBVRMXCwcFgSkQMwMqNDEjUwUzHYF8g3KCME+COYIRcGwDAyIBg?=
 =?us-ascii?q?xV5HINFgSmEE0ctT4MzQB1AAgELbT03BgMLGwY9l1qEAguDfMYkNAeCOIFmg?=
 =?us-ascii?q?WMMn14GEy+XRg4Gkn2YfiKpEYFnOoFcMxokgzZPAxkPjiEZH4N1yCNBNTwCB?=
 =?us-ascii?q?wEKAQEDCYVGAQGKVIFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:x2HkkK5UftBPlqrb9APXwBzXdLJyesId70hD6qm+c202TiXqrb
 HLoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhWotKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkaNDSaNzhHZKjBkWqFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQkjuRRjz7LqVsLjM2fqbR+a
 DsnPauLFebE0gqUg==
X-Talos-CUID: 9a23:PAXIY2+ul6aty5bJHMWVv2UrBeA8W1ia9jDvfROVU083FabIQ3bFrQ==
X-Talos-MUID: 9a23:Rt/9HApc74JuKoA1StQezxtzE+g4w/SuMktTnpY8sNCGEjFZZijI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,193,1739833200"; 
   d="scan'208";a="113565857"
X-MGA-submission: =?us-ascii?q?MDGd4DULwAW3461JA7e1GJMkJ1R9JRi4jSk6iz?=
 =?us-ascii?q?2lEeMxQVJ7tZzbgkLp9UOTRE1izn0nf9UfYXBvC4GM4p23Y2w3a2x/zF?=
 =?us-ascii?q?mHCfsOnHMd78o84Ivci5vEzoVSw7Tjmz2Ui+ZjSw5uyc36v0BCYkPQ1X?=
 =?us-ascii?q?9ys6m7Z1Kpe4Y5A5+HG2sB8A=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2025 17:00:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1743951638; x=1744556438; i=markus.elfring@web.de;
	bh=K6UXdRXl9MHFPtosnw5TDjv8tKjgmiiclUDgOIc7zrI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=sbs2md/LpXBzxM820Mq2FvU52P9V6AJ9qLN3dRw5dZYLer+QZzEb62ShdqbPf0Lu
	 jInrDbuZA34xT/6+1ExD4QeQ43JPOeo+3nY88l74w5Xn7ESU61v3andgXrGQv4UiC
	 27M8TIBJx09TUuz/uE4hJzJt/5+XQR4RphfTVApKH8c0dWTJP2wVm7dTn9jcoKZGV
	 OrYhpzmoJ7lypHu5N6GIIjCoyefw3s+bE0Ygsrk1m3rcVuW5FOBoNzH+WIp/F7Tfl
	 uK3oOPgkBvq0rBrmgBTFAsR3ItvWu99Pgzpo9Tgn3R2QB/h2ZNKYGOLhCNAL2O+68
	 8/eUJ9o4BW51ujhHsw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.38]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MmQYd-1tJcIB0mG1-00ZOPM; Sun, 06
 Apr 2025 17:00:38 +0200
Message-ID: <de6a4d5f-edad-4c1a-a8a3-801239892e6d@web.de>
Date: Sun, 6 Apr 2025 17:00:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, Luis Chamberlain
 <mcgrof@kernel.org>, kdevops@lists.linux.dev
Cc: cocci@inria.fr, gost.dev@samsung.com, Davidlohr Bueso
 <dave@stgolabs.net>, Jan Kara <jack@suse.cz>
References: <20250403020123.1806887-1-mcgrof@kernel.org>
 <dc6b7ff7-8da7-4d02-8fb4-52593137bf11@web.de>
 <6418648b-ade1-93af-c7e1-d41578ad3d3e@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <6418648b-ade1-93af-c7e1-d41578ad3d3e@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:T9i/xQSD98TtJ7rI2MyP1h9qxwDWMroBAPEHMt//sN4WFBEGBVs
 ca03vIuHjOxDV16FeWqsOWFAbPzaPV85wuAVUFCYNOkSSyFfezl7VxfjbGiqnsgB/Q58ZpY
 tcwFUmIXl/wxG7cq83wJk6rVJgoELGQiOWbXg7m09t8MPOK35bg3DuipSkYqoKfOJ0u0X34
 OQ2yb95gIrQbw1I6v8lVg==
UI-OutboundReport: notjunk:1;M01:P0:5HnLqtpzt0s=;d8VNqSLUktF9l3Q55J4qgGLHrIl
 1DezS0tExP7LybE0j+ZrcU73Ds8/5P1uwRpqmd7Z4oanQlCxqWMXteqLy7cNDgFsVWHckQhck
 i+/f0LepcPwDZGegzMR2eAOVVd1L+62hEtxNx1DDHRa4Gu8cAZq9sW1Fb3eSt8Ch+Da6g8Fyg
 Qi64iMu7TYx0eoD9Q34wvO4N3new9h97A+KKbPYwcPXUtva8W2/MjVu3IHUuiG3AAaPg5QG5k
 oV7VGqPSmc1AW2cR9xMr9qbFQXoJ+FqvHtHJgnuRF4HsZT0KouBVYvzgBZh6gIPZ59s0JJ5Gw
 Fe5H0uW7b88r2LzpWhhCS2CSFsnIBRLmn6g0D/eyCZHMywhyJOUmrhug8XwqN0xVXIz7fZgOd
 M1kyVqc0ifSTiapjlShAOCA3fLIIyCTjLo1kwsQZ/roeqi57vJ1XjANX3eelLaxAhPoaguShD
 1n1up0ZrPiLhi92he28nNM8xzmBjeh4aG9aU4F5tN4UYRUYxOX564sJfdXxKAL6k/egZ2DNP4
 aARlQzQRdLFAp0N9jPifeMfnNThf5kK49NvOFH2FIiyY0FGeb3XEcTBKUP8i5mHSjhdqNZh4M
 4WUafnZNHhrSRRgrejn2Z2Ag16uTSl9AUYIJGk+dEqpvUmW+75sDueha1Bcn3twc4hS69zr6l
 4nOxwKRZcM2wPT4TymolrbyowN/TivHf3hN0zzgFKLgjWmlU4P29vusJ6RgPyV9MEXeevfTy8
 ssOXWetq04XxkjBimKIBm1vP+lnqv+ioK8sXcHsv2ZQzMBkTag0UoGTxbR66LREERVNIVfYyg
 ACt+bFD/c7CsPUrAyJlVNvukSZcw0RhADxQcnzD/7+XTCBnexAY/EVjME4G03I7A8FFm66Kxu
 Eu9cixrm9U+ZtACBk64yHb8UoG5rc32+ZM7BrUY8+RK/WfOvCwilIwpTHPUZBeyqAI5fqvmZ9
 tDmWbKpYeddEQDyLJHS6Q4h9+/xjU0QfAQ4OCc3EPt8CbE6r/LowemP4tMxN715qhHcgSxLKv
 R/BYmxfqFYNeOR4QEgZpPD+SSddVScGBMjMLzNb/TAXnIVHbusyJhji4wJYsxKJn1CpRdaw2B
 IKBNyhe8zvWYWl8SRpu6ejCUcO2jcF2lRVwsuHXhYkp4kvktAfbu2cQ9yjoNz4r8Cwpfu+kNR
 HqKArwtgFZS1hYqVXwtPRMR6edP4f97a1+MkekqM5egkLlYDiRwB77P9WXmW2ylCPl4kqQ0tw
 X5NMVIUoorwahBXCXStyti4uHPF8bt5KHDHyAounqW72P2BB7KnmtpR0UAZzUKdYYFHj3Ublk
 OKgPneVTsu7hjKt80OAvmWcJEIpPQew11i2qdWF6pi/BbsZTqDwrn3+TXj/FqqC2KHXKw1Kds
 58bVGkD0w+F+aLT4lQn5iO5xbQMUqUm0/p3GEsnps2Z0zKt2N8gqakwEJn8IBCjLXURlsNs8W
 CK9n2l/CDuMxEjcS4lfdv5/11xTIZ0NmbM/psRME3BOxh0AQf
Subject: Re: [cocci] [PATCH kdevops] scripts/coccinelle/generation: add
 example generation script
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2686
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-04/de6a4d5f-edad-4c1a-a8a3-801239892e6d%40web.de>

>> =E2=80=A6
>>> +++ b/scripts/coccinelle/generation/check_for_atomic_calls.py
>>> @@ -0,0 +1,443 @@
>> =E2=80=A6
>>> +header =3D f"""// SPDX-License-Identifier: GPL-2.0
>> =E2=80=A6
>>> +/// Detect atomic context in ANY transitive caller (up to {max_depth}=
 levels)
>> =E2=80=A6
>>> +virtual after_start
>>> +virtual report
>>
>> Can any code refinements trigger desirable effects?
>
> How should I know?

I imagine that further experiences can be shared by developers
and code reviewers.


>                     If you want these changes to be made, do some
> performance tests and show that this is beneficial in some way.

>> +virtual after_start, report

Can the reduction of repeated key words be occasionally desirable
(also because of an influence on code size)?


>> =E2=80=A6
>>> +@irq_handler_def@
>>> +identifier fn;
>>> +@@
>>> +(
>>> +DEFINE_IRQ_HANDLER(fn, ...)
>>> +|
>>> +DECLARE_TASKLET(fn, ...)
>>> +)
>>
>> +(DEFINE_IRQ_HANDLER
>> +|DECLARE_TASKLET
>> +)(fn, ...)
>
> Intuitively this is of no benefit, because Coccinelle will generate the
> first case internally.

Is the proposed SmPL code variant a bit more succinct?


>> =E2=80=A6
>>> +@irq_func_names@
>>> +identifier fn =3D~ "(_irq|_intr|_isr|_napi|_poll|_tasklet|_softirq|_b=
h)$";
>>> +@@
>>
>> +identifier fn =3D~ "_(?:i(?:rq|(?:nt|s)r)|napi|poll|tasklet|softirq|bh=
)$";
>
> I would imagine that a regular expression compiler would generate the sa=
me
> code in both cases.

I suggest to improve the expression precision at some places.

Regards,
Markus
