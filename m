Return-Path: <SRS0=mkCy=TA=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 002EBC43219
	for <cocci@archiver.kernel.org>; Tue, 30 Apr 2019 03:28:01 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 092EB20835
	for <cocci@archiver.kernel.org>; Tue, 30 Apr 2019 03:28:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 092EB20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hofr.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x3U3Rjts009355
          ; Tue, 30 Apr 2019 05:27:45 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id F3265767F;
	Tue, 30 Apr 2019 05:27:44 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B2E673E98
 for <cocci@systeme.lip6.fr>; Tue, 30 Apr 2019 05:27:42 +0200 (CEST)
Received: from mail.osadl.at (178.115.242.59.static.drei.at [178.115.242.59])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x3U3ReNo005247
 for <cocci@systeme.lip6.fr>; Tue, 30 Apr 2019 05:27:41 +0200 (CEST)
X-pt: isis.lip6.fr
Received: by mail.osadl.at (Postfix, from userid 1001)
 id A5CA45C0355; Tue, 30 Apr 2019 05:26:49 +0200 (CEST)
Date: Tue, 30 Apr 2019 05:26:49 +0200
From: Nicholas Mc Guire <der.herr@hofr.at>
To: Julia Lawall <julia.lawall@lip6.fr>
Message-ID: <20190430032649.GA23144@osadl.at>
References: <20190429060512.GA16251@osadl.at>
 <alpine.DEB.2.21.1904291221350.2444@hadrien>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1904291221350.2444@hadrien>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 30 Apr 2019 05:27:45 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 30 Apr 2019 05:27:41 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] detecting false positive sparse with coccinelle
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

On Mon, Apr 29, 2019 at 12:26:49PM -0400, Julia Lawall wrote:
> 
> 
> On Mon, 29 Apr 2019, Nicholas Mc Guire wrote:
> 
> >
> > Hi !
> >
> >  I'm trying to detect false positive sparse messages by taking
> >  the pattern and scanning with coccinelle for it so that the
> >  fix could be generated. Basically the identification seems
> >  to be working (a type-check on var is stil missing - but thats
> >  a different issue) - the problem though is that I'm unable
> >  to insert the (__force __be16) cast in the patch rule as
> >  coccinelle is refusing hose lines. Any hint how that could be
> >  done or is the problem the syntactic oddity of having a
> >  unknown keyworkd followed by a type that is confusing coccinelle
> >  here ?
> 
> Types like this are currently not parsed properly - see the GSoC project.
> I'm not sure that there is a good solution at the moment.  This should be
> parsed OK by the C parser, so you could try passing through python.  See
> python_mdecl.cocci.  It may be necessary to construct the complete
> expression (__force __be16)var in python.
>
ok - so I guess this means the issue applies to all type attributes
then. Using python might be doable but the goal is to not grow the
number of involved tools - there are already too many anyway.
I'll try poking around in coccinelle then - not sure how hard that 
would be to add that - something like an typedef equivalent called
attributedef would be my first guess.

thx!
hofrat 
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
