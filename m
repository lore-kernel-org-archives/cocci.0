Return-Path: <SRS0=l37a=DC=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1667BC4363D
	for <cocci@archiver.kernel.org>; Fri, 25 Sep 2020 07:51:25 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF0F32084C
	for <cocci@archiver.kernel.org>; Fri, 25 Sep 2020 07:51:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF0F32084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08P7opu5019616;
	Fri, 25 Sep 2020 09:50:51 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E10E2778D;
	Fri, 25 Sep 2020 09:50:50 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B5AD94316
 for <cocci@systeme.lip6.fr>; Fri, 25 Sep 2020 09:50:48 +0200 (CEST)
Received: from smtprelay.hostedemail.com (smtprelay0158.hostedemail.com
 [216.40.44.158])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08P7olb7022012
 for <cocci@systeme.lip6.fr>; Fri, 25 Sep 2020 09:50:48 +0200 (CEST)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave06.hostedemail.com (Postfix) with ESMTP id 79FD0800CF2E
 for <cocci@systeme.lip6.fr>; Thu, 24 Sep 2020 22:23:45 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay06.hostedemail.com (Postfix) with ESMTP id 67C1118224D82;
 Thu, 24 Sep 2020 22:23:42 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: space69_45180fb27162
X-Filterd-Recvd-Size: 3682
Received: from XPS-9350.home (unknown [47.151.133.149])
 (Authenticated sender: joe@perches.com)
 by omf03.hostedemail.com (Postfix) with ESMTPA;
 Thu, 24 Sep 2020 22:23:40 +0000 (UTC)
Message-ID: <a53048f738dacc1c58654eb94e229de79d4f94c2.camel@perches.com>
From: Joe Perches <joe@perches.com>
To: Thomas Gleixner <tglx@linutronix.de>, Julia Lawall <julia.lawall@inria.fr>
Date: Thu, 24 Sep 2020 15:23:39 -0700
In-Reply-To: <87r1qqvo2d.fsf@nanos.tec.linutronix.de>
References: <87r1qqvo2d.fsf@nanos.tec.linutronix.de>
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 25 Sep 2020 09:50:51 +0200 (CEST)
X-Greylist: Delayed for 06:59:59 by milter-greylist-4.4.3 (isis.lip6.fr
 [132.227.60.2]); Fri, 25 Sep 2020 09:50:48 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Giuseppe Scrivano <gscrivan@redhat.com>,
        Valdis =?UTF-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Andy Whitcroft <apw@shadowen.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        cocci <cocci@systeme.lip6.fr>
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

On Thu, 2020-09-24 at 23:53 +0200, Thomas Gleixner wrote:
> On Thu, Sep 24 2020 at 13:33, Joe Perches wrote:
> > On Thu, 2020-09-24 at 22:19 +0200, Thomas Gleixner wrote:
> > > On Sat, Aug 22 2020 at 09:07, Julia Lawall wrote:
> > > > On Fri, 21 Aug 2020, Joe Perches wrote:
> > > > > True enough for a general statement, though the coccinelle
> > > > > script Julia provided does not change a single instance of
> > > > > for loop expressions with commas.
> > > > > 
> > > > > As far as I can tell, no logic defect is introduced by the
> > > > > script at all.
> > > > 
> > > > The script has a rule to ensure that what is changed is part of a top
> > > > level statement that has the form e1, e2;.  I put that in to avoid
> > > > transforming cases where the comma is the body of a macro, but it protects
> > > > against for loop headers as well.
> > > 
> > > Right. I went through the lot and did not find something dodgy. Except
> > > for two hunks this still applies. Can someone please send a proper patch
> > > with changelog/SOB etc. for this?
> > 
> > Treewide?
> > 
> > Somebody no doubt would complain, but there
> > _really should_ be some mechanism for these
> > trivial and correct treewide changes...
> 
> There are lots of mechanisms:

I've tried them all.

None of them work particularly well,
especially the individual patch route.

>  - Andrew picks such changes up

Generally not treewide.

>  - With a few competent eyeballs on it (reviewers) this can go thorugh
>    the trivial tree as well. It's more than obvious after all.

Jiri is almost non-existent when it comes to
trivial treewide patches.

>  - Send the script to Linus with a proper change log attached and ask
>    him to run it.

Linus has concerns about backports and what he
deems trivialities.  Generally overblown IMO.

>  - In the worst case if nobody feels responsible, I'll take care.

If Julia doesn't send a new patch in the next few
days, I will do the apply, fixup and resend of hers.

So, you're on-deck, nearly up...

> All of the above is better than trying to get the attention of a
> gazillion of maintainters.

True.

And all of the treewide changes depend on some
generic acceptance of value in the type of change.

Some believe that comma->semicolon conversions
aren't useful as there isn't a logical change and
the compiler output wouldn't be different.

Anyway, cheers, Joe


_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
