Return-Path: <SRS0=Nzf/=TO=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF39C04AB4
	for <cocci@archiver.kernel.org>; Tue, 14 May 2019 06:53:13 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C3FE2086A
	for <cocci@archiver.kernel.org>; Tue, 14 May 2019 06:53:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C3FE2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x4E6r06D028382
          ; Tue, 14 May 2019 08:53:00 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 8AE7A7748;
	Tue, 14 May 2019 08:53:00 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 283AE7743
 for <cocci@systeme.lip6.fr>; Tue, 14 May 2019 08:52:59 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x4E6qtMg029535
 for <cocci@systeme.lip6.fr>; Tue, 14 May 2019 08:52:55 +0200 (CEST)
X-pt: isis.lip6.fr
X-Addr-Warning: ATTENTION - Votre correspondant a fourni une adresse
 d'enveloppe @lip6.fr, mais ce message ne provient pas
 de lip6.fr ! postmaster@lip6.fr.
X-IronPort-AV: E=Sophos;i="5.60,467,1549926000"; d="scan'208";a="305905534"
Received: from abo-218-110-68.mrs.modulonet.fr (HELO hadrien) ([85.68.110.218])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 14 May 2019 08:52:54 +0200
Date: Tue, 14 May 2019 08:52:54 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <4116e083-9e21-62d7-10b7-5cb26594144c@web.de>
Message-ID: <alpine.DEB.2.21.1905140849570.2567@hadrien>
References: <1553321671-27749-1-git-send-email-wen.yang99@zte.com.cn>
 <e34d47fe-3aac-5b01-055d-61d97cf50fe7@web.de>
 <6f08d4d7-5ffc-11c0-8200-cade7d294de6@web.de>
 <alpine.DEB.2.20.1905131130530.3616@hadrien>
 <4116e083-9e21-62d7-10b7-5cb26594144c@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 14 May 2019 08:53:01 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Tue, 14 May 2019 08:52:55 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Yi Wang <wang.yi59@zte.com.cn>, Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        Wen Yang <wen.yang99@zte.com.cn>, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [4/5] Coccinelle: put_device: Extend when constraints
 for two SmPL ellipses
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



On Tue, 14 May 2019, Markus Elfring wrote:

> >> A SmPL ellipsis was specified for a search approach so that additional
> >> source code would be tolerated between an assignment to a local variable
> >> and the corresponding null pointer check.
> >>
> >> But such code should be restricted.
> >> * The local variable must not be reassigned there.
> >> * It must also not be forwarded to an other assignment target.
> >>
> >> Take additional casts for these code exclusion specifications into account
> >> together with optional parentheses.
> >
> > NACK.
>
> Can you agree to any information which I presented in the commit message?
>
>
> > You don't need so many type metavariables.
>
> It seems that the Coccinelle software can cope also with my SmPL code addition.
> You might feel uncomfortable with the suggested changes for a while.

It's ugly.  Much more ugly than msg =

>
>
> > Type metavariables in the same ... can be the same.
>
> Such information is good to know for the proper usage of specifications
> after a SmPL ellipsis.
>
> * Can it become required to identify involved source code placeholders
>   by extra metavariables?

I don't understand the question.

> * Would you like to clarify the probability any more how often the shown
>   type casts will be identical?

No idea about this one either.

Basically, if you have T && T, the two T's have to be the same, and T is
not pure.  If you have T || T, then only one will be matched and T remains
pure.  If you have T on two separate ...s then you are in the && case.  If
you have T in two branches of a disjunction or in two whens on the same
... you are in the || case.  Just as you can use the variable e1 over and
over on the same when, you can use the same T.

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
