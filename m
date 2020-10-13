Return-Path: <SRS0=ddCJ=DU=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A0EC433E7
	for <cocci@archiver.kernel.org>; Tue, 13 Oct 2020 10:31:08 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FA2E2080A
	for <cocci@archiver.kernel.org>; Tue, 13 Oct 2020 10:31:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FA2E2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 09DAUegx009454;
	Tue, 13 Oct 2020 12:30:40 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 3BB5174CE;
	Tue, 13 Oct 2020 12:30:40 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 78A06578C
 for <cocci@systeme.lip6.fr>; Tue, 13 Oct 2020 12:30:38 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 09DAUaaX001442
 for <cocci@systeme.lip6.fr>; Tue, 13 Oct 2020 12:30:36 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.77,370,1596492000"; d="scan'208";a="472338857"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 13 Oct 2020 12:30:36 +0200
Date: Tue, 13 Oct 2020 12:30:36 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Sumera Priyadarsini <sylphrenadin@gmail.com>
In-Reply-To: <20201012171909.ihbx73evyj5dosxl@adolin>
Message-ID: <alpine.DEB.2.22.394.2010131226130.2674@hadrien>
References: <20201012171909.ihbx73evyj5dosxl@adolin>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 13 Oct 2020 12:30:40 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 13 Oct 2020 12:30:36 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Gilles.Muller@lip6.fr, michal.lkml@markovi.net, nicolas.palix@imag.fr,
        cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH V2] coccinelle: iterators: Add
 for_each_child.cocci script
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

I have one more change to suggest.  This one only affects the patch case,
as the other cases just point to a problem but don't ompletely specify
what to do about it.

> +@ruleone depends on patch && !context && !org && !report@
> +
> +local idexpression r.n;
> +iterator r.i,i1;
> +expression e;
> +expression list [r.n1] es;
> +statement S;
> +@@
> +
> + i(es,n,...) {
> +   ...
> +(
> +   of_node_put(n);
> +|
> +   e = n
> +|
> +   return n;
> +|
> +   i1(...,n,...) S
> +|
> ++  of_node_put(n);
> +?  return ...;
> +)
> +   ... when any
> + }

There is one occurrence of the following code:

        for_each_available_child_of_node(search, child) {
                name = of_get_property(child, "regulator-compatible", NULL);
                if (!name)
                        name = child->name;

                if (!strcmp(desc->of_match, name)) {
                        of_node_put(search);
                        return of_node_get(child);
                }
        }

In this case, the for_each_available_child_of_node has incremented the
reference count of child by 1, and then the return increments it again.
It would be ok to put an of_not_put before the return, which is done by
the above rule, but the code would be even simpler if it would just leave
the reference count as is.  So before the current return case, you can put
another return case that does the following:

-  return of_node_get(n);
+  return n;

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
