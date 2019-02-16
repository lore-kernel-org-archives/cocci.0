Return-Path: <SRS0=17+G=QX=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE20C43381
	for <cocci@archiver.kernel.org>; Sat, 16 Feb 2019 06:42:23 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50BE1222D9
	for <cocci@archiver.kernel.org>; Sat, 16 Feb 2019 06:42:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50BE1222D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1G6g6qJ003367
          ; Sat, 16 Feb 2019 07:42:06 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 80DB776FA;
	Sat, 16 Feb 2019 07:42:06 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 3335D76F4
 for <cocci@systeme.lip6.fr>; Sat, 16 Feb 2019 07:42:05 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1G6g3tJ006320
 for <cocci@systeme.lip6.fr>; Sat, 16 Feb 2019 07:42:03 +0100 (CET)
X-pt: isis.lip6.fr
X-Addr-Warning: ATTENTION - Votre correspondant a fourni une adresse
 d'enveloppe @lip6.fr, mais ce message ne provient pas
 de lip6.fr ! postmaster@lip6.fr.
X-IronPort-AV: E=Sophos;i="5.58,375,1544482800"; d="scan'208";a="369656095"
Received: from abo-58-107-68.mrs.modulonet.fr (HELO hadrien) ([85.68.107.58])
 by mail2-relais-roc.national.inria.fr with
 ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Feb 2019 07:42:03 +0100
Date: Sat, 16 Feb 2019 07:42:03 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Michael Stefaniuc <mstefani@mykolab.com>
In-Reply-To: <0e8b1430-1538-cc24-8644-2ed8baa24276@mykolab.com>
Message-ID: <alpine.DEB.2.21.1902160740520.3212@hadrien>
References: <fb42aa05-f4d0-53cb-7eda-4f0a5db6cd3c@mykolab.com>
 <alpine.DEB.2.21.1902152203380.2572@hadrien>
 <0e8b1430-1538-cc24-8644-2ed8baa24276@mykolab.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-741117803-1550299323=:3212"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 16 Feb 2019 07:42:06 +0100 (CET)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Sat, 16 Feb 2019 07:42:03 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Qualifiers for field types get lost
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
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-741117803-1550299323=:3212
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Fri, 15 Feb 2019, Michael Stefaniuc wrote:

> On 2/15/19 10:04 PM, Julia Lawall wrote:
> >
> >
> > On Thu, 14 Feb 2019, Michael Stefaniuc wrote:
> >
> >> Hello,
> >>
> >> I have this trivial script to remove useless casts to self:
> >> @ disable drop_cast @
> >> type T;
> >> T E;
> >> @@
> >> - (T)
> >>      E
> >>
> >> It works but I'm hitting false positives when the code casts away
> >> qualifiers for field types. Please see the attached test case:
> >> - Good: Cast is kept in foo()
> >> - Bad: Cast is dropped in baz()
> >>
> >> Applying the generated diff will lead to a gcc warning:
> >> $ gcc -c  qualifier.c
> >> qualifier.c: In function ‘baz’:
> >> qualifier.c:12:12: warning: return discards ‘const’ qualifier from
> >> pointer target type [-Wdiscarded-qualifiers]
> >>      return &b->i;
> >>             ^~~~~
> >>
> >> I tried disabling the optional_qualifier iso but that has no effect:
> >> - Not needed for the foo() case
> >> - No effect for the baz() case
> >>
> >> I even tried prepending an alternation with "const T good;" but the cast
> >> still gets removed.
> >
> > The const is now propagated to the fields.  Let me know if there are
> > further problems.
> Many thanks!
>
> I tested it and it removed all but 1 false positive.
> I have also validated that it removed only false positives.
>
> There's a qualifier propagation issue left in the case the field is an
> array. I have attached a patch that extends the tests/qualifier.c test
> case to demonstrate the problem.

Thanks for the report.  I will add that case.

> But actually I am happy about that leftover false positive as that gave
> me a new idea of how to remove some more casts:
> https://source.winehq.org/patches/data/158631

Indeed, this looks like a good idea.

julia
--8323329-741117803-1550299323=:3212
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-741117803-1550299323=:3212--
