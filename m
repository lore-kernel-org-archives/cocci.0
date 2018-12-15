Return-Path: <SRS0=7lyY=OY=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D947C43387
	for <cocci@archiver.kernel.org>; Sat, 15 Dec 2018 13:49:33 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61A062084D
	for <cocci@archiver.kernel.org>; Sat, 15 Dec 2018 13:49:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61A062084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id wBFDnGwv008863
          ; Sat, 15 Dec 2018 14:49:16 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 0624276D8;
	Sat, 15 Dec 2018 14:49:16 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 66B6276D5
 for <cocci@systeme.lip6.fr>; Sat, 15 Dec 2018 14:49:14 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id wBFDnDYf026609
 for <cocci@systeme.lip6.fr>; Sat, 15 Dec 2018 14:49:13 +0100 (CET)
X-pt: isis.lip6.fr
X-Addr-Warning: ATTENTION - Votre correspondant a fourni une adresse
 d'enveloppe @lip6.fr, mais ce message ne provient pas
 de lip6.fr ! postmaster@lip6.fr.
X-IronPort-AV: E=Sophos;i="5.56,357,1539640800"; d="scan'208";a="289164087"
Received: from abo-91-111-68.mrs.modulonet.fr (HELO hadrien) ([85.68.111.91])
 by mail3-relais-sop.national.inria.fr with
 ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Dec 2018 14:49:13 +0100
Date: Sat, 15 Dec 2018 14:49:13 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: SF Markus Elfring <elfring@users.sourceforge.net>
In-Reply-To: <c8041b90-d4e9-a9a6-603d-7f5498fe081c@users.sourceforge.net>
Message-ID: <alpine.DEB.2.21.1812151447110.2428@hadrien>
References: <alpine.DEB.2.21.1812132057380.2465@hadrien>
 <c8041b90-d4e9-a9a6-603d-7f5498fe081c@users.sourceforge.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 15 Dec 2018 14:49:17 +0100 (CET)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Sat, 15 Dec 2018 14:49:13 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] struct replacement
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



On Sat, 15 Dec 2018, SF Markus Elfring wrote:

> > If you want to make a function prototype, it needs a type in front of it.
>
> This information is appropriate according to the syntax of the C programming language.
>
>
> > This can be a type metavariable, declared with type t;
>
> Can this detail be treated as optional by the means of the semantic patch language
> (without using extra SmPL disjunctions)?

No, it is not optinal in the case of a function prototype.  It is optional
in the case of a function definition.  A prototype without a specified
return type looks too much like a function call, and causes parsing
issues.

>
>
> > But actually your rule should be:
>
> @replacement@
> @@
>  struct
> - old_thing
> + new_thing
>
> Such a succinct change specification seems to be nice.
> Will further collateral evolution matter for this transformation approach?
>
> * Will any related adjustments be needed for data type definitions?
>   https://en.cppreference.com/w/c/language/typedef
>
> * Should source code be updated also in header files then?

To include header files, ie to cause them to be treated as independent
files, like .c files, give the command line argument --include-headers.

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
