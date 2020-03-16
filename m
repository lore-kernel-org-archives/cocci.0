Return-Path: <SRS0=+m3J=5B=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 643ECC4CECE
	for <cocci@archiver.kernel.org>; Mon, 16 Mar 2020 10:04:08 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBA012071C
	for <cocci@archiver.kernel.org>; Mon, 16 Mar 2020 10:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TILuxv64"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBA012071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02GA3kvZ006313;
	Mon, 16 Mar 2020 11:03:46 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 70A6F7822;
	Mon, 16 Mar 2020 11:03:40 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 4AAC4781F
 for <cocci@systeme.lip6.fr>; Mon, 16 Mar 2020 11:03:39 +0100 (CET)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:535])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02GA3aum009947
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 16 Mar 2020 11:03:37 +0100 (CET)
Received: by mail-pg1-x535.google.com with SMTP id z4so3691199pgu.3
 for <cocci@systeme.lip6.fr>; Mon, 16 Mar 2020 03:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=E8iDrgsHE027K+FE3v0mwPnXtrzybe8lDJJX12h8vck=;
 b=TILuxv6445mlLoJGVL2FGozwg6KNabEwuHD0ugQnZZttwMLiwFBn8cgkzFFybCir3x
 arJh75Hc/D1fjuPuu4cGnsa/ZOKue2WA/0Q2C+KydK19GfpQ8tgagYTHQ+/AKdu8JWE+
 I32/5rEVl0J5gL4gcTwGCSCvZI9Lecd3qu9nn/VDbztaEFvp2RxrX623NJP7KTfUg/g8
 G7CUSeW4xHLpUr7n0JqocuoUBVL0qNQX7LP4/R6SG8lOicJbbv8cqHxizWvKBoDsWY3K
 vxREGsNDb3nbfs/OadtQR2mJYtBWJ/DQginqEVNGfi6BJF75WB1ACcx8f3E6mY9KMxxd
 giQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=E8iDrgsHE027K+FE3v0mwPnXtrzybe8lDJJX12h8vck=;
 b=NsemdXTzUseiSaKs3YWZ90mRJ6u/Zq6Qa672zzFlY+7qhSFFAEAMcwhKCIhViasfqh
 HR9ZfAtadyfBti4WkRfYMHuH50yjF3P2ztO5iagM9o4DeXtrz6FrjSM8VobddfbE7w8U
 0AoIRgUvn+Bjjv6jFIdeOQYO4ZWWztF8xXnmRYKiBJAd2C6sWfaObR3fzHVGQ7GPE0e8
 yUKzN33GUuVMN+h5Ea3ADdBcQjs8oLbohpoHhvGO8TnPBksLJmhps9/0fCzvFy1QEUkn
 HaN0Zr80S32SMF4p6PadwqNy0ave6IVQFR1iWO6yriOaudfSX9m3ivnKc6WzlnIKgsYV
 Xn8w==
X-Gm-Message-State: ANhLgQ24StTYNr6SMNa/KSj5rEPeXJ3sJyY/GIuRqH2O9HlMZHu0dH9n
 FlZwlqp4cNd7T12idL9Dw4UxYeN2
X-Google-Smtp-Source: ADFU+vuHDbRlrKvR17wodpG4OQigmIZChV0t9oXkwWTo/yT9rw+Kdv6qZNgAd24MojOTsZvJIFVtiA==
X-Received: by 2002:a63:c4e:: with SMTP id 14mr25922355pgm.444.1584353015997; 
 Mon, 16 Mar 2020 03:03:35 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:284:a4f2:cc63:b7fc:551c:dce5])
 by smtp.gmail.com with ESMTPSA id
 u3sm19803374pjv.32.2020.03.16.03.03.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 03:03:35 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 16 Mar 2020 15:32:54 +0530
Message-Id: <20200316100319.27935-2-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200316100319.27935-1-jaskaransingh7654321@gmail.com>
References: <20200316100319.27935-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 16 Mar 2020 11:03:46 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 16 Mar 2020 11:03:38 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 01/26] parsing_cocci: Add Function Prototype token
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

To add the types ParenType and FunctionType to the SmPL AST, a
reduce/reduce conflict with the funproto rule of the SmPL parser
must be resolved. This requires explicitly identifying a function
prototype by use of a token (TFunProto).

While the correct method of identifying a function prototype would be to
check if an identifier is preceded by a return type, it is challenging
to implement. This is because implementing an OCaml function, to
correctly determine a C type in SmPL, without the aid of Yacc, would
have to handle a number of cases (disjunctions, typeof expressions,
etc.).

Thus, a slightly hacky approach is taken to determine a function
prototype with not the best certainty but what works for most cases
in SmPL. If the identifier is preceded by any token that does not
seem to be part of a type, then it is not identified as a function
prototype. Else, it is.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/parse_cocci.ml          | 72 +++++++++++++++++++++++----
 parsing_cocci/parser_cocci_menhir.mly |  9 ++--
 2 files changed, 67 insertions(+), 14 deletions(-)

diff --git a/parsing_cocci/parse_cocci.ml b/parsing_cocci/parse_cocci.ml
index 679d213a..4b2cb7e4 100644
--- a/parsing_cocci/parse_cocci.ml
+++ b/parsing_cocci/parse_cocci.ml
@@ -295,6 +295,7 @@ let token2c (tok,_) add_clt =
   | PC.TLineEnd(clt) -> "line end"
   | PC.TInvalid -> "invalid"
   | PC.TFunDecl(clt) -> "fundecl"
+  | PC.TFunProto(clt) -> "funproto"
 
   | PC.TIso -> "<=>"
   | PC.TRightIso -> "=>"
@@ -480,7 +481,7 @@ let get_clt (tok,_) =
 
   | PC.TOPar0(_,clt) | PC.TMid0(_,clt) | PC.TAnd0(_,clt) | PC.TCPar0(_,clt)
   | PC.TOEllipsis(clt) | PC.TCEllipsis(clt)
-  | PC.TPOEllipsis(clt) | PC.TPCEllipsis(clt)
+  | PC.TPOEllipsis(clt) | PC.TPCEllipsis(clt) | PC.TFunProto(clt)
   | PC.TFunDecl(clt) | PC.TDirective(_,clt) | PC.TAttr_(clt)
   | PC.TLineEnd(clt) -> clt
   | PC.TVAEllipsis(clt) -> clt
@@ -718,6 +719,7 @@ let update_clt (tok,x) clt =
 
   | PC.TLineEnd(_) -> (PC.TLineEnd(clt),x)
   | PC.TFunDecl(_) -> (PC.TFunDecl(clt),x)
+  | PC.TFunProto(_) -> (PC.TFunProto(clt),x)
   | PC.TTildeExclEq(_) -> (PC.TTildeExclEq(clt),x)
   | PC.TDirective(a,_) -> (PC.TDirective(a,clt),x)
   | PC.TAttr_(_) -> (PC.TAttr_(clt),x)
@@ -925,7 +927,7 @@ let split_token ((tok,_) as t) =
   | PC.TInitialize | PC.TFinalize -> ([t],[t])
   | PC.TPArob clt | PC.TMetaPos(_,_,_,clt) | PC.TMetaCom(_,_,clt) -> split t clt
 
-  | PC.TFunDecl(clt)
+  | PC.TFunDecl(clt) | PC.TFunProto(clt)
   | PC.TWhen(clt) | PC.TWhenTrue(clt) | PC.TWhenFalse(clt)
   | PC.TAny(clt) | PC.TStrict(clt) | PC.TLineEnd(clt)
   | PC.TEllipsis(clt)
@@ -1006,7 +1008,8 @@ let find_function_names l =
     | _ -> false in
   let rec split acc = function
       [] | [_] -> raise Irrelevant
-    | ((PC.TCPar(_),_) as t1) :: ((PC.TOBrace(_),_) as t2) :: rest ->
+    | ((PC.TCPar(_),_) as t1) :: ((PC.TOBrace(_),_) as t2) :: rest
+    | ((PC.TCPar(_),_) as t1) :: ((PC.TPtVirg(_),_) as t2) :: rest ->
 	(List.rev (t1::acc),(t2::rest))
     | x::xs -> split (x::acc) xs in
   let rec balanced_name level = function
@@ -1037,7 +1040,48 @@ let find_function_names l =
     | (PC.TArobArob,_)::_ | (PC.TArob,_)::_ | (PC.EOF,_)::_ ->
 	raise Irrelevant
     | t::rest -> balanced_args level rest in
-  let rec loop = function
+  let rec is_permissible_proto = function
+      [] -> false
+    | (PC.TCPar0(_),_)::
+      ((PC.TMid0(_),_) | (PC.TAnd0(_),_))::
+      (PC.TOPar0(_),_)::_ -> false
+    | (PC.TOPar0(_),_)::rest
+    | (PC.TCPar0(_),_)::rest -> is_permissible_proto rest
+    | x::rest when is_mid x ->
+        let rec loop = function
+          [] -> false
+        | (PC.TOPar0(_),_)::xs -> is_permissible_proto xs
+        | x::xs -> loop xs in
+        loop rest
+    | _::((PC.TEq(_),_) | (PC.TNotEq(_),_))::(PC.TWhen(_),_)::_
+    | _::(PC.TWhen(_),_)::_
+    | (PC.TComma(_),_)::_
+    | (PC.TDirective(_),_)::_
+    | (PC.TElse(_),_)::_
+    | (PC.TReturn(_),_)::_
+    | (PC.TMetaStm(_),_)::_
+    | (PC.TMetaExp(_),_)::_
+    | (PC.TMetaId(_),_)::_
+    | (PC.TMetaLocalIdExp(_),_)::_
+    | (PC.TEq(_),_)::_
+    | (PC.TEllipsis(_),_)::_
+    | (PC.TOEllipsis(_),_)::_
+    | (PC.TCEllipsis(_),_)::_
+    | (PC.TPOEllipsis(_),_)::_
+    | (PC.TPCEllipsis(_),_)::_
+    | (PC.TPtVirg(_),_)::_
+    | (PC.TOBrace(_),_)::_
+    | (PC.TCBrace(_),_)::_
+    | (PC.TOPar(_),_)::_
+    | (PC.TCPar(_),_)::_
+    | (PC.TIdent(_),_)::_ -> false
+    | _ -> true in
+  let decl_or_proto clt info bef aft =
+    match aft with
+      (PC.TOBrace(_),_)::_ -> (((PC.TFunDecl(clt),info) :: bef), aft)
+    | (PC.TPtVirg(_),_)::_ -> (((PC.TFunProto(clt),info) :: bef), aft)
+    | _ -> raise Irrelevant in
+  let rec loop acc = function
       [] -> []
     | t :: rest ->
 	if is_par t || is_mid t || is_ident t
@@ -1046,26 +1090,30 @@ let find_function_names l =
 	    try
 	      let (bef,aft) = split [] (t::rest) in
 	      let rest = balanced_name 0 bef in
+              (match aft with
+                (PC.TPtVirg(_),_)::_
+                 when not(is_permissible_proto acc) -> raise Irrelevant
+              | _ ->
 	      (match rest with
 		(PC.TOPar(_),_)::_ ->
 		  (match balanced_args 0 rest with
 		    [] ->
 		      let (_,info) as h = List.hd bef in
 		      let clt = get_clt h in
-		      (((PC.TFunDecl(clt),info) :: bef), aft)
+                      decl_or_proto clt info bef aft
 		  | (PC.TAttr_(_),_)::rest ->
 		      (match balanced_args 0 rest with
 			[] ->
 			  let (_,info) as h = List.hd bef in
 			  let clt = get_clt h in
-			  (((PC.TFunDecl(clt),info) :: bef), aft)
+                          decl_or_proto clt info bef aft
 		      | _ -> raise Irrelevant)
 		  | _ -> raise Irrelevant)
-	      | _ -> raise Irrelevant)
+	      | _ -> raise Irrelevant))
 	    with Irrelevant -> ([t],rest) in
-	  t @ (loop rest)
-	else t :: (loop rest) in
-  loop l
+          t @ (loop (t @ acc) rest)
+        else t :: (loop (t :: acc) rest) in
+  loop [] l
 
 (* ----------------------------------------------------------------------- *)
 (* an attribute is an identifier that precedes another identifier and
@@ -1168,6 +1216,8 @@ let detect_types in_meta_decls l =
 	delim::newid::id::(loop false infn (ident::type_names) rest)
     | ((PC.TFunDecl(_),_) as fn)::rest ->
 	fn::(loop false 1 type_names rest)
+    | ((PC.TFunProto(_),_) as fn)::rest ->
+	fn::(loop false 1 type_names rest)
     | ((PC.TOPar(_),_) as lp)::rest when infn > 0 ->
 	lp::(loop false (infn + 1) type_names rest)
     | ((PC.TCPar(_),_) as rp)::rest when infn > 0 ->
@@ -1252,7 +1302,7 @@ let token2line (tok,_) =
   | PC.TMetaDParamList(_,_,_,_,clt) | PC.TMetaFunc(_,_,_,clt)
   | PC.TMetaLocalFunc(_,_,_,clt) | PC.TMetaPos(_,_,_,clt) | PC.TMetaCom(_,_,clt)
 
-  | PC.TFunDecl(clt)
+  | PC.TFunDecl(clt) | PC.TFunProto(clt)
   | PC.TWhen(clt) | PC.TWhenTrue(clt) | PC.TWhenFalse(clt)
   | PC.TAny(clt) | PC.TStrict(clt) | PC.TEllipsis(clt)
 
diff --git a/parsing_cocci/parser_cocci_menhir.mly b/parsing_cocci/parser_cocci_menhir.mly
index 9e6c8a08..26958f63 100644
--- a/parsing_cocci/parser_cocci_menhir.mly
+++ b/parsing_cocci/parser_cocci_menhir.mly
@@ -239,7 +239,8 @@ let inline_id aft = function
 
 %token <Data.clt> TVAEllipsis
 %token <Data.clt> TIf TElse TWhile TFor TDo TSwitch TCase TDefault TReturn
-%token <Data.clt> TBreak TContinue TGoto TSizeof TTypeof TFunDecl Tdecimal Texec
+%token <Data.clt> TBreak TContinue TGoto TSizeof TTypeof TFunDecl TFunProto
+%token <Data.clt> Tdecimal Texec
 %token <string * Data.clt> TIdent TTypeId TDeclarerId TIteratorId TSymId
 %token <Ast_cocci.added_string * Data.clt> TDirective
 %token <Data.clt> TAttr_
@@ -1439,7 +1440,8 @@ reverse_separated_nonempty_llist(separator, X):
 
 funproto:
   s=ioption(storage) i=ioption(Tinline) t=ctype
-  id=fn_ident lp=TOPar arglist=arg_list(name_opt_decl) rp=TCPar pt=TPtVirg
+  TFunProto id=fn_ident
+  lp=TOPar arglist=arg_list(name_opt_decl) rp=TCPar pt=TPtVirg
       { let s = match s with None -> [] | Some s -> [Ast0.FStorage s] in
         let i =
 	  match i with
@@ -1453,7 +1455,8 @@ funproto:
 	      P.clt2mcode "(" lp, args, vararg, P.clt2mcode ")" rp,
 	      P.clt2mcode ";" pt)) }
 | i=Tinline s=storage t=ctype
-  id=fn_ident lp=TOPar arglist=arg_list(name_opt_decl) rp=TCPar pt=TPtVirg
+  TFunProto id=fn_ident
+  lp=TOPar arglist=arg_list(name_opt_decl) rp=TCPar pt=TPtVirg
       { let s = [Ast0.FStorage s] in
         let i = [Ast0.FInline (P.clt2mcode "inline" i)] in
 	let t = [Ast0.FType t] in
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
