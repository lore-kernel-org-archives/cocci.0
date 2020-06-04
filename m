Return-Path: <SRS0=OH0s=7R=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B42C433DF
	for <cocci@archiver.kernel.org>; Thu,  4 Jun 2020 16:42:22 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B3102072E
	for <cocci@archiver.kernel.org>; Thu,  4 Jun 2020 16:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="ub4mWTHg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B3102072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 054GgIIA029789;
	Thu, 4 Jun 2020 18:42:18 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id ED4777567;
	Thu,  4 Jun 2020 18:42:17 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B71FE5D47
 for <cocci@systeme.lip6.fr>; Thu,  4 Jun 2020 18:42:14 +0200 (CEST)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:b49])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 054GgC5h000575
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Thu, 4 Jun 2020 18:42:13 +0200 (CEST)
Received: by mail-yb1-xb49.google.com with SMTP id d6so8653710ybn.0
 for <cocci@systeme.lip6.fr>; Thu, 04 Jun 2020 09:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=pofY5UnHBtE2yEYmKDPS6cR9bq/E80+ZeaPnrnMNK98=;
 b=ub4mWTHgAmvJMZjGWw+3krHG/dMMay/tEALCX2G/rPbqjl75Y1uFKqie5t1rgrrhON
 mSo60E/ut95d77LLkZkje/FzRws70wUBRcAvqqI6aATgZOEQANEMIjEbyhsrSIwC/se1
 +gGkOGCIm1IyRrH4kWj4cbjTNvz6C+D4ft584XFWfpJ7iRrH7vNHTY3oULr4Z6pRVU6G
 BavBT5hfTMSMPCNrPtuEOHmz9ygqHX4Urzmv6tacLepDNsToQeLuvQr0aZV2GY+d7uvc
 FqYz0BricpkB/+MN9552QQhFDDWbsbpx/QxKWrc7keuS8FBrMpqkSeSwwHcn2IhJ2wAB
 UILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=pofY5UnHBtE2yEYmKDPS6cR9bq/E80+ZeaPnrnMNK98=;
 b=g9Ry5s+juR8+a8waKSXAWIId/GSzI4DYMdX9W2rkzkpJus23RQpgVXasi05JGgY7Z7
 ZZ3Rguz7pWVOlUxN3vqsL8Hi/CrEtrKx5uVkw5BRjMN/hCWcmGSSZZ7HIXyBxZMNT8I0
 cqC68aVaJTPczw/ywTBwlVBgkyiNY48k71p1l8uN1+8kJUxQkTT6mSOuDYlYsPN8iNpM
 5cu1XD884rplM47AeQCnVFUiHo2AU8iVGHC5ywtDU3xtP+RfN0U3fxsbQwOKld+cbEOc
 1ZcfaiDUtkIMsrBhDCaBoqGuMyrkX3BE3Q7ccclcve3LaQuHc+BbF9sB0x4QjCeEOujD
 WEEg==
X-Gm-Message-State: AOAM532VkUPFUReUBAsyGj8xK/A5zNX5H9cv6a8If46Y7M8hEC4CBEH+
 hKmVQJu6jMGA7Q91mIhFDls+882D6bbWRQ==
X-Google-Smtp-Source: ABdhPJzuB/YAm+byvdwGw2WfFvD+78kMp/xSR/rtbn2s7vqMXsI0/43mdS+H2sOvX7lbvdCDP2L90nRRZYLC1A==
X-Received: by 2002:a25:5804:: with SMTP id m4mr9094629ybb.488.1591288932392; 
 Thu, 04 Jun 2020 09:42:12 -0700 (PDT)
Date: Thu,  4 Jun 2020 18:41:45 +0200
Message-Id: <20200604164145.173925-1-maennich@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.rc2.251.g90737beb825-goog
From: Matthias Maennich <maennich@google.com>
To: linux-kernel@vger.kernel.org
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 04 Jun 2020 18:42:18 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Thu, 04 Jun 2020 18:42:13 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: YueHaibing <yuehaibing@huawei.com>, maennich@google.com,
        stable@vger.kernel.org, jeyu@kernel.org, kernel-team@android.com,
        cocci@systeme.lip6.fr
Subject: [Cocci] [PATCH] scripts: add dummy report mode to
	add_namespace.cocci
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

When running `make coccicheck` in report mode using the
add_namespace.cocci file, it will fail for files that contain
MODULE_LICENSE. Those match the replacement precondition, but spatch
errors out as virtual.ns is not set.

In order to fix that, add the virtual rule nsdeps and only do search and
replace if that rule has been explicitly requested.

In order to make spatch happy in report mode, we also need a dummy rule,
as otherwise it errors out with "No rules apply". Using a script:python
rule appears unrelated and odd, but this is the shortest I could come up
with.

Adjust scripts/nsdeps accordingly to set the nsdeps rule when run trough
`make nsdeps`.

Suggested-by: Julia Lawall <julia.lawall@inria.fr>
Fixes: c7c4e29fb5a4 ("scripts: add_namespace: Fix coccicheck failed")
Cc: YueHaibing <yuehaibing@huawei.com>
Cc: jeyu@kernel.org
Cc: cocci@systeme.lip6.fr
Cc: stable@vger.kernel.org
Signed-off-by: Matthias Maennich <maennich@google.com>
---
 scripts/coccinelle/misc/add_namespace.cocci | 8 +++++++-
 scripts/nsdeps                              | 2 +-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/scripts/coccinelle/misc/add_namespace.cocci b/scripts/coccinelle/misc/add_namespace.cocci
index 99e93a6c2e24..cbf1614163cb 100644
--- a/scripts/coccinelle/misc/add_namespace.cocci
+++ b/scripts/coccinelle/misc/add_namespace.cocci
@@ -6,6 +6,7 @@
 /// add a missing namespace tag to a module source file.
 ///
 
+virtual nsdeps
 virtual report
 
 @has_ns_import@
@@ -16,10 +17,15 @@ MODULE_IMPORT_NS(ns);
 
 // Add missing imports, but only adjacent to a MODULE_LICENSE statement.
 // That ensures we are adding it only to the main module source file.
-@do_import depends on !has_ns_import@
+@do_import depends on !has_ns_import && nsdeps@
 declarer name MODULE_LICENSE;
 expression license;
 identifier virtual.ns;
 @@
 MODULE_LICENSE(license);
 + MODULE_IMPORT_NS(ns);
+
+// Dummy rule for report mode that would otherwise be empty and make spatch
+// fail ("No rules apply.")
+@script:python depends on report@
+@@
diff --git a/scripts/nsdeps b/scripts/nsdeps
index 03a8e7cbe6c7..dab4c1a0e27d 100644
--- a/scripts/nsdeps
+++ b/scripts/nsdeps
@@ -29,7 +29,7 @@ fi
 
 generate_deps_for_ns() {
 	$SPATCH --very-quiet --in-place --sp-file \
-		$srctree/scripts/coccinelle/misc/add_namespace.cocci -D ns=$1 $2
+		$srctree/scripts/coccinelle/misc/add_namespace.cocci -D nsdeps -D ns=$1 $2
 }
 
 generate_deps() {
-- 
2.27.0.rc2.251.g90737beb825-goog

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
