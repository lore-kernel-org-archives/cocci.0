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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B60E2C433E1
	for <cocci@archiver.kernel.org>; Sun, 24 May 2020 17:21:28 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 543A9206C3
	for <cocci@archiver.kernel.org>; Sun, 24 May 2020 17:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lN1JFHjX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 543A9206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04OHLPsO016708;
	Sun, 24 May 2020 19:21:25 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id C14AC3DC8;
	Sun, 24 May 2020 19:21:25 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id A3D273D0F
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 19:21:23 +0200 (CEST)
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1044])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04OHLM59027601
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 19:21:22 +0200 (CEST)
Received: by mail-pj1-x1044.google.com with SMTP id q24so7579625pjd.1
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 10:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=os3s+iiu3kRUhEBpBGoWTbPu1B0JO7uZ2SeONoSREVg=;
 b=lN1JFHjXy6Z2Xn9NgQNwCSGkqzi3SZU1f3l4aB/NxvM7JHO+hJPskAXo10NiyleEou
 ZDiuQflg7lQoWDj4gzg9YX8KBdO6n7FxgAQ2OZsiBVKFJKmaRzcLtob8xcI6ee+tVI0X
 U+bxWkS8wx4aggXGxgKF3FKsMA26FuAZSjImEYQCBDb2FPMAA1B6xPsT4Qixt7uZZwGj
 GzLqX24fVWMKnmwbEOe3rtu12eJjmLHdYYq3ph7dFWapVX6arpsSmZds6LCi04VhFPJt
 iw+p8fuWPM5wQsbEQuRcjPaAfITwxcKq+pz7IVfxAwLmFU7aisG6+I4Pym9b/ED+e86z
 +WNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=os3s+iiu3kRUhEBpBGoWTbPu1B0JO7uZ2SeONoSREVg=;
 b=cCdqhlNnsYYZNdwQyEjTWNLmJ/RNe1u/YXNtMveW5vA8MsuiuMvwzSJVOE7IwZQ+Xs
 ru3PfzHtd84HIcxFgopBDTpBDMaVDjfngOzq9dIjRBAj0Y3IIfvaHmMtiwMPIUPmA4XR
 6J2y5JOiU7hVp3Ak0YLl7G877ciOxoKpPGFTo+v6AG81Bk0+Vd+rN9Fp6d57eyuQ2E8W
 XjBluBKOMGfSxNQ0CcxRSgicsvPxi8Aeo/2RPRugqoqY3ITHpO/ui88o6VStsYhl5ccB
 l93UTYu9GoYDJtpKX62UAiAx5qhe6yOrWgJHE2ZgsxnJsvgW6qSBPYOXknXNyPgVGKz4
 wFyw==
X-Gm-Message-State: AOAM531Zk+BbuUseeyHlOlHw8erAvrcK6eOeIGIqhFFKcNEQs722CXwv
 pRi34YnTAkgc0oeI08V4FzxQBd3VjLQ=
X-Google-Smtp-Source: ABdhPJyT7AmwQVVJMt44XvefjBQQvprCe+glU2wY4o9ENb4QyI+bO2vj48Bmvw1Y/Jewy7ZCLSco3g==
X-Received: by 2002:a17:90a:7ace:: with SMTP id
 b14mr14598962pjl.116.1590340881350; 
 Sun, 24 May 2020 10:21:21 -0700 (PDT)
Received: from localhost.localdomain ([1.38.220.54])
 by smtp.gmail.com with ESMTPSA id d9sm6556497pfn.72.2020.05.24.10.21.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2020 10:21:20 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sun, 24 May 2020 22:49:21 +0530
Message-Id: <20200524171935.2504-17-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200524171935.2504-1-jaskaransingh7654321@gmail.com>
References: <20200524171935.2504-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 24 May 2020 19:21:25 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 24 May 2020 19:21:23 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 16/30] parsing_cocci: disjdistr: Reflect Macrodecl
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
disjdistr.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/disjdistr.ml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/parsing_cocci/disjdistr.ml b/parsing_cocci/disjdistr.ml
index 6724bb25..8a42743a 100644
--- a/parsing_cocci/disjdistr.ml
+++ b/parsing_cocci/disjdistr.ml
@@ -342,10 +342,10 @@ and disjdecl d =
       disjmult2 (disjmult disjfninfo fninfo) (disjident name)
 	(fun fninfo name ->
 	  Ast.rewrap d (Ast.FunProto(fninfo,name,lp1,params,va,rp1,sem)))
-  | Ast.MacroDecl(stg,name,lp,args,rp,sem) ->
+  | Ast.MacroDecl(stg,name,lp,args,rp,attr,sem) ->
       disjmult2 (disjident name) (disjdots disjexp args)
 	(fun name args ->
-	  Ast.rewrap d (Ast.MacroDecl(stg,name,lp,args,rp,sem)))
+	  Ast.rewrap d (Ast.MacroDecl(stg,name,lp,args,rp,attr,sem)))
   | Ast.MacroDeclInit(stg,name,lp,args,rp,eq,ini,sem) ->
       disjmult3 (disjident name) (disjdots disjexp args) (disjini ini)
 	(fun name args ini ->
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
