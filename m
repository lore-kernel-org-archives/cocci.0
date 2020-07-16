Return-Path: <SRS0=QQ00=A3=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,LONGWORDS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1498C433E6
	for <cocci@archiver.kernel.org>; Thu, 16 Jul 2020 13:02:39 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87B942074B
	for <cocci@archiver.kernel.org>; Thu, 16 Jul 2020 13:02:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87B942074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 06GD2ETg001020;
	Thu, 16 Jul 2020 15:02:15 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 372C17779;
	Thu, 16 Jul 2020 15:02:15 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 435B83F6C
 for <cocci@systeme.lip6.fr>; Thu, 16 Jul 2020 15:02:12 +0200 (CEST)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 06GD2Bmm015540
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Thu, 16 Jul 2020 15:02:11 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: jaskaran_singh) with ESMTPSA id 7BA872A0BFF
From: Jaskaran Singh <jaskaran.singh@collabora.com>
To: cocci@systeme.lip6.fr
Date: Thu, 16 Jul 2020 18:30:13 +0530
Message-Id: <20200716130016.23729-23-jaskaran.singh@collabora.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200716130016.23729-1-jaskaran.singh@collabora.com>
References: <20200716130016.23729-1-jaskaran.singh@collabora.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 16 Jul 2020 15:02:15 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Thu, 16 Jul 2020 15:02:11 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Subject: [Cocci] [PATCH 22/24] parsing_cocci: context_neg: Reflect
	attributefn in AST0 visitor
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

The SmPL AST0 visitor has a function for attributes. Reflect these
changes in context_neg.ml. Also add a few general fixes w/r/t the usage
of the for_all2 function for comparing attributes.

Signed-off-by: Jaskaran Singh <jaskaran.singh@collabora.com>
---
 parsing_cocci/ast0_cocci.mli |  1 +
 parsing_cocci/context_neg.ml | 20 ++++++++++++++------
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/parsing_cocci/ast0_cocci.mli b/parsing_cocci/ast0_cocci.mli
index c4b9260b..6097039f 100644
--- a/parsing_cocci/ast0_cocci.mli
+++ b/parsing_cocci/ast0_cocci.mli
@@ -599,6 +599,7 @@ val stmt : statement -> anything
 val forinfo : forinfo -> anything
 val case_line : case_line -> anything
 val string_fragment : string_fragment -> anything
+val attr : attr -> anything
 val top : top_level -> anything
 
 (* --------------------------------------------------------------------- *)
diff --git a/parsing_cocci/context_neg.ml b/parsing_cocci/context_neg.ml
index a0d52e9a..ebb93806 100644
--- a/parsing_cocci/context_neg.ml
+++ b/parsing_cocci/context_neg.ml
@@ -186,7 +186,7 @@ let collect_plus_lines top =
       donothing donothing
       donothing donothing donothing donothing donothing donothing donothing
       donothing donothing donothing statement donothing donothing donothing
-      donothing in
+      donothing donothing in
   fn.VT0.combiner_rec_top_level top
 
 (* --------------------------------------------------------------------- *)
@@ -557,7 +557,7 @@ let classify is_minus all_marked table code =
       ident expression (do_nothing Ast0.assignOp) (do_nothing Ast0.binaryOp)
       typeC initialiser param declaration field enum_decl
       statement (do_nothing Ast0.forinfo) case_line string_fragment
-      (do_top Ast0.top) in
+      (do_nothing Ast0.attr) (do_top Ast0.top) in
   combiner.VT0.combiner_rec_top_level code
 
 (* --------------------------------------------------------------------- *)
@@ -644,6 +644,7 @@ let rec equal_expression e1 e2 =
       equal_mcode ar1 ar2
   | (Ast0.Cast(lp1,_,ar1,rp1,_),Ast0.Cast(lp2,_,ar2,rp2,_)) ->
       equal_mcode lp1 lp2 &&
+      (List.length ar1) = (List.length ar2) &&
       List.for_all2 equal_attribute ar1 ar2 &&
       equal_mcode rp1 rp2
   | (Ast0.SizeOfExpr(szf1,_),Ast0.SizeOfExpr(szf2,_)) ->
@@ -752,10 +753,14 @@ let equal_declaration d1 d2 =
       equal_mcode name1 name2
   | (Ast0.Init(stg1,_,_,attr1,eq1,_,sem1),
      Ast0.Init(stg2,_,_,attr2,eq2,_,sem2)) ->
-      equal_option stg1 stg2 && List.for_all2 equal_attribute attr1 attr2 &&
+      equal_option stg1 stg2 &&
+      (List.length attr1) = (List.length attr2) &&
+      List.for_all2 equal_attribute attr1 attr2 &&
       equal_mcode eq1 eq2 && equal_mcode sem1 sem2
   | (Ast0.UnInit(stg1,_,_,attr1,sem1),Ast0.UnInit(stg2,_,_,attr2,sem2)) ->
-      equal_option stg1 stg2 && List.for_all2 equal_attribute attr1 attr2 &&
+      equal_option stg1 stg2 &&
+      (List.length attr1) = (List.length attr2) &&
+      List.for_all2 equal_attribute attr1 attr2 &&
       equal_mcode sem1 sem2
   | (Ast0.FunProto(fninfo1,name1,lp1,p1,va1,rp1,sem1),
      Ast0.FunProto(fninfo2,name2,lp2,p2,va2,rp2,sem2)) ->
@@ -770,7 +775,9 @@ let equal_declaration d1 d2 =
        equal_mcode rp1 rp2 && equal_mcode sem1 sem2
   | (Ast0.MacroDecl(stg1,nm1,lp1,_,rp1,attr1,sem1),
      Ast0.MacroDecl(stg2,nm2,lp2,_,rp2,attr2,sem2)) ->
-      equal_option stg1 stg2 && List.for_all2 equal_attribute attr1 attr2 &&
+      equal_option stg1 stg2 &&
+      (List.length attr1) = (List.length attr2) &&
+      List.for_all2 equal_attribute attr1 attr2 &&
       equal_mcode lp1 lp2 && equal_mcode rp1 rp2 && equal_mcode sem1 sem2
   | (Ast0.MacroDeclInit(stg1,nm1,lp1,_,rp1,eq1,_,sem1),
      Ast0.MacroDeclInit(stg2,nm2,lp2,_,rp2,eq2,_,sem2)) ->
@@ -778,6 +785,7 @@ let equal_declaration d1 d2 =
        equal_mcode lp1 lp2 && equal_mcode rp1 rp2 && equal_mcode eq1 eq2
 	 && equal_mcode sem1 sem2
   | (Ast0.TyDecl(_,attr1,sem1),Ast0.TyDecl(_,attr2,sem2)) ->
+       (List.length attr1) = (List.length attr2) &&
        List.for_all2 equal_attribute attr1 attr2 && equal_mcode sem1 sem2
   | (Ast0.OptDecl(_),Ast0.OptDecl(_)) -> true
   | (Ast0.DisjDecl(starter1,_,mids1,ender1),
@@ -1055,7 +1063,7 @@ let contextify_all =
     donothing donothing donothing donothing donothing donothing donothing
     donothing donothing donothing donothing donothing donothing donothing
     donothing donothing donothing donothing donothing donothing donothing
-    donothing donothing donothing
+    donothing donothing donothing donothing
 
 let contextify_whencode =
   let bind x y = () in
-- 
2.21.3

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
