Return-Path: <SRS0=KM+6=JY=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC00C433B4
	for <cocci@archiver.kernel.org>; Tue, 27 Apr 2021 15:12:47 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79EB7610FC
	for <cocci@archiver.kernel.org>; Tue, 27 Apr 2021 15:12:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79EB7610FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 13RFCg4X017865;
	Tue, 27 Apr 2021 17:12:42 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A63297634;
	Tue, 27 Apr 2021 17:12:42 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 498833DD8
 for <cocci@systeme.lip6.fr>; Tue, 27 Apr 2021 17:12:41 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 13RFCeCF006639
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Tue, 27 Apr 2021 17:12:40 +0200 (CEST)
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AeBYrFK+ZqKpHeebpqA9uk+GUdb1zdoIgy1kn?=
 =?us-ascii?q?xilNYDZSddGVkN3rge8S0gX6hC1UVHYrn92BP6foewKhybde544NMbC+GBT3oW?=
 =?us-ascii?q?fAFvAe0aLO4R3FXwL/8/NQzs5bHZRWJf/RKRxBjcj86BSlCNpI+ri62Y2hmOu2?=
 =?us-ascii?q?9QYXcShGa7t46R14FwacFQlQQhRHCpoyHIed4M0CmjzIQwVvUu2VHX8ANtKzwO?=
 =?us-ascii?q?HjsJ79exYJC1oG5WC1/FaVwZr7FxTd4RsESTNIxt4ZgAz4ujf07KmirP23oyW0?=
 =?us-ascii?q?vwS4gvg46biRqOdrPtCGicQeN1zX+36VTblmMofy2gwdkaWF7kosmtWJngwpNc?=
 =?us-ascii?q?Zy7H2UXma7p3LWqnPd+Qdr1H/41UXdu3Hqpsv0SVsBa/Z8uQ=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.82,254,1613430000"; d="scan'208";a="379825595"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-SHA;
 27 Apr 2021 17:12:39 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Julia Lawall <Julia.Lawall@inria.fr>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Date: Tue, 27 Apr 2021 16:19:45 +0200
Message-Id: <20210427141946.2478411-1-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 27 Apr 2021 17:12:43 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 27 Apr 2021 17:12:40 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Michal Marek <michal.lkml@markovi.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        kernel-janitors@vger.kernel.org,
        Zhang Qilong <zhangqilong3@huawei.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        cocci@systeme.lip6.fr
Subject: [Cocci] [PATCH v4] coccinelle: api: semantic patch to use
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
statement followed by a pm_runtime_put_noidle call.  The patch
case appears somewhat more complicated, because it also deals with the
cases where {}s need to be removed.

pm_runtime_resume_and_get was introduced in
commit dd8088d5a896 ("PM: runtime: Add pm_runtime_resume_and_get to
deal with usage counter")

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

---
v4: s/pm_runtime_resume_and_get/pm_runtime_put_noidle/ as noted by John Hovold
v3: add the people who signed off on commit dd8088d5a896, expand the log message
v2: better keyword

 scripts/coccinelle/api/pm_runtime_resume_and_get.cocci |  153 +++++++++++++++++
 1 file changed, 153 insertions(+)

diff --git a/scripts/coccinelle/api/pm_runtime_resume_and_get.cocci b/scripts/coccinelle/api/pm_runtime_resume_and_get.cocci
new file mode 100644
index 000000000000..3387cb606f9b
--- /dev/null
+++ b/scripts/coccinelle/api/pm_runtime_resume_and_get.cocci
@@ -0,0 +1,153 @@
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
+@r0 depends on patch && !context && !org && !report@
+expression ret,e;
+@@
+
+-     ret = pm_runtime_get_sync(e);
++     ret = pm_runtime_resume_and_get(e);
+-     if (ret < 0)
+-             pm_runtime_put_noidle(e);
+
+@r1 depends on patch && !context && !org && !report@
+expression ret,e;
+statement S1,S2;
+@@
+
+-     ret = pm_runtime_get_sync(e);
++     ret = pm_runtime_resume_and_get(e);
+      if (ret < 0)
+-     {
+-             pm_runtime_put_noidle(e);
+	      S1
+-     }
+      else S2
+
+@r2 depends on patch && !context && !org && !report@
+expression ret,e;
+statement S;
+@@
+
+-     ret = pm_runtime_get_sync(e);
++     ret = pm_runtime_resume_and_get(e);
+      if (ret < 0) {
+-             pm_runtime_put_noidle(e);
+	      ...
+      } else S
+
+@r3 depends on patch && !context && !org && !report@
+expression ret,e;
+identifier f;
+constant char[] c;
+statement S;
+@@
+
+-     ret = pm_runtime_get_sync(e);
++     ret = pm_runtime_resume_and_get(e);
+      if (ret < 0)
+-     {
+              f(...,c,...);
+-             pm_runtime_put_noidle(e);
+-     }
+      else S
+
+@r4 depends on patch && !context && !org && !report@
+expression ret,e;
+identifier f;
+constant char[] c;
+statement S;
+@@
+
+-     ret = pm_runtime_get_sync(e);
++     ret = pm_runtime_resume_and_get(e);
+      if (ret < 0) {
+              f(...,c,...);
+-             pm_runtime_put_noidle(e);
+	      ...
+      } else S
+
+// ----------------------------------------------------------------------------
+
+@r2_context depends on !patch && (context || org || report)@
+statement S;
+expression e, ret;
+position j0, j1;
+@@
+
+*     ret@j0 = pm_runtime_get_sync(e);
+      if (ret < 0) {
+*             pm_runtime_put_noidle@j1(e);
+	      ...
+      } else S
+
+@r3_context depends on !patch && (context || org || report)@
+identifier f;
+statement S;
+constant char []c;
+expression e, ret;
+position j0, j1;
+@@
+
+*     ret@j0 = pm_runtime_get_sync(e);
+      if (ret < 0) {
+              f(...,c,...);
+*             pm_runtime_put_noidle@j1(e);
+	      ...
+      } else S
+
+// ----------------------------------------------------------------------------
+
+@script:python r2_org depends on org@
+j0 << r2_context.j0;
+j1 << r2_context.j1;
+@@
+
+msg = "WARNING: opportunity for pm_runtime_get_sync"
+coccilib.org.print_todo(j0[0], msg)
+coccilib.org.print_link(j1[0], "")
+
+@script:python r3_org depends on org@
+j0 << r3_context.j0;
+j1 << r3_context.j1;
+@@
+
+msg = "WARNING: opportunity for pm_runtime_get_sync"
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
+msg = "WARNING: opportunity for pm_runtime_get_sync on line %s." % (j0[0].line)
+coccilib.report.print_report(j0[0], msg)
+
+@script:python r3_report depends on report@
+j0 << r3_context.j0;
+j1 << r3_context.j1;
+@@
+
+msg = "WARNING: opportunity for pm_runtime_get_sync on %s." % (j0[0].line)
+coccilib.report.print_report(j0[0], msg)
+

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
