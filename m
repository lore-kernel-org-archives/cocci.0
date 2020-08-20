Return-Path: <SRS0=/h8Y=B6=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78206C433DF
	for <cocci@archiver.kernel.org>; Thu, 20 Aug 2020 16:53:12 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5A072072D
	for <cocci@archiver.kernel.org>; Thu, 20 Aug 2020 16:53:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5A072072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 07KGqrfD002972;
	Thu, 20 Aug 2020 18:52:53 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 65268758C;
	Thu, 20 Aug 2020 18:52:53 +0200 (CEST)
Received: from osiris.lip6.fr (osiris.lip6.fr [132.227.60.30])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 6202B428B
 for <cocci@systeme.lip6.fr>; Thu, 20 Aug 2020 18:52:51 +0200 (CEST)
Received: from smtprelay.hostedemail.com (smtprelay0253.hostedemail.com
 [216.40.44.253])
 by osiris.lip6.fr (8.15.2/8.15.2) with ESMTPS id 07KGqnHl022212
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Thu, 20 Aug 2020 18:52:50 +0200 (CEST)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave06.hostedemail.com (Postfix) with ESMTP id E522B8124C85
 for <cocci@systeme.lip6.fr>; Thu, 20 Aug 2020 16:52:47 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay07.hostedemail.com (Postfix) with ESMTP id 2A044181D3028;
 Thu, 20 Aug 2020 16:52:44 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: sense41_180e31f27032
X-Filterd-Recvd-Size: 4180
Received: from XPS-9350.home (unknown [47.151.133.149])
 (Authenticated sender: joe@perches.com)
 by omf20.hostedemail.com (Postfix) with ESMTPA;
 Thu, 20 Aug 2020 16:52:42 +0000 (UTC)
Message-ID: <a5713d8597065ef986f780499428fcc4cd31c003.camel@perches.com>
From: Joe Perches <joe@perches.com>
To: Julia Lawall <julia.lawall@inria.fr>
Date: Thu, 20 Aug 2020 09:52:41 -0700
In-Reply-To: <alpine.DEB.2.22.394.2008201021400.2524@hadrien>
References: <20200818184107.f8af232fb58b17160c570874@linux-foundation.org>
 <3bf27caf462007dfa75647b040ab3191374a59de.camel@perches.com>
 <b0fd63e4b379eda69ee85ab098353582b8c054bb.camel@perches.com>
 <alpine.DEB.2.22.394.2008201021400.2524@hadrien>
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 20 Aug 2020 18:52:53 +0200 (CEST)
X-Greylist: Delayed for 16:29:27 by milter-greylist-4.4.3 (osiris.lip6.fr
 [132.227.60.30]); Thu, 20 Aug 2020 18:52:50 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.30
Cc: Giuseppe Scrivano <gscrivan@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Julia Lawall <julia.lawall@lip6.fr>, Andy Whitcroft <apw@shadowen.org>,
        Andrew Morton <akpm@linux-foundation.org>,
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

On Thu, 2020-08-20 at 10:33 +0200, Julia Lawall wrote:
> On Wed, 19 Aug 2020, Joe Perches wrote:
> > On Wed, 2020-08-19 at 14:22 -0700, Joe Perches wrote:
> > > There are commas used as statement terminations that should typically
> > > have used semicolons instead.  Only direct assignments or use of a single
> > > function or value on a single line are detected by this test.
> > > 
> > > e.g.:
> > > 	foo = bar(),		/* typical use is semicolon not comma */
> > > 	bar = baz();
> > > 
> > > Add an imperfect test to detect these comma uses.
> > > 
> > > No false positives were found in testing, but many types of false negatives
> > > are possible.
> > > 
> > > e.g.:
> > > 	foo = bar() + 1,	/* comma use, but not direct assignment */
> > > 	bar = baz();
> > 
> > Hi.
> > 
> > I recently added a test for this condition to linux's checkpatch.
> > 
> > A similar coccinelle script might be:
> > 
> > $ cat comma.cocci
> > @@
> > expression e1;
> > expression e2;
> > @@
> > 
> > 	e1
> > -	,
> > +	;
> > 	e2;
> > $
> > 
> > This works reasonably well but it has several false positives
> > for declarations like:
> > 
> > $ spatch --sp-file comma.cocci mm/huge_memory.c
> > diff -u -p a/huge_memory.c b/huge_memory.c
> > --- a/huge_memory.c
> > +++ b/huge_memory.c
> > @@ -2778,7 +2778,7 @@ static unsigned long deferred_split_scan
> >  	struct pglist_data *pgdata = NODE_DATA(sc->nid);
> >  	struct deferred_split *ds_queue = &pgdata->deferred_split_queue;
> >  	unsigned long flags;
> > -	LIST_HEAD(list), *pos, *next;
> > +	LIST_HEAD(list), *pos; *next;
> >  	struct page *page;
> >  	int split = 0;
> > $
> > 
> > Any script improvement suggestions?
> 
> I have a bunch of variations of this that are more complicated than I
> would have expected.  One shorter variant that I have is:
> 
> @@
> expression e1,e2;
> statement S;
> @@
> 
>  S
>  e1
> -,
> +;
>   (<+... e2 ...+>);
> 
> This will miss cases where the first statement is the comma thing.  But I
> think it is possible to improve this now.  I will check.

Hi Julia.

Right, thanks, this adds a dependency on a statement
before the expression.  Any stragglers would be easily
found using slightly different form.
There are not very many of these in linux kernel.

Another nicety would be to allow the s/,/;/ conversion to
find both b and c in this sequence:
	a = 1;
	b = 2,
	c = 3,
	d = 4;
without running the script multiple times.
There are many dozen uses of this style in linux kernel.

I tried variants of adding a comma after the e2 expression,
but cocci seems to have parsing problems with:

@@
expression e1;
expression e2;
@@
	e1
-	,
+	;
	e2,

I do appreciate that coccinelle adds braces for multiple
expression comma use after an if.

i.e.:
	if (foo)
		a = 1, b = 2;
becomes
	if (foo) {
		a = 1; b = 2;
	}

There are a few dozen uses of this style in linux kernel.


_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
