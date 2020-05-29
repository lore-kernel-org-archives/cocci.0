Return-Path: <SRS0=Yx51=7L=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC95C433E4
	for <cocci@archiver.kernel.org>; Fri, 29 May 2020 12:10:22 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18C3520814
	for <cocci@archiver.kernel.org>; Fri, 29 May 2020 12:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qcyoD/rM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18C3520814
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04TCAJIe022904;
	Fri, 29 May 2020 14:10:19 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 6D8867783;
	Fri, 29 May 2020 14:10:19 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 15E155D47
 for <cocci@systeme.lip6.fr>; Fri, 29 May 2020 14:10:18 +0200 (CEST)
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:442])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04TCAGov020624
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 29 May 2020 14:10:17 +0200 (CEST)
Received: by mail-pf1-x442.google.com with SMTP id y18so1282506pfl.9
 for <cocci@systeme.lip6.fr>; Fri, 29 May 2020 05:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Q36LaeZDTpziWGoQvRQkTXbRQt72vU9QHB86ae1n9ew=;
 b=qcyoD/rM5mseRAjXyKIGrqO/pJq3I0x1O/hbEt+d97hnZ13JvRVP55afd30b9raQ0F
 S3oxzOhM0lYrZp+4E5UHiMpaTGPIXfGsOgd9IbiC9g7H2N7gcI+ym9FjokbMGarEvQMQ
 jb6R3K3wtR2ulrI4pToDXPf9UJwG481zODObsjkJ3N+ovm9Njlut1NUvUQm+uNuojZfX
 F9lXmONIdX6L0FJnOO54Byp1TXevwbm8bQ/7QHfUxHIYj1SjVa11nCWOC3llVnYH8CZT
 VshbSfu5S1eo+3U9QMDlgLtEH6lQpBI/aMAvFe+D1SVT1A5WPZPrtfG/bvHYuZz7wNVd
 Vryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Q36LaeZDTpziWGoQvRQkTXbRQt72vU9QHB86ae1n9ew=;
 b=aPlF1mjQTut92AjPspueY+CzAHnBKg72MB5AbBSBrb8IYixx2L6CezDrhhKI0UBkQA
 ZLcdJ0A+6OMe4vNPy30vrcy1V9unQkh09m04t2AjkjiTQNE5ACeVgTUXQh3xiJfaQUgm
 YbmaQWJG/JTpyQrkvDh8WsgNnePnK+0K0y4CjTpFdmmRiYqBumqGhFSSHnJ4UjwY0F2Q
 PfXi/F3PhBoNSQKVQ5ne+GBZo2DNvoxelIXsIPiATsJibafu0nSL/jp8kUlh3gNm1G0o
 3lw0ow9ABYeMwV7ogZWzYPJ7Oisuxjc2HpXKT+keVy02FynIHLal7Db4h4HdMLbiZxru
 stig==
X-Gm-Message-State: AOAM531sQjqjcfbglkZgB+sjPQHegcjhWQAIKjBA2s0G2Q5q96SrIXXr
 V/RyVWu0kR92oRrw1p8SjaexYVhX
X-Google-Smtp-Source: ABdhPJyeld+rPpgA36eiqTuyl97ExmRBx4srWD7ZRCwiEMW9bmKEFM3yCKwbT749P5ZCByjxIt5oAw==
X-Received: by 2002:a05:6a00:46:: with SMTP id
 i6mr8682622pfk.146.1590754215382; 
 Fri, 29 May 2020 05:10:15 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:694:e576:19d1:a79b:707d:59f2])
 by smtp.gmail.com with ESMTPSA id dw13sm7975161pjb.40.2020.05.29.05.10.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2020 05:10:14 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri, 29 May 2020 17:36:57 +0530
Message-Id: <20200529120703.31145-28-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200529120703.31145-1-jaskaransingh7654321@gmail.com>
References: <20200529120703.31145-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 29 May 2020 14:10:19 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 29 May 2020 14:10:17 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v3 27/32] engine: cocci_vs_c: Match Cast attributes
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

Cast attributes are added to the C and SmPL ASTs. Match these attributes
in cocci_vs_c.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 engine/cocci_vs_c.ml | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/engine/cocci_vs_c.ml b/engine/cocci_vs_c.ml
index 66cb104a..54ab21ae 100644
--- a/engine/cocci_vs_c.ml
+++ b/engine/cocci_vs_c.ml
@@ -1121,7 +1121,7 @@ let rec (expression: (A.expression, Ast_c.expression) matcher) =
        * differentiate between different cases *)
       let rec matches_id = function
 	  B.Ident(name) -> true
-	| B.Cast(ty,e) -> matches_id (B.unwrap_expr e)
+	| B.Cast(ty,a,e) -> matches_id (B.unwrap_expr e)
 	| _ -> false in
       let form_ok =
 	match (form,expr) with
@@ -1137,7 +1137,7 @@ let rec (expression: (A.expression, Ast_c.expression) matcher) =
 		    true
                   end
                   else false
-	      | B.Cast(ty,e) -> matches (B.unwrap_expr e)
+	      | B.Cast(ty,a,e) -> matches (B.unwrap_expr e)
 	      |	B.Unary(e,B.UnMinus) -> matches (B.unwrap_expr e)
 	      | B.SizeOfExpr(exp) -> true
 	      | B.SizeOfType(ty) -> true
@@ -1525,16 +1525,26 @@ let rec (expression: (A.expression, Ast_c.expression) matcher) =
    *    by trying | ea, B.Case (typb, eb) -> match_e_e ea eb ?
    *)
 
-  | A.Cast (ia1, typa, ia2, ea), ((B.Cast (typb, eb), typ),ii) ->
+  | A.Cast (ia1, typa, attrsa, ia2, ea),
+    ((B.Cast (typb, attrsb, eb), typ),ii) ->
+
+      let attr_allminus =
+        let mcode_is_not_context = function
+          | (_,_,A.CONTEXT(_,_),_) -> false
+          | _ -> true in
+        check_allminus.Visitor_ast.combiner_fullType typa &&
+        List.for_all mcode_is_not_context attrsa in
+
       let (ib1, ib2) = tuple_of_list2 ii in
       fullType typa typb >>= (fun typa typb ->
+      attribute_list attr_allminus attrsa attrsb >>= (fun attrsa attrsb ->
       expression ea eb >>= (fun ea eb ->
       tokenf ia1 ib1 >>= (fun ia1 ib1 ->
       tokenf ia2 ib2 >>= (fun ia2 ib2 ->
         return (
-          ((A.Cast (ia1, typa, ia2, ea))) +> wa,
-          ((B.Cast (typb, eb),typ),[ib1;ib2])
-        )))))
+          ((A.Cast (ia1, typa, attrsa, ia2, ea))) +> wa,
+          ((B.Cast (typb, attrsb, eb),typ),[ib1;ib2])
+        ))))))
 
   | A.SizeOfExpr (ia1, ea), ((B.SizeOfExpr (eb), typ),ii) ->
       let ib1 = tuple_of_list1 ii in
@@ -1641,7 +1651,7 @@ let rec (expression: (A.expression, Ast_c.expression) matcher) =
 
 
   | _,
-     (((B.Cast (_, _)|B.ParenExpr _|B.SizeOfType _|B.SizeOfExpr _|
+     (((B.Cast (_, _, _)|B.ParenExpr _|B.SizeOfType _|B.SizeOfExpr _|
      B.Constructor (_, _)|
      B.RecordPtAccess (_, _)|
      B.RecordAccess (_, _)|B.ArrayAccess (_, _)|
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
