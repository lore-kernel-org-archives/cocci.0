Return-Path: <SRS0=PEvY=IQ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9218EC433DB
	for <cocci@archiver.kernel.org>; Thu, 18 Mar 2021 19:24:52 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA6DE64F30
	for <cocci@archiver.kernel.org>; Thu, 18 Mar 2021 19:24:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA6DE64F30
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 12IJOPtm003031;
	Thu, 18 Mar 2021 20:24:25 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 32E9C77CD;
	Thu, 18 Mar 2021 20:24:25 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 0C5765DC3
 for <cocci@systeme.lip6.fr>; Thu, 18 Mar 2021 20:24:23 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 12IJOMic029246
 for <cocci@systeme.lip6.fr>; Thu, 18 Mar 2021 20:24:22 +0100 (CET)
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AQ8GrK6/z2J4P/Uk3xRduk+GDdb1zdoIgy1kn?=
 =?us-ascii?q?xilNYDZSddGVkN3roe8S0gX6hC1UdHYrn92BP6foewK5ybde544NMbC+GDT3oW?=
 =?us-ascii?q?fAFvAG0aLO4R3FXxf/+OlUyLt6f8FFY+HYIFBmga/BjzWQPM0nxLC8npyAoevF?=
 =?us-ascii?q?1X9iQUVLRshbjztRLgaeHglISBJdBZw/faDshPZvnDardXQJYsnTPBBsNYWum/?=
 =?us-ascii?q?TwiJnkbRQabiRXizWmsDXA0t/HOind9gsCVXd1za0692/en0jC+ry7qP2g0Hbn?=
 =?us-ascii?q?pgjuxqUTtNz9ysZSQOyg4/JlUQnEu0KTSsBMe5DqhkFNnMifrGwF1Pngyi1QR/?=
 =?us-ascii?q?hb4XvNcm+yuhvgwWDboVAT10M=3D?=
X-IronPort-AV: E=Sophos;i="5.81,259,1610406000"; d="scan'208";a="498756359"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 Mar 2021 20:24:22 +0100
Date: Thu, 18 Mar 2021 20:24:22 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Thomas Adam <thomas@xteddy.org>
In-Reply-To: <CAOhcEPYTkAqYM4q4p6q=nvF3eS6QX_-ajRykn08YfnOK9+VHUg@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2103182020110.2984@hadrien>
References: <CAOhcEPYTkAqYM4q4p6q=nvF3eS6QX_-ajRykn08YfnOK9+VHUg@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 18 Mar 2021 20:24:26 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 18 Mar 2021 20:24:22 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Removing the last return statement from a void function
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



On Thu, 18 Mar 2021, Thomas Adam wrote:

> Hello all,
>
> I've another Coccinelle question I'm hoping you can help me with.  The
> codebase I'm working on is old, and has some interesting styles which
> by themselves probably don't cause any problems, but newer C compilers
> are now starting to flag them.
>
> In particular, there seems to be a pattern in this code base of using
> explicit `return;` statements at the end of void functions.  Here's an
> example:
>
> static void broadcast_mini_icon(FvwmWindow *fw)
> {
>     if (!FMiniIconsSupported)
>     {
>         return;
>     }
>     if (fw->mini_pixmap_file && fw->mini_icon)
>     {
>         BroadcastFvwmPicture( M_MINI_ICON, FW_W(fw),
>             FW_W_FRAME(fw), (unsigned long)fw,
>             fw->mini_icon, fw->mini_pixmap_file);
>     }
>     return;
> }
>
> Here you can see the last return statement is not necessary.
>
> I'm trying to make coccinelle recognise this and remove such cases.
> Here's what I've tried:
>
> @@
> identifier f;
> @@
>
> void f(...) {
>   <...
> - return;
> ...>
>
> }
>
> ... which sort of works, but proceeds to remove *all* `return;`
> statements from void functions, rather than the last occurance in the
> function.
>
> Am I on the right track with this approach, or do I need to do
> something more creative?

The ... in Coccinelle is based on control flow, so it is a bit hard to
find the return at the bottom of the function.  Actually, from
Coccinelle's point of view, all returns are at the bottom of the function,
because one leaves the function after a return.

You can try the following:

@r@
position p;
identifier f;
}

f(...) {
<...
{ .. return@p; }
...>
}

@@
position p != r.p;
@@

- return@p;

Basically the first rule collects the position of all returns that are
inside a { }, and then the second rule removes the others.

However there is an isomorphism that makes a pattern with { ... S } match
just S, for any S, which you don't want.  So you can make an empty file
called empty.iso, and then run the rule with the command-line argument
--iso-file empty.iso

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
