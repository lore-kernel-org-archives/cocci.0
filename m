Return-Path: <SRS0=qWDJ=5C=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C621C10F29
	for <cocci@archiver.kernel.org>; Tue, 17 Mar 2020 08:44:35 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75A7420674
	for <cocci@archiver.kernel.org>; Tue, 17 Mar 2020 08:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Un2YJTW9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75A7420674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02H8iMVi001215;
	Tue, 17 Mar 2020 09:44:22 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 18C957808;
	Tue, 17 Mar 2020 09:44:22 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id C101F3B93
 for <cocci@systeme.lip6.fr>; Tue, 17 Mar 2020 09:44:20 +0100 (CET)
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:541])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02H8iI2m012286
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Tue, 17 Mar 2020 09:44:19 +0100 (CET)
Received: by mail-pg1-x541.google.com with SMTP id m15so11322928pgv.12
 for <cocci@systeme.lip6.fr>; Tue, 17 Mar 2020 01:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=l7INLeM/RDBSwj9nE6SnZPwPnnYgiUoi/gexQUxcDqQ=;
 b=Un2YJTW95/3s2mhk4GocGitMHkvJLAMgCo4yxvb3f0GIRTii6RKVq3gQP1lXQ8h0G9
 rfeTsnbnNAO25keTfVNScUW8PR3UhnX5JT7vZLB8POoyxjWiZ000Lv2gwtSdoK2h1Eks
 KiN/hB1x9ZkrydLEOiB4CtfriupyYxS6bJ2rBc0c+8Fh3EU/J496W/jimx4SuRz7CnTg
 JMwpt4j6thkqJihwk4MGieIPPqNlop3cHchk7njtPaDXbTQWHt39n06WO84Qty7Nsi3i
 kKYD+04BEW2YySCCvbLyit3m9eCjh9l9U2Pao5RdmAXFEVQUBG4qSuwhAxJfIrhyGfxE
 2S2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=l7INLeM/RDBSwj9nE6SnZPwPnnYgiUoi/gexQUxcDqQ=;
 b=JYiK+PiEuf3IXayIauGl6TySY9LcnFZyX79Zoz/shjqLaoiHcsY2ArUkLSlHBIoSVT
 PrqvTXwnyeCR29f9Hd5y9qQRIe4xOSz3vZNlh5n1beeWhjh5mtcffB/CoIHrWG0/1nEH
 ftR5HlraH3qFAigFXqjvAvBxONkU4ed2MYRKGHX8o0VgVRjrjEvlGtZrUOzVtoH1zFj7
 07mGUM2znMymefscSrXgU9uOUqXXhxwgIbOy0F0tNhyjkopxfqHAns6pQNdJodY9fT78
 RA8ndUwi2O49BAJ3LkJ/W6ljVboFWEvwscT/ezN9keiOrQ/GY/WjLNrUPSYfrWDnx4AF
 nISQ==
X-Gm-Message-State: ANhLgQ3aT/zinBGflxzuwthq9tD9Nn/lOV8OCbLbNA2+w5N/M+AAKxt9
 VcldMWJToPouvzJ8JlwDW7eiKek6
X-Google-Smtp-Source: ADFU+vvAQsA7VFCG9kKV3yvvJkidPVqjOY/i/ULZqTUGZZySi5qxMy8dhN2c/MSc3VmcDaa+DyqxiQ==
X-Received: by 2002:aa7:8283:: with SMTP id s3mr4045573pfm.106.1584434657882; 
 Tue, 17 Mar 2020 01:44:17 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:1672:6342:3ccf:a5d:a11e:f77e])
 by smtp.gmail.com with ESMTPSA id e189sm2267209pfa.139.2020.03.17.01.43.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2020 01:44:17 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Tue, 17 Mar 2020 14:13:10 +0530
Message-Id: <20200317084310.12652-1-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200316100319.27935-6-jaskaransingh7654321@gmail.com>
References: <20200316100319.27935-6-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 17 Mar 2020 09:44:22 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Tue, 17 Mar 2020 09:44:20 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v2 05/26] parsing_cocci: visitor_ast: Add cases for
	ParenType/FunctionType
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

The order of the terms in ParenType require implementing a special
case for ParenType. This case handles only the following:

	<type> ( * id [ .* ] ) ( params )

i.e., a function pointer or an array of function pointers, and will fail
for any other cases. This is similar to the function used to print
ParenType in Pretty_print_c.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
Changes in v2:
-------------
- Change the "visitor_ast0" in patch subject to "visitor_ast"

 parsing_cocci/visitor_ast.ml | 75 ++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/parsing_cocci/visitor_ast.ml b/parsing_cocci/visitor_ast.ml
index 3d5de794..99af7652 100644
--- a/parsing_cocci/visitor_ast.ml
+++ b/parsing_cocci/visitor_ast.ml
@@ -318,6 +318,61 @@ let combiner bind option_default
     let lrb = string_mcode rb in
     multibind ([lty] @ lid @ [lb; lsize; lrb])
 
+  and parentype_type (lp, ty, (id : Ast.ident option), rp) =
+    match Ast.unwrap ty with
+     Ast.Type(_,_,fty1) ->
+      (match Ast.unwrap fty1 with
+         Ast.Pointer(ty1,star) ->
+          (match Ast.unwrap ty1 with
+             Ast.Type(_,_,fty2) ->
+              (match Ast.unwrap fty2 with
+                Ast.FunctionType(ty2,lp2,params,rp2) ->
+                  let typ = fullType ty2 in
+                  let lp = string_mcode lp in
+                  let star = string_mcode star in
+                  let idl = match id with
+                    | Some idd -> [ident idd]
+                    | None -> [] in
+                  let rp = string_mcode rp in
+                  let lp2 = string_mcode lp2 in
+                  let params = parameter_dots params in
+                  let rp2 = string_mcode rp2 in
+                  multibind
+                    ([typ;lp;star] @ idl @ [rp;lp2;params;rp2])
+                | _ -> failwith "ParenType Visitor_ast")
+           | _ -> failwith "ParenType Visitor_ast")
+       | Ast.Array(ty1,lb1,size1,rb1) ->
+          (match Ast.unwrap ty1 with
+            Ast.Type(_,_,fty2) ->
+             (match Ast.unwrap fty2 with
+               Ast.Pointer(ty2,star) ->
+                (match Ast.unwrap ty2 with
+                  Ast.Type(_,_,fty3) ->
+                   (match Ast.unwrap fty3 with
+                     Ast.FunctionType(ty3,lp3,params,rp3) ->
+                     let typ = fullType ty3 in
+                     let lp = string_mcode lp in
+                     let star = string_mcode star in
+                     let idl = match id with
+                       | Some idd -> [ident idd]
+                       | None -> [] in
+                     let lb1 = string_mcode lb1 in
+                     let size1 = get_option expression size1 in
+                     let rb1 = string_mcode rb1 in
+                     let rp = string_mcode rp in
+                     let lp3 = string_mcode lp3 in
+                     let params = parameter_dots params in
+                     let rp3 = string_mcode rp3 in
+                     multibind
+                       ([typ;lp;star] @ idl @
+                        [lb1;size1;rb1;rp;lp3;params;rp3])
+   	           | _ -> failwith "ParenType Visitor_ast")
+                | _ -> failwith "ParenType Visitor_ast")
+             | _ -> failwith "ParenType Visitor_ast")
+          | _ -> failwith "ParenType Visitor_ast")
+       | _ -> failwith "ParenType Visitor_ast")
+    | _ -> failwith "ParenType Visitor_ast"
+
   and typeC ty =
     let k ty =
       match Ast.unwrap ty with
@@ -332,6 +387,14 @@ let combiner bind option_default
 	  bind lty lstar
       | Ast.FunctionPointer(ty,lp1,star,rp1,lp2,params,rp2) ->
 	  function_pointer (ty,lp1,star,None,rp1,lp2,params,rp2)
+      | Ast.ParenType(lp,ty,rp) ->
+          parentype_type (lp,ty,None,rp)
+      | Ast.FunctionType(ty,lp,params,rp) ->
+          let lty = fullType ty in
+          let llp = string_mcode lp in
+          let lparams = parameter_dots params in
+          let lrp = string_mcode rp in
+          multibind [lty; llp; lparams; lrp]
       | Ast.Array(ty,lb,size,rb) -> array_type (ty,None,lb,size,rb)
       | Ast.Decimal(dec,lp,length,comma,precision_opt,rp) ->
 	  let ldec = string_mcode dec in
@@ -384,6 +447,7 @@ let combiner bind option_default
 	  Ast.FunctionPointer(ty,lp1,star,rp1,lp2,params,rp2) ->
 	    function_pointer (ty, lp1, star, Some id, rp1, lp2, params, rp2)
 	| Ast.Array(ty,lb,size,rb) -> array_type (ty, Some id, lb, size, rb)
+        | Ast.ParenType(lp,ty,rp) -> parentype_type (lp, ty, Some id, rp)
 	| _ -> let lty = fullType ty in
 	       let lid = ident id in
 	       bind lty lid)
@@ -1253,6 +1317,17 @@ let rebuilder
 	    let lparams = parameter_dots params in
 	    let lrp2 = string_mcode rp2 in
 	    Ast.FunctionPointer(lty, llp1, lstar, lrp1, llp2, lparams, lrp2)
+        | Ast.ParenType(lp,ty,rp) ->
+            let llp = string_mcode lp in
+            let lty = fullType ty in
+            let lrp = string_mcode rp in
+            Ast.ParenType(llp,lty,lrp)
+        | Ast.FunctionType(ty,lp,params,rp) ->
+            let lty = fullType ty in
+            let llp = string_mcode lp in
+            let lparams = parameter_dots params in
+            let lrp = string_mcode rp in
+            Ast.FunctionType(lty,llp,lparams,lrp)
 	| Ast.Array(ty,lb,size,rb) ->
 	    let lty = fullType ty in
 	    let llb = string_mcode lb in
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
