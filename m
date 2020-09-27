Return-Path: <SRS0=onlg=DE=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D38C4741F
	for <cocci@archiver.kernel.org>; Sun, 27 Sep 2020 18:03:54 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACA07239EE
	for <cocci@archiver.kernel.org>; Sun, 27 Sep 2020 18:03:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACA07239EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08RI3Qne019996;
	Sun, 27 Sep 2020 20:03:26 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B3C6E5F8F;
	Sun, 27 Sep 2020 20:03:26 +0200 (CEST)
Received: from osiris.lip6.fr (osiris.lip6.fr [132.227.60.30])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id CDF2B4316
 for <cocci@systeme.lip6.fr>; Sun, 27 Sep 2020 20:03:23 +0200 (CEST)
Received: from smtprelay.hostedemail.com (smtprelay0201.hostedemail.com
 [216.40.44.201])
 by osiris.lip6.fr (8.15.2/8.15.2) with ESMTPS id 08RI3L3G009730
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Sun, 27 Sep 2020 20:03:22 +0200 (CEST)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave03.hostedemail.com (Postfix) with ESMTP id 15AA7181CAB42
 for <cocci@systeme.lip6.fr>; Sun, 27 Sep 2020 17:45:52 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay02.hostedemail.com (Postfix) with ESMTP id 7921C1730858;
 Sun, 27 Sep 2020 17:45:48 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cry47_3d0f42d2717a
X-Filterd-Recvd-Size: 3344
Received: from XPS-9350.home (unknown [47.151.133.149])
 (Authenticated sender: joe@perches.com)
 by omf10.hostedemail.com (Postfix) with ESMTPA;
 Sun, 27 Sep 2020 17:45:46 +0000 (UTC)
Message-ID: <983c49ebe4bbe0435a73d25cd8525764a4f8adac.camel@perches.com>
From: Joe Perches <joe@perches.com>
To: Julia Lawall <julia.lawall@inria.fr>
Date: Sun, 27 Sep 2020 10:45:45 -0700
In-Reply-To: <alpine.DEB.2.22.394.2009271907270.2839@hadrien>
References: <87r1qqvo2d.fsf@nanos.tec.linutronix.de>
 <a53048f738dacc1c58654eb94e229de79d4f94c2.camel@perches.com>
 <alpine.DEB.2.22.394.2009271907270.2839@hadrien>
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 27 Sep 2020 20:03:27 +0200 (CEST)
X-Greylist: Delayed for 00:10:01 by milter-greylist-4.4.3 (osiris.lip6.fr
 [132.227.60.30]); Sun, 27 Sep 2020 20:03:23 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.30
Cc: Giuseppe Scrivano <gscrivan@redhat.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Valdis =?UTF-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        lkp <lkp@intel.com>, kernelnewbies <kernelnewbies@kernelnewbies.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, cocci <cocci@systeme.lip6.fr>,
        Andy Whitcroft <apw@shadowen.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Andrew Morton <akpm@linux-foundation.org>
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

On Sun, 2020-09-27 at 19:08 +0200, Julia Lawall wrote:
> I end up with 208 patches.  I'm not sure that sending them all at once
> would be a good idea...

Last I looked the diffstat for comma -> semicolon was:

234 files changed, 509 insertions(+), 509 deletions(-)

So it would be nearly 1 patch per individual file,

Greg KH does send hundreds of patches for -stable at a time.

So, maybe or maybe not send them all at once.
Maybe send it in batches of 25 or so.

There's no single right way to do this.

Maybe put up a git tree somewhere and let the
kernel-robot test compilation.

(A nicety might be for the kernel-robot to have some
 option to test pre and post compilation object code
 differences with an optional report)

When I automated 491 patches for /* fallthrough */ to
fallthrough;, the robot caught a couple problems which
was great.

https://repo.or.cz/linux-2.6/trivial-mods.git/shortlog/refs/heads/20200310_fallthrough_2

I only posted the first ~30 patches though with
about 50% acceptance. Gustavo Silva picked up the
effort and did a great job.  Eventually, a single
treewide patch was posted and accepted by Linus for
this though after dozens of individual patches went
through various maintainer trees:

$ git log --shortstat -1 df561f6688fe
commit df561f6688fef775baa341a0f5d960becd248b11
Author: Gustavo A. R. Silva <gustavoars@kernel.org>
Date:   Sun Aug 23 17:36:59 2020 -0500

    treewide: Use fallthrough pseudo-keyword
    
    Replace the existing /* fall through */ comments and its variants with
    the new pseudo-keyword macro fallthrough[1]. Also, remove unnecessary
    fall-through markings when it is the case.
    
    [1] https://www.kernel.org/doc/html/v5.7/process/deprecated.html?highlight=>
    
    Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

 1148 files changed, 2667 insertions(+), 2737 deletions(-)


_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
