Return-Path: <SRS0=jYvI=VC=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF010C5B57D
	for <cocci@archiver.kernel.org>; Fri,  5 Jul 2019 06:17:25 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 630B02082E
	for <cocci@archiver.kernel.org>; Fri,  5 Jul 2019 06:17:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 630B02082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x656H7Oj026074;
	Fri, 5 Jul 2019 08:17:07 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id BB73F777B;
	Fri,  5 Jul 2019 08:17:07 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 39C3D777B
 for <cocci@systeme.lip6.fr>; Fri,  5 Jul 2019 08:17:06 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x656H4mN018817
 for <cocci@systeme.lip6.fr>; Fri, 5 Jul 2019 08:17:04 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.63,454,1557180000"; d="scan'208";a="312501121"
Received: from abo-12-105-68.mrs.modulonet.fr (HELO hadrien) ([85.68.105.12])
 by mail3-relais-sop.national.inria.fr with
 ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jul 2019 08:17:03 +0200
Date: Fri, 5 Jul 2019 08:17:03 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: wen.yang99@zte.com.cn
In-Reply-To: <201907051357245235750@zte.com.cn>
Message-ID: <alpine.DEB.2.21.1907050811110.18245@hadrien>
References: 1561690732-20694-1-git-send-email-wen.yang99@zte.com.cn,
 201907041103003504524@zte.com.cn,
 alpine.DEB.2.21.1907050727550.18245@hadrien <201907051357245235750@zte.com.cn>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1434881685-1562307423=:18245"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 05 Jul 2019 08:17:08 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Fri, 05 Jul 2019 08:17:04 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: wang.yi59@zte.com.cn, michal.lkml@markovi.net, nicolas.palix@imag.fr,
        linux-kernel@vger.kernel.org, Markus.Elfring@web.de,
        cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH v2] coccinelle: semantic code search
 formissingof_node_put
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
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1434881685-1562307423=:18245
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Fri, 5 Jul 2019, wen.yang99@zte.com.cn wrote:

> > > > > > +x = @p1\(of_find_all_nodes\|
> > > > >
> > > > > I would find this SmPL disjunction easier to read without the usage
> > > > > of extra backslashes.
> > > > >
> > > > > +x =
> > > > > +(of_…
> > > > > +|of_…
> > > > > +)@p1(...);
> > > >
> > > > Did you actually test this?  I doubt that a position metavariable can be
> > > > put on a ) of a disjunction.
> > > >
> > > > > > +|
> > > > > > +return x;
> > > > > > +|
> > > > > > +return of_fwnode_handle(x);
> > > > >
> > > > > Can a nested SmPL disjunction be helpful at such places?
> > > > >
> > > > > +|return
> > > > > +(x
> > > > > +|of_fwnode_handle(x)
> > > > > +);
> > > >
> > > > The original code is much more readable.  The internal representation will
> > > > be the same.
> > > >
> > > > > > +    when != v4l2_async_notifier_add_fwnode_subdev(<...x...>)
> > > > >
> > > > > Would the specification variant “<+... x ...+>” be relevant
> > > > > for the parameter selection?
> > > >
> > > > I'm indeed quite surprised that <...x...> would be accepted by the parser..
> > >
> > > Hi julia,
> > >
> > > Thank you for your comments.
> > > We tested and found that both <...x...> and <+... x ...+> variants work fine.
> > > We use <... x ...> instead of <+... x ...+> here to eliminate the following false positives:
> > >
> > > ./drivers/media/platform/qcom/camss/camss.c:504:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 479, but without a corresponding object release within this function.
> > >
> > > 465 static int camss_of_parse_ports(struct camss *camss)
> > > 466 {
> > > ...
> > > 479 remote = of_graph_get_remote_port_parent(node);
> > > ...
> > > 486 asd = v4l2_async_notifier_add_fwnode_subdev(
> > > 487 &camss->notifier, of_fwnode_handle(remote), ---> v4l2_async_notifier_add_fwnode_subdev will pass remote to camss->notifier.
> > > 488 sizeof(*csd));
> > > ...
> > > 504 return num_subdevs;
> >
> > I suspect that what is happening is that there is a runtime error, but
> > that error is caught somewhere and you don't see it.
>
> Thanks.
> You are right, there is indeed a runtime error.
> Since make coccicheck adds the "-very-quiet" parameter by default, we didn't find it.
>
> $ spatch --sp-file   of_node_put.cocci   -D report drivers/media/platform/am437x/am437x-vpfe.c
> init_defs_builtins: /usr/local/bin/../lib/coccinelle/standard.h
> HANDLING: drivers/media/platform/am437x/am437x-vpfe.c
> exn while in timeout_function
> only handling multi and no when code in a nest expr
>
> >  Could you send me again the entire semantic patch so I can check on this?
> >
>
> Thanks.
> The entire SmPL is as follows:
>
> $ cat of_node_put.cocci
> // SPDX-License-Identifier: GPL-2.0
> /// Find missing of_node_put
> ///
> // Confidence: Moderate
> // Copyright: (C) 2018-2019 Wen Yang, ZTE.
> // Comments:
> // Options: --no-includes --include-headers
>
> virtual report
> virtual org
>
> @initialize:python@
> @@
>
> seen = set()
>
> def add_if_not_present (p1, p2):
>     if (p1, p2) not in seen:
>         seen.add((p1, p2))
>         return True
>     return False

Did you need this?  Normally a script rule is run only once for each set
of bindings for the inherited variables.  I guess that multiple p1s could
lead to the same p2, and you only want to report on one of them?

This set is going to be global to the whole kernel, or at least to all of
the files considered by a given thread, if you use -j.  To clean it up on
each file, you can make another python at the end that depends on r1 or r2
and depends on report.  This rule can clear seen.

Otherwise, it looks fine.

julia


>
> def display_report(p1, p2):
>     if add_if_not_present(p1[0].line, p2[0].line):
>        coccilib.report.print_report(p2[0],
>                                     "ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line "
>                                     + p1[0].line
>                                     + ", but without a corresponding object release within this function.")
>
> def display_org(p1, p2):
>     cocci.print_main("acquired a node pointer with refcount incremented", p1)
>     cocci.print_secs("needed of_node_put", p2)
>
> @r1 exists@
> local idexpression struct device_node *x;
> expression e, e1;
> position p1, p2;
> statement S;
> type T;
> @@
>
> x = @p1\(of_find_all_nodes\|
>          of_get_cpu_node\|
>          of_get_parent\|
>          of_get_next_parent\|
>          of_get_next_child\|
>          of_get_next_cpu_node\|
>          of_get_compatible_child\|
>          of_get_child_by_name\|
>          of_find_node_opts_by_path\|
>          of_find_node_by_name\|
>          of_find_node_by_type\|
>          of_find_compatible_node\|
>          of_find_node_with_property\|
>          of_find_matching_node_and_match\|
>          of_find_node_by_phandle\|
>          of_parse_phandle\|
>          of_find_next_cache_node\|
>          of_get_next_available_child\)(...);
> ...
> if (x == NULL || ...) S
> ... when != e = (T)x
>     when != true x == NULL
>     when != of_node_put(x)
>     when != of_get_next_parent(x)
>     when != of_find_matching_node(x, ...)
>     when != if (x) { ... return x; }
>     when != v4l2_async_notifier_add_fwnode_subdev(<...x...>)
>     when != e1 = of_fwnode_handle(x)
> (
> if (x) { ... when forall
>          of_node_put(x) ... }
> |
> return x;
> |
> return of_fwnode_handle(x);
> |
> return@p2 ...;
> )
>
> @script:python depends on report && r1@

No need to depend on r1.  That is guaranteed by the inheritance on the
metavariables below.

> p1 << r1.p1;
> p2 << r1.p2;
> @@
>
> display_report(p1, p2)
>
> @script:python depends on org && r1@
> p1 << r1.p1;
> p2 << r1.p2;
> @@
>
> display_org(p1, p2)
>
> @r2 exists@
> local idexpression struct device_node *x;
> expression e, e1;
> position p1, p2;
> identifier f;
> statement S;
> type T;
> @@
>
> (
> x = f@p1(...);
> ... when != e = (T)x
>     when != true x == NULL
>     when != of_node_put(x)
>     when != of_get_next_parent(x)
>     when != of_find_matching_node(x, ...)
>     when != if (x) { ... return x; }
>     when != v4l2_async_notifier_add_fwnode_subdev(<...x...>)
>     when != e1 = of_fwnode_handle(x)
> (
> if (x) { ... when forall
>          of_node_put(x) ... }
> |
> return x;
> |
> return of_fwnode_handle(x);
> |
> return@p2 ...;
> )
> &
> x = f(...)
> ...
> if (<+...x...+>) S
> ...
> of_node_put(x);
> )
> @script:python depends on report && r2@
> p1 << r2.p1;
> p2 << r2.p2;
> @@
>
> display_report(p1, p2)
>
> @script:python depends on org && r2@
> p1 << r2.p1;
> p2 << r2.p2;
> @@
>
> display_org(p1, p2)
>
> > I think that what you want is:
> >
> > when != v4l2_async_notifier_add_fwnode_subdev(...,<+...x...+>,...)
> >
> > ie x occurring somewhere within some argument.
>
> Thank you very much for your suggestion.
> Applying it will solve this problem, thank you.
>
> --
> Thanks and regards,
> Wen
--8323329-1434881685-1562307423=:18245
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-1434881685-1562307423=:18245--
