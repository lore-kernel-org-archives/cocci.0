Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2D14CC6B38
	for <cocci@archiver.kernel.org>; Fri, 16 Oct 2026 15:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=uM/uqb6jB5bPusJ8VZ1C6mfq3AmMpsh982OmnP2N20Q=;
  b=K2F1YQHSbiZxhWSBtotoR3xCaQjLIL6dhb/QeEDQ3q1DpR3DcP2CETxN
   upGLlabQr2UQgT0THB30bsMcyfchaYfz2AerZK0UD2XrNrVcSTJSVgHso
   1/kGspzn48Ra7K8yaJZKKxuhGkiPDpORBMt1HkjgKnPRSu6QiapKlsnfE
   8=;
X-CSE-ConnectionGUID: MMddhzrOS1atMYXzWrbmMQ==
X-CSE-MsgGUID: gnMZk56RRua0PJc0pT5BeA==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
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
X-IronPort-AV: E=Sophos;i="6.27,162,1787004000"; 
   d="scan'208";a="300607457"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Oct 2026 17:18:01 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 434498067C; Fri, 16 Oct 2026 17:18:01 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 1564A82586
	for <cocci@sympa.inria.fr>; Fri, 16 Oct 2026 15:57:23 +0200 (CEST)
X-CSE-ConnectionGUID: aIjTM3OHQ02ysERLKT+HYQ==
X-CSE-MsgGUID: tg5a1Nu7Q9SgQtyv90dLEA==
IronPort-SDR: 6ad22d42_8uS5qJsviMR7iLBnKdw3CWaCigIORthcRbFE2UJJddC+lQQ
 7X+LjzYIxQenUOvrA0Ah1KKV3X6rMFosc7+qpeQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HbAQD7K9JqfDLaVdFaHgEBCxIMggULgkGBbDMEVI1Sh?=
 =?us-ascii?q?liCIQOBE4o1MAKFUIp9gVUUgSs9Ag8BAwELAQFRBAEBAQIEOIRGAo4WAh4HA?=
 =?us-ascii?q?QQwCQ4BAgQDAgMBAQEBAQEBAQEBAQsBAQEEAQEBAgEBAgQDAQEBAQIQAQEiG?=
 =?us-ascii?q?QcOEimGTw2MGgGBJGECBQM7AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBBQIsXwEBAQMnEwYBGx0BAwwGBRguIAIRAQUBHAYThSUBBhABA?=
 =?us-ascii?q?zcDBLJ+i3CBARYFAhaBAYINBtprChkoDXWBaAIHCQEKAQGBN4R5Kl0DgjwEH?=
 =?us-ascii?q?AEFb4UFgxlpeieCKIEVgnM4PoIfgWeDf4MDBIIigQwbgkKURAEHBzEJCRMGC?=
 =?us-ascii?q?AICSAsKGQMEBAECCxMJAwMCDgIIAwIIBhkBPxIEEwIICQQLBwUfCgIMFgooI?=
 =?us-ascii?q?gQOKwoDVhAGGgEIBgICBAQCBAIKAgkCAgUDBAIEDQMEAQEIAgIDKgMBAxkIC?=
 =?us-ascii?q?QgCCwURGAwLBzEDEAkDAh0DFBEFCBE0CAYWARoGBQYLASAWFAEFDBEBAhsCH?=
 =?us-ascii?q?wQdARAIAwEUBAIBCQMEFgQCFAofAgMDBgMKCQIFAxsYBAECAgMCAQIIAwcIA?=
 =?us-ascii?q?wgFAwQCAwMDBAECAgEBAQIDAQMDBAQDAgEDBwICAwMDCwECAwMFAwMFBQICB?=
 =?us-ascii?q?QUDBQICCgIDAwMCAQMCGggDBgMSARADAwYBAwcDBwIEAwkCCAMDCAgDFwMDB?=
 =?us-ascii?q?QECAgQDAwgIBAMDBAICAwwFAwIDAwUDAwcCBAIEAwMBBQECBwIDBwIBGAMCB?=
 =?us-ascii?q?AgHBwUCCwQCCAQNCQQCBAICDwQGAwMHAQECAQcFBgMCAhABCAoFBgICAhwDH?=
 =?us-ascii?q?QECAQ0GAQkFAgEFDgcFAgIYAwYBAQMGBQEDAQoLAQECAQIKAQIEAgUDAwEDA?=
 =?us-ascii?q?gMCBgMDAgUFBQMJBwUOCQEDAwYFAgIDAgMBAggEBgUDAgIDBQEDAwQDCgMCC?=
 =?us-ascii?q?AMDCAMMAhoCBQMDAwYJAwcHAgMHAwIFAgcFAwMFAwYBAwIBAwMICxUiAwEFA?=
 =?us-ascii?q?wMCAQMCBQMDGAICBAUDAwMDAwgEAgIBBwYEAgICAQUFBQQFBgIEAwgBAQUDA?=
 =?us-ascii?q?woNAQIHDAMMBgMHAwMEBAMCBQoCBAEHAwMHBwkHAwIDBwEBCwQBAwMKAwMFA?=
 =?us-ascii?q?gEBBwUDBgMHAgMDAwUEBQMCCwMHAgIDAwMCJwEBAQMDAwMDBAMBAwEDAwcDB?=
 =?us-ascii?q?QMCDgIIAQoDAgYDBwYDBQMDAgECAwMFEQMGBAUGFwIGETIBCAIDAwEUBAQFA?=
 =?us-ascii?q?gUVAggBAwUDAwMDAgUDAQUBAQMDBQMDAwMDAwQBAwQCAwcGCAEBAQIIAwMCB?=
 =?us-ascii?q?QMDAwQDAwIBDQQCBQMGAgIEAgQBBwMBAgIDAwMDAQIEBAIHBAUCDAMEAgMDB?=
 =?us-ascii?q?QIDAgMLBgILBAIDAwMDAw0BAgsGAxQFCQQIBQMPBQEFBwcJAQMIBQMGAwsDF?=
 =?us-ascii?q?AMDBgMDAwoEAgUBBhAMDQQBAgQJAwICBAIPFQQEAwcBAQ0LAQEEEQMEAQQBA?=
 =?us-ascii?q?wQGEwUCAQMICQYHAQgCAgUCAgIDAwMCBQgCBQIEAgEEAgIHAgQJAwIDAgICD?=
 =?us-ascii?q?AkIEz0MBy4EBAwqARUUBSmBABCSEh6Bcz40PRYoEwETCCcLfkUYCRkpAoEEA?=
 =?us-ascii?q?QEBoi+iP0keCQEGAg1UgWeBChUKL5tghXxNhASTTw6TDi6XX3uCWY86kVYTh?=
 =?us-ascii?q?RsCCgcHESQSgTI6gVxwUIEegUlQAxkPjiKEAs45QjU9AgcCBw4DC5IcgUwBA?=
 =?us-ascii?q?Q?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 J8ve1aw3g==
IronPort-HdrOrdr: A9a23:9+IyFqDecan/jxTlHemI55DYdb4zR+YMi2TDGXoBLSC9Vvbo7f
 xG/c5rriMc7Qx6ZJhOo6HiBEDtewK/yXcx2/htAV7AZnifhILLFvAF0WKK+VSJcE3DH6xmpN
 5dmsBFaeEYZmIK6voSjjPIduoI8Z2o9OSHi47loEuFjjsHV0ij1WpE48+gfHFLeA==
X-Talos-CUID: 9a23:xPE5225hiXjuaVd7jdss/W8WJuV+VV3klC3BOGKCLUVVC52kcArF
X-Talos-MUID: 9a23:R4SoiQRli6ZroEF6RXTwi2xrbeF1vJ3/M080jYQY6pGIEQFZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,161,1787004000"; 
   d="scan'208";a="160048584"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDFqsAua4QCzWE2vVjuz7oEiGUsOmV5aCawNb+?=
 =?us-ascii?q?g6hcFiCr/TzgHfz1QIRjTxmxq9OQG0vH/YS+g7uWjME2hXbSMg+m8puK?=
 =?us-ascii?q?irXAWDKzh4Bnxe1aP9YauqNm09RmKqG1eBJZlc1kmtLAXx3YSylus4Bf?=
 =?us-ascii?q?EeeXALuLS3EtxSHWzVg/DVBA=3D=3D?=
Received: from mail-ej1-f50.google.com ([209.85.218.50])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 15:57:23 +0200
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c411e139259so44542066b.2
        for <cocci@inria.fr>; Fri, 16 Oct 2026 06:57:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792159041; x=1792763841;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uM/uqb6jB5bPusJ8VZ1C6mfq3AmMpsh982OmnP2N20Q=;
        b=tDLX7ECSE3mEZRR8qnXOPhFscLQeXKkh041yiHvlmq1KXvY8LQoDdBw/Mo65PW1S+L
         s+qII1tRdtOMnaME0rCf19cn5xKSiyDAMUQ5DdHYgPkiOIp7bnece9IGVLLx9X9hKmBj
         hUALteS5Oklisp/teabtoWDXQq5jYYMA3ImiW8M5QMJ6QwZ1UANEPhT8AuKDsjkrSd9l
         flVovjlmYpDUoikTDcgLcCnwCXgGxf+Zn+2ZV6Wg1VLmFK3yv+fgf4u3GPS+Yn57EqH7
         fIchUpvORKsUJDdOcJfib4dvkRiXHOMD9tHcQ/okosXv0Sz+JHGfMB7o46Ld+XjVK0mD
         oAGw==
X-Gm-Message-State: AFq9FYLdCNObOQTspZF1SKJ7NOVROX8lDozTowUbkL9L9dS5P/UCDijW
	ZAmXXgzOCc0WLi8GKOpXTtrbyf9xWzRNXylRr5ws886XeT7KPxvNd9TX
X-Gm-Gg: AYBFou2xIJRMG3IsZlERG2Fbir9FCHmolHclQaqsugyUrF+PzNpc3drA99mhdn7ltzj
	1It+g13gzNqbPkunH6YVfE7WCadsOmLkFg/n0MxsDiQNkySW/QCd3wZbH+47Cjtp2bX5i5NpQ5f
	YPf9p+JelLxVee/bqHCt2FgDWQHkD1KnmaWutTrC9Yx2X15G7YxLnoaieYfjWb3eRKv7oGcYo98
	cvaDPgWbmj0Z5414C+u7hoj+ur0J8JG/nezNlY3Fpn/Qp88R8yP92k5avm9SdHndJYIweKll4vQ
	ydlRmTXRkio1hn8jhv79/iwqmLVuL1B1gtKaIuzR+z7W9JtQqQvh8oDJkccmH+z87j7MqYTzpvN
	vmlP2BQz0jRn9oqKj9SFeY1q0VC4CZBLl20AbJk6jY7htBy81A5rb7+d2uVyjFMi+SnkDtOQ87c
	SPfatcnrlWfd/+i3W8Q6rotC1orOAnhcyIwzBgVDaVKhqYB/pBpXFUKNIQvsQaFgRc9ZvfeLgEh
	JjvmyO8M7O2jKZajb7z9a7uez/dZIqK4p0MxRt+LKTyygOVf/C1hA==
X-Received: by 2002:a17:907:3f18:b0:c41:735b:968b with SMTP id a640c23a62f3a-c41735bb4b3mr39888566b.3.1792159040829;
        Fri, 16 Oct 2026 06:57:20 -0700 (PDT)
Received: from ptb-02009389.paris.inria.fr (pd956db4d.dip0.t-ipconnect.de. [217.86.219.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c40919c1282sm72704866b.63.2026.10.16.06.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 06:57:20 -0700 (PDT)
Date: Fri, 16 Oct 2026 15:57:18 +0200
From: Ella Ma <alansnape3058@gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr, linux-kernel@vger.kernel.org, nicolas.palix@imag.fr
Message-ID: <20261016135718.ab5322cdyozostuj@ptb-02009389.paris.inria.fr>
References: <ec578f57-a7f5-7afc-ec2-9156c336187@inria.fr>
 <20261007164316.15102-1-alansnape3058@gmail.com>
 <f635d9fd-8dd5-47f-7996-239bc74bd828@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f635d9fd-8dd5-47f-7996-239bc74bd828@inria.fr>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v3] coccinelle: free: add a checker for
 `__cleanup(kfree)` usage
Reply-To: Ella Ma <alansnape3058@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3754
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-10/0JV0EUIKcxoWNqZyqDM48Q>

On Wed, Oct 07, 2026 at 08:27:33PM +0200, Julia Lawall wrote:
> 
> 
> On Wed, 7 Oct 2026, Ella Ma wrote:
> 
> > Using __cleanup(kfree) will pass the stack address of the annotated
> > local variable to kfree functions. This will lead to invalid
> > deallocation issues. Inspired by CVE-2026-45959 and similar bugs
> > recently detected.
> >
> > Signed-off-by: Ella Ma <alansnape3058@gmail.com>
> > ---
> >
> > Changes in v2:
> > - Add virtual rules `report` and `org` as suggested by Sashiko
> > - Remove `kvfree_sensitive` from rule `cleanup` as suggested by Sashiko
> > - Add `free_percpu` to rule `free`
> > - Add `kfree_const` to rule `cleanup`
> >
> > Changes in v3:
> > - Edit the error messages to clarify the reasons and results
> >
> >  scripts/coccinelle/free/cleanup-free.cocci | 112 +++++++++++++++++++++
> >  1 file changed, 112 insertions(+)
> >  create mode 100644 scripts/coccinelle/free/cleanup-free.cocci
> >
> > diff --git a/scripts/coccinelle/free/cleanup-free.cocci b/scripts/coccinelle/free/cleanup-free.cocci
> > new file mode 100644
> > index 000000000000..48e47ed2186a
> > --- /dev/null
> > +++ b/scripts/coccinelle/free/cleanup-free.cocci
> > @@ -0,0 +1,112 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +///
> > +/// Find __cleanup(kfree)
> > +/// Using __cleanup(kfree) will pass the stack address of the annotated
> > +/// local variable to kfree, causing an invalid free.
> > +/// I.e., `T v __cleanup(kfree);` --> `kfree(&v);`
> > +/// Such usage is impossible to be correct.
> > +///
> > +// Confidence: High
> > +// Copyright: (C) 2026 Ella Ma
> > +// Options: --no-includes --include-headers
> > +
> > +virtual report
> > +virtual org
> > +
> > +// Suggesting using __free for the functions with a DEFINE_FREE definition.
> > +// Update this list when new DEFINE_FREE definitions are added.
> > +@free@
> > +attribute name __cleanup;
> > +symbol kfree, kfree_sensitive, kvfree, kvfree_atomic, free_percpu;
> > +type T;
> > +identifier v, n;
> > +position p;
> > +@@
> > +
> > +(
> > +  T v __cleanup@p(
> > +(
> > +  n
> > +&
> > +(
> > +  kfree \| kfree_sensitive \| kvfree \| kvfree_atomic \| free_percpu
> > +)
> > +)
> > +  );
> > +|
> > +  T v __cleanup@p(
> > +(
> > +  n
> > +&
> > +(
> > +  kfree \| kfree_sensitive \| kvfree \| kvfree_atomic \| free_percpu
> > +)
> > +)
> > +  ) = ...;
> > +)
> > +
> > +@script:python depends on report@
> > +p << free.p;
> > +n << free.n;
> > +@@
> > +
> > +msg = f"ERROR: __cleanup({n}) will cause an invalid free: the stack address of the annotated variable will be passed to {n}; use __free({n}) to free the pointee"
> > +coccilib.report.print_report(p[0], msg)
> > +
> > +@script:python depends on org@
> > +p << free.p;
> > +n << free.n;
> > +@@
> > +
> > +msg = f"ERROR: __cleanup({n}) will cause an invalid free: the stack address of the annotated variable will be passed to {n}; use __free({n}) to free the pointee"
> > +coccilib.org.print_todo(p[0], msg)
> > +
> > +
> > +// Reporting __cleanup usage for the functions without a DEFINE_FREE definition.
> > +// The following list only contains frequently used functions. Supplement it if
> > +// necessary.
> > +@cleanup@
> > +attribute name __cleanup;
> > +symbol vfree, vfree_atomic, kfree_const;
> > +type T;
> > +identifier v, n;
> > +position p;
> > +@@
> > +
> > +(
> > +  T v __cleanup@p(
> > +(
> > +  n
> > +&
> > +(
> > +  vfree \| vfree_atomic \| kfree_const
> > +)
> > +)
> > +  );
> > +|
> > +  T v __cleanup@p(
> > +(
> > +  n
> > +&
> > +(
> > +  vfree \| vfree_atomic \| kfree_const
> > +)
> > +)
> > +  ) = ...;
> > +)
> > +
> > +@script:python depends on report@
> > +p << cleanup.p;
> > +n << cleanup.n;
> > +@@
> > +
> > +msg = f"ERROR: __cleanup({n}) will cause an invalid free: the stack address of the annotated variable will be passed to {n}"
> > +coccilib.report.print_report(p[0], msg)
> 
> Hello, this is more words, but is not what I was hoping for.  You explain
> the effect, but not the cause.  And to fix the bug with confidence the
> reader wants to know the cause.  Here I would have expected something like
> "__cleanup usage for a function without a DEFINE_FREE definition. This will cause an invalid free"

Do you mean only the second rule needs a refinement, or both rules?

==> __cleanup vs __free, both rules:

Using DEFINE_FREE declarer only defines a forwarding function that can
be annotated to a local variable via __free attribute. Defining such a
function with DEFINE_FREE will not automatically make __cleanup correct.
User still need to use __free instead.

FYI: __cleanup will pass the stack address to the annotated function
directly; while __free will first call the forwarding function defined
with DEFINE_FREE, and then the forwarding function will correctly pass
the pointee address to the annotated function.

==> Only the second rule:

Yes. For the functions without a forwarding function definition, one of
the root cause is lacking the definition. But I am not sure whether this
semantic patch should suggest adding one.  As these free functions are
all those frequently used, perhaps the DEFINE_FREE definition should be
added to the corresponding public header files.  Or, do you mean this
semantic rule only needs to report this missing, and the users will add
them where they think is good?

Besides, after adding a definition, the current error message will
become misleading, as there are no rules to search for existing
DEFINE_FREE definitions in the code base. Do you think it is necessary
for this semantic patch to search for the corresponding DEFINE_FREE
definitions first and then generate the error message accordingly?

I.e.,
with DEFINE_FREE:
requiring replacing __cleanup with __free.
without DEFINE_FREE:
reporting missing DEFINE_FREE and also requiring replacing __cleanup
with __free.

ella

> 
> julia
> 
> 
> > +
> > +@script:python depends on org@
> > +p << cleanup.p;
> > +n << cleanup.n;
> > +@@
> > +
> > +msg = f"ERROR: __cleanup({n}) will cause an invalid free: the stack address of the annotated variable will be passed to {n}"
> > +coccilib.org.print_todo(p[0], msg)
> > --
> > 2.34.1
> >
> >
