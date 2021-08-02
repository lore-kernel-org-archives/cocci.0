Return-Path: <SRS0=dEn7=MZ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0189CC4338F
	for <cocci@archiver.kernel.org>; Mon,  2 Aug 2021 18:05:42 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A82E60F51
	for <cocci@archiver.kernel.org>; Mon,  2 Aug 2021 18:05:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2A82E60F51
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 172I5bYc006673;
	Mon, 2 Aug 2021 20:05:37 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id BBB06750F;
	Mon,  2 Aug 2021 20:05:37 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B273E3783
 for <cocci@systeme.lip6.fr>; Mon,  2 Aug 2021 20:05:35 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 172I5ZeU001517
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 2 Aug 2021 20:05:35 +0200 (CEST)
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ALAramq4WWqDjMMnINAPXwNXXdLJyesId70hD?=
 =?us-ascii?q?6qkRc203TiX2rbHKoB1273HJYVUqOE3I5+rwWpVoKEm0nfUe3WB2B9aftWLd1F?=
 =?us-ascii?q?dAQrsO0WKb+VLdJxE=3D?=
X-IronPort-AV: E=Sophos;i="5.84,289,1620684000"; d="scan'208";a="522520154"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 02 Aug 2021 20:05:34 +0200
Date: Mon, 2 Aug 2021 20:05:33 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Joe Perches <joe@perches.com>
In-Reply-To: <5e170252bf759dc90888de34fbad3291a70b58de.camel@perches.com>
Message-ID: <alpine.DEB.2.22.394.2108022000400.19470@hadrien>
References: <ab04588b3b0c2bfa6942beb9069754ce59f2551b.camel@perches.com>
 <alpine.DEB.2.22.394.2108021933170.19470@hadrien>
 <5e170252bf759dc90888de34fbad3291a70b58de.camel@perches.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 02 Aug 2021 20:05:38 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 02 Aug 2021 20:05:35 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Coccinelle: Length/Size of char array?
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



On Mon, 2 Aug 2021, Joe Perches wrote:

> On Mon, 2021-08-02 at 19:35 +0200, Julia Lawall wrote:
> >
> > On Mon, 2 Aug 2021, Joe Perches wrote:
> >
> > > Is it possible to determine the length of a matched char array and use
> > > the length in a test?
> > >
> > > For instance, add something like a test to show only the instances
> > > where a src buffer overruns a dest buffer.
> > >
> > > void foo(void)
> > > {
> > > 	char foo[5];
> > >
> > > 	strcpy(foo, "fits");
> > > }
> > >
> > > it would be useful to see only the instances where the dest
> > > buffer would be overrun like:
> > >
> > > void foo(void)
> > > {
> > > 	char foo[5];
> > >
> > > 	strcpy(foo, "doesn't fit");
> > > }
> > >
> > > ---
> > >
> > > This would find all instances of a constant src array into non-pointer dst:
> > >
> > > @@
> > > char [] dest;
> > > constant char [] src;
> > > @@
> > >
> > > *	strcpy(dest, src)
> > >
> > > ---
> > >
> > > Is there a mexhanism like:
> > >
> > > @@
> > > char [] dest;
> > > constant char [] src;
> > > @@
> > >
> > > 	when (some cocci grammar testing length(dest) < length(src))
> > > *	strcpy(dest, src)
> >
> > You can match the size and the string, and then use python or ocaml code
> > to do the needed comparisons.
>
> Pardon the question, but how do you determine the size?

In the case of a local variable, you can do:

@r@
constant int n;
identifier i;
constant char [] c;
position p1,p2;
@@

char i@p1[n];
... when exists
strcpy@p2(i,c);

@script:ocaml@
p1 << r.p1;
p2 << r.p2;
n << r.n;
c << r.c;
@@

if string_of_int n < String.length c
then ...

A similar script can be written in python.

If the array is allocated somewhere else, it would be more complicated.

julia

>
> > Does it occur often enough that the string
> > is explicit in the call to make it worth it?
>
> The idea is just to find defects/buffer overruns.
>
>
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
