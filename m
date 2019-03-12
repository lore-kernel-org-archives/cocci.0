Return-Path: <SRS0=3qPg=RP=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53716C43381
	for <cocci@archiver.kernel.org>; Tue, 12 Mar 2019 13:57:30 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3B652087C
	for <cocci@archiver.kernel.org>; Tue, 12 Mar 2019 13:57:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3B652087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x2CDvFbp017840
          ; Tue, 12 Mar 2019 14:57:15 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 356FD7719;
	Tue, 12 Mar 2019 14:57:15 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 982E27714
 for <cocci@systeme.lip6.fr>; Tue, 12 Mar 2019 14:57:13 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x2CDvCS2002717
 for <cocci@systeme.lip6.fr>; Tue, 12 Mar 2019 14:57:12 +0100 (CET)
X-pt: isis.lip6.fr
X-Addr-Warning: ATTENTION - Votre correspondant a fourni une adresse
 d'enveloppe @lip6.fr, mais ce message ne provient pas
 de lip6.fr ! postmaster@lip6.fr.
X-IronPort-AV: E=Sophos;i="5.58,471,1544482800"; d="scan'208";a="298984237"
Received: from vaio-julia.rsr.lip6.fr ([132.227.76.33])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Mar 2019 14:54:04 +0100
Date: Tue, 12 Mar 2019 14:54:02 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Maxime Ripard <maxime.ripard@bootlin.com>
In-Reply-To: <20190312134814.7jf6ff2upiy3wri3@flea>
Message-ID: <alpine.DEB.2.20.1903121450120.4097@hadrien>
References: <20190312083143.sko2syivudpawqk7@flea>
 <alpine.DEB.2.21.1903120950170.2728@hadrien>
 <20190312110114.i4cdrtaznc4phacn@flea>
 <alpine.DEB.2.20.1903121219540.4097@hadrien>
 <20190312134814.7jf6ff2upiy3wri3@flea>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 12 Mar 2019 14:57:15 +0100 (CET)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Tue, 12 Mar 2019 14:57:12 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Substitution of function call to structure parameter
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

> > Try dropping the ; on the assignment fb = e
>
> It worked, thanks!
>
> What is the meaning of the semi-column in that case? The obvious would
> be that it matches an end of line, but given the behaviour shown
> above, I guess there's more to it?

In SmPL you specify complete terms.  For example, you can't just write

if (...)

You have to put at least a then branch.

Likewise, if you have e1 = e2;, the only complete term it matches is a
complete top-level assignment.  It can't match the last n tokens of a
declaration.  On the other hand e1 = e2 is an expression.  It can be part
of other things.

If you think a bit about my explanation, you will quickly see that it is
not quite right, because int x = 12; doesn't have a subterm of the form x
= 12 according to the grammar of C.  So there is a small internal hack to
get around that issue.

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
