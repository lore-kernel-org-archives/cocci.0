Return-Path: <SRS0=22Of=IN=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A373C433DB
	for <cocci@archiver.kernel.org>; Mon, 15 Mar 2021 00:43:29 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C4EB64E68
	for <cocci@archiver.kernel.org>; Mon, 15 Mar 2021 00:43:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C4EB64E68
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xteddy.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 12F0hOvE003418;
	Mon, 15 Mar 2021 01:43:24 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 279C53C3C;
	Mon, 15 Mar 2021 01:43:24 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id DD5A93BA2
 for <cocci@systeme.lip6.fr>; Mon, 15 Mar 2021 01:43:21 +0100 (CET)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:236])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 12F0hICa008161
 for <cocci@systeme.lip6.fr>; Mon, 15 Mar 2021 01:43:19 +0100 (CET)
Received: by mail-oi1-x236.google.com with SMTP id d16so23625607oic.0
 for <cocci@systeme.lip6.fr>; Sun, 14 Mar 2021 17:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xteddy-org.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EAs1l3Y97PkaVj3HvwmBPaHH7kWNTOmgHjRj/IEOyrU=;
 b=p8Fs4MdwJqoqSv4/x/uYBahamt/sptdYgcc+8lHWKcCf/6vP9t1FI6ZTNRWQuPeKaK
 8QMs1Aq51hO2VMqLpX/qcfGKWYyMy8NqO7xhOYBdeCuGem48N5+sdbChaPX6ptGG2q0z
 cZB4Di0wks6awKe0WqU/AxAFtGZPmxNPS/dcp9cqxIvdGbNQ1a+MFkLkNaUZU7rKaM2a
 Luzsk6Mi6SnHB6YS/ILsxkb22v7C6dXj8TcMudp4c6oruQlUk777ytPvgoj5gfIsbuXE
 +0/PiImqwOw7Z07PcFRfFrcx/b3u2N5/bHs8WEzmPb2Gnfbgm0CXpMEbpM9Co7ekZ6Jd
 V7Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EAs1l3Y97PkaVj3HvwmBPaHH7kWNTOmgHjRj/IEOyrU=;
 b=SMTUX9puJLB1yFOMB2/OZTzbkHHXxu2N0zLvkGzXNmzKaglPXGizPHCXra4lb+3Sli
 ljnK6brAVO3I+C29k21C4GuqWpOuuv/bGys2XNoABOiGXtSqW4qB6t/BRFAhI/1o1vUN
 nVx2WlpgEaRdhc+nrlcNXURaO0QNJugAGhHTcEQTTGSiaS+YcNPuOC85RE6ruP7pE7TS
 aPSbr+bEIaFnEfHv5+T2rLgLeEULI7/caQeFoUa04W+30L/PI+Y1UIwJVdd35uM+vlfN
 nVx9xJBkaiIEZlcKcwB2kQUXDW19h4Oks23JK8TU/sdLsx8k1NlgzSCZ5lgGJuSJ8zEF
 4SpA==
X-Gm-Message-State: AOAM533vBtUKOqBg2wcb4CCc9qT+H7vEgirpg3wM4MTVFBNofuyKnMqD
 w4b6dB/QPMxAaWM0vJjb19hi9eO2FFcV5OgIzqr4Bg==
X-Google-Smtp-Source: ABdhPJyJDZ9LeTqunDG+oUWgM4JyhrDwpCAEbm90BZ0JlL9wfPpqVvaZF6ZRF2rlVsHXhV5ylTGWkEEU6+PCXoqhysc=
X-Received: by 2002:aca:4c48:: with SMTP id z69mr9042880oia.61.1615768998257; 
 Sun, 14 Mar 2021 17:43:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAOhcEPbTH-oTTn1OUkgoYf2GaBKaCYjwpWuhrdNRkNQ0uZ_r4A@mail.gmail.com>
 <20210314061001.GA993@kunai> <alpine.DEB.2.22.394.2103141016010.2986@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2103141016010.2986@hadrien>
From: Thomas Adam <thomas@xteddy.org>
Date: Mon, 15 Mar 2021 00:43:07 +0000
Message-ID: <CAOhcEPZx4tNocG4TJvQKg_6e6kyJPbWGtj52TaGhJqHD36ZfYw@mail.gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 15 Mar 2021 01:43:25 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 15 Mar 2021 01:43:19 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
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

Hello,

I can see I was as clear as mud with my explanation -- apologies for
that, so let me try again.

In my original example:

struct monitor {
    struct {
        int width;
        int height
    } virtual;
};

... the members width and height aren't required any more, as they're
actually computable generically, and don't belong in that struct.
Instead, I have separate functions which can provide those values.

So where I have in code, statements such as:

struct monitor *m = this_monitor();
int foo = m->virutal.width;

I want to be able to substitute "m->virtual.width" with a function
call "get_width()" -- which does not involve "struct monitor" at all.
Indeed, the semantic patch I'm trying to apply now looks like this:

@@
struct monitor *m;
@@

- m->virtual.width;
+ get_width();

... and although spatch doesn't tell me of any errors, when I run it
over my codebase, no modifications are made.  So clearly I'm still
doing something wrong.  At the point, I have some questions:

1.  Given the inner struct "virtual" inside of "struct monitor", is it
correct that spatch would understand:

m->virtual.width;

... or do I need to declare "virtual" as some expression or
identifier?  I did try:

@@
struct monitor *m;
expression virtual;
@@

- m->virtual.width;
+ get_width();

... but this results in an error.

2.  Do I need to declare "virtual" as a struct in its own right
somehow?  If so, it's not immediately obvious if this should be the
case or how to do it.

I hope I'm making some sense here -- apologies if not, and if I need
to expand upon anything further, do please let me know.

Essentially, it seems to me as though the inner struct "virtual" isn't
being declared as a valid type which spatch is understanding, and this
is why things aren't working how I'd like.

Again, thanks ever so much for you time -- everyone's been very
helpful to me in the past, and I've found coccinelle to be invaluable
to making sweeping code changes, as well as bug-fixes on my codebase,
so thanks to everyone involved in this project.  It's invaluable!

Kindly,
Thomas

On Sun, 14 Mar 2021 at 09:16, Julia Lawall <julia.lawall@inria.fr> wrote:
>
>
>
> On Sun, 14 Mar 2021, Wolfram Sang wrote:
>
> >
> > > @@
> > > type M;
> >
> > This?
> >
> > struct monitor* m;
> >
> > > @@
> > > - m->virtual.width;
> > > + get_monitor_width();
>
> I guess that m should be somewhere in teh call to get_monitor_width too?
>
> julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
