Return-Path: <SRS0=O8dQ=7N=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5646C433E0
	for <cocci@archiver.kernel.org>; Sun, 31 May 2020 15:28:01 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64AAE206DA
	for <cocci@archiver.kernel.org>; Sun, 31 May 2020 15:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MRbjdy8X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64AAE206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04VFRxhl028376;
	Sun, 31 May 2020 17:27:59 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 3975F7752;
	Sun, 31 May 2020 17:27:59 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id BC79A3C89
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 17:27:56 +0200 (CEST)
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:442])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04VFRtV7012713
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 17:27:56 +0200 (CEST)
Received: by mail-pf1-x442.google.com with SMTP id n15so2282035pfd.0
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 08:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SF0fEKNRQE0hfdZKrqQAWSzMC2Wucfj6sXpz+PSSvjI=;
 b=MRbjdy8Xmv8HMZ1M8j9QUSwReZa81/7D706bTMwbPJ+aCPEmgJruA2pWhdGyydpJMY
 trFoaL3Fq/57dgxj+87rWp0P2LcWvLJhnVWPGqaEkZbO+ukZn4uXsrNyvzB9d9YZ9hRt
 OKYzIBjAlyS/tt9vOb3kQN8yxrvmt3V574fFjaYrBHnwp2ndMcWi0uUpCUxp67Ub4uC7
 rp7wi7qihb48NGBLhEN/DTyFKHH+87snXEfKEnxDHMC+mTOhbqfS9PsWU6OjSqC0k9ta
 ENVs1RSQZftP/XAd3Sw0AsqidshdBkQNB9H1kbwCTa8BVuBixJgaut9ZsV0Ny62A63LZ
 FVmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SF0fEKNRQE0hfdZKrqQAWSzMC2Wucfj6sXpz+PSSvjI=;
 b=WBuR2GOfqBb4JX4rS9iiX/jiuyghMj/i2yqIO/cBPTaNrbacmliS/2/ujZzj4b0jCg
 U4uSsGOg4zcBGd9vzY5KFFw9nu0sX9PgnDoERa7y6KdaGQYJ65v1xlq8GG5LQLAzHEHk
 pf5TmdSOKA6qdyjNo6GtYn2hXMTTkNJFjl9agRHgzoz7hSXl2LQeHgDDfkgWkQ9vvOIf
 zSQbF5CTTvPh3lcDlLr62O+N/K/UM+PlGDsTvqeD7kCzTBkN1WxcgfYns8UOw3ECASgc
 SlxzXuzYnCOfnLVZlkz4Qg2oMeAMMsbL/VutbJcFz3PsStOvF/rrRAG+s/YMA5dQeGOp
 bapg==
X-Gm-Message-State: AOAM532QGYk4B6dUzlq3kdTfPcrUc2T5cmggj8z1Psf2WiIhKfx7TioD
 E9jCBe41DaVMdCnSmaUx100m54aZ
X-Google-Smtp-Source: ABdhPJx7lZruaEGSlK38Q5FdcbLL1e5LT76Ki37lo4BAvSaojHpJeUNHjNdphdL+SV76KgdCi2Y32Q==
X-Received: by 2002:aa7:91da:: with SMTP id z26mr9479338pfa.64.1590938874418; 
 Sun, 31 May 2020 08:27:54 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:1863:fef5:a170:128b:8ef:499d])
 by smtp.gmail.com with ESMTPSA id 131sm12310443pfv.139.2020.05.31.08.27.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2020 08:27:54 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sun, 31 May 2020 20:56:10 +0530
Message-Id: <20200531152621.2886-17-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200531152621.2886-1-jaskaransingh7654321@gmail.com>
References: <20200531152621.2886-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 31 May 2020 17:27:59 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 31 May 2020 17:27:56 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 16/27] parsing_cocci: disjdistr: Reflect struct end
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

Struct end attributes are added to the SmPL AST. Reflect these changes
in disjdistr.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/disjdistr.ml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/parsing_cocci/disjdistr.ml b/parsing_cocci/disjdistr.ml
index b8491931..ba2b8c02 100644
--- a/parsing_cocci/disjdistr.ml
+++ b/parsing_cocci/disjdistr.ml
@@ -351,9 +351,9 @@ and disjdecl d =
       disjmult3 (disjident name) (disjdots disjexp args) (disjini ini)
 	(fun name args ini ->
 	  Ast.rewrap d (Ast.MacroDeclInit(stg,name,lp,args,rp,eq,ini,sem)))
-  | Ast.TyDecl(ty,sem) ->
+  | Ast.TyDecl(ty,attr,sem) ->
       let ty = disjty ty in
-      List.map (function ty -> Ast.rewrap d (Ast.TyDecl(ty,sem))) ty
+      List.map (function ty -> Ast.rewrap d (Ast.TyDecl(ty,attr,sem))) ty
   | Ast.Typedef(stg,ty,id,sem) ->
       let ty = disjty ty in (* disj not allowed in id *)
       List.map (function ty -> Ast.rewrap d (Ast.Typedef(stg,ty,id,sem))) ty
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
