Return-Path: <SRS0=ZWNV=TY=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D689C282E1
	for <cocci@archiver.kernel.org>; Fri, 24 May 2019 13:21:11 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E66E020851
	for <cocci@archiver.kernel.org>; Fri, 24 May 2019 13:21:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E66E020851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4ODKuRO021033;
	Fri, 24 May 2019 15:20:56 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 841517752;
	Fri, 24 May 2019 15:20:56 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 149667747
 for <cocci@systeme.lip6.fr>; Fri, 24 May 2019 15:20:55 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4ODKsgZ016587
 for <cocci@systeme.lip6.fr>; Fri, 24 May 2019 15:20:54 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.60,507,1549926000"; d="scan'208";a="307121983"
Received: from vaio-julia.rsr.lip6.fr ([132.227.76.33])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 May 2019 15:20:54 +0200
Date: Fri, 24 May 2019 15:20:52 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: =?ISO-8859-15?Q?Christoph_B=F6hmwalder?= <christoph.boehmwalder@linbit.com>
In-Reply-To: <CADC+RAzMNspm03FhGGQEDTsAMkQecjo_A930_SvsraKBpzu_bQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1905241519320.3669@hadrien>
References: <CADC+RAzMNspm03FhGGQEDTsAMkQecjo_A930_SvsraKBpzu_bQ@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-617032276-1558704052=:3669"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 24 May 2019 15:20:56 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Fri, 24 May 2019 15:20:54 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] "depends on" per file
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

--8323329-617032276-1558704052=:3669
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT



On Fri, 24 May 2019, Christoph Böhmwalder wrote:

> Hi,
>
> I'm trying to replace a function with a one-liner, where the one-liner
> has a dependency on a header file that the function doesn't.
> Now I want to include said header file iff it isn't already included
> in the affected file.
> In more concrete terms, this is my script:
>
>
> @ find_linux_dcache_h @
> @@
>  #include <linux/dcache.h>
>
> @ replace_simple_positive @
> expression den;
> @@
> - simple_positive(den)
> + (den->d_inode && !d_unhashed(den))
>
> @ add_linux_dcache_h depends on !find_linux_dcache_h && ever
> replace_simple_positive @
> @@
>  #include <...>
> + #include <linux/dcache.h>
>
>
> So far so good, (almost) works just fine. The issue is that if the
> rule gets matched in one file, it will include the header in every
> other file as well, because the "depends on ever" clause is satisfied.
> Is there a way to tell coccinelle "apply this rule to file X, but only
> if another rule matched in the same file"?

Do you have multiple file names on the command line?  If so, this i not a
good idea.  It will try to process all of the files at once.  Normally,
you just run Coccinelle on a directory.  Then it will process each file
independently.  You can do it in parallel as well, with the -j option.

julia
--8323329-617032276-1558704052=:3669
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-617032276-1558704052=:3669--
