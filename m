Return-Path: <SRS0=Yx51=7L=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED3CC433DF
	for <cocci@archiver.kernel.org>; Fri, 29 May 2020 12:09:45 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81519206F0
	for <cocci@archiver.kernel.org>; Fri, 29 May 2020 12:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pUK5ZvId"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81519206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04TC9fgW009322;
	Fri, 29 May 2020 14:09:41 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id C4E117783;
	Fri, 29 May 2020 14:09:41 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 5F0115D47
 for <cocci@systeme.lip6.fr>; Fri, 29 May 2020 14:09:40 +0200 (CEST)
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:641])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04TC9cuj020792
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 29 May 2020 14:09:39 +0200 (CEST)
Received: by mail-pl1-x641.google.com with SMTP id t16so1089688plo.7
 for <cocci@systeme.lip6.fr>; Fri, 29 May 2020 05:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Or1NaRYISV1vwJAK4o18y0yXpcwFKIGkq7teampwCKk=;
 b=pUK5ZvIdnz75WZ29JTbdef9Hm+1GOSRhTTH1jrYk9pMfHBoNNRGm8Eub0Ka1enbmRS
 BotTX/3z3WEghP+NqFbIc3xyEl1lrTHfMNqH8E7Y8+mC0tDUAN8Cd+Tl0bos26x/ni5o
 DPHUPJTaxAHfm+nzw9Y0qU8G4XgqVox7ZHS48bTVrLbQD2opIN6xMlVAfRSzXAmAAMLT
 /UtTO1+TP0bvhz8AwrblDJuq2cdtCXkyNmoxyarBB/75pRVYdNGb0h9Eg0Qr0iPnzq5j
 SzDmf56T6OzcZjpZQRpzr7iaVau5eud22ywF3WLcDoRDcBe7bePotn4wfPZLYAR/wQwP
 A0UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Or1NaRYISV1vwJAK4o18y0yXpcwFKIGkq7teampwCKk=;
 b=sTxTjvwlXHqynHocujlJyvVY4OANrNqfu8SwbINQuLB05y2pMdWId0WJWiTBNK7Dw/
 KsYc5t+5H5CitCaqFukNiAZ4ACieSs0T4TvXQKC43mUpBufRCBA+vgzuXgO8tx/dUM2f
 B2qmaFt9qDwAxpD5mZOk/XI9LPWdFFCGnRq1l9M3dNN1a6zT0mBJcC4B3w01XO9jkagV
 bb54bjtsPa7vVX61ud0QPT7nXKqUIlvAM7Vmt+DbF7LxdiAcrulqRGFLgbTo2qY4DnyC
 kShYzVz+ZcVZ8DWY2V1hGTktWGNXIqisiUnTP6E5mj+8TySBYku8aR5Di1nOE7N3KdDH
 8lHQ==
X-Gm-Message-State: AOAM5333qP0EghNFeURMlbNJXtuwr4ZRhBnY6nwXJRg+OXtVk6NzWN5S
 GByQ1d2pY01IiOAVklWaQdCqcfaV
X-Google-Smtp-Source: ABdhPJyM2hdlKexVrZF+MKWfcfL7qQiA2PI8e0V1Oix3VYWGO0bTgjNVZfZqdyQxSP2vbS7a7uL30g==
X-Received: by 2002:a17:90a:a613:: with SMTP id
 c19mr9119641pjq.155.1590754177920; 
 Fri, 29 May 2020 05:09:37 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:694:e576:19d1:a79b:707d:59f2])
 by smtp.gmail.com with ESMTPSA id dw13sm7975161pjb.40.2020.05.29.05.09.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2020 05:09:37 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri, 29 May 2020 17:36:49 +0530
Message-Id: <20200529120703.31145-20-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200529120703.31145-1-jaskaransingh7654321@gmail.com>
References: <20200529120703.31145-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 29 May 2020 14:09:41 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 29 May 2020 14:09:39 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v3 19/32] parsing_cocci: unify_ast: Reflect Cast
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
index e2b92c48..3822bf81 100644
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
