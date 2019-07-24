Return-Path: <SRS0=DzZf=VV=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCECC7618B
	for <cocci@archiver.kernel.org>; Wed, 24 Jul 2019 12:01:46 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA2A1229ED
	for <cocci@archiver.kernel.org>; Wed, 24 Jul 2019 12:01:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA2A1229ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x6OC1QiB012923;
	Wed, 24 Jul 2019 14:01:26 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id EA52C777C;
	Wed, 24 Jul 2019 14:01:25 +0200 (CEST)
Received: from osiris.lip6.fr (osiris.lip6.fr [132.227.60.30])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7D510420D
 for <cocci@systeme.lip6.fr>; Wed, 24 Jul 2019 14:01:23 +0200 (CEST)
Received: from smtprelay.hostedemail.com (smtprelay0111.hostedemail.com
 [216.40.44.111])
 by osiris.lip6.fr (8.15.2/8.15.2) with ESMTP id x6OC0eda008311
 for <cocci@systeme.lip6.fr>; Wed, 24 Jul 2019 14:00:41 +0200 (CEST)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave06.hostedemail.com (Postfix) with ESMTP id D1F3A80162CC
 for <cocci@systeme.lip6.fr>; Wed, 24 Jul 2019 10:43:27 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay04.hostedemail.com (Postfix) with ESMTP id 423DB180A68A2;
 Wed, 24 Jul 2019 10:43:25 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: lip98_a3a5877a904
X-Filterd-Recvd-Size: 3083
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
 (Authenticated sender: joe@perches.com)
 by omf20.hostedemail.com (Postfix) with ESMTPA;
 Wed, 24 Jul 2019 10:43:24 +0000 (UTC)
Message-ID: <d2b2b528b9f296dfeb1d92554be024245abd678e.camel@perches.com>
From: Joe Perches <joe@perches.com>
To: David Laight <David.Laight@ACULAB.COM>,
        Julia Lawall <julia.lawall@lip6.fr>
Date: Wed, 24 Jul 2019 03:43:22 -0700
In-Reply-To: <563222fbfdbb44daa98078db9d404972@AcuMS.aculab.com>
References: <7ab8957eaf9b0931a59eff6e2bd8c5169f2f6c41.1563841972.git.joe@perches.com>
 <66fcdbf607d7d0bea41edb39e5579d63b62b7d84.camel@perches.com>
 <alpine.DEB.2.21.1907231546090.2551@hadrien>
 <0f3ba090dfc956f5651e6c7c430abdba94ddcb8b.camel@perches.com>
 <alpine.DEB.2.21.1907232252260.2539@hadrien>
 <d5993902fd44ce89915fab94f4db03f5081c3c8e.camel@perches.com>
 <alpine.DEB.2.21.1907232326360.2539@hadrien>
 <f909b4b31f123c7d88535db397a04421077ed0ab.camel@perches.com>
 <563222fbfdbb44daa98078db9d404972@AcuMS.aculab.com>
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 24 Jul 2019 14:01:26 +0200 (CEST)
X-Greylist: Delayed for 12:18:18 by milter-greylist-4.4.3 (osiris.lip6.fr
 [132.227.60.30]); Wed, 24 Jul 2019 14:00:41 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.30
Cc: cocci <cocci@systeme.lip6.fr>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Cocci] [Fwd: [PATCH 1/2] string: Add stracpy and stracpy_pad
 mechanisms]
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

On Wed, 2019-07-24 at 10:28 +0000, David Laight wrote:
> From: Joe Perches
> > Sent: 24 July 2019 05:38
> > On Tue, 2019-07-23 at 23:27 -0500, Julia Lawall wrote:
> > > On Tue, 23 Jul 2019, Joe Perches wrote:
> > > > On Tue, 2019-07-23 at 22:54 -0500, Julia Lawall wrote:
> > > > > A seantic patch and the resulting output for the case where the third
> > > > > arugument is a constant is attached.  Likewise the resulting output on a
> > > > > recent linux-next.
[]
> > > > There is a problem with conversions with assignments
> > > > of strlcpy() so ideally the cocci script should make sure
> > > > any return value was not used before conversion.
> > > > 
> > > > This is not a provably good conversion:
> > > > 
> > > > drivers/s390/char/sclp_ftp.c
> > > > @@ -114,8 +114,7 @@ static int sclp_ftp_et7(const struct hmc
> > > >         sccb->evbuf.mdd.ftp.length = ftp->len;
> > > >         sccb->evbuf.mdd.ftp.bufaddr = virt_to_phys(ftp->buf);
> > > > 
> > > > -       len = strlcpy(sccb->evbuf.mdd.ftp.fident, ftp->fname,
> > > > -                     HMCDRV_FTP_FIDENT_MAX);
> > > > +       len = stracpy(sccb->evbuf.mdd.ftp.fident, ftp->fname);
[]
> > Any use of the strlcpy return value should not be converted
> > because the logic after an assignment or use of the return value
> > can not be assured to have the same behavior.
> 
> Most of the code probably expects the length to be that copied
> (so is broken if the string is truncated).

Fortunately there are relatively few uses of the return
value of strlcpy so it's not a large problem set.

Slightly unrepresentative counts:

$ git grep -P "^\s+strlcpy\b" | wc -l
1681
$ git grep -P "=\s*strlcpy\b" | wc -l
28


_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
