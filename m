Return-Path: <SRS0=k3NR=DT=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 904FDC433E7
	for <cocci@archiver.kernel.org>; Mon, 12 Oct 2020 17:19:39 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE90720878
	for <cocci@archiver.kernel.org>; Mon, 12 Oct 2020 17:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uXeZybEO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE90720878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 09CHJIDM010703;
	Mon, 12 Oct 2020 19:19:18 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 3678F74CE;
	Mon, 12 Oct 2020 19:19:18 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id A25A94500
 for <cocci@systeme.lip6.fr>; Mon, 12 Oct 2020 19:19:16 +0200 (CEST)
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:541])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 09CHJF4t023183
 for <cocci@systeme.lip6.fr>; Mon, 12 Oct 2020 19:19:15 +0200 (CEST)
Received: by mail-pg1-x541.google.com with SMTP id h6so14948232pgk.4
 for <cocci@systeme.lip6.fr>; Mon, 12 Oct 2020 10:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
 bh=vzqIrfL5tQGfCDq/e194NCPT321X2oYruUrL6Phu1Gc=;
 b=uXeZybEO9E4gStg0B9aDvmKZL0+BvJDAfXXYFXSSuzJ+S+CAUgg+WLDNaoz3Rqa4EO
 gnfxIEzG5gb7eSaQVP72VamEhXeW21if6zPP1y87EnVtPLlqX1R6nXid2pbuXVQctc06
 WJst6BrMrG1puAKCwmZPPaAvwviByQLvSqipYMdSYAIfOa5VDh3hM1/2bqBsxTAG9j7v
 e3AbQcGwzQlA2+i0KX07YPvFfMZUbCkSam/AEVWqFHi+D05RVWaIdwHvySG72C67B8oQ
 ggCTi0zbQdbxzigeIv7KoJJ5vPsu5bxQK+MmJELYzVdYJeAO6GVdnmav4bBGiGcHtN+v
 7cEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=vzqIrfL5tQGfCDq/e194NCPT321X2oYruUrL6Phu1Gc=;
 b=r2u72FzAJDkOAe52E7ydrX7Xhid6Xq+fVB7D9fpRhtH0Qp9wSPT/dB8DJoKHNmrymK
 xCFbshp21jqxEZ3zVa0CyGBVpvgI+TE7f6ypyrp1kmLPOBIQ6DEYY9BMiMgMe8V0+ENK
 7S80wMpeVt7feg19DPvaNZt/FtXPUHWSjpPjvB/248ci783ZgShWFhvHCYYINzO4HdVb
 /IbmaAIgvtfOtmFxUfKDVJ8Yj0M+RZl2BXkSObJ59CyzmLFVDT+eHvuwig7B5CtLspR2
 slUJIswd7bOGSuL6CshmwdrROEDUNpXaxZwqwBsvb6wdq6xBrqqkrcq0/0e6kgGb7+yD
 wnUw==
X-Gm-Message-State: AOAM53313RRb0z/Z0qlTTFBFN7Jm6cWZib98nW6IEYr92Oi+u7AIQCDI
 xHMdQU5MsD7WuRzjoXrU6y9q29/rFDfuMg==
X-Google-Smtp-Source: ABdhPJzjAH2/0cY8tZgvBF03akxLc2+C0qOrux9D5km6QbZ5T/r92m7CZB+pIRz9vxt655AVUYZZbA==
X-Received: by 2002:a17:90a:6582:: with SMTP id
 k2mr21123691pjj.139.1602523154510; 
 Mon, 12 Oct 2020 10:19:14 -0700 (PDT)
Received: from adolin ([49.207.194.162])
 by smtp.gmail.com with ESMTPSA id t9sm20219051pgp.90.2020.10.12.10.19.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 10:19:13 -0700 (PDT)
Date: Mon, 12 Oct 2020 22:49:09 +0530
From: Sumera Priyadarsini <sylphrenadin@gmail.com>
To: cocci@systeme.lip6.fr
Message-ID: <20201012171909.ihbx73evyj5dosxl@adolin>
MIME-Version: 1.0
Content-Disposition: inline
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 12 Oct 2020 19:19:18 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 12 Oct 2020 19:19:16 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: Julia.Lawall@lip6.fr, michal.lkml@markovi.net, nicolas.palix@imag.fr,
        linux-kernel@vger.kernel.org, Gilles.Muller@lip6.fr
Subject: [Cocci] [PATCH V2] coccinelle: iterators: Add for_each_child.cocci
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

----
Changes in V2:
- Add options --include-headers and --no-includes
- Add 'when forall` to rules for break and goto
---
 .../coccinelle/iterators/for_each_child.cocci | 355 ++++++++++++++++++
 1 file changed, 355 insertions(+)
 create mode 100644 scripts/coccinelle/iterators/for_each_child.cocci

diff --git a/scripts/coccinelle/iterators/for_each_child.cocci b/scripts/coccinelle/iterators/for_each_child.cocci
new file mode 100644
index 000000000000..57caf9b8d7a5
--- /dev/null
+++ b/scripts/coccinelle/iterators/for_each_child.cocci
@@ -0,0 +1,355 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Adds missing of_node_put() before return/break/goto statement within a for_each iterator for child nodes.
+//# False positives can be due to function calls within the for_each
+//# loop that may encapsulate an of_node_put.
+///
+// Confidence: High
+// Copyright: (C) 2020 Sumera Priyadarsini
+// URL: http://coccinelle.lip6.fr
+// Options: --no-includes --include-headers
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
+    when forall
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
+       when forall
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
+    when forall
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
+    when forall
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
+    when forall
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
+     when forall
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
