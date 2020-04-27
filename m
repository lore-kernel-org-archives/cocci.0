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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE631C55199
	for <cocci@archiver.kernel.org>; Mon, 27 Apr 2020 12:09:21 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E8A3206CD
	for <cocci@archiver.kernel.org>; Mon, 27 Apr 2020 12:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7yHica3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E8A3206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03RC9223002113;
	Mon, 27 Apr 2020 14:09:03 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 8CA427843;
	Mon, 27 Apr 2020 14:09:01 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7E94C7842
 for <cocci@systeme.lip6.fr>; Mon, 27 Apr 2020 14:09:00 +0200 (CEST)
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:543])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03RC8tcj001397
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 27 Apr 2020 14:08:56 +0200 (CEST)
Received: by mail-pg1-x543.google.com with SMTP id h69so8598339pgc.8
 for <cocci@systeme.lip6.fr>; Mon, 27 Apr 2020 05:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EoZoSm0QiODt/4J+FuqA6+ZZi5LG3HLcOc7upKu+yJM=;
 b=R7yHica3shohf+92In4pjcI74a4GfMNHDik0wVV3cB42MPo/RE1K3KhhsbDQS8ZC9m
 PdQdoIL1wt2VT0/mCHnzjsmBPCGhTwu4CV0ajPIPlc2rqci4e5r9eyR5ML9YdFKjXRWY
 qtS6818TfXmknxu1JmyyXOqhjJ9ouKZ7t57ALkDxYG5xrOGWJ3KVJs+A/9/gMgRMJGLx
 HFOf9GQkxzfZtncFpVL8D5B2AEo0Gc7Vh1ousSwShJX7+4gGbNt3pRCJWZUPK2EmHD67
 4eYLm2jPG+DoepASTCix2K0M/Yu7upUddso3wep2iBqMal2/vCHMhtGF9WS6t6JiM680
 lT8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EoZoSm0QiODt/4J+FuqA6+ZZi5LG3HLcOc7upKu+yJM=;
 b=nOFxlKDZJUQK/lRR8rzkwi/kLX7xK84BRMFjoMmpthIE7s5medQYH35QU848lYvj0R
 SLTjxieB6btiYe3wZpn57nlhsFsSXlw0F//N8phdC5hyhFp2BkvwrcTIeoHtTY069zQI
 yO08ZUG0P9m6ztSdOB0jKUfh7ABytjN7XeyNTHe0lyw+Ij9jFhLvjUwNCoem7IGtw2d/
 vsQiGwy69tqOuf4ZrqDj0kkQXTfVJzI9TWYZncvTXdD+4ZJmpIIIOFnzOH94Kh8bQhFN
 BfK1oswY89myDxI83lwCgWuCj/9u6LyVvKTUMnG5uL3GJ7WwmBl/7/FWoi0pQvZCJh4u
 +6xQ==
X-Gm-Message-State: AGi0PubwO1rENiYEqkkI0GYnFFdnXrbh+U0XVdT6yiZu8c7NziLifLlY
 Yhm3flrLrQMI0ulgroua66rCU7QWD50=
X-Google-Smtp-Source: APiQypIwXevV7IoRsnLu8OBV28oCnIRiQ2xXzPupX+CQDkmAlP3Bvc2kQx+rlURw+FWjonzH6Dan4w==
X-Received: by 2002:a63:e441:: with SMTP id i1mr22073345pgk.285.1587989334326; 
 Mon, 27 Apr 2020 05:08:54 -0700 (PDT)
Received: from localhost.localdomain ([1.38.220.114])
 by smtp.gmail.com with ESMTPSA id r17sm9623885pgn.35.2020.04.27.05.08.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2020 05:08:53 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 27 Apr 2020 17:38:13 +0530
Message-Id: <20200427120834.380-3-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200427120834.380-1-jaskaransingh7654321@gmail.com>
References: <20200427120834.380-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 27 Apr 2020 14:09:03 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 27 Apr 2020 14:08:56 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 02/23] parsing_cocci: parser: Parse Parameter
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

Parameter attributes are added to the SmPL AST. Parse these attributes
correctly in the SmPL parser. The added production only supports
attributes after the type or the type and identifier.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/parser_cocci_menhir.mly | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/parsing_cocci/parser_cocci_menhir.mly b/parsing_cocci/parser_cocci_menhir.mly
index db5661bd..fe4ef322 100644
--- a/parsing_cocci/parser_cocci_menhir.mly
+++ b/parsing_cocci/parser_cocci_menhir.mly
@@ -1541,9 +1541,10 @@ storage:
        | s=Tregister    { P.clt2mcode Ast.Register s }
        | s=Textern      { P.clt2mcode Ast.Extern s }
 
-decl: t=ctype d=direct_declarator(disj_ident)
-	{ let (i,fn) = d in Ast0.wrap(Ast0.Param(fn t, Some i)) }
-    | t=ctype { (*verify in FunDecl*) Ast0.wrap(Ast0.Param(t, None)) }
+decl: t=ctype d=direct_declarator(disj_ident) ar=attr_list
+	{ let (i,fn) = d in Ast0.wrap(Ast0.Param(fn t, Some i, ar)) }
+    | t=ctype ar=attr_list
+        { (*verify in FunDecl*) Ast0.wrap(Ast0.Param(t, None, ar)) }
     | TMetaParam
 	{ let (nm,cstr,pure,clt) = $1 in
 	Ast0.wrap(Ast0.MetaParam(P.clt2mcode nm clt,cstr,pure)) }
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
