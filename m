Return-Path: <SRS0=EC4o=DW=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D38C433DF
	for <cocci@archiver.kernel.org>; Thu, 15 Oct 2020 20:49:04 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 025872072D
	for <cocci@archiver.kernel.org>; Thu, 15 Oct 2020 20:49:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 025872072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 09FKmmW4019164;
	Thu, 15 Oct 2020 22:48:48 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 767AA778E;
	Thu, 15 Oct 2020 22:48:48 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 49DA64500
 for <cocci@systeme.lip6.fr>; Thu, 15 Oct 2020 22:48:46 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 09FKmijf009879
 for <cocci@systeme.lip6.fr>; Thu, 15 Oct 2020 22:48:44 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.77,380,1596492000"; d="scan'208";a="472842063"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 15 Oct 2020 22:48:44 +0200
Date: Thu, 15 Oct 2020 22:48:44 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Denis Efremov <efremov@linux.com>
In-Reply-To: <20200803183438.34685-1-efremov@linux.com>
Message-ID: <alpine.DEB.2.22.394.2010152246260.2869@hadrien>
References: <20200605204237.85055-1-efremov@linux.com>
 <20200803183438.34685-1-efremov@linux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 15 Oct 2020 22:48:48 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 15 Oct 2020 22:48:44 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH v7] coccinelle: api: add kfree_mismatch script
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


[See below for a comment]

On Mon, 3 Aug 2020, Denis Efremov wrote:

> Check that alloc and free types of functions match each other.
>
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
> Changes in v2:
>  - Lines are limited to 80 characters where possible
>  - Confidence changed from High to Medium because of
>    fs/btrfs/send.c:1119 false-positive
>  - __vmalloc_area_node() explicitly excluded from analysis
>    instead of !(file in "mm/vmalloc.c") condition
> Changes in v3:
>  - prints style in org && report modes changed for python2
> Changes in v4:
>  - missing msg argument to print_todo fixed
> Changes in v5:
>  - fix position p in kfree rule
>  - move @kok and @v positions in choice rule after the arguments
>  - remove kvmalloc suggestions
> Changes in v6:
>  - more asterisks added in context mode
>  - second @kok added to the choice rule
> Changes in v7:
>  - file renamed to kfree_mismatch.cocci
>  - python function relevant() removed
>  - additional rule for filtering free positions added
>  - btrfs false-positive fixed
>  - confidence level changed to high
>  - kvfree_switch rule added
>  - names for position variables changed to @a (alloc) and @f (free)
>
>  scripts/coccinelle/api/kfree_mismatch.cocci | 229 ++++++++++++++++++++
>  1 file changed, 229 insertions(+)
>  create mode 100644 scripts/coccinelle/api/kfree_mismatch.cocci
>
> diff --git a/scripts/coccinelle/api/kfree_mismatch.cocci b/scripts/coccinelle/api/kfree_mismatch.cocci
> new file mode 100644
> index 000000000000..9e9ef9fd7a25
> --- /dev/null
> +++ b/scripts/coccinelle/api/kfree_mismatch.cocci
> @@ -0,0 +1,229 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +///
> +/// Check that kvmalloc'ed memory is freed by kfree functions,
> +/// vmalloc'ed by vfree functions and kvmalloc'ed by kvfree
> +/// functions.
> +///
> +// Confidence: High
> +// Copyright: (C) 2020 Denis Efremov ISPRAS
> +// Options: --no-includes --include-headers
> +//
> +
> +virtual patch
> +virtual report
> +virtual org
> +virtual context
> +
> +@alloc@
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
> +  if (E == NULL) {
> +    ...
> +    E = \(vmalloc\|vzalloc\|vmalloc_user\|vmalloc_node\|
> +          vzalloc_node\|vmalloc_exec\|vmalloc_32\|
> +          vmalloc_32_user\|__vmalloc\|__vmalloc_node_range\|
> +          __vmalloc_node\)(...)@vok
> +    ...
> +  }
> +)
> +
> +@free@
> +expression E;
> +position fok;
> +@@
> +
> +  E = \(kvmalloc\|kvzalloc\|kvcalloc\|kvzalloc_node\|kvmalloc_node\|
> +        kvmalloc_array\)(...)
> +  ...
> +  kvfree(E)@fok
> +
> +@vfree depends on !patch@
> +expression E;
> +position a != alloc.kok;
> +position f != free.fok;
> +@@
> +
> +* E = \(kmalloc\|kzalloc\|krealloc\|kcalloc\|kmalloc_node\|
> +*       kzalloc_node\|kmalloc_array\|kmalloc_array_node\|
> +*       kcalloc_node\)(...)@a
> +  ... when != if (...) { ... E = \(vmalloc\|vzalloc\|vmalloc_user\|vmalloc_node\|vzalloc_node\|vmalloc_exec\|vmalloc_32\|vmalloc_32_user\|__vmalloc\|__vmalloc_node_range\|__vmalloc_node\)(...); ... }
> +      when != is_vmalloc_addr(E)
> +      when any
> +* \(vfree\|vfree_atomic\|kvfree\)(E)@f
> +
> +@depends on patch exists@
> +expression E;
> +position a != alloc.kok;
> +position f != free.fok;
> +@@
> +
> +  E = \(kmalloc\|kzalloc\|krealloc\|kcalloc\|kmalloc_node\|
> +        kzalloc_node\|kmalloc_array\|kmalloc_array_node\|
> +        kcalloc_node\)(...)@a
> +  ... when != if (...) { ... E = \(vmalloc\|vzalloc\|vmalloc_user\|vmalloc_node\|vzalloc_node\|vmalloc_exec\|vmalloc_32\|vmalloc_32_user\|__vmalloc\|__vmalloc_node_range\|__vmalloc_node\)(...); ... }
> +      when != is_vmalloc_addr(E)
> +      when any
> +- \(vfree\|vfree_atomic\|kvfree\)(E)@f
> ++ kfree(E)
> +
> +@kfree depends on !patch@
> +expression E;
> +position a != alloc.vok;
> +position f != free.fok;
> +@@
> +
> +* E = \(vmalloc\|vzalloc\|vmalloc_user\|vmalloc_node\|vzalloc_node\|
> +*       vmalloc_exec\|vmalloc_32\|vmalloc_32_user\|__vmalloc\|
> +*       __vmalloc_node_range\|__vmalloc_node\)(...)@a
> +  ... when != is_vmalloc_addr(E)
> +      when any
> +* \(kfree\|kzfree\|kvfree\)(E)@f
> +
> +@depends on patch exists@
> +expression E;
> +position a != alloc.vok;
> +position f != free.fok;
> +@@
> +
> +  E = \(vmalloc\|vzalloc\|vmalloc_user\|vmalloc_node\|vzalloc_node\|
> +        vmalloc_exec\|vmalloc_32\|vmalloc_32_user\|__vmalloc\|
> +        __vmalloc_node_range\|__vmalloc_node\)(...)@a
> +  ... when != is_vmalloc_addr(E)
> +      when any
> +- \(kfree\|kvfree\)(E)@f
> ++ vfree(E)
> +
> +@kvfree depends on !patch@
> +expression E;
> +position a, f;
> +@@
> +
> +* E = \(kvmalloc\|kvzalloc\|kvcalloc\|kvzalloc_node\|kvmalloc_node\|
> +*       kvmalloc_array\)(...)@a
> +  ... when != is_vmalloc_addr(E)
> +      when any
> +* \(kfree\|kzfree\|vfree\|vfree_atomic\)(E)@f
> +
> +@depends on patch exists@
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
> +@kvfree_switch depends on !patch@
> +expression alloc.E;
> +position f != free.fok;
> +@@
> +
> +  ... when != is_vmalloc_addr(E)
> +      when any
> +* \(kfree\|kzfree\|vfree\|vfree_atomic\)(E)@f
> +
> +@depends on patch exists@
> +expression alloc.E;
> +position f != free.fok;
> +@@
> +
> +  ... when != is_vmalloc_addr(E)
> +      when any
> +(
> +- \(kfree\|vfree\)(E)@f
> ++ kvfree(E)
> +|
> +- kzfree(E)@f
> ++ kvfree_sensitive(E)
> +)


The above two rules refer to free.fok, but it is not clear why, because
free.fok only occurs on a kvfree call.  Is there a mistake, or is it just
an unnecessary copy-pasted constraint?

julia


> +
> +@script: python depends on report@
> +a << vfree.a;
> +f << vfree.f;
> +@@
> +
> +msg = "WARNING: kmalloc is used to allocate this memory at line %s" % (a[0].line)
> +coccilib.report.print_report(f[0], msg)
> +
> +@script: python depends on org@
> +a << vfree.a;
> +f << vfree.f;
> +@@
> +
> +msg = "WARNING: kmalloc is used to allocate this memory at line %s" % (a[0].line)
> +coccilib.org.print_todo(f[0], msg)
> +
> +@script: python depends on report@
> +a << kfree.a;
> +f << kfree.f;
> +@@
> +
> +msg = "WARNING: vmalloc is used to allocate this memory at line %s" % (a[0].line)
> +coccilib.report.print_report(f[0], msg)
> +
> +@script: python depends on org@
> +a << kfree.a;
> +f << kfree.f;
> +@@
> +
> +msg = "WARNING: vmalloc is used to allocate this memory at line %s" % (a[0].line)
> +coccilib.org.print_todo(f[0], msg)
> +
> +@script: python depends on report@
> +a << kvfree.a;
> +f << kvfree.f;
> +@@
> +
> +msg = "WARNING: kvmalloc is used to allocate this memory at line %s" % (a[0].line)
> +coccilib.report.print_report(f[0], msg)
> +
> +@script: python depends on org@
> +a << kvfree.a;
> +f << kvfree.f;
> +@@
> +
> +msg = "WARNING: kvmalloc is used to allocate this memory at line %s" % (a[0].line)
> +coccilib.org.print_todo(f[0], msg)
> +
> +@script: python depends on report@
> +ka << alloc.kok;
> +va << alloc.vok;
> +f << kvfree_switch.f;
> +@@
> +
> +msg = "WARNING: kmalloc (line %s) && vmalloc (line %s) are used to allocate this memory" % (ka[0].line, va[0].line)
> +coccilib.report.print_report(f[0], msg)
> +
> +@script: python depends on org@
> +ka << alloc.kok;
> +va << alloc.vok;
> +f << kvfree_switch.f;
> +@@
> +
> +msg = "WARNING: kmalloc (line %s) && vmalloc (line %s) are used to allocate this memory" % (ka[0].line, va[0].line)
> +coccilib.org.print_todo(f[0], msg)
> +
> --
> 2.26.2
>
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
