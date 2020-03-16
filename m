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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43AC0C18E5B
	for <cocci@archiver.kernel.org>; Mon, 16 Mar 2020 10:04:13 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94AED2051A
	for <cocci@archiver.kernel.org>; Mon, 16 Mar 2020 10:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BX2FZIw1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94AED2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02GA3mEq017535;
	Mon, 16 Mar 2020 11:03:54 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 7DF607802;
	Mon, 16 Mar 2020 11:03:54 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 0042E7809
 for <cocci@systeme.lip6.fr>; Mon, 16 Mar 2020 11:03:53 +0100 (CET)
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:543])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02GA3krP011138
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 16 Mar 2020 11:03:47 +0100 (CET)
Received: by mail-pg1-x543.google.com with SMTP id 7so9471730pgr.2
 for <cocci@systeme.lip6.fr>; Mon, 16 Mar 2020 03:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=so2jJuxsUbe7bFw/ZHcXeCSOvtnxUQw4U4/ZWa5QNnI=;
 b=BX2FZIw1jLDHl3RJXXnnTiRqtirELvNnZFq8LxZBxm/6Rg8YbKvxbsIalacvAVULgs
 PJi+BvuJxrqOHpYhMwnkgy6E9vKlyqOD26Ejlg5RUB2dq5KLE2dGIi5jfktkGhrJV1uM
 lSkywAWCMEqqGCELhrAGPmNe5drDi78YeSdI/f/iV43/80uF7Z+O4ohcWZKXuTMVneGK
 2pjufT/exmB6PDtv4RfX0SbBMEXsCiNMtGg/JUpAoN325tZqDfpcS7QXR22brBLRvR7k
 RUOESXqBL4bp55cVFAwb91lNuXgPLgfuOCXk9N+CdSu5us3fk4r7reUlMq2nPOma/zSf
 CONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=so2jJuxsUbe7bFw/ZHcXeCSOvtnxUQw4U4/ZWa5QNnI=;
 b=ByHOnT6TmJbuqB0gfyXMjJQksmlCtHnsrHBue9kF1oBA0DcvCG6da86N3+adc0rzAB
 0NqAA6+xB6NkJLCvsdiLMxAfunZt4m1Zi7YHojY1yp+3lXG3cYs8aSvkDSmSfn/x5Y9s
 aWCj0axpHpFT6i5zIAuguMK9egejTJG4Jnvt7frWTg1H/A9dkpNZPizlmxiYrxq83kQ1
 yujKRz9RNYVMiqoFZWHakLkgG3R1Xze5RuNRSzBdTFx3+YhSjay+pMF+sC2mrzFbKkSV
 w8tFa3EMBJUBOeA70DZcAuhFGtvEWWb+R4YOKTMDpbZnLHTpWeBax3uDTTlb2btrJeep
 TjEQ==
X-Gm-Message-State: ANhLgQ3TQZeFey9w7/Nqw4OC2Hfp99uXhs9z7u9n5Flp1qENCAo9feU9
 rvrv6pH7VHKgTyffiJ3sAADDHefV
X-Google-Smtp-Source: ADFU+vs47Vh+Legb/ydDVkLzEn3qt0Vo5K3w405gIKl/mIaNLWyDtuo+DyhOsp82ac5/62ywoNIKEw==
X-Received: by 2002:a63:f450:: with SMTP id p16mr26969901pgk.211.1584353026045; 
 Mon, 16 Mar 2020 03:03:46 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:284:a4f2:cc63:b7fc:551c:dce5])
 by smtp.gmail.com with ESMTPSA id
 u3sm19803374pjv.32.2020.03.16.03.03.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 03:03:45 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 16 Mar 2020 15:32:57 +0530
Message-Id: <20200316100319.27935-5-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200316100319.27935-1-jaskaransingh7654321@gmail.com>
References: <20200316100319.27935-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 16 Mar 2020 11:03:54 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 16 Mar 2020 11:03:48 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 04/26] parsing_cocci: visitor_ast0: Add cases for
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
 parsing_cocci/visitor_ast0.ml | 163 ++++++++++++++++++++++++++++++++++
 1 file changed, 163 insertions(+)

diff --git a/parsing_cocci/visitor_ast0.ml b/parsing_cocci/visitor_ast0.ml
index c282e1f8..c56cd7a7 100644
--- a/parsing_cocci/visitor_ast0.ml
+++ b/parsing_cocci/visitor_ast0.ml
@@ -339,6 +339,12 @@ let visitor mode bind option_default
 	| Ast0.FunctionPointer(ty,lp1,star,rp1,lp2,params,rp2) ->
 	    let (t,id) =
               function_pointer (ty,lp1,star,None,rp1,lp2,params,rp2) in t
+        | Ast0.ParenType(lp,ty,rp) ->
+	    let (t,id) =
+              parentype_type (lp,ty,None,rp) in t
+        | Ast0.FunctionType(ty,lp,params,rp) ->
+	    let (t,id) =
+              functiontype_type (ty,None,lp,params,rp) in t
 	| Ast0.Array(ty,lb,size,rb) ->
             let (t,id) = array_type (ty,None,lb,size,rb) in t
 	| Ast0.Decimal(dec,lp,length,comma,precision_opt,rp) ->
@@ -435,6 +441,76 @@ let visitor mode bind option_default
     ((multibind ([ty_n] @ idl @ [lb_n;size_n;rb_n]),
      Ast0.Array(ty,lb,size,rb)), idu)
 
+  and parentype_type (lp,ty,(id : Ast0.ident option),rp) =
+    match Ast0.unwrap ty with
+      Ast0.Pointer(ty1,star) ->
+        (match Ast0.unwrap ty1 with
+          Ast0.FunctionType(ty2,lp2,params,rp2) ->
+            let (ty_n,typ) = typeC ty2 in
+            let (lp_n,lp) = string_mcode lp in
+            let (star_n,star) = string_mcode star in
+            let (idl,idu) = (match id with
+              | Some a -> let (b,c) = ident a in ([b],Some c)
+              | None -> ([],None)) in
+            let (rp_n,rp) = string_mcode rp in
+            let (lp2_n,lp2) = string_mcode lp2 in
+            let (params_n,params) = parameter_dots params in
+            let (rp2_n,rp2) = string_mcode rp2 in
+            ((multibind ([ty_n;lp_n;star_n] @ idl @
+              [rp_n;lp2_n;params_n;rp2_n]),
+               Ast0.ParenType
+                 (lp,
+                  Ast0.rewrap ty1 (Ast0.Pointer
+                   (Ast0.rewrap ty2 (Ast0.FunctionType
+                     (typ,lp2,params,rp2)),star)),rp)), idu)
+	| _ -> failwith "ParenType Visitor_ast0")
+    | Ast0.Array(ty1,lb1,size1,rb1) ->
+        (match Ast0.unwrap ty1 with
+          Ast0.Pointer(ty2,star) ->
+            (match Ast0.unwrap ty2 with
+              Ast0.FunctionType(ty3,lp3,params,rp3) ->
+                let (ty_n,typ) = typeC ty3 in
+                let (lp_n,lp) = string_mcode lp in
+                let (star_n,star) = string_mcode star in
+                let (idl,idu) = (match id with
+                  | Some a -> let (b,c) = ident a in ([b],Some c)
+                  | None -> ([],None)) in
+                let (lb1_n,lb1) = string_mcode lb1 in
+                let (size_n,size1) = get_option expression size1 in
+                let (rb1_n,rb1) = string_mcode rb1 in
+                let (rp_n,rp) = string_mcode rp in
+                let (lp3_n,lp3) = string_mcode lp3 in
+                let (params_n,params) = parameter_dots params in
+                let (rp3_n,rp3) = string_mcode rp3 in
+                ((multibind ([ty_n;lp_n;star_n] @ idl @
+                  [lb1_n;size_n;rb1_n;rp_n;lp3_n;params_n;rp3_n]),
+                   Ast0.ParenType
+                     (lp,
+                      Ast0.rewrap ty1
+                       (Ast0.Array
+                         (Ast0.rewrap ty2
+                           (Ast0.Pointer
+                             (Ast0.rewrap ty3
+                               (Ast0.FunctionType(typ,lp3,params,rp3)),
+                              star)),
+                        lb1,size1,rb1)),
+                   rp)),
+                 idu)
+    	    | _ -> failwith "ParenType Visitor_ast0")
+        | _ -> failwith "ParenType Visitor_ast0")
+    | _ -> failwith "ParenType Visitor_ast0"
+
+  and functiontype_type (ty,(id : Ast0.ident option),lp,params,rp) =
+    let (ty_n,ty) = typeC ty in
+    let (idl,idu) = (match id with
+      | Some a -> let (b,c) = ident a in ([b],Some c)
+      | None -> ([],None)) in
+    let (lp_n,lp) = string_mcode lp in
+    let (params_n,params) = parameter_dots params in
+    let (rp_n,rp) = string_mcode rp in
+    ((multibind ([ty_n] @ idl @ [lp_n; params_n; rp_n]),
+     Ast0.FunctionType(ty,lp,params,rp)), idu)
+
   and named_type ty id =
     match Ast0.unwrap ty with
       Ast0.FunctionPointer(rty,lp1,star,rp1,lp2,params,rp2) ->
@@ -446,6 +522,14 @@ let visitor mode bind option_default
 	let (tyres, idn) = array_type (rty,Some id,lb,size,rb) in
         let idn = match idn with Some i -> i | None -> failwith "Impossible" in
 	(rewrap ty tyres, idn)
+    | Ast0.ParenType(lp,rty,rp) ->
+	let (tyres, idn) = parentype_type (lp,rty,Some id,rp) in
+        let idn = match idn with Some i -> i | None -> failwith "Impossible" in
+	(rewrap ty tyres, idn)
+    | Ast0.FunctionType(rty,lp,params,rp) ->
+	let (tyres, idn) = functiontype_type (rty,Some id,lp,params,rp) in
+        let idn = match idn with Some i -> i | None -> failwith "Impossible" in
+	(rewrap ty tyres, idn)
     | _ -> let (ty_n,ty) = typeC ty in
            let (id_n,id) = ident id in
              ((bind ty_n id_n, ty), id)
@@ -479,6 +563,77 @@ let visitor mode bind option_default
     ((multibind ([ty_n] @ idl @ [lb_n;size_n;rb_n]),
      Ast0.Array(ty,lb,size,rb)), idu)
 
+  (* returns ((bind value,original value),id) since id may have been updated*)
+  and parentype_typedef (lp,ty,id,rp) =
+    match Ast0.unwrap ty with
+      Ast0.Pointer(ty1,star) ->
+        (match Ast0.unwrap ty1 with
+          Ast0.FunctionType(ty2,lp2,params,rp2) ->
+            let (ty_n,typ) = typeC ty2 in
+            let (lp_n,lp) = string_mcode lp in
+            let (star_n,star) = string_mcode star in
+            let (idl,idu) = (match id with
+              | Some a -> let (b,c) = typeC a in ([b],Some c)
+              | None -> ([],None)) in
+            let (rp_n,rp) = string_mcode rp in
+            let (lp2_n,lp2) = string_mcode lp2 in
+            let (params_n,params) = parameter_dots params in
+            let (rp2_n,rp2) = string_mcode rp2 in
+            ((multibind ([ty_n;lp_n;star_n] @ idl @
+              [rp_n;lp2_n;params_n;rp2_n]),
+               Ast0.ParenType
+                 (lp,
+                  Ast0.rewrap ty1 (Ast0.Pointer
+                   (Ast0.rewrap ty2 (Ast0.FunctionType
+                     (typ,lp2,params,rp2)),star)),rp)), idu)
+	| _ -> failwith "ParenType Visitor_ast0")
+    | Ast0.Array(ty1,lb1,size1,rb1) ->
+        (match Ast0.unwrap ty with
+          Ast0.Pointer(ty2,star) ->
+            (match Ast0.unwrap ty1 with
+              Ast0.FunctionType(ty3,lp3,params,rp3) ->
+                let (ty_n,typ) = typeC ty3 in
+                let (lp_n,lp) = string_mcode lp in
+                let (star_n,star) = string_mcode star in
+                let (idl,idu) = (match id with
+                  | Some a -> let (b,c) = typeC a in ([b],Some c)
+                  | None -> ([],None)) in
+                let (lb1_n,lb1) = string_mcode lb1 in
+                let (size_n,size1) = get_option expression size1 in
+                let (rb1_n,rb1) = string_mcode rb1 in
+                let (rp_n,rp) = string_mcode rp in
+                let (lp3_n,lp3) = string_mcode lp3 in
+                let (params_n,params) = parameter_dots params in
+                let (rp3_n,rp3) = string_mcode rp3 in
+                ((multibind ([ty_n;lp_n;star_n] @ idl @
+                  [lb1_n;size_n;rb1_n;rp_n;lp3_n;params_n;rp3_n]),
+                   Ast0.ParenType
+                     (lp,
+                      Ast0.rewrap ty1
+                       (Ast0.Array
+                         (Ast0.rewrap ty2 
+                           (Ast0.Pointer
+                             (Ast0.rewrap ty3
+                               (Ast0.FunctionType(typ,lp3,params,rp3)),
+                              star)),
+                        lb1,size1,rb1)),
+                   rp)),
+                 idu)
+    	    | _ -> failwith "ParenType Visitor_ast0")
+        | _ -> failwith "ParenType Visitor_ast0")
+    | _ -> failwith "ParenType Visitor_ast0"
+
+  and functiontype_typedef (ty,id,lp,params,rp) =
+    let (ty_n,ty) = typeC ty in
+    let (idl,idu) = (match id with
+      | Some a -> let (b,c) = typeC a in ([b],Some c)
+      | None -> ([],None)) in
+    let (lp_n,lp) = string_mcode lp in
+    let (params_n,params) = parameter_dots params in
+    let (rp_n,rp) = string_mcode rp in
+    ((multibind ([ty_n] @ idl @ [lp_n; params_n; rp_n]),
+     Ast0.FunctionType(ty,lp,params,rp)), idu)
+
   and named_type_typedef ty id =
     match Ast0.unwrap ty with
       Ast0.FunctionPointer(rty,lp1,star,rp1,lp2,params,rp2) ->
@@ -490,6 +645,14 @@ let visitor mode bind option_default
 	let (tyres, idn) = array_type_typedef (rty,Some id,lb,size,rb) in
         let idn = match idn with Some i -> i | None -> failwith "Impossible" in
 	(rewrap ty tyres, idn)
+    | Ast0.ParenType(lp,rty,rp) ->
+	let (tyres, idn) = parentype_typedef (lp,rty,Some id,rp) in
+        let idn = match idn with Some i -> i | None -> failwith "Impossible" in
+	(rewrap ty tyres, idn)
+    | Ast0.FunctionType(rty,lp,params,rp) ->
+	let (tyres, idn) = functiontype_typedef (rty,Some id,lp,params,rp) in
+        let idn = match idn with Some i -> i | None -> failwith "Impossible" in
+	(rewrap ty tyres, idn)
     | _ -> let (ty_n,ty) = typeC ty in
            let (id_n,id) = typeC id in
              ((bind ty_n id_n, ty), id)
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
