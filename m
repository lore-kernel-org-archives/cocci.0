Return-Path: <SRS0=ECaW=GD=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9831BC433E0
	for <cocci@archiver.kernel.org>; Thu, 31 Dec 2020 20:42:23 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCEE02079A
	for <cocci@archiver.kernel.org>; Thu, 31 Dec 2020 20:42:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCEE02079A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0BVKfqRD023235;
	Thu, 31 Dec 2020 21:41:52 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 441363A53;
	Thu, 31 Dec 2020 21:41:52 +0100 (CET)
Received: from osiris.lip6.fr (osiris.lip6.fr [132.227.60.30])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id CFCFA373F
 for <cocci@systeme.lip6.fr>; Thu, 31 Dec 2020 21:41:50 +0100 (CET)
Received: from smtprelay.hostedemail.com (smtprelay0160.hostedemail.com
 [216.40.44.160])
 by osiris.lip6.fr (8.15.2/8.15.2) with ESMTPS id 0BVKfkcK028422
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Thu, 31 Dec 2020 21:41:48 +0100 (CET)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay01.hostedemail.com (Postfix) with ESMTP id 6DEDC100E7B44;
 Thu, 31 Dec 2020 20:41:45 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: scarf83_56008ba274b0
X-Filterd-Recvd-Size: 2201
Received: from [192.168.1.159] (unknown [47.151.137.21])
 (Authenticated sender: joe@perches.com)
 by omf06.hostedemail.com (Postfix) with ESMTPA;
 Thu, 31 Dec 2020 20:41:44 +0000 (UTC)
Message-ID: <eaa30016de67722c9595c3233b32b94474280a0a.camel@perches.com>
From: Joe Perches <joe@perches.com>
To: Julia Lawall <julia.lawall@inria.fr>
Date: Thu, 31 Dec 2020 12:41:43 -0800
In-Reply-To: <alpine.DEB.2.22.394.2012312124290.20387@hadrien>
References: <58a84d03b714f71d231f9cac04af09a6b97c6f04.camel@perches.com>
 <cc5722eb472a0a94f3418f6081b10f3c4a7e156d.camel@perches.com>
 <alpine.DEB.2.22.394.2012312124290.20387@hadrien>
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 31 Dec 2020 21:41:52 +0100 (CET)
X-Greylist: Delayed for 00:28:14 by milter-greylist-4.4.3 (osiris.lip6.fr
 [132.227.60.30]); Thu, 31 Dec 2020 21:41:48 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.30
Cc: cocci <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] cocci: missed strlcpy->strscpy conversion?
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

On Thu, 2020-12-31 at 21:27 +0100, Julia Lawall wrote:
> On Thu, 31 Dec 2020, Joe Perches wrote:
> > On Thu, 2020-12-31 at 11:04 -0800, Joe Perches wrote:
> > > strlcpy is deprecated.  see: Documentation/process/deprecated.rst
> > > 
> > > Change the calls that do not use the strlcpy return value to the
> > > preferred strscpy.
> > > 
> > > Done with cocci script:
> > > 
> > > @@
> > > expression e1, e2, e3;
> > > @@
> > > 
> > > -	strlcpy(
> > > +	strscpy(
> > > 	e1, e2, e3);
> > > 
> > > This cocci script leaves the instances where the return value is
> > > used unchanged.
> > 
> > Hey Julia.
> > 
> > After using the cocci script above on a test treewide conversion,
> > there were a few instances with no return use that were not converted.
> > 
> > Any idea why these were not converted?
[]
> The parse is not happy about the for_each_possible_cpu.  It seems that the
> heuristic for detecting that as a loop expects that the body of the loop
> will have braces.  You can see this with the --parse-c option, ie
> 
> spatch --parse-c drivers/block/rnbd/rnbd-clt.c
> 
> The offending line will have BAD in front of it.

Thanks.

Do you consider the for_each heuristic a defect? (I'm not sure I do)

I hope it's time for you to stop working today...

cheers and happy new year,  Joe

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
