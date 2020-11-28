Return-Path: <SRS0=SYYD=FC=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56890C63697
	for <cocci@archiver.kernel.org>; Sat, 28 Nov 2020 07:55:51 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CF022225E
	for <cocci@archiver.kernel.org>; Sat, 28 Nov 2020 07:55:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CF022225E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0AS7tItR006668;
	Sat, 28 Nov 2020 08:55:18 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id BB7255C34;
	Sat, 28 Nov 2020 08:55:18 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 41342454B
 for <cocci@systeme.lip6.fr>; Sat, 28 Nov 2020 08:55:17 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0AS7tG9o000294
 for <cocci@systeme.lip6.fr>; Sat, 28 Nov 2020 08:55:16 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.78,376,1599516000"; 
 d="scan'208,217";a="479972397"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 28 Nov 2020 08:55:16 +0100
Date: Sat, 28 Nov 2020 08:55:16 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Ira Weiny <ira.weiny@intel.com>
In-Reply-To: <20201128054145.GP1161629@iweiny-DESK2.sc.intel.com>
Message-ID: <alpine.DEB.2.22.394.2011280849310.2725@hadrien>
References: <20201128054145.GP1161629@iweiny-DESK2.sc.intel.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 28 Nov 2020 08:55:19 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 28 Nov 2020 08:55:16 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Itterating matches
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



On Fri, 27 Nov 2020, Ira Weiny wrote:

> I have been looking for a way to help automate my kmap/mem*/kunmap
> transformation.[1]  I'm very new to coccinelle and I'm having some trouble.
>
> I have tried to build up a script[2][3] to do this while also learning coccinelle
> but I'm not getting a couple of points.
>
> 1) How do I get matches to iterate?

What do you mean by iterate?

> 	1a) What is the difference between '<+... ...+>' and '<... ...>'?

<+... P ...+> requires P to appear one or more times
<... P ...>  allows P to occur 0 or more times

> 2) Why can't I get the type declaration (type VP;) matched correctly.  It works
>    some times but not always.  It also matches a lot of random declarations?
> 	2a) and for some reason in the more advanced script[3] it completely
> 	    breaks.  Which is very confusing because fundamentally it does not
>             seem to be any different from [2]?

I haven't tried running the scripts to see why the declaration breaks.
but I think that the declaration is not what you want.  ptr could be used
in some other case.  It would be better to have one rule that makes the
rest of the changes in the code, and the another rule that removes the ptr
declaration when there is no remaining use of the variable:

@r1@
identifier ptr;
...
@@

remove kmaps etc

@@
identifier r1.ptr;
type T;
@@

- T ptr;
  ... when != ptr

This will allow you to get rid of lines 8 and 28 in [2].

julia


> Any advice is appreciated.
>
> Thanks,
> Ira
>
> [1] https://lore.kernel.org/lkml/20201124141244.GE17322@twin.jikos.cz/
>
> [2]
> <script>
>   1 @ rule0 @
>   2 type VP;
>   3 identifier ptr;
>   4 identifier page;
>   5 @@
>   6
>   7 -VP ptr;
>   8 <...
>   9 (
>  10 -ptr = kmap(page);
>  11 |
>  12 -ptr = kmap_atomic(page);
>  13 )
>  14 <+...
>  15 (
>  16 -memset(...);
>  17 +memIra();
>  18 |
>  19 -memcpy(...);
>  20 +memIra();
>  21 )
>  22 ...+>
>  23 (
>  24 -kunmap(page);
>  25 |
>  26 -kunmap_atomic(ptr);
>  27 )
>  28 ...>
> </script>
>
> [3]
> <script>
>   1 @ rule0 @
>   2 type VP;
>   3 identifier page;
>   4 identifier ptr;
>   5 expression V;
>   6 expression L;
>   7 expression T;
>   8 expression F;
>   9 expression B;
>  10 expression Off;
>  11 @@
>  12
>  13 -VP ptr;
>  14 <...
>  15 (
>  16 -ptr = kmap(page);
>  17 |
>  18 -ptr = kmap_atomic(page);
>  19 )
>  20 <...
>  21 (
>  22 -memset(ptr, 0, L);
>  23 +zero_user(page, 0, L);
>  24 |
>  25 -memset(ptr + Off, 0, L);
>  26 +zero_user(page, Off, L);
>  27 |
>  28 -memset(ptr, V, L);
>  29 +memset_page(page, V, 0, L);
>  30 |
>  31 -memset(ptr + Off, V, L);
>  32 +memset_page(page, V, Off, L);
>  33 |
>  34 -memcpy(ptr + Off, F, B);
>  35 +memcpy_to_page(page, Off, F, B);
>  36 |
>  37 -memcpy(ptr, F, B);
>  38 +memcpy_to_page(page, 0, F, B);
>  39 |
>  40 -memcpy(T, ptr + Off, B);
>  41 +memcpy_from_page(T, page, Off, B);
>  42 |
>  43 -memcpy(T, ptr, B);
>  44 +memcpy_from_page(T, page, 0, B);
>  45 )
>  46 ...>
>  47 (
>  48 -kunmap(page);
>  49 |
>  50 -kunmap_atomic(ptr);
>  51 )
>  52 ...>
> </script>
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
