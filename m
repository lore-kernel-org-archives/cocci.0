Return-Path: <SRS0=wUuY=YI=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5B9C10F14
	for <cocci@archiver.kernel.org>; Tue, 15 Oct 2019 19:27:49 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3164F2083B
	for <cocci@archiver.kernel.org>; Tue, 15 Oct 2019 19:27:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3164F2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9FJRYH4015161;
	Tue, 15 Oct 2019 21:27:34 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 9009277B5;
	Tue, 15 Oct 2019 21:27:34 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 25B1F77B2
 for <cocci@systeme.lip6.fr>; Tue, 15 Oct 2019 21:27:33 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9FJRWfe020265
 for <cocci@systeme.lip6.fr>; Tue, 15 Oct 2019 21:27:32 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.67,300,1566856800"; d="scan'208";a="406331084"
Received: from ip-121.net-89-2-166.rev.numericable.fr (HELO hadrien)
 ([89.2.166.121])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 15 Oct 2019 21:27:32 +0200
Date: Tue, 15 Oct 2019 21:27:32 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <46ce51eb-b6d9-3a38-482c-f1654525bb04@web.de>
Message-ID: <alpine.DEB.2.21.1910152125020.2581@hadrien>
References: <46ce51eb-b6d9-3a38-482c-f1654525bb04@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1766552878-1571167652=:2581"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 15 Oct 2019 21:27:34 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Tue, 15 Oct 2019 21:27:32 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Converting a function return type to void based on a
 SmPL constraint?
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
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1766552878-1571167652=:2581
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Tue, 15 Oct 2019, Markus Elfring wrote:

> Hello,
>
> I have noticed that an update suggestion can be provided for
> a source file by a known script for the semantic patch language.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/coccinelle/misc/returnvar.cocci?id=8e0d0ad206f08506c893326ca7c9c3d9cc042cef
>
> Update candidate:
> btrfs_destroy_delayed_refs()
> https://elixir.bootlin.com/linux/v5.4-rc2/source/fs/btrfs/disk-io.c#L4252
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/fs/btrfs/disk-io.c?id=0e9d28bc6c81f47f94979ec7d0ab6ac42345fcee#n4243

Why are there two links here to the same thing???

>
> I got the software development idea then to change the function return type
> to “void” together with the deletion of return statements by the help of
> the tool “Coccinelle 1.0.8-00004-g842075f7” instead of adjusting return values.
>
> @replacement@
> constant C;
> identifier action, rc;
> type T;
> @@
>  static
> -T
> +void
>  action(...)
>  {
> -T rc = C;
>  ... when != rc
>      when strict
> -return rc;
>  }
>
>
> Unfortunately, I do not get the transformation result which I would expect
> for this approach. But I have noticed also that a similar SmPL script
> can work as expected (if a function like “unpin_extent_cache” was not marked
> as “static”?).
> Would you like to add any advices?

I don't know what result you expect, nor what is the relevance of
unpin_extent_cache, which is not the function linked to above.

My advice would be to take the time to cut down the example to a few lines
of code that can easily fit in an email, and then send a complete message
with no URLs or implicit references to previous emails that describes the
problem.

julia

> Regards,
> Markus
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
--8323329-1766552878-1571167652=:2581
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-1766552878-1571167652=:2581--
