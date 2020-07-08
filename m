Return-Path: <SRS0=dcoo=AT=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B3EC433E1
	for <cocci@archiver.kernel.org>; Wed,  8 Jul 2020 13:01:34 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C65720658
	for <cocci@archiver.kernel.org>; Wed,  8 Jul 2020 13:01:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C65720658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 068D1J50023740;
	Wed, 8 Jul 2020 15:01:19 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 446557839;
	Wed,  8 Jul 2020 15:01:14 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 71E487831
 for <cocci@systeme.lip6.fr>; Wed,  8 Jul 2020 15:01:11 +0200 (CEST)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 068D1AUT022988
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Wed, 8 Jul 2020 15:01:10 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: jaskaran_singh) with ESMTPSA id AE1582A07C0
From: Jaskaran Singh <jaskaran.singh@collabora.com>
To: cocci@systeme.lip6.fr
Date: Wed,  8 Jul 2020 18:30:17 +0530
Message-Id: <20200708130035.26687-3-jaskaran.singh@collabora.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200708130035.26687-1-jaskaran.singh@collabora.com>
References: <20200708130035.26687-1-jaskaran.singh@collabora.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 08 Jul 2020 15:01:19 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Wed, 08 Jul 2020 15:01:10 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Subject: [Cocci] [PATCH v2 RESEND 02/20] parsing_cocci: parser: Wrap SmPL
	Attributes
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

Attributes are wrapped in the SmPL AST. Reciprocate this and wrap
attributes in the SmPL parser.

Signed-off-by: Jaskaran Singh <jaskaran.singh@collabora.com>
---
 parsing_cocci/parse_aux.ml            |  3 +++
 parsing_cocci/parse_aux.mli           |  7 +++++++
 parsing_cocci/parser_cocci_menhir.mly | 18 ++++++++++--------
 3 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/parsing_cocci/parse_aux.ml b/parsing_cocci/parse_aux.ml
index b5d1afb4..f2036bfc 100644
--- a/parsing_cocci/parse_aux.ml
+++ b/parsing_cocci/parse_aux.ml
@@ -152,6 +152,9 @@ let logic_op ast_op left op right =
 let make_cv cv ty =
   match cv with None -> ty | Some x -> Ast0.wrap (Ast0.ConstVol(x,ty))
 
+let make_attr attr =
+  Ast0.wrap(Ast0.Attribute(id2mcode attr))
+
 let top_dots l = Ast0.wrap l
 
 (* here the offset is that of the first in the sequence of *s, not that of
diff --git a/parsing_cocci/parse_aux.mli b/parsing_cocci/parse_aux.mli
index 91d7cb26..0ecf10b0 100644
--- a/parsing_cocci/parse_aux.mli
+++ b/parsing_cocci/parse_aux.mli
@@ -151,6 +151,13 @@ val logic_op :
   string -> Ast0_cocci.expression -> Ast0_cocci.base_expression Ast0_cocci.wrap
 val make_cv :
   Ast_cocci.const_vol Ast0_cocci.mcode option -> Ast0_cocci.typeC -> Ast0_cocci.typeC
+val make_attr:
+  string *
+  (Data.line_type * int * int * int * int * int *
+   (Ast_cocci.added_string * Ast0_cocci.position_info) list *
+   (Ast_cocci.added_string * Ast0_cocci.position_info) list *
+   Ast0_cocci.anything list * string) ->
+   Ast0_cocci.attr
 val top_dots : 'a -> 'a Ast0_cocci.wrap
 val pointerify :
   Ast0_cocci.typeC ->
diff --git a/parsing_cocci/parser_cocci_menhir.mly b/parsing_cocci/parser_cocci_menhir.mly
index 56c336a1..af9726e1 100644
--- a/parsing_cocci/parser_cocci_menhir.mly
+++ b/parsing_cocci/parser_cocci_menhir.mly
@@ -1495,11 +1495,11 @@ fninfo:
 	let _ = List.find (function Ast0_cocci.FInline(_) -> true | _ -> false) $2 in
 	raise (Semantic_cocci.Semantic "duplicate inline")
       with Not_found -> (Ast0_cocci.FInline(Parse_aux.clt2mcode "inline" $1))::$2 }
-  | Tattr    fninfo
+  | a=Tattr    fninfo
       { try
 	let _ = List.find (function Ast0_cocci.FAttr(_) -> true | _ -> false) $2 in
 	raise (Semantic_cocci.Semantic "multiple attributes")
-      with Not_found -> (Ast0_cocci.FAttr(Parse_aux.id2mcode $1))::$2 }
+      with Not_found -> (Ast0_cocci.FAttr(Parse_aux.make_attr a))::$2 }
 
 fninfo_nt:
     /* empty */ { [] }
@@ -1514,11 +1514,11 @@ fninfo_nt:
 	let _ = List.find (function Ast0_cocci.FInline(_) -> true | _ -> false) $2 in
 	raise (Semantic_cocci.Semantic "duplicate inline")
       with Not_found -> (Ast0_cocci.FInline(Parse_aux.clt2mcode "inline" $1))::$2 }
-  | Tattr    fninfo_nt
+  | a=Tattr    fninfo_nt
       { try
 	let _ = List.find (function Ast0_cocci.FAttr(_) -> true | _ -> false) $2 in
 	raise (Semantic_cocci.Semantic "duplicate init")
-      with Not_found -> (Ast0_cocci.FAttr(Parse_aux.id2mcode $1))::$2 }
+      with Not_found -> (Ast0_cocci.FAttr(Parse_aux.make_attr a))::$2 }
 
 storage:
          s=Tstatic      { Parse_aux.clt2mcode Ast_cocci.Static s }
@@ -3227,12 +3227,14 @@ script_virt_name_decl:
 
 %inline
 attr_list:
-                        { [] }
- | a=Tattr f=full_attr_list {Parse_aux.id2mcode a::f}
+                           { [] }
+ | Tattr f=full_attr_list
+    { let a = Parse_aux.make_attr $1 in a::f }
 
 full_attr_list:
-                        { [] }
- | Tattr full_attr_list {Parse_aux.id2mcode $1::$2}
+                           { [] }
+ | Tattr f=full_attr_list
+    { let a = Parse_aux.make_attr $1 in a::f }
 
 anything: /* used for script code */
    TIdentifier { "identifier" }
-- 
2.21.3

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
