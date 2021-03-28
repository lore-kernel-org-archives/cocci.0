Return-Path: <SRS0=v4mC=I2=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050AFC433C1
	for <cocci@archiver.kernel.org>; Sun, 28 Mar 2021 14:08:24 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5A946193A
	for <cocci@archiver.kernel.org>; Sun, 28 Mar 2021 14:08:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5A946193A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 12SE8Kqx021165;
	Sun, 28 Mar 2021 16:08:20 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 0C5B277C4;
	Sun, 28 Mar 2021 16:08:20 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 0B3C93E8A
 for <cocci@systeme.lip6.fr>; Sun, 28 Mar 2021 16:08:18 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 12SE8Hft024070
 for <cocci@systeme.lip6.fr>; Sun, 28 Mar 2021 16:08:17 +0200 (CEST)
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AFkQsM68m5RGMyclo/21uk+A5I+orLtY04lQ7?=
 =?us-ascii?q?vn1ZYxpTb8CeioSSjO0WvCWE7Ao5dXk8lbm7U5Wobmjb8fdOi7U5HbDnZwX+vX?=
 =?us-ascii?q?vtEYcK1+rf6hnBPwG7yeJHz6dndMFFebjNJHx3l9zz7gX9M/tI+rm62Zulj+vf?=
 =?us-ascii?q?0HthJDsCA51I1At3Bh2WFUd7XmB9dPkEPaCB7clKrSfIQxoqR/m8b0NoY8H+vd?=
 =?us-ascii?q?HR0LrpbRkabiRXijWmvHeYrIT3FBWVxX4lPg9ny71Kywf4rzA=3D?=
X-IronPort-AV: E=Sophos;i="5.81,285,1610406000"; d="scan'208";a="377085944"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 28 Mar 2021 16:08:17 +0200
Date: Sun, 28 Mar 2021 16:08:16 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <b761969f-181b-5951-0730-11c340e236ab@web.de>
Message-ID: <alpine.DEB.2.22.394.2103281607280.2854@hadrien>
References: <0756b630-a2d7-f300-3b11-59af33b48631@web.de>
 <alpine.DEB.2.22.394.2103281128560.2854@hadrien>
 <1b5f6d22-5b89-097f-37bd-13b3b2ab011a@web.de>
 <alpine.DEB.2.22.394.2103281244200.2854@hadrien>
 <173fa182-4127-aaba-262e-e3953a81a1e2@web.de>
 <alpine.DEB.2.22.394.2103281343310.2854@hadrien>
 <b761969f-181b-5951-0730-11c340e236ab@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2127690802-1616940497=:2854"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 28 Mar 2021 16:08:20 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 28 Mar 2021 16:08:17 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Replacing #define directives with the help of SmPL
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

--8323329-2127690802-1616940497=:2854
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Sun, 28 Mar 2021, Markus Elfring wrote:

> >> Another SmPL script example:
> >>
> >> @display2@
> >> identifier i;
> >> expression e;
> >> @@
> >> *#define i e
> >>
> >>
> >> elfring@Sonne:~/Projekte/Coccinelle/janitor> spatch show_define_usage2.cocci /usr/include/pipewire-0.3/pipewire/client.h
> >> …
> >> -#define PW_CLIENT_EVENT_INFO		0
> >> …
> >
> > And what is the problem here?
>
> Can you help anyhow according to dealing with the longest common substring problem
> in combination with discussed capabilities of the semantic patch language?

You can implement whatever you want in python.

>
>
> > This may (or may not) give you the right grouping, but you will still have
> > to ensure that the elements end up in the right order, unless you want to
> > provide all the values explicitly.
>
> Some information from #define directives can be imported into symbol tables
> for later transformations (on demand).
> Source code positions need to be recorded accordingly, don't they?

If you want to record the position of something you can use a position
variable.

julia
--8323329-2127690802-1616940497=:2854
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-2127690802-1616940497=:2854--
