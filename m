Return-Path: <SRS0=RP4p=WV=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0355C3A5A1
	for <cocci@archiver.kernel.org>; Sun, 25 Aug 2019 09:55:42 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5328A206DD
	for <cocci@archiver.kernel.org>; Sun, 25 Aug 2019 09:55:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5328A206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7P9tSiC024546;
	Sun, 25 Aug 2019 11:55:28 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 669A376C5;
	Sun, 25 Aug 2019 11:55:28 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 61CFB7694
 for <cocci@systeme.lip6.fr>; Sun, 25 Aug 2019 11:55:26 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7P9tPTZ012310
 for <cocci@systeme.lip6.fr>; Sun, 25 Aug 2019 11:55:26 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.64,428,1559512800"; d="scan'208";a="317126085"
Received: from unknown (HELO [192.168.0.117]) ([223.255.127.50])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 25 Aug 2019 11:45:55 +0200
Date: Sun, 25 Aug 2019 17:45:32 +0800 (CST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: julia@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <c6f15b8d-561e-fda4-1531-191334f1142c@web.de>
Message-ID: <alpine.DEB.2.21.1908251741460.2366@hadrien>
References: <a7f12c28-0f96-d388-f1f4-57db4d3d880d@web.de>
 <2AE15A09-F219-43DC-81A9-73C13CFC0753@lip6.fr>
 <661aa3dc-3514-3d75-eb3a-9e46843fd02d@web.de>
 <alpine.DEB.2.21.1908251547420.2283@hadrien>
 <c6f15b8d-561e-fda4-1531-191334f1142c@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 25 Aug 2019 11:55:28 +0200 (CEST)
X-Greylist: Delayed for 00:09:27 by milter-greylist-4.4.3 (isis.lip6.fr
 [132.227.60.2]); Sun, 25 Aug 2019 11:55:26 +0200 (CEST)
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr



On Sun, 25 Aug 2019, Markus Elfring wrote:

> >> Does this SmPL construct help to restrict a source code search element
> >> (while using SmPL ellipses) to a single statement for the shown analysis example?
> >
> > Yes.
>
> I get a parse error also for the following SmPL script variant.
>
> @check@
> expression x;
> statement es;
> @@
> *if ( \( !(x) \| x == NULL \) )
> *   <+... *(x) ...+>;
>  else
>     es
>
>
> Can it be avoided to express assignment variations explicitly?

I don't know what you are trying to do.  Previously, you had the beginning
of an assignment before the ...  I suggested to replace the ... before and
after the *(x) by <+... ...+>.  Strangely you have deleted the assignment
part as well.

Your code line with the <+... ...+> ends with a ;.  So the <+... ...+>
must match an expression (which could be an assignment).  But due to
parsing priorities, <+... ...+> that is unknown is parsed as a statement.
So the ; causes a parse error.  To force the <+... ...+> to be parsed as
an expression, you have to surround it with ().  An isomorphism will
normally cause the case without the parentheses to be considered as well.

None of this has anything to do with unary operators.

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
