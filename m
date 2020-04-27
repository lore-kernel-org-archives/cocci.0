Return-Path: <SRS0=J+r8=6L=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC45C7C8A1
	for <cocci@archiver.kernel.org>; Mon, 27 Apr 2020 12:10:16 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE36C20656
	for <cocci@archiver.kernel.org>; Mon, 27 Apr 2020 12:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFykXHTJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE36C20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03RCA5H2021071;
	Mon, 27 Apr 2020 14:10:05 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id F2BFD7807;
	Mon, 27 Apr 2020 14:10:04 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id A63947769
 for <cocci@systeme.lip6.fr>; Mon, 27 Apr 2020 14:10:02 +0200 (CEST)
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:642])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03RCA1MI005679
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 27 Apr 2020 14:10:01 +0200 (CEST)
Received: by mail-pl1-x642.google.com with SMTP id t7so1001806plr.0
 for <cocci@systeme.lip6.fr>; Mon, 27 Apr 2020 05:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TV0hQbWPE6I76/eXMWA6DfzgeTBXmkrL8f2jcsCkf6M=;
 b=XFykXHTJUnmfHwxVJBT+GrMJwkXlKejUejMWI37lo3fMnJ7a54q4mbdXHF/Yq8C9gM
 9Qw1gkA7U7I+251l6XKLHnjeJgrO+gNIdEdEDyyWsxyfrjIOlgpvXRiu8U8o9tlEavH0
 tmdvlUYTrjyNa6r+N64+vfwGgOFe3aJmUdnm0aF2gwKgmGLIbacxKH27318o8YM41a4s
 Q7ogCkjB49da2fWtAJTr3vuWL4uSAtn01imVJ9vpc3GS3W83cY75iHJ9KQxLeDDNzxni
 bf6nJ9n7G0Md5FGIMVlqMNsBkwJraEGJXboFJHmJ1hLOo0oRISZFx44m2A2liaoEN928
 0kow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TV0hQbWPE6I76/eXMWA6DfzgeTBXmkrL8f2jcsCkf6M=;
 b=g9JfQQdIofOKxNhYW434I/z9S3KSJVqPah8UHMcQhnHDodPR71WRykf3EHTps5kD2x
 Te7kwIYvkRb4LpwaCoNdSUUXUVnLqxoJKpNRMF88TCyqQ/T8aAJPBtc4w/mxGTiK0YDt
 rQVufZzrqMJ7Am5gmbx0aD+VbTmapmY9vzvdBxj4/OtXgbJEC6e0Eqw9d/DeAmOSQTsc
 fCy8RfiCw+lYuRauDqQLurLBIlcQOnyvZGWqWHx993j02WUddG3SBhbnjxFxg1rpK31j
 7akwTACC8LA25gdBXEsoizhQ4EjfOqjHkwqMWAeK3AmhQxlUU5qXBWIbNo2P6L1W9dVO
 30uA==
X-Gm-Message-State: AGi0PuaC+IyWqvmIEOdEvshDsSG6RTs4K65Ou+YZgJf0ATEDrAEM+CsH
 NQbkVg0rEbi3GiDBh/PPxpN/wakqz24=
X-Google-Smtp-Source: APiQypLyTnGrTHyYnknK9WQhzBklWrnjk/ZUhuFMnwGbhCGFImwXysm5JxOe0CYQ3/uEOptNqrDipQ==
X-Received: by 2002:a17:90a:32ea:: with SMTP id
 l97mr23042764pjb.50.1587989400281; 
 Mon, 27 Apr 2020 05:10:00 -0700 (PDT)
Received: from localhost.localdomain ([1.38.220.114])
 by smtp.gmail.com with ESMTPSA id r17sm9623885pgn.35.2020.04.27.05.09.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2020 05:09:59 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 27 Apr 2020 17:38:30 +0530
Message-Id: <20200427120834.380-20-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200427120834.380-1-jaskaransingh7654321@gmail.com>
References: <20200427120834.380-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 27 Apr 2020 14:10:05 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 27 Apr 2020 14:10:02 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 19/23] parsing_cocci: unify_ast: Reflect Parameter
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

Parameter attributes are added to the SmPL AST. Reflect these changes in
unify_ast.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/unify_ast.ml | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/parsing_cocci/unify_ast.ml b/parsing_cocci/unify_ast.ml
index 68cb6613..e2b92c48 100644
--- a/parsing_cocci/unify_ast.ml
+++ b/parsing_cocci/unify_ast.ml
@@ -542,11 +542,17 @@ and unify_designator d1 d2 =
 
 and unify_parameterTypeDef p1 p2 =
   match (Ast.unwrap p1,Ast.unwrap p2) with
-    (Ast.VoidParam(ft1),Ast.VoidParam(ft2)) -> unify_fullType ft1 ft2
-  | (Ast.Param(ft1,i1),Ast.Param(ft2,i2)) ->
-      unify_fullType ft1 ft2 &&
-      unify_option unify_ident i1 i2
+    (Ast.VoidParam(ft1,attr1),Ast.VoidParam(ft2,attr2)) ->
+      if List.for_all2 unify_mcode attr1 attr2
+      then unify_fullType ft1 ft2
+      else false
+  | (Ast.Param(ft1,i1,attr1),Ast.Param(ft2,i2,attr2)) ->
 
+      if List.for_all2 unify_mcode attr1 attr2
+      then
+        unify_fullType ft1 ft2 &&
+        unify_option unify_ident i1 i2
+      else false
   | (Ast.MetaParam(_,_,_,_),_)
   | (Ast.MetaParamList(_,_,_,_,_),_)
   | (_,Ast.MetaParam(_,_,_,_))
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
