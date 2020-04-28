Return-Path: <SRS0=bJsz=6M=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B64C83008
	for <cocci@archiver.kernel.org>; Tue, 28 Apr 2020 18:41:25 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57B8F208E0
	for <cocci@archiver.kernel.org>; Tue, 28 Apr 2020 18:41:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57B8F208E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03SIfBH6007670;
	Tue, 28 Apr 2020 20:41:11 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 8E5597807;
	Tue, 28 Apr 2020 20:41:11 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 88A5E3DC8
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 20:41:09 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03SIf9lf015707
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 20:41:09 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.73,328,1583190000"; d="scan'208";a="447338520"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 28 Apr 2020 20:41:08 +0200
Date: Tue, 28 Apr 2020 20:41:08 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Paul Chaignon <paul@cilium.io>
In-Reply-To: <20200428181746.GA8848@Mem>
Message-ID: <alpine.DEB.2.21.2004282036540.3273@hadrien>
References: <20200428101124.GA18321@Mem>
 <alpine.DEB.2.21.2004281943320.3273@hadrien> <20200428181746.GA8848@Mem>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 28 Apr 2020 20:41:11 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 28 Apr 2020 20:41:09 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr, paul.chaignon@gmail.com
Subject: Re: [Cocci] Using a macro for variable attributes
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



On Tue, 28 Apr 2020, Paul Chaignon wrote:

> Thanks for the quick answer!
>
> On Tue, Apr 28, 2020 at 07:44:15PM +0200, Julia Lawall wrote:
> >
> >
> > On Tue, 28 Apr 2020, Paul Chaignon wrote:
> >
> > > Hi all,
> > >
> > > I am working on a small semantic patch to annotate specific variables in
> > > our codebase with __attribute__((aligned(8))). The following program works
> > > fine.
> > >
> > >   @r@
> > >   expression e1, e2;
> > >   identifier x;
> > >   @@
> > >   (
> > >     struct \(icmphdr\|icmp6hdr\) x
> > >   + __attribute__((aligned(8)))
> > >     ;
> > >   |
> > >     struct \(icmphdr\|icmp6hdr\) x
> > >   + __attribute__((aligned(8)))
> > >     = ...;
> > >   )
> > >     ... when exists
> > >     ctx_load_bytes(e1, e2, &x, ...)
> > >
> > > However, when I replace __attribute__((aligned(8))) with our internal
> > > macro __align_stack_8, it fails with the following error:
> > >
> > >   plus: parse error:
> > >     File "/home/paul/cilium/contrib/coccinelle/aligned.cocci", line 7, column 2, charpos = 77
> > >     around = '__align_stack_8',
> > >     whole content = + __align_stack_8
> > >
> > > I've tried adding '#define __align_stack_8' in a file passed with
> > > --macro-file, without success. Is this a known limitation for macros or
> > > am I missing something?
> >
> > Try adding the "metavariable" declaration:
> >
> > attribute name __align_stack_8;
>
> Awesome, that worked. And I think I understand: undeclared identifiers are by
> default considered symbols, leading to the parse error.
>
> Unfortunately, my semantic patch now leads to the following changes:
>
>   -	struct icmphdr icmphdr __align_stack_8;
>   +	struct icmphdr icmphdr __align_stack_8 __align_stack_8;
>
> I would normally add a first case to my conjunction to match on
> already-present attributes, but Coccinelle can't match on attributes yet.
> Any workaround?

Jaskaran is working on it.

A hackish solution would be to put a position variable on the variable
name and put a position variable on the ; and then use python to see if
they are not adjacent to each other...

Do you get a lot of occurrences of the problem?  In the short term it
could be simpler to just clean it up by hand.  It should be easy to search
for at least.

julia


>
> Paul
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
