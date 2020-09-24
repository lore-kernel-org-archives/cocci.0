Return-Path: <SRS0=fIkn=DB=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30BEAC4363D
	for <cocci@archiver.kernel.org>; Thu, 24 Sep 2020 10:35:50 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24E9023772
	for <cocci@archiver.kernel.org>; Thu, 24 Sep 2020 10:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DUmmxAMH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24E9023772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08OAZDDB005429;
	Thu, 24 Sep 2020 12:35:13 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 0D281778D;
	Thu, 24 Sep 2020 12:35:13 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id ABE7A4452
 for <cocci@systeme.lip6.fr>; Thu, 24 Sep 2020 12:35:11 +0200 (CEST)
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:543])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08OAZA8i007358
 for <cocci@systeme.lip6.fr>; Thu, 24 Sep 2020 12:35:10 +0200 (CEST)
Received: by mail-pg1-x543.google.com with SMTP id k133so1644911pgc.7
 for <cocci@systeme.lip6.fr>; Thu, 24 Sep 2020 03:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
 bh=KmL8vyp508qdUeyaBVJz9l+cgP9HDZJMrQi87MgxIv4=;
 b=DUmmxAMHLA6Y6oxNLR2+SJoV/M+GCSY+YgJ0JwuJLuqCHyNxGqcfGE7MzvPvC/J0SA
 s7hMLn+miAtVg6f7c+L0mZ9PwbJbnlhwlcc7ATP/jtFGrRjWkA7FM3N3gDyWcZsh47uO
 ASsQWM4RO5y2CW4ZzUlwYMSgwqte8vLf0Kl9p07GDcl8BqBxSTNBJ3J5wTlyYQAYItex
 7RTAvxRWISz5QdW4LOkxZbmxulxkXv8OpqvlsLNIvB7yXPC1f4NLetx3dcT057h15lGs
 RZ31yy3JnIdsEXlTRtcSv9gh5N+MHTtJ6GPA3R+IQs1BiJJWzvB8GdYExl1AykDJwhaC
 B7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=KmL8vyp508qdUeyaBVJz9l+cgP9HDZJMrQi87MgxIv4=;
 b=nJyYRHi8+fUTToKBUo0K9tFgpmBJVzhHBYHnliY1WzPpLaqBKUs6k/aJR+NVsusGQm
 nx5TJykTrOYgx67xn6aPbP9UU54hXhFMh3vIEkAT5dVq1+kRclTjVnK3X7ij53RGN0YP
 z5qZJtRDJ6Lj7OHXYtNIch6AeBO0RV60eChgcCgjHinoJacFCBipaXtiXGG9gTBkJzut
 RrXKuapRPrldHj6jiRV4FSihhtx733sG3OABU7mOfpFvzbkAifceEhhFch3DbRB6o/ri
 wGs7GU7AKmuvQfS67ilNH043KhXvRNLXzmb85Gwi/daMo3cgaYMVXdsyI5Sml0avycsZ
 xgiw==
X-Gm-Message-State: AOAM533PTzsY7NGnoxIM7HBitxrUcbWNNbPHLhndqJ00ceI+jWnxI+gy
 JGXgen//PbnXudKKwLa1ouU+poJjhDiQD2hO
X-Google-Smtp-Source: ABdhPJytKP3vyuFyNa5Y6imfCslsQO3tcklFOkHwdlUx8Ztc787slznKAU0VMbgxGRDZ1sd1bgahDw==
X-Received: by 2002:aa7:8583:0:b029:13f:7096:5eb with SMTP id
 w3-20020aa785830000b029013f709605ebmr4044342pfn.0.1600943709678; 
 Thu, 24 Sep 2020 03:35:09 -0700 (PDT)
Received: from adolin ([49.207.208.43])
 by smtp.gmail.com with ESMTPSA id nl10sm1816511pjb.11.2020.09.24.03.35.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2020 03:35:09 -0700 (PDT)
Date: Thu, 24 Sep 2020 16:05:04 +0530
From: Sumera Priyadarsini <sylphrenadin@gmail.com>
To: cocci@systeme.lip6.fr
Message-ID: <20200924103504.2ceibylmerdzgmct@adolin>
MIME-Version: 1.0
Content-Disposition: inline
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 24 Sep 2020 12:35:13 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Thu, 24 Sep 2020 12:35:11 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: Julia.Lawall@lip6.fr, michal.lkml@markovi.net, nicolas.palix@imag.fr,
        linux-kernel@vger.kernel.org, Gilles.Muller@lip6.fr
Subject: [Cocci] [PATCH] coccinelle: iterators: Add for_each_child.cocci
 script
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

While iterating over child nodes with the for_each functions, if
control is transferred from the middle of the loop, as in the case
of a break or return or goto, there is no decrement in the
reference counter thus ultimately resulting in a memory leak.

Add this script to detect potential memory leaks caused by
the absence of of_node_put() before break, goto, or, return
statements which transfer control outside the loop.

Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
---
 .../coccinelle/iterators/for_each_child.cocci | 348 ++++++++++++++++++
 1 file changed, 348 insertions(+)
 create mode 100644 scripts/coccinelle/iterators/for_each_child.cocci

diff --git a/scripts/coccinelle/iterators/for_each_child.cocci b/scripts/coccinelle/iterators/for_each_child.cocci
new file mode 100644
index 000000000000..0abc12ca2ad3
--- /dev/null
+++ b/scripts/coccinelle/iterators/for_each_child.cocci
@@ -0,0 +1,348 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Adds missing of_node_put() before return/break/goto statement within a for_each iterator for child nodes.
+//# False positives can be due to function calls within the for_each
+//# loop that may encapsulate an of_node_put.
+///
+// Confidence: High
+// Copyright: (C) 2020 Sumera Priyadarsini
+// URL: http://coccinelle.lip6.fr
+
+virtual patch
+virtual context
+virtual org
+virtual report
+
+@r@
+local idexpression n;
+expression e1,e2;
+iterator name for_each_node_by_name, for_each_node_by_type,
+for_each_compatible_node, for_each_matching_node,
+for_each_matching_node_and_match, for_each_child_of_node,
+for_each_available_child_of_node, for_each_node_with_property;
+iterator i;
+statement S;
+expression list [n1] es;
+@@
+
+(
+(
+for_each_node_by_name(n,e1) S
+|
+for_each_node_by_type(n,e1) S
+|
+for_each_compatible_node(n,e1,e2) S
+|
+for_each_matching_node(n,e1) S
+|
+for_each_matching_node_and_match(n,e1,e2) S
+|
+for_each_child_of_node(e1,n) S
+|
+for_each_available_child_of_node(e1,n) S
+|
+for_each_node_with_property(n,e1) S
+)
+&
+i(es,n,...) S
+)
+
+@ruleone depends on patch && !context && !org && !report@
+
+local idexpression r.n;
+iterator r.i,i1;
+expression e;
+expression list [r.n1] es;
+statement S;
+@@
+
+ i(es,n,...) {
+   ...
+(
+   of_node_put(n);
+|
+   e = n
+|
+   return n;
+|
+   i1(...,n,...) S
+|
++  of_node_put(n);
+?  return ...;
+)
+   ... when any
+ }
+
+@ruletwo depends on patch && !context && !org && !report@
+
+local idexpression r.n;
+iterator r.i,i1,i2;
+expression e,e1;
+expression list [r.n1] es;
+statement S,S2;
+@@
+
+ i(es,n,...) {
+   ...
+(
+   of_node_put(n);
+|
+   e = n
+|
+   i1(...,n,...) S
+|
++  of_node_put(n);
+?  break;
+)
+   ... when any
+ }
+... when != n
+    when strict
+(
+ n = e1;
+|
+?i2(...,n,...) S2
+)
+
+@rulethree depends on patch && !context && !org && !report exists@
+
+local idexpression r.n;
+iterator r.i,i1,i2;
+expression e,e1;
+identifier l;
+expression list [r.n1] es;
+statement S,S2;
+@@
+
+ i(es,n,...) {
+   ...
+(
+   of_node_put(n);
+|
+   e = n
+|
+   i1(...,n,...) S
+|
++  of_node_put(n);
+?  goto l;
+)
+   ... when any
+ }
+... when exists
+l: ... when != n
+       when strict
+(
+ n = e1;
+|
+?i2(...,n,...) S2
+)
+
+// ----------------------------------------------------------------------------
+
+@ruleone_context depends on !patch && (context || org || report) exists@
+statement S;
+expression e;
+expression list[r.n1] es;
+iterator r.i, i1;
+local idexpression r.n;
+position j0, j1;
+@@
+
+ i@j0(es,n,...) {
+   ...
+(
+   of_node_put(n);
+|
+   e = n
+|
+   return n;
+|
+   i1(...,n,...) S
+|
+  return @j1 ...;
+)
+   ... when any
+ }
+
+@ruleone_disj depends on !patch && (context || org || report)@
+expression list[r.n1] es;
+iterator r.i;
+local idexpression r.n;
+position ruleone_context.j0, ruleone_context.j1;
+@@
+
+*  i@j0(es,n,...) {
+   ...
+*return  @j1...;
+   ... when any
+ }
+
+@ruletwo_context depends on !patch && (context || org || report) exists@
+statement S, S2;
+expression e, e1;
+expression list[r.n1] es;
+iterator r.i, i1, i2;
+local idexpression r.n;
+position j0, j2;
+@@
+
+ i@j0(es,n,...) {
+   ...
+(
+   of_node_put(n);
+|
+   e = n
+|
+   i1(...,n,...) S
+|
+  break@j2;
+)
+   ... when any
+ }
+... when != n
+    when strict
+(
+ n = e1;
+|
+?i2(...,n,...) S2
+)
+
+@ruletwo_disj depends on !patch && (context || org || report)@
+statement S2;
+expression e1;
+expression list[r.n1] es;
+iterator r.i, i2;
+local idexpression r.n;
+position ruletwo_context.j0, ruletwo_context.j2;
+@@
+
+*  i@j0(es,n,...) {
+   ...
+*break @j2;
+   ... when any
+ }
+... when != n
+    when strict
+(
+  n = e1;
+|
+?i2(...,n,...) S2
+)
+
+@rulethree_context depends on !patch && (context || org || report) exists@
+identifier l;
+statement S,S2;
+expression e, e1;
+expression list[r.n1] es;
+iterator r.i, i1, i2;
+local idexpression r.n;
+position j0, j3;
+@@
+
+ i@j0(es,n,...) {
+   ...
+(
+   of_node_put(n);
+|
+   e = n
+|
+   i1(...,n,...) S
+|
+  goto l@j3;
+)
+  ... when any
+ }
+... when exists
+l:
+... when != n
+    when strict
+(
+ n = e1;
+|
+?i2(...,n,...) S2
+)
+
+@rulethree_disj depends on !patch && (context || org || report) exists@
+identifier l;
+statement S2;
+expression e1;
+expression list[r.n1] es;
+iterator r.i, i2;
+local idexpression r.n;
+position rulethree_context.j0, rulethree_context.j3;
+@@
+
+*  i@j0(es,n,...) {
+   ...
+*goto l@j3;
+   ... when any
+ }
+... when exists
+ l:
+ ... when != n
+     when strict
+(
+ n = e1;
+|
+?i2(...,n,...) S2
+)
+
+// ----------------------------------------------------------------------------
+
+@script:python ruleone_org depends on org@
+i << r.i;
+j0 << ruleone_context.j0;
+j1 << ruleone_context. j1;
+@@
+
+msg = "WARNING: Function \"%s\" should have of_node_put() before return " % (i)
+coccilib.org.print_safe_todo(j0[0], msg)
+coccilib.org.print_link(j1[0], "")
+
+@script:python ruletwo_org depends on org@
+i << r.i;
+j0 << ruletwo_context.j0;
+j2 << ruletwo_context.j2;
+@@
+
+msg = "WARNING: Function \"%s\" should have of_node_put() before break " % (i)
+coccilib.org.print_safe_todo(j0[0], msg)
+coccilib.org.print_link(j2[0], "")
+
+@script:python rulethree_org depends on org@
+i << r.i;
+j0 << rulethree_context.j0;
+j3 << rulethree_context.j3;
+@@
+
+msg = "WARNING: Function \"%s\" should have of_node_put() before goto " % (i)
+coccilib.org.print_safe_todo(j0[0], msg)
+coccilib.org.print_link(j3[0], "")
+
+// ----------------------------------------------------------------------------
+
+@script:python ruleone_report depends on report@
+i << r.i;
+j0 << ruleone_context.j0;
+j1 << ruleone_context.j1;
+@@
+
+msg = "WARNING: Function \"%s\" should have of_node_put() before return around line %s." % (i, j1[0].line)
+coccilib.report.print_report(j0[0], msg)
+
+@script:python ruletwo_report depends on report@
+i << r.i;
+j0 << ruletwo_context.j0;
+j2 << ruletwo_context.j2;
+@@
+
+msg = "WARNING: Function \"%s\" should have of_node_put() before break around line %s." % (i,j2[0].line)
+coccilib.report.print_report(j0[0], msg)
+
+@script:python rulethree_report depends on report@
+i << r.i;
+j0 << rulethree_context.j0;
+j3 << rulethree_context.j3;
+@@
+
+msg = "WARNING: Function \"%s\" should have of_node_put() before goto around lines %s." % (i,j3[0].line)
+coccilib.report.print_report(j0[0], msg)
-- 
2.25.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
