Return-Path: <SRS0=EwIO=TD=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76062C43219
	for <cocci@archiver.kernel.org>; Fri,  3 May 2019 20:39:17 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACAA4206BB
	for <cocci@archiver.kernel.org>; Fri,  3 May 2019 20:39:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACAA4206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x43Kd3L5024163
          ; Fri, 3 May 2019 22:39:03 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 1E6EE7737;
	Fri,  3 May 2019 22:39:03 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 38B8A7734
 for <cocci@systeme.lip6.fr>; Fri,  3 May 2019 22:39:01 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x43Kd0wY006090
 for <cocci@systeme.lip6.fr>; Fri, 3 May 2019 22:39:00 +0200 (CEST)
X-pt: isis.lip6.fr
X-Addr-Warning: ATTENTION - Votre correspondant a fourni une adresse
 d'enveloppe @lip6.fr, mais ce message ne provient pas
 de lip6.fr ! postmaster@lip6.fr.
X-IronPort-AV: E=Sophos;i="5.60,427,1549926000"; d="scan'208";a="381569320"
Received: from abo-60-75-68.mrs.modulonet.fr (HELO hadrien) ([85.68.75.60])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 03 May 2019 22:39:00 +0200
Date: Fri, 3 May 2019 22:39:00 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Michael Stefaniuc <mstefani@mykolab.com>
In-Reply-To: <04697af8fb0c96a2e14d15fc11d708a7@mykolab.com>
Message-ID: <alpine.DEB.2.21.1905032238080.3158@hadrien>
References: <1f616769-3fb1-6d41-93eb-82aecc5cb766@mykolab.com>
 <alpine.DEB.2.20.1905030916530.3572@hadrien>
 <04697af8fb0c96a2e14d15fc11d708a7@mykolab.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 03 May 2019 22:39:03 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Fri, 03 May 2019 22:39:00 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Matching more than one declaration?
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



On Fri, 3 May 2019, Michael Stefaniuc wrote:

> On 2019-05-03 09:17, Julia Lawall wrote:
> > On Thu, 2 May 2019, Michael Stefaniuc wrote:
> >
> > > Hello,
> > >
> > > it seems that more than one declaration cannot be matched in one rule:
> > >
> > > @@
> > > identifier i, f;
> > > @@
> > > - int i;
> > > - int f;
> > >
> > > That won't match
> > >
> > > void foo(void)
> > > {
> > >     int i;
> > >     float f;
> >
> > The semantic patch has int int and the code has int float.  If the code
> > has int int, it matches fine.
> Duh... I messed it up while simplifying my test case :/
>
> It does work but only in function scope and not in global scope.
> I've attached the fixed test case.

No, it won't work in global scope.  You can only match one top-level thing
at a time, and each declaration is a top-level thing.  Youcan make a
series of rules that depend on the previous ones, and only make the change
if all are matched.

julia

>
> thanks
> bye
>       michael
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
