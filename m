Return-Path: <SRS0=bgdO=76=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51E1C433E0
	for <cocci@archiver.kernel.org>; Wed, 17 Jun 2020 20:31:01 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54EF120776
	for <cocci@archiver.kernel.org>; Wed, 17 Jun 2020 20:31:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54EF120776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 05HKUnAe000734;
	Wed, 17 Jun 2020 22:30:49 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B7F507577;
	Wed, 17 Jun 2020 22:30:49 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 605133D0F
 for <cocci@systeme.lip6.fr>; Wed, 17 Jun 2020 22:30:47 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 05HKUh6e008640
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Wed, 17 Jun 2020 22:30:43 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.73,523,1583190000"; d="scan'208";a="455255405"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 17 Jun 2020 22:30:43 +0200
Date: Wed, 17 Jun 2020 22:30:43 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Denis Efremov <efremov@linux.com>
In-Reply-To: <20200615102045.4558-1-efremov@linux.com>
Message-ID: <alpine.DEB.2.22.394.2006172229550.3083@hadrien>
References: <20200615102045.4558-1-efremov@linux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 17 Jun 2020 22:30:49 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 17 Jun 2020 22:30:43 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH] coccinelle: misc: add array_size_dup script to
 detect missed overlow checks
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

> Detect an opencoded expression that is used before or after
> array_size()/array3_size()/struct_size() to compute the same size.

This would benefit from the assignemnt operator metavariables as well.

Also, it could be better to put the python rules up next the SmPL pattern
matching rules that they are associated with.

julia


>
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
>  scripts/coccinelle/misc/array_size_dup.cocci | 347 +++++++++++++++++++
>  1 file changed, 347 insertions(+)
>  create mode 100644 scripts/coccinelle/misc/array_size_dup.cocci
>
> diff --git a/scripts/coccinelle/misc/array_size_dup.cocci b/scripts/coccinelle/misc/array_size_dup.cocci
> new file mode 100644
> index 000000000000..08919a938754
> --- /dev/null
> +++ b/scripts/coccinelle/misc/array_size_dup.cocci
> @@ -0,0 +1,347 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +///
> +/// Check for array_size(), array3_size(), struct_size() duplicates.
> +/// Three types of patterns for these functions:
> +///  1. An opencoded expression is used before array_size() to compute the same size
> +///  2. An opencoded expression is used after array_size() to compute the same size
> +///  3. Consecutive calls of array_size() with the same values
> +/// From security point of view only first case is relevant. These functions
> +/// perform arithmetic overflow check. Thus, if we use an opencoded expression
> +/// before a call to the *_size() function we can miss an overflow.
> +///
> +// Confidence: High
> +// Copyright: (C) 2020 Denis Efremov ISPRAS
> +// Options: --no-includes --include-headers --no-loops
> +
> +virtual context
> +virtual report
> +virtual org
> +
> +@as@
> +expression E1, E2;
> +@@
> +
> +array_size(E1, E2)
> +
> +@as_next@
> +expression subE1 <= as.E1;
> +expression as.E1;
> +expression subE2 <= as.E2;
> +expression as.E2;
> +expression E3;
> +position p1, p2;
> +@@
> +
> +* E1 * E2@p1
> +  ... when != \(E1\|E2\|subE1\|subE2\)=E3
> +      when != \(E1\|E2\|subE1\|subE2\)+=E3
> +      when != \(E1\|E2\|subE1\|subE2\)-=E3
> +      when != \(E1\|E2\|subE1\|subE2\)*=E3
> +      when != \(&E1\|&E2\|&subE1\|&subE2\)
> +* array_size(E1, E2)@p2
> +
> +@as_prev@
> +expression subE1 <= as.E1;
> +expression as.E1;
> +expression subE2 <= as.E2;
> +expression as.E2;
> +expression E3;
> +position p1, p2;
> +@@
> +
> +* array_size(E1, E2)@p1
> +  ... when != \(E1\|E2\|subE1\|subE2\)=E3
> +      when != \(E1\|E2\|subE1\|subE2\)+=E3
> +      when != \(E1\|E2\|subE1\|subE2\)-=E3
> +      when != \(E1\|E2\|subE1\|subE2\)*=E3
> +      when != \(&E1\|&E2\|&subE1\|&subE2\)
> +* E1 * E2@p2
> +
> +@as_dup@
> +expression subE1 <= as.E1;
> +expression as.E1;
> +expression subE2 <= as.E2;
> +expression as.E2;
> +expression E3;
> +position p1, p2;
> +@@
> +
> +* array_size(E1, E2)@p1
> +  ... when != \(E1\|E2\|subE1\|subE2\)=E3
> +      when != \(E1\|E2\|subE1\|subE2\)+=E3
> +      when != \(E1\|E2\|subE1\|subE2\)-=E3
> +      when != \(E1\|E2\|subE1\|subE2\)*=E3
> +      when != \(&E1\|&E2\|&subE1\|&subE2\)
> +* array_size(E1, E2)@p2
> +
> +@as3@
> +expression E1, E2, E3;
> +@@
> +
> +array3_size(E1, E2, E3)
> +
> +@as3_next@
> +expression subE1 <= as3.E1;
> +expression as3.E1;
> +expression subE2 <= as3.E2;
> +expression as3.E2;
> +expression subE3 <= as3.E3;
> +expression as3.E3;
> +expression E4;
> +position p1, p2;
> +@@
> +
> +* E1 * E2 * E3@p1
> +  ... when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\)=E4
> +      when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\)+=E4
> +      when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\)-=E4
> +      when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\)*=E4
> +      when != \(&E1\|&E2\|&E3\|&subE1\|&subE2\|&subE3\)
> +* array3_size(E1, E2, E3)@p2
> +
> +@as3_prev@
> +expression subE1 <= as3.E1;
> +expression as3.E1;
> +expression subE2 <= as3.E2;
> +expression as3.E2;
> +expression subE3 <= as3.E3;
> +expression as3.E3;
> +expression E4;
> +position p1, p2;
> +@@
> +
> +* array3_size(E1, E2, E3)@p1
> +  ... when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\)=E4
> +      when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\)+=E4
> +      when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\)-=E4
> +      when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\)*=E4
> +      when != \(&E1\|&E2\|&E3\|&subE1\|&subE2\|&subE3\)
> +* E1 * E2 * E3@p2
> +
> +@as3_dup@
> +expression subE1 <= as3.E1;
> +expression as3.E1;
> +expression subE2 <= as3.E2;
> +expression as3.E2;
> +expression subE3 <= as3.E3;
> +expression as3.E3;
> +expression E4;
> +position p1, p2;
> +@@
> +
> +* array3_size(E1, E2, E3)@p1
> +  ... when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\)=E4
> +      when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\)+=E4
> +      when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\)-=E4
> +      when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\)*=E4
> +      when != \(&E1\|&E2\|&E3\|&subE1\|&subE2\|&subE3\)
> +* array3_size(E1, E2, E3)@p2
> +
> +@ss@
> +expression E1, E2, E3;
> +@@
> +
> +struct_size(E1, E2, E3)
> +
> +@ss_next@
> +expression subE1 <= ss.E1;
> +expression ss.E1;
> +expression subE2 <= ss.E2;
> +expression ss.E2;
> +expression subE3 <= ss.E3;
> +expression ss.E3;
> +expression E4;
> +position p1, p2;
> +@@
> +
> +* E1 * E2 + E3@p1
> +  ... when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\)=E4
> +      when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\)+=E4
> +      when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\)-=E4
> +      when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\)*=E4
> +      when != \(&E1\|&E2\|&E3\|&subE1\|&subE2\|&subE3\)
> +* struct_size(E1, E2, E3)@p2
> +
> +@ss_prev@
> +expression subE1 <= ss.E1;
> +expression ss.E1;
> +expression subE2 <= ss.E2;
> +expression ss.E2;
> +expression subE3 <= ss.E3;
> +expression ss.E3;
> +expression E4;
> +position p1, p2;
> +@@
> +
> +* struct_size(E1, E2, E3)@p1
> +  ... when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\)=E4
> +      when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\)+=E4
> +      when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\)-=E4
> +      when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\)*=E4
> +      when != \(&E1\|&E2\|&E3\|&subE1\|&subE2\|&subE3\)
> +* E1 * E2 + E3@p2
> +
> +@ss_dup@
> +expression subE1 <= ss.E1;
> +expression ss.E1;
> +expression subE2 <= ss.E2;
> +expression ss.E2;
> +expression subE3 <= ss.E3;
> +expression ss.E3;
> +expression E4;
> +position p1, p2;
> +@@
> +
> +* struct_size(E1, E2, E3)@p1
> +  ... when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\)=E4
> +      when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\)+=E4
> +      when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\)-=E4
> +      when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\)*=E4
> +      when != \(&E1\|&E2\|&E3\|&subE1\|&subE2\|&subE3\)
> +* struct_size(E1, E2, E3)@p2
> +
> +@script:python depends on report@
> +p1 << as_next.p1;
> +p2 << as_next.p2;
> +@@
> +
> +msg = "WARNING: array_size is used down the code (line %s) to compute the same size" % (p2[0].line)
> +coccilib.report.print_report(p1[0], msg)
> +
> +@script:python depends on org@
> +p1 << as_next.p1;
> +p2 << as_next.p2;
> +@@
> +
> +msg = "WARNING: array_size is used down the code (line %s) to compute the same size" % (p2[0].line)
> +coccilib.org.print_todo(p1[0], msg)
> +
> +@script:python depends on report@
> +p1 << as_prev.p1;
> +p2 << as_prev.p2;
> +@@
> +
> +msg = "WARNING: array_size is already used (line %s) to compute the same size" % (p1[0].line)
> +coccilib.report.print_report(p2[0], msg)
> +
> +@script:python depends on org@
> +p1 << as_prev.p1;
> +p2 << as_prev.p2;
> +@@
> +
> +msg = "WARNING: array_size is already used (line %s) to compute the same size" % (p1[0].line)
> +coccilib.org.print_todo(p2[0], msg)
> +
> +@script:python depends on report@
> +p1 << as_dup.p1;
> +p2 << as_dup.p2;
> +@@
> +
> +msg = "WARNING: same array_size (line %s)" % (p1[0].line)
> +coccilib.report.print_report(p2[0], msg)
> +
> +@script:python depends on org@
> +p1 << as_dup.p1;
> +p2 << as_dup.p2;
> +@@
> +
> +msg = "WARNING: same array_size (line %s)" % (p1[0].line)
> +coccilib.org.print_todo(p2[0], msg)
> +
> +
> +@script:python depends on report@
> +p1 << as3_next.p1;
> +p2 << as3_next.p2;
> +@@
> +
> +msg = "WARNING: array3_size is used down the code (line %s) to compute the same size" % (p2[0].line)
> +coccilib.report.print_report(p1[0], msg)
> +
> +@script:python depends on org@
> +p1 << as3_next.p1;
> +p2 << as3_next.p2;
> +@@
> +
> +msg = "WARNING: array3_size is used down the code (line %s) to compute the same size" % (p2[0].line)
> +coccilib.org.print_todo(p1[0], msg)
> +
> +@script:python depends on report@
> +p1 << as3_prev.p1;
> +p2 << as3_prev.p2;
> +@@
> +
> +msg = "WARNING: array3_size is already used (line %s) to compute the same size" % (p1[0].line)
> +coccilib.report.print_report(p2[0], msg)
> +
> +@script:python depends on org@
> +p1 << as3_prev.p1;
> +p2 << as3_prev.p2;
> +@@
> +
> +msg = "WARNING: array3_size is already used (line %s) to compute the same size" % (p1[0].line)
> +coccilib.org.print_todo(p2[0], msg)
> +
> +@script:python depends on report@
> +p1 << as3_dup.p1;
> +p2 << as3_dup.p2;
> +@@
> +
> +msg = "WARNING: same array3_size (line %s)" % (p1[0].line)
> +coccilib.report.print_report(p2[0], msg)
> +
> +@script:python depends on org@
> +p1 << as3_dup.p1;
> +p2 << as3_dup.p2;
> +@@
> +
> +msg = "WARNING: same array3_size (line %s)" % (p1[0].line)
> +coccilib.org.print_todo(p2[0], msg)
> +
> +
> +@script:python depends on report@
> +p1 << ss_next.p1;
> +p2 << ss_next.p2;
> +@@
> +
> +msg = "WARNING: struct_size is used down the code (line %s) to compute the same size" % (p2[0].line)
> +coccilib.report.print_report(p1[0], msg)
> +
> +@script:python depends on org@
> +p1 << ss_next.p1;
> +p2 << ss_next.p2;
> +@@
> +
> +msg = "WARNING: struct_size is used down the code (line %s) to compute the same size" % (p2[0].line)
> +coccilib.org.print_todo(p1[0], msg)
> +
> +@script:python depends on report@
> +p1 << ss_prev.p1;
> +p2 << ss_prev.p2;
> +@@
> +
> +msg = "WARNING: struct_size is already used (line %s) to compute the same size" % (p1[0].line)
> +coccilib.report.print_report(p2[0], msg)
> +
> +@script:python depends on org@
> +p1 << ss_prev.p1;
> +p2 << ss_prev.p2;
> +@@
> +
> +msg = "WARNING: struct_size is already used (line %s) to compute the same size" % (p1[0].line)
> +coccilib.org.print_todo(p2[0], msg)
> +
> +@script:python depends on report@
> +p1 << ss_dup.p1;
> +p2 << ss_dup.p2;
> +@@
> +
> +msg = "WARNING: same struct_size (line %s)" % (p1[0].line)
> +coccilib.report.print_report(p2[0], msg)
> +
> +@script:python depends on org@
> +p1 << ss_dup.p1;
> +p2 << ss_dup.p2;
> +@@
> +
> +msg = "WARNING: same struct_size (line %s)" % (p1[0].line)
> +coccilib.org.print_todo(p2[0], msg)
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
