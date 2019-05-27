Return-Path: <SRS0=gsjE=T3=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BF2C04AB3
	for <cocci@archiver.kernel.org>; Mon, 27 May 2019 14:29:13 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 279B621721
	for <cocci@archiver.kernel.org>; Mon, 27 May 2019 14:29:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 279B621721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4RET0bv015028;
	Mon, 27 May 2019 16:29:00 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 3DD25774E;
	Mon, 27 May 2019 16:29:00 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 479727747
 for <cocci@systeme.lip6.fr>; Mon, 27 May 2019 16:28:58 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4RESvjE017496
 for <cocci@systeme.lip6.fr>; Mon, 27 May 2019 16:28:57 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.60,519,1549926000"; d="scan'208";a="384903858"
Received: from unknown (HELO hadrien) ([207.115.96.130])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 May 2019 16:28:56 +0200
Date: Mon, 27 May 2019 10:28:55 -0400 (EDT)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: =?ISO-8859-15?Q?Christoph_B=F6hmwalder?= <christoph.boehmwalder@linbit.com>
In-Reply-To: <28b6ede5-cc25-c6be-8526-c291988d208a@linbit.com>
Message-ID: <alpine.DEB.2.21.1905271025520.2501@hadrien>
References: <28b6ede5-cc25-c6be-8526-c291988d208a@linbit.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-22134082-1558967337=:2501"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 27 May 2019 16:29:00 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Mon, 27 May 2019 16:28:57 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Are types re-evaluated between subsequent rules?
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

--8323329-22134082-1558967337=:2501
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT



On Mon, 27 May 2019, Christoph Böhmwalder wrote:

> Hi,
>
> I'm having trouble understanding coccinelles behaviour here. Consider the
> following C code and cocci rules:
>
>
> #include <stdio.h>
>
> int x;
>
> int main(int argc, char **argv)
> {
>     f(x);
> }
>
>
> @@
> identifier x;
> @@
> - int x;
> + int *x;
>
> @@
> int *x;
> @@
> - f(x)
> + g(x)
>
>
>
> Since I read on some slides[0] that "Later rules see the results of earlier
> rules", I would assume that this would pick up the type change introduced by
> the first rule and replace f by g because it now has an "int *" parameter.
> However, spatch merely outputs the patch to change the type of x. If I change
> the type of the "expected" x in rule 2 to "int", cocci picks it up correctly.
>
> Am I missing something?

Your first rule changes only variable declarations, which consist of a
type, a variable and a semicolon.  If you want to change all int types to
int *, then you can change the first rule to remove the x and the ;.  If
you want to change int x in the parameter list of main, or in the
parameter list of all functions, then you could do

@@
identifier f; // all functions
identifier x;
@@

f(...,
- int x
+ int *x
  ,...) { ... }

You can factor out the common parts, ie int and x from the transformation,
as Markus suggests, but I doubt this would be useful.

julia

>
>
> [0]: http://events17.linuxfoundation.org/sites/events/files/slides/part1.pdf,
> page 43
>
> --
> Regards,
> Christoph
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
--8323329-22134082-1558967337=:2501
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-22134082-1558967337=:2501--
