Return-Path: <SRS0=Ayxn=SQ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECBEC10F13
	for <cocci@archiver.kernel.org>; Sun, 14 Apr 2019 07:47:45 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E37E620850
	for <cocci@archiver.kernel.org>; Sun, 14 Apr 2019 07:47:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E37E620850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x3E7lTHE020325
          ; Sun, 14 Apr 2019 09:47:30 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D2697771D;
	Sun, 14 Apr 2019 09:47:29 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id D47CF770C
 for <cocci@systeme.lip6.fr>; Sun, 14 Apr 2019 09:47:28 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x3E7lSYu010304
 for <cocci@systeme.lip6.fr>; Sun, 14 Apr 2019 09:47:28 +0200 (CEST)
X-pt: isis.lip6.fr
X-Addr-Warning: ATTENTION - Votre correspondant a fourni une adresse
 d'enveloppe @lip6.fr, mais ce message ne provient pas
 de lip6.fr ! postmaster@lip6.fr.
X-IronPort-AV: E=Sophos;i="5.60,348,1549926000"; d="scan'208";a="378540351"
Received: from abo-75-106-68.mrs.modulonet.fr (HELO hadrien) ([85.68.106.75])
 by mail2-relais-roc.national.inria.fr with
 ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Apr 2019 09:47:27 +0200
Date: Sun, 14 Apr 2019 09:47:27 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <f30d46a4-db37-7e97-6fb3-2cc2917fd432@web.de>
Message-ID: <alpine.DEB.2.21.1904140946570.2615@hadrien>
References: <ce2b0c4c-bc85-0341-ca0a-9b158804943a@web.de>
 <alpine.DEB.2.20.1904111728380.3143@hadrien>
 <88620f8c-3762-ac4e-5e0f-6115a21635fc@web.de>
 <alpine.DEB.2.21.1904131737540.2536@hadrien>
 <ada8fea1-1b56-1c58-5a78-8fc95006d203@web.de>
 <alpine.DEB.2.21.1904131743330.2536@hadrien>
 <566b0019-021a-0415-4b98-b5d8c74beb83@web.de>
 <alpine.DEB.2.21.1904131802270.2536@hadrien>
 <bedc9f4a-4d02-6898-0226-6f9e67d5d870@web.de>
 <alpine.DEB.2.21.1904131816130.2536@hadrien>
 <b2fc8f6b-b89a-ee77-fdd7-0e219d5bea27@web.de>
 <alpine.DEB.2.21.1904131834510.2536@hadrien>
 <934077c2-a431-afb9-e7f5-0909d45abe2e@web.de>
 <alpine.DEB.2.21.1904131905320.2536@hadrien>
 <f30d46a4-db37-7e97-6fb3-2cc2917fd432@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-974006616-1555228048=:2615"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 14 Apr 2019 09:47:30 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Sun, 14 Apr 2019 09:47:28 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Clarification for SmPL functionality around position
 variables
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

--8323329-974006616-1555228048=:2615
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Sun, 14 Apr 2019, Markus Elfring wrote:

> > Use position variables and use a second rule that forces the positions to
> > be different.  I already explained this.
>
> I suggest to take another look at the provided information.
>
> I have extended the analysis approach like the following.
>
>
> @find@
> identifier work;
> position p1, p2;
> statement s1, s2;
> type T;
> @@
>  T work(...)
>  {
>  ... when any
>  if@p1 (...)
>  {
>     ... when any
>     s1
>     s2
>  }
>  ... when any
>  if@p2 (...)
>  {
>     ... when any
>     s1
>     s2
>  }
>  ... when any
>  }
>
> @duplicated_code@
> identifier work;
> position pos != find.p2, find.p1, find.p2;
> statement s1, s2;
> type T;
> @@
>  T work(...)
>  {
>  ... when any
> *if@p1@pos (...)
> *{
>     ... when any
> *   s1
> *   s2
> *}
>  ... when any
> *if@p2 (...)
> *{
>     ... when any
> *   s1
> *   s2
> *}
>  ... when any
>  }
>
>
> > You surely don't like it, but nothing is going to change in this direction,
> > so the discussion (at least on my side) ends here.
>
> Now I stumble on another error message.
>
>
> elfring@Sonne:~/Projekte/Coccinelle/janitor> spatch --parse-cocci show_same_statements7.cocci
> …
> Variable find.p2 in duplicated_code cannot be used as both a position and a constraint

I think that you have to declare find.p1 and find.p2 on a subsequent line.

julia

>
>
>
> By the way:
> Will it matter that the determined source code positions are not only different
> but also that one place should be before the other?
>
> Regards,
> Markus
>
--8323329-974006616-1555228048=:2615
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-974006616-1555228048=:2615--
