Return-Path: <SRS0=02ua=7V=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5656C433DF
	for <cocci@archiver.kernel.org>; Mon,  8 Jun 2020 15:01:29 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D40B206C3
	for <cocci@archiver.kernel.org>; Mon,  8 Jun 2020 15:01:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D40B206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 058F1QMk014288;
	Mon, 8 Jun 2020 17:01:26 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 516627783;
	Mon,  8 Jun 2020 17:01:26 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 5F3A944A7
 for <cocci@systeme.lip6.fr>; Mon,  8 Jun 2020 17:01:25 +0200 (CEST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com
 [209.85.208.170])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 058F1ODr019516
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 8 Jun 2020 17:01:24 +0200 (CEST)
Received: by mail-lj1-f170.google.com with SMTP id c17so20870768lji.11
 for <cocci@systeme.lip6.fr>; Mon, 08 Jun 2020 08:01:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lR7SkMxR2WvDhYKg7h/qTpiMFY/yOdg6mP8JNQ15c78=;
 b=pmSvVoR90pw3o7RKS0zdPmjjlMOnHDxu6pM62Egz5JOaaXDdHnZaVQKMzMtofEjoye
 O64zdXc0+cEyfLBwDAjRPCDkgm4TRez1leYofH8ez9m3Ls6YKJbSqAseCIUcJy+2DG8U
 Y8FYsnNqtOybdw4gXKbMISgNBVwYBEmFUW3cpNfKSrOI4nzAgrX6ueLKNiuwFKdIBd+k
 Qb9NDmqZZryjx4aWHxcn3e7A+rNAFQOlBCFFVy1nCj8eDuFpej3g64Hlp2e88kpxGX/M
 8zcFEAFrSVdXeUMQrqkzreus8R9CMkOIckUFC2/L/AXf8ZSAw+BebMxSWLcWrHZvj5K4
 zjHQ==
X-Gm-Message-State: AOAM532AKCY5fKWWo8d0s594RDsEmErhZXM9C2rMEJ2VTJrvxx7jLKTA
 I9H6UPG51OfJg0K92hLZoAM=
X-Google-Smtp-Source: ABdhPJyxS9y/hUjXRm6R0Uxf68yVoHH4SPTO73VCz8t8ngQaeVrq1ectHYOH68ht0aomkffk9AQdaA==
X-Received: by 2002:a2e:800b:: with SMTP id j11mr12204281ljg.467.1591628484282; 
 Mon, 08 Jun 2020 08:01:24 -0700 (PDT)
Received: from localhost.localdomain ([213.87.137.116])
 by smtp.googlemail.com with ESMTPSA id r16sm279228ljn.106.2020.06.08.08.01.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 08:01:23 -0700 (PDT)
From: Denis Efremov <efremov@linux.com>
To: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Mon,  8 Jun 2020 18:00:38 +0300
Message-Id: <20200608150038.223747-5-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200608150038.223747-1-efremov@linux.com>
References: <20200608150038.223747-1-efremov@linux.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 08 Jun 2020 17:01:26 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 08 Jun 2020 17:01:25 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: linux-kernel@vger.kernel.org, cocci@systeme.lip6.fr
Subject: [Cocci] [PATCH v2 4/4] coccinelle: api: add selfcheck for
	memdup_user rule
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

Check that the rule matches vmemdup_user implementation.
memdup_user is out of scope because we are not matching
kmalloc_track_caller() function.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 scripts/coccinelle/api/memdup_user.cocci | 46 ++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/scripts/coccinelle/api/memdup_user.cocci b/scripts/coccinelle/api/memdup_user.cocci
index 8621bd98be1e..78fded83b197 100644
--- a/scripts/coccinelle/api/memdup_user.cocci
+++ b/scripts/coccinelle/api/memdup_user.cocci
@@ -14,13 +14,24 @@ virtual patch
 virtual context
 virtual org
 virtual report
+virtual selfcheck
 
 @initialize:python@
 @@
-filter = frozenset(['memdup_user', 'vmemdup_user'])
+
+definitions = {
+    'memdup_user': 'mm/util.c',
+    'vmemdup_user': 'mm/util.c',
+}
+
+filter = frozenset(definitions.keys())
+coccinelle.filtered = set()
+coccinelle.checked_files = set()
 
 def relevant(p):
-    return not (filter & {el.current_element for el in p})
+    found = filter & {el.current_element for el in p}
+    coccinelle.filtered |= found
+    return not found
 
 @depends on patch@
 expression from,to,size;
@@ -117,3 +128,34 @@ p << rv.p;
 @@
 
 coccilib.report.print_report(p[0], "WARNING opportunity for vmemdup_user")
+
+@script:python depends on selfcheck@
+@@
+coccinelle.checked_files |= set(definitions.values()) & set(cocci.files())
+
+@finalize:python depends on selfcheck@
+filtered << merge.filtered;
+checked_files << merge.checked_files;
+@@
+
+# Don't check memdup_user because the pattern is not capturing
+# kmalloc_track_caller() calls
+del definitions['memdup_user']
+
+# mapping between checked files and filtered definitions
+found_defns = {}
+for files, funcs in zip(checked_files, filtered):
+   for file in files:
+      found_defns[file] = funcs
+
+# reverse mapping of definitions
+expected_defns = {v : set() for v in definitions.values()}
+for k, v in definitions.items():
+    expected_defns[v] |= {k}
+
+for efile, efuncs in expected_defns.items():
+    if efile in found_defns:
+        not_found = efuncs - found_defns[efile]
+        if not_found:
+            print('SELF-CHECK: the pattern no longer matches ' \
+		  'definitions {} in file {}'.format(not_found, efile))
-- 
2.26.2

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
