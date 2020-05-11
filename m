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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6594EC54E8D
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:09:07 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D872420731
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7GeQ6an"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D872420731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04BA8u15023886;
	Mon, 11 May 2020 12:08:56 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id ED9F93E6B;
	Mon, 11 May 2020 12:08:55 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 397B13DC8
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:08:54 +0200 (CEST)
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:441])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04BA8q86013547
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:08:53 +0200 (CEST)
Received: by mail-pf1-x441.google.com with SMTP id r14so4538084pfg.2
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 03:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9+LCecuHRzdR/o7M/ikGH5G4JrMwoDyf73lHut0jbu0=;
 b=h7GeQ6angKT+XYjyho/EzT2LYrafE7OVEX1t7xcLS3lNqkor/j9ihEJF99yDW0QRny
 vAdyzmLTuWQwdKT6AngTHhE8B0ZjH9Gct1z/7MPIt8bZeD+E6jSXOUUZY2CSf51ekOIz
 +d6xOeViKZdrNFFX+GEjjh9dtQ/wZ/5DwgKtO/LfwCT+AEZ3Vkn8sJ4/RoOyCRrOlSdK
 sW3nHjaiCrPU8MAl8S3WAxlrA8cfcheYwCEiYNlJEUCP6tFxRSItiXgRGNv/5nFKQ8H8
 mIJXr5rMECbp7LIPgH8dn6auIX9F+i2LstWrnkf95Zpe0oWdTiD6kEU4K2dN+Mss/yld
 0RIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9+LCecuHRzdR/o7M/ikGH5G4JrMwoDyf73lHut0jbu0=;
 b=kzPtvxGaXavUdF4ybnLzyWhBvtnPfPDhcVijto/VhNx6kjge5rhPgiqo0sR3VJN1Wu
 5MmHge5q+Jeykvsz9wygwkAu8nxiJLwcS+NsS23fO9GhIrqKEI6PqXZnski/08CQusgl
 ZJkFiiADpyZNu2v1WabzH9zYzpQdlD+AUhJ/M0xDZMrvezLgZ4MQ64Qn9Hjx6VZvH6rS
 aMmcWmOYC1YsYOCpJjSr7fnb0wrAqX5Wzs6G1oO1IWCgdYgEPJ2K+JVzNwHh80YyDDGJ
 nQtBMFeBV140JVvUT/2U79ezQ4qI6BbKLKe84q13pAggCrKp4vk/FdahuiOnKZklNMCg
 xgpw==
X-Gm-Message-State: AGi0PuZ1xkAy1OgLyUf4xxPWBH/xOjNnhMOGK4D+5rek/g0GTBYTQOEQ
 ee8eOi5xFGoXF4GPyGXeLhpjiXgmPpg=
X-Google-Smtp-Source: APiQypIPXNUv4FjDzB/h0HAlb6FddelA+Zob+scQO3d444cuX7sBPXiFL7cOBR2jTYcvF6VyeuzB3A==
X-Received: by 2002:a62:1b84:: with SMTP id
 b126mr15566787pfb.123.1589191731833; 
 Mon, 11 May 2020 03:08:51 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:382:66db:4729:1ab8:2139:8945])
 by smtp.gmail.com with ESMTPSA id
 o99sm9772994pjo.8.2020.05.11.03.08.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 03:08:51 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 11 May 2020 15:37:02 +0530
Message-Id: <20200511100715.19819-20-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200511100715.19819-1-jaskaransingh7654321@gmail.com>
References: <20200511100715.19819-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 11 May 2020 12:08:56 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 11 May 2020 12:08:53 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v2 19/32] parsing_cocci: unify_ast: Reflect Cast
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

Cast attributes are added to the SmPL AST. Reflect these changes in
unify_ast.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/unify_ast.ml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/parsing_cocci/unify_ast.ml b/parsing_cocci/unify_ast.ml
index 68cb6613..25287503 100644
--- a/parsing_cocci/unify_ast.ml
+++ b/parsing_cocci/unify_ast.ml
@@ -220,8 +220,10 @@ and unify_expression e1 e2 =
       unify_expression e1 e2 && unify_ident fld1 fld2
   | (Ast.RecordPtAccess(e1,pt1,fld1),Ast.RecordPtAccess(e2,pt2,fld2)) ->
       unify_expression e1 e2 && unify_ident fld1 fld2
-  | (Ast.Cast(lp1,ty1,rp1,e1),Ast.Cast(lp2,ty2,rp2,e2)) ->
-      unify_fullType ty1 ty2 && unify_expression e1 e2
+  | (Ast.Cast(lp1,ty1,attr1,rp1,e1),Ast.Cast(lp2,ty2,attr2,rp2,e2)) ->
+      if List.for_all2 unify_mcode attr1 attr2
+      then unify_fullType ty1 ty2 && unify_expression e1 e2
+      else false
   | (Ast.SizeOfExpr(szf1,e1),Ast.SizeOfExpr(szf2,e2)) ->
       unify_expression e1 e2
   | (Ast.SizeOfType(szf1,lp1,ty1,rp1),Ast.SizeOfType(szf2,lp2,ty2,rp2)) ->
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
