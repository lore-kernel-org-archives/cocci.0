Return-Path: <SRS0=43Z/=6Z=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92FD5C54E4B
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:09:46 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1225320720
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QyN2+VqA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1225320720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04BA9SI8007291;
	Mon, 11 May 2020 12:09:28 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 194D83E6B;
	Mon, 11 May 2020 12:09:28 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 178B63DC8
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:09:26 +0200 (CEST)
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:442])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04BA9OG9029195
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:09:25 +0200 (CEST)
Received: by mail-pf1-x442.google.com with SMTP id 145so4516700pfw.13
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 03:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XuPFrwuWq6NuiENxiCfyOsgjvaeRNzYflde0XQeU41k=;
 b=QyN2+VqAWmY39JYUX0uPwnhfq1lXa5sQISqDl6C0kv7zwJatCwnR06z1AMeNpAoC5K
 HXogBGmzxgDXtUzizQK8a1gb5wj7qA/oSPRBBGFb1Fw+z5ygBmKPaVJwfrmMv6XXCmTP
 fUjwGiZbbGmqgXDuoSgNRZfnNhM7XOpD93PA5jE4daD9PDcVe/Vei4c0qnhZjCaNJDZq
 O+kGPvwSlYTjC54rrcIJSRkjONFYUwycNH5lpcm+KJGbgD1X55PC7fZYRsNcTyMUFvZQ
 O33Z9bYpgGs3TY3o9B+zo0NgEAealA05gUQ0XdXVuvXo8l9Y1ZK4JO7Tw3c21Ux9AMSx
 sm8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XuPFrwuWq6NuiENxiCfyOsgjvaeRNzYflde0XQeU41k=;
 b=R0Q5nZoGE9RzgN3Ug2okEHRbCcef6rK8rj31nI5edDXdbtUIe4NV/gqQCn2kUbT7sM
 1NBE0d+jbP7F/tFsdemQadL5eZdZDwSmR5A5fs/I1V8Jv5ZgMLqPSuxSNDz195eIXIKX
 x1XDAq63bjX04e7vh2dL7eniE/5pfQiY7X9/U6V++66VOJw6ewGCCWE1kfjz9NB0s9Zj
 Tk5lKyLrD3ORKCUml1L0Jzd0/9uLLAjtN6qSAO4FIJQ810U+xLViHPjEzOUPckwXM1MZ
 DuMh7pJax+2LsOOyGgM4Nh5tlZBNKZvdgyKHnY8eCNT8SeErV5c9l+ahPLm9TrMsaLtx
 B0yQ==
X-Gm-Message-State: AGi0Pua4QMpE3VhUKXiHkvS3NN38nJfZ4KvAJMpjCXPFG+ArQNomUlvO
 g78sTi4oAkgC8n6Cw315YSX3lcSZhwc=
X-Google-Smtp-Source: APiQypJEJcH5C+xRyh0XzWcTfMI/YAkOn6uXNXTLi6CnDmyv4AeQHQW9gU1GaPv0MrCh6TTVfs3jnQ==
X-Received: by 2002:a65:4bc6:: with SMTP id p6mr13722210pgr.20.1589191763466; 
 Mon, 11 May 2020 03:09:23 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:382:66db:4729:1ab8:2139:8945])
 by smtp.gmail.com with ESMTPSA id
 o99sm9772994pjo.8.2020.05.11.03.09.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 03:09:23 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 11 May 2020 15:37:10 +0530
Message-Id: <20200511100715.19819-28-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200511100715.19819-1-jaskaransingh7654321@gmail.com>
References: <20200511100715.19819-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 11 May 2020 12:09:28 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 11 May 2020 12:09:25 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v2 27/32] engine: cocci_vs_c: Match Cast attributes
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
index 317fa71e..3f46a60c 100644
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
