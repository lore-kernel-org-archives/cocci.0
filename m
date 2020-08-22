Return-Path: <SRS0=Y/+4=CA=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4892C433DF
	for <cocci@archiver.kernel.org>; Sat, 22 Aug 2020 01:08:39 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31A9A207CD
	for <cocci@archiver.kernel.org>; Sat, 22 Aug 2020 01:08:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31A9A207CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 07M18J2W029125;
	Sat, 22 Aug 2020 03:08:19 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id C92DF758C;
	Sat, 22 Aug 2020 03:08:19 +0200 (CEST)
Received: from osiris.lip6.fr (osiris.lip6.fr [132.227.60.30])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 530614173
 for <cocci@systeme.lip6.fr>; Sat, 22 Aug 2020 03:08:17 +0200 (CEST)
Received: from smtprelay.hostedemail.com (smtprelay0219.hostedemail.com
 [216.40.44.219])
 by osiris.lip6.fr (8.15.2/8.15.2) with ESMTPS id 07M18El0025753
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Sat, 22 Aug 2020 03:08:15 +0200 (CEST)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay01.hostedemail.com (Postfix) with ESMTP id 88C7D100E7B45;
 Sat, 22 Aug 2020 01:08:11 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: wound83_2f0234b2703d
X-Filterd-Recvd-Size: 5026
Received: from XPS-9350.home (unknown [47.151.133.149])
 (Authenticated sender: joe@perches.com)
 by omf13.hostedemail.com (Postfix) with ESMTPA;
 Sat, 22 Aug 2020 01:08:09 +0000 (UTC)
Message-ID: <744af177c09f8ce22c99d6e1df458bced558518b.camel@perches.com>
From: Joe Perches <joe@perches.com>
To: Julia Lawall <julia.lawall@inria.fr>,
        kernel-janitors
 <kernel-janitors@vger.kernel.org>,
        kernelnewbies
 <kernelnewbies@kernelnewbies.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Date: Fri, 21 Aug 2020 18:08:08 -0700
In-Reply-To: <alpine.DEB.2.22.394.2008201856110.2524@hadrien>
References: <20200818184107.f8af232fb58b17160c570874@linux-foundation.org>
 <3bf27caf462007dfa75647b040ab3191374a59de.camel@perches.com>
 <b0fd63e4b379eda69ee85ab098353582b8c054bb.camel@perches.com>
 <alpine.DEB.2.22.394.2008201021400.2524@hadrien>
 <a5713d8597065ef986f780499428fcc4cd31c003.camel@perches.com>
 <alpine.DEB.2.22.394.2008201856110.2524@hadrien>
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 22 Aug 2020 03:08:20 +0200 (CEST)
X-Greylist: Delayed for 49:54:52 by milter-greylist-4.4.3 (osiris.lip6.fr
 [132.227.60.30]); Sat, 22 Aug 2020 03:08:15 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.30
Cc: Giuseppe Scrivano <gscrivan@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@shadowen.org>, cocci <cocci@systeme.lip6.fr>,
        LKML <linux-kernel@vger.kernel.org>
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

(forwarding on to kernel-janitors/mentees and kernelnewbies)

Just fyi for anyone that cares:

A janitorial task for someone might be to use Julia's coccinelle
script below to convert the existing instances of commas that
separate statements into semicolons.

https://lore.kernel.org/lkml/alpine.DEB.2.22.394.2008201856110.2524@hadrien/

On Thu, 2020-08-20 at 19:03 +0200, Julia Lawall wrote:
> > > I have a bunch of variations of this that are more complicated than I
> > > would have expected.  One shorter variant that I have is:
> > > 
> > > @@
> > > expression e1,e2;
> > > statement S;
> > > @@
> > > 
> > >  S
> > >  e1
> > > -,
> > > +;
> > >   (<+... e2 ...+>);
> > > 
> > > This will miss cases where the first statement is the comma thing.  But I
> > > think it is possible to improve this now.  I will check.
> > 
> > Hi Julia.
> > 
> > Right, thanks, this adds a dependency on a statement
> > before the expression.  Any stragglers would be easily
> > found using slightly different form.
> > There are not very many of these in linux kernel.
> > 
> > Another nicety would be to allow the s/,/;/ conversion to
> > find both b and c in this sequence:
> > 	a = 1;
> > 	b = 2,
> > 	c = 3,
> > 	d = 4;
> > without running the script multiple times.
> > There are many dozen uses of this style in linux kernel.
> > 
> > I tried variants of adding a comma after the e2 expression,
> > but cocci seems to have parsing problems with:
> > 
> > @@
> > expression e1;
> > expression e2;
> > @@
> > 	e1
> > -	,
> > +	;
> > 	e2,
> 
> This doesn't work because it's not a valid expression.
> 
> The problem is solved by doing:
> 
>   e1
> - ,
> + ;
>   e2
>   ... when any
> 
> But that doesn't work in the current version of Coccinelle.  I have fixed
> the problem, though and it will work shortly.
> 
> > I do appreciate that coccinelle adds braces for multiple
> > expression comma use after an if.
> > 
> > i.e.:
> > 	if (foo)
> > 		a = 1, b = 2;
> > becomes
> > 	if (foo) {
> > 		a = 1; b = 2;
> > 	}
> 
> I wasn't sure what was wanted for such things.  Should b = 2 now be on a
> separate line?
> 
> I took the strategy of avoiding the problem and leaving those cases as is.
> That also solves the LIST_HEAD problem.  But if it is wanted to change
> these commas under ifs, then that is probably possible too.
> 
> My current complete solution is as follows.  The first rule avoids changing
> commas in macros, where thebody of the macro is just an expression.  The
> second rule uses position variables to ensure that the two expression are
> on different lines.
> 
> @r@
> expression e1,e2;
> statement S;
> position p;
> @@
> 
> e1 ,@S@p e2;
> 
> @@
> expression e1,e2;
> position p1;
> position p2 :
>     script:ocaml(p1) { not((List.hd p1).line_end = (List.hd p2).line) };
> statement S;
> position r.p;
> @@
> 
> e1@p1
> -,@S@p
> +;
> e2@p2
> ... when any
> 
> The generated patch is below.
> 
> julia
> 
> diff -u -p a/drivers/reset/hisilicon/reset-hi3660.c b/drivers/reset/hisilicon/reset-hi3660.c
> --- a/drivers/reset/hisilicon/reset-hi3660.c
> +++ b/drivers/reset/hisilicon/reset-hi3660.c
> @@ -89,7 +89,7 @@ static int hi3660_reset_probe(struct pla
>  		return PTR_ERR(rc->map);
>  	}
> 
> -	rc->rst.ops = &hi3660_reset_ops,
> +	rc->rst.ops = &hi3660_reset_ops;
>  	rc->rst.of_node = np;
>  	rc->rst.of_reset_n_cells = 2;
>  	rc->rst.of_xlate = hi3660_reset_xlate;

The rest of the changes are in the link above...


_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
