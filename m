Return-Path: <SRS0=02ua=7V=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B2FC433E0
	for <cocci@archiver.kernel.org>; Mon,  8 Jun 2020 12:21:06 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FA5C2074B
	for <cocci@archiver.kernel.org>; Mon,  8 Jun 2020 12:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZKycvy2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FA5C2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 058CL4lD024426;
	Mon, 8 Jun 2020 14:21:04 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id F2F437783;
	Mon,  8 Jun 2020 14:21:03 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id D197844A7
 for <cocci@systeme.lip6.fr>; Mon,  8 Jun 2020 14:21:02 +0200 (CEST)
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:641])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 058CL1PY022590
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 8 Jun 2020 14:21:02 +0200 (CEST)
Received: by mail-pl1-x641.google.com with SMTP id n2so6578168pld.13
 for <cocci@systeme.lip6.fr>; Mon, 08 Jun 2020 05:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KpNADySjSxgviZ47NrIw80ayrJdSlH5yFH10DEh6Q0w=;
 b=nZKycvy2w6KMWaLoR/N6Jxhr/1KG+jd/puMz8/26FwZJVTQSmQgejm261IcGrjv6G+
 kPkIhwth9R1xTMY80Qts2sImQN5wLfE+rv3OFbjfGheLwAl2THT/Fskc8C6h7UBXts18
 OMqPhERaIDx1+a0qq9eySYZ+ZtHY4U5KiwkvGoCY3yajmgIpOnwhNtcu21Pub2nY1XGK
 Wz5HH2buGP3716CaXgdcaU/KZ5d1MFxAArq3pJGpz6/MuuHSbKC5Q+GvWPYenEYEilJL
 U3kkpZtdQR6Ib1+zOLgOF3kAT5Y0fEaaTvQnaRYnS9Fd7oL9yPlrqn9fDLvYPct6Gddm
 mR9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KpNADySjSxgviZ47NrIw80ayrJdSlH5yFH10DEh6Q0w=;
 b=jAzAS1Yaxv8ryT3I6ShfplAA6WkRGmpVKr7wkJQRS8Oilz8CxoCKD8m1wTopnD2lGc
 54hCvysuooHb3zGleLUfDXYOyVAEID7qpORrk2tj21OpuIGpuW6+Qn42OwhbxX6MiVZA
 imqAK/0HhdXs/sTy/zuUHz0igcC51WBwPOGTRXWTe4xNrbs6qYvT65mLsfYEi7LqglY2
 KtALs7ZCXZBRZOUlWcdw0CQ+R+uvBWvsI/Dkx+RlGu9nJJdRSWymIoPdCgwn5bO9Det7
 hdCjGh/vPDVYRAkBBnmzJb3Rt722EYivyYt+p2SJHqM2vOFzqcBLmZhZFZo7TccJZAV6
 R6Bg==
X-Gm-Message-State: AOAM530Jqv8U0B9t7Codt5waZ9/1euy5JxQmM5Zw3YPnb0KfJQJ6e/A4
 9BS1aJTf2xTTAf4kvCtrALjuUYMU
X-Google-Smtp-Source: ABdhPJz9XlDcc/DxNbc5wo6U98ssO56xSpZFoRGydxGX1FlaNB0frnpgtna8PyWw3Es168K16F4ctg==
X-Received: by 2002:a17:902:ee12:: with SMTP id
 z18mr20829277plb.211.1591618860366; 
 Mon, 08 Jun 2020 05:21:00 -0700 (PDT)
Received: from localhost.localdomain
 ([2402:3a80:1863:7add:d8e9:7114:e8b0:51a9])
 by smtp.gmail.com with ESMTPSA id i5sm15747657pjd.23.2020.06.08.05.20.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 05:20:59 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon,  8 Jun 2020 17:50:36 +0530
Message-Id: <20200608122037.28019-4-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200608122037.28019-1-jaskaransingh7654321@gmail.com>
References: <20200608122037.28019-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 08 Jun 2020 14:21:04 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 08 Jun 2020 14:21:02 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 3/4] parsing_c: parser: Use end_attributes_opt in
	field_declaration
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

The field_declaration rule has redundant code caused by additional
productions for end attributes. Use end_attributes_opt to resolve this.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_c/parser_c.mly | 32 ++------------------------------
 1 file changed, 2 insertions(+), 30 deletions(-)

diff --git a/parsing_c/parser_c.mly b/parsing_c/parser_c.mly
index ebb3b327..61bb1ca0 100644
--- a/parsing_c/parser_c.mly
+++ b/parsing_c/parser_c.mly
@@ -1851,23 +1851,7 @@ struct_decl2:
 
 
 field_declaration:
- | spec_qualif_list struct_declarator_list TPtVirg
-     {
-       let (attrs, ds) = $1 in
-       let (returnType,storage) = fixDeclSpecForDecl ds in
-       if fst (unwrap storage) <> NoSto
-       then internal_error "parsing don't allow this";
-
-       let iistart = Ast_c.fakeInfo () in (* for parallelism with DeclList *)
-       FieldDeclList ($2 +> (List.map (fun (f, iivirg) ->
-         f returnType, iivirg))
-                         ,[$3;iistart])
-         (* don't need to check if typedef or func initialised cos
-          * grammar don't allow typedef nor initialiser in struct
-          *)
-     }
-
- | spec_qualif_list struct_declarator_list end_attributes TPtVirg
+ | spec_qualif_list struct_declarator_list end_attributes_opt TPtVirg
      {
        let (attrs, ds) = $1 in
        let (returnType,storage) = fixDeclSpecForDecl ds in
@@ -1883,19 +1867,7 @@ field_declaration:
           *)
      }
 
- | spec_qualif_list TPtVirg
-     {
-       let (attrs, ds) = $1 in
-       (* gccext: allow empty elements if it is a structdef or enumdef *)
-       let (returnType,storage) = fixDeclSpecForDecl ds in
-       if fst (unwrap storage) <> NoSto
-       then internal_error "parsing don't allow this";
-
-       let iistart = Ast_c.fakeInfo () in (* for parallelism with DeclList *)
-       FieldDeclList ([(Simple (None, returnType)) , []], [$2;iistart])
-     }
-
- | spec_qualif_list end_attributes TPtVirg
+ | spec_qualif_list end_attributes_opt TPtVirg
      {
        let (attrs, ds) = $1 in
        (* gccext: allow empty elements if it is a structdef or enumdef *)
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
