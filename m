Return-Path: <SRS0=82Xq=HP=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F02C433E0
	for <cocci@archiver.kernel.org>; Sat, 13 Feb 2021 07:46:38 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 054FF64DEE
	for <cocci@archiver.kernel.org>; Sat, 13 Feb 2021 07:46:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 054FF64DEE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 11D7kFS6001801;
	Sat, 13 Feb 2021 08:46:15 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 4B58974AF;
	Sat, 13 Feb 2021 08:46:15 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 2812324DD
 for <cocci@systeme.lip6.fr>; Sat, 13 Feb 2021 08:46:13 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 11D7kCbc009311
 for <cocci@systeme.lip6.fr>; Sat, 13 Feb 2021 08:46:12 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.81,175,1610406000"; d="scan'208";a="372952662"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 13 Feb 2021 08:46:12 +0100
Date: Sat, 13 Feb 2021 08:46:11 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Denis Efremov <efremov@linux.com>
In-Reply-To: <f7c2e83e-0cdd-d414-0fb1-e57cd380dce7@linux.com>
Message-ID: <alpine.DEB.2.22.394.2102130843330.2720@hadrien>
References: <0c2a01f3-e48b-fc67-78b4-f061026aec42@linux.com>
 <alpine.DEB.2.22.394.2102121504100.9350@hadrien>
 <f7c2e83e-0cdd-d414-0fb1-e57cd380dce7@linux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 13 Feb 2021 08:46:16 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 13 Feb 2021 08:46:12 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Backward compatibility issue
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



On Fri, 12 Feb 2021, Denis Efremov wrote:

>
>
> On 2/12/21 5:04 PM, Julia Lawall wrote:
> >
> >
> > On Thu, 11 Feb 2021, Denis Efremov wrote:
> >
> >> Hi, one of my patterns started to fail tests on latest coccinelle.
> >> I've bisected the commit that introduces "error". It's:
> >> commit db60e916633d2cb3ae31140364783fdf85ed10f4
> >> "make information about SmPL iterator and declarer names available to the C parser"
> >>
> >> To reproduce the error:
> >> $ cd linux
> >> $ git checkout 5b01014759991887b1e450c9def01e58c02ab81b
> >> $ wget https://raw.githubusercontent.com/evdenis/cvehound/master/cvehound/cve/CVE-2016-9793.cocci
> >> $ spatch -D detect --cocci-file CVE-2016-9793.cocci net/core/sock.c
> >> # spatch before db60e916633d2cb3ae31140364783fdf85ed10f4 will find the match
> >> net/core/sock.c:718:16-17: ERROR: CVE-2016-9793
> >> net/core/sock.c:754:16-17: ERROR: CVE-2016-9793
> >> ...
> >> # spatch >= db60e916633d2cb3ae31140364783fdf85ed10f4 will not match the same code
> >
> > If you change typedef u32 to symbol u32, it should be good.  It is no use
> > to Coccinelle to know that u32 is a typedef in this code.
>
> After changing typedef to symbol, git version starts to match the code,
> but coccinelle 1.0.8 starts to fail the detection.

Strange, I'll check.

> Well, this doesn't
> solve the problem for me.
>
> What's the difference between symbol and typedef? How can I understand
> when to use one or another?

Typedef allows the thing to be used as a type.  But in semantic patch that
oyu have, there is no way for Coccinelle to know that u32 is being used as
a type.  It's just the argument to a macro.  It could be any identifier.

Symbol just means "this is an identifier I want to match exactly, and I
don't want the semantic patch parser to ask me if it should be a
metavariable".  It actually has no impact on the matching process.

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
