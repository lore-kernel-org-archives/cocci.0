Return-Path: <SRS0=mXBt=CM=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589BCC433E2
	for <cocci@archiver.kernel.org>; Thu,  3 Sep 2020 16:35:36 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BADEC20578
	for <cocci@archiver.kernel.org>; Thu,  3 Sep 2020 16:35:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BADEC20578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 083GZF7m004178;
	Thu, 3 Sep 2020 18:35:15 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E9680742E;
	Thu,  3 Sep 2020 18:35:14 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B6F006717
 for <cocci@systeme.lip6.fr>; Thu,  3 Sep 2020 18:35:13 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 083GZDtt006785
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Thu, 3 Sep 2020 18:35:13 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.76,359,1592863200"; d="scan'208";a="465969925"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 03 Sep 2020 18:35:05 +0200
Date: Thu, 3 Sep 2020 18:35:05 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Joe Perches <joe@perches.com>
In-Reply-To: <13de187ee83bb6ebffc6e4ff5f1c78d917ba9432.camel@perches.com>
Message-ID: <alpine.DEB.2.22.394.2009031834060.2496@hadrien>
References: <de28becbfe76575b18c0bf47567b7f9c20f15f87.camel@perches.com>
 <alpine.DEB.2.22.394.2008300854510.3629@hadrien>
 <b43fac2f903451dba4d5f4ac010b2ae5bfcad0c4.camel@perches.com>
 <alpine.DEB.2.22.394.2008301021250.3629@hadrien> 
 <bc3215bbf6c217a06dc2ebbf6ddd977c5d57654c.camel@perches.com>
 <alpine.DEB.2.22.394.2008301742400.3629@hadrien>
 <7ce009d5f538feae7a6a20e0bbecdf73d74ea9f9.camel@perches.com>
 <alpine.DEB.2.22.394.2008302039000.3629@hadrien> 
 <ec1cc3309738bf1acab87fcf9178dbf7b204176a.camel@perches.com>
 <alpine.DEB.2.22.394.2009022236330.2460@hadrien>
 <0db493cb85521ee26b7ca7c255e89721cc6b6dcd.camel@perches.com>
 <alpine.DEB.2.22.394.2009031711470.2496@hadrien>
 <13de187ee83bb6ebffc6e4ff5f1c78d917ba9432.camel@perches.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 03 Sep 2020 18:35:15 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 03 Sep 2020 18:35:13 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] transform oddity / bug ?
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



On Thu, 3 Sep 2020, Joe Perches wrote:

> On Thu, 2020-09-03 at 17:14 +0200, Julia Lawall wrote:
> > On Wed, 2 Sep 2020, Joe Perches wrote:
> > > On Wed, 2020-09-02 at 22:46 +0200, Julia Lawall wrote:
> > > > On Wed, 2 Sep 2020, Joe Perches wrote:
> > > > > On Sun, 2020-08-30 at 20:41 +0200, Julia Lawall wrote:
> > > > > > On Sun, 30 Aug 2020, Joe Perches wrote:
> > > > > > > On Sun, 2020-08-30 at 17:46 +0200, Julia Lawall wrote:
> > > > > > > > Unfortunately this does not work when the declaration
> > > > > > > is comma terminated and not semicolon terminated.
> > > > > []
> > > > > > I will have to look into it.  It should handle this sort of thing, but it
> > > > > > is somewhat complex, because the declarations have to be split and this
> > > > > > specific case may not be handled.
> > > > >
> > > > > Thanks.  Hope you can get to look at that one day.
> >
> > It works if you replace the addition of the new declaration by ++.  It
> > seems that it is concerned that if there are multiple variables in the
> > original declaration then it may be necessary to do multiple additions and
> > so it doesn't do anything for a single +.  You can see this information
> > with the --debug option.
>
> Thanks, works now.
>
> > The newlines in the generated code are also not what one would hope for.
> > I will see if this can be improved.
>
> One day.
>
> It's not urgent for me as all the proposed changes
> would need to be checked manually and the rename can
> cause other alignment issues around not just the
> definition changes but in code too.
>
> e.g.:
> 	written = sysfs_emit(buf,
> 			     "foo", bar...);
> becomes
> 	len = sysfs_emit(buf,
> 			     "foo", bar...);

If you remove and put back the argument list, perhaps with an expression
list metavariable, if you don't know how many arguments there are,
Coccinelle should clean this up for yout.

julia

>
> I have other scripts that can fix both the definition
> and the alignment changes done by coccinelle.
>
> cheers, Joe
>
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
