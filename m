Return-Path: <SRS0=VaV3=27=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A3DC33CA4
	for <cocci@archiver.kernel.org>; Fri, 10 Jan 2020 17:12:32 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43FAA2080D
	for <cocci@archiver.kernel.org>; Fri, 10 Jan 2020 17:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qvfQuEt9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43FAA2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00AHCI4I027236;
	Fri, 10 Jan 2020 18:12:18 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 98DEE77EA;
	Fri, 10 Jan 2020 18:12:18 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7E70677E3
 for <cocci@systeme.lip6.fr>; Fri, 10 Jan 2020 18:12:17 +0100 (CET)
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:444])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00AHCGGI024005
 for <cocci@systeme.lip6.fr>; Fri, 10 Jan 2020 18:12:16 +0100 (CET)
Received: by mail-pf1-x444.google.com with SMTP id n9so1412681pff.13
 for <cocci@systeme.lip6.fr>; Fri, 10 Jan 2020 09:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=joa4U6NVSyf3okdud4VRwzY72Y0ZlT46zp7owqZcmHc=;
 b=qvfQuEt9fQ8K4OtdLOPjD8xcTI5WbX0ofVHsvV7s+rc6fr8kk4LrVw7/rzCHMh4iMP
 W01njasiHWH0LHlgBmvm3tZt6Gzrp9199R7/wu4/C+DYa8JcOJ5Enj0fC8WW7JLW5LIt
 QRBkrHIWKGZE10grbf2dTD9YY9LcrWVus11FVEsZcIVVpRLOrpQg9bdbjoxSirlb7hLc
 +qHGu1vw0bbuGpfn/EKYaPH6m5+L6OlTLMAij7HvVM8XUHszQwbW3GZLCyaQHGXMb+qu
 vSHhj5zItdSE+IdrUx0xH8OrkL53s3IakhRIEQ0VLTU5jc2Mm0Jf6TLOctFzoGwPGRM9
 /ATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=joa4U6NVSyf3okdud4VRwzY72Y0ZlT46zp7owqZcmHc=;
 b=QAteEZUwRN92deLJ0WmzJzrNdnlzmjk3QwLNDSTwlZ/gL1VjP66TSBdCsX2E/vOUKJ
 TKR5McITLRlCcOyKMOWfAA0h68n/76VsLVas+UnrbpoFQp3+zQcAjQY8jC+wPm+aT7nt
 bBShjKVFQIW+OqIVCo5Vd02Vsc0+0WfpLb/53vyFhaxMAO40nX6+6GKB7GNbJ/GfyAzs
 l9Jug7ss9LpTztoBhARJO2jyJD+hPcBV/QMSwLXIA6ScMg9EpmUi1nUlJ0J4816Waath
 LPrIOhUpaMYAJqxWqJWN2w+/CmWBnp2DtnJ1rhPeqFR868V9bWQ00eJUWI6a7mKj/KA5
 1gQg==
X-Gm-Message-State: APjAAAUhMb+JgpztnpejOw+myEd3IupefrrFX4WNBkW44bBAFYEvZv1u
 WZ0c2Fl5C6ZhhzRVgrQwTR4tcGMQago=
X-Google-Smtp-Source: APXvYqzB/kKjQGYXIaC96i8daTOgWtOxGdexmMQqefBVgyG256LxIiMCm3rK3x7BydmKOtYmVtVGzw==
X-Received: by 2002:a63:de47:: with SMTP id y7mr5491806pgi.270.1578676335906; 
 Fri, 10 Jan 2020 09:12:15 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:1662:5ce0:c587:cd6:22a3:e892])
 by smtp.gmail.com with ESMTPSA id b24sm3534920pfo.55.2020.01.10.09.12.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2020 09:12:15 -0800 (PST)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri, 10 Jan 2020 22:41:49 +0530
Message-Id: <20200110171150.14695-2-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200110171150.14695-1-jaskaransingh7654321@gmail.com>
References: <20200110171150.14695-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 10 Jan 2020 18:12:18 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 10 Jan 2020 18:12:17 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org, skhan@linuxfoundation.org
Subject: [Cocci] [PATCH 1/2] parsing_c: Support user comments attached to
	identifier
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

Comments attached to identifiers via OCaml/Python bindings can be helpful
in using Coccinelle for source code analysis. Users of SmPL can attach
these comments to identifiers for denoting some information.

In certain cases, attaching comments to an identifier via OCaml/Python
bindings can lead to pretty printing errors. The reason for this is that
cases in unparse_cocci.ml do not recognize the identifier and the comments
as different tokens.

Add a function to support user comments.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_c/unparse_cocci.ml | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/parsing_c/unparse_cocci.ml b/parsing_c/unparse_cocci.ml
index 30e755e9..0388aa59 100644
--- a/parsing_c/unparse_cocci.ml
+++ b/parsing_c/unparse_cocci.ml
@@ -268,23 +268,49 @@ let print_disj_list fn l sep =
 (* --------------------------------------------------------------------- *)
 (* Identifier *)
 
+let print_with_comments id lcol rcol =
+  let ident_re = Str.regexp
+    "^\\([a-zA-Z_][a-zA-Z_0-9]*\\)\\(/\\*.*\\*/\\)*$" in
+  let pr_with_comments i c =
+    match c with
+      "" -> print_text i
+    | _ ->
+        print_text i;
+        pr_barrier lcol rcol;
+        print_text c in
+  let get_match i s =
+    try matched i s
+    with Not_found -> "" in
+  if id ==~ ident_re
+  then
+    let matched_id = get_match 1 id in
+    let comment = get_match 2 id in
+    pr_with_comments matched_id comment
+  else print_text id in
+
 let rec ident i =
   match Ast.unwrap i with
       Ast.Id(name) -> mcode print_string name
     | Ast.MetaId(name,_,_,_) ->
+	let (_,_,_,lcol,rcol) = lookup_metavar name in
 	handle_metavar name (function
-			       | (Ast_c.MetaIdVal id) -> print_text id
+			       | (Ast_c.MetaIdVal id) ->
+                                   print_with_comments id lcol rcol
 			       | _ -> error name i "identifier value expected"
 			    )
     | Ast.MetaFunc(name,_,_,_) ->
+	let (_,_,_,lcol,rcol) = lookup_metavar name in
 	handle_metavar name (function
-			       | (Ast_c.MetaFuncVal id) -> print_text id
+			       | (Ast_c.MetaFuncVal id) ->
+                                   print_with_comments id lcol rcol
 			       | _ ->
 				   error name i "function name value expected"
 			    )
     | Ast.MetaLocalFunc(name,_,_,_) ->
+	let (_,_,_,lcol,rcol) = lookup_metavar name in
 	handle_metavar name (function
-			       | (Ast_c.MetaLocalFuncVal id) -> print_text id
+			       | (Ast_c.MetaLocalFuncVal id) ->
+                                   print_with_comments id lcol rcol
 			       | _ ->
 				   error name i
 				     "local function name value expected"
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
