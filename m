Return-Path: <SRS0=uPFL=JW=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C04C433ED
	for <cocci@archiver.kernel.org>; Sun, 25 Apr 2021 12:47:11 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FA8A6128B
	for <cocci@archiver.kernel.org>; Sun, 25 Apr 2021 12:47:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FA8A6128B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 13PCl0wB005066;
	Sun, 25 Apr 2021 14:47:01 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A2DD977D7;
	Sun, 25 Apr 2021 14:47:00 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 48F383E3B
 for <cocci@systeme.lip6.fr>; Sun, 25 Apr 2021 14:46:58 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 13PCksCP017684
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 25 Apr 2021 14:46:55 +0200 (CEST)
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Agv/EXKzF9Ek1yNBf8EWTKrPw571zdoIgy1kn?=
 =?us-ascii?q?xilNYDZeG/b0q+mFmvMH2RjozAsLUHY7ltyafIWGS3XQ9Zl6iLNhXouKcQH6tA?=
 =?us-ascii?q?KTQ71KwpDlx1TbcBHW0s54+eNef7NlCNv2ZGIbse/f7BOjG9gthPmLmZrHuc7k?=
 =?us-ascii?q?w31gTR5nZshbhm9EIzyGGU57ThQuP/YEPaebj/AsmxOQPVAebsG2HRA+PtT+mw?=
 =?us-ascii?q?=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.82,250,1613430000"; d="scan'208";a="379598642"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-SHA;
 25 Apr 2021 14:46:54 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Julia Lawall <Julia.Lawall@inria.fr>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Sun, 25 Apr 2021 13:55:32 +0200
Message-Id: <20210425115532.2447295-1-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 25 Apr 2021 14:47:04 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 25 Apr 2021 14:46:55 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Nicolas Palix <nicolas.palix@imag.fr>, kernel-janitors@vger.kernel.org,
        cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: [Cocci] [PATCH] coccinelle: api: semantic patch to use
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
count is unlikely to be needed in the failure case.

pm_runtime_resume_and_get was introduced in
commit dd8088d5a896 ("PM: runtime: Add pm_runtime_resume_and_get to
deal with usage counter")

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
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
+// Keywords: kwd
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
