Return-Path: <SRS0=yQoC=73=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA19DC433E0
	for <cocci@archiver.kernel.org>; Sun, 14 Jun 2020 19:38:06 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64B1A206D7
	for <cocci@archiver.kernel.org>; Sun, 14 Jun 2020 19:38:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64B1A206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 05EJc1gH017856;
	Sun, 14 Jun 2020 21:38:01 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D019E7760;
	Sun, 14 Jun 2020 21:38:01 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id D2DCE44A7
 for <cocci@systeme.lip6.fr>; Sun, 14 Jun 2020 21:37:58 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 05EJbwLm025914
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 14 Jun 2020 21:37:58 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.73,512,1583190000"; d="scan'208";a="454646118"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 14 Jun 2020 21:37:45 +0200
Date: Sun, 14 Jun 2020 21:37:45 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Mike Galbraith <umgwanakikbuti@gmail.com>
In-Reply-To: <1592158913.7336.48.camel@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2006142137330.2849@hadrien>
References: <b14e6d1d-afa0-5c28-547a-9bb1a987f6fd@infradead.org>
 <1592115803.27290.33.camel@gmail.com>
 <alpine.DEB.2.22.394.2006140940000.2849@hadrien>
 <1592121432.2129.9.camel@gmail.com>
 <alpine.DEB.2.22.394.2006141042270.2849@hadrien> 
 <1592124280.2129.22.camel@gmail.com>
 <alpine.DEB.2.22.394.2006141456520.2849@hadrien>
 <1592158913.7336.48.camel@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 14 Jun 2020 21:38:02 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 14 Jun 2020 21:37:58 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Randy Dunlap <rdunlap@infradead.org>, cocci@systeme.lip6.fr
Subject: Re: [Cocci] coccinelle issues
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



On Sun, 14 Jun 2020, Mike Galbraith wrote:

> On Sun, 2020-06-14 at 14:59 +0200, Julia Lawall wrote:
> >
> > On Sun, 14 Jun 2020, Mike Galbraith wrote:
> >
> > > On Sun, 2020-06-14 at 10:43 +0200, Julia Lawall wrote:
> > > >
> > > > What is your Linux distribution?
> > >
> > > openSUSE Leap-15.1
> >
> > Our CI already has an entry for openSUSE Leap.  We will look into it, but
> > if you have any further information about the problem, please let us know.
>
> Executive Summary:

Thanks for all the information!

julia

>
> warning: Can't find macro file: /usr/local/coccinelle/bin/../lib/coccinelle/standard.h
> warning: Can't find default iso file: /usr/local/coccinelle/bin/../lib/coccinelle/standard.iso
>
> I find those under lib64, apply symlink bandaid, proggy acks.
>
> WRT the HEAD make install booboo..
>
> git@homer:~/coccinelle> sudo make install
> mkdir -p /usr/local/coccinelle/bin /usr/local/coccinelle/lib64/coccinelle
> mkdir -p /usr/local/coccinelle/lib64/coccinelle/ocaml
> if test -f bundles/pyml/dllpyml_stubs.so; then \
>         /usr/bin/install -c -m 755 bundles/pyml/dllpyml_stubs.so \
>                 /usr/local/coccinelle/lib64/coccinelle; \
> fi
> if test -f bundles/pcre/dllpcre_stubs.so; then \
>         /usr/bin/install -c -m 755 bundles/pcre/dllpcre_stubs.so \
>                 /usr/local/coccinelle/lib64/coccinelle; \
> fi
> /usr/bin/install -c -m 755 spatch.opt /usr/local/coccinelle/bin/spatch
> /usr/bin/install -c -m 644 standard.h /usr/local/coccinelle/lib64/coccinelle
> /usr/bin/install -c -m 644 standard.iso /usr/local/coccinelle/lib64/coccinelle
> /usr/bin/install -c -m 644 ocaml/*.cmi /usr/local/coccinelle/lib64/coccinelle/ocaml/
> if test -f ocaml/coccilib.cmx; then \
>         /usr/bin/install -c -m 644 ocaml/*.cmx /usr/local/coccinelle/lib64/coccinelle/ocaml/; \
> fi
> /usr/bin/install -c -m 755 tools/spgen/source/spgen.opt \
>          /usr/local/coccinelle/bin/spgen
> /usr/bin/install -c -m 644 python/coccilib/*.py \
>         /usr/local/coccinelle/lib64/coccinelle/python/coccilib
> /usr/bin/install: target '/usr/local/coccinelle/lib64/coccinelle/python/coccilib' is not a directory
> make: *** [Makefile:332: install-python] Error 1
>
> mkdir -p bandaid worked.
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
