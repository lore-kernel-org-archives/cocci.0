Return-Path: <SRS0=ZI4t=V2=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894A8C7618B
	for <cocci@archiver.kernel.org>; Mon, 29 Jul 2019 14:07:49 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E10FF2070D
	for <cocci@archiver.kernel.org>; Mon, 29 Jul 2019 14:07:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E10FF2070D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x6TE7X9N025214;
	Mon, 29 Jul 2019 16:07:34 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A7C7E7790;
	Mon, 29 Jul 2019 16:07:33 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B51AA776D
 for <cocci@systeme.lip6.fr>; Mon, 29 Jul 2019 16:07:31 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x6TE7VXs028669
 for <cocci@systeme.lip6.fr>; Mon, 29 Jul 2019 16:07:31 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.64,322,1559512800"; d="scan'208";a="393742892"
Received: from 71-219-88-14.chvl.qwest.net (HELO hadrien.PK5001Z)
 ([71.219.88.14])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 29 Jul 2019 16:07:30 +0200
Date: Mon, 29 Jul 2019 10:07:29 -0400 (EDT)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Joe Perches <joe@perches.com>
In-Reply-To: <eaef283741c0a6a718040f99a17bdb9882bde665.camel@perches.com>
Message-ID: <alpine.DEB.2.21.1907291004220.2686@hadrien>
References: <7ab8957eaf9b0931a59eff6e2bd8c5169f2f6c41.1563841972.git.joe@perches.com>
 <66fcdbf607d7d0bea41edb39e5579d63b62b7d84.camel@perches.com>
 <alpine.DEB.2.21.1907231546090.2551@hadrien>
 <0f3ba090dfc956f5651e6c7c430abdba94ddcb8b.camel@perches.com>
 <alpine.DEB.2.21.1907232252260.2539@hadrien>
 <d5993902fd44ce89915fab94f4db03f5081c3c8e.camel@perches.com>
 <alpine.DEB.2.21.1907232326360.2539@hadrien>
 <f909b4b31f123c7d88535db397a04421077ed0ab.camel@perches.com>
 <563222fbfdbb44daa98078db9d404972@AcuMS.aculab.com>
 <d2b2b528b9f296dfeb1d92554be024245abd678e.camel@perches.com>
 <alpine.DEB.2.21.1907242040490.10108@hadrien>
 <a0e892c3522f4df2991119a2a30cd62ec14c76cc.camel@perches.com>
 <alpine.DEB.2.21.1907250856450.2555@hadrien>
 <eaef283741c0a6a718040f99a17bdb9882bde665.camel@perches.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 29 Jul 2019 16:07:34 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Mon, 29 Jul 2019 16:07:31 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: David Laight <David.Laight@ACULAB.COM>, cocci <cocci@systeme.lip6.fr>,
        LKML <linux-kernel@vger.kernel.org>
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

I see that stracpy is now in linux-next.  Would it be reasonable to send
patches adding uses now?  Are there any rules for adding calls to
stracpy_pad?

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
