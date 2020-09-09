Return-Path: <SRS0=pcGb=CS=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C37BC43461
	for <cocci@archiver.kernel.org>; Wed,  9 Sep 2020 18:13:49 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 287D921D7D
	for <cocci@archiver.kernel.org>; Wed,  9 Sep 2020 18:13:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 287D921D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 089IDLKj025976;
	Wed, 9 Sep 2020 20:13:22 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 6DA967815;
	Wed,  9 Sep 2020 20:13:21 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 2E4665F8F
 for <cocci@systeme.lip6.fr>; Wed,  9 Sep 2020 20:13:20 +0200 (CEST)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 089IDJIn010054
 for <cocci@systeme.lip6.fr>; Wed, 9 Sep 2020 20:13:19 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: jaskaran_singh) with ESMTPSA id C548F29B137
From: Jaskaran Singh <jaskaran.singh@collabora.com>
To: cocci@systeme.lip6.fr
Date: Wed,  9 Sep 2020 23:43:01 +0530
Message-Id: <20200909181302.1187-3-jaskaran.singh@collabora.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200909181302.1187-1-jaskaran.singh@collabora.com>
References: <20200909181302.1187-1-jaskaran.singh@collabora.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 09 Sep 2020 20:13:22 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 09 Sep 2020 20:13:19 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] [RFC PATCH 2/3] parsing_c: parse_c: Build name cache and
	includes dependency graph
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

Build the includes dependency graph and name cache while parsing header
files. Every header file is parsed only once for name caching and, while
parsing these files, an includes dependency graph is built to determine
reachability of one header file from another file.

Signed-off-by: Jaskaran Singh <jaskaran.singh@collabora.com>
---
 parsing_c/parse_c.ml | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/parsing_c/parse_c.ml b/parsing_c/parse_c.ml
index 5574cb11b..3b250720f 100644
--- a/parsing_c/parse_c.ml
+++ b/parsing_c/parse_c.ml
@@ -17,6 +17,7 @@ open Common
 
 module TH = Token_helpers
 module LP = Lexer_parser
+module IC = Includes_cache
 
 module Stat = Parsing_stat
 
@@ -995,15 +996,29 @@ let rec _parse_print_error_heuristic2 saved_typedefs saved_macros
 and handle_include file wrapped_incl k =
     let incl = Ast_c.unwrap wrapped_incl.Ast_c.i_include in
     let parsing_style = Includes.get_parsing_style () in
+    let f = Includes.resolve file parsing_style incl in
     if Includes.should_parse parsing_style file incl
     then
-      match Includes.resolve file parsing_style incl with
+      match f with
       | Some header_filename when Common.lfile_exists header_filename ->
-	  (if !Flag_parsing_c.verbose_includes
-	  then pr2 ("including "^header_filename));
-	  let nonlocal =
-	    match incl with Ast_c.NonLocal _ -> true | _ -> false in
-          ignore (k nonlocal header_filename)
+          if not (IC.has_been_parsed header_filename)
+          then begin
+            IC.add_to_parsed_files header_filename;
+	    (if !Flag_parsing_c.verbose_includes
+	    then pr2 ("including "^header_filename));
+	    let nonlocal =
+	      match incl with Ast_c.NonLocal _ -> true | _ -> false in
+            let res = k nonlocal header_filename in
+            match res with
+              None -> ()
+            | Some x ->
+                let pt = x.parse_trees in
+                let (p, _, _) = pt in
+                with_program2_unit
+                  (IC.extract_names header_filename)
+                  p
+          end;
+          IC.add_to_dependency_graph file header_filename;
       | _ -> ()
 
 and _parse_print_error_heuristic2bis saved_typedefs saved_macros
-- 
2.21.3

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
