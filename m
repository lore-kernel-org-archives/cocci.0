Return-Path: <SRS0=b71c=UW=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088C6C43613
	for <cocci@archiver.kernel.org>; Sun, 23 Jun 2019 12:55:55 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F35020656
	for <cocci@archiver.kernel.org>; Sun, 23 Jun 2019 12:55:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F35020656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5NCtgvX027797;
	Sun, 23 Jun 2019 14:55:42 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 7B362776C;
	Sun, 23 Jun 2019 14:55:42 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 193E77761
 for <cocci@systeme.lip6.fr>; Sun, 23 Jun 2019 14:55:41 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5NCteVb006019
 for <cocci@systeme.lip6.fr>; Sun, 23 Jun 2019 14:55:40 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.63,408,1557180000"; d="scan'208";a="388678215"
Received: from abo-12-105-68.mrs.modulonet.fr (HELO hadrien) ([85.68.105.12])
 by mail2-relais-roc.national.inria.fr with
 ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jun 2019 14:55:40 +0200
Date: Sun, 23 Jun 2019 14:55:40 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <5f436d79-b510-b0a3-d11a-d92b8d175f7f@web.de>
Message-ID: <alpine.DEB.2.21.1906231454520.4961@hadrien>
References: <f1bb347b-7318-f69f-ad86-bd633c72b375@web.de>
 <alpine.DEB.2.21.1906212251430.2538@hadrien>
 <9d2ef926-62b9-d182-d6d6-cd82ca13173f@web.de>
 <alpine.DEB.2.21.1906221517080.3253@hadrien>
 <4dfb9359-ab09-d206-3110-0fd177ba34b3@web.de>
 <alpine.DEB.2.21.1906221555220.3253@hadrien>
 <5f436d79-b510-b0a3-d11a-d92b8d175f7f@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2000394775-1561294540=:4961"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 23 Jun 2019 14:55:42 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Sun, 23 Jun 2019 14:55:40 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Checking redundant variable initialisations with SmPL?
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

--8323329-2000394775-1561294540=:4961
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Sun, 23 Jun 2019, Markus Elfring wrote:

> > Yu can do whatever you want, but you will get lotsof false positives if
> > you keep it.  If you really want a star on the declaration then you need
> > to make two rules.  The first that finds the positions of the places that
> > match and the second that only puts a * when there is both a matched
> > declaration and a matched reinitialization.
>
> I hoped that the following SmPL script variant can be another approximation
> for the desired solution on the discussed source code search pattern.
>
>
> @display@
> binary operator bo1, bo2;
> expression action, e1, e2 != e1, e3, e4, e5;
> identifier var;
> statement es1, is2, es2, is3, es3;
> type t;
> @@
> (
>  t var = e1;
>  <+...
>  if (...)
>  {
>     var = e2;
>     ...
>  }
>  else
>     es1
>  ...+>
>  if ( \( var \| var bo1 e3 \) )
>     is2
>  else
>     es2
> |
>  t var
> *      = e1
>  ;
>  ... when != if ( \( var \| var bo2 e4 \) ) is3 else es3
>      when != action(..., var, ...)
>      when != switch (var) { default: ... }
>      when exists
> (
> *e5 = <+... var ...+>
> |
> *var = e5
> )
> )
>
>
> But I stumble on the following error message.
>
> elfring@Sonne:~/Projekte/Linux/next-patched> git checkout next-20190620 && spatch drivers/misc/lkdtm/core.c ~/Projekte/Coccinelle/janitor/show_questionable_variable_initialisation5.cocci
> …
> minus: parse error:
>   File "/home/elfring/Projekte/Coccinelle/janitor/show_questionable_variable_initialisation5.cocci", line 36, column 0, charpos = 492
>   around = ')',
>   whole content = )
>
>
> I observed then that each of the two main branches in the shown SmPL disjunction
> can work as expected. So I wonder even more why the combination can not be parsed
> by the software “Coccinelle 1.0.7-00211-geaa13d59 (OCaml 4.07.1)” so far.

Try

... when any

just before the final ).  In some circumstaces the parser doesn't accept
an expression at the end of a sequence like you have here.

julia
--8323329-2000394775-1561294540=:4961
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-2000394775-1561294540=:4961--
