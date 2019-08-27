Return-Path: <SRS0=PQQq=WX=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E4FC3A5A3
	for <cocci@archiver.kernel.org>; Tue, 27 Aug 2019 14:45:29 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D01D7206BF
	for <cocci@archiver.kernel.org>; Tue, 27 Aug 2019 14:45:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D01D7206BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7REiuW9024084;
	Tue, 27 Aug 2019 16:44:56 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 8A5C17791;
	Tue, 27 Aug 2019 16:44:56 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id DA06D7788
 for <cocci@systeme.lip6.fr>; Tue, 27 Aug 2019 16:44:54 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7REirZl001480
 for <cocci@systeme.lip6.fr>; Tue, 27 Aug 2019 16:44:53 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.64,437,1559512800"; d="scan'208";a="317337914"
Received: from unknown (HELO hadrien) ([223.104.3.36])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Aug 2019 16:44:50 +0200
Date: Tue, 27 Aug 2019 22:44:43 +0800 (CST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: julia@hadrien
To: Paul Chaignon <paul.chaignon@gmail.com>
In-Reply-To: <20190827143039.GA19250@Nover>
Message-ID: <alpine.DEB.2.21.1908272238360.2475@hadrien>
References: <20190827143039.GA19250@Nover>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 27 Aug 2019 16:44:57 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Tue, 27 Aug 2019 16:44:53 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] SmPL highlighting on GitHub and GitLab
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



On Tue, 27 Aug 2019, Paul Chaignon wrote:

> Hello dear Coccinelle community,
>
> Since a few hours ago, SmPL code is detected and highlighted on GitHub.
> Examples [1, 2] are visible in the Linux repository.  Other repositories
> should receive highlighting when they'll be updated (after a git push).
> Highlighting on GitLab should follow if/when they update their Linguist
> dependency.
>
> This change follows an update to the Linguist library [3], used to detect
> languages on GitHub and GitLab.  At the moment, all .cocci files are
> detected as SmPL.  The grammar for highlighting [4] was written by John
> Gardner and should also work for the Atom editor.  If you want to change
> the color, aliases, or extensions associated with SmPL, we'd welcome pull
> requests to Linguist and I'm confident John would too for the grammar!

Wow, thanks for this!

However, I don't see anything for [1], only for [2].

As far as I can see, the - code has a background and the + code does not.
Is there a reason for that?

It could also be good to use a different color for the * code; I've been
using purple.

I also use blue for the @@s and black for the metavariable declarations,
but I find your color choices rather appealing in this case.

If there are no further color suggestions on the list, I will look into
how to make a pull request.

Thanks!

julia

>
> Regards,
> Paul Chaignon
>
> 1 - https://github.com/torvalds/linux/blob/master/scripts/coccinelle/api/d_find_alias.cocci
> 2 - https://github.com/torvalds/linux/blob/master/scripts/coccinelle/misc/boolreturn.cocci
> 3 - https://github.com/github/linguist
> 4 - https://github.com/Alhadis/language-etc/blob/master/grammars/smpl.cson
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
