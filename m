Return-Path: <SRS0=qX47=VU=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 682DEC76186
	for <cocci@archiver.kernel.org>; Tue, 23 Jul 2019 23:42:44 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D6562238C
	for <cocci@archiver.kernel.org>; Tue, 23 Jul 2019 23:42:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D6562238C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x6NNgUq9020777;
	Wed, 24 Jul 2019 01:42:30 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 2CA28777C;
	Wed, 24 Jul 2019 01:42:30 +0200 (CEST)
Received: from osiris.lip6.fr (osiris.lip6.fr [132.227.60.30])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id CE67076BF
 for <cocci@systeme.lip6.fr>; Wed, 24 Jul 2019 01:42:26 +0200 (CEST)
Received: from smtprelay.hostedemail.com (smtprelay0036.hostedemail.com
 [216.40.44.36])
 by osiris.lip6.fr (8.15.2/8.15.2) with ESMTP id x6NNgOhd019849
 for <cocci@systeme.lip6.fr>; Wed, 24 Jul 2019 01:42:25 +0200 (CEST)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay06.hostedemail.com (Postfix) with ESMTP id 48EDC182251C0;
 Tue, 23 Jul 2019 23:42:22 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: arch08_31ad5a36be712
X-Filterd-Recvd-Size: 2901
Received: from XPS-9350 (172-222-149-092.dhcp.chtrptr.net [172.222.149.92])
 (Authenticated sender: joe@perches.com)
 by omf12.hostedemail.com (Postfix) with ESMTPA;
 Tue, 23 Jul 2019 23:42:21 +0000 (UTC)
Message-ID: <0f3ba090dfc956f5651e6c7c430abdba94ddcb8b.camel@perches.com>
From: Joe Perches <joe@perches.com>
To: Julia Lawall <julia.lawall@lip6.fr>
Date: Tue, 23 Jul 2019 16:42:19 -0700
In-Reply-To: <alpine.DEB.2.21.1907231546090.2551@hadrien>
References: <7ab8957eaf9b0931a59eff6e2bd8c5169f2f6c41.1563841972.git.joe@perches.com>
 <66fcdbf607d7d0bea41edb39e5579d63b62b7d84.camel@perches.com>
 <alpine.DEB.2.21.1907231546090.2551@hadrien>
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 24 Jul 2019 01:42:30 +0200 (CEST)
X-Greylist: Delayed for 18:10:03 by milter-greylist-4.4.3 (osiris.lip6.fr
 [132.227.60.30]); Wed, 24 Jul 2019 01:42:25 +0200 (CEST)
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

On Tue, 2019-07-23 at 15:52 -0500, Julia Lawall wrote:
> On Mon, 22 Jul 2019, Joe Perches wrote:
> > I just sent a patch to add yet another string copy mechanism.
> > 
> > This could help avoid misuses of strscpy and strlcpy like this
> > patch set:
> > 
> > https://lore.kernel.org/lkml/cover.1562283944.git.joe@perches.com/T/
> > 
> > A possible cocci script to do conversions could be:
> > 
> >    $ cat str.cpy.cocci
> >    @@
> >    expression e1;
> >    expression e2;
> >    @@
> > 
> >    - strscpy(e1, e2, sizeof(e1))
> >    + stracpy(e1, e2)
> > 
> >    @@
> >    expression e1;
> >    expression e2;
> >    @@
> > 
> >    - strlcpy(e1, e2, sizeof(e1))
> >    + stracpy(e1, e2)
> > 
> > This obviously does not match the style of all the
> > scripts/coccinelle cocci files, but this might be
> > something that could be added improved and added.
> > 
> > This script produces:
> > 
> > $ spatch --in-place -sp-file str.cpy.cocci .
> > $ git checkout tools/
> > $ git diff --shortstat
> >  958 files changed, 2179 insertions(+), 2655 deletions(-)
> > 
> > The remainder of strlcpy and strscpy uses in the
> > kernel would generally have a form like:
> > 
> > 	strlcpy(to, from, DEFINE)
> > 
> > where DEFINE is the specified size of to
> > 
> > Could the cocci script above be updated to find
> > and correct those styles as well?
> 
> I guess it would depend on what "to" is and what DEFINE expands into.  For
> example, in cpuidle-powernv.c, I see:
> 
> strlcpy(powernv_states[index].name, name, CPUIDLE_NAME_LEN);
> 
> and by poking around I see:
> 
> struct cpuidle_state {
> 	char		name[CPUIDLE_NAME_LEN];
> 	char		desc[CPUIDLE_DESC_LEN];
> 	...
> };

Yes, ideally this case would not modify the #define for the
length but adapt the strlcpy(,,DEFINE)

There are a lot of these in drivers/hwmon using I2C_NAME_SIZE.

> I will look into it.

Thanks.


_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
