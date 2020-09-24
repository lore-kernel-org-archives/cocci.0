Return-Path: <SRS0=fIkn=DB=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED36C4363D
	for <cocci@archiver.kernel.org>; Thu, 24 Sep 2020 12:29:09 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2547C206A5
	for <cocci@archiver.kernel.org>; Thu, 24 Sep 2020 12:29:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2547C206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08OCO5Aw020287;
	Thu, 24 Sep 2020 14:24:05 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 18A2B778D;
	Thu, 24 Sep 2020 14:24:05 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id D7BBB4452
 for <cocci@systeme.lip6.fr>; Thu, 24 Sep 2020 14:24:03 +0200 (CEST)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08OCO2pR021961
 for <cocci@systeme.lip6.fr>; Thu, 24 Sep 2020 14:24:03 +0200 (CEST)
IronPort-SDR: 0j/7ELyMsXC632E40m2UE+maRjKQ3bgcKA1Mf4icWybcn+vZ6ji7YzMI9RoyE2G6YDTSbk4RQf
 fIyMw0HIqJUg==
X-IronPort-AV: E=McAfee;i="6000,8403,9753"; a="158562148"
X-IronPort-AV: E=Sophos;i="5.77,297,1596524400"; d="scan'208";a="158562148"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2020 05:24:01 -0700
IronPort-SDR: ISIDr2pBNgkCDud9iDp95cuQ+U//+UNSDUGbPUGBeuUvmeu6oRrBDQVwbQXYBRRZ6eb66M4+/L
 pMVe4S2ZVQiA==
X-IronPort-AV: E=Sophos;i="5.77,297,1596524400"; d="scan'208";a="486882125"
Received: from dgurdan-mobl.ger.corp.intel.com (HELO
 elena-ThinkPad-X1-Carbon-6th.ger.corp.intel.com) ([10.252.43.142])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2020 05:23:58 -0700
From: Elena Reshetova <elena.reshetova@intel.com>
To: Julia.Lawall@lip6.fr
Date: Thu, 24 Sep 2020 15:22:59 +0300
Message-Id: <20200924122259.1357095-1-elena.reshetova@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 24 Sep 2020 14:24:05 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 24 Sep 2020 14:24:03 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: michal.lkml@markovi.net, keescook@chromium.org, Gilles.Muller@lip6.fr,
        nicolas.palix@imag.fr, Dan Carpenter <dan.carpenter@oracle.com>,
        cocci@systeme.lip6.fr
Subject: [Cocci] [PATCH] coccinelle: api/atomic_as_refcounter: Improve
	verbosity
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

When atomic_as_refcounter script is used by 0day CI and
the findings are automatically reported, the message that
it gives is confusing to people. I.e. it does not actually
state what should be done.

Add more information to the message output.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
---
 scripts/coccinelle/api/atomic_as_refcounter.cocci | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/scripts/coccinelle/api/atomic_as_refcounter.cocci b/scripts/coccinelle/api/atomic_as_refcounter.cocci
index 0f78d94abc35..0ce7618479fd 100644
--- a/scripts/coccinelle/api/atomic_as_refcounter.cocci
+++ b/scripts/coccinelle/api/atomic_as_refcounter.cocci
@@ -55,7 +55,8 @@ identifier fname6 =~ ".*call_rcu.*";
 p1 << r1.p1;
 p2 << r1.p2;
 @@
-msg = "atomic_dec_and_test variation before object free at line %s."
+msg = "atomic_dec_and_test variation before object free at line %s. \
+Consider using refcount_t instead of atomic_t for the variable."
 coccilib.report.print_report(p1[0], msg % (p2[0].line))
 
 @r4 exists@
@@ -88,7 +89,8 @@ fname@p2(y, ...);
 p1 << r4.p1;
 p2 << r4.p2;
 @@
-msg = "atomic_dec_and_test variation before object free at line %s."
+msg = "atomic_dec_and_test variation before object free at line %s. \
+Consider using refcount_t instead of atomic_t for the variable."
 coccilib.report.print_report(p1[0], msg % (p2[0].line))
 
 @r2 exists@
@@ -107,7 +109,8 @@ atomic64_add_unless(&(a)->x,-1,1)@p1
 @script:python depends on report@
 p1 << r2.p1;
 @@
-msg = "atomic_add_unless"
+msg = "Usage of atomic_add_unless encountered. \
+Consider using refcount_t instead of atomic_t for the variable."
 coccilib.report.print_report(p1[0], msg)
 
 @r3 exists@
@@ -126,5 +129,6 @@ x = atomic64_add_return@p1(-1, ...);
 @script:python depends on report@
 p1 << r3.p1;
 @@
-msg = "x = atomic_add_return(-1, ...)"
+msg = "Usage of x = atomic_add_return(-1, ...) encountered. \
+Consider using refcount_t instead of atomic_t for the variable."
 coccilib.report.print_report(p1[0], msg)
-- 
2.25.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
