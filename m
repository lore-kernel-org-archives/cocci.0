Return-Path: <SRS0=XveF=OV=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E994C65BAF
	for <cocci@archiver.kernel.org>; Wed, 12 Dec 2018 12:26:39 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD84520839
	for <cocci@archiver.kernel.org>; Wed, 12 Dec 2018 12:26:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD84520839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id wBCCQEcC004505
          ; Wed, 12 Dec 2018 13:26:14 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 1920C76AB;
	Wed, 12 Dec 2018 13:26:14 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 46E3060D7
 for <cocci@systeme.lip6.fr>; Wed, 12 Dec 2018 13:26:13 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id wBCCQCoN009954
 for <cocci@systeme.lip6.fr>; Wed, 12 Dec 2018 13:26:12 +0100 (CET)
X-pt: isis.lip6.fr
X-Addr-Warning: ATTENTION - Votre correspondant a fourni une adresse
 d'enveloppe @lip6.fr, mais ce message ne provient pas
 de lip6.fr ! postmaster@lip6.fr.
X-IronPort-AV: E=Sophos;i="5.56,344,1539640800"; d="scan'208";a="288799412"
Received: from vaio-julia.rsr.lip6.fr ([132.227.76.33])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Dec 2018 13:26:12 +0100
Date: Wed, 12 Dec 2018 13:26:09 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Max <msuraev@sysmocom.de>
In-Reply-To: <a752b0e8-8ed0-1e86-eff7-3d91e87b11ae@sysmocom.de>
Message-ID: <alpine.DEB.2.20.1812121322240.4125@hadrien>
References: <a752b0e8-8ed0-1e86-eff7-3d91e87b11ae@sysmocom.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1317464645-1544617569=:4125"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 12 Dec 2018 13:26:14 +0100 (CET)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Wed, 12 Dec 2018 13:26:12 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] replacing defines
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

--8323329-1317464645-1544617569=:4125
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Wed, 12 Dec 2018, Max wrote:

> Hi.
>
> I've problem replacing parameterized #define using spatch.
>
> For example, in test.c I have following defines:
>
> ...
>
> #define old_junk(a, b, c) if (c) \
>
>                                            printf(a); \
>
>                                           else \
>
>                                            { printf(b); }
>
> #define new_stuff(a, b, b) my_func(a, b, c)
>
> I would like to replace all the entries of old_junk(x, y, z); with
> new_stuff(x, y, z);
>
> I've tried following spatch:
>
> @@
> identifier old_junk, new_stuff, abort;

You have declared new_stuff and abort as metavariables, meaning that
Coccinelle has to figure out what they should be.  But it has no way of
figuring that out in this case.  I think that you can just drop the above
line completely, since you say you really want to replace a call to
old_junk by a call to new_stuff.  If you wanted to replace all calls to
three argument functions by a call to new_stuff, then you would want
old_junk to be a metavariable, but that is probably not useful.

> identifier a, b, c;

Are you sure that a b and c will only match identifiers, like x.  If they
may match expressions, like 2 + 3, then you would want expression in these
cases.

Actually, the fact that old_junk and new_stuff are defined as macros is
irrelevant for this rule.  Coccinelle will just look at the calls.  It
doesn't expland macros, so it doesn't know whether the call is to a macr
or to a function.

julia

> @@
> - old_junk(a, b, c);
> + if (new_stuff(a, b, c))
>
> +        abort();
>
> Which used as "spatch --in-place --sp-file my.spatch tests/test.c"
>
> Unfortunately all I got is "metavariable new_stuff not used in the - or
> context code".
>
> I've tried using "function new_stuff" instead and got another failure:
> "MetaFunc, need more semantic info about id".
>
> Which is the right way to make this sort of replacements?
>
> I'd be happy to get points to the docs which clarify this part as I was
> unable to find anything relevant on
> http://coccinelle.lip6.fr/documentation.php
>
> I went over tutorial slides as well and it feels like I'm missing
> something obvious in here.
>
> I'm using spatch 1.0.4 in latest ubuntu.
>
> --
> - Max Suraev <msuraev@sysmocom.de>       http://www.sysmocom.de/
> =======================================================================
> * sysmocom - systems for mobile communications GmbH
> * Alt-Moabit 93
> * 10559 Berlin, Germany
> * Sitz / Registered office: Berlin, HRB 134158 B
> * Geschaeftsfuehrer / Managing Directors: Harald Welte
>
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
--8323329-1317464645-1544617569=:4125
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-1317464645-1544617569=:4125--
