Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9428D105F7A6
	for <cocci@archiver.kernel.org>; Fri, 13 Mar 2026 14:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=tt40o9/tZtCEVpuNieF742619QvOSFrRFIR65B98goI=;
  b=QNsMAS4KIfAn0ekOLH/vpn9ERywuieQ1KTL3CSAUaJFihcxKfDbQbR7p
   vSv+AIvuQA/CsbdCyWdxVvbOwEz6LN7W2cKo050qlHXnE6EI3eScgh1UH
   yIEPtbDqVwxXBQbREBoQ3fFEmwU6/Ts3D8Dxsqor3mXa1SIoz8SrQfXoR
   Y=;
X-CSE-ConnectionGUID: 3ViUOkLuQjCUAP6nKO832w==
X-CSE-MsgGUID: doFm41XdR86CnenF2fWGmw==
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
X-IronPort-AV: E=Sophos;i="6.23,118,1770591600"; 
   d="scan'208";a="267696086"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Mar 2026 15:25:43 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 1824181DE9; Fri, 13 Mar 2026 15:25:43 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id EC20C81DE5
	for <cocci@sympa.inria.fr>; Fri, 13 Mar 2026 15:25:39 +0100 (CET)
X-CSE-ConnectionGUID: 8nuOivokR/efacTBj3McFQ==
X-CSE-MsgGUID: mfeLFggWTf6TTCQZ2c+5jw==
IronPort-SDR: 69b41e64_trgJTGNVlhB0e/v0EQakAYCd8nu1RaOdEdjpGJL+ZX6rG/d
 l1uVShbMcsnWRy6M8tg89Uuyg8+WAvfL2lXGk4w==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HWBQB0HbRpgA4P49RaDnuBUIJBaB9eNAQLSQiEUI9Tg?=
 =?us-ascii?q?iEDhDuPEYpOgX0CDwEDAQ1KBAECBAEBAwMBggyCLkYCjSMCHgcBBDIHDgECB?=
 =?us-ascii?q?AEBAQEDAgMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAQE7Bw4KMYZPDYJiA?=
 =?us-ascii?q?YEkgSYBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QINOkQBAQECASMdAQERJgEECwsaAhgOAgJWBhUBAYJ+AYIiAQYQAQMPJwcNB?=
 =?us-ascii?q?rE1gTKBAYIMAQEGgVhB2EsfLCJZgWcDBoEfLoVvgmUBim4nD4FVRIE8C4JHM?=
 =?us-ascii?q?T6CYQEBAoFeg1uCRyKCJoEOhzsGi2hSeBwDWSwBVRMXCwcFgSNDA4EGIw88B?=
 =?us-ascii?q?S0dgSMhHRcUH1gbBwUSISqBRHiCAQ+GankDLl4aDiICOVyBBgoBUgWCLQIiA?=
 =?us-ascii?q?gELbT03CQsbBD2Obz2DFS0BKyKCG5MUELMZNAeCOIFngWQMii6VPwYTL5dSD?=
 =?us-ascii?q?pMLmQaOCZs4gW8NJoFcMxokgzZPAxkPjl+DQjOBC412uW1FMgIJMQIHAQoBA?=
 =?us-ascii?q?QMJhUYBAYxWgUsBAQ?=
IronPort-PHdr: A9a23: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
 PLmr5dEWVZzGv5IUiyN8/QdLZ0xUj52yNam
IronPort-Data: A9a23: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
 N0AUYf6NRjAYA==
IronPort-HdrOrdr: A9a23:NCg9VqmdQL/aQXF/dod4Von37uvpDfL43DAbv31ZSRFFG/FwWf
 re+MjzpiWE7Qr5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQyVxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK7/oSizPZLz9P+qjlzImVpaP502pnSx1sZppt9gFjF2+gYzBLrUV9ZKbQD/
 Cnl7F6TtebCA4qhk/XPBM4Y9Q=
X-Talos-CUID: 9a23:bV61HG6PzfuB0wQLp9sspEgJPcE7dX7ni3reKkSEI2Qybba7cArF
X-Talos-MUID: =?us-ascii?q?9a23=3AUScz9A3Go2WAVD627ivY5PS97zUj5qqjLG4Cnqo?=
 =?us-ascii?q?6tZe4CQdJCW2Wz2m1Xdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,118,1770591600"; 
   d="scan'208";a="267696056"
X-MGA-submission: =?us-ascii?q?MDGxOMY+CgLTDoaI98ZK3r3XjFoc5Kr5l4cIrb?=
 =?us-ascii?q?B88PiXqVWFu3MAv36kQmIjRyJPRlfdcpFB3QHrMkiHcvZKuziXz0Hi70?=
 =?us-ascii?q?YLDwr7f/A/s8jNiyNhs+K5Z/ivpg87ii0n58yZIEDK8X3A6LA5dLQKWa?=
 =?us-ascii?q?5mNPtMw3etEyZvDExbsI1mgw=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 15:25:39 +0100
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MyvB8-1vfnFY133K-015d7P; Fri, 13
 Mar 2026 15:25:38 +0100
Message-ID: <c25119df-1825-4fd8-bb69-84549affe866@web.de>
Date: Fri, 13 Mar 2026 15:25:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Alice Lee <Alice.Lee@ist.ac.at>
References: <274abdf3dbbe4c3e8f1f33fba516c8b3@ist.ac.at>
Content-Language: en-GB, de-DE
Cc: cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <274abdf3dbbe4c3e8f1f33fba516c8b3@ist.ac.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:U0B/+7ZiMlV/p+BDmHkhXSvtNuHYJrXjIE7Q35t/fmIYAV1ehdU
 x1WiuoCNkSUd1OsN7r7FKFIsJ6+n144mVTBpeM8MFQQqMKXKYj9M8d690EXxJ9FSvjiBdid
 Sad0W+dEkJj/q0TTUAXXGfFnooOSj05uTVDNc9ulqqrXCQYVm4s7XL5kW0Domvy+eFe7Xsu
 s4SDykX7e59CeGBY5wuow==
UI-OutboundReport: notjunk:1;M01:P0:pRHjMk2UQEI=;iwK699RM1Q6yZdJoRjQGHILjzDR
 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
 nsqTVwciVf7Jn5UMtA/9KEYSrfyIwWBEw==
Subject: Re: [cocci] Can Coccinelle parse files where macros are used as
 binary operations?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3429
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/LVss8FUCq21PDKB0bASKCw>

> I am trying to use Coccinelle to search C codebases (=E2=80=A6)

Nice =E2=80=A6


> and I am struggling to understand the scope of the --macro-file argument=
.

https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/233b5ceb1d5a701fb270e=
bdf0a9bd6be0a6ce53b/docs/manual/spatch_options.tex#L409-412


> Can macros used with #if in the source code be defined in a file passed =
with --macro-file, and then the right sections of source code are ignored?

I suggest to reconsider corresponding expectations in more detail.

1. Some developers would like to expect that the Coccinelle software



> # Can macros used with #if=C2=A0in the source code be defined in a file =
passed with --macro-file, and then the right sections of source code are i=
gnored?

1. Some developers would like to expect that the Coccinelle software
   can handle source files also without extra preprocessing.

   But it was discovered that implementation details are still waiting on
   corresponding clarifications.

   Exclude macro calls from searches for function implementations
   2024-10-28
   https://github.com/coccinelle/coccinelle/issues/381

2. Software components can be improved accordingly.

   Improve support for the handling of #if conditions
   2022-10-29
   https://github.com/coccinelle/coccinelle/issues/293


Regards,
Markus
