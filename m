Return-Path: <SRS0=FJ6B=7K=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99379C433DF
	for <cocci@archiver.kernel.org>; Thu, 28 May 2020 12:26:13 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1191B20888
	for <cocci@archiver.kernel.org>; Thu, 28 May 2020 12:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqHYV015"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1191B20888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04SCQAIv013388;
	Thu, 28 May 2020 14:26:10 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 5A72D5D47;
	Thu, 28 May 2020 14:26:10 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 976843E1D
 for <cocci@systeme.lip6.fr>; Thu, 28 May 2020 14:26:08 +0200 (CEST)
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:644])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04SCQ6jh022728
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Thu, 28 May 2020 14:26:07 +0200 (CEST)
Received: by mail-pl1-x644.google.com with SMTP id a13so11521259pls.8
 for <cocci@systeme.lip6.fr>; Thu, 28 May 2020 05:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=T2brFoIow4rd5tKe3ijdp0ueRTupRQzrSf/7ZqdUTjY=;
 b=TqHYV015n8H4WIlljmFlWyZEeFaaxtoLNqGz0dSzb+9yW4UW/S7J8WyHwjWBLLjKvR
 rYvQJ94tkczZR/pBjCATj/L4UT3MW2Vye+s/PAw/ZEUr5YruH158q01y9un4I7miKrDJ
 kSGCQUc8D8MyYQo0tFu2c9dXukzj09thSeVhhPIrul1G1FvOkkeedlGT/tAKRWkH5Nhw
 b/YMyGEL4saoD9R9U8xmsbeaVgBRR/FBWrDDoqLLo/dpVvjL4DsrIatKtPBOlLHFLFuE
 OWnaYqKzo/BvvwNzNCfK0J9n2DyFwVMNNBppO/ntacPiO4/k1wIN+KsaXdp6MYhyVobX
 Nc6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=T2brFoIow4rd5tKe3ijdp0ueRTupRQzrSf/7ZqdUTjY=;
 b=oUdTp9gPQE3mGx53ERZwh9HSFzYft7tJVsUy5rdVgVwEhop86+Gdw3+9xqzlnSy2NM
 Vo5oy8ZGUxWPLtfep+ut5iDB/9hYXqcpshdjhTNtIsnDOtiv2d+3OZS63zq3sdhvzohv
 HacMZQpK1gT4LpiQ9PxkLWYj8X45pi0eQkTKkfRt+oQw6GOsH/vIncmXpxZNugtPPhnB
 9HffC9MIToqqstKq463IquCb/9QmVZe63qTfxSFrxsxCb/00akeNB9agb2kTcL6yvb0w
 ghyyMAkaGLzdz0Z5deBnav4d2yexGkFZ6gnRBNZAk+CIHaaURf7k/WSc21BnzOFvgJgw
 qvxQ==
X-Gm-Message-State: AOAM532V0FhcOAzOqXZpEJ+2h9uaAg51ipF0ZO66wXk7UMBWep6w0Wtz
 cpG87lA4Vh/AEy8Yz9pmz51s7cOA
X-Google-Smtp-Source: ABdhPJzs618xBbe2c7sSFFQ0pxRW5xjR4C6EdWgiodo41oaYH6AqgiV7I1mHg219yQOQlwdT7H46jA==
X-Received: by 2002:a17:902:6a88:: with SMTP id
 n8mr3327098plk.195.1590668765774; 
 Thu, 28 May 2020 05:26:05 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:2183:e360:deba:7bf4:98ef:5568])
 by smtp.gmail.com with ESMTPSA id 1sm5722888pje.26.2020.05.28.05.26.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2020 05:26:04 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Thu, 28 May 2020 17:54:26 +0530
Message-Id: <20200528122428.4212-25-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200528122428.4212-1-jaskaransingh7654321@gmail.com>
References: <20200528122428.4212-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 28 May 2020 14:26:10 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Thu, 28 May 2020 14:26:07 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v2 24/25] engine: cocci_vs_c: "Match" parameter
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

Parameter attributes are added to the C AST, but not to the SmPL AST.
Once parameter attributes are added to SmPL as well, they can actually
be matched, but for now a call to attribute_list is required to
correctly remove attributes. Attributes from a parameter are removed
when the whole parameter is removed, replaced or otherwise.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 engine/cocci_vs_c.ml | 50 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 41 insertions(+), 9 deletions(-)

diff --git a/engine/cocci_vs_c.ml b/engine/cocci_vs_c.ml
index 413ea220..317fa71e 100644
--- a/engine/cocci_vs_c.ml
+++ b/engine/cocci_vs_c.ml
@@ -594,6 +594,23 @@ let initialisation_to_affectation decl =
 	Some x -> F.DefineExpr x
       |	None -> F.Decl decl
 
+let check_allminus =
+  let mcode r (_,_,kind,_) =
+    match kind with
+      A.MINUS(_,_,_,_) -> true
+    | _ -> false in
+  let bind x y = x && y in
+  let option_default = true in
+  let donothing r k re = k re in
+  Visitor_ast.combiner bind option_default
+    mcode mcode mcode mcode mcode mcode mcode mcode mcode
+    mcode mcode mcode mcode mcode
+    donothing donothing donothing donothing donothing donothing
+    donothing donothing donothing donothing donothing donothing
+    donothing donothing donothing donothing donothing donothing
+    donothing donothing donothing donothing donothing donothing
+    donothing donothing donothing donothing
+
 (*****************************************************************************)
 (* Functor parameter combinators *)
 (*****************************************************************************)
@@ -1994,7 +2011,8 @@ and argument arga argb =
   X.all_bound (A.get_inherited arga) >&&>
   match A.unwrap arga, argb with
   | A.TypeExp tya,
-    Right (B.ArgType {B.p_register=b,iib; p_namei=sopt;p_type=tyb}) ->
+    Right (B.ArgType
+            {B.p_register=b,iib; p_namei=sopt;p_type=tyb;p_attr=attrs}) ->
       if b || sopt <> None
       then
         (* failwith "the argument have a storage and ast_cocci does not have"*)
@@ -2006,7 +2024,8 @@ and argument arga argb =
             (A.TypeExp tya) +> A.rewrap arga,
             (Right (B.ArgType {B.p_register=(b,iib);
                                p_namei=sopt;
-                               p_type=tyb;}))
+                               p_type=tyb;
+                               p_attr=attrs;}))
         ))
 
   | A.TypeExp tya,  _                                  -> fail
@@ -2099,19 +2118,25 @@ and parameters_bis eas ebs =
           | [], [Left eb] ->
               let {B.p_register=(hasreg,iihasreg);
                     p_namei = idbopt;
-                    p_type=tb; } = eb in
+                    p_type=tb;
+                    p_attr=attrs; } = eb in
 
+              let attr_allminus =
+                check_allminus.Visitor_ast.combiner_parameter ea in
               if idbopt = None && not hasreg
               then
                 match tb with
                 | (qub, (B.BaseType B.Void,_)) ->
                     fullType ta tb >>= (fun ta tb ->
+                    attribute_list attr_allminus [] attrs >>=
+                    (fun attrsa attrsb ->
                       return (
                       [(A.VoidParam ta) +> A.rewrap ea],
                       [Left {B.p_register=(hasreg, iihasreg);
                               p_namei = idbopt;
-                              p_type = tb;}]
-			))
+                              p_type = tb;
+                              p_attr = attrsb;}]
+			)))
                 | _ -> fail
               else fail
           | _ -> fail)
@@ -2149,9 +2174,14 @@ and parameter = fun parama paramb ->
   | A.Param (typa, idaopt), eb ->
       let {B.p_register = (hasreg,iihasreg);
 	    p_namei = nameidbopt;
-	    p_type = typb;} = paramb in
+	    p_type = typb;
+            p_attr = attrs;} = paramb in
+
+      let attr_allminus =
+        check_allminus.Visitor_ast.combiner_parameter parama in
 
       fullType typa typb >>= (fun typa typb ->
+      attribute_list attr_allminus [] attrs >>= (fun attrsa attrsb ->
 	match idaopt, nameidbopt with
 	| Some ida, Some nameidb ->
       (* todo: if minus on ida, should also minus the iihasreg ? *)
@@ -2160,7 +2190,8 @@ and parameter = fun parama paramb ->
               A.Param (typa, Some ida)+> A.rewrap parama,
               {B.p_register = (hasreg, iihasreg);
 		p_namei = Some (nameidb);
-		p_type = typb}
+                p_type = typb;
+                p_attr = attrsb;}
 		))
 
 	| None, None ->
@@ -2168,7 +2199,8 @@ and parameter = fun parama paramb ->
             A.Param (typa, None)+> A.rewrap parama,
             {B.p_register=(hasreg,iihasreg);
               p_namei = None;
-              p_type = typb;}
+              p_type = typb;
+              p_attr = attrsb;}
 	      )
   (* why handle this case ? because of transform_proto ? we may not
    * have an ident in the proto.
@@ -2183,7 +2215,7 @@ and parameter = fun parama paramb ->
  *)
 
 	| Some _, None -> fail
-	| None, Some _ -> fail)
+	| None, Some _ -> fail))
   | A.OptParam _, _ ->
       failwith "not handling Opt for Param"
   | _ -> fail
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
