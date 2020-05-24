Return-Path: <SRS0=Qcbb=7G=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579A6C433E0
	for <cocci@archiver.kernel.org>; Sun, 24 May 2020 17:21:37 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC2FC206C3
	for <cocci@archiver.kernel.org>; Sun, 24 May 2020 17:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tmx9VP/z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC2FC206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04OHLXgI001873;
	Sun, 24 May 2020 19:21:33 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B9B793DC8;
	Sun, 24 May 2020 19:21:33 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 4182A3D0F
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 19:21:32 +0200 (CEST)
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:442])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04OHLUdA023796
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 19:21:31 +0200 (CEST)
Received: by mail-pf1-x442.google.com with SMTP id y198so7870775pfb.4
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 10:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ms6UHNFKx95qXnFx7eWKRowPk5NVwtvKW5RD2jrIW8U=;
 b=Tmx9VP/zYAfZtyu7Ne32W2MZkODoDFcU1ay7iT7r2Arvcj7yEzcrwxkJIxTeoY8TkB
 aFoYyU4NdFHncx4iuu9NK8Qy/30P/+EOIUQ/ANgp5mgSsGrYwveeiTmacna4IoYIdfRW
 an5OEaZu42GvmLo4g7PmsSorljKIxFnbHW21JZ344j4N/k3Y4xM1uHCaC/dkjV1xNr9T
 XZURRAi7TAeTptinu+DssSTDe6naneQuYh8ugQbC7mIsJWIxVq+RztyqAyxJC94O4fKq
 HsB9Sc4TD8XOqGKu0mQ22w1WOdqgNxW4M9FQEXg9/3mM7w92M0TTnJhB6usaoDeuzvDj
 HA9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ms6UHNFKx95qXnFx7eWKRowPk5NVwtvKW5RD2jrIW8U=;
 b=kmHyS2QLBNs4QMftFylg+nEK1snDGtndBZEia1mviCQtVUAwTlTTuwccVS9bfuEMO6
 UcPlL9/vze0ohOoiKD5z2cJ9D1cfvlpj7aULrIQsVwPc9HrX+BtEsR/XU8HdwxwuPKTD
 UagLaDrSWCvECnTG+w6esJL50eUSD9zHttQHWUH+Z6YsGjYenHO+hukyQZCElleN5Ew5
 dz7iGIIzksXjaDe8xikGelaQ3tgSFItFAscUQ0n0IQ1e9jUxc56RzCPDASDiJE9SB3Vs
 8WACPP99VGO665B4iEh3M/NknkbXKQhK0TVnecKBnZqUWxviAQ76dhKXQUVdqbuvO2ni
 uYnw==
X-Gm-Message-State: AOAM5327FXExXVQN3qkGwHZCKzsGERSnKTHcp26KuCFnr4TlFfscbM0T
 EkZ1WBCzjRpvLLr7aT38DDzf5z0Xsj4=
X-Google-Smtp-Source: ABdhPJwfNWe0g/Lx45cNC3vTGfsVrhncBhAyKZiwbFRyc1VaUD87vTB3cxRX7PndMhclQ60PlwLcfQ==
X-Received: by 2002:a62:174c:: with SMTP id 73mr13148847pfx.71.1590340889945; 
 Sun, 24 May 2020 10:21:29 -0700 (PDT)
Received: from localhost.localdomain ([1.38.220.54])
 by smtp.gmail.com with ESMTPSA id d9sm6556497pfn.72.2020.05.24.10.21.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2020 10:21:29 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sun, 24 May 2020 22:49:23 +0530
Message-Id: <20200524171935.2504-19-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200524171935.2504-1-jaskaransingh7654321@gmail.com>
References: <20200524171935.2504-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 24 May 2020 19:21:34 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 24 May 2020 19:21:31 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 18/30] parsing_cocci: unify_ast: Reflect Macrodecl
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

Macrodecl attributes are added to the SmPL AST. Reflect these changes in
unify_ast.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/unify_ast.ml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/parsing_cocci/unify_ast.ml b/parsing_cocci/unify_ast.ml
index 68cb6613..c4a6e0ce 100644
--- a/parsing_cocci/unify_ast.ml
+++ b/parsing_cocci/unify_ast.ml
@@ -409,8 +409,8 @@ and unify_declaration d1 d2 =
 	  unify_ident nm1 nm2 &&
 	  unify_dots unify_parameterTypeDef pdots params1 params2
        else false
-  | (Ast.MacroDecl(s1,n1,lp1,args1,rp1,sem1),
-     Ast.MacroDecl(s2,n2,lp2,args2,rp2,sem2)) ->
+  | (Ast.MacroDecl(s1,n1,lp1,args1,rp1,attr1,sem1),
+     Ast.MacroDecl(s2,n2,lp2,args2,rp2,attr2,sem2)) ->
        if bool_unify_option unify_mcode s1 s2
        then
 	 unify_ident n1 n2 &&
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
