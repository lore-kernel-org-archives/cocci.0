Return-Path: <SRS0=13qy=BU=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A9ABC433E0
	for <cocci@archiver.kernel.org>; Mon, 10 Aug 2020 15:23:13 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C50DE20772
	for <cocci@archiver.kernel.org>; Mon, 10 Aug 2020 15:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/KNBIQd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C50DE20772
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 07AFMpXN006907;
	Mon, 10 Aug 2020 17:22:51 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 904D47780;
	Mon, 10 Aug 2020 17:22:51 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 23E805F8F
 for <cocci@systeme.lip6.fr>; Mon, 10 Aug 2020 17:22:50 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 07AFMmdH017357
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Mon, 10 Aug 2020 17:22:49 +0200 (CEST)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3D2B520782;
 Mon, 10 Aug 2020 15:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597072967;
 bh=Itc7IHb08ZGOHTDJBJwZojMpWgF91q1faBxQtgBUtgk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=m/KNBIQd4PrbMp8WrO7drnHJYkq/93fM+BWFGArpZAFGvXE4RjpbamqNznFSHdWv7
 6PXk+ZBNSQHQsN4+powt2I5/acka3shE+QlY6KZxQnjaRPieG+l/O/bAJPHb2Zjpgi
 wQGp5XGMX7bWL6Bn65FdhKRhI6Y+B7I+tYg7AVPM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Date: Mon, 10 Aug 2020 17:20:40 +0200
Message-Id: <20200810151813.224449988@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200810151812.114485777@linuxfoundation.org>
References: <20200810151812.114485777@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 10 Aug 2020 17:22:51 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 10 Aug 2020 17:22:49 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Matthias Maennich <maennich@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        YueHaibing <yuehaibing@huawei.com>, stable@vger.kernel.org,
        jeyu@kernel.org, cocci@systeme.lip6.fr
Subject: [Cocci] [PATCH 5.7 21/79] scripts: add dummy report mode to
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

From: Matthias Maennich <maennich@google.com>

commit 55c7549819e438f40a3ef1d8ac5c38b73390bcb7 upstream.

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
Reported-by: Shuah Khan <skhan@linuxfoundation.org>
Acked-by: Julia Lawall <julia.lawall@inria.fr>
Link: https://lore.kernel.org/r/20200604164145.173925-1-maennich@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 scripts/coccinelle/misc/add_namespace.cocci |    8 +++++++-
 scripts/nsdeps                              |    2 +-
 2 files changed, 8 insertions(+), 2 deletions(-)

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
--- a/scripts/nsdeps
+++ b/scripts/nsdeps
@@ -29,7 +29,7 @@ fi
 
 generate_deps_for_ns() {
 	$SPATCH --very-quiet --in-place --sp-file \
-		$srctree/scripts/coccinelle/misc/add_namespace.cocci -D ns=$1 $2
+		$srctree/scripts/coccinelle/misc/add_namespace.cocci -D nsdeps -D ns=$1 $2
 }
 
 generate_deps() {


_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
