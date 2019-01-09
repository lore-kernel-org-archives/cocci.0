Return-Path: <SRS0=lWl4=PR=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E4BCC43387
	for <cocci@archiver.kernel.org>; Wed,  9 Jan 2019 08:55:03 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8269A2075C
	for <cocci@archiver.kernel.org>; Wed,  9 Jan 2019 08:55:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8269A2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x098scit000449
          ; Wed, 9 Jan 2019 09:54:38 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 1240076F2;
	Wed,  9 Jan 2019 09:54:38 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B1A3576E6
 for <cocci@systeme.lip6.fr>; Wed,  9 Jan 2019 09:54:35 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x098sYLT016212
 for <cocci@systeme.lip6.fr>; Wed, 9 Jan 2019 09:54:34 +0100 (CET)
X-pt: isis.lip6.fr
X-Addr-Warning: ATTENTION - Votre correspondant a fourni une adresse
 d'enveloppe @lip6.fr, mais ce message ne provient pas
 de lip6.fr ! postmaster@lip6.fr.
X-IronPort-AV: E=Sophos;i="5.56,456,1539640800"; d="scan'208";a="291274120"
Received: from abo-91-111-68.mrs.modulonet.fr (HELO hadrien) ([85.68.111.91])
 by mail3-relais-sop.national.inria.fr with
 ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2019 09:50:17 +0100
Date: Wed, 9 Jan 2019 09:50:17 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Evan Zhao <tacingiht@gmail.com>
In-Reply-To: <CAAGQS2u+vSa-m_LoOZKVAsry81AS6af=rRY06qOYD8K02WON_Q@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1901090948120.2752@hadrien>
References: <CAAGQS2uda32aGO0vfPNUz8WGatfu8i0oM8dkf_aN9tsAUC1YLg@mail.gmail.com>
 <alpine.DEB.2.21.1901090904120.2752@hadrien>
 <CAAGQS2u+vSa-m_LoOZKVAsry81AS6af=rRY06qOYD8K02WON_Q@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 09 Jan 2019 09:54:38 +0100 (CET)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Wed, 09 Jan 2019 09:54:34 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] A question about a part of a CTL formula
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



On Wed, 9 Jan 2019, Evan Zhao wrote:

> Thank you for your quick response,
>
> I am a beginner for model checking.
> I having been reading your papers and implement code for a while,
> there are some more questions, will you please to answer them too?
>
> there are three free vars type, free_vars, minus_free_vars, and
> minus_nc_free_vars.
> By reading your paper, I know that free vars are used to manage the
> metavariables, but
> what does those three do respectively?

free variables would be all metavariables referenced by a rule.
minus_free_vars would be the ones used in the matching part of the rule (-
annotated code or unannotated code).
nc means no constraint.  One can put a constraint on a metavariable, for
example to say that one position should be different than a previously
identified position.  The no constraint variables are the ones thatare
found directly on the matching code, and not in the constraints.

julia

>
> Thank you again.
>
> On Wed, Jan 9, 2019 at 4:09 PM Julia Lawall <julia.lawall@lip6.fr> wrote:
> >
> >
> >
> > On Wed, 9 Jan 2019, Evan Zhao wrote:
> >
> > > Hi there,
> > >
> > > I am looking at a CTL formula generated by spatch with "--show-ctl-text",
> > >
> > > for example, for a cocci file like
> > > @@
> > > expression e,e1,e2;
> > > @@
> > >
> > > if (e)
> > > - GOTO(e1);
> > > -else GOTO(e2);
> > > + e1;
> > > +else e2;
> > >
> > > it corresponding CTL formula is:
> > >
> > > CTL =
> > > Let _r_0 = (EX^((TrueBranch v InLoop)) v EX^(EX^(FalseBranch))) in
> > > ((_r_0 &
> > > (Ex e1 .
> > > ((Ex_ e . (Ex _v . if (e) )) &,
> > > ((EX(FalseBranch) &, EX(After)) &,
> > > ((EX((TrueBranch &, AX((Ex _v . GOTO(e1);)))) &,
> > > EX((FalseBranch &,
> > > AX(((Ex _v . else ) &, AX((Ex e2 . (Ex _v . GOTO(e2);))))))))
> > > &, EX((After &, EX((Ex _v . _S1)))))))))
> > > v
> > > (!_r_0 &
> > > (Ex e1 .
> > > ((Ex_ e . if (e) ) &,
> > > (EX(FalseBranch) &,
> > > ((EX((TrueBranch &, AX((Ex _v . GOTO(e1);)))) &,
> > > EX((FalseBranch &,
> > > AX(((Ex _v . else ) &, AX((Ex e2 . (Ex _v . GOTO(e2);))))))))
> > > &, EX(After)))))))
> > >
> > > and I noticed that
> > > Let _r_0 = (EX^((TrueBranch v InLoop)) v EX^(EX^(FalseBranch))) in
> > > is a fixed pattern, and I can track it at somewhere around the function of
> > > do_between_dots in the module Asttoctl2, but I don't what it stands for.
> > >
> > > Cloud someone tell me what purpose it serves for?
> >
> > I think it is checking whether the added code is in an if branch in which
> > case it wants to add {}.  I think that in your semantic patch it is not
> > detecting that the then is just a replacement.  If this is what led you to
> > look at the CTL in the first place, you may get a better result with
> >
> > if (e)
> > - GOTO(
> >   e1
> > - )
> >   ;
> > else
> > - GOTO(
> >   e2
> > - )
> >   ;
> >
> > Then it should be able to see that the changes are just inside the
> > existing branches, and so no {} adjustment is needed.
> >
> > julia
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
