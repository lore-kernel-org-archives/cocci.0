Return-Path: <SRS0=iJe8=CV=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8558FC43461
	for <cocci@archiver.kernel.org>; Sat, 12 Sep 2020 15:08:42 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA7A120855
	for <cocci@archiver.kernel.org>; Sat, 12 Sep 2020 15:08:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA7A120855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08CF8MRq008381;
	Sat, 12 Sep 2020 17:08:22 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 3BF577595;
	Sat, 12 Sep 2020 17:08:22 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 997834316
 for <cocci@systeme.lip6.fr>; Sat, 12 Sep 2020 17:08:20 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08CF8KHT008460
 for <cocci@systeme.lip6.fr>; Sat, 12 Sep 2020 17:08:20 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.76,359,1592863200"; d="scan'208";a="467361552"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Sep 2020 17:08:19 +0200
Date: Sat, 12 Sep 2020 17:08:19 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Denis Efremov <efremov@linux.com>
In-Reply-To: <20200811074953.73994-1-efremov@linux.com>
Message-ID: <alpine.DEB.2.22.394.2009121707040.2362@hadrien>
References: <20200604140805.111613-1-efremov@linux.com>
 <20200811074953.73994-1-efremov@linux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 12 Sep 2020 17:08:22 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 12 Sep 2020 17:08:20 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Eric Biggers <ebiggers@kernel.org>, alexandre.belloni@bootlin.com,
        corbet@lwn.net, mchehab+huawei@kernel.org,
        linux-kernel@vger.kernel.org, cocci@systeme.lip6.fr,
        alex.dewar90@gmail.com
Subject: Re: [Cocci] [PATCH] coccinelle: api: update kzfree script to
 kfree_sensitive
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



On Tue, 11 Aug 2020, Denis Efremov wrote:

> Commit 453431a54934 ("mm, treewide: rename kzfree() to kfree_sensitive()")
> renames kzfree to kfree_sensitive and uses memzero_explicit(...) instead of
> memset(..., 0, ...) internally. Update cocci script to reflect these
> changes.
>
> Signed-off-by: Denis Efremov <efremov@linux.com>

Applied, thanks.

> ---
> Julia, I think you can squash this commit with original script, or I can
> resend the whole script since it's not merged to the mainline.
>
>  .../{kzfree.cocci => kfree_sensitive.cocci}   | 29 +++++++++----------
>  1 file changed, 13 insertions(+), 16 deletions(-)
>  rename scripts/coccinelle/api/{kzfree.cocci => kfree_sensitive.cocci} (70%)
>
> diff --git a/scripts/coccinelle/api/kzfree.cocci b/scripts/coccinelle/api/kfree_sensitive.cocci
> similarity index 70%
> rename from scripts/coccinelle/api/kzfree.cocci
> rename to scripts/coccinelle/api/kfree_sensitive.cocci
> index 33625bd7cec9..e4a066a0b77d 100644
> --- a/scripts/coccinelle/api/kzfree.cocci
> +++ b/scripts/coccinelle/api/kfree_sensitive.cocci
> @@ -1,13 +1,13 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  ///
> -/// Use kzfree, kvfree_sensitive rather than memset or
> -/// memzero_explicit followed by kfree
> +/// Use kfree_sensitive, kvfree_sensitive rather than memset or
> +/// memzero_explicit followed by kfree.
>  ///
>  // Confidence: High
>  // Copyright: (C) 2020 Denis Efremov ISPRAS
>  // Options: --no-includes --include-headers
>  //
> -// Keywords: kzfree, kvfree_sensitive
> +// Keywords: kfree_sensitive, kvfree_sensitive
>  //
>
>  virtual context
> @@ -18,7 +18,8 @@ virtual report
>  @initialize:python@
>  @@
>  # kmalloc_oob_in_memset uses memset to explicitly trigger out-of-bounds access
> -filter = frozenset(['kmalloc_oob_in_memset', 'kzfree', 'kvfree_sensitive'])
> +filter = frozenset(['kmalloc_oob_in_memset',
> +		    'kfree_sensitive', 'kvfree_sensitive'])
>
>  def relevant(p):
>      return not (filter & {el.current_element for el in p})
> @@ -56,17 +57,13 @@ type T;
>  - memzero_explicit@m((T)E, size);
>    ... when != E
>        when strict
> -// TODO: uncomment when kfree_sensitive will be merged.
> -// Only this case is commented out because developers
> -// may not like patches like this since kzfree uses memset
> -// internally (not memzero_explicit).
> -//(
> -//- kfree(E)@p;
> -//+ kfree_sensitive(E);
> -//|
> +(
> +- kfree(E)@p;
> ++ kfree_sensitive(E);
> +|
>  - \(vfree\|kvfree\)(E)@p;
>  + kvfree_sensitive(E, size);
> -//)
> +)
>
>  @rp_memset depends on patch@
>  expression E, size;
> @@ -80,7 +77,7 @@ type T;
>        when strict
>  (
>  - kfree(E)@p;
> -+ kzfree(E);
> ++ kfree_sensitive(E);
>  |
>  - \(vfree\|kvfree\)(E)@p;
>  + kvfree_sensitive(E, size);
> @@ -91,11 +88,11 @@ p << r.p;
>  @@
>
>  coccilib.report.print_report(p[0],
> -  "WARNING: opportunity for kzfree/kvfree_sensitive")
> +  "WARNING: opportunity for kfree_sensitive/kvfree_sensitive")
>
>  @script:python depends on org@
>  p << r.p;
>  @@
>
>  coccilib.org.print_todo(p[0],
> -  "WARNING: opportunity for kzfree/kvfree_sensitive")
> +  "WARNING: opportunity for kfree_sensitive/kvfree_sensitive")
> --
> 2.26.2
>
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
