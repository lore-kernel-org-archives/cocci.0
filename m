Return-Path: <SRS0=02ua=7V=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870F0C433E0
	for <cocci@archiver.kernel.org>; Mon,  8 Jun 2020 11:21:23 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FDA6206C3
	for <cocci@archiver.kernel.org>; Mon,  8 Jun 2020 11:21:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FDA6206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 058BLK5t013969;
	Mon, 8 Jun 2020 13:21:20 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 883F97783;
	Mon,  8 Jun 2020 13:21:20 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id F047844A7
 for <cocci@systeme.lip6.fr>; Mon,  8 Jun 2020 13:21:18 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 058BLIiW000577
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 8 Jun 2020 13:21:18 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.73,487,1583190000"; d="scan'208";a="453524540"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 08 Jun 2020 13:21:18 +0200
Date: Mon, 8 Jun 2020 13:21:18 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Denis Efremov <efremov@ispras.ru>
In-Reply-To: <9becafe8-ecd0-79a0-ba6c-3ec0f733d786@ispras.ru>
Message-ID: <alpine.DEB.2.21.2006081320340.3136@hadrien>
References: <b273ce70-5527-6e79-9e1e-7a6c3f83eda4@ispras.ru>
 <alpine.DEB.2.21.2006081224320.3136@hadrien>
 <9becafe8-ecd0-79a0-ba6c-3ec0f733d786@ispras.ru>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 08 Jun 2020 13:21:20 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 08 Jun 2020 13:21:18 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Python interface
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



On Mon, 8 Jun 2020, Denis Efremov wrote:

>
> > Is this self-check functionality planned for a patch in the Linux kernel,
> > or for some oher use?  Because the python script that I suggested for
> > collecting the names of all of the files will imply parsing all of those
> > files, which will have a major negative impact on performance.
>
> Yes, I've almost prepared it. It's more like a PoC, of course you are free not
> to taking it. I just find it interesting to implement. I hope you enjoy it.
> The check will depend on additional "virtual selfcheck", so I expect that the
> performance will not downgrade much.
>
> Perhaps it
> > could be possible to have the complete list of files available in the
> > initialize rule, like you expected.  But I wonder if the difference
> > between "the file is not in the initial list" and "the file is in the
> > initial list but it is ignored" is important for you?
>
> "the file is in the initial list but it is ignored" is ok to me. I don't know
> how to get it.
>
> The problem is that I need to know that the "mm/util.c" file is in the scope.
> We know that a pattern should match a function in the "mm/util.c" file
> and report only in case it doesn't. We don't need to report if the tool
> is not processing the file "mm/util.c" at all. That is why we need the full
> list of files.

OK, basically I worry about converting a list of 35 000 file names to
python.  But maybe it's not a big deal.

julia

>
> Thanks,
> Denis
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
