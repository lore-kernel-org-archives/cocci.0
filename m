Return-Path: <SRS0=RP4p=WV=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA72C3A5A1
	for <cocci@archiver.kernel.org>; Sun, 25 Aug 2019 07:49:22 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FAD9217F4
	for <cocci@archiver.kernel.org>; Sun, 25 Aug 2019 07:49:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FAD9217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7P7n5pR016348;
	Sun, 25 Aug 2019 09:49:05 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 42D6676C5;
	Sun, 25 Aug 2019 09:49:05 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 674907694
 for <cocci@systeme.lip6.fr>; Sun, 25 Aug 2019 09:49:03 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7P7n3lX016795
 for <cocci@systeme.lip6.fr>; Sun, 25 Aug 2019 09:49:03 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.64,428,1559512800"; d="scan'208";a="398781773"
Received: from unknown (HELO [192.168.0.117]) ([223.255.127.50])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 25 Aug 2019 09:49:00 +0200
Date: Sun, 25 Aug 2019 15:48:20 +0800 (CST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: julia@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <661aa3dc-3514-3d75-eb3a-9e46843fd02d@web.de>
Message-ID: <alpine.DEB.2.21.1908251547420.2283@hadrien>
References: <a7f12c28-0f96-d388-f1f4-57db4d3d880d@web.de>
 <2AE15A09-F219-43DC-81A9-73C13CFC0753@lip6.fr>
 <661aa3dc-3514-3d75-eb3a-9e46843fd02d@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-573611738-1566719342=:2283"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 25 Aug 2019 09:49:05 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Sun, 25 Aug 2019 09:49:03 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Challenges around asterisk usage in SmPL code
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

--8323329-573611738-1566719342=:2283
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Sun, 25 Aug 2019, Markus Elfring wrote:

> >> @assignment@
> >> expression x, y;
> >> @@
> >> * y = ... *(x) ...;
> >
> > This doesn’t do what you think.
>
> This might be.
>
>
> > It matches a series of statements, I’m not even completely sure how.
>
> Such a feedback is also interesting.
> My imaginations evolved in other directions.
>
>
> > There can’t be a series of statements before an else.
>
> This view can depend on the interpretation around the handling of compound statements,
> can't it?
>
>
> > You want <+...  ...+>
>
> Does this SmPL construct help to restrict a source code search element
> (while using SmPL ellipses) to a single statement for the shown analysis example?

Yes.

>
> Will the support for unary operations need any further development considerations?

No, the precedence should be ok as is.

julia

> Regards,
> Markus
>
--8323329-573611738-1566719342=:2283
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-573611738-1566719342=:2283--
