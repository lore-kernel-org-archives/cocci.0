Return-Path: <SRS0=QQ00=A3=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,LONGWORDS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E83C433EC
	for <cocci@archiver.kernel.org>; Thu, 16 Jul 2020 13:06:03 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71B2F2076D
	for <cocci@archiver.kernel.org>; Thu, 16 Jul 2020 13:06:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71B2F2076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 06GD5mCv005060;
	Thu, 16 Jul 2020 15:05:48 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 7CE437859;
	Thu, 16 Jul 2020 15:05:45 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7710B7858
 for <cocci@systeme.lip6.fr>; Thu, 16 Jul 2020 15:05:43 +0200 (CEST)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 06GD5g3d024896
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Thu, 16 Jul 2020 15:05:43 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: jaskaran_singh) with ESMTPSA id D69AA2A570F
From: Jaskaran Singh <jaskaran.singh@collabora.com>
To: cocci@systeme.lip6.fr
Date: Thu, 16 Jul 2020 18:35:09 +0530
Message-Id: <20200716130521.7717-6-jaskaran.singh@collabora.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200716130521.7717-1-jaskaran.singh@collabora.com>
References: <20200716130521.7717-1-jaskaran.singh@collabora.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 16 Jul 2020 15:05:48 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Thu, 16 Jul 2020 15:05:43 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Subject: [Cocci] [PATCH 05/17] parsing_cocci: free_vars: Reflect attributefn
	in AST visitor
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

The SmPL AST visitor has a function for attributes. Reflect these
changes in free_vars.ml.

Signed-off-by: Jaskaran Singh <jaskaran.singh@collabora.com>
---
 parsing_cocci/free_vars.ml | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/parsing_cocci/free_vars.ml b/parsing_cocci/free_vars.ml
index 6ad35dcc..6958f48e 100644
--- a/parsing_cocci/free_vars.ml
+++ b/parsing_cocci/free_vars.ml
@@ -253,7 +253,7 @@ let collect_refs include_constraints =
     astfvident astfvexpr astfvfrag astfvfmt astfvassignop astfvbinaryop
     astfvfullType astfvtypeC astfvinit astfvparam astfvdefine_param
     astfvdecls donothing astfvfields astafvfields donothing
-    astfvrule_elem astfvstatement donothing donothing donothing_a
+    astfvrule_elem astfvstatement donothing donothing donothing donothing_a
 
 let collect_all_refs = collect_refs true
 let collect_non_constraint_refs = collect_refs false
@@ -303,7 +303,7 @@ let collect_pos_positions =
     donothing donothing donothing donothing donothing donothing donothing
     donothing donothing donothing donothing donothing donothing
     donothing donothing donothing donothing
-    cprule_elem cpstmt donothing donothing donothing
+    cprule_elem cpstmt donothing donothing donothing donothing
 
 (* ---------------------------------------------------------------- *)
 
@@ -479,7 +479,7 @@ let collect_saved =
     astfvident astfvexpr astfvfrag astfvfmt astfvassign astfvbinary donothing
     astfvtypeC astfvinit astfvparam astfvdefine_param astfvdecls donothing
     astfvfields donothing donothing astfvrule_elem donothing donothing
-    donothing donothing
+    donothing donothing donothing
 
 (* ---------------------------------------------------------------- *)
 
@@ -612,7 +612,7 @@ let collect_in_plus_term =
     donothing donothing donothing donothing donothing donothing donothing
     donothing donothing donothing donothing donothing donothing donothing
     donothing donothing donothing donothing donothing donothing astfvrule_elem
-    astfvstatement donothing donothing donothing
+    astfvstatement donothing donothing donothing donothing
 
 let collect_in_plus metavars minirules =
   nub
@@ -905,7 +905,7 @@ let classify_variables metavar_decls minirules used_after =
       ident expression string_fragment string_format assignop binaryop
       donothing typeC
       init param define_param decl donothing field donothing donothing
-      rule_elem donothing donothing donothing donothing in
+      rule_elem donothing donothing donothing donothing donothing in
 
   List.map fn.V.rebuilder_top_level minirules
 
@@ -1091,7 +1091,8 @@ let astfvs metavars bound =
     donothing donothing donothing donothing donothing donothing donothing
     donothing donothing donothing donothing donothing donothing donothing
     donothing donothing donothing
-    astfvrule_elem astfvstatement astfvcase_line astfvtoplevel donothing
+    astfvrule_elem astfvstatement astfvcase_line donothing astfvtoplevel
+    donothing
 
 (*
 let collect_astfvs rules =
@@ -1175,7 +1176,8 @@ let get_neg_pos_list (_,rule) used_after_list =
     donothing donothing donothing donothing donothing donothing donothing
     donothing donothing donothing donothing donothing donothing donothing
     donothing donothing donothing donothing donothing donothing donothing
-    donothing donothing donothing donothing donothing donothing donothing in
+    donothing donothing donothing donothing donothing donothing donothing
+    donothing in
   match rule with
     Ast.CocciRule(rule_name,_,minirules,_,_) ->
       List.map
-- 
2.21.3

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
