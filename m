Return-Path: <SRS0=zfpL=BM=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7119CC433DF
	for <cocci@archiver.kernel.org>; Sun,  2 Aug 2020 20:24:43 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6F262072A
	for <cocci@archiver.kernel.org>; Sun,  2 Aug 2020 20:24:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6F262072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 072KOOva015757;
	Sun, 2 Aug 2020 22:24:24 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 2C25276BF;
	Sun,  2 Aug 2020 22:24:24 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 8360A4084
 for <cocci@systeme.lip6.fr>; Sun,  2 Aug 2020 22:24:22 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 072KOLsS003798
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 2 Aug 2020 22:24:21 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.75,427,1589234400"; d="scan'208";a="462198836"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 02 Aug 2020 22:24:21 +0200
Date: Sun, 2 Aug 2020 22:24:21 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Denis Efremov <efremov@linux.com>
In-Reply-To: <20200731210026.7186-1-efremov@linux.com>
Message-ID: <alpine.DEB.2.22.394.2008022142550.2531@hadrien>
References: <20200605204237.85055-1-efremov@linux.com>
 <20200731210026.7186-1-efremov@linux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 02 Aug 2020 22:24:24 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 02 Aug 2020 22:24:21 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH v6] coccinelle: api: add kvfree script
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

> +@initialize:python@
> +@@
> +# low-level memory api
> +filter = frozenset(['__vmalloc_area_node'])
> +
> +def relevant(p):
> +    return not (filter & {el.current_element for el in p})

Is this used?

Otherwise, I think it would be good to not warn about a use of kvfree
if that use is reachable from a kvmalloc.  There seems to be such a false
positive in fs/btrfs/send.c, on line 1118.

It also seems that when there are both a kmalloc and a vmalloc, there is
no warning if kfree or vfree is used.  Is that intentional?

julia


> +
> +@choice@
> +expression E, E1;
> +position kok, vok;
> +@@
> +
> +(
> +  if (...) {
> +    ...
> +    E = \(kmalloc\|kzalloc\|krealloc\|kcalloc\|
> +          kmalloc_node\|kzalloc_node\|kmalloc_array\|
> +          kmalloc_array_node\|kcalloc_node\)(...)@kok
> +    ...
> +  } else {
> +    ...
> +    E = \(vmalloc\|vzalloc\|vmalloc_user\|vmalloc_node\|
> +          vzalloc_node\|vmalloc_exec\|vmalloc_32\|
> +          vmalloc_32_user\|__vmalloc\|__vmalloc_node_range\|
> +          __vmalloc_node\)(...)@vok
> +    ...
> +  }
> +|
> +  E = \(kmalloc\|kzalloc\|krealloc\|kcalloc\|kmalloc_node\|kzalloc_node\|
> +        kmalloc_array\|kmalloc_array_node\|kcalloc_node\)(...)@kok
> +  ... when != E = E1
> +      when any
> +  if (\(!E\|E == NULL\)) {
> +    ...
> +    E = \(vmalloc\|vzalloc\|vmalloc_user\|vmalloc_node\|
> +          vzalloc_node\|vmalloc_exec\|vmalloc_32\|
> +          vmalloc_32_user\|__vmalloc\|__vmalloc_node_range\|
> +          __vmalloc_node\)(...)@vok
> +    ...
> +  }
> +)
> +
> +@vfree depends on !patch@
> +expression E;
> +position k != choice.kok;
> +position p;
> +@@
> +
> +* E = \(kmalloc\|kzalloc\|krealloc\|kcalloc\|kmalloc_node\|
> +*       kzalloc_node\|kmalloc_array\|kmalloc_array_node\|
> +*       kcalloc_node\)(...)@k
> +  ... when != if (...) { ... E = \(vmalloc\|vzalloc\|vmalloc_user\|vmalloc_node\|vzalloc_node\|vmalloc_exec\|vmalloc_32\|vmalloc_32_user\|__vmalloc\|__vmalloc_node_range\|__vmalloc_node\)(...); ... }
> +      when != is_vmalloc_addr(E)
> +      when any
> +* \(vfree\|vfree_atomic\|kvfree\)(E)@p
> +
> +@pvfree depends on patch exists@
> +expression E;
> +position k != choice.kok;
> +@@
> +
> +  E = \(kmalloc\|kzalloc\|krealloc\|kcalloc\|kmalloc_node\|
> +        kzalloc_node\|kmalloc_array\|kmalloc_array_node\|
> +        kcalloc_node\)(...)@k
> +  ... when != if (...) { ... E = \(vmalloc\|vzalloc\|vmalloc_user\|vmalloc_node\|vzalloc_node\|vmalloc_exec\|vmalloc_32\|vmalloc_32_user\|__vmalloc\|__vmalloc_node_range\|__vmalloc_node\)(...); ... }
> +      when != is_vmalloc_addr(E)
> +      when any
> +- \(vfree\|vfree_atomic\|kvfree\)(E)
> ++ kfree(E)
> +
> +@kfree depends on !patch@
> +expression E;
> +position v != choice.vok;
> +position p;
> +@@
> +
> +* E = \(vmalloc\|vzalloc\|vmalloc_user\|vmalloc_node\|vzalloc_node\|
> +*       vmalloc_exec\|vmalloc_32\|vmalloc_32_user\|__vmalloc\|
> +*       __vmalloc_node_range\|__vmalloc_node\)(...)@v
> +  ... when != !is_vmalloc_addr(E)
> +      when any
> +* \(kfree\|kzfree\|kvfree\)(E)@p
> +
> +@pkfree depends on patch exists@
> +expression E;
> +position v != choice.vok;
> +@@
> +
> +  E = \(vmalloc\|vzalloc\|vmalloc_user\|vmalloc_node\|vzalloc_node\|
> +        vmalloc_exec\|vmalloc_32\|vmalloc_32_user\|__vmalloc\|
> +        __vmalloc_node_range\|__vmalloc_node\)(...)@v
> +  ... when != !is_vmalloc_addr(E)
> +      when any
> +- \(kfree\|kvfree\)(E)
> ++ vfree(E)
> +
> +@kvfree depends on !patch@
> +expression E;
> +position p, k;
> +@@
> +
> +* E = \(kvmalloc\|kvzalloc\|kvcalloc\|kvzalloc_node\|kvmalloc_node\|
> +*       kvmalloc_array\)(...)@k
> +  ... when != is_vmalloc_addr(E)
> +      when any
> +* \(kfree\|kzfree\|vfree\|vfree_atomic\)(E)@p
> +
> +@pkvfree depends on patch exists@
> +expression E;
> +@@
> +
> +  E = \(kvmalloc\|kvzalloc\|kvcalloc\|kvzalloc_node\|kvmalloc_node\|
> +        kvmalloc_array\)(...)
> +  ... when != is_vmalloc_addr(E)
> +      when any
> +- \(kfree\|vfree\)(E)
> ++ kvfree(E)
> +
> +@script: python depends on report@
> +k << vfree.k;
> +p << vfree.p;
> +@@
> +
> +msg = "WARNING: kmalloc is used to allocate this memory at line %s" % (k[0].line)
> +coccilib.report.print_report(p[0], msg)
> +
> +@script: python depends on org@
> +k << vfree.k;
> +p << vfree.p;
> +@@
> +
> +msg = "WARNING: kmalloc is used to allocate this memory at line %s" % (k[0].line)
> +coccilib.org.print_todo(p[0], msg)
> +
> +@script: python depends on report@
> +v << kfree.v;
> +p << kfree.p;
> +@@
> +
> +msg = "WARNING: vmalloc is used to allocate this memory at line %s" % (v[0].line)
> +coccilib.report.print_report(p[0], msg)
> +
> +@script: python depends on org@
> +v << kfree.v;
> +p << kfree.p;
> +@@
> +
> +msg = "WARNING: vmalloc is used to allocate this memory at line %s" % (v[0].line)
> +coccilib.org.print_todo(p[0], msg)
> +
> +@script: python depends on report@
> +k << kvfree.k;
> +p << kvfree.p;
> +@@
> +
> +msg = "WARNING: kvmalloc is used to allocate this memory at line %s" % (k[0].line)
> +coccilib.report.print_report(p[0], msg)
> +
> +@script: python depends on org@
> +k << kvfree.k;
> +p << kvfree.p;
> +@@
> +
> +msg = "WARNING: kvmalloc is used to allocate this memory at line %s" % (k[0].line)
> +coccilib.org.print_todo(p[0], msg)
> --
> 2.26.2
>
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
