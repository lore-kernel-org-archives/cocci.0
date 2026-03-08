Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E81DF5513F
	for <cocci@archiver.kernel.org>; Sun,  8 Mar 2026 13:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=ySGQFNnXCxVpV1jLDB362rcjOZpVkemptsFCgzGKg8E=;
  b=khdaIgFyfVIuXHaRrLqZn+IpYk8rRT6JdUQmp2S5ISxYmPyA6Jc9xtbT
   gLb8Eg3sEcgUzbNY6h0MiSwTgbZVs0n7EZ0beGmkhcAKgHXUjwXzWe7Wg
   YzGtaFvLyWx6HUs5WaHQWVNnWLzBcaW6uB+9ItzeA9D6L6TBrNPj7vtf3
   E=;
X-CSE-ConnectionGUID: hupWFGs4ST+oxpXEsiPXTw==
X-CSE-MsgGUID: ynXuslFvTIKjWJxRM5qaig==
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
X-IronPort-AV: E=Sophos;i="6.23,108,1770591600"; 
   d="scan'208";a="266736771"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Mar 2026 14:00:44 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id E13DA80D28; Sun,  8 Mar 2026 14:00:43 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 2261B80D28
	for <cocci@sympa.inria.fr>; Sun,  8 Mar 2026 14:00:35 +0100 (CET)
X-CSE-ConnectionGUID: QiYiCgfkSg6ah5/OVXCH3g==
X-CSE-MsgGUID: F32n7+tZQ9iJGanjB5eajw==
IronPort-SDR: 69ad72f3_hALI8fH0HQ00PP8rwT16SwpQe/LPWapeSML2c5FHJe6cl1G
 l1DcpyFCIrnvORD/GAlyPifBsrwJvSndPsDV6Cw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FrQABqcq1pgAMP49RagQmBUoI/aB9eNAQLSQiEUI9Tg?=
 =?us-ascii?q?iRpg1KPEYpPgXwCDwEDAQ0UAQEuCgECBAEBAwSFAAKNIQIeBwEENwMNAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABATsHDgoxhk8NgluBL?=
 =?us-ascii?q?IEmAQEBAQEBAQEBAQEBHQINOkQBAQECASMdAQERJwQLCxoCGA4CAlYbAQGCf?=
 =?us-ascii?q?gGCIgEGEAEDDycHDQarC4EyE26CDAEBBoJp13sfLCJZgWcDBoEfL4VugmUBi?=
 =?us-ascii?q?m4nD4FVRIE8glIxPoJhBAGBXU2DDoJpgiaBDoxdhk5SeBwDWSwBVRMXCwcFg?=
 =?us-ascii?q?SNDA4EGIw88BS0dgSMhHRcUH1gbBwUSISqBaXiCAQ+GaHkDLl4aDiICOlxKP?=
 =?us-ascii?q?goBWgWCJQIBC209NwkLGwQ9jnI+gUFsgRULHwKVYbMZNAeCOIFngWQMii6VP?=
 =?us-ascii?q?wYTL5dSDpMLmQaOCZs4ghIBD4FcMxokT4JnTwMZD44tFoNeM8khRTICOgIHA?=
 =?us-ascii?q?QoBAQMJhUYBAYxWgUsBAQ?=
IronPort-PHdr: A9a23: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
 J7DmfCrQAo=
IronPort-Data: A9a23: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
 OnxUVYf
IronPort-HdrOrdr: A9a23:1aZfPaMu8GG9T8BcTh+jsMiBIKoaSvp037BZ7TEUdfUzSL3gqy
 nOpoV86faQsl0ssR4b9uxoVJPwIk80sKQFhrX5Xo3NYOCFggeVxehZhOOO/9SjIVyaygc378
 ddmsZFeb/NJGRbyeDn/QK/D9Es+9Wf9ru07N2utUuFATsKV0l6hT0Jcjpz/3cGPzWvjvcCfq
 ah2g==
X-Talos-CUID: =?us-ascii?q?9a23=3Av4PnSmoup6EJuwFp8NRoSOrmUfkkQ3z2w3nTGED?=
 =?us-ascii?q?mAGY0D5qreXSwo6wxxg=3D=3D?=
X-Talos-MUID: 9a23:0cUh3Agi68rRNBAtAykLGMMpGpwy5fvtFHI0wJQklMCCNwYtNj6fk2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,108,1770591600"; 
   d="scan'208";a="266736762"
X-MGA-submission: =?us-ascii?q?MDGhw4c6Mmifen1f1iI7RTyXIDEbavixIocDV1?=
 =?us-ascii?q?d8MMTuyMD7G4BgHw9PM3ZPHqdmR9wWAwQYuQ4ATJkO1BVDcMJpTmc/Uh?=
 =?us-ascii?q?jHY5ET+ctOfGXk5OzaGFvQiwOowkMKbVSgqr9aCOGvdYHdGXOlUo9fVS?=
 =?us-ascii?q?FCrcnh3E2rdFGrzp0uHAlJ1A=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2026 14:00:35 +0100
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N0qv3-1vkhd903Nt-0114a8 for
 <cocci@inria.fr>; Sun, 08 Mar 2026 14:00:34 +0100
Message-ID: <20a815aa-5fa9-4b34-ab81-d6985ed193c0@web.de>
Date: Sun, 8 Mar 2026 14:00:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: cocci@inria.fr
References: <349a12a9-f70d-4c8f-a730-9f8ec90b593f@web.de>
 <f25025ab-4500-4315-b41c-53cd5775c69f@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <f25025ab-4500-4315-b41c-53cd5775c69f@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yTQgvd9JurOaqfif9sTb3yndDfeSCvCFlBkenVKoXnn0ZlQKlZ8
 Y46pO8CR97pgTXTMibZoV0GwX4GjzbNd51AKH2EDYYaZpOTmV7NgNPT8iHtLPIs8Ll51fx1
 uzSo0pAzTnc54S6cR6PDFSYTZ2KuFb9XQi+ehjOlyaHLLZRYonf9crB8lQ9a3GNLqyvCNhg
 44uY9dpFk+3KYMY+8iF3w==
UI-OutboundReport: notjunk:1;M01:P0:kVktyXd6FAc=;sqRKHDMKU54Q5Udj7uGrGuwJogu
 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
Subject: Re: [cocci] Reconsidering source code search challenges for nested
 compound statements
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3328
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/MYavL3ul8Pj7Acp-wd6mQQ>

> I constructed another source file example together with a corresponding =
SmPL script.

@display@
statement list sl;
@@
*{ sl }


Compound statements are often used in known programming languages.
https://en.cppreference.com/w/c/language/statements.html#Compound_statemen=
ts

Another test result:
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> /usr/bin/spatch =
test-item_assignments.c ../janitor/show_compound_statements.cocci
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


The source code search pattern looks promising (in principle).
But it can be ambiguous in its minimal form.
Thus further case distinctions would occasionally be helpful.

Additional context information can become relevant then.
How would you prefer to handle control flow recursion in safer ways here?

Regards,
Markus
