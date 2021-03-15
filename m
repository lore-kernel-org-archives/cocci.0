Return-Path: <SRS0=22Of=IN=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A58DC433E0
	for <cocci@archiver.kernel.org>; Mon, 15 Mar 2021 06:39:22 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A47064E12
	for <cocci@archiver.kernel.org>; Mon, 15 Mar 2021 06:39:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A47064E12
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 12F6cxpY028355;
	Mon, 15 Mar 2021 07:38:59 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id EE0277610;
	Mon, 15 Mar 2021 07:38:58 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 876053B91
 for <cocci@systeme.lip6.fr>; Mon, 15 Mar 2021 07:38:56 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 12F6ct3g017893
 for <cocci@systeme.lip6.fr>; Mon, 15 Mar 2021 07:38:55 +0100 (CET)
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AOfpoKahprjhWAx9b0PGCyaSglXBQXtIji2hD?=
 =?us-ascii?q?6mlwRA09T+W0n92j9c526TbakzAUMUtMpfmlNLObSX3Rsb55iLN+AZ6YUAPruH?=
 =?us-ascii?q?SlIehZhOOI/xTbByb8+uRBvJ0OT4FCDrTLZ2RHsQ=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.81,249,1610406000"; d="scan'208";a="497870213"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 15 Mar 2021 07:38:55 +0100
Date: Mon, 15 Mar 2021 07:38:55 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Thomas Adam <thomas@xteddy.org>
In-Reply-To: <CAOhcEPZx4tNocG4TJvQKg_6e6kyJPbWGtj52TaGhJqHD36ZfYw@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2103150734370.2952@hadrien>
References: <CAOhcEPbTH-oTTn1OUkgoYf2GaBKaCYjwpWuhrdNRkNQ0uZ_r4A@mail.gmail.com>
 <20210314061001.GA993@kunai> <alpine.DEB.2.22.394.2103141016010.2986@hadrien>
 <CAOhcEPZx4tNocG4TJvQKg_6e6kyJPbWGtj52TaGhJqHD36ZfYw@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 15 Mar 2021 07:38:59 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 15 Mar 2021 07:38:55 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Wolfram Sang <wsa@kernel.org>, Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Replacing a struct member with a function call
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



On Mon, 15 Mar 2021, Thomas Adam wrote:

> Hello,
>
> I can see I was as clear as mud with my explanation -- apologies for
> that, so let me try again.
>
> In my original example:
>
> struct monitor {
>     struct {
>         int width;
>         int height
>     } virtual;
> };
>
> ... the members width and height aren't required any more, as they're
> actually computable generically, and don't belong in that struct.
> Instead, I have separate functions which can provide those values.
>
> So where I have in code, statements such as:
>
> struct monitor *m = this_monitor();
> int foo = m->virutal.width;
>
> I want to be able to substitute "m->virtual.width" with a function
> call "get_width()" -- which does not involve "struct monitor" at all.
> Indeed, the semantic patch I'm trying to apply now looks like this:
>
> @@
> struct monitor *m;
> @@
>
> - m->virtual.width;
> + get_width();
>
> ... and although spatch doesn't tell me of any errors, when I run it
> over my codebase, no modifications are made.  So clearly I'm still
> doing something wrong.  At the point, I have some questions:
>
> 1.  Given the inner struct "virtual" inside of "struct monitor", is it
> correct that spatch would understand:
>
> m->virtual.width;
>
> ... or do I need to declare "virtual" as some expression or
> identifier?  I did try:
>
> @@
> struct monitor *m;
> expression virtual;
> @@
>
> - m->virtual.width;
> + get_width();
>
> ... but this results in an error.
>
> 2.  Do I need to declare "virtual" as a struct in its own right
> somehow?  If so, it's not immediately obvious if this should be the
> case or how to do it.
>
> I hope I'm making some sense here -- apologies if not, and if I need
> to expand upon anything further, do please let me know.
>
> Essentially, it seems to me as though the inner struct "virtual" isn't
> being declared as a valid type which spatch is understanding, and this
> is why things aren't working how I'd like.
>
> Again, thanks ever so much for you time -- everyone's been very
> helpful to me in the past, and I've found coccinelle to be invaluable
> to making sweeping code changes, as well as bug-fixes on my codebase,
> so thanks to everyone involved in this project.  It's invaluable!

spatch doens't care about virtual.  Identifier is fine.  If the code is
really as simple as you have presented it, ie with the type of m declared
immediately before its use, then there may be a problem with parsing the
code.  Run spatch --parse-c on a file that you think should be changed and
see if BAD or bad come out in front of the code that should be
changed.nYOu can also run spatch --parse-c on the entire directory (may
require removing any limits on the stack size).  That will conclude by
telling you the tokens it is most unhappy with.  You can often get away
with defining a few dummy macros.

If none of that works, please send a small function that illustrates the
problem and the complete semantic patch.

julia



>
> Kindly,
> Thomas
>
> On Sun, 14 Mar 2021 at 09:16, Julia Lawall <julia.lawall@inria.fr> wrote:
> >
> >
> >
> > On Sun, 14 Mar 2021, Wolfram Sang wrote:
> >
> > >
> > > > @@
> > > > type M;
> > >
> > > This?
> > >
> > > struct monitor* m;
> > >
> > > > @@
> > > > - m->virtual.width;
> > > > + get_monitor_width();
> >
> > I guess that m should be somewhere in teh call to get_monitor_width too?
> >
> > julia
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
