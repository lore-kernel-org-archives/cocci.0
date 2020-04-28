Return-Path: <SRS0=bJsz=6M=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EFC7C83001
	for <cocci@archiver.kernel.org>; Tue, 28 Apr 2020 17:05:38 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF17120730
	for <cocci@archiver.kernel.org>; Tue, 28 Apr 2020 17:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3bYwUCG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF17120730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03SH5Rsm007720;
	Tue, 28 Apr 2020 19:05:27 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 2DF997807;
	Tue, 28 Apr 2020 19:05:27 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id AE3833DC8
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 19:05:25 +0200 (CEST)
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:543])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03SH5Oif002204
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 19:05:24 +0200 (CEST)
Received: by mail-pg1-x543.google.com with SMTP id s8so412749pgq.1
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 10:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=O4KoUK8FiK//uiuAX0JmPGKV6xwymcrVCBu5CmhgaQE=;
 b=N3bYwUCGdiyPP4A3L2+so8wCB7K+g6vtfYtIo3dEyTb5miR98x2A98gA7J6l3ehUxC
 r8ua/8ZEO8gaiZ6w1WEhdsiP/SXopiWN24FsD8Tya0bsXoOV4RxAd9GkwlvbE/g7uGvH
 7X7lqfEo1U5TdG8CZmJ2xVraUzKbG1e6//GrNPEqb/GtWpKLZZXNXom6o0guuz20wFl8
 c7vzSMuZxhvmAixlKEhiP+y83c24UQJTzKM8YOvmm2jX+SCu3cdicqAx5XRMhjB1N8LC
 e51nl7onQe8mXP+nuKZJn/7iZeaFMVJduN+CYdLx+GZWFHLouMLbFKw9YMBCFZOP75aO
 chxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=O4KoUK8FiK//uiuAX0JmPGKV6xwymcrVCBu5CmhgaQE=;
 b=QfwuLXKx20gSfhhHNflEKwuySLgU1Uldc9IHLB084khgiFoZc4YeNG0e4Iypw2FscM
 YIMqEdaBvOylzG+Chx2vWHcKlaCl5fVDIIvWHe0dp3cka6vZea/Piw0DuYNMyglyTUja
 7GWXsq4FESg6rhBk7koZgV1AMJD/NY65XitivgpV9UDB88bE5+QBIpenNi2CHeSvohhH
 NESPw77fAcWPjeHMA9D7Ust6vxgqvgzOl8OjHpg+q8KoExnAfvunjLTJAyR7bOgtqHUD
 YqWy6m9R+fac12iSYEvS81nfpzSCZZy0UECpqrGcNN42/Cuww7az0WEQ7YiGMPdwusIt
 5BYg==
X-Gm-Message-State: AGi0PubNusJhbGYXR+SYfXsXzOClzM66NjGJ2P7psmQ2VTq4aWawpqgv
 ylTjMdNfBFZuYLSsD/oR0zE6qr/g7LY=
X-Google-Smtp-Source: APiQypKUxqKQwflH7GXBkwQ4XwXr0dv9xj1SLp2lfU4YP4khXLGCrJqQ0CpS+HKliJ4euA3BkeJsAg==
X-Received: by 2002:aa7:9ae5:: with SMTP id y5mr30465320pfp.294.1588093523253; 
 Tue, 28 Apr 2020 10:05:23 -0700 (PDT)
Received: from localhost.localdomain ([1.38.220.163])
 by smtp.gmail.com with ESMTPSA id u15sm2505097pjm.47.2020.04.28.10.05.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2020 10:05:22 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Tue, 28 Apr 2020 22:32:21 +0530
Message-Id: <20200428170228.7002-26-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200428170228.7002-1-jaskaransingh7654321@gmail.com>
References: <20200428170228.7002-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 28 Apr 2020 19:05:27 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Tue, 28 Apr 2020 19:05:25 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 25/32] parsing_c: visitor_c: Visit Cast attributes
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

Cast attributes are added to the C AST. Visit these attributes in
the C AST visitor.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_c/visitor_c.ml | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/parsing_c/visitor_c.ml b/parsing_c/visitor_c.ml
index 57b5f32b..1a522413 100644
--- a/parsing_c/visitor_c.ml
+++ b/parsing_c/visitor_c.ml
@@ -324,7 +324,9 @@ let rec vk_expr = fun bigf expr ->
 
     | SizeOfExpr  (e) -> exprf e
     | SizeOfType  (t) -> vk_type bigf t
-    | Cast    (t, e) -> vk_type bigf t; exprf e
+    | Cast    (t, e, a) ->
+        vk_type bigf t; exprf e;
+        a +> List.iter (vk_attribute bigf)
 
     (* old: | StatementExpr (((declxs, statxs), is)), is2 ->
      *          List.iter (vk_decl bigf) declxs;
@@ -1188,7 +1190,11 @@ let rec vk_expr_s = fun bigf expr ->
 
       | SizeOfExpr  (e) -> SizeOfExpr (exprf e)
       | SizeOfType  (t) -> SizeOfType (vk_type_s bigf t)
-      | Cast    (t, e)  -> Cast (vk_type_s bigf t, exprf e)
+      | Cast    (t, e, a)  ->
+          Cast
+            (vk_type_s bigf t,
+             exprf e,
+             a +> List.map (vk_attribute_s bigf))
 
       | StatementExpr (statxs, is) ->
           StatementExpr (
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
