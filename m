Return-Path: <SRS0=43Z/=6Z=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18953C47255
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:13:40 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 836E3206D6
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fprue9XP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 836E3206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04BADRro006593;
	Mon, 11 May 2020 12:13:27 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 3A2007839;
	Mon, 11 May 2020 12:13:24 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 1B2627831
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:13:22 +0200 (CEST)
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:444])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04BADJ6A019133
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:13:20 +0200 (CEST)
Received: by mail-pf1-x444.google.com with SMTP id x15so3946494pfa.1
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 03:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bpLTgt82Ti31oCPVD1pdgcNX51JVNVAJJuqnmPIy5S0=;
 b=Fprue9XP2QnYFuMFJj8BXSBOpeZAXQlYWa6NLP0bkkD5T1du46XQ1CD4QyN/guXkwj
 pLRHCxEqlHlHmJMefUnEvqZJ7d7Qtov7uaqW7lfQPCaXNXD/gAp471ex7NJTUGpG78i7
 8EXhTBWu4B067LB9t/IT+nnedqg+DndFK67KYtk6fAsBhWgl1i23ZhyI8Gp6R+pZSePM
 6lK0T55t1rFKNkwtNcIk9hUFJnp/JqAW2rvI3cSQ21cJIhRKOfku2Ro9X867mVRetlFl
 0YYaSYyTnxgUItE2kovfUHUNh0eBJOOOajXstBNLrfU7LMGNARj5JQMr6oBYaN58jklW
 KVwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bpLTgt82Ti31oCPVD1pdgcNX51JVNVAJJuqnmPIy5S0=;
 b=gVO2Awco96YRhP1uqnIPZxOndqBeAcgIdFenYFKiBtKxJCmiAqSBkY2t3m8YtB1G6z
 IAYoBqumc2Ip8OuVilWpXfNMJylPqOoxlW9NaMRKClTdwcFQ6YEu2aVz+6yyUKzwKCt7
 GGuoQMfw0NNObuRFj3dui0r9yNxgKhDypG0WUBBJU3R+3+byeXQCLzRha4OicauL6KKd
 5E087HOVWtI0e38lyUTe6KArgWSK2kj4ukHPp7umyF2FC6dENRRSYq579sCeeqZsOWV4
 hVd5Ep0szVHqCF0cyr4+XCFaGKtvK3bhzZHoPENNUSyXO8ekh1W/EFr9mdB8aCJrA7CI
 FcQg==
X-Gm-Message-State: AGi0PuaZI7kpHiP2ZBvwSseuFXzVPHS6DgBJIPt4Lp77ikU7V1MhYHzA
 zDCXIjSOOF7/r42yf3VQzLR6k3AJdYg=
X-Google-Smtp-Source: APiQypJdoB2y17RAIqS9YA61EKWWv60wkx64JOT6VCfsf9yPUbTwWFYw/W4H7sjfXkMcQvMhvwInjg==
X-Received: by 2002:aa7:979d:: with SMTP id o29mr15789608pfp.90.1589191998963; 
 Mon, 11 May 2020 03:13:18 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:382:66db:4729:1ab8:2139:8945])
 by smtp.gmail.com with ESMTPSA id
 j14sm10021121pjm.27.2020.05.11.03.13.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 03:13:18 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 11 May 2020 15:42:38 +0530
Message-Id: <20200511101300.11101-2-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200511101300.11101-1-jaskaransingh7654321@gmail.com>
References: <20200511101300.11101-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 11 May 2020 12:13:27 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 11 May 2020 12:13:20 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v3 01/23] parsing_cocci: ast0_cocci: Add parameter
	attributes
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

Add parameter attributes to AST0 of SmPL. This is a list of attributes
in the VoidParam and Param types of AST0.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/ast0_cocci.ml  | 4 ++--
 parsing_cocci/ast0_cocci.mli | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/parsing_cocci/ast0_cocci.ml b/parsing_cocci/ast0_cocci.ml
index a06d99ae..8d30daea 100644
--- a/parsing_cocci/ast0_cocci.ml
+++ b/parsing_cocci/ast0_cocci.ml
@@ -334,8 +334,8 @@ and initialiser_list = initialiser dots
 (* Parameter *)
 
 and base_parameterTypeDef =
-    VoidParam     of typeC
-  | Param         of typeC * ident option
+    VoidParam     of typeC * attr list
+  | Param         of typeC * ident option * attr list
   | MetaParam     of Ast.meta_name mcode * constraints * pure
   | MetaParamList of Ast.meta_name mcode * listlen * constraints * pure
   | AsParam       of parameterTypeDef * expression (* expr, always metavar *)
diff --git a/parsing_cocci/ast0_cocci.mli b/parsing_cocci/ast0_cocci.mli
index 5c2520be..f66a1fac 100644
--- a/parsing_cocci/ast0_cocci.mli
+++ b/parsing_cocci/ast0_cocci.mli
@@ -320,8 +320,8 @@ and initialiser_list = initialiser dots
 (* Parameter *)
 
 and base_parameterTypeDef =
-    VoidParam     of typeC
-  | Param         of typeC * ident option
+    VoidParam     of typeC * attr list
+  | Param         of typeC * ident option * attr list
   | MetaParam     of Ast_cocci.meta_name mcode * constraints * pure
   | MetaParamList of Ast_cocci.meta_name mcode * listlen * constraints * pure
   | AsParam       of parameterTypeDef * expression (* expr, always metavar *)
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
