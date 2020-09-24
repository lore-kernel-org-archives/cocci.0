Return-Path: <SRS0=fIkn=DB=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762D2C4363D
	for <cocci@archiver.kernel.org>; Thu, 24 Sep 2020 21:54:14 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BD7421D20
	for <cocci@archiver.kernel.org>; Thu, 24 Sep 2020 21:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BjoKxTy1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k3Osk55T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BD7421D20
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08OLrocF012141;
	Thu, 24 Sep 2020 23:53:50 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id AE70D778D;
	Thu, 24 Sep 2020 23:53:50 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 1137B4452
 for <cocci@systeme.lip6.fr>; Thu, 24 Sep 2020 23:53:48 +0200 (CEST)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08OLrklN028652
 for <cocci@systeme.lip6.fr>; Thu, 24 Sep 2020 23:53:46 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1600984426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to; bh=50ls+vBq+FfTMVSndh/JUjpk9M8gYW0WEmaHS52ov8k=;
 b=BjoKxTy1U6UgZenE4M+pedzTdDBWmjQjQobkRZ5JK4lp1hYD1pfZm3CE/cIgodrnxeCktm
 TdMByqmjJxy4enCTDib0fm6j4Vk6BpKGDfXLwzOeodvasek+5B55/FneJPmWlLppzJ9Mpr
 H1dMhMm9NN4/n+McjtE6vNahwMzEgazKwiuPh5fHdOo2KD98HmawEYn5aLZkQm1EMT3TCa
 D+OmRqgoUd3e43vMDMwycVh/JTdVIWrnY3I440zpS4gzEZXJdiBruez/KOab/1wv7+BhF4
 RT65yv/uHvDsGUuW1DPergoCvEzHnmdO78CKOgwuejWsAfwOMKO9lfNlzG7TSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1600984426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to; bh=50ls+vBq+FfTMVSndh/JUjpk9M8gYW0WEmaHS52ov8k=;
 b=k3Osk55T4BVLeOs/VuJRBYoV8EVmF++pnR29w1CC/rwV5NEARaHvp4iSy1FBHeDCIevC4W
 /AYlGdBVgp8Vq7Dg==
To: Joe Perches <joe@perches.com>, Julia Lawall <julia.lawall@inria.fr>
In-Reply-To: <6d5383a3ec02d89dd05797c3ae158aebdc0c88ae.camel@perches.com>
Date: Thu, 24 Sep 2020 23:53:46 +0200
Message-ID: <87r1qqvo2d.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 24 Sep 2020 23:53:51 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 24 Sep 2020 23:53:47 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Giuseppe Scrivano <gscrivan@redhat.com>,
        Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
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

On Thu, Sep 24 2020 at 13:33, Joe Perches wrote:
> On Thu, 2020-09-24 at 22:19 +0200, Thomas Gleixner wrote:
>> On Sat, Aug 22 2020 at 09:07, Julia Lawall wrote:
>> > On Fri, 21 Aug 2020, Joe Perches wrote:
>> > > True enough for a general statement, though the coccinelle
>> > > script Julia provided does not change a single instance of
>> > > for loop expressions with commas.
>> > > 
>> > > As far as I can tell, no logic defect is introduced by the
>> > > script at all.
>> > 
>> > The script has a rule to ensure that what is changed is part of a top
>> > level statement that has the form e1, e2;.  I put that in to avoid
>> > transforming cases where the comma is the body of a macro, but it protects
>> > against for loop headers as well.
>> 
>> Right. I went through the lot and did not find something dodgy. Except
>> for two hunks this still applies. Can someone please send a proper patch
>> with changelog/SOB etc. for this?
>
> Treewide?
>
> Somebody no doubt would complain, but there
> _really should_ be some mechanism for these
> trivial and correct treewide changes...

There are lots of mechanisms:

 - Andrew picks such changes up

 - With a few competent eyeballs on it (reviewers) this can go thorugh
   the trivial tree as well. It's more than obvious after all.

 - Send the script to Linus with a proper change log attached and ask
   him to run it.

 - In the worst case if nobody feels responsible, I'll take care.

All of the above is better than trying to get the attention of a
gazillion of maintainters.

Thanks,

        tglx
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
