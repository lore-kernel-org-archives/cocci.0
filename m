Return-Path: <SRS0=PP4e=67=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF437C433E0
	for <cocci@archiver.kernel.org>; Sun, 17 May 2020 08:07:51 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3887C2065F
	for <cocci@archiver.kernel.org>; Sun, 17 May 2020 08:07:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3887C2065F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04H87XmK023626;
	Sun, 17 May 2020 10:07:33 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 16A017740;
	Sun, 17 May 2020 10:07:33 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id CDBEC3DC8
 for <cocci@systeme.lip6.fr>; Sun, 17 May 2020 10:07:30 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04H87UU1019922
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 17 May 2020 10:07:30 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.73,402,1583190000"; d="scan'208";a="348845950"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 17 May 2020 10:07:29 +0200
Date: Sun, 17 May 2020 10:07:29 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Thomas Adam <thomas@xteddy.org>
In-Reply-To: <20200517001646.gtobyv6jea5bugfr@debian>
Message-ID: <alpine.DEB.2.21.2005171002330.2822@hadrien>
References: <20200517001646.gtobyv6jea5bugfr@debian>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 17 May 2020 10:07:33 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 17 May 2020 10:07:30 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Using cocci to mangle function arguments
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



On Sun, 17 May 2020, Thomas Adam wrote:

> Hi all,
>
> I have a situation where I'm trying to use Coccinelle to both rename one
> function to another, and at the same time modify the number of arguments.
>
> I have a function called:
>
>     func_old(ERR, "func_name", "%s message", charstring);
>
> Which is therefore variadic.  In terms of argument ordering func_old() takes:
>
>   1.  log-level type
>   2.  the calling function
>   3.  A variadic string
>
> I'm wanting to replace func_old() with func_new() such that it looks like
> this:
>
>     func_new("%s: %s message", __func__, charstring);
>
> Hence, func_new() reduces the number of arguments to just one -- a format
> string, and variadic arguments.
>
> My question is how would I go about trying to get coccinelle to help me
> translate this?  Is this even possible?  I have tried:
>
> @@
> expression O1, O2, O3
> @@
>
> - func_old(O1, O2, O3, ...);
>
> But I don't know how to convert what would be O2 to '__func__'.  When calling
> func_new(), there is no explicit O2 parameter from func_old(), it should be
> part of the format string, hence:
>
> + func_new("%s: ...", __func__, O3);
>
> I suspect I might be stretching coccinelle's abilities in trying to craft new
> parameters, but I thought I'd ask.

I'm not sure to completely understand the problem.  Is it that O1 is
always an explicit string and you want to add %s: at the beginning of that
string?

If you require O1 to be an explicit string, it would be better to declare
it as:

constant char[] O1;

For creating the new string, you can use python.  Check
demos/pythontococci.cocci.  Basically, you need to play with the data you
are given in the python code to create the string that you want.
According to the example, when you use it in the final SmPL rule that
creates the new code, you will call it an identifier, even though it is a
string.  But it doesn't matter.

There is a more clean way to do this with some make_expr function, but
there doens't seem to be a convenient demo for it.

julia


>
> Apologies if this is convoluted.  If I can help answer any additional
> questions, or if something's not clear, let me know.
>
> TIA!
>
> Thomas
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
