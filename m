Return-Path: <SRS0=bJsz=6M=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0B8C83000
	for <cocci@archiver.kernel.org>; Tue, 28 Apr 2020 17:06:00 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD9CB20730
	for <cocci@archiver.kernel.org>; Tue, 28 Apr 2020 17:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4aY627p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD9CB20730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03SH5n7Z024395;
	Tue, 28 Apr 2020 19:05:49 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 239427807;
	Tue, 28 Apr 2020 19:05:49 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 0F0A83DC8
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 19:05:48 +0200 (CEST)
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:642])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03SH5kFF021109
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 19:05:47 +0200 (CEST)
Received: by mail-pl1-x642.google.com with SMTP id t7so2709799plr.0
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 10:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4k4s3jEr8PRibdpYeNA1YSIZdm/UmvfWjDFT3dGHHBg=;
 b=g4aY627pJfP3I22sv7vXrXSCT4NshMtjg7kbhDUGPQFCA06rn+fIQGYW0PLKNL6qAn
 i2m2feeoONeECQbT3QtwWjSOz2PhOTUG8Pdvivkw55XcMldCi7Ynst+hAph4gS7xxr3b
 sJH6ojhyZiCHvo+1RRwWc9yBRadBTU80LNXHiOVTmrjatEkB5UjS55hNiTUV9syKxonF
 3IlFulNF1stGu6PwkDmteS5F+2Ejz55H6gYuyqJSfRQpN8OLkObeC0slOWBMOdNzp0CZ
 nPOGErOwbC23kw4T1FUyZx69RJbuxx+3h0TTLL3vm7dllDrcWTs/m8KQr0OkjeAiETI5
 vqqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4k4s3jEr8PRibdpYeNA1YSIZdm/UmvfWjDFT3dGHHBg=;
 b=Knmc7OgZtMCXCVBoHbJtmzrTpeP+U0RQwqJZhhivSyK5MBIB46pGXjM+UIMX7dPjHk
 kiNI6mS9cTQs4m7rLwOMVUtz5aAWPQjEct0HLgeKvCqxAsmLAiFArOqk4T9h3c7V2CjY
 3S9UqYa3Ghbou2+4r9w635WqN8P9/2raZAytLljunDchAPn8Ua4sV+JT9tfTnlCJyGYE
 Rk5KOn9JlHeZHEo5mvr+KEHq2iX6Ml3NkhAtizsHiNYE3IiwCdtGaOKDv8RhMIbZrQsX
 tajqZk4WCib6KhxJE6HgEPlQFPz/A2negjSFoo60ZryLH7fFO7nEsKl5sqDLbrK6OlIn
 5gKg==
X-Gm-Message-State: AGi0PuaYFxmIOjPwNtWOUHF9+D1NMIDkTekrYRphu4ObR8J4yfmcVWBM
 pTCXtusQvHGZHdEewhGWsPYomSSAcX8=
X-Google-Smtp-Source: APiQypJ/hsXfVM292zeaeVK+bET52q2eR2MR3Xy44NFrleDZ4cCY7Kpi4HtZSijpEvXArdrBUt7sFw==
X-Received: by 2002:a17:902:a701:: with SMTP id
 w1mr26845316plq.165.1588093545374; 
 Tue, 28 Apr 2020 10:05:45 -0700 (PDT)
Received: from localhost.localdomain ([1.38.220.163])
 by smtp.gmail.com with ESMTPSA id u15sm2505097pjm.47.2020.04.28.10.05.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2020 10:05:44 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Tue, 28 Apr 2020 22:32:23 +0530
Message-Id: <20200428170228.7002-28-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200428170228.7002-1-jaskaransingh7654321@gmail.com>
References: <20200428170228.7002-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 28 Apr 2020 19:05:49 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Tue, 28 Apr 2020 19:05:47 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 27/32] engine: cocci_vs_c: Match Cast attributes
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
index 317fa71e..0001ec2a 100644
--- a/engine/cocci_vs_c.ml
+++ b/engine/cocci_vs_c.ml
@@ -1121,7 +1121,7 @@ let rec (expression: (A.expression, Ast_c.expression) matcher) =
        * differentiate between different cases *)
       let rec matches_id = function
 	  B.Ident(name) -> true
-	| B.Cast(ty,e) -> matches_id (B.unwrap_expr e)
+	| B.Cast(ty,e,a) -> matches_id (B.unwrap_expr e)
 	| _ -> false in
       let form_ok =
 	match (form,expr) with
@@ -1137,7 +1137,7 @@ let rec (expression: (A.expression, Ast_c.expression) matcher) =
 		    true
                   end
                   else false
-	      | B.Cast(ty,e) -> matches (B.unwrap_expr e)
+	      | B.Cast(ty,e,a) -> matches (B.unwrap_expr e)
 	      |	B.Unary(e,B.UnMinus) -> matches (B.unwrap_expr e)
 	      | B.SizeOfExpr(exp) -> true
 	      | B.SizeOfType(ty) -> true
@@ -1525,16 +1525,26 @@ let rec (expression: (A.expression, Ast_c.expression) matcher) =
    *    by trying | ea, B.Case (typb, eb) -> match_e_e ea eb ?
    *)
 
-  | A.Cast (ia1, typa, ia2, ea), ((B.Cast (typb, eb), typ),ii) ->
+  | A.Cast (ia1, typa, attrsa, ia2, ea),
+    ((B.Cast (typb, eb, attrsb), typ),ii) ->
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
+          ((B.Cast (typb, eb, attrsb),typ),[ib1;ib2])
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
