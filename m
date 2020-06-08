Return-Path: <SRS0=02ua=7V=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC57C433E0
	for <cocci@archiver.kernel.org>; Mon,  8 Jun 2020 15:01:27 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50E60206C3
	for <cocci@archiver.kernel.org>; Mon,  8 Jun 2020 15:01:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50E60206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 058F1OHM011567;
	Mon, 8 Jun 2020 17:01:24 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D265B7783;
	Mon,  8 Jun 2020 17:01:24 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 2C38944A7
 for <cocci@systeme.lip6.fr>; Mon,  8 Jun 2020 17:01:23 +0200 (CEST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com
 [209.85.208.179])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 058F1M9X027097
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 8 Jun 2020 17:01:22 +0200 (CEST)
Received: by mail-lj1-f179.google.com with SMTP id a25so20903107ljp.3
 for <cocci@systeme.lip6.fr>; Mon, 08 Jun 2020 08:01:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gS/VQWLqdTR1WnMRT1E0dWszp6HUI8fnasX0aZv1mo8=;
 b=PT7TLCyHiYaC7tglY2lDCkzweTpsI6QVKt+ki0CXFZ6KRow1sfe7J/g2ivgAXAqcKV
 C+IqO6C12FByKWo8ngB9otK0gjiRWEEUkgfX9LIEaAxmH8sykWCgDB+3uCJpuOEmDPSG
 gjhdnSVRhbFW7JH+Y4WOrtBm8OXqe//hcuEARpI1dQnMHhrPPAU9EvazOPOnBB7Ro08Y
 6LpjzVdrqzrVmjdYGjfldJAYdc7N6PqoZ0MNUERGgDv3FAd+T3KcwlivmLN7UGEwaY5O
 LMaDYmkGjICypNys3pDHmZWi/HK239F5DowqkGlX0fBQF5QXljoQ2Ry5ijS86jYwOIgE
 M/pA==
X-Gm-Message-State: AOAM531obrfSSJ2YNbHt1oudq2WLtYYmrPW/mlKS+Ttr8XwMc0oKDv+e
 Jq6qAJaaLSPa3XqSEDSs48o=
X-Google-Smtp-Source: ABdhPJzLKQbTG+B2awlUCbuilSYITMINPGNFWm2gSFfpcpQ8UoH6L5e6cbQTFICgqgLzZ6kTX9ZppQ==
X-Received: by 2002:a2e:9081:: with SMTP id l1mr12154029ljg.81.1591628482141; 
 Mon, 08 Jun 2020 08:01:22 -0700 (PDT)
Received: from localhost.localdomain ([213.87.137.116])
 by smtp.googlemail.com with ESMTPSA id r16sm279228ljn.106.2020.06.08.08.01.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 08:01:21 -0700 (PDT)
From: Denis Efremov <efremov@linux.com>
To: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Mon,  8 Jun 2020 18:00:37 +0300
Message-Id: <20200608150038.223747-4-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200608150038.223747-1-efremov@linux.com>
References: <20200608150038.223747-1-efremov@linux.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 08 Jun 2020 17:01:24 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 08 Jun 2020 17:01:22 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: linux-kernel@vger.kernel.org, cocci@systeme.lip6.fr
Subject: [Cocci] [PATCH v2 3/4] coccinelle: api: filter out memdup_user
	definitions
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

Don't match original implementations.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 scripts/coccinelle/api/memdup_user.cocci | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/scripts/coccinelle/api/memdup_user.cocci b/scripts/coccinelle/api/memdup_user.cocci
index d15c061a34ab..8621bd98be1e 100644
--- a/scripts/coccinelle/api/memdup_user.cocci
+++ b/scripts/coccinelle/api/memdup_user.cocci
@@ -15,12 +15,20 @@ virtual context
 virtual org
 virtual report
 
+@initialize:python@
+@@
+filter = frozenset(['memdup_user', 'vmemdup_user'])
+
+def relevant(p):
+    return not (filter & {el.current_element for el in p})
+
 @depends on patch@
 expression from,to,size;
 identifier l1,l2;
+position p : script:python() { relevant(p) };
 @@
 
--  to = \(kmalloc\|kzalloc\)
+-  to = \(kmalloc@p\|kzalloc@p\)
 		(size,\(GFP_KERNEL\|GFP_USER\|
 		      \(GFP_KERNEL\|GFP_USER\)|__GFP_NOWARN\));
 +  to = memdup_user(from,size);
@@ -42,9 +50,10 @@ identifier l1,l2;
 @depends on patch@
 expression from,to,size;
 identifier l1,l2;
+position p : script:python() { relevant(p) };
 @@
 
--  to = \(kvmalloc\|kvzalloc\)(size,\(GFP_KERNEL\|GFP_USER\));
+-  to = \(kvmalloc@p\|kvzalloc@p\)(size,\(GFP_KERNEL\|GFP_USER\));
 +  to = vmemdup_user(from,size);
    if (
 -      to==NULL
@@ -63,7 +72,7 @@ identifier l1,l2;
 
 @r depends on !patch@
 expression from,to,size;
-position p;
+position p : script:python() { relevant(p) };
 statement S1,S2;
 @@
 
@@ -76,7 +85,7 @@ statement S1,S2;
 
 @rv depends on !patch@
 expression from,to,size;
-position p;
+position p : script:python() { relevant(p) };
 statement S1,S2;
 @@
 
-- 
2.26.2

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
