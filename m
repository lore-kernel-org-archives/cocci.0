Return-Path: <SRS0=bgdO=76=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15915C433DF
	for <cocci@archiver.kernel.org>; Wed, 17 Jun 2020 20:43:15 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88843212CC
	for <cocci@archiver.kernel.org>; Wed, 17 Jun 2020 20:43:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88843212CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 05HKh1sD013710;
	Wed, 17 Jun 2020 22:43:01 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A54B67577;
	Wed, 17 Jun 2020 22:43:01 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 30A6A3D0F
 for <cocci@systeme.lip6.fr>; Wed, 17 Jun 2020 22:43:00 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 05HKgxIl020435
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Wed, 17 Jun 2020 22:42:59 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.73,523,1583190000"; d="scan'208";a="351906301"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 17 Jun 2020 22:42:59 +0200
Date: Wed, 17 Jun 2020 22:42:58 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Denis Efremov <efremov@linux.com>
In-Reply-To: <20200614215414.40034-1-efremov@linux.com>
Message-ID: <alpine.DEB.2.22.394.2006172241551.3083@hadrien>
References: <20200604140805.111613-1-efremov@linux.com>
 <20200614215414.40034-1-efremov@linux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 17 Jun 2020 22:43:01 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 17 Jun 2020 22:42:59 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH v3] coccinelle: api: add kzfree script
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



On Mon, 15 Jun 2020, Denis Efremov wrote:

> Check for memset()/memzero_explicit() followed by kfree()/vfree()/kvfree().
>
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
> Changes in v2:
>  - memset_explicit() added
>  - kvfree_sensitive() added
>  - forall added to r1
>  - ... between memset and kfree added
> Changes in v3:
>  - Explicit filter for definitions instead of !(file in "...") conditions
>  - type T added to match casts
>  - memzero_explicit() patterns fixed
>  - additional rule "cond" added to filter false-positives
>
>  scripts/coccinelle/api/kzfree.cocci | 90 +++++++++++++++++++++++++++++
>  1 file changed, 90 insertions(+)
>  create mode 100644 scripts/coccinelle/api/kzfree.cocci
>
> diff --git a/scripts/coccinelle/api/kzfree.cocci b/scripts/coccinelle/api/kzfree.cocci
> new file mode 100644
> index 000000000000..4758ca5a781e
> --- /dev/null
> +++ b/scripts/coccinelle/api/kzfree.cocci
> @@ -0,0 +1,90 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +///
> +/// Use kzfree, kvfree_sensitive rather than memset or
> +/// memzero_explicit followed by kfree
> +///
> +// Confidence: High
> +// Copyright: (C) 2020 Denis Efremov ISPRAS
> +// Options: --no-includes --include-headers
> +//
> +// Keywords: kzfree, kvfree_sensitive
> +//
> +
> +virtual context
> +virtual patch
> +virtual org
> +virtual report
> +
> +@initialize:python@
> +@@
> +# kmalloc_oob_in_memset uses memset to explicitly trigger out-of-bounds access
> +filter = frozenset(['kmalloc_oob_in_memset', 'kzfree', 'kvfree_sensitive'])
> +
> +def relevant(p):
> +    return not (filter & {el.current_element for el in p})
> +
> +@cond@
> +position ok;
> +@@
> +
> +if (...)
> +  \(memset@ok\|memzero_explicit@ok\)(...);
> +
> +@r depends on !patch forall@
> +expression E;
> +position p : script:python() { relevant(p) };
> +position m != cond.ok;
> +type T;
> +@@
> +
> +(
> +* memset@m((T)E, 0, ...);
> +|
> +* memzero_explicit@m((T)E, ...);
> +)
> +  ... when != E
> +      when strict
> +* \(kfree\|vfree\|kvfree\)(E)@p;
> +
> +@rp_memzero depends on patch@
> +expression E, size;
> +position p : script:python() { relevant(p) };
> +type T;
> +@@
> +
> +- memzero_explicit((T)E, size)@p;
> +  ... when != E
> +      when strict
> +- \(kfree\|vfree\|kvfree\)(E);
> ++ kvfree_sensitive(E, size);
> +
> +@rp_memset depends on patch@
> +expression E, size;
> +position p : script:python() { relevant(p) };
> +type T;
> +@@
> +
> +- memset((T)E, size)@p;

This is missing a 0 argument.



> +  ... when != E
> +      when strict
> +(
> +- kfree(E);
> ++ kzfree(E);
> +|
> +- \(vfree\|kvfree\)(E);
> ++ kvfree_sensitive(E, size);
> +)

I'm not sure why you want kzfree in the first case, but kvfree_sensitive
in the second case.

julia


> +
> +@script:python depends on report@
> +p << r.p;
> +@@
> +
> +coccilib.report.print_report(p[0],
> +  "WARNING: opportunity for kzfree/kvfree_sensitive")
> +
> +@script:python depends on org@
> +p << r.p;
> +@@
> +
> +coccilib.org.print_todo(p[0],
> +  "WARNING: opportunity for kzfree/kvfree_sensitive")
> --
> 2.26.2
>
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
