Return-Path: <SRS0=oR/p=KM=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA86C433B4
	for <cocci@archiver.kernel.org>; Mon, 17 May 2021 20:46:20 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 897E2610E9
	for <cocci@archiver.kernel.org>; Mon, 17 May 2021 20:46:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 897E2610E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 14HKkD4d001593;
	Mon, 17 May 2021 22:46:13 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id C00DE77DD;
	Mon, 17 May 2021 22:46:13 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7ED053D0C
 for <cocci@systeme.lip6.fr>; Mon, 17 May 2021 22:46:11 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 14HKk856028040
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 17 May 2021 22:46:08 +0200 (CEST)
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ADDX/CK6zpIQM/dBgXwPXwNHXdLJyesId70hD?=
 =?us-ascii?q?6qm+c3Fom6uj5qOTdZsguiMc5Ax7ZJhCo7C90de7L080nKQdibX5Vo3PYOCJgg?=
 =?us-ascii?q?GVxflZjLff/w=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.82,307,1613430000"; d="scan'208";a="381672824"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-SHA;
 17 May 2021 22:46:07 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Julia Lawall <Julia.Lawall@inria.fr>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Date: Mon, 17 May 2021 21:38:10 +0200
Message-Id: <20210517193810.2793785-1-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 17 May 2021 22:46:14 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 17 May 2021 22:46:08 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Michal Marek <michal.lkml@markovi.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        kernel-janitors@vger.kernel.org,
        Zhang Qilong <zhangqilong3@huawei.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        cocci@systeme.lip6.fr, Jonathan Cameron <jic23@kernel.org>
Subject: [Cocci] [PATCH v6] coccinelle: api: semantic patch to use
	pm_runtime_resume_and_get
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

pm_runtime_get_sync keeps a reference count on failure, which can lead
to leaks.  pm_runtime_resume_and_get drops the reference count in the
failure case.  This rule very conservatively follows the definition of
pm_runtime_resume_and_get to address the cases where the reference
count is unlikely to be needed in the failure case.  Specifically, the
change is only done when pm_runtime_get_sync is followed immediately
by an if and when the branch of the if is immediately a call to
pm_runtime_put_noidle (like in the definition of
pm_runtime_resume_and_get) or something that is likely a print
statement followed by a pm_runtime_put_noidle call.

The change is furthermore only done when the ret variable is only used
in a ret < 0 test and possibly in the associated branch.  No change is
made if ret is used in the else branch (the rule bad) or after the if.
This is because pm_runtime_resume_and_get only returns 0 (success) or
a negative value (failure), while pm_runtime_get_sync may also return
1 in the success case.  Thus more attention is required to make the
change in a case where a 1 value might be observed.

The patch case appears somewhat more complicated than the others,
because it aolso deals with the cases where {}s need to be removed.

pm_runtime_resume_and_get was introduced in
commit dd8088d5a896 ("PM: runtime: Add pm_runtime_resume_and_get to
deal with usage counter")

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

---
v6: don't touch code that reuses the value of ret, as suggested by Mauro Carvalho Chehab
v5: print a message with the new function name, as suggested by Markus Elfring
v4: s/pm_runtime_resume_and_get/pm_runtime_put_noidle/ as noted by John Hovold
v3: add the people who signed off on commit dd8088d5a896, expand the log message
v2: better keyword

 scripts/coccinelle/api/pm_runtime_resume_and_get.cocci |  185 +++++++++++++++++
 1 file changed, 185 insertions(+)

diff --git a/scripts/coccinelle/api/pm_runtime_resume_and_get.cocci b/scripts/coccinelle/api/pm_runtime_resume_and_get.cocci
new file mode 100644
index 000000000000..b5abb3783d3d
--- /dev/null
+++ b/scripts/coccinelle/api/pm_runtime_resume_and_get.cocci
@@ -0,0 +1,185 @@
+// SPDX-License-Identifier: GPL-2.0-only
+///
+/// Use pm_runtime_resume_and_get.
+/// pm_runtime_get_sync keeps a reference count on failure,
+/// which can lead to leaks.  pm_runtime_resume_and_get
+/// drops the reference count in the failure case.
+/// This rule addresses the cases where the reference count
+/// is unlikely to be needed in the failure case.
+///
+// Confidence: High
+// Copyright: (C) 2021 Julia Lawall, Inria
+// URL: https://coccinelle.gitlabpages.inria.fr/website
+// Options: --include-headers --no-includes
+// Keywords: pm_runtime_get_sync
+
+virtual patch
+virtual context
+virtual org
+virtual report
+
+@bad exists@
+expression ret;
+statement S1;
+position p;
+@@
+
+ ret = pm_runtime_get_sync(...);
+ if@p (ret < 0) S1
+ else {<+... ret ...+>}
+
+@r0 depends on patch && !context && !org && !report@
+expression ret,e,e1;
+@@
+
+-     ret = pm_runtime_get_sync(e);
++     ret = pm_runtime_resume_and_get(e);
+-     if (ret < 0)
+-             pm_runtime_put_noidle(e);
+      ... when != ret
+?     ret = e1
+
+@r1 depends on patch && !context && !org && !report@
+expression ret,e,e1;
+statement S1,S2;
+position p != bad.p;
+@@
+
+-     ret = pm_runtime_get_sync(e);
++     ret = pm_runtime_resume_and_get(e);
+      if@p (ret < 0)
+-     {
+-             pm_runtime_put_noidle(e);
+	      S1
+-     }
+      else S2
+      ... when != ret
+?     ret = e1
+
+@r2 depends on patch && !context && !org && !report@
+expression ret,e,e1;
+statement S;
+position p != bad.p;
+@@
+
+-     ret = pm_runtime_get_sync(e);
++     ret = pm_runtime_resume_and_get(e);
+      if@p (ret < 0) {
+-             pm_runtime_put_noidle(e);
+	      ...
+      } else S
+      ... when != ret
+?     ret = e1
+
+@r3 depends on patch && !context && !org && !report@
+expression ret,e,e1;
+identifier f;
+constant char[] c;
+position p != bad.p;
+statement S;
+@@
+
+-     ret = pm_runtime_get_sync(e);
++     ret = pm_runtime_resume_and_get(e);
+      if@p (ret < 0)
+-     {
+              f(...,c,...);
+-             pm_runtime_put_noidle(e);
+-     }
+      else S
+      ... when != ret
+?     ret = e1
+
+@r4 depends on patch && !context && !org && !report@
+expression ret,e,e1;
+identifier f;
+constant char[] c;
+position p != bad.p;
+statement S;
+@@
+
+-     ret = pm_runtime_get_sync(e);
++     ret = pm_runtime_resume_and_get(e);
+      if@p (ret < 0) {
+              f(...,c,...);
+-             pm_runtime_put_noidle(e);
+	      ...
+      } else S
+      ... when != ret
+?     ret = e1
+
+// ----------------------------------------------------------------------------
+
+@r2_context depends on !patch && (context || org || report)@
+statement S;
+expression e, ret, e1;
+position j0, j1;
+position p != bad.p;
+@@
+
+*     ret@j0 = pm_runtime_get_sync(e);
+      if@p (ret < 0) {
+*             pm_runtime_put_noidle@j1(e);
+	      ...
+      } else S
+      ... when != ret
+          when forall
+?     ret = e1
+
+@r3_context depends on !patch && (context || org || report)@
+identifier f;
+statement S;
+constant char []c;
+expression e, ret, e1;
+position j0, j1;
+position p != bad.p;
+@@
+
+*     ret@j0 = pm_runtime_get_sync(e);
+      if@p (ret < 0) {
+              f(...,c,...);
+*             pm_runtime_put_noidle@j1(e);
+	      ...
+      } else S
+      ... when != ret
+          when forall
+?     ret = e1
+
+// ----------------------------------------------------------------------------
+
+@script:python r2_org depends on org@
+j0 << r2_context.j0;
+j1 << r2_context.j1;
+@@
+
+msg = "WARNING: opportunity for pm_runtime_resume_and_get"
+coccilib.org.print_todo(j0[0], msg)
+coccilib.org.print_link(j1[0], "")
+
+@script:python r3_org depends on org@
+j0 << r3_context.j0;
+j1 << r3_context.j1;
+@@
+
+msg = "WARNING: opportunity for pm_runtime_resume_and_get"
+coccilib.org.print_todo(j0[0], msg)
+coccilib.org.print_link(j1[0], "")
+
+// ----------------------------------------------------------------------------
+
+@script:python r2_report depends on report@
+j0 << r2_context.j0;
+j1 << r2_context.j1;
+@@
+
+msg = "WARNING: opportunity for pm_runtime_resume_and_get on line %s." % (j0[0].line)
+coccilib.report.print_report(j0[0], msg)
+
+@script:python r3_report depends on report@
+j0 << r3_context.j0;
+j1 << r3_context.j1;
+@@
+
+msg = "WARNING: opportunity for pm_runtime_resume_and_get on %s." % (j0[0].line)
+coccilib.report.print_report(j0[0], msg)
+

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
