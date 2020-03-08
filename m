Return-Path: <SRS0=0GNs=4Z=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09F3C3F2C6
	for <cocci@archiver.kernel.org>; Sun,  8 Mar 2020 08:44:39 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DAD1206D7
	for <cocci@archiver.kernel.org>; Sun,  8 Mar 2020 08:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTIESWNF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DAD1206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0288iEOl012945;
	Sun, 8 Mar 2020 09:44:26 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 3913577F4;
	Sun,  8 Mar 2020 09:44:26 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 310C17742
 for <cocci@systeme.lip6.fr>; Sun,  8 Mar 2020 09:44:23 +0100 (CET)
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:441])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 0288iGYT006704
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 8 Mar 2020 09:44:17 +0100 (CET)
Received: by mail-pf1-x441.google.com with SMTP id c144so3404032pfb.10
 for <cocci@systeme.lip6.fr>; Sun, 08 Mar 2020 00:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nSi+dgPVv0xkezcYKd48ZE1X5GOqXzTJa3ohoO1Apmo=;
 b=MTIESWNFcQY2QWPO5eMS6C7CeqW7anSsU6Z793Utd9GI6wnXL4pEk6xRykG5QdhVcF
 HTrfsorFLXxMQU9sFg3glWtpvetTEobTHK3vDRFK7ZsU1ztOqTXPeEu7PemJe+gMsZvd
 fB72E4Rn+xuY04AnURROZFtXiTrmSqYTEW5zxtRSe8iYKu7M8WIjb6WpZ8gVVFfKZu4E
 2u4D4hse21fL/oCw3VpNCOHeP9b+tSoX5rNhrbQgRVoYrzGdej+BIG9wxY+Ea/sgOiNL
 q1A7v0FoZggezQrQFH6Wikqr50DjEw4YEhZtSlIteShsNfTmZFhIs0iT+i8kDOT6K0Ez
 cnQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nSi+dgPVv0xkezcYKd48ZE1X5GOqXzTJa3ohoO1Apmo=;
 b=q9/mDsT/pxscaTxh5qtLDgyX/lKVfN7CcKSbovjLZsvClO/4Llf/45www7vW92p6wQ
 zRTKuLDxs1ao/DrX8B4Sw9TztNemNLPm6rqlMUamynIp+k9Jp77v6msIu/ISV9YEYLHU
 tFF0P8jzTAxRDy5koNXB+o4+jdRQJSY62MmTUbWF8gVIGyRcuRAPZkxwh+3Fhi0QjqCW
 fMswOrINFMbe+dM3XdrFfljii2p3V+GR1iwlln/a77adiYyjWQ4Hj1LlzICW1bCk5Ko+
 q1Q+jENwoTwDUryuQDI305VDYL4fB7vPfliL10VRg9X8LR6Jc/W2dr5/naLgdBvBg3Sk
 E0Cw==
X-Gm-Message-State: ANhLgQ2+pIZZ4USOUE5gw2YdcUnxySEzTAUfFj/n495VHH3nAvDuWWtg
 456Fn+VB4dBIfFccSfcsgm8bVshG
X-Google-Smtp-Source: ADFU+vu9GWkUHfH56Um7+sGuoWDgr5VRLwBRNq+Y6cecZi6NyGSDkUWq4+Vkr91rmr27KChtEfK0Iw==
X-Received: by 2002:a63:770d:: with SMTP id s13mr10961125pgc.7.1583657055986; 
 Sun, 08 Mar 2020 00:44:15 -0800 (PST)
Received: from localhost.localdomain ([1.38.148.20])
 by smtp.gmail.com with ESMTPSA id b3sm14587244pjo.30.2020.03.08.00.44.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Mar 2020 00:44:15 -0800 (PST)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sun,  8 Mar 2020 14:13:46 +0530
Message-Id: <20200308084356.14506-4-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200308084356.14506-1-jaskaransingh7654321@gmail.com>
References: <20200308084356.14506-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 08 Mar 2020 09:44:26 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 08 Mar 2020 09:44:18 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 03/13] parsing_cocci: parser: Parse enumerators
	correctly
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

The EnumDef constructor of the SmPL AST has changed. Make
the SmPL parser parse an EnumDef correctly.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/parse_aux.ml            |  5 +++++
 parsing_cocci/parse_aux.mli           |  9 +++++++++
 parsing_cocci/parser_cocci_menhir.mly | 13 +++++--------
 3 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/parsing_cocci/parse_aux.ml b/parsing_cocci/parse_aux.ml
index 9f2d607b..b5d1afb4 100644
--- a/parsing_cocci/parse_aux.ml
+++ b/parsing_cocci/parse_aux.ml
@@ -136,6 +136,11 @@ let mkpdots str dot =
     "..." -> Ast0.wrap(Ast0.Pdots(clt2mcode str dot))
   | _ -> failwith "cannot happen"
 
+let mkenumdots str (dot,whencode) =
+  match str with
+    "..." -> Ast0.wrap(Ast0.EnumDots(clt2mcode str dot, whencode))
+  | _ -> failwith "cannot happen"
+
 let arith_op ast_op left op right =
   let op' = Ast0.wrap (Ast0.Arith (clt2mcode ast_op op)) in  
   Ast0.wrap (Ast0.Binary(left, op', right))
diff --git a/parsing_cocci/parse_aux.mli b/parsing_cocci/parse_aux.mli
index 63419831..91d7cb26 100644
--- a/parsing_cocci/parse_aux.mli
+++ b/parsing_cocci/parse_aux.mli
@@ -126,6 +126,15 @@ val mkpdots :
   (Ast_cocci.added_string * Ast0_cocci.position_info) list *
   (Ast_cocci.added_string * Ast0_cocci.position_info) list * Ast0_cocci.anything list *
   string -> Ast0_cocci.base_parameterTypeDef Ast0_cocci.wrap
+val mkenumdots :
+  string ->
+  (Data.line_type * int * int * int * int * int *
+   (Ast_cocci.added_string * Ast0_cocci.position_info) list *
+   (Ast_cocci.added_string * Ast0_cocci.position_info) list * Ast0_cocci.anything list *
+   string) *
+  (string Ast0_cocci.mcode * string Ast0_cocci.mcode * Ast0_cocci.enum_decl)
+  option ->
+  Ast0_cocci.base_enum_decl Ast0_cocci.wrap
 val arith_op :
   Ast_cocci.arithOp ->
   Ast0_cocci.expression ->
diff --git a/parsing_cocci/parser_cocci_menhir.mly b/parsing_cocci/parser_cocci_menhir.mly
index 9e6c8a08..ff535729 100644
--- a/parsing_cocci/parser_cocci_menhir.mly
+++ b/parsing_cocci/parser_cocci_menhir.mly
@@ -1160,15 +1160,12 @@ struct_decl_list_start:
 /* very restricted what kinds of expressions can appear in an enum decl */
 
 enum_decl_one:
-    | disj_ident    { Ast0.wrap(Ast0.Ident($1)) }
+    | disj_ident    { Ast0.wrap(Ast0.Enum($1, None)) }
     | disj_ident TEq enum_val
-	{ let id = Ast0.wrap(Ast0.Ident($1)) in
-        let (op,clt) = ("=",$2) in
-        let op' = P.clt2mcode op clt in
-        let op'' = Ast0.wrap (Ast0.SimpleAssign op') in
+	{
 	Ast0.wrap
-	  (Ast0.Assignment
-	     (id, op'', Ast0.set_arg_exp $3, false)) }
+	  (Ast0.Enum
+	     ($1, Some(P.clt2mcode "=" $2, $3))) }
 
 enum_val:
    ident    { Ast0.wrap(Ast0.Ident($1)) }
@@ -1193,7 +1190,7 @@ enum_val:
 
 enum_decl_list:
    nonempty_list_start(enum_decl_one,edots_when(TEllipsis,enum_decl_one))
-     { Ast0.wrap($1 P.mkedots (fun c -> Ast0.EComma c)) }
+     { Ast0.wrap($1 P.mkenumdots (fun c -> Ast0.EnumComma c)) }
 
 /*****************************************************************************/
 
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
