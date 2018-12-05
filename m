Return-Path: <SRS0=Yxto=OO=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC48C04EB9
	for <cocci@archiver.kernel.org>; Wed,  5 Dec 2018 06:56:32 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F4182082B
	for <cocci@archiver.kernel.org>; Wed,  5 Dec 2018 06:56:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F4182082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id wB56uI1m014776
          ; Wed, 5 Dec 2018 07:56:18 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 7A68B76DA;
	Wed,  5 Dec 2018 07:56:18 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 6EF0B76D4
 for <cocci@systeme.lip6.fr>; Wed,  5 Dec 2018 07:56:16 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id wB56uFIt019576
 for <cocci@systeme.lip6.fr>; Wed, 5 Dec 2018 07:56:15 +0100 (CET)
X-pt: isis.lip6.fr
X-Addr-Warning: ATTENTION - Votre correspondant a fourni une adresse
 d'enveloppe @lip6.fr, mais ce message ne provient pas
 de lip6.fr ! postmaster@lip6.fr.
X-IronPort-AV: E=Sophos;i="5.56,317,1539640800"; d="scan'208";a="358832890"
Received: from abo-91-111-68.mrs.modulonet.fr (HELO hadrien) ([85.68.111.91])
 by mail2-relais-roc.national.inria.fr with
 ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Dec 2018 07:56:15 +0100
Date: Wed, 5 Dec 2018 07:56:15 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Timur Tabi <timur@kernel.org>
In-Reply-To: <CAOZdJXXqgro7gn6ZkX=1CCN=22U1NF=_S-mAgPsgZmC4HV-+GQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1812050753320.2670@hadrien>
References: <CAOZdJXXqgro7gn6ZkX=1CCN=22U1NF=_S-mAgPsgZmC4HV-+GQ@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 05 Dec 2018 07:56:19 +0100 (CET)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Wed, 05 Dec 2018 07:56:15 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] warning: line 202: should __func__ be a metavariable?
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



On Tue, 4 Dec 2018, Timur Tabi wrote:

> I have some rules and Python code that removes __FUNCTION__ as a
> parameter in a call to a function.  That all works great.  I now want
> it to remove __func__ in exactly the same way.  So I copy/pasted my
> rules and just changed __FUNCTION__ to __func__, but spatch complains:
>
> warning: line 202: should __func__ be a metavariable?
> warning: line 218: should __func__ be a metavariable?
> warning: line 229: should __func__ be a metavariable?
>
> I don't even know what this means.  Here is one rule that fails:
>
> // Look for NV_PRINTF2 calls that have __func__ as the first parameter
> @r2b depends on rules@
> constant char[] c;
> expression x;
> @@
> NV_PRINTF2(x, c, __func__, ...)

Typically function names and field names might be metavariables or might
be specific desired names, so there is no check for them.  On the other
hand, other kinds of expressions are often represented as metavariables,
and a common mistake is to forget to declare one of them.  So Coccinelle
gives a warning if such a thing is not declared as a metavariable.  You
can silence the warning by adding the metavariable declaration

symbol __func__;

which means to match that thing explicitly.  Once you do that in one rule,
it applies thereafter.

julia

>
> // Get rid of __func__ at the beginning of the string
> @script:python s2b@
> c << r2b.c;
> c2;
> @@
> import re
> coccinelle.c2 = re.sub('%s[: ]*', '', c, 1)
>
> @depends on rules@
> expression x;
> constant char[] r2b.c;
> identifier s2b.c2;
> @@
> NV_PRINTF2(x,
> -c, __func__
> +c2
> ,...);
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
