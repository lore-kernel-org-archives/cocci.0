Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E019EC3A59D
	for <cocci@archiver.kernel.org>; Sun, 23 Oct 2022 20:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=oAw83aa23W5jQO4zMD6j3/doCvGx1C5w03aSzbT6xPs=;
  b=d1v4m9ppYjh+WkljHbCzdNYiYF9HtAXnUV7uQ0mTZyTiMw10imrkq+ys
   7lFpmia+60SoXF98xjY5FENPEOY2vnkPzbacJGI7rL7GczvcCZOjULno9
   Z/tr8Nt0ocB7/RsK0duvPGqyUmIFzpAO3rTetOvvcWiraWMUqWtQpsFMT
   U=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@zx2c4.com
X-IronPort-AV: E=Sophos;i="5.95,207,1661810400"; 
   d="scan'208";a="67942862"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Oct 2022 22:09:42 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 31024E013D; Sun, 23 Oct 2022 22:09:42 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id C8885E0130
	for <cocci@sympa.inria.fr>; Sun, 23 Oct 2022 21:59:19 +0200 (CEST)
IronPort-SDR: 63559d17_fwW8AhApIL1lqOlZb0fXGj7maWLxlBUXJOeUETQkd4uLNeq
 CId+2dzLIJOnGfNIICx4QhmB1dsxCoelfgLUUAg==
X-IPAS-Result: =?us-ascii?q?A0BwAgDFm1VjkNlUsotaHgEBCxIMQIN8gQFWLgQLRQOES?=
 =?us-ascii?q?4h+iBkDaZ5AAQMBDTkLBAEBghKHZgIdBwEENBMBAgQBAQEBAwIDAQEBAQEBA?=
 =?us-ascii?q?wEBBQEBAQIBAQIEBAETAQEBAQEBFgkeHgUihWgNgjUpAYNkAQUjHQEBNwEPC?=
 =?us-ascii?q?xgCAiYCAhBHBhMbgmIBgyADAw2rO4EygQGCCAEBBoFAAYEfhA1+AwaBESyPY?=
 =?us-ascii?q?XongimEPz6CS4VQgmaVVjgDRB1AAws7Mg1RHFgOCR8cDhcNBQYSAyBuBUEPK?=
 =?us-ascii?q?C9nKxwbB4EMKigVAwQEAwIGEwMiAg0pMRQEKRMPLQcjcQkCAyFlBQMDBCgsA?=
 =?us-ascii?q?wkhHwclJDwHWDoBBAMCECI8BgMJAwIkV4EkJgUDDRclCAVOBAg6AgUGUhICC?=
 =?us-ascii?q?hEDEg8GJ0cOSj45FgYnRAE0Dw4WA2OXAoElcoE7L3F/WMBXgTUHA4Nig06Hd?=
 =?us-ascii?q?5UCMpZqkieXIY1BmjOBeSOBW3CDNxIBOxwPiEuFVYNyhRSFTD80AgE4AgYLA?=
 =?us-ascii?q?QEDCYpeAQE?=
IronPort-PHdr: A9a23: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
 zYkmlF1PaIm8zK+uz8K
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:qOD6HK0Cth4j5Z03gCt+wAqjBLUkLtp133Aq2lEZdPU0SKGlfg
 6V7ZcmPDvP+U8ssRAb6La90cy7LU80mqQa3WB8B9aftUzdyROVxeJZnOzfKl/bakjDH4dmvM
 8KGcdD4Z/LfDxHZK3BkWuF+rgboOW6zA==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.95,207,1661810400"; 
   d="scan'208";a="33212602"
X-MGA-submission: =?us-ascii?q?MDH+JRxxcZzcXkDIuhvbJNcZIJgaXcrThx2q6Z?=
 =?us-ascii?q?Pq7X+FIVLYDdUpR3IVHV+Px/C7sfC5jGFvVTGafDXTfT2AYgYTDh/M+R?=
 =?us-ascii?q?F5ceA6Axquzp/bYG+ov5GuG6pXZQtLfYDbb7TVZvdMWGdvFbaA1cVbhj?=
 =?us-ascii?q?q78GqPqHiRW6nggzN14AGJSg=3D=3D?=
Received: from dfw.source.kernel.org ([139.178.84.217])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2022 21:59:18 +0200
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id D670960F4F;
	Sun, 23 Oct 2022 19:59:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE218C433D6;
	Sun, 23 Oct 2022 19:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1666555154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oAw83aa23W5jQO4zMD6j3/doCvGx1C5w03aSzbT6xPs=;
	b=b0yVxChbvq7mz3ABFKCeYpLxja2Y9i6Hxyy9MeXhBMtSydaDI0kKguq6QQleLPPy5VB1wQ
	LYTqtSBlwWkWH1QLqfdMgQZNXD56Vx20fPZ0+SKdjT4SAEHykILxzBBjKgRLUK66iXwJAV
	uVO9XhOM5nLBsgxFXqleeEvZwsrbjdc=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ff6264c7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sun, 23 Oct 2022 19:59:14 +0000 (UTC)
Date: Sun, 23 Oct 2022 21:59:11 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Markus Elfring <Markus.Elfring@web.de>, cocci@inria.fr
Message-ID: <Y1WdD/fxtmZwtxrn@zx2c4.com>
References: <CAHmME9rTWvUxsM-sFZh1r+D5gb-8rbHmeWiFEfobkjxDRrZO1Q@mail.gmail.com>
 <alpine.DEB.2.22.394.2210200705030.2988@hadrien>
 <CAHmME9p7nTuAOS87NYKhbhh1rF-XJBkuWjjmHbrkiJUrth5XHQ@mail.gmail.com>
 <trinity-3c34f082-c650-4c08-9ff9-f746f20e4183-1666533323595@3c-app-webde-bap48>
 <Y1WYWT0xU5hv1Gr9@zx2c4.com>
 <alpine.DEB.2.22.394.2210232143500.94971@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2210232143500.94971@hadrien>
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] algebraic simplification possibilities with SmPL
Reply-To: "Jason A. Donenfeld" <Jason@zx2c4.com>
X-Loop: cocci@inria.fr
X-Sequence: 679
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/Y1WdD%2FfxtmZwtxrn%40zx2c4.com>

On Sun, Oct 23, 2022 at 09:45:42PM +0200, Julia Lawall wrote:
> 
> 
> On Sun, 23 Oct 2022, Jason A. Donenfeld wrote:
> 
> > On Sun, Oct 23, 2022 at 03:55:23PM +0200, Markus Elfring wrote:
> > > > There's another one in that series that's kind of interesting:
> > > >
> > > > https://lore.kernel.org/lkml/20221022014403.3881893-6-Jason@zx2c4.com/
> > > >
> > > > This one has a very simple rule:
> > > >
> > > > @@
> > > > expression H;
> > > > expression L;
> > > > @@
> > > > - (get_random_u32_below(H) + L)
> > > > + get_random_u32_between(L, H + L)
> > > >
> > > > This worked as expected, but I had to do a lot of hand simplification.
> > > > For example, a lot of code had a pattern of:
> > > >
> > > > get_random_u32_below(H - L + 1) + L
> > > >
> > > > which then got converted into
> > > >
> > > > get_random_u32_between(L, H - L + 1 + L)
> > > >
> > > > which I then had to clean up manually into
> > > >
> > > > get_random_u32_between(L, H + 1)
> > > >
> > > > It's not like that's all that hard to do. But it would be cool if
> > > > Cocinnelle had some sort of algebraic simplification possibility.
> > >
> > > I imagine also that it will occasionally be nicer if further optimisation
> > > rules would belong to the standard functionality of the Coccinelle software.
> > > But I guess that you can achieve desirable transformations also by using
> > > additional rules for the semantic patch language.
> > >
> > > How do you think about a change approach like the following?
> > >
> > > @cleanup@
> > > identifier H, L;
> > > @@
> > >  get_random_u32_between(L,
> > >                         H
> > > -                         - L
> > >                           + 1
> > > -                         + L
> > >                        )
> > >
> >
> > I can do something like that. These seem to work:
> >
> > @@
> > expression H;
> > expression L;
> > @@
> > - (get_random_u32_below(H) + L)
> > + get_random_u32_between(L, H + L)
> >
> > @@
> > expression H;
> > expression L;
> > expression E;
> > @@
> >   get_random_u32_between(L,
> >   H
> > - + E
> > - - E
> >   )
> >
> > @@
> > expression H;
> > expression L;
> > expression E;
> > @@
> >   get_random_u32_between(L,
> >   H
> > - - E
> > - + E
> >   )
> >
> > @@
> > expression H;
> > expression L;
> > expression E;
> > expression F;
> > @@
> >   get_random_u32_between(L,
> >   H
> > - - E
> >   + F
> > - + E
> >   )
> >
> > @@
> > expression H;
> > expression L;
> > expression E;
> > expression F;
> > @@
> >   get_random_u32_between(L,
> >   H
> > - + E
> >   + F
> > - - E
> >   )
> >
> >
> > Kind of annoying that Coccinelle doesn't do commutativity itself, but
> > that's fine.
> 
> The parse tree is probably not what you would hope it to be.  It's
> probably, eg:
> 
> (a + b) + c
> 
> so it's not straightforward to exchange b and c, without considering lots
> of special cases.

The general solution might be a pass that removes parens when they don't
influence the order of operations?

Jason
