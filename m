Return-Path: <SRS0=R2Y6=A7=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4078C433FB
	for <cocci@archiver.kernel.org>; Mon, 20 Jul 2020 16:23:28 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3581B2070A
	for <cocci@archiver.kernel.org>; Mon, 20 Jul 2020 16:23:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3581B2070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 06KGNATv007943;
	Mon, 20 Jul 2020 18:23:10 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id C17C17775;
	Mon, 20 Jul 2020 18:23:10 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id AFBB844A7
 for <cocci@systeme.lip6.fr>; Mon, 20 Jul 2020 18:23:08 +0200 (CEST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com
 [209.85.167.41])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 06KGN6xV016132
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 20 Jul 2020 18:23:08 +0200 (CEST)
Received: by mail-lf1-f41.google.com with SMTP id b11so7631303lfe.10
 for <cocci@systeme.lip6.fr>; Mon, 20 Jul 2020 09:23:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=N8ZQ1z1Y9J3lklmnyIL1eg+foE3QYmPpQxCfPP1w6Ms=;
 b=f7UouSm34bIkruzTrrvYyi6+mg1Y/qmSgOp145jlR4TKzkUwv79a2nVFmeBXWA4C78
 Atg/NVXc+XNHTsXXxOOkEyp7kfZw74mPh6iOCs/E83jslpFDmDvjGn0/X1WeZeAdsJOo
 fcNIrUPdWoumj/Hcs0QHU59pxuJCX6C72eXYPNAvxpAYU22W0DmPyZzg8xvj6R7/ptAc
 gvmLOXhUWcEeXhYLUyhq3wPj0xrw0crhCSzvAsT4aculWxhUDXaNRFv2/oJueTJ68+yq
 29SK4xrHqbPZ/WI5jx9jD1BQ5tioIIYGWPbtu/ln6yxC9l++A84ZYhfwEAb+8DjTZ9V5
 GRZg==
X-Gm-Message-State: AOAM531WsFE3nVGd5ePot29nrJ9qUxobS4YJbCUvNeCU1yhmiLo6QNaQ
 QNKiomqkA/PAgGvxGxduMRw=
X-Google-Smtp-Source: ABdhPJwPSiI6maUDjNW5LdNyJ1oYyUWzFvLT4Ry+qkJRlqg+yd+gK6S7BJiIulAIF30jbdq+2o9JNA==
X-Received: by 2002:ac2:5a01:: with SMTP id q1mr11219181lfn.182.1595262185871; 
 Mon, 20 Jul 2020 09:23:05 -0700 (PDT)
Received: from localhost.localdomain (broadband-37-110-38-130.ip.moscow.rt.ru.
 [37.110.38.130])
 by smtp.googlemail.com with ESMTPSA id a19sm925855lff.25.2020.07.20.09.23.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2020 09:23:05 -0700 (PDT)
From: Denis Efremov <efremov@linux.com>
To: Julia Lawall <julia.lawall@inria.fr>
Date: Mon, 20 Jul 2020 19:22:16 +0300
Message-Id: <20200720162216.13248-4-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200720162216.13248-1-efremov@linux.com>
References: <20200720162216.13248-1-efremov@linux.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 20 Jul 2020 18:23:10 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 20 Jul 2020 18:23:08 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: [Cocci] [PATCH v3 3/3] coccinelle: api: filter out memdup_user
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

Don't match memdup_user/vmemdup_user.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 scripts/coccinelle/api/memdup_user.cocci | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/scripts/coccinelle/api/memdup_user.cocci b/scripts/coccinelle/api/memdup_user.cocci
index 60027e21c5e6..e01e95108405 100644
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
 -		(size,\(GFP_KERNEL\|GFP_USER\|
 -		      \(GFP_KERNEL\|GFP_USER\)|__GFP_NOWARN\));
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
