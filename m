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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94E9C54E8D
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:14:56 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38E5A2075E
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pDQWaZaL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38E5A2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04BAEWhA020202;
	Mon, 11 May 2020 12:14:32 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A51393E6B;
	Mon, 11 May 2020 12:14:32 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 100F23DC8
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:14:31 +0200 (CEST)
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1044])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04BAETAI007039
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:14:30 +0200 (CEST)
Received: by mail-pj1-x1044.google.com with SMTP id e6so7551866pjt.4
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 03:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TV0hQbWPE6I76/eXMWA6DfzgeTBXmkrL8f2jcsCkf6M=;
 b=pDQWaZaLZq5Zp3He8jOevTL36fH5efM7S8NZMK8PNRUNPqV2R80Ocu64IvtOqZTFPO
 KRSkrBCLqhRj10nSluJvpyMHLKBCzqERxK3+qu/uONFaXwFK2F7UAfrNz00oJI1mWiV8
 EzxSyyHuRZimEaJZIYyKJHPPR1hL2bnE7mKQmIqDA8f0IltOCXtLa6z/eGPfa65FrOCA
 rLZE8hm5onqaEl3JhhVDgZeHh+YVO+iUcr1xP7qh2dpSCDPbCUXSfITiRjO8Vo/yT4KY
 zL+76sV7YEynP56BWbYJMI9NuznvQei3EXxIusLJaYY1n35wC6VWFaqt7yOMcProeSp3
 YOLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TV0hQbWPE6I76/eXMWA6DfzgeTBXmkrL8f2jcsCkf6M=;
 b=h3XvDiovKoixqQJfenR5D8YzneTDSCicDV7rEeTQmpwYSSrlDZMpLsH1mSaEDlDzaK
 mwtLwNL0m0iuKNaJPg0hNAxvJ1XN+KWii7+mPzcf8fWpD4kwB27dbOqCJsBJSeAkHAiz
 4NR1mUxA5h4TAHgbehdnUuNjLfU14Ol5GLD43J3mRlxA8hMr4Yqz5kMDqtbkvt2UvH78
 EuC+oEneddOpCvS0UBmBEWiySaXOqHbJfPCHFZmeOhf0wRJn6Q+1za7USO1SUmXKudA4
 3gufVRapBxV+u0T2Y9sEbbwxhRWtHCGbB1EBnUsDVFiJoUehXQd9NP07DY/qXkSqEnu2
 K2Tw==
X-Gm-Message-State: AGi0PuYumrpxOJ8lPDRSYywlg0ObSXRml+J4cJ6kx+Gh8bDmogY7hstd
 I2DgWcbRq3AS2iJL4TTn1Vgzod3RyOw=
X-Google-Smtp-Source: APiQypKini2t5ARQmTcRJ7w/Cnlob2L/WnrdU5+FGEjGRwoFIPYYlRfdXS8E6IOzLddn4KoEYVvW7A==
X-Received: by 2002:a17:90a:2046:: with SMTP id
 n64mr21598286pjc.230.1589192068735; 
 Mon, 11 May 2020 03:14:28 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:382:66db:4729:1ab8:2139:8945])
 by smtp.gmail.com with ESMTPSA id
 j14sm10021121pjm.27.2020.05.11.03.14.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 03:14:28 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 11 May 2020 15:42:56 +0530
Message-Id: <20200511101300.11101-20-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200511101300.11101-1-jaskaransingh7654321@gmail.com>
References: <20200511101300.11101-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 11 May 2020 12:14:32 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 11 May 2020 12:14:30 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v3 19/23] parsing_cocci: unify_ast: Reflect
	Parameter attributes
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
