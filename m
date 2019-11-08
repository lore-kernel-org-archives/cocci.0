Return-Path: <SRS0=dAPZ=ZA=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3618EC5DF60
	for <cocci@archiver.kernel.org>; Fri,  8 Nov 2019 12:51:53 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C5D421848
	for <cocci@archiver.kernel.org>; Fri,  8 Nov 2019 12:51:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C5D421848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xA8CpPQk016230;
	Fri, 8 Nov 2019 13:51:25 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 210A677D0;
	Fri,  8 Nov 2019 13:51:25 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 9116277C6
 for <cocci@systeme.lip6.fr>; Fri,  8 Nov 2019 13:51:23 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xA8CpLjj026804
 for <cocci@systeme.lip6.fr>; Fri, 8 Nov 2019 13:51:21 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.68,281,1569276000"; d="scan'208";a="410989447"
Received: from portablejulia.rsr.lip6.fr ([132.227.76.63])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 08 Nov 2019 13:51:21 +0100
Date: Fri, 8 Nov 2019 13:51:20 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: julia@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <bfd990c8-1c1d-a6ee-7b05-e9f80160712b@web.de>
Message-ID: <alpine.DEB.2.21.1911081350350.2465@hadrien>
References: <bfd990c8-1c1d-a6ee-7b05-e9f80160712b@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1793381850-1573217481=:2465"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 08 Nov 2019 13:51:25 +0100 (CET)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Fri, 08 Nov 2019 13:51:21 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Fixing SmPL scripts for data output according to
 structured file formats
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

--8323329-1793381850-1573217481=:2465
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Fri, 8 Nov 2019, Markus Elfring wrote:

> Hello,
>
> I have taken another look at a script for the semantic patch language.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/scripts/coccinelle/free/iounmap.cocci?id=cd0207a7bfd29016a4eeb0b0203fa900b41e4eee
>
> It belongs to the category of SmPL scripts which support data output also for
> structured file formats. The output order matters then for the integration of
> additional information so that preferably valid data are provided at
> appropriate places.
>
> A well-known file format like “Org mode” expects then that specific contents
> should be enclosed by corresponding tags.
> https://orgmode.org/manual/Literal-Examples.html
>
> But a SmPL rule which uses the SmPL asterisk functionality triggers immediate
> output of diff hunks so far (if a source code fragment was matched).
> I find such a data processing approach questionable for this operation mode.
>
> I imagine the following solution possibilities.
>
> 1. Separate SmPL rules should be used without SmPL asterisks.
>
> 2. It would occasionally be more convenient to redirect the output to standard
>    files into corresponding variables.
>
>
> How would you like to improve the software situation here?

make coccicheck uses --no-show-diff at the approrpiate place so that the *
have no effect if the context option is not chosen.

julia


>
> Regards,
> Markus
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
--8323329-1793381850-1573217481=:2465
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-1793381850-1573217481=:2465--
