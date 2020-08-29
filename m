Return-Path: <SRS0=mjN0=CH=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8F5C433E6
	for <cocci@archiver.kernel.org>; Sat, 29 Aug 2020 20:26:24 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 861212076D
	for <cocci@archiver.kernel.org>; Sat, 29 Aug 2020 20:26:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 861212076D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 07TKQBZs008478;
	Sat, 29 Aug 2020 22:26:11 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id DC13D777D;
	Sat, 29 Aug 2020 22:26:11 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 8F6C63F6C
 for <cocci@systeme.lip6.fr>; Sat, 29 Aug 2020 22:26:10 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 07TKQAH6028940
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Sat, 29 Aug 2020 22:26:10 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.76,359,1592863200"; d="scan'208";a="465222749"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 29 Aug 2020 22:26:09 +0200
Date: Sat, 29 Aug 2020 22:26:09 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Denis Efremov <efremov@linux.com>
In-Reply-To: <d7dcb9b4-4093-d0a3-5277-b50e212a5700@linux.com>
Message-ID: <alpine.DEB.2.22.394.2008292225550.3629@hadrien>
References: <20200811210127.11889-1-efremov@linux.com>
 <alpine.DEB.2.22.394.2008292133360.3629@hadrien>
 <489164b541e344f254b70429e4f6d467e1602931.camel@perches.com>
 <alpine.DEB.2.22.394.2008292146170.3629@hadrien>
 <d7dcb9b4-4093-d0a3-5277-b50e212a5700@linux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 29 Aug 2020 22:26:12 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 29 Aug 2020 22:26:10 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Kees Cook <keescook@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>,
        cocci@systeme.lip6.fr
Subject: Re: [Cocci] [RFC PATCH] coccinelle: misc: add
 uninitialized_var.cocci script
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



On Sat, 29 Aug 2020, Denis Efremov wrote:

>
>
> On 8/29/20 10:48 PM, Julia Lawall wrote:
> >
> >
> > On Sat, 29 Aug 2020, Joe Perches wrote:
> >
> >> On Sat, 2020-08-29 at 21:36 +0200, Julia Lawall wrote:
> >>>
> >>> On Wed, 12 Aug 2020, Denis Efremov wrote:
> >>>
> >>>> Commit 63a0895d960a ("compiler: Remove uninitialized_var() macro") and
> >>>> commit 4b19bec97c88 ("docs: deprecated.rst: Add uninitialized_var()")
> >>>> removed uninitialized_var() and deprecated it.
> >>>>
> >>>> The purpose of this script is to prevent new occurrences of open-coded
> >>>> variants of uninitialized_var().
> >>
> >>>> Cc: Kees Cook <keescook@chromium.org>
> >>>> Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
> >>>> Signed-off-by: Denis Efremov <efremov@linux.com>
> >>>
> >>> Applied, without the commented out part.
> >>>
> >>> I only got three warnings, though.  Perhaps the others have been fixed?
> >>
> >> uninitialized_var does not exist in -next
>
> Yes, and this rule checks for not introducing these initializations once again.
>
> i.e, checks for:
>
> int a = a;
>
> int a = *(&a);
>
> >
> > OK, if it seems better, I can remove it.  Out of the threee reported, one
> > was a completely unnecessary initialization.
> >
>
> I would like send v2 with better description and link to the documentation because it's
> now available online:
> https://www.kernel.org/doc/html/latest/process/deprecated.html#uninitialized-var

OK, thanks.

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
