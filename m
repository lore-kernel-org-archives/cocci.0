Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43EE4EA853A
	for <cocci@archiver.kernel.org>; Sun,  8 Mar 2026 17:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=FVisP4s3c5la6KM3o8Nl9plZJJA4FvIS/J/5SLvSHyo=;
  b=PdYdCDQvGthYqIWazmeFWXZnWrjxvlkCfJVUx1w/Lvgy5zlxTg1m7nVL
   AqkLWrAC/mNwYYKBgjw+dBDGKH2p7u1YJRPvs0dOjmpOTQrh/3fBc1w7j
   bVK/ZnGuQRTbR4svmHTsfuUfue+8DQ6Kt5j0n3VGx1AYuSkJ/2kXp2z/Z
   A=;
X-CSE-ConnectionGUID: 2rmVoj8rSFmttKQ1DhAAxg==
X-CSE-MsgGUID: qrEu28fISJSEWKKPgMTYyg==
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
X-IronPort-AV: E=Sophos;i="6.23,109,1770591600"; 
   d="scan'208";a="266753203"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Mar 2026 18:35:53 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id C127681649; Sun,  8 Mar 2026 18:35:52 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 001BC804B6
	for <cocci@sympa.inria.fr>; Sun,  8 Mar 2026 18:35:45 +0100 (CET)
X-CSE-ConnectionGUID: b8g5pP7pTle//j/mXmEOSg==
X-CSE-MsgGUID: 8AP/9pGyShSfAgzaquZpow==
IronPort-SDR: 69adb36b_OEjvp6036Eo8R45tfwG9H65C0O4FWtRKy5IxlyoWg5EczBg
 JMxZTu9U+UjObnqT8fzrT+B5qHglv8LFaX28Yvw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GBBgAgs61pgAQP49RagQmBUIJBaB9eNAQLSYRYj1OCI?=
 =?us-ascii?q?QNpg1KbXAIPAQMBDUoEAQIEAQEDAwGFAAKNIQIeBwEEMwYOAQIEAQEBAQMCA?=
 =?us-ascii?q?wEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABATsHDgoxhk8NgmIBgSSBJgEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAg06RAEBA?=
 =?us-ascii?q?QIBIx0BAREmAQQLCxoCGA4CAlYGEwIBAYJ+AYIiAQYQAQMPJwcNBqtdgTITb?=
 =?us-ascii?q?oIMAQEGgUYCDAICQAHYSx8sIlmBZwMGgR8uhW+CZQGJdHonD4FVRIE8C4JHM?=
 =?us-ascii?q?T6CShcBAgEBgV2DW4JpgiaBDot7YoZOUngcA1ksAVUTFwsHBYEjQwOBBiMPP?=
 =?us-ascii?q?AUtHYEjIR0XFB9YGwcFEiEqgWl4ggEPhmh5Ay5eGg4iAjpcSj4KAVoFgiUCA?=
 =?us-ascii?q?QttPTcJCxsEPY5yPoItBmIaEyoCgUUVxyA0B4I4gWeBZAyKLpU/BhMvl1IOk?=
 =?us-ascii?q?wuYIGaMD4F6mziBfiSBXDMaJE+CZ08DGQ+OLRYcg0IzgQuDVcQ1RTICCTECB?=
 =?us-ascii?q?wEKAQEDCYVGAQGMVoFLAQE?=
IronPort-PHdr: A9a23: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
 BI72FMWiQsF6zrmpVs6dAOimQ==
IronPort-Data: A9a23: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
 t3SRDNKNBgRlgiovfkxDBoPk+tf6iEz1g/FGwEU
IronPort-HdrOrdr: A9a23:tKEjKqgbDy2jaAE0j/sG4us5DXBQXg4ji2hC6mlwRA09TyVXrb
 HNoB1p726RtN93YgBZpTngAtj4fZq4z/VICOYqUotKMDOW31dAabsSi7cKoAePJ8SdzIJgPM
 5bGsASNDSzNykesS+Q2mmF+rgbsbq62ZyJwcHD0nxqUQZmUK146RxlYzzrb3GeCDMmOXIjfq
 DsnfavSgDQA0j+5amAbEU4Yw==
X-Talos-CUID: 9a23:9ZON42D/Vnl79Zf6EyM3+xMMIp89TnnQizDSZEqIDEtOc7LAHA==
X-Talos-MUID: 9a23:exdkMAZTUS1/u+BT5xbUw2B6G9ZT45+gIU8fmIwbidGDKnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,109,1770591600"; 
   d="scan'208";a="266753187"
X-MGA-submission: =?us-ascii?q?MDEAFrNS9voO/IFFFtzmv1U7VyczDoYC2jgopz?=
 =?us-ascii?q?pKIqa8OT6bobCpZ2S3cCscdzBxfsnBkk5rnhlY1pKKed1UaUJf/tl1Li?=
 =?us-ascii?q?OS5/uQQe41xzJN/gm3P3PjoTWT2VGgsOlzpE9eNEQHcHFUpngN3zD6Ex?=
 =?us-ascii?q?qqL9r11+m9p31QS9JE5/621A=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2026 18:35:38 +0100
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N3GgY-1vZKvL1cgc-00vrCw; Sun, 08
 Mar 2026 18:35:37 +0100
Message-ID: <cd1bbe8e-ef35-408f-8754-173678bf3204@web.de>
Date: Sun, 8 Mar 2026 18:35:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <349a12a9-f70d-4c8f-a730-9f8ec90b593f@web.de>
 <f25025ab-4500-4315-b41c-53cd5775c69f@web.de>
 <20a815aa-5fa9-4b34-ab81-d6985ed193c0@web.de>
 <bc3eaab-b09e-4e67-054-b522d723c6a@inria.fr>
 <576f0704-7ceb-4e0d-ae1d-1beb1eb1efc3@web.de>
 <92db939d-8643-3bd5-ab3b-29605d36d29a@inria.fr>
 <0a740db5-eaae-43c9-9b73-d9317a1a92c6@web.de>
 <be59dbcf-c9b-745d-e15c-e8fcefaf40e2@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <be59dbcf-c9b-745d-e15c-e8fcefaf40e2@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FP2gSBFrGyjyfn1z1Y6gdWo5TJN6IW8JdABqpcdAG+2lcVm1RNF
 0osZU8TJuTGAuVw/pDS8JdCjBHqKqO6ta4jQdvwIjoZBKbIjqBxhUiqOU3IUEXPIqTQEl6z
 lwu772MNJcy6wmcMrlLgglTisBVScc5WJtNXuuglzHV70qrnof5JgwIh2fN7PQgvaoj7o8w
 cTRKkktlKZSj/XKOCx//g==
UI-OutboundReport: notjunk:1;M01:P0:iy7w8BkzmXI=;luAhhup98cp6UzfxP7n15QcmUMj
 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
Subject: Re: [cocci] Reconsidering source code search challenges for nested
 compound statements
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3335
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/2cuWKxf7J_rhKGGK1B6Auw>

>> Can you see concrete change opportunities from my recent test results?
>>
>> 1. Inappropriate difference output
>>    https://lore.kernel.org/cocci/349a12a9-f70d-4c8f-a730-9f8ec90b593f@w=
eb.de/
>>    https://sympa.inria.fr/sympa/arc/cocci/2026-03/msg00004.html
> There is a problem here.

Thanks for such a feedback finally.


>> 2. Questionable hierarchy level
>>    https://lore.kernel.org/cocci/20a815aa-5fa9-4b34-ab81-d6985ed193c0@w=
eb.de/
>>    https://sympa.inria.fr/sympa/arc/cocci/2026-03/msg00015.html
> This is the message I was referring to.  I have no idea what you expect =
as
> the output.

I presented another test result for further development considerations.



>              I don't know why it is so hard to provide that information.

I imagine that corresponding case distinctions can become also more intere=
sting.

A) C++ test variant:
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> /usr/bin/spatch =
=2D-c++ test-item_assignments.c ../janitor/show_compound_statements.cocci
=E2=80=A6
@@ -3,9 +3,6 @@ void my_test(void)
  int item;
=20
  if (1)
- {
-    item =3D 1;
- }
=20
  item =3D 2;
 }


Should declarations belong also to statements then?
https://en.cppreference.com/w/cpp/language/statements.html#Declaration_sta=
tements
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/233b5ceb1d5a701fb270e=
bdf0a9bd6be0a6ce53b/docs/manual/cocci_syntax.tex#L348-350


B) SmPL script variant:

@display2@
declaration d;
statement list sl;
@@
 {
 d
 *sl
 }

Questionable test result:
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/janitor> /usr/bin/spatc=
h --parse-cocci show_compound_statements2.cocci
=E2=80=A6
minus: parse error:=20
  File "show_compound_statements2.cocci", line 7, column 2, charpos =3D 56
  around =3D 'sl',
  whole content =3D  *sl


How should this implementation detail be improved anyhow?

Regards,
Markus
