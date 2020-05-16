Return-Path: <SRS0=NPBS=66=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED20C433DF
	for <cocci@archiver.kernel.org>; Sat, 16 May 2020 12:45:48 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC1C220727
	for <cocci@archiver.kernel.org>; Sat, 16 May 2020 12:45:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC1C220727
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04GCjWlk025855;
	Sat, 16 May 2020 14:45:32 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id C4DAF3E6B;
	Sat, 16 May 2020 14:45:32 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 360F83DC8
 for <cocci@systeme.lip6.fr>; Sat, 16 May 2020 14:45:31 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04GCjUo1015053
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Sat, 16 May 2020 14:45:30 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.73,398,1583190000"; d="scan'208";a="348817067"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 16 May 2020 14:45:29 +0200
Date: Sat, 16 May 2020 14:45:29 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Chuhong Yuan <hslester96@gmail.com>
In-Reply-To: <CANhBUQ3YaJnVZwy2+Fo42Naa04wQiBnEO6cm-rGE05=rZp0XKw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2005161441500.2573@hadrien>
References: <CANhBUQ2Bqxwk3o8w22L8yvSK+VWbf-WTSiaf8v9kbsqSv2VwAA@mail.gmail.com>
 <alpine.DEB.2.21.2005161047430.2573@hadrien>
 <CANhBUQ3YaJnVZwy2+Fo42Naa04wQiBnEO6cm-rGE05=rZp0XKw@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 16 May 2020 14:45:33 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 16 May 2020 14:45:30 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] How to match function calls in macros?
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



On Sat, 16 May 2020, Chuhong Yuan wrote:

> On Sat, May 16, 2020 at 4:49 PM Julia Lawall <julia.lawall@inria.fr> wrote:
> >
> >
> >
> > On Sat, 16 May 2020, Chuhong Yuan wrote:
> >
> > > Hi all,
> > > I want to write a script to match function calls in macros
> > > but I don't know how to do that.
> > > Here is an example:
> > >
> > > #define __INIT_WORK(_work, _func, _onstack)     \
> > >     do {     \
> > >         static struct lock_class_key __key; \
> > >         \
> > >         __init_work((_work), _onstack); \
> > >         (_work)->data = (atomic_long_t) WORK_DATA_INIT(); \
> > >         lockdep_init_map(&(_work)->lockdep_map,
> > > "(work_completion)"#_work, &__key, 0); \
> > >         INIT_LIST_HEAD(&(_work)->entry); \
> > >         (_work)->func = (_func); \
> > >     } while (0)
> > >
> > > In this example, I want to match function calls
> > > like __init_work() and lockdep_init_map() in this macro.
> > > So how to implement this by Coccinelle?
> >
> > I would suggest to take your file and run spatch --parse-c on the file.
> > If you find BAD or bad in front of the lines of this code then the problem
> > is that the code is not being parsed.  I suspect that the # is the
> > problem.
> >
>
> I have run parse-c and it says the example file is perfect.
>
> > Normally, Coccinelle will match code inside of macro definitions, but only
> > if it is able to parse the macro definition, and the ability to parse
> > macro definitions is somewhat limited.
> >
>
> My expression is not very clear.
> I want to know which macros have function calls and what functions do they call.
> So I wrote a script like this:
>
> - #define mac(...) ... f(...) ...
>
> But it does not work on the example.

Try:

@@
identifier mac,f;
@@

*#define mac(...) <+... f(...) ...+>

... means that the code before and after the ... cannot be matched by the
... when considering control-flow paths.  Your macro is a loop, so there
is one call to f(...) after another. Coccinelle doesn't evaluate values,
so it doesn't realize that a while(0) won't loop.

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
