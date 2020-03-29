Return-Path: <SRS0=tDau=5O=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E78C9C43331
	for <cocci@archiver.kernel.org>; Sun, 29 Mar 2020 09:20:38 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4606B206CC
	for <cocci@archiver.kernel.org>; Sun, 29 Mar 2020 09:20:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4606B206CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02T9KI8O013981;
	Sun, 29 Mar 2020 11:20:18 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 4DB637750;
	Sun, 29 Mar 2020 11:20:18 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id E64F766CB
 for <cocci@systeme.lip6.fr>; Sun, 29 Mar 2020 11:20:16 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02T9KGJt016222
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 29 Mar 2020 11:20:16 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.72,319,1580770800"; d="scan'208";a="442804953"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 29 Mar 2020 11:20:15 +0200
Date: Sun, 29 Mar 2020 11:20:15 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: =?ISO-8859-15?Q?Christoph_B=F6hmwalder?= <christoph.boehmwalder@linbit.com>
In-Reply-To: <2a36722e-c5ff-aa94-fac1-d885b89176d0@linbit.com>
Message-ID: <alpine.DEB.2.21.2003291118410.2990@hadrien>
References: <b86347f3-69d3-0801-c91f-87c3424e71dc@linbit.com>
 <alpine.DEB.2.21.2003271645370.2709@hadrien>
 <1f1a7b29-b767-551c-e2ec-d5cdf5ceecd0@linbit.com>
 <alpine.DEB.2.21.2003271714150.2709@hadrien>
 <2a36722e-c5ff-aa94-fac1-d885b89176d0@linbit.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-241838555-1585473616=:2990"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 29 Mar 2020 11:20:18 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 29 Mar 2020 11:20:16 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Matching against a declarer macro
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

--8323329-241838555-1585473616=:2990
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sun, 29 Mar 2020, Christoph Böhmwalder wrote:

> Am 27.03.20 um 17:15 schrieb Julia Lawall:
> >
> >
> > On Fri, 27 Mar 2020, Christoph Böhmwalder wrote:
> >
> > > Am 27.03.20 um 16:47 schrieb Julia Lawall:> Are you sure that the C code
> > > is
> > > parsed successfully?  I'm not at all sure
> > > > that static is allowed in an argument list.  Types are allowed, bu
> > > > static
> > > > is only part of a type.
> > >
> > > I'm pretty sure it is parsed successfully. At least spatch doesn't
> > > complain
> > > about it, no matter how many debug flags I specify.
> >
> > Did you try spatch --parse-c file.c?
>
> It seems like RB_DECLARE_CALLBACKS_MAX is recognized as a "known macro"? Looks
> like it is able to parse this bit of code just fine:
>
> $ spatch --parse-c drbd/drbd_interval.c --debug
> init_defs_builtins: /usr/local/bin/../lib/coccinelle/standard.h
>
> PARSING: drbd/drbd_interval.c
> parse error
>  = error in drbd/drbd_interval.h; set verbose_parsing for more info
> badcount: 5
> bad:                                    unsigned int);
> bad:
> bad: #define drbd_for_each_overlap(i, root, sector, size)               \
> bad:    for (i = drbd_find_overlap(root, sector, size);         \
> bad:         i;                                                 \
> BAD:!!!!!            i = drbd_next_overlap(i, sector, size))
> (ONCE) CPP-MACRO: found known macro = RB_DECLARE_CALLBACKS_MAX
> passed:static , augment_callbacks , struct drbd_interval , rb ,
> passed:sector_t , end , NODE_END

It's not parsing anything.  You can see that here.  It is passing, ie
ignoring, the entire command line.

I don't remember the exact situation with this code.  Is there no
semicolon at the end of the macro line?

julia


> -----------------------------------------------------------------------
> maybe 10 most problematic tokens
> -----------------------------------------------------------------------
> -----------------------------------------------------------------------
> NB total files = 1; perfect = 1; pbs = 0; timeout = 0; =========> 100%
> nb good = 160,  nb passed = 2 =========> 1.23% passed
> nb good = 160,  nb bad = 0 =========> 100.00% good or passed
>
> > Do you want to actually match NODE_END?  If so, it shouldn't be declared
> > as a metavariable.
>
> Right, I do want to exactly match NODE_END, so I removed the declaration;
> still no match though. If it is detected as a known macro it should be able to
> be substituted, right?
>
> >
> > julia
> >
>
> Thanks,
> --
> Christoph Böhmwalder
> LINBIT | Keeping the Digital World Running
> DRBD HA —  Disaster Recovery — Software defined Storage
>
--8323329-241838555-1585473616=:2990
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-241838555-1585473616=:2990--
