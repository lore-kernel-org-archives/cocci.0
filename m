Return-Path: <SRS0=TLPZ=22=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A05CC00523
	for <cocci@archiver.kernel.org>; Sun,  5 Jan 2020 10:06:21 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F9D0207FD
	for <cocci@archiver.kernel.org>; Sun,  5 Jan 2020 10:06:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F9D0207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 005A5qPc019280;
	Sun, 5 Jan 2020 11:05:52 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 57DA37718;
	Sun,  5 Jan 2020 11:05:52 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id EDD5C73E2
 for <cocci@systeme.lip6.fr>; Sun,  5 Jan 2020 11:05:50 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 005A5ouk004256
 for <cocci@systeme.lip6.fr>; Sun, 5 Jan 2020 11:05:50 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.69,398,1571695200"; d="scan'208";a="334788243"
Received: from abo-154-110-68.mrs.modulonet.fr (HELO hadrien) ([85.68.110.154])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 05 Jan 2020 11:05:50 +0100
Date: Sun, 5 Jan 2020 11:05:49 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <08d3a32e-7adc-ff5b-52d0-9e67ed03ae42@web.de>
Message-ID: <alpine.DEB.2.21.2001051100550.2579@hadrien>
References: <20200103160304.GG17258@pobox.com>
 <08d3a32e-7adc-ff5b-52d0-9e67ed03ae42@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 05 Jan 2020 11:05:52 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 05 Jan 2020 11:05:50 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] transforming arguments to statement macros?
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

On Sun, 5 Jan 2020, Markus Elfring wrote:

> > I would prefer that the macros were written with the do-while pattern,
> > but it's a legacy codebase that uses HGOTO_ERROR() no fewer than 12,000
> > times, and most occurrences have no semicolon.  I will have to automate
> > the conversion, and I guess that I cannot use spatch to do it.
>
> Would you like to try out how good semicolons can be added behind
> these macro calls by a small script for the semantic patch language?

The problem is that the arguemnt list is considered to be comments.  THere
is no way to specify to put a semicolon at the end of a comment.

The only short term suggestion I have is the following:

@r@
statement s : script:ocaml() { List.hd (Str.split (Str.regexp " *(") s) =
"ASSERT" };
statement s1,s2;
position p1;
@@

s
s1@p1

@@
statement r.s1;
position r.p1;
@@

+;
s1@p1

-------------------

This uses ASSERT as an example, because standard.h already contains

#define ASSERT(x) MACROSTATEMENT

It uses a regular expression to detect that a statement starts with the
word ASSERT, and matches the next statement as well, and then in another
rule adds a ; before the subsequent statement.  If you add the ; after the
ASSERT statement it comes out after ASSERT, not after the commented
argument list. But with this semantic patch, the ; comes out on a line of
its own, and would have to be moved up manually.  So I don't know if that
gives any real benefit.  It obviously also doesn't work if the ASSERT is
at the end of a function.

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
