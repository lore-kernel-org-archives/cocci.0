Return-Path: <SRS0=92ax=TU=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE10C04AAC
	for <cocci@archiver.kernel.org>; Mon, 20 May 2019 16:04:01 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3661D2171F
	for <cocci@archiver.kernel.org>; Mon, 20 May 2019 16:04:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3661D2171F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4KG3lxs024514;
	Mon, 20 May 2019 18:03:47 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id AFD547759;
	Mon, 20 May 2019 18:03:47 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 4912A7741
 for <cocci@systeme.lip6.fr>; Mon, 20 May 2019 18:03:44 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4KG3hDk019469
 for <cocci@systeme.lip6.fr>; Mon, 20 May 2019 18:03:43 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.60,491,1549926000"; d="scan'208";a="306577805"
Received: from unknown (HELO hadrien) ([163.173.90.196])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 20 May 2019 11:52:37 +0200
Date: Mon, 20 May 2019 11:52:37 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Pavel Machek <pavel@ucw.cz>
In-Reply-To: <20190520093303.GA9320@atrey.karlin.mff.cuni.cz>
Message-ID: <alpine.DEB.2.21.1905201152040.2543@hadrien>
References: <201905171432571474636@zte.com.cn>
 <alpine.DEB.2.20.1905170912590.4014@hadrien>
 <20190520093303.GA9320@atrey.karlin.mff.cuni.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 20 May 2019 18:03:47 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Mon, 20 May 2019 18:03:44 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: sashal@kernel.org, michal.lkml@markovi.net, nicolas.palix@imag.fr,
        linux-kernel@vger.kernel.org, cocci@systeme.lip6.fr,
        Markus.Elfring@web.de, wen.yang99@zte.com.cn
Subject: Re: [Cocci] Coccinelle: semantic patch for missing of_node_put
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



On Mon, 20 May 2019, Pavel Machek wrote:

> Hi!
>
> > A semantic patch has no access to comments.  The only thing I can see to
> > do is to use python to interact with some external tools.  For example,
> > you could write some code to collect the comments in a file and the lines
> > on which they occur, and then get the comment that most closely precedes
> > the start of the function.
>
> How dangerous is missing of_node_put? AFAICT it will only result into
> very small, one-time memory leak, right?
>
> Could we make sure these patches are _not_ going to stable? Leaking
> few bytes once per boot is not really a serious bug.

Sasha,

Probably patches that add only of_node_put should not be auto selected for
stable.

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
