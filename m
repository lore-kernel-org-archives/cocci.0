Return-Path: <SRS0=QQ00=A3=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40114C433F2
	for <cocci@archiver.kernel.org>; Thu, 16 Jul 2020 13:02:28 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D7E12074B
	for <cocci@archiver.kernel.org>; Thu, 16 Jul 2020 13:02:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D7E12074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 06GD1ox9012807;
	Thu, 16 Jul 2020 15:01:50 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 4C6E2781F;
	Thu, 16 Jul 2020 15:01:45 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 76D1B3F6C
 for <cocci@systeme.lip6.fr>; Thu, 16 Jul 2020 15:01:42 +0200 (CEST)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 06GD1fvC027607
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Thu, 16 Jul 2020 15:01:41 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: jaskaran_singh) with ESMTPSA id 36AA82A570E
From: Jaskaran Singh <jaskaran.singh@collabora.com>
To: cocci@systeme.lip6.fr
Date: Thu, 16 Jul 2020 18:29:52 +0530
Message-Id: <20200716130016.23729-2-jaskaran.singh@collabora.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200716130016.23729-1-jaskaran.singh@collabora.com>
References: <20200716130016.23729-1-jaskaran.singh@collabora.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 16 Jul 2020 15:01:50 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Thu, 16 Jul 2020 15:01:41 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Subject: [Cocci] [PATCH 01/24] parsing_cocci: visitor_ast0: Add attributefn
	to SmPL AST0 visitor
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

Add a public function for visiting attributes to the SmPL AST0 visitor.

Signed-off-by: Jaskaran Singh <jaskaran.singh@collabora.com>
---
 parsing_cocci/visitor_ast0.ml        | 21 +++++++++++++++++----
 parsing_cocci/visitor_ast0.mli       |  2 ++
 parsing_cocci/visitor_ast0_types.ml  |  6 ++++++
 parsing_cocci/visitor_ast0_types.mli |  6 ++++++
 4 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/parsing_cocci/visitor_ast0.ml b/parsing_cocci/visitor_ast0.ml
index a5902f8c..090fe625 100644
--- a/parsing_cocci/visitor_ast0.ml
+++ b/parsing_cocci/visitor_ast0.ml
@@ -25,7 +25,7 @@ let visitor mode bind option_default
     dotsenumdeclfn dotscasefn dotsdefparfn
     identfn exprfn assignOpfn binaryOpfn tyfn initfn paramfn declfn fieldfn
     enumdeclfn
-    stmtfn forinfofn casefn string_fragmentfn topfn =
+    stmtfn forinfofn casefn string_fragmentfn attributefn topfn =
   let multibind l =
     let rec loop = function
 	[] -> option_default
@@ -1155,7 +1155,7 @@ let visitor mode bind option_default
           Ast0.Attribute(attr) ->
             let (attr_n,attr) = string_mcode attr in
             (attr_n,Ast0.Attribute(attr))) in
-    k a
+    attributefn all_functions k a
 
   (* we only include the when string mcode w because the parameterised
      string_mcodefn function might have side-effects *)
@@ -1370,6 +1370,7 @@ let visitor mode bind option_default
       VT0.case_line = case_line;
       VT0.define_param = define_param;
       VT0.string_fragment = string_fragment;
+      VT0.attribute = attribute;
       VT0.top_level = top_level;
       VT0.expression_dots = expression_dots;
       VT0.statement_dots = statement_dots;
@@ -1419,6 +1420,7 @@ let combiner_functions =
    VT0.combiner_forinfofn = (fun r k e -> k e);
    VT0.combiner_casefn = (fun r k e -> k e);
    VT0.combiner_string_fragmentfn = (fun r k e -> k e);
+   VT0.combiner_attributefn = (fun r k e -> k e);
    VT0.combiner_topfn = (fun r k e -> k e)}
 
 let combiner_dz r =
@@ -1458,6 +1460,8 @@ let combiner_dz r =
       (function e -> let (n,_) = r.VT0.define_param e in n);
       VT0.combiner_rec_string_fragment =
       (function e -> let (n,_) = r.VT0.string_fragment e in n);
+      VT0.combiner_rec_attribute =
+      (function e -> let (n,_) = r.VT0.attribute e in n);
       VT0.combiner_rec_top_level =
       (function e -> let (n,_) = r.VT0.top_level e in n);
       VT0.combiner_rec_expression_dots =
@@ -1524,6 +1528,7 @@ let combiner bind option_default functions =
     (fun r k e -> (functions.VT0.combiner_forinfofn (dz r) (xk k) e, e))
     (fun r k e -> (functions.VT0.combiner_casefn (dz r) (xk k) e, e))
     (fun r k e -> (functions.VT0.combiner_string_fragmentfn (dz r) (xk k) e,e))
+    (fun r k e -> (functions.VT0.combiner_attributefn (dz r) (xk k) e, e))
     (fun r k e -> (functions.VT0.combiner_topfn (dz r) (xk k) e, e)))
 
 let flat_combiner bind option_default
@@ -1534,7 +1539,7 @@ let flat_combiner bind option_default
     dotsenumdeclfn dotscasefn dotsdefparfn
     identfn exprfn assignOpfn binaryOpfn tyfn initfn paramfn declfn fieldfn
     enumdeclfn
-    stmtfn forinfofn casefn string_fragmentfn topfn =
+    stmtfn forinfofn casefn string_fragmentfn attributefn topfn =
   let dz = combiner_dz in
   let xk k e = let (n,_) = k e in n in
   combiner_dz (visitor COMBINER bind option_default
@@ -1575,6 +1580,7 @@ let flat_combiner bind option_default
     (fun r k e -> (forinfofn (dz r) (xk k) e, e))
     (fun r k e -> (casefn (dz r) (xk k) e, e))
     (fun r k e -> (string_fragmentfn (dz r) (xk k) e, e))
+    (fun r k e -> (attributefn (dz r) (xk k) e, e))
     (fun r k e -> (topfn (dz r) (xk k) e, e)))
 
 let rebuilder_functions =
@@ -1615,6 +1621,7 @@ let rebuilder_functions =
    VT0.rebuilder_forinfofn = (fun r k e -> k e);
    VT0.rebuilder_casefn = (fun r k e -> k e);
    VT0.rebuilder_string_fragmentfn = (fun r k e -> k e);
+   VT0.rebuilder_attributefn = (fun r k e -> k e);
    VT0.rebuilder_topfn = (fun r k e -> k e)}
 
 let rebuilder_dz r =
@@ -1652,6 +1659,8 @@ let rebuilder_dz r =
       (function e -> let (_,e) = r.VT0.case_line e in e);
       VT0.rebuilder_rec_string_fragment =
       (function e -> let (_,e) = r.VT0.string_fragment e in e);
+      VT0.rebuilder_rec_attribute =
+      (function e -> let (_,e) = r.VT0.attribute e in e);
       VT0.rebuilder_rec_top_level =
       (function e -> let (_,e) = r.VT0.top_level e in e);
       VT0.rebuilder_rec_expression_dots =
@@ -1714,6 +1723,7 @@ let rebuilder functions =
     (fun r k e -> ((),functions.VT0.rebuilder_casefn (dz r) (xk k) e))
     (fun r k e ->
       ((),functions.VT0.rebuilder_string_fragmentfn (dz r) (xk k) e))
+    (fun r k e -> ((),functions.VT0.rebuilder_attributefn (dz r) (xk k) e))
     (fun r k e -> ((),functions.VT0.rebuilder_topfn (dz r) (xk k) e)))
 
 let flat_rebuilder
@@ -1725,7 +1735,7 @@ let flat_rebuilder
     dotsenumdeclfn dotscasefn dotsdefparfn
     identfn exprfn assignOpfn arithOpfn tyfn initfn paramfn declfn fieldfn
     enumdeclfn
-    stmtfn forinfofn casefn string_fragmentfn topfn =
+    stmtfn forinfofn casefn string_fragmentfn attributefn topfn =
   let dz = rebuilder_dz in
   let xk k e = let (_,e) = k e in e in
   rebuilder_dz
@@ -1767,6 +1777,7 @@ let flat_rebuilder
     (fun r k e -> ((),forinfofn (dz r) (xk k) e))
     (fun r k e -> ((),casefn (dz r) (xk k) e))
     (fun r k e -> ((),string_fragmentfn (dz r) (xk k) e))
+    (fun r k e -> ((),attributefn (dz r) (xk k) e))
     (fun r k e -> ((),topfn (dz r) (xk k) e)))
 
 let combiner_rebuilder_functions =
@@ -1821,6 +1832,7 @@ let combiner_rebuilder_functions =
    VT0.combiner_rebuilder_forinfofn = (fun r k e -> k e);
    VT0.combiner_rebuilder_casefn = (fun r k e -> k e);
    VT0.combiner_rebuilder_string_fragmentfn = (fun r k e -> k e);
+   VT0.combiner_rebuilder_attributefn = (fun r k e -> k e);
    VT0.combiner_rebuilder_topfn = (fun r k e -> k e)}
 
 let combiner_rebuilder bind option_default functions =
@@ -1862,4 +1874,5 @@ let combiner_rebuilder bind option_default functions =
     functions.VT0.combiner_rebuilder_forinfofn
     functions.VT0.combiner_rebuilder_casefn
     functions.VT0.combiner_rebuilder_string_fragmentfn
+    functions.VT0.combiner_rebuilder_attributefn
     functions.VT0.combiner_rebuilder_topfn
diff --git a/parsing_cocci/visitor_ast0.mli b/parsing_cocci/visitor_ast0.mli
index e801c983..53d51e4a 100644
--- a/parsing_cocci/visitor_ast0.mli
+++ b/parsing_cocci/visitor_ast0.mli
@@ -50,6 +50,7 @@ val flat_combiner :
     ((Ast0_cocci.forinfo,'a) Visitor_ast0_types.ccode) ->
     ((Ast0_cocci.case_line,'a) Visitor_ast0_types.ccode) ->
     ((Ast0_cocci.string_fragment,'a) Visitor_ast0_types.ccode) ->
+    ((Ast0_cocci.attr,'a) Visitor_ast0_types.ccode) ->
     ((Ast0_cocci.top_level,'a) Visitor_ast0_types.ccode) ->
     'a Visitor_ast0_types.combiner_rec_functions
 
@@ -95,6 +96,7 @@ val flat_rebuilder :
     (Ast0_cocci.forinfo Visitor_ast0_types.rcode) ->
     (Ast0_cocci.case_line Visitor_ast0_types.rcode) ->
     (Ast0_cocci.string_fragment Visitor_ast0_types.rcode) ->
+    (Ast0_cocci.attr Visitor_ast0_types.rcode) ->
     (Ast0_cocci.top_level Visitor_ast0_types.rcode) ->
       Visitor_ast0_types.rebuilder_rec_functions
 
diff --git a/parsing_cocci/visitor_ast0_types.ml b/parsing_cocci/visitor_ast0_types.ml
index 7a00c702..65892483 100644
--- a/parsing_cocci/visitor_ast0_types.ml
+++ b/parsing_cocci/visitor_ast0_types.ml
@@ -28,6 +28,7 @@ type 'n all_functions =
       case_line : (Ast0.case_line,'n) inout;
       define_param : (Ast0.define_param,'n) inout;
       string_fragment : (Ast0.string_fragment,'n) inout;
+      attribute : (Ast0.attr,'n) inout;
       top_level : (Ast0.top_level,'n) inout;
       expression_dots : (Ast0.expression Ast0.dots,'n) inout;
       statement_dots : (Ast0.statement Ast0.dots,'n) inout;
@@ -63,6 +64,7 @@ type 'n combiner_rec_functions =
       combiner_rec_case_line : (Ast0.case_line,'n) combiner_inout;
       combiner_rec_define_param : (Ast0.define_param,'n) combiner_inout;
       combiner_rec_string_fragment : (Ast0.string_fragment,'n) combiner_inout;
+      combiner_rec_attribute : (Ast0.attr,'n) combiner_inout;
       combiner_rec_top_level : (Ast0.top_level,'n) combiner_inout;
       combiner_rec_expression_dots :
 	(Ast0.expression Ast0.dots,'n) combiner_inout;
@@ -122,6 +124,7 @@ type 'n combiner_functions =
    combiner_forinfofn : (Ast0.forinfo,'n) ccode;
    combiner_casefn : (Ast0.case_line,'n) ccode;
    combiner_string_fragmentfn : (Ast0.string_fragment,'n) ccode;
+   combiner_attributefn : (Ast0.attr,'n) ccode;
    combiner_topfn : (Ast0.top_level,'n) ccode}
 
 (* ----------------------------------------------------------------------- *)
@@ -148,6 +151,7 @@ type rebuilder_rec_functions =
       rebuilder_rec_forinfo : Ast0.forinfo rebuilder_inout;
       rebuilder_rec_case_line : Ast0.case_line rebuilder_inout;
       rebuilder_rec_string_fragment : Ast0.string_fragment rebuilder_inout;
+      rebuilder_rec_attribute : Ast0.attr rebuilder_inout;
       rebuilder_rec_top_level : Ast0.top_level rebuilder_inout;
       rebuilder_rec_expression_dots :
 	Ast0.expression Ast0.dots rebuilder_inout;
@@ -208,6 +212,7 @@ type rebuilder_functions =
    rebuilder_forinfofn : Ast0.forinfo rcode;
    rebuilder_casefn : Ast0.case_line rcode;
    rebuilder_string_fragmentfn : Ast0.string_fragment rcode;
+   rebuilder_attributefn : Ast0.attr rcode;
    rebuilder_topfn : Ast0.top_level rcode}
 
 (* ----------------------------------------------------------------------- *)
@@ -256,4 +261,5 @@ type 'n combiner_rebuilder_functions =
    combiner_rebuilder_forinfofn : (Ast0.forinfo,'n) rccode;
    combiner_rebuilder_casefn : (Ast0.case_line,'n) rccode;
    combiner_rebuilder_string_fragmentfn : (Ast0.string_fragment,'n) rccode;
+   combiner_rebuilder_attributefn : (Ast0.attr,'n) rccode;
    combiner_rebuilder_topfn : (Ast0.top_level,'n) rccode}
diff --git a/parsing_cocci/visitor_ast0_types.mli b/parsing_cocci/visitor_ast0_types.mli
index d06baaf7..7c7c31aa 100644
--- a/parsing_cocci/visitor_ast0_types.mli
+++ b/parsing_cocci/visitor_ast0_types.mli
@@ -18,6 +18,7 @@ type 'n all_functions = {
   case_line : (Ast0_cocci.case_line, 'n) inout;
   define_param : (Ast0_cocci.define_param, 'n) inout;
   string_fragment : (Ast0_cocci.string_fragment, 'n) inout;
+  attribute : (Ast0_cocci.attr, 'n) inout;
   top_level : (Ast0_cocci.top_level, 'n) inout;
   expression_dots : (Ast0_cocci.expression Ast0_cocci.dots, 'n) inout;
   statement_dots : (Ast0_cocci.statement Ast0_cocci.dots, 'n) inout;
@@ -48,6 +49,7 @@ type 'n combiner_rec_functions = {
   combiner_rec_case_line : (Ast0_cocci.case_line, 'n) combiner_inout;
   combiner_rec_define_param : (Ast0_cocci.define_param, 'n) combiner_inout;
   combiner_rec_string_fragment : (Ast0_cocci.string_fragment, 'n) combiner_inout;
+  combiner_rec_attribute : (Ast0_cocci.attr, 'n) combiner_inout;
   combiner_rec_top_level : (Ast0_cocci.top_level, 'n) combiner_inout;
   combiner_rec_expression_dots :
     (Ast0_cocci.expression Ast0_cocci.dots, 'n) combiner_inout;
@@ -102,6 +104,7 @@ type 'n combiner_functions = {
   combiner_forinfofn : (Ast0_cocci.forinfo, 'n) ccode;
   combiner_casefn : (Ast0_cocci.case_line, 'n) ccode;
   combiner_string_fragmentfn : (Ast0_cocci.string_fragment, 'n) ccode;
+  combiner_attributefn : (Ast0_cocci.attr, 'n) ccode;
   combiner_topfn : (Ast0_cocci.top_level, 'n) ccode;
 }
 type 'a rebuilder_inout = 'a -> 'a
@@ -123,6 +126,7 @@ type rebuilder_rec_functions = {
   rebuilder_rec_forinfo : Ast0_cocci.forinfo rebuilder_inout;
   rebuilder_rec_case_line : Ast0_cocci.case_line rebuilder_inout;
   rebuilder_rec_string_fragment : Ast0_cocci.string_fragment rebuilder_inout;
+  rebuilder_rec_attribute : Ast0_cocci.attr rebuilder_inout;
   rebuilder_rec_top_level : Ast0_cocci.top_level rebuilder_inout;
   rebuilder_rec_expression_dots : Ast0_cocci.expression Ast0_cocci.dots rebuilder_inout;
   rebuilder_rec_statement_dots : Ast0_cocci.statement Ast0_cocci.dots rebuilder_inout;
@@ -175,6 +179,7 @@ type rebuilder_functions = {
   rebuilder_forinfofn : Ast0_cocci.forinfo rcode;
   rebuilder_casefn : Ast0_cocci.case_line rcode;
   rebuilder_string_fragmentfn : Ast0_cocci.string_fragment rcode;
+  rebuilder_attributefn : Ast0_cocci.attr rcode;
   rebuilder_topfn : Ast0_cocci.top_level rcode;
 }
 type ('mc, 'a) rcmcode = 'a -> 'mc Ast0_cocci.mcode -> 'a * 'mc Ast0_cocci.mcode
@@ -219,5 +224,6 @@ type 'n combiner_rebuilder_functions = {
   combiner_rebuilder_forinfofn : (Ast0_cocci.forinfo, 'n) rccode;
   combiner_rebuilder_casefn : (Ast0_cocci.case_line, 'n) rccode;
   combiner_rebuilder_string_fragmentfn : (Ast0_cocci.string_fragment, 'n) rccode;
+  combiner_rebuilder_attributefn : (Ast0_cocci.attr, 'n) rccode;
   combiner_rebuilder_topfn : (Ast0_cocci.top_level, 'n) rccode;
 }
-- 
2.21.3

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
