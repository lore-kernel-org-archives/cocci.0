Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F3C5D29C39
	for <cocci@archiver.kernel.org>; Mon, 19 Jan 2026 15:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=oubwn71L38zpozbPk6JIRJ8vDZ9+Rzjj7UWwx/3Rd6w=;
  b=D7MROAyW4pPWaI8SUbfPWVGQLb7XoIXVgyjQCToZLkvcd3j5xnMXLEr2
   1/AT7vk4+3hWPQ3ZtYXX54vJ4vod183RH+3Tc7wUi+RjlrRMFYUTetDaI
   Qos/7ikvLnKGgX5kGDjGITXrvLD8dpXw3JOb0TBQRiX3qN4zm+MG1gfic
   A=;
X-CSE-ConnectionGUID: GMcGFtwcTqi8qCW5A5jocA==
X-CSE-MsgGUID: uAwuf2uYT2mjIj85/Wi0Ug==
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
X-IronPort-AV: E=Sophos;i="6.21,238,1763420400"; 
   d="scan'208";a="259304680"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Jan 2026 16:39:05 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 9DF1E83847; Mon, 19 Jan 2026 16:39:04 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id AA3F7837CA
	for <cocci@sympa.inria.fr>; Mon, 19 Jan 2026 16:39:00 +0100 (CET)
X-CSE-ConnectionGUID: ndwIAGRHSYKV9pe99vfKzg==
X-CSE-MsgGUID: q8nL2+9LQzubDWWFQ4AYTA==
IronPort-SDR: 696e5014_6PzNXqseaJXD/BRJRMW923niTj1/GNTbRH9cdf9pDbSfrqb
 DaOwH552P+fuEeZKlpJ+xbTtk0YICQWWHr8T5eQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HwAQB8T25pg07ASNlaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8EAQELAYJAaB9fMwQLSQSEVI9TgiEDaYNSjxGIeYNSAg8BAwENRAoBAgQBA?=
 =?us-ascii?q?QMEOIFUgnQCjHkCHgcBBDMGDgECBAEBAQEDAgMBAQEBAQEBAQENAQEFAQEBA?=
 =?us-ascii?q?gEBAgQGAQIQAQEBOgcOO4ZPDYJiAYEkgSYBAQEBAQEBAQEBAQEdAg06RAEBA?=
 =?us-ascii?q?QIBIwQZAQERJwQLCxoCJgICVgYBEgIBAYJ+AYIiAQYQAQMPJwcNsWJ/M4EBg?=
 =?us-ascii?q?gwBAQbaYx8sIlmBZwMGFAGBCi4BhW2CZQGGKoQ9Jw+BVUSBPIJSMT6CSoF5g?=
 =?us-ascii?q?1uCaYImgQ6NA4cLUngcA1ksAVUTFwsHBYEjQwMqLy0jDzwFLR2BIyEdFxMfW?=
 =?us-ascii?q?BsHBRMjbCEGHBICAwECAjpTDIF2AgIEghB7ggEPhw6BAAUubxoOIgJBUgIBC?=
 =?us-ascii?q?209NwkLGwQ9kARHgTJ9PH0ggigvkkazPTQHgjiBZ4FkDIoulT8GEy+XUg4Gk?=
 =?us-ascii?q?V+BJh6YaCKLbYF6lXOFRYF+JIFcMxokgzYSDTADGQ+OIRklg3WEYMJGQjUCO?=
 =?us-ascii?q?gIHAQoBAQMJhUYBAYxWgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 AzwgKAe5ekRkNiKndgQIDguY+tHOtEzBw==
IronPort-HdrOrdr: A9a23:QfSWqqlkoYS004QmpNgD2ykdlfTpDfLy3DAbv31ZSRFFG/Fw5P
 re+cjzsiWE8Qr5OUtQ/+xoXZPqfZqyz/FICOUqTNOftUzdyQyVxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIOauEYZmIbsS+V2njaL/8d4J2g7L2ig/vYwkxgVAdwdshbnn1E40qgc3GfX2N9dOIE/X
 enl7F6T7HMQx4qUvg=
X-Talos-CUID: 9a23:VPqDHmEutiBjs5A9qmJh+FE1M+8fUkbs70mBO0LpWHhna6+aHAo=
X-Talos-MUID: 9a23:uNVIGwmdcLk1i366a0uxdnp7ZMFMuef/LHkfjJ8qhPaqDHBZCgu02WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,238,1763420400"; 
   d="scan'208";a="259304652"
X-MGA-submission: =?us-ascii?q?MDE0iqKtlggy/5QQ8tx0uk15ykzl3Q2LknLkxZ?=
 =?us-ascii?q?HNUknJlUF0ftULesK4uxmv7lFZaR+C5zInby2Jx+fv/Z070BtyEx4/6K?=
 =?us-ascii?q?ICM3Yu/JQEnQaXzcu79W2WXLRGjr3XPICDmCj2TmwuFojMflIBo2DnS1?=
 =?us-ascii?q?9Riv6qaOMDx9Usp3R3ombkHw=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 16:39:00 +0100
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.178]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N1u6d-1voqcM3Hqb-00wvwJ; Mon, 19
 Jan 2026 16:38:59 +0100
Message-ID: <15bca19e-5a87-4efd-8da7-c6ea2cad27f1@web.de>
Date: Mon, 19 Jan 2026 16:38:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <e12b2a95-f1e6-4f8b-ab62-151c9789e798@web.de>
 <3857229-a98-854f-225f-5a63ca19cb7d@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <3857229-a98-854f-225f-5a63ca19cb7d@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tZpRjOmygi1HKAXwO89LQTcd1GacqKz8VydmPAVL4aEn6KREWHU
 xf1jUoDjzUeGnVOcllxLcr8j34X6x650jACqxtdbtQGPMbGzLQFLG3ZzOnCA8lktVHbrfQs
 Az3IujQuEoyowyxNoBfIZ3m53leIswwKamitsr6sAiCrISmbHmZjw2jDZe00gdrRzvrlV78
 zTCQ6Fodvp8xupHaYABeQ==
UI-OutboundReport: notjunk:1;M01:P0:VCZLExrxsaA=;JceY1pnWf4sJ9msEwAWYtmOiHfJ
 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
Subject: Re: [cocci] Checking data structure member accesses after function
 return value assignments?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3272
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-01/5u8ve6lv20gdpoLuqU5qRA>

=E2=80=A6
>> May I expect that the same data processing result can be achieved toget=
her with
>> the application of an SmPL nest construct?
=E2=80=A6
> Since you haven't told me what happens when you run this, I don't know
> what the issue is.

I assume that you can try to reproduce a questionable test result also wit=
h
your current development software version.


> But it may work better with () around the <+... ...+>, to avoid a parsin=
g conflict.

Why are you looking for extra parentheses there?

Another SmPL script example:
// See also:
// [PATCH] regulator: fp9931: Add missing memory allocation check
// https://lore.kernel.org/lkml/tencent_5FCF2108621C51007E5526A7C60A5CC1F3=
06@qq.com/
// https://lkml.org/lkml/2026/1/18/129
@display@
expression action, pointer;
identifier member;
@@
*pointer =3D action(...);
*<+... (pointer)->member ...+>
 ;


Questionable test result:
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> time /usr/bin=
/spatch --no-loops /home/altes_Heim2/elfring/Projekte/Coccinelle/janitor/s=
how_questionable_statement_combination3.cocci drivers/regulator/fp9931.c
[no diff output]

real    0m0,108s
user    0m0,086s
sys     0m0,015s


Regards,
Markus
