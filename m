Return-Path: <SRS0=5OGr=FD=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC6FC3E8C5
	for <cocci@archiver.kernel.org>; Sun, 29 Nov 2020 12:25:25 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9205B207CD
	for <cocci@archiver.kernel.org>; Sun, 29 Nov 2020 12:25:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9205B207CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0ATCP5Gb015023;
	Sun, 29 Nov 2020 13:25:05 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id EF9F8779F;
	Sun, 29 Nov 2020 13:25:04 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 15FDF454B
 for <cocci@systeme.lip6.fr>; Sun, 29 Nov 2020 13:25:04 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0ATCP3Xp029733
 for <cocci@systeme.lip6.fr>; Sun, 29 Nov 2020 13:25:03 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.78,379,1599516000"; d="scan'208";a="365979975"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 29 Nov 2020 13:25:03 +0100
Date: Sun, 29 Nov 2020 13:25:02 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <3b134eb3-7ccf-454c-3266-64cfaec5a307@web.de>
Message-ID: <alpine.DEB.2.22.394.2011291323290.2671@hadrien>
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
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1336015433-1606652703=:2671"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 29 Nov 2020 13:25:05 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 29 Nov 2020 13:25:03 +0100 (CET)
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

--8323329-1336015433-1606652703=:2671
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Sun, 29 Nov 2020, Markus Elfring wrote:

> >> @Replacement@
> >> expression action, input1, input2, input3, target;
> >> identifier gs;
> >> @@
> >> -\( g_string_assign@gs \| g_string_append@gs \| g_string_append_c@gs \) (target, input1);
> >>  action (
> >> +        gs (
> >>              target
> >> +            , input1)
> >>              ,
> >> (            input2, input3
> >> |            input2
> >> )       );
> >
> > I find this way of writing disjunctions really unreadable.
>
> I am using different coding styles for SmPL disjunctions because of specific reasons.
>
>
> > You are saving some precious whitespace characters at the cost of making
> > any distinction between what is obligatory and what is optional.
>
> I tend to increase such distinction possibilities.
>
>
> >> The implementation of a function like “format_column_declaration” contains
> >> the following statements.
> >> https://gitlab.gnome.org/GNOME/evolution-data-server/-/blob/3de7ea5fdb5d5db4a097a4d888d77bd2778c1c30/src/addressbook/libedata-book/e-book-sqlite.c#L1898
> >>
> >> 	g_string_append (string, info->name);
> >> 	g_string_append_c (string, ' ');
> >>
> >> 	g_string_append (string, info->type);
> >>
> >> 	if (info->extra) {
> >> 		g_string_append_c (string, ' ');
> >> 		g_string_append (string, info->extra);
> >> 	}
> >
> > The rule matches for example on the first line and on the second line.
>
> Yes. - The transformation approach should work so in principle.
>
>
> > The match on the first line makes a change in the second line.  The match
> > on the second line removes the second line.  This is a conflict,
> > as reported.
>
> I imagine that the error message can be improved somehow.
>
>
> > The problem would be solved in this case by making two separate rules.
>
> I find this suggestion unclear at the moment.

A rule for each of the functions you have in the big disjunction you have
on the first line of your rule.  But it only helps in your case because in
your C code, the first two lines have different function names.

>
> Two changes should be performed in combination for a code replacement.
> How should a separation help then?
>
> Can the shown change pattern be applied recursively?

You can follow the example in demos/iteration.cocci.

julia
--8323329-1336015433-1606652703=:2671
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-1336015433-1606652703=:2671--
