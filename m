Return-Path: <SRS0=ZWNV=TY=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7757C072B5
	for <cocci@archiver.kernel.org>; Fri, 24 May 2019 20:12:54 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C0A9217F9
	for <cocci@archiver.kernel.org>; Fri, 24 May 2019 20:12:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C0A9217F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4OKCfAP009692;
	Fri, 24 May 2019 22:12:42 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D67FF7752;
	Fri, 24 May 2019 22:12:41 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B905D7747
 for <cocci@systeme.lip6.fr>; Fri, 24 May 2019 22:12:40 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4OKCeiM015924
 for <cocci@systeme.lip6.fr>; Fri, 24 May 2019 22:12:40 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.60,508,1549926000"; d="scan'208";a="384662088"
Received: from abo-218-110-68.mrs.modulonet.fr (HELO hadrien) ([85.68.110.218])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 May 2019 22:12:40 +0200
Date: Fri, 24 May 2019 22:12:39 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Timur Tabi <timur@kernel.org>
In-Reply-To: <CAOZdJXXV0a7VgRvLcYvzLZrPzVNsr6+WAxf4e6HDsE+U59zShA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1905242211550.2514@hadrien>
References: <CAOZdJXUYqKX6KEwzXqMR-Wq-gsdHOZzHu9O--5HD2gmb56O36g@mail.gmail.com>
 <alpine.DEB.2.21.1905242147210.2514@hadrien>
 <CAOZdJXXV0a7VgRvLcYvzLZrPzVNsr6+WAxf4e6HDsE+U59zShA@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 24 May 2019 22:12:42 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Fri, 24 May 2019 22:12:40 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Checking if a line of code *does not* exist
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



On Fri, 24 May 2019, Timur Tabi wrote:

> On Fri, May 24, 2019 at 2:48 PM Julia Lawall <julia.lawall@lip6.fr> wrote:
> >
> >
> >
> > On Fri, 24 May 2019, Timur Tabi wrote:
> >
> > > I'm working on a new script that needs to add a NULL-pointer check if
> > > one does not already exist.  For example:
> > >
> > > x = (MYTYPE)MACRO(params);
> > >
> > > should become
> > >
> > > x = (MYTYPE)MACRO(params);
> > > if (!x) {
> > >     do_something;
> > > }
> > >
> > > My problem is that I want coccinelle to add the if-check only if it
> > > doesn't already exist.  So currently I have this:
> > >
> > > @@
> > > type T;
> > > expression x;
> > > @@
> > > x = (T)MACRO(...);
> > > +if (x == NULL)
> > > +{
> > > +    status = ERROR;
> > > +    goto exit;
> > > +}
> > >
> > > How do I make sure that these lines are not added if they already
> > > exist?  I need to check for "if (x == NULL)" and "if (!x)" variants.
> >
> > (
> > A
> > B
> > |
> > A
> > +B
> > )
>
> I can't quite get this to work:
>
> func(...) {
> <+...
>  x = (T)MACRO(...);
> (
>  if (x == NULL)

You can't just put the header of an if.  You have to put the whole thing:

if (x == NULL) S1 else S2

julia

> |
> +if (x == NULL)
> +{
> +    goto label;
> +}
> )
> ...+>
> }
>
> This gives me:
> minus: parse error:
>   File "/home/ttabi/boardobj.cocci", line 12, column 0, charpos = 157
>   around = '|',
>   whole content = |
>
> Line 12 is the |
>
>
>
> >
> > Just put the == NULL variant.  An isomorphism will take care of the !x
> > case.
> >
> > julia
> >
> >
> >
> >
> > > _______________________________________________
> > > Cocci mailing list
> > > Cocci@systeme.lip6.fr
> > > https://systeme.lip6.fr/mailman/listinfo/cocci
> > >
> > _______________________________________________
> > Cocci mailing list
> > Cocci@systeme.lip6.fr
> > https://systeme.lip6.fr/mailman/listinfo/cocci
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
