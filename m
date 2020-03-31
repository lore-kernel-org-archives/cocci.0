Return-Path: <SRS0=cR8/=5Q=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D11C43331
	for <cocci@archiver.kernel.org>; Tue, 31 Mar 2020 10:22:28 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D15D208E4
	for <cocci@archiver.kernel.org>; Tue, 31 Mar 2020 10:22:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D15D208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02VAMAFO014007;
	Tue, 31 Mar 2020 12:22:10 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E2D0C7822;
	Tue, 31 Mar 2020 12:22:09 +0200 (CEST)
Received: from osiris.lip6.fr (osiris.lip6.fr [132.227.60.30])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 6D90E780F
 for <cocci@systeme.lip6.fr>; Tue, 31 Mar 2020 12:22:08 +0200 (CEST)
Received: from smtprelay.hostedemail.com (smtprelay0022.hostedemail.com
 [216.40.44.22])
 by osiris.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02VAM61n017471
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Tue, 31 Mar 2020 12:22:07 +0200 (CEST)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave07.hostedemail.com (Postfix) with ESMTP id 52DD5180388FE
 for <cocci@systeme.lip6.fr>; Tue, 31 Mar 2020 09:04:41 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay07.hostedemail.com (Postfix) with ESMTP id F2265181D2077;
 Tue, 31 Mar 2020 09:04:37 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: part09_45710aadc8c46
X-Filterd-Recvd-Size: 1847
Received: from XPS-9350.home (unknown [47.151.136.130])
 (Authenticated sender: joe@perches.com)
 by omf17.hostedemail.com (Postfix) with ESMTPA;
 Tue, 31 Mar 2020 09:04:36 +0000 (UTC)
Message-ID: <471262a54c6919efe62917ec2beb43e6bd45e0b1.camel@perches.com>
From: Joe Perches <joe@perches.com>
To: Julia Lawall <julia.lawall@inria.fr>
Date: Tue, 31 Mar 2020 02:02:42 -0700
In-Reply-To: <alpine.DEB.2.21.2003311048341.3188@hadrien>
References: <f8581a548767a5d7e460816f125566fca8694aa0.camel@perches.com>
 <alpine.DEB.2.21.2003311048341.3188@hadrien>
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 31 Mar 2020 12:22:10 +0200 (CEST)
X-Greylist: Delayed for 00:40:02 by milter-greylist-4.4.3 (osiris.lip6.fr
 [132.227.60.30]); Tue, 31 Mar 2020 12:22:07 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.30
Cc: cocci <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] linux: bad logic in repetitive tests
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

On Tue, 2020-03-31 at 10:50 +0200, Julia Lawall wrote:
> On Mon, 30 Mar 2020, Joe Perches wrote:
> 
> > There is a block of if tests against the same variable
> > in include/linux/mtd/pfow.h that likely is defective
> > 
> >         if (prog_status & 0x3)
> >                 ...
> >         else if (prog_status & 0x2)
> >                 ...
> >         else (prog_status & 0x1)
> >                 ...
> > 
> > If the first test is true the subsequent 2 tests aren't
> > possible.
> > 
> > Likely the first test should be something like
> > 
> > 	if ((prog_status & 0x03) == 0x03)
> > 
> > Is there a way for cocci to find this style of bitwise
> > logic defect?
> 
> I guess this occurs rarely enough that just looking for a succession of
> bit and tests on the same variable would be good enough to narrow it down
> to something manageable to check by hand.

I suppose, but I think misuse of the and'ed bits
by #define is the most likely defect as it's
very difficult to verify visually.

Hard to otherwise quantify.

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
