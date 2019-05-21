Return-Path: <SRS0=7mCU=TV=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64400C04AAF
	for <cocci@archiver.kernel.org>; Tue, 21 May 2019 05:58:34 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E182B20856
	for <cocci@archiver.kernel.org>; Tue, 21 May 2019 05:58:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E182B20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4L5wHrY012304;
	Tue, 21 May 2019 07:58:17 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 45B2B7747;
	Tue, 21 May 2019 07:58:17 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id E35E47741
 for <cocci@systeme.lip6.fr>; Tue, 21 May 2019 07:58:15 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4L5vdRj027386
 for <cocci@systeme.lip6.fr>; Tue, 21 May 2019 07:57:39 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.60,494,1549926000"; d="scan'208";a="306675426"
Received: from abo-218-110-68.mrs.modulonet.fr (HELO hadrien) ([85.68.110.218])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 21 May 2019 07:57:39 +0200
Date: Tue, 21 May 2019 07:57:39 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <78de5a84-1651-c5eb-4fbd-35362c93abef@web.de>
Message-ID: <alpine.DEB.2.21.1905210756490.2773@hadrien>
References: <a639ce38-81a1-8825-73b0-2b7ba53e6588@web.de>
 <78de5a84-1651-c5eb-4fbd-35362c93abef@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 21 May 2019 07:58:17 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Tue, 21 May 2019 07:57:40 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Continuation for a code search after a common SmPL rule?
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



On Tue, 21 May 2019, Markus Elfring wrote:

> Message repetition from 2019-05-16 because of a temporary technical difficulty
> with the mailing list services:
>
> =====
>
> Hello,
>
> The semantic patch language can handle several rules which can contain
> remarkable amounts of source code search specifications.
> It can happen then that a few of these SmPL rules contain a bit of
> common specifications.
>
> Example:
> @one@
> @@
> code_area_1
> code_area_2
>
> @two@
> @@
> code_area_1
> code_area_3
>
>
> Now I would like to clarify possibilities again to reduce unwanted
> code duplication at such places.
> The common code part can be moved to another SmPL rule.
>
> @start@
> @@
> code_area_1
>
>
> Subsequent SmPL rules can refer to metavariables from previous rules.
> But how can be achieved that the code search will be continued at a place
> after the position where a previous rule ended its search
> (without extra code repetition)?
>
> Can the splitting and recombination of such rules become more convenient
> with extensions for the Coccinelle software?

In general it can't.  Coccinelle doesn't have the goal of minimizing the
number of characters in te semantic patch.  It has the goal of making
readable specifications that follow the structure of the matched code.

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
