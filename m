Return-Path: <SRS0=EC4o=DW=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8259C433DF
	for <cocci@archiver.kernel.org>; Thu, 15 Oct 2020 20:30:05 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 516262074D
	for <cocci@archiver.kernel.org>; Thu, 15 Oct 2020 20:30:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 516262074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 09FKTYRP023774;
	Thu, 15 Oct 2020 22:29:34 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B689C778E;
	Thu, 15 Oct 2020 22:29:34 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 2A6114500
 for <cocci@systeme.lip6.fr>; Thu, 15 Oct 2020 22:29:33 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 09FKTWBM011897
 for <cocci@systeme.lip6.fr>; Thu, 15 Oct 2020 22:29:32 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.77,380,1596492000"; d="scan'208";a="472841147"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 15 Oct 2020 22:29:32 +0200
Date: Thu, 15 Oct 2020 22:29:31 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Sumera Priyadarsini <sylphrenadin@gmail.com>
In-Reply-To: <20201015105140.sj4dfy2eykkts2tn@adolin>
Message-ID: <alpine.DEB.2.22.394.2010152229160.2869@hadrien>
References: <20201015105140.sj4dfy2eykkts2tn@adolin>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 15 Oct 2020 22:29:35 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 15 Oct 2020 22:29:32 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: linux-kernel@vger.kernel.org, michal.lkml@markovi.net,
        nicolas.palix@imag.fr, cocci@systeme.lip6.fr, Gilles.Muller@lip6.fr
Subject: Re: [Cocci] [PATCH V3] coccinelle: iterators: Add
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



On Thu, 15 Oct 2020, Sumera Priyadarsini wrote:

> While iterating over child nodes with the for_each functions, if
> control is transferred from the middle of the loop, as in the case
> of a break or return or goto, there is no decrement in the
> reference counter thus ultimately resulting in a memory leak.
>
> Add this script to detect potential memory leaks caused by
> the absence of of_node_put() before break, goto, or, return
> statements which transfer control outside the loop.
>
> Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>

Applied, thanks.

julia

>
> ----
> Changes in V2:
> - Add options --include-headers and --no-includes
> - Add 'when forall` to rules for break and goto
>
> Changes in V3:
> - Add return case
> ---
>  .../coccinelle/iterators/for_each_child.cocci | 358 ++++++++++++++++++
>  1 file changed, 358 insertions(+)
>  create mode 100644 scripts/coccinelle/iterators/for_each_child.cocci
>
> diff --git a/scripts/coccinelle/iterators/for_each_child.cocci b/scripts/coccinelle/iterators/for_each_child.cocci
> new file mode 100644
> index 000000000000..bc394615948e
> --- /dev/null
> +++ b/scripts/coccinelle/iterators/for_each_child.cocci
> @@ -0,0 +1,358 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// Adds missing of_node_put() before return/break/goto statement within a for_each iterator for child nodes.
> +//# False positives can be due to function calls within the for_each
> +//# loop that may encapsulate an of_node_put.
> +///
> +// Confidence: High
> +// Copyright: (C) 2020 Sumera Priyadarsini
> +// URL: http://coccinelle.lip6.fr
> +// Options: --no-includes --include-headers
> +
> +virtual patch
> +virtual context
> +virtual org
> +virtual report
> +
> +@r@
> +local idexpression n;
> +expression e1,e2;
> +iterator name for_each_node_by_name, for_each_node_by_type,
> +for_each_compatible_node, for_each_matching_node,
> +for_each_matching_node_and_match, for_each_child_of_node,
> +for_each_available_child_of_node, for_each_node_with_property;
> +iterator i;
> +statement S;
> +expression list [n1] es;
> +@@
> +
> +(
> +(
> +for_each_node_by_name(n,e1) S
> +|
> +for_each_node_by_type(n,e1) S
> +|
> +for_each_compatible_node(n,e1,e2) S
> +|
> +for_each_matching_node(n,e1) S
> +|
> +for_each_matching_node_and_match(n,e1,e2) S
> +|
> +for_each_child_of_node(e1,n) S
> +|
> +for_each_available_child_of_node(e1,n) S
> +|
> +for_each_node_with_property(n,e1) S
> +)
> +&
> +i(es,n,...) S
> +)
> +
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
> +- return of_node_get(n);
> ++ return n;
> +|
> ++  of_node_put(n);
> +?  return ...;
> +)
> +   ... when any
> + }
> +
> +@ruletwo depends on patch && !context && !org && !report@
> +
> +local idexpression r.n;
> +iterator r.i,i1,i2;
> +expression e,e1;
> +expression list [r.n1] es;
> +statement S,S2;
> +@@
> +
> + i(es,n,...) {
> +   ...
> +(
> +   of_node_put(n);
> +|
> +   e = n
> +|
> +   i1(...,n,...) S
> +|
> ++  of_node_put(n);
> +?  break;
> +)
> +   ... when any
> + }
> +... when != n
> +    when strict
> +    when forall
> +(
> + n = e1;
> +|
> +?i2(...,n,...) S2
> +)
> +
> +@rulethree depends on patch && !context && !org && !report exists@
> +
> +local idexpression r.n;
> +iterator r.i,i1,i2;
> +expression e,e1;
> +identifier l;
> +expression list [r.n1] es;
> +statement S,S2;
> +@@
> +
> + i(es,n,...) {
> +   ...
> +(
> +   of_node_put(n);
> +|
> +   e = n
> +|
> +   i1(...,n,...) S
> +|
> ++  of_node_put(n);
> +?  goto l;
> +)
> +   ... when any
> + }
> +... when exists
> +l: ... when != n
> +       when strict
> +       when forall
> +(
> + n = e1;
> +|
> +?i2(...,n,...) S2
> +)
> +
> +// ----------------------------------------------------------------------------
> +
> +@ruleone_context depends on !patch && (context || org || report) exists@
> +statement S;
> +expression e;
> +expression list[r.n1] es;
> +iterator r.i, i1;
> +local idexpression r.n;
> +position j0, j1;
> +@@
> +
> + i@j0(es,n,...) {
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
> +  return @j1 ...;
> +)
> +   ... when any
> + }
> +
> +@ruleone_disj depends on !patch && (context || org || report)@
> +expression list[r.n1] es;
> +iterator r.i;
> +local idexpression r.n;
> +position ruleone_context.j0, ruleone_context.j1;
> +@@
> +
> +*  i@j0(es,n,...) {
> +   ...
> +*return  @j1...;
> +   ... when any
> + }
> +
> +@ruletwo_context depends on !patch && (context || org || report) exists@
> +statement S, S2;
> +expression e, e1;
> +expression list[r.n1] es;
> +iterator r.i, i1, i2;
> +local idexpression r.n;
> +position j0, j2;
> +@@
> +
> + i@j0(es,n,...) {
> +   ...
> +(
> +   of_node_put(n);
> +|
> +   e = n
> +|
> +   i1(...,n,...) S
> +|
> +  break@j2;
> +)
> +   ... when any
> + }
> +... when != n
> +    when strict
> +    when forall
> +(
> + n = e1;
> +|
> +?i2(...,n,...) S2
> +)
> +
> +@ruletwo_disj depends on !patch && (context || org || report)@
> +statement S2;
> +expression e1;
> +expression list[r.n1] es;
> +iterator r.i, i2;
> +local idexpression r.n;
> +position ruletwo_context.j0, ruletwo_context.j2;
> +@@
> +
> +*  i@j0(es,n,...) {
> +   ...
> +*break @j2;
> +   ... when any
> + }
> +... when != n
> +    when strict
> +    when forall
> +(
> +  n = e1;
> +|
> +?i2(...,n,...) S2
> +)
> +
> +@rulethree_context depends on !patch && (context || org || report) exists@
> +identifier l;
> +statement S,S2;
> +expression e, e1;
> +expression list[r.n1] es;
> +iterator r.i, i1, i2;
> +local idexpression r.n;
> +position j0, j3;
> +@@
> +
> + i@j0(es,n,...) {
> +   ...
> +(
> +   of_node_put(n);
> +|
> +   e = n
> +|
> +   i1(...,n,...) S
> +|
> +  goto l@j3;
> +)
> +  ... when any
> + }
> +... when exists
> +l:
> +... when != n
> +    when strict
> +    when forall
> +(
> + n = e1;
> +|
> +?i2(...,n,...) S2
> +)
> +
> +@rulethree_disj depends on !patch && (context || org || report) exists@
> +identifier l;
> +statement S2;
> +expression e1;
> +expression list[r.n1] es;
> +iterator r.i, i2;
> +local idexpression r.n;
> +position rulethree_context.j0, rulethree_context.j3;
> +@@
> +
> +*  i@j0(es,n,...) {
> +   ...
> +*goto l@j3;
> +   ... when any
> + }
> +... when exists
> + l:
> + ... when != n
> +     when strict
> +     when forall
> +(
> + n = e1;
> +|
> +?i2(...,n,...) S2
> +)
> +
> +// ----------------------------------------------------------------------------
> +
> +@script:python ruleone_org depends on org@
> +i << r.i;
> +j0 << ruleone_context.j0;
> +j1 << ruleone_context. j1;
> +@@
> +
> +msg = "WARNING: Function \"%s\" should have of_node_put() before return " % (i)
> +coccilib.org.print_safe_todo(j0[0], msg)
> +coccilib.org.print_link(j1[0], "")
> +
> +@script:python ruletwo_org depends on org@
> +i << r.i;
> +j0 << ruletwo_context.j0;
> +j2 << ruletwo_context.j2;
> +@@
> +
> +msg = "WARNING: Function \"%s\" should have of_node_put() before break " % (i)
> +coccilib.org.print_safe_todo(j0[0], msg)
> +coccilib.org.print_link(j2[0], "")
> +
> +@script:python rulethree_org depends on org@
> +i << r.i;
> +j0 << rulethree_context.j0;
> +j3 << rulethree_context.j3;
> +@@
> +
> +msg = "WARNING: Function \"%s\" should have of_node_put() before goto " % (i)
> +coccilib.org.print_safe_todo(j0[0], msg)
> +coccilib.org.print_link(j3[0], "")
> +
> +// ----------------------------------------------------------------------------
> +
> +@script:python ruleone_report depends on report@
> +i << r.i;
> +j0 << ruleone_context.j0;
> +j1 << ruleone_context.j1;
> +@@
> +
> +msg = "WARNING: Function \"%s\" should have of_node_put() before return around line %s." % (i, j1[0].line)
> +coccilib.report.print_report(j0[0], msg)
> +
> +@script:python ruletwo_report depends on report@
> +i << r.i;
> +j0 << ruletwo_context.j0;
> +j2 << ruletwo_context.j2;
> +@@
> +
> +msg = "WARNING: Function \"%s\" should have of_node_put() before break around line %s." % (i,j2[0].line)
> +coccilib.report.print_report(j0[0], msg)
> +
> +@script:python rulethree_report depends on report@
> +i << r.i;
> +j0 << rulethree_context.j0;
> +j3 << rulethree_context.j3;
> +@@
> +
> +msg = "WARNING: Function \"%s\" should have of_node_put() before goto around lines %s." % (i,j3[0].line)
> +coccilib.report.print_report(j0[0], msg)
> --
> 2.25.1
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
