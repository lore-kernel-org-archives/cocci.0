Return-Path: <SRS0=lRSE=SP=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3038C10F11
	for <cocci@archiver.kernel.org>; Sat, 13 Apr 2019 16:17:06 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43C65208E3
	for <cocci@archiver.kernel.org>; Sat, 13 Apr 2019 16:17:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43C65208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x3DGGsHZ017922
          ; Sat, 13 Apr 2019 18:16:54 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 09A7C7727;
	Sat, 13 Apr 2019 18:16:54 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 17AEC7725
 for <cocci@systeme.lip6.fr>; Sat, 13 Apr 2019 18:16:53 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x3DGGqlo000831
 for <cocci@systeme.lip6.fr>; Sat, 13 Apr 2019 18:16:52 +0200 (CEST)
X-pt: isis.lip6.fr
X-Addr-Warning: ATTENTION - Votre correspondant a fourni une adresse
 d'enveloppe @lip6.fr, mais ce message ne provient pas
 de lip6.fr ! postmaster@lip6.fr.
X-IronPort-AV: E=Sophos;i="5.60,345,1549926000"; d="scan'208";a="302788596"
Received: from abo-75-106-68.mrs.modulonet.fr (HELO hadrien) ([85.68.106.75])
 by mail3-relais-sop.national.inria.fr with
 ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Apr 2019 18:16:52 +0200
Date: Sat, 13 Apr 2019 18:16:51 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <bedc9f4a-4d02-6898-0226-6f9e67d5d870@web.de>
Message-ID: <alpine.DEB.2.21.1904131816130.2536@hadrien>
References: <ce2b0c4c-bc85-0341-ca0a-9b158804943a@web.de>
 <alpine.DEB.2.20.1904111728380.3143@hadrien>
 <88620f8c-3762-ac4e-5e0f-6115a21635fc@web.de>
 <alpine.DEB.2.21.1904131737540.2536@hadrien>
 <ada8fea1-1b56-1c58-5a78-8fc95006d203@web.de>
 <alpine.DEB.2.21.1904131743330.2536@hadrien>
 <566b0019-021a-0415-4b98-b5d8c74beb83@web.de>
 <alpine.DEB.2.21.1904131802270.2536@hadrien>
 <bedc9f4a-4d02-6898-0226-6f9e67d5d870@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 13 Apr 2019 18:16:54 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Sat, 13 Apr 2019 18:16:52 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Checking influence of loops?
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



On Sat, 13 Apr 2019, Markus Elfring wrote:

> >> Should two search specifications (with SmPL ellipses) between them
> >> be kept separate for the desired diff output?
> >
> > I don't understand any of your answers precisely.
>
> I hope that we can come closer again to a better understanding
> of the reported software situation.
>
>
> > If you have a pattern like
> >
> > AAA
> > ...
> > BBB
> >
> > The AAA and BBB might match the same code
>
> I agree to this information in principle.
> But I imagine that this source code should be found
> at different positions.

No there is no such constraint.

>
>
> > if there is a possible flow of execution from the match
> > of AAA to itself.
>
> I am curious on the circumstances when such details
> would be really relevant.

Typically when there is a loop or goto.  But there is no special handling
of either construct.

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
