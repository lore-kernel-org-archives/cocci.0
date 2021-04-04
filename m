Return-Path: <SRS0=NM3K=JB=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD19C433ED
	for <cocci@archiver.kernel.org>; Sun,  4 Apr 2021 12:34:05 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE3A361278
	for <cocci@archiver.kernel.org>; Sun,  4 Apr 2021 12:34:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE3A361278
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 134CY19S022988;
	Sun, 4 Apr 2021 14:34:01 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 4081B77D0;
	Sun,  4 Apr 2021 14:34:01 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 0AF2774DE
 for <cocci@systeme.lip6.fr>; Sun,  4 Apr 2021 14:34:00 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 134CXxbe027486
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 4 Apr 2021 14:33:59 +0200 (CEST)
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AXFkxo6B84EHIPpflHelM55DYdL4zR+YMi2QD?=
 =?us-ascii?q?/UZ3VBBTb4ikh9mj9c576TbYgCscMUtKpfmuI6+FKEm3ybdQwa08eYivRxPnvm?=
 =?us-ascii?q?zAFu9fxK/v2SfpFSG71sM178tdWpNzAtHxElR25PySiDWQKcoqw9WM7cmT6tv2?=
 =?us-ascii?q?8nZ3QQlmL4Fm4gtpYzzrcHFeeQhcCZI1UKeb/8pMzgDQHEg/U8LTPBQ4dtmGg9?=
 =?us-ascii?q?XKkZ78CCR2ZCIP2U2pljOn6LnzDhie0FM/alp0oYsfzQ=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.81,304,1610406000"; d="scan'208";a="501516764"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 04 Apr 2021 14:33:59 +0200
Date: Sun, 4 Apr 2021 14:33:58 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Denis Efremov <efremov@linux.com>
In-Reply-To: <afb06bbc-5c28-8a92-f205-c9a1c87c707c@linux.com>
Message-ID: <alpine.DEB.2.22.394.2104041433430.2958@hadrien>
References: <20210216080133.455456-1-efremov@linux.com>
 <20210305100956.6222-1-efremov@linux.com>
 <afb06bbc-5c28-8a92-f205-c9a1c87c707c@linux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 04 Apr 2021 14:34:01 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 04 Apr 2021 14:33:59 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH v3] coccinelle: misc: add swap script
X-BeenThere: cocci@systeme.lip6.fr
X-Mailman-Version: 2.1.13
Precedence: list
List-Id: <cocci.systeme.lip6.fr>
List-Unsubscribe: <https://systeme.lip6.fr/mailman/options/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=unsubscribe>
List-Archive: <https://systeme.lip6.fr/pipermail/cocci>
List-Post: <mailto:cocci@systeme.lip6.fr>
List-Help: <mailto:cocci-request@systeme.lip6.fr?subject=help>
List-Subscribe: <https://systeme.lip6.fr/mailman/listinfo/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr



On Sun, 28 Mar 2021, Denis Efremov wrote:

> Ping?

Applied.  Thanks.

>
> On 3/5/21 1:09 PM, Denis Efremov wrote:
> > Check for opencoded swap() implementation.
> >
> > Signed-off-by: Denis Efremov <efremov@linux.com>
> > ---
> > Changes in v2:
> >   - additional patch rule to drop excessive {}
> >   - fix indentation in patch mode by anchoring ;
> > Changes in v3:
> >   - Rule added for simple (without var init) swap highlighting in !patch
> > mode
> >   - "depends on patch && (rpvar || rp)" fixed
> >
> >   scripts/coccinelle/misc/swap.cocci | 122 +++++++++++++++++++++++++++++
> >   1 file changed, 122 insertions(+)
> >   create mode 100644 scripts/coccinelle/misc/swap.cocci
> >
> > diff --git a/scripts/coccinelle/misc/swap.cocci
> > b/scripts/coccinelle/misc/swap.cocci
> > new file mode 100644
> > index 000000000000..c5e71b7ef7f5
> > --- /dev/null
> > +++ b/scripts/coccinelle/misc/swap.cocci
> > @@ -0,0 +1,122 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +///
> > +/// Check for opencoded swap() implementation.
> > +///
> > +// Confidence: High
> > +// Copyright: (C) 2021 Denis Efremov ISPRAS
> > +// Options: --no-includes --include-headers
> > +//
> > +// Keywords: swap
> > +//
> > +
> > +virtual patch
> > +virtual org
> > +virtual report
> > +virtual context
> > +
> > +@rvar depends on !patch@
> > +identifier tmp;
> > +expression a, b;
> > +type T;
> > +position p;
> > +@@
> > +
> > +(
> > +* T tmp;
> > +|
> > +* T tmp = 0;
> > +|
> > +* T *tmp = NULL;
> > +)
> > +... when != tmp
> > +* tmp = a;
> > +* a = b;@p
> > +* b = tmp;
> > +... when != tmp
> > +
> > +@r depends on !patch@
> > +identifier tmp;
> > +expression a, b;
> > +position p != rvar.p;
> > +@@
> > +
> > +* tmp = a;
> > +* a = b;@p
> > +* b = tmp;
> > +
> > +@rpvar depends on patch@
> > +identifier tmp;
> > +expression a, b;
> > +type T;
> > +@@
> > +
> > +(
> > +- T tmp;
> > +|
> > +- T tmp = 0;
> > +|
> > +- T *tmp = NULL;
> > +)
> > +... when != tmp
> > +- tmp = a;
> > +- a = b;
> > +- b = tmp
> > ++ swap(a, b)
> > +  ;
> > +... when != tmp
> > +
> > +@rp depends on patch@
> > +identifier tmp;
> > +expression a, b;
> > +@@
> > +
> > +- tmp = a;
> > +- a = b;
> > +- b = tmp
> > ++ swap(a, b)
> > +  ;
> > +
> > +@depends on patch && (rpvar || rp)@
> > +@@
> > +
> > +(
> > +  for (...;...;...)
> > +- {
> > +	swap(...);
> > +- }
> > +|
> > +  while (...)
> > +- {
> > +	swap(...);
> > +- }
> > +|
> > +  if (...)
> > +- {
> > +	swap(...);
> > +- }
> > +)
> > +
> > +
> > +@script:python depends on report@
> > +p << r.p;
> > +@@
> > +
> > +coccilib.report.print_report(p[0], "WARNING opportunity for swap()")
> > +
> > +@script:python depends on org@
> > +p << r.p;
> > +@@
> > +
> > +coccilib.org.print_todo(p[0], "WARNING opportunity for swap()")
> > +
> > +@script:python depends on report@
> > +p << rvar.p;
> > +@@
> > +
> > +coccilib.report.print_report(p[0], "WARNING opportunity for swap()")
> > +
> > +@script:python depends on org@
> > +p << rvar.p;
> > +@@
> > +
> > +coccilib.org.print_todo(p[0], "WARNING opportunity for swap()")
> >
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
