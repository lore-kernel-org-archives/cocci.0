Return-Path: <SRS0=Xu+Y=BF=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8A2C433F1
	for <cocci@archiver.kernel.org>; Sun, 26 Jul 2020 12:52:45 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D626A20719
	for <cocci@archiver.kernel.org>; Sun, 26 Jul 2020 12:52:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D626A20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 06QCqVkd015627;
	Sun, 26 Jul 2020 14:52:32 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id DA618781E;
	Sun, 26 Jul 2020 14:52:31 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id A754777B7
 for <cocci@systeme.lip6.fr>; Sun, 26 Jul 2020 14:52:27 +0200 (CEST)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 06QCqQ4J014287
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 26 Jul 2020 14:52:26 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: jaskaran_singh) with ESMTPSA id B3DAA27744B
From: Jaskaran Singh <jaskaran.singh@collabora.com>
To: cocci@systeme.lip6.fr
Date: Sun, 26 Jul 2020 18:21:10 +0530
Message-Id: <20200726125141.17787-13-jaskaran.singh@collabora.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200726125141.17787-1-jaskaran.singh@collabora.com>
References: <20200726125141.17787-1-jaskaran.singh@collabora.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 26 Jul 2020 14:52:32 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 26 Jul 2020 14:52:26 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Subject: [Cocci] [PATCH 12/43] engine: cocci_vs_c: Reflect MetaAttributeVal
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

MetaAttributeVal is added to the C AST. Reflect these changes in
cocci_vs_c.ml.

Signed-off-by: Jaskaran Singh <jaskaran.singh@collabora.com>
---
 engine/cocci_vs_c.ml        | 8 ++++++--
 parsing_c/lib_parsing_c.ml  | 3 +++
 parsing_c/lib_parsing_c.mli | 3 +++
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/engine/cocci_vs_c.ml b/engine/cocci_vs_c.ml
index cba6c8d01..ed91a4785 100644
--- a/engine/cocci_vs_c.ml
+++ b/engine/cocci_vs_c.ml
@@ -229,6 +229,8 @@ let equal_metavarval valu valu' =
 
   | Ast_c.MetaFmtVal a, Ast_c.MetaFmtVal b ->
       Lib_parsing_c.al_string_format a = Lib_parsing_c.al_string_format b
+  | Ast_c.MetaAttributeVal a, Ast_c.MetaAttributeVal b ->
+      Lib_parsing_c.al_attribute a = Lib_parsing_c.al_attribute b
   | Ast_c.MetaFragListVal a, Ast_c.MetaFragListVal b ->
       Lib_parsing_c.al_string_fragments a =
       Lib_parsing_c.al_string_fragments b
@@ -287,7 +289,7 @@ let equal_metavarval valu valu' =
       |B.MetaExprListVal _
       |B.MetaExprVal _|B.MetaLocalFuncVal _|B.MetaFuncVal _|B.MetaIdVal _
       |B.MetaAssignOpVal _ | B.MetaBinaryOpVal _
-      |B.MetaFmtVal _|B.MetaFragListVal _
+      |B.MetaFmtVal _|B.MetaFragListVal _|B.MetaAttributeVal _
     ), _
       -> raise (Impossible 16)
 
@@ -322,6 +324,8 @@ let equal_inh_metavarval valu valu'=
   | Ast_c.MetaFmtVal a, Ast_c.MetaFmtVal b ->
       Lib_parsing_c.al_inh_string_format a =
       Lib_parsing_c.al_inh_string_format b
+  | Ast_c.MetaAttributeVal a, Ast_c.MetaAttributeVal b ->
+      Lib_parsing_c.al_inh_attribute a = Lib_parsing_c.al_inh_attribute b
   | Ast_c.MetaFragListVal a, Ast_c.MetaFragListVal b ->
       Lib_parsing_c.al_inh_string_fragments a =
       Lib_parsing_c.al_inh_string_fragments b
@@ -388,7 +392,7 @@ let equal_inh_metavarval valu valu'=
       |B.MetaExprListVal _
       |B.MetaExprVal _|B.MetaLocalFuncVal _|B.MetaFuncVal _|B.MetaIdVal _
       |B.MetaAssignOpVal _ | B.MetaBinaryOpVal _
-      |B.MetaFmtVal _|B.MetaFragListVal _
+      |B.MetaFmtVal _|B.MetaFragListVal _|B.MetaAttributeVal _
     ), _
       -> raise (Impossible 17)
 
diff --git a/parsing_c/lib_parsing_c.ml b/parsing_c/lib_parsing_c.ml
index 99e43be3b..687833604 100644
--- a/parsing_c/lib_parsing_c.ml
+++ b/parsing_c/lib_parsing_c.ml
@@ -86,6 +86,7 @@ let al_name      x = Visitor_c.vk_name_s      (strip_info_visitor()) x
 let al_string_format x = Visitor_c.vk_string_format_s (strip_info_visitor()) x
 let al_string_fragments x =
   Visitor_c.vk_string_fragments_s (strip_info_visitor()) x
+let al_attribute x = Visitor_c.vk_attribute_s (strip_info_visitor()) x
 
 let al_node      x = Visitor_c.vk_node_s      (strip_info_visitor()) x
 
@@ -147,6 +148,7 @@ let al_inh_string_format x =
   Visitor_c.vk_string_format_s (strip_inh_info_visitor()) x
 let al_inh_string_fragments x =
   Visitor_c.vk_string_fragments_s (strip_inh_info_visitor()) x
+let al_inh_attribute x = Visitor_c.vk_attribute_s (strip_inh_info_visitor()) x
 
 
 
@@ -184,6 +186,7 @@ let semi_al_string_format =
   Visitor_c.vk_string_format_s semi_strip_info_visitor
 let semi_al_string_fragments =
   Visitor_c.vk_string_fragments_s semi_strip_info_visitor
+let semi_al_attribute = Visitor_c.vk_attribute_s semi_strip_info_visitor
 
 let semi_al_program =
   List.map (Visitor_c.vk_toplevel_s semi_strip_info_visitor)
diff --git a/parsing_c/lib_parsing_c.mli b/parsing_c/lib_parsing_c.mli
index d9578f3ca..0e53f9060 100644
--- a/parsing_c/lib_parsing_c.mli
+++ b/parsing_c/lib_parsing_c.mli
@@ -22,6 +22,7 @@ val al_arguments :
 val al_fields : Ast_c.field list -> Ast_c.field list
 val al_name : Ast_c.name -> Ast_c.name
 val al_string_format : Ast_c.string_format -> Ast_c.string_format
+val al_attribute : Ast_c.attribute -> Ast_c.attribute
 val al_string_fragments :
   Ast_c.string_fragment list -> Ast_c.string_fragment list
 val al_node : Control_flow_c.node -> Control_flow_c.node
@@ -44,6 +45,7 @@ val al_inh_arguments :
 val al_inh_string_format : Ast_c.string_format -> Ast_c.string_format
 val al_inh_string_fragments :
   Ast_c.string_fragment list -> Ast_c.string_fragment list
+val al_inh_attribute : Ast_c.attribute -> Ast_c.attribute
 val semi_strip_info_visitor : Visitor_c.visitor_c_s
 val semi_al_expr : Ast_c.expression -> Ast_c.expression
 val semi_al_declaration : Ast_c.declaration -> Ast_c.declaration
@@ -67,6 +69,7 @@ val semi_al_arguments :
 val semi_al_string_format : Ast_c.string_format -> Ast_c.string_format
 val semi_al_string_fragments :
   Ast_c.string_fragment list -> Ast_c.string_fragment list
+val semi_al_attribute : Ast_c.attribute -> Ast_c.attribute
 val semi_al_program : Ast_c.toplevel list -> Ast_c.toplevel list
 val real_strip_info_visitor : 'a -> Visitor_c.visitor_c_s
 val real_al_expr : Ast_c.expression -> Ast_c.expression
-- 
2.21.3

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
