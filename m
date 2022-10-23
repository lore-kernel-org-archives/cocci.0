Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBBE5C3A59D
	for <cocci@archiver.kernel.org>; Sun, 23 Oct 2022 20:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=qN5ny+o71gm6CXKEKthOgSkktAVZ67zrHN8M4WHDcec=;
  b=OVeL9L2QrhUy0kF8qgngpV7roqB3cDpiISlzhI0Enk8CG9Prez/1aH5k
   JunAxn1xlPS7lw5BVNhjXVYQlNJ9eaew1WTPRhO82S7bfEIENOH1gSSU3
   p1Vr03cUFnU/lCXQNIY8dlTg5VPCwfCuKcgJHd4ufzCgzBPRtLOnvAJA6
   E=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.95,207,1661810400"; 
   d="scan'208";a="67942838"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Oct 2022 22:09:20 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0F6BBE013D; Sun, 23 Oct 2022 22:09:20 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 3CB26E004E
	for <cocci@sympa.inria.fr>; Sun, 23 Oct 2022 22:09:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=qN5ny+o71gm6CXKEKthOgSkktAVZ67zrHN8M4WHDcec=;
  b=PFo9U8/5IZY2ciTT5uVRQjMOvUGaheEJluDACI2hQKNEtmRAattFXhpJ
   wLsLJYinBg/ZLYdU8G1q7qC1FW4/hB4zDdvAHRvY5BJ0phbeNwBFP65Hr
   6+uYTW70MawS2PjKAYm/cHoS4fsw/Rp/xTTg6fKMg6Q/Da05cl3apU6n1
   Y=;
X-IronPort-AV: E=Sophos;i="5.95,207,1661810400"; 
   d="scan'208";a="33212793"
Received: from 51.123.68.85.rev.sfr.net (HELO hadrien) ([85.68.123.51])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2022 22:09:13 +0200
Date: Sun, 23 Oct 2022 22:09:13 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
cc: Markus Elfring <Markus.Elfring@web.de>, cocci@inria.fr
In-Reply-To: <Y1WdD/fxtmZwtxrn@zx2c4.com>
Message-ID: <alpine.DEB.2.22.394.2210232208180.94971@hadrien>
References: <CAHmME9rTWvUxsM-sFZh1r+D5gb-8rbHmeWiFEfobkjxDRrZO1Q@mail.gmail.com> <alpine.DEB.2.22.394.2210200705030.2988@hadrien> <CAHmME9p7nTuAOS87NYKhbhh1rF-XJBkuWjjmHbrkiJUrth5XHQ@mail.gmail.com> <trinity-3c34f082-c650-4c08-9ff9-f746f20e4183-1666533323595@3c-app-webde-bap48>
 <Y1WYWT0xU5hv1Gr9@zx2c4.com> <alpine.DEB.2.22.394.2210232143500.94971@hadrien> <Y1WdD/fxtmZwtxrn@zx2c4.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] algebraic simplification possibilities with SmPL
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 678
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/alpine.DEB.2.22.394.2210232208180.94971%40hadrien>



On Sun, 23 Oct 2022, Jason A. Donenfeld wrote:

> On Sun, Oct 23, 2022 at 09:45:42PM +0200, Julia Lawall wrote:
> >
> >
> > On Sun, 23 Oct 2022, Jason A. Donenfeld wrote:
> >
> > > On Sun, Oct 23, 2022 at 03:55:23PM +0200, Markus Elfring wrote:
> > > > > There's another one in that series that's kind of interesting:
> > > > >
> > > > > https://lore.kernel.org/lkml/20221022014403.3881893-6-Jason@zx2c4.com/
> > > > >
> > > > > This one has a very simple rule:
> > > > >
> > > > > @@
> > > > > expression H;
> > > > > expression L;
> > > > > @@
> > > > > - (get_random_u32_below(H) + L)
> > > > > + get_random_u32_between(L, H + L)
> > > > >
> > > > > This worked as expected, but I had to do a lot of hand simplification.
> > > > > For example, a lot of code had a pattern of:
> > > > >
> > > > > get_random_u32_below(H - L + 1) + L
> > > > >
> > > > > which then got converted into
> > > > >
> > > > > get_random_u32_between(L, H - L + 1 + L)
> > > > >
> > > > > which I then had to clean up manually into
> > > > >
> > > > > get_random_u32_between(L, H + 1)
> > > > >
> > > > > It's not like that's all that hard to do. But it would be cool if
> > > > > Cocinnelle had some sort of algebraic simplification possibility.
> > > >
> > > > I imagine also that it will occasionally be nicer if further optimisation
> > > > rules would belong to the standard functionality of the Coccinelle software.
> > > > But I guess that you can achieve desirable transformations also by using
> > > > additional rules for the semantic patch language.
> > > >
> > > > How do you think about a change approach like the following?
> > > >
> > > > @cleanup@
> > > > identifier H, L;
> > > > @@
> > > >  get_random_u32_between(L,
> > > >                         H
> > > > -                         - L
> > > >                           + 1
> > > > -                         + L
> > > >                        )
> > > >
> > >
> > > I can do something like that. These seem to work:
> > >
> > > @@
> > > expression H;
> > > expression L;
> > > @@
> > > - (get_random_u32_below(H) + L)
> > > + get_random_u32_between(L, H + L)
> > >
> > > @@
> > > expression H;
> > > expression L;
> > > expression E;
> > > @@
> > >   get_random_u32_between(L,
> > >   H
> > > - + E
> > > - - E
> > >   )
> > >
> > > @@
> > > expression H;
> > > expression L;
> > > expression E;
> > > @@
> > >   get_random_u32_between(L,
> > >   H
> > > - - E
> > > - + E
> > >   )
> > >
> > > @@
> > > expression H;
> > > expression L;
> > > expression E;
> > > expression F;
> > > @@
> > >   get_random_u32_between(L,
> > >   H
> > > - - E
> > >   + F
> > > - + E
> > >   )
> > >
> > > @@
> > > expression H;
> > > expression L;
> > > expression E;
> > > expression F;
> > > @@
> > >   get_random_u32_between(L,
> > >   H
> > > - + E
> > >   + F
> > > - - E
> > >   )
> > >
> > >
> > > Kind of annoying that Coccinelle doesn't do commutativity itself, but
> > > that's fine.
> >
> > The parse tree is probably not what you would hope it to be.  It's
> > probably, eg:
> >
> > (a + b) + c
> >
> > so it's not straightforward to exchange b and c, without considering lots
> > of special cases.
>
> The general solution might be a pass that removes parens when they don't
> influence the order of operations?

Sorry, they weren't real parentheses.  They were showing how the AST is
organized.  b and c aren't at the same level.

julia
