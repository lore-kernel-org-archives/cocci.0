Return-Path: <SRS0=Xu+Y=BF=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C0BC433F7
	for <cocci@archiver.kernel.org>; Sun, 26 Jul 2020 12:52:45 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BB8420719
	for <cocci@archiver.kernel.org>; Sun, 26 Jul 2020 12:52:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BB8420719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 06QCqVb3019442;
	Sun, 26 Jul 2020 14:52:32 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id C8971777B;
	Sun, 26 Jul 2020 14:52:32 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id AF41A777B
 for <cocci@systeme.lip6.fr>; Sun, 26 Jul 2020 14:52:30 +0200 (CEST)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 06QCqTHZ000995
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 26 Jul 2020 14:52:30 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: jaskaran_singh) with ESMTPSA id D31C327088D
From: Jaskaran Singh <jaskaran.singh@collabora.com>
To: cocci@systeme.lip6.fr
Date: Sun, 26 Jul 2020 18:21:12 +0530
Message-Id: <20200726125141.17787-15-jaskaran.singh@collabora.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200726125141.17787-1-jaskaran.singh@collabora.com>
References: <20200726125141.17787-1-jaskaran.singh@collabora.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 26 Jul 2020 14:52:32 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 26 Jul 2020 14:52:30 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] [PATCH 14/43] engine: pretty_print_engine: Add
	MetaAttributeVal
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
pretty_print_engine.ml.

Signed-off-by: Jaskaran Singh <jaskaran.singh@collabora.com>
---
 engine/pretty_print_engine.ml |  1 +
 parsing_c/pretty_print_c.ml   | 12 ++++++++++++
 parsing_c/pretty_print_c.mli  |  5 +++++
 3 files changed, 18 insertions(+)

diff --git a/engine/pretty_print_engine.ml b/engine/pretty_print_engine.ml
index 383016ce3..b825fac39 100644
--- a/engine/pretty_print_engine.ml
+++ b/engine/pretty_print_engine.ml
@@ -42,6 +42,7 @@ let rec pp_binding_kind = function
   | Ast_c.MetaStmtListVal      (statxs,_) ->
       Pretty_print_c.pp_statement_seq_list_simple statxs
   | Ast_c.MetaFmtVal fmt -> Pretty_print_c.pp_string_format_simple fmt
+  | Ast_c.MetaAttributeVal attr -> Pretty_print_c.pp_attribute_simple attr
   | Ast_c.MetaFragListVal frags ->
       frags +> (List.iter Pretty_print_c.pp_string_fragment_simple)
   | Ast_c.MetaParamVal     params -> pp "<<param>>"
diff --git a/parsing_c/pretty_print_c.ml b/parsing_c/pretty_print_c.ml
index 74b57344e..6ac3e4767 100644
--- a/parsing_c/pretty_print_c.ml
+++ b/parsing_c/pretty_print_c.ml
@@ -55,6 +55,7 @@ type pretty_printers = {
   fragment        : Ast_c.string_fragment printer;
   fragment_list   : (Ast_c.string_fragment list) printer;
   format          : Ast_c.string_format printer;
+  attribute       : Ast_c.attribute printer;
   flow            : Control_flow_c.node printer;
   name            : Ast_c.name printer
 }
@@ -1145,6 +1146,12 @@ and pp_init (init, iinit) =
       ii +> List.iter pr_elem;
     );
 
+  and pp_attribute (e,ii) =
+    match (e,ii) with
+      Attribute(a), ii  ->
+        let (i) = Common.tuple_of_list1 ii in
+        pr_elem i
+
 (* ---------------------- *)
   and pp_def_start defbis iifunc1 iifunc2 ifakestart isto =
     let {f_name = name;
@@ -1524,6 +1531,7 @@ and pp_init (init, iinit) =
     toplevel   = pp_toplevel;
     fragment   = pp_string_fragment;
     fragment_list = pp_string_fragment_list;
+    attribute  = pp_attribute;
     format     = pp_string_format;
     flow       = pp_flow;
     name       = pp_name;
@@ -1583,6 +1591,7 @@ let pp_init_simple       = ppc.init
 let pp_toplevel_simple   = ppc.toplevel
 let pp_string_fragment_simple = ppc.fragment
 let pp_string_format_simple = ppc.format
+let pp_attribute_simple  = ppc.attribute
 let pp_flow_simple       = ppc.flow
 let pp_name              = ppc.name
 
@@ -1649,6 +1658,9 @@ let pp_string_fragment_list_gen ~pr_elem ~pr_space =
 let pp_string_format_gen ~pr_elem ~pr_space =
   (pp_elem_sp pr_elem pr_space).format
 
+let pp_attribute_gen ~pr_elem ~pr_space =
+  (pp_elem_sp pr_elem pr_space).attribute
+
 let pp_program_gen ~pr_elem ~pr_space =
   (pp_elem_sp pr_elem pr_space).toplevel
 
diff --git a/parsing_c/pretty_print_c.mli b/parsing_c/pretty_print_c.mli
index 5cfcc779d..daaad2061 100644
--- a/parsing_c/pretty_print_c.mli
+++ b/parsing_c/pretty_print_c.mli
@@ -26,6 +26,7 @@ type pretty_printers = {
   fragment        : Ast_c.string_fragment printer;
   fragment_list   : (Ast_c.string_fragment list) printer;
   format          : Ast_c.string_format printer;
+  attribute       : Ast_c.attribute printer;
   flow            : Control_flow_c.node printer;
   name            : Ast_c.name printer
 }
@@ -80,6 +81,9 @@ val pp_string_fragment_list_gen:
 val pp_string_format_gen:
     pr_elem:Ast_c.info printer -> pr_space:unit printer ->
       Ast_c.string_format printer
+val pp_attribute_gen:
+    pr_elem:Ast_c.info printer -> pr_space:unit printer ->
+      Ast_c.attribute printer
 val pp_program_gen : pr_elem:Ast_c.info printer -> pr_space:unit printer ->
   Ast_c.toplevel printer
 
@@ -98,6 +102,7 @@ val pp_statement_seq_list_simple: Ast_c.statement_sequencable list printer
 val pp_toplevel_simple:   Ast_c.toplevel printer
 val pp_string_fragment_simple:   Ast_c.string_fragment printer
 val pp_string_format_simple:     Ast_c.string_format printer
+val pp_attribute_simple:     Ast_c.attribute printer
 
 val debug_info_of_node:
   Control_flow_c.G.key -> Control_flow_c.cflow -> string
-- 
2.21.3

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
