Return-Path: <SRS0=5OGr=FD=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2722CC3E8C5
	for <cocci@archiver.kernel.org>; Sun, 29 Nov 2020 16:25:32 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4E9E20657
	for <cocci@archiver.kernel.org>; Sun, 29 Nov 2020 16:25:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4E9E20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0ATGPHl3001646;
	Sun, 29 Nov 2020 17:25:17 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E835A779F;
	Sun, 29 Nov 2020 17:25:16 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 3C0A5454B
 for <cocci@systeme.lip6.fr>; Sun, 29 Nov 2020 17:25:16 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0ATGPFPs026882
 for <cocci@systeme.lip6.fr>; Sun, 29 Nov 2020 17:25:15 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.78,379,1599516000"; d="scan'208";a="365987751"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 29 Nov 2020 17:24:50 +0100
Date: Sun, 29 Nov 2020 17:24:50 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <b548f18b-2fa7-1fcf-5bbb-3011d8a270e5@web.de>
Message-ID: <alpine.DEB.2.22.394.2011291723370.2671@hadrien>
References: <13b38013-8d4f-55fa-3c0e-ead782031659@web.de>
 <alpine.DEB.2.22.394.2011281844070.2725@hadrien>
 <feb351dc-537f-0f83-d9ec-cf16796ac0ee@web.de>
 <alpine.DEB.2.22.394.2011281959330.2725@hadrien>
 <d78a46b3-7035-8300-6e8c-b9e823574ad9@web.de>
 <alpine.DEB.2.22.394.2011282048540.2725@hadrien>
 <8d2bfa68-c8e0-9c5a-b2f5-057e534f5976@web.de>
 <0148bab2-6148-e403-985d-df2e7cade490@web.de>
 <alpine.DEB.2.22.394.2011291250490.2671@hadrien>
 <3b134eb3-7ccf-454c-3266-64cfaec5a307@web.de>
 <alpine.DEB.2.22.394.2011291323290.2671@hadrien>
 <cb266001-ed38-da76-389c-5a7bf7f59e9e@web.de>
 <alpine.DEB.2.22.394.2011291441520.2671@hadrien>
 <79d4245d-6f34-7b8d-d632-99afcc1d228a@web.de>
 <alpine.DEB.2.22.394.2011291543520.2671@hadrien>
 <beeb673b-65b5-fdef-f300-c86a4bd0abc7@web.de>
 <alpine.DEB.2.22.394.2011291617340.2671@hadrien>
 <cf0e2d68-d76b-5892-b97e-36a270732028@web.de>
 <alpine.DEB.2.22.394.2011291652000.2671@hadrien>
 <b548f18b-2fa7-1fcf-5bbb-3011d8a270e5@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-214502117-1606667090=:2671"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 29 Nov 2020 17:25:17 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 29 Nov 2020 17:25:15 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Adjusting some calls according to pass-through functions
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

--8323329-214502117-1606667090=:2671
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Sun, 29 Nov 2020, Markus Elfring wrote:

> > In your rule.  In the place of A, in my example.
>
> I find such information too terse.
>
> I hope that the software documentation will be improved further for transformation loops.
>
>
> > I would still suggest to have one rule per function, rather than trying to
> > do everything at once.
>
> I have tried such a SmPL script variant out a moment ago.
>
> elfring@Sonne:~/Projekte/Gnome/Evolution-Data-Server/lokal> spatch --smpl-spacing --max-width 120 src/addressbook/libedata-book/e-book-sqlite.c ~/Projekte/Gnome/use_string_action_return_pointer9.cocci
> init_defs_builtins: /usr/local/bin/../lib/coccinelle/standard.h
> HANDLING: src/addressbook/libedata-book/e-book-sqlite.c
>
> previous modification:
> MINUS
>
> According to environment 2:
>    Replacement2.input1 -> field->dbname
>
>    Replacement2.gs -> id g_string_append
>
>
> current modification:
>
>   <<< gs(
> CONTEXT
>   >>> , input1)
>
>
> According to environment 2:
>    Replacement2.input1 -> ", "
>
>    Replacement2.gs -> id g_string_append
>
>
> Replacement2: already tagged token:
> C code context
> File "src/addressbook/libedata-book/e-book-sqlite.c", line 3629, column 21, charpos = 101199
>   around = 'string',
>   whole content = 				g_string_append (string, field->dbname);

Since you have provided neither your semantic patch nor the source code to
which it is applied, this information is not useful.

> Do you find the implementation of a function like “ebsql_prepare_insert” more interesting then?
> https://gitlab.gnome.org/GNOME/evolution-data-server/-/blob/3de7ea5fdb5d5db4a097a4d888d77bd2778c1c30/src/addressbook/libedata-book/e-book-sqlite.c#L3598

I'm not sure that Coccinelle is well suited for the problem you are trying
to address.  Normally, one works on code fragments that are more disjoint
from each other.

julia
--8323329-214502117-1606667090=:2671
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-214502117-1606667090=:2671--
