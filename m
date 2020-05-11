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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0CEC54E4B
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:13:40 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ADA1206D6
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYE8YFmQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ADA1206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04BADR6c028016;
	Mon, 11 May 2020 12:13:29 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A9F107831;
	Mon, 11 May 2020 12:13:29 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 3ABD43DC8
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:13:28 +0200 (CEST)
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1042])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04BADQZn027759
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:13:27 +0200 (CEST)
Received: by mail-pj1-x1042.google.com with SMTP id hi11so7621984pjb.3
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 03:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EoZoSm0QiODt/4J+FuqA6+ZZi5LG3HLcOc7upKu+yJM=;
 b=cYE8YFmQ6IDPFzfo1kFv2uiAJ0RKuDf+NMfBaB8rZOQtuE0vBTuulZ7EJha4OW1LSE
 dsEKjyilml+HhGP3reEJjnDtSG8xXXzNy6Q01gVkNU/giP4DXTunuqPSVeJa9DVHaC0R
 F5+JWAp7X6IAAq3M+Ka7sJ34SMNunhK1d5ykfV4GVbEXEppJerkm04WzI/f2k/l73et/
 eHVJamPKyWmJ//9taKqwShUNIlN5FeJLmrCPrlRTOCqpcjxEnXHun/XORZVmYbsjxHxZ
 X9hzRkr5YA50e36gFLJ4npA5Rlk+hHdfFEQ3RuX0fwY4k2qIiVcvBpI284SFhShZN5kS
 wGeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EoZoSm0QiODt/4J+FuqA6+ZZi5LG3HLcOc7upKu+yJM=;
 b=QraWDidedYuC5ZKLLMhJQKEsHVxpMfMcS2yOu+kvMnjN2W3oQhzEhFbJe88U1F+GOS
 UobnKWyfyKFtl+WFOkeaiT6SWFuxfbs+elZoIWeSoFOHOBZO1C24dQYDi8bndwWRYFDP
 pWm84A7NXquOhdDQZ0zpjgGyaY1CXX+qblQISVfJUra2ybmQRR9Lr8+3JohRCEF7JibR
 gDWl7dD9BbvyyXGe6xxOCLHesZEC+JAQ8OdKV8ODdK+2meWPn6QgN3FPJJocOc3AHcfN
 +YQnUnJoMRL6ky2B2e2d/bFAXHDvSt+Tuzh5CM/gQApo/ssXS6+ot54PXYi0v87/WsvI
 CwDg==
X-Gm-Message-State: AGi0PuYKhZsHI77YopcSlZ4bKRWvmTPyZMS6cEcIOv3VGC9YXFYLHKbQ
 V3TOfAU3pjvAQpG89YGnTpwWvM2GczQ=
X-Google-Smtp-Source: APiQypK5Yi5Ac8AkWi22B/7AAR5vBfiFx5OM0TadenrlfR7I5M4UEo0Mz9L67sjxk3A1RK3s7MrDxA==
X-Received: by 2002:a17:902:778a:: with SMTP id
 o10mr13930114pll.76.1589192005779; 
 Mon, 11 May 2020 03:13:25 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:382:66db:4729:1ab8:2139:8945])
 by smtp.gmail.com with ESMTPSA id
 j14sm10021121pjm.27.2020.05.11.03.13.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 03:13:25 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 11 May 2020 15:42:39 +0530
Message-Id: <20200511101300.11101-3-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200511101300.11101-1-jaskaransingh7654321@gmail.com>
References: <20200511101300.11101-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 11 May 2020 12:13:29 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 11 May 2020 12:13:27 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v3 02/23] parsing_cocci: parser: Parse Parameter
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
