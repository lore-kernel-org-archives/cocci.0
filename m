Return-Path: <SRS0=v8PH=77=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F95C433DF
	for <cocci@archiver.kernel.org>; Thu, 18 Jun 2020 19:56:44 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59A3C20890
	for <cocci@archiver.kernel.org>; Thu, 18 Jun 2020 19:56:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59A3C20890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 05IJuLU7006966;
	Thu, 18 Jun 2020 21:56:21 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 824D47577;
	Thu, 18 Jun 2020 21:56:21 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B532C402B
 for <cocci@systeme.lip6.fr>; Thu, 18 Jun 2020 21:56:19 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 05IJuJeK001069
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Thu, 18 Jun 2020 21:56:19 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.75,252,1589234400"; d="scan'208";a="455481042"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 Jun 2020 21:56:19 +0200
Date: Thu, 18 Jun 2020 21:56:18 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Kees Cook <keescook@chromium.org>
In-Reply-To: <202006181249.8B826D9@keescook>
Message-ID: <alpine.DEB.2.22.394.2006182155260.2367@hadrien>
References: <20200615102045.4558-1-efremov@linux.com>
 <202006171103.327F86B1C@keescook>
 <alpine.DEB.2.22.394.2006172051280.3083@hadrien>
 <202006181249.8B826D9@keescook>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 18 Jun 2020 21:56:21 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 18 Jun 2020 21:56:19 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
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



On Thu, 18 Jun 2020, Kees Cook wrote:

> On Wed, Jun 17, 2020 at 08:54:03PM +0200, Julia Lawall wrote:
> >
> >
> > On Wed, 17 Jun 2020, Kees Cook wrote:
> >
> > > On Mon, Jun 15, 2020 at 01:20:45PM +0300, Denis Efremov wrote:
> > > > +@as@
> > > > +expression E1, E2;
> > > > +@@
> > > > +
> > > > +array_size(E1, E2)
> > >
> > > BTW, is there a way yet in Coccinelle to match a fully qualified (?)
> > > identifier? For example, if I have two lines in C:
> > >
> > > A)
> > > 	array_size(variable, 5);
> > > B)
> > > 	array_size(instance->member.size, 5);
> > > C)
> > > 	array_size(instance->member.size + 1, 5);
> > > D)
> > > 	array_size(function_call(variable), 5);
> > >
> > >
> > > This matches A, B, C, and D:
> > >
> > > @@
> > > expression ARG1;
> > > expression ARG2;
> > > @@
> > >
> > > array_size(ARG1, ARG2);
> > >
> > >
> > > This matches only A:
> > >
> > > @@
> > > identifier ARG1;
> > > expression ARG2;
> > > @@
> > >
> > > array_size(ARG1, ARG2);
> > >
> > >
> > > How do I get something to match A and B but not C and D (i.e. I do not
> > > want to match any operations, function calls, etc, only a variable,
> > > which may be identified through dereference, array index, or struct
> > > member access.)
> >
> > \(i\|e.fld\|e->fld\)
> >
> > would probably do what you want.  It will also match cases where e is a
> > function/macr call, but that is unlikely.
> >
> > If you want a single metavariable that contains the whole thing, you can
> > have an expression metavariable E and then write:
> >
> > \(\(i\|e.fld\|e->fld\) \& E\)
>
> Can you give an example of how that would look for an @@ section?
>
> The problem I have is that I don't know the depth or combination of such
> metavariables. There are a lot of combinations:
>
> a
> 	a.b
> 		a.b.c
> 			a.b.c.d
> 			a.b.c->d
> 		a.b->c
> 			a.b->c.d
> 			a.b->c->d
> 	a->b
> 		a->b.c
> 			a->b.c.d
> 			a->b.c->d
> 		a->b->c
> 			a->b->c.d
> 			a->b->c->d
> ...


@@
identifier i,fld;
expression e;
@@

\(\(i\|e.fld\|e->fld\) \& E\)

The e will match all of the variants you are concerned about.

julia



>
>
> --
> Kees Cook
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
