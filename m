Return-Path: <SRS0=bgdO=76=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C8EC433E0
	for <cocci@archiver.kernel.org>; Wed, 17 Jun 2020 20:15:32 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F14621707
	for <cocci@archiver.kernel.org>; Wed, 17 Jun 2020 20:15:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F14621707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 05HKF9le017701;
	Wed, 17 Jun 2020 22:15:09 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B75A07577;
	Wed, 17 Jun 2020 22:15:09 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 96AD23D0F
 for <cocci@systeme.lip6.fr>; Wed, 17 Jun 2020 22:15:08 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 05HKF73A023787
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Wed, 17 Jun 2020 22:15:08 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.73,523,1583190000"; d="scan'208";a="351904443"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 17 Jun 2020 22:15:07 +0200
Date: Wed, 17 Jun 2020 22:15:07 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Denis Efremov <efremov@linux.com>
In-Reply-To: <alpine.DEB.2.22.394.2006172154040.3083@hadrien>
Message-ID: <alpine.DEB.2.22.394.2006172214360.3083@hadrien>
References: <20200615102045.4558-1-efremov@linux.com>
 <202006151123.3C2CB7782@keescook>
 <a28543e5-4f93-bf16-930b-42d7b24ab902@linux.com>
 <4dd9c371-0c37-a4bb-e957-3848cb1a13ff@embeddedor.com>
 <e34b7e26-6f07-19b6-39ad-e3bc939551fc@linux.com>
 <alpine.DEB.2.22.394.2006172154040.3083@hadrien>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 17 Jun 2020 22:15:09 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 17 Jun 2020 22:15:08 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [Cocci] [PATCH] coccinelle: misc: add array_size_dup script to
 detect missed overlow checks
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



On Wed, 17 Jun 2020, Julia Lawall wrote:

>
>
> On Wed, 17 Jun 2020, Denis Efremov wrote:
>
> >
> > >
> > > Awesome! I'll take a look into this. :)
> > >
> > Here is another script for your #83 ticket.
> > Currently, it issues 598 warnings.
> >
> > // SPDX-License-Identifier: GPL-2.0-only
> > ///
> > /// Check for missing overflow checks in allocation functions.
> > /// Low confidence because it's pointless to check for overflow
> > /// relatively small allocations.
> > ///
> > // Confidence: Low
> > // Copyright: (C) 2020 Denis Efremov ISPRAS
> > // Options: --no-includes --include-headers
> >
> > virtual patch
> > virtual context
> > virtual org
> > virtual report
> >
> > @depends on patch@
> > expression E1, E2, E3, E4, size;
> > @@
> >
> > (
> > - size = E1 * E2;
> > + size = array_size(E1, E2);
> > |
> > - size = E1 * E2 * E3;
> > + size = array3_size(E1, E2, E3);
> > |
> > - size = E1 * E2 + E3;
> > + size = struct_size(E1, E2, E3);
>
> Should the arguments be checked to see if they have something to do with
> arrays and structures?

Sorry for the noise, I see that this comment makes no sense.

julia

>
> > )
> >   ... when != size = E4
> >       when != size += E4
> >       when != size -= E4
> >       when != size *= E4
>
> Here you can have a metavariable
>
> assignment operator aop;
>
> and then say size aop E4
>
> It doesn't really look like an assignment any more, but it could be a
> little safer.
>
> julia
>
> >       when != &size
> >   \(kmalloc\|krealloc\|kzalloc\|kzalloc_node\|
> >     vmalloc\|vzalloc\|vzalloc_node\|
> >     kvmalloc\|kvzalloc\|kvzalloc_node\|
> >     sock_kmalloc\|
> >     f2fs_kmalloc\|f2fs_kzalloc\|f2fs_kvmalloc\|f2fs_kvzalloc\|
> >     devm_kmalloc\|devm_kzalloc\)
> >   (..., size, ...)
> >
> > @r depends on !patch@
> > expression E1, E2, E3, E4, size;
> > position p;
> > @@
> >
> > (
> > * size = E1 * E2;@p
> > |
> > * size = E1 * E2 * E3;@p
> > |
> > * size = E1 * E2 + E3;@p
> > )
> >   ... when != size = E4
> >       when != size += E4
> >       when != size -= E4
> >       when != size *= E4
> >       when != &size
> > * \(kmalloc\|krealloc\|kzalloc\|kzalloc_node\|
> >     vmalloc\|vzalloc\|vzalloc_node\|
> >     kvmalloc\|kvzalloc\|kvzalloc_node\|
> >     sock_kmalloc\|
> >     f2fs_kmalloc\|f2fs_kzalloc\|f2fs_kvmalloc\|f2fs_kvzalloc\|
> >     devm_kmalloc\|devm_kzalloc\)
> >   (..., size, ...)
> >
> > @script:python depends on report@
> > p << r.p;
> > @@
> >
> > coccilib.report.print_report(p[0], "WARNING: missing overflow check")
> >
> > @script:python depends on org@
> > p << r.p;
> > @@
> >
> > coccilib.org.print_todo(p[0], "WARNING: missing overflow check")
> > _______________________________________________
> > Cocci mailing list
> > Cocci@systeme.lip6.fr
> > https://systeme.lip6.fr/mailman/listinfo/cocci
> >
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
