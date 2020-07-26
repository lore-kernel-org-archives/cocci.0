Return-Path: <SRS0=Xu+Y=BF=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F03DAC43466
	for <cocci@archiver.kernel.org>; Sun, 26 Jul 2020 12:53:17 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96C0020714
	for <cocci@archiver.kernel.org>; Sun, 26 Jul 2020 12:53:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96C0020714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 06QCr0Vb027373;
	Sun, 26 Jul 2020 14:53:00 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E4F477815;
	Sun, 26 Jul 2020 14:52:59 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 9CA25777B
 for <cocci@systeme.lip6.fr>; Sun, 26 Jul 2020 14:52:57 +0200 (CEST)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 06QCquO0023053
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 26 Jul 2020 14:52:57 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: jaskaran_singh) with ESMTPSA id B874427088D
From: Jaskaran Singh <jaskaran.singh@collabora.com>
To: cocci@systeme.lip6.fr
Date: Sun, 26 Jul 2020 18:21:30 +0530
Message-Id: <20200726125141.17787-33-jaskaran.singh@collabora.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200726125141.17787-1-jaskaran.singh@collabora.com>
References: <20200726125141.17787-1-jaskaran.singh@collabora.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 26 Jul 2020 14:53:00 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 26 Jul 2020 14:52:57 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Subject: [Cocci] [PATCH 32/43] parsing_cocci: free_vars: Reflect
	MetaAttribute
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

MetaAttribute is added to the SmPL AST. Reflect these changes in
free_vars.ml.

Signed-off-by: Jaskaran Singh <jaskaran.singh@collabora.com>
---
 parsing_cocci/free_vars.ml | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/parsing_cocci/free_vars.ml b/parsing_cocci/free_vars.ml
index 6958f48ee..404e2d549 100644
--- a/parsing_cocci/free_vars.ml
+++ b/parsing_cocci/free_vars.ml
@@ -137,6 +137,13 @@ let collect_refs include_constraints =
 	  bind (constraints cstr) [metaid name]
       | _ -> option_default) in
 
+  let astfvattribute recursor k a =
+    bind (k a)
+      (match Ast.unwrap a with
+	Ast.MetaAttribute(name,cstr,_,_) ->
+	  bind (constraints cstr) [metaid name]
+      | _ -> option_default) in
+
   let rec collect_assign_names aop =
     match Ast.unwrap aop with
       Ast.MetaAssign(name,cstr,_,_) ->
@@ -253,7 +260,8 @@ let collect_refs include_constraints =
     astfvident astfvexpr astfvfrag astfvfmt astfvassignop astfvbinaryop
     astfvfullType astfvtypeC astfvinit astfvparam astfvdefine_param
     astfvdecls donothing astfvfields astafvfields donothing
-    astfvrule_elem astfvstatement donothing donothing donothing donothing_a
+    astfvrule_elem astfvstatement donothing astfvattribute
+    donothing donothing_a
 
 let collect_all_refs = collect_refs true
 let collect_non_constraint_refs = collect_refs false
@@ -369,6 +377,12 @@ let collect_saved =
 	Ast.MetaFormat(name,_,Ast.Saved,_) -> [metaid name]
       | _ -> option_default) in
 
+  let astfvattribute recursor k a =
+    bind (k a)
+      (match Ast.unwrap a with
+	Ast.MetaAttribute(name,_,Ast.Saved,_) -> [metaid name]
+      | _ -> option_default) in
+
   let astfvassign recursor k aop =
     bind (k aop)
       (match Ast.unwrap aop with
@@ -479,7 +493,7 @@ let collect_saved =
     astfvident astfvexpr astfvfrag astfvfmt astfvassign astfvbinary donothing
     astfvtypeC astfvinit astfvparam astfvdefine_param astfvdecls donothing
     astfvfields donothing donothing astfvrule_elem donothing donothing
-    donothing donothing donothing
+    astfvattribute donothing donothing
 
 (* ---------------------------------------------------------------- *)
 
@@ -779,6 +793,14 @@ let classify_variables metavar_decls minirules used_after =
 	Ast.rewrap ft (Ast.MetaFormat(name,constraints,unitary,inherited))
     | _ -> ft in
 
+  let attribute r k a =
+    let a = k a in
+    match Ast.unwrap a with
+      Ast.MetaAttribute(name,constraints,_,_) ->
+	let (unitary,inherited) = classify name in
+	Ast.rewrap a (Ast.MetaAttribute(name,constraints,unitary,inherited))
+    | _ -> a in
+
   let assignop r k ft =
     let ft = k ft in
     match Ast.unwrap ft with
@@ -905,7 +927,7 @@ let classify_variables metavar_decls minirules used_after =
       ident expression string_fragment string_format assignop binaryop
       donothing typeC
       init param define_param decl donothing field donothing donothing
-      rule_elem donothing donothing donothing donothing donothing in
+      rule_elem donothing donothing attribute donothing donothing in
 
   List.map fn.V.rebuilder_top_level minirules
 
-- 
2.21.3

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
