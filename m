Return-Path: <SRS0=Qcbb=7G=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C5C2C433DF
	for <cocci@archiver.kernel.org>; Sun, 24 May 2020 13:03:57 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12F1520776
	for <cocci@archiver.kernel.org>; Sun, 24 May 2020 13:03:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12F1520776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04OD3sao008131;
	Sun, 24 May 2020 15:03:54 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 4A5A83DC8;
	Sun, 24 May 2020 15:03:54 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 935223D0F
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 15:03:52 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04OD3pCN003759
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 15:03:52 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.73,429,1583190000"; d="scan'208";a="349464018"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 May 2020 15:03:30 +0200
Date: Sun, 24 May 2020 15:03:30 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <a29f1f11-c12c-6b96-0ddc-09b9790fe9af@web.de>
Message-ID: <alpine.DEB.2.21.2005241501560.2429@hadrien>
References: <1d595042-0940-3056-5460-bffd58782fe2@web.de>
 <alpine.DEB.2.21.2005241405010.2429@hadrien>
 <a29f1f11-c12c-6b96-0ddc-09b9790fe9af@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1435213899-1590325410=:2429"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 24 May 2020 15:03:54 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 24 May 2020 15:03:52 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Converting variable initialisations to later assignments
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

--8323329-1435213899-1590325410=:2429
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Sun, 24 May 2020, Markus Elfring wrote:

> >> @movement@
> >> expression E;
> >> identifier V1, V2, Vx;
> >> statement S;
> >> type T1, T2;
> >> @@
> >>  T1 V1;
> >>  ... when any
> >>  T2 V2
> >> -      = \( <+... Vx ...+> \& E \)
> >
> > What is Vx for?  He wants an expression that involves a.
>
> I chose a slightly more unique metavariable identifier for the desired
> clarification of this use case.
>
> a ⇔ Vx
>     (Or should the identifier “V1” be used instead?)

Vx is not bound to anything.  It will match any identifier.

>
>
> >>  ;
> >>  ... when any
> >>      when != S
> >> ++ V2 = E;
> >
> > What do you expect this code to be added on to?
>
> I imagine that we would like to determine the end of the code block
> for variable declarations somehow.
>
>
> >> elfring@Sonne:~/Projekte/Coccinelle/janitor> spatch --parse-cocci convert_variable_initialisation_to_assignment.cocci
> >> …
> >> plus: parse error:
> >>   File "convert_variable_initialisation_to_assignment.cocci", line 10, column 9, charpos = 117
> >>   around = '\(',
> >>   whole content = -      = \( <+... Vx ...+> \& E \)
> >>
> >>
> >> I have tried another SmPL code variation out then.
> >>
> >> -T2 V2 = \( <+... Vx ...+> \& E \)
> >> +T2 V2
> >>  ;
> >>
> >> elfring@Sonne:~/Projekte/Coccinelle/janitor> spatch --parse-cocci convert_variable_initialisation_to_assignment2.cocci
> >> …
> >> 14: no available token to attach to
>
> Will the mentioned error messages get any more attention?

I already asked above what you expected the ++ code to be attached to.
All added code has to be attached to something.

julia
--8323329-1435213899-1590325410=:2429
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-1435213899-1590325410=:2429--
