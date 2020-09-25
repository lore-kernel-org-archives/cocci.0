Return-Path: <SRS0=l37a=DC=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57176C4363D
	for <cocci@archiver.kernel.org>; Fri, 25 Sep 2020 17:06:59 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AA5720936
	for <cocci@archiver.kernel.org>; Fri, 25 Sep 2020 17:06:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AA5720936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08PH6VsR006646;
	Fri, 25 Sep 2020 19:06:31 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 6629A778D;
	Fri, 25 Sep 2020 19:06:31 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id CF9264316
 for <cocci@systeme.lip6.fr>; Fri, 25 Sep 2020 19:06:28 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08PH6SiD018192
 for <cocci@systeme.lip6.fr>; Fri, 25 Sep 2020 19:06:28 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.77,302,1596492000"; d="scan'208";a="360082879"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 25 Sep 2020 19:06:21 +0200
Date: Fri, 25 Sep 2020 19:06:20 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Joe Perches <joe@perches.com>
In-Reply-To: <a53048f738dacc1c58654eb94e229de79d4f94c2.camel@perches.com>
Message-ID: <alpine.DEB.2.22.394.2009251904540.2772@hadrien>
References: <87r1qqvo2d.fsf@nanos.tec.linutronix.de>
 <a53048f738dacc1c58654eb94e229de79d4f94c2.camel@perches.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 25 Sep 2020 19:06:32 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 25 Sep 2020 19:06:28 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Giuseppe Scrivano <gscrivan@redhat.com>,
        =?UTF-8?Q?Valdis_Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, cocci <cocci@systeme.lip6.fr>,
        Andy Whitcroft <apw@shadowen.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Cocci] coccinelle: Convert comma to semicolons (was Re:
 [PATCH] checkpatch: Add test for comma use that should be semicolon)
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



On Thu, 24 Sep 2020, Joe Perches wrote:

> On Thu, 2020-09-24 at 23:53 +0200, Thomas Gleixner wrote:
> > On Thu, Sep 24 2020 at 13:33, Joe Perches wrote:
> > > On Thu, 2020-09-24 at 22:19 +0200, Thomas Gleixner wrote:
> > > > On Sat, Aug 22 2020 at 09:07, Julia Lawall wrote:
> > > > > On Fri, 21 Aug 2020, Joe Perches wrote:
> > > > > > True enough for a general statement, though the coccinelle
> > > > > > script Julia provided does not change a single instance of
> > > > > > for loop expressions with commas.
> > > > > >
> > > > > > As far as I can tell, no logic defect is introduced by the
> > > > > > script at all.
> > > > >
> > > > > The script has a rule to ensure that what is changed is part of a top
> > > > > level statement that has the form e1, e2;.  I put that in to avoid
> > > > > transforming cases where the comma is the body of a macro, but it protects
> > > > > against for loop headers as well.
> > > >
> > > > Right. I went through the lot and did not find something dodgy. Except
> > > > for two hunks this still applies. Can someone please send a proper patch
> > > > with changelog/SOB etc. for this?
> > >
> > > Treewide?
> > >
> > > Somebody no doubt would complain, but there
> > > _really should_ be some mechanism for these
> > > trivial and correct treewide changes...
> >
> > There are lots of mechanisms:
>
> I've tried them all.
>
> None of them work particularly well,
> especially the individual patch route.
>
> >  - Andrew picks such changes up
>
> Generally not treewide.
>
> >  - With a few competent eyeballs on it (reviewers) this can go thorugh
> >    the trivial tree as well. It's more than obvious after all.
>
> Jiri is almost non-existent when it comes to
> trivial treewide patches.
>
> >  - Send the script to Linus with a proper change log attached and ask
> >    him to run it.
>
> Linus has concerns about backports and what he
> deems trivialities.  Generally overblown IMO.
>
> >  - In the worst case if nobody feels responsible, I'll take care.
>
> If Julia doesn't send a new patch in the next few
> days, I will do the apply, fixup and resend of hers.
>
> So, you're on-deck, nearly up...
>
> > All of the above is better than trying to get the attention of a
> > gazillion of maintainters.
>
> True.
>
> And all of the treewide changes depend on some
> generic acceptance of value in the type of change.
>
> Some believe that comma->semicolon conversions
> aren't useful as there isn't a logical change and
> the compiler output wouldn't be different.

I have a script that will cut up the patches and send them to the
appropriate maintainers, so I have no problem with that route.

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
