Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E59C64ED8
	for <cocci@archiver.kernel.org>; Mon, 27 Feb 2023 15:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=iGj9g1zQ78obBdhv+XduuwrZ+OdekU5IWhy6yIO4qXs=;
  b=TwruIq08ql0R+amXmX+DfBoPLWeUzzPoh1acHfy9INMj3xUlhuIWEGvI
   FxV+PMzwV1Ye1VD8uaIitAR/6sX+BSDQ5jRvLLPLMwOIairT3AR6NFi8o
   iTUZ6vwO14Ro0UcbHC/nuDmiZS1GKei0IX/Zm5LcuMn+S4mUa4j1ZU9Zu
   g=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="5.98,219,1673910000"; 
   d="scan'208";a="94561887"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Feb 2023 16:55:22 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id ABC62E0152; Mon, 27 Feb 2023 16:55:22 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id DE947E00A1
	for <cocci@sympa.inria.fr>; Mon, 27 Feb 2023 16:55:19 +0100 (CET)
IronPort-SDR: 63fcd266_t15lgftgtfO2Agh/4Eb690g/sviS2XlkPLE+u6bHqvGYFPB
 oBh+jYudWYB8QgG/0z11eYEbCgVAjthXxVjGqmw==
X-IPAS-Result: =?us-ascii?q?A0GWBwCj0fxjhwQP49RSCB0BAQEBCQESAQUFAUCBT4Itg?=
 =?us-ascii?q?V8uBAtGhFOOe4F3LoQwhyiQHIFqgSw+DwEDAQ1BAQIEAQEDBIR+AoUwAh0HA?=
 =?us-ascii?q?QQ0EwECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEAQECEAEBARoJFwcOB?=
 =?us-ascii?q?QsFIoVoDYI3KQERZIEIAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQESAkdTPQMDI?=
 =?us-ascii?q?x0BAREmAQ8JAhoCJgICVwYBDAgBAYJ6gm4BAzEHk2WcF4EygQGCCAEBBpwJH?=
 =?us-ascii?q?ywiU4FeCYEULIxAPQmCRIFjJw+BVUSBFSeBFYFuPoQHFieDWIJnigCBX4pHC?=
 =?us-ascii?q?oE0d4EjDoFCgQkCCQIRb4EUCGiCAkcCD14lBA4DGSsdQAIBCzs6PzUGAwsgB?=
 =?us-ascii?q?icBM2sCCSUREwUDCxUqRwQINgUGHDQRAggPEg8GJkMOQjc0EwZcASkLDhEDT?=
 =?us-ascii?q?4FIBC9egQEGASgkmXkVeIIGlmwBi02hPTQHgiiBVIFVDJ8BBhMulwMOBpIhl?=
 =?us-ascii?q?1kgom+FCIF5I4FcMxokgzZPAxkPjiAZhAyPR0A0OwIHAQoBAQMJhUYBAYYGA?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23: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
 klQqVsdBZsePMv31h46ArGVtJvHEQzcUIIUyhA=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:/XK8ba2XnF5P8sXeDcufaAqjBGYkLtp133Aq2lEZdPWaSL3+qy
 ncpoV/6faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SODUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyTMbEQt6bHCWeDYrUd6eWmtIa1mOzZ03Bhdg1ybbp8hj0JdzpzXncWeOFcb6BJb6
 Z0C/A33QZJ8hksBPiGOg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,219,1673910000"; 
   d="scan'208";a="48745276"
X-MGA-submission: =?us-ascii?q?MDFNYdUA7ItWsoSezyff2QstA61ZN6QA0gDdyQ?=
 =?us-ascii?q?vOiFJdhmWt6U+BS0DfqVJiE3tQo40/W+dv2WDGkwl3MCtGAvV/2+fhOV?=
 =?us-ascii?q?k0WDg8nq7Ey941ZiusgyKUZCp78tnFc/kzyRlzM47Uo7e4zueh7POikD?=
 =?us-ascii?q?pdeSMk/9YmLeOIvtsp+EkW4Q=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 16:55:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1677513310; i=markus.elfring@web.de;
	bh=Lg0wDyn8d+RcV+DwwNMGNIOP5LJQCKLpwRuUV5j6dAE=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:Cc:In-Reply-To;
	b=IFdeH996jCr4pPhFDG2uumFC+QEYoGc5f9ASaJ1h8rSiOf02hL3bfJRc2X0Fp4pcD
	 13y+8/MoTdOKqowOZWJDxBFIBzjrtw8Df2LbG6otkbPzojFSQarTKeG6lgEIWZL7l2
	 QMEQv4bA3GgaF+pbc5Jx1T07RCuNcj+c+4866RN0fstbmxlw6Uu0ap/RpPfBIJG44g
	 eo6/2WH2JK0ZBW2WczB0+QkeumbN3YdWyL76yW5hOhQYqtJfLqERjjXcxon16Q1B3o
	 dMQPL3m3PXtDqVWhl9Po/SkGO7PDZII4e1WoUeaPAZvKuNE3Rt6U0VH6kOe0CSqHfP
	 394d6+sRfmuBQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MnFy4-1onTje0Axo-00jKkV; Mon, 27
 Feb 2023 16:55:10 +0100
Message-ID: <cc06244c-5e6b-5ae8-056c-7755973a1027@web.de>
Date: Mon, 27 Feb 2023 16:54:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
To: Schspa Shi <schspa@gmail.com>, Julia Lawall <Julia.Lawall@inria.fr>,
 Peter Zijlstra <peterz@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>,
 cocci@inria.fr
References: <20230227075346.69658-1-schspa@gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Ben Segall <bsegall@google.com>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ingo Molnar <mingo@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, Mel Gorman <mgorman@suse.de>,
 Nicolas Palix <nicolas.palix@imag.fr>, Steven Rostedt <rostedt@goodmis.org>,
 Valentin Schneider <vschneid@redhat.com>
In-Reply-To: <20230227075346.69658-1-schspa@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:v/jz8ufn5yTzpEuZxHuGsutm47Yo/4GPragCVwKofUC/7LxJ2bb
 RvldxQPIW21x6RBCcDSTB/8emoRrzdSxqKj4FuNCl6ntNuSv0ojprao14quXkDCRYCWdC8N
 MN81Vn7+REbY6dtly2vIWN3sKdwd8UlcaNq7LCU8ThhMm0JHHfvS7XtHM///0/BkZhmyxmU
 yJb9PA3rEJtjEY7MQy3rA==
UI-OutboundReport: notjunk:1;M01:P0:TFrbNo+Zb6o=;8C5PU5MQHlfVPh9xnvdjbs9VkkL
 HCSa/PRfRSIXd1Kw6OnwdFOR/NNX8z8phOFkpfDUF2P3IkM40qZHu9cehTBGDD+B5JeEpelEG
 /4++7W7rfaYUIULBRV/FEnwMgJCEBCY9cOSbqwAhi6UzcPmpsTTtFgwaWZgOFwwTyODdtMTk8
 L/nDlBVnqB3qUj3mYobWGcZWvtKOolR0+ZQm2SGsI6hUswOPEQzgrr9t0+m9nJi2kEmaJOAG0
 CcdwjnpbGud71PMyy2YyeDh46f+wvJoU9GiCJT9ODqqEkAOgynCj8Odh9vn3FhIaI2wbHbknn
 oLBd59Rsu8li139YZTaGwaTU8UU8mutzmKwp0NKFOHViVLbpA50DBP2TlsR+gaIzKgJbQyYnG
 QBggS9EB0qkyJJVN+eZsWGV3YqtdrOjbI8Ae1NMdjwI1RrpLTl/dgQGBeX0e/9Dm0kWAm5AqQ
 krAltcQA7c2RNHGgMFilltvJkLJDSG3ygAfgsyPqVaIAB+BpCnS93tC0EGZ+aNF3/LN5XMXOj
 GekRuKm6+fWTkq6zbUHbLezQkSwupi0rBIeuHXm4667EFGJb5wwNrmTg7hEQz1yOiG2+L1yrS
 EDNV3HxQOHdOuhq9GMTP1U59t2Tp+79MB3xplSq/YnrZg+NLJwaTVjGWZmm+7x0cKo+EaMdWC
 sJ6dlTXIAv6AX9ZkIDKoEvZVShCQd6GF1BoIwDWMhtMCz7vjJvq6dEn2qxVzg2MBV2/UFHiw0
 luKzDCIsI8KQCjyUy9mSPPNQ1J03kTNf4PXfcEQ1DInb1T2yFAmUtfhain1BlFHj+v7MLDPmn
 +/lB+4amAaYv1U5Tb6Vp1wd75vYQW2pVqiAly8K4S6wgYEhBFD/OtXd2YNOi5MxkfgrLoY+pO
 tm2VCw/VGwLeapD63Q90S2252zmqS7Dm/LWffwBo4AOmxOcVX1Y8Eq7RzR3yZBMwiX4RV+uSz
 kddNrw==
Subject: Re: [cocci] [RFC PATCH] coccinelle: Add SmPL script for completion
 API check
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 869
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-02/cc06244c-5e6b-5ae8-056c-7755973a1027%40web.de>

=E2=80=A6
> This patch provide a SmPL script to detect bad
> DECLARE_COMPLETION_ONSTACK(_MAP) API usage, but far from perfect.
=E2=80=A6
> +++ b/scripts/coccinelle/api/complete.cocci
> @@ -0,0 +1,160 @@
> +// SPDX-License-Identifier: GPL-2.0
> +///
> +//  Copyright: (C) 2023 Schspa Shi.
> +//  Confidence: High


Would it be helpful to add the field =E2=80=9CKeywords=E2=80=9D?


> +@r1 exists@
> +declarer name DECLARE_COMPLETION_ONSTACK;
> +declarer name DECLARE_COMPLETION_ONSTACK_MAP;
> +position p;
> +identifier done;
> +identifier func;
> +@@
> +
> +func(...) {
> +...
> +(
> +DECLARE_COMPLETION_ONSTACK(done@p);
> +|
> +DECLARE_COMPLETION_ONSTACK_MAP(done@p, ...);
> +)
> +...
> +}
> +
> +@locked exists@
> +identifier func=3Dr1.func;
> +identifier done=3Dr1.done;
> +position p1,p;
> +@@
> +
> +func(...) {
> +...
> +(
> +mutex_lock@p1
> +|
> +mutex_trylock@p1
> +)
> + (...)
> +...  when !=3D mutex_unlock(...)
> +done@p
> +...
> +}
> +
> +
> +@elocked exists@
> +identifier func=3Dr1.func;
> +identifier done=3Dr1.done;
> +position p1,p;
> +expression e;
> +@@
> +
> +func(...) {
> +...
> +e =3D &done;
> +...
> +(
> +mutex_lock@p1
> +|
> +mutex_trylock@p1
> +)
> + (...)
> +...  when !=3D mutex_unlock(...)
> +e@p
> +...
> +}
> +
> +
> +@has_wait_for_completion exists@
> +position p;
> +identifier done;
> +identifier func=3Dr1.func;
> +identifier fb =3D { wait_for_completion, wait_for_completion_io};
> +expression e;
> +@@
> +
> +func(...) {
> +...
> +(
> +...
> +fb(&done@p);
> +...
> +|
> +e =3D &done;
> +...
> +fb(e@p);
> +)
> +...
> +}

I would prefer the following SmPL code variant.

@r1 exists@
declarer name DECLARE_COMPLETION_ONSTACK, DECLARE_COMPLETION_ONSTACK_MAP;
identifier done, func;
position p;
@@
=C2=A0func(...)
=C2=A0{
=C2=A0...
(DECLARE_COMPLETION_ONSTACK(done@p)
|DECLARE_COMPLETION_ONSTACK_MAP(done@p, ...)
);
=C2=A0...
=C2=A0}

@locked exists@
identifier r1.func, r1.done;
position p1, p;
@@
=C2=A0func(...)
=C2=A0{
=C2=A0...
(mutex_lock@p1
|mutex_trylock@p1
)(...)
=C2=A0... when !=3D mutex_unlock(...)
=C2=A0done@p
=C2=A0...
=C2=A0}

@elocked exists@
expression e;
identifier r1.func, r1.done;
position p1, p;
@@
=C2=A0func(...)
=C2=A0{
=C2=A0...
=C2=A0e =3D &done;
=C2=A0...
(mutex_lock@p1
|mutex_trylock@p1
)(...)
=C2=A0... when !=3D mutex_unlock(...)
=C2=A0e@p
=C2=A0...
=C2=A0}

@has_wait_for_completion exists@
expression e;
identifier done, r1.func, fb =3D {wait_for_completion, wait_for_completion=
_io};
position p;
@@
=C2=A0func(...)
=C2=A0{
=C2=A0...
(
=C2=A0fb(&done@p);
=C2=A0...
|
=C2=A0e =3D &done;
=C2=A0...
=C2=A0fb(e@p);
)
=C2=A0...
=C2=A0}



> +@has_while_wait exists@
> +position p;
> +identifier done, ret;
> +identifier func=3Dr1.func;
> +identifier fb =3D~ "wait_for_completion.*";

* The metavariables can be grouped once more.

* I suggest to restrict the regular expression a bit more by using an anch=
or.
=C2=A0
identifier done, ret, r1.func, fb =3D~ "^wait_for_completion.*";



> +expression e;
> +@@
> +
> +func(...) {
> +...
> +while (...) {
> +	...
> +	ret =3D fb(&done@p, e);
> +	...
> +}
> +...
> +}
> +
> +@has_while_wait2 exists@
> +position p;
> +identifier done;
> +identifier func=3Dr1.func;
> +expression fb =3D~ "wait_for_completion.*";
> +@@
> +
> +func(...) {
> +...
> +while (fb(&done@p, ...) =3D=3D 0) {
> +	...
> +}
> +...
> +}
> +
> +
> +@r2 depends on (!has_wait_for_completion && !has_while_wait && !has_whi=
le_wait2) exists@

Would the dependency specification =E2=80=9C!(has_wait_for_completion || h=
as_while_wait || has_while_wait2)=E2=80=9D
be nicer?



> +func(...) {
> +...
> +(
> +wait_for_completion_interruptible(&done@p)
> +|
> +wait_for_completion_killable(&done@p)
> +|
> +wait_for_completion_timeout(&done@p, ...)
> +|
> +wait_for_completion_io_timeout(&done@p, ...)
> +|
> +wait_for_completion_interruptible_timeout(&done@p, ...)
> +|
> +wait_for_completion_killable_timeout(&done@p, ...)
> +|
> +try_wait_for_completion(&done@p)
> +|
> +wait_for_completion_timeout(e@p, ...)
> +)
> +...
> +}

Were the function names (in this SmPL disjunction) ordered according to th=
eir
call probability?


> +@script:python depends on report@
> +fp << r2.p;
> +@@
> +
> +print('file:{:s}::{:s} was suspected to return a variable on stack'.for=
mat(fp[0].file, fp[0].line))

Would the following statement variant be more appropriate?

coccilib.report.print_report(fp[0],
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 "WARNING: It seems that a reference was returned =
to a variable which was stored on a stack.")


Regards,
Markus
