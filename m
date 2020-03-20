Return-Path: <SRS0=15MF=5F=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70766C4332B
	for <cocci@archiver.kernel.org>; Fri, 20 Mar 2020 07:02:51 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E010D20775
	for <cocci@archiver.kernel.org>; Fri, 20 Mar 2020 07:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oOWdiVbk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E010D20775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02K72bZr013177;
	Fri, 20 Mar 2020 08:02:37 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 87475780E;
	Fri, 20 Mar 2020 08:02:37 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 893413B93
 for <cocci@systeme.lip6.fr>; Fri, 20 Mar 2020 08:02:35 +0100 (CET)
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:642])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02K72XsJ000126
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 20 Mar 2020 08:02:34 +0100 (CET)
Received: by mail-pl1-x642.google.com with SMTP id t16so2100995plr.8
 for <cocci@systeme.lip6.fr>; Fri, 20 Mar 2020 00:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9INiUzByyCqI0paXu0A4FAHZ1W7BiT8Ci43ZLU3pjuM=;
 b=oOWdiVbkFdGSu26UfKnhHx5VQZ6hRTdc5XJX21lfhihzlMAWwCaIo6NiTKpN5NO/AT
 7RfGQKaG5ISEhjf8sHwYkNoeB3qkfg30qcseJ7GznLFzLaqWBlJIsTuuEeVCFx0PkqGq
 dTDBUidM6CmfFALcsjWSNq+hBSHnLdELTHP239wioL9OPU5MNoCWIcNkQp01nxwzoPdY
 8jd6iptCrsuB0GJHYQADf3IUg0UU3NxjZyQWW8ZufPS+X8y3vW83urHH4OlFe9TC24y4
 Vnt9LFSsYQhW9cSDaWf1TDZTUccPyAgAGYPFdtrDfGpJVMcCXspm5CXkTVBbaEuK0H6y
 WLlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9INiUzByyCqI0paXu0A4FAHZ1W7BiT8Ci43ZLU3pjuM=;
 b=TT/9FpZjrUpIdDan3pvI7qHDoXRpuTN8UirZWOJhq4YAOz558CU+MIGyxEvBQWdWhb
 zOqPrYVQSCqMcuasGdsjyK11Kwqylr/UlL7DywTKuW17gVZ3XIwbLDPIBcZBTE5gi4nV
 h66tHFhFhTM0efujfU7EUNfjLAALQcweH3aJ/qh12a/ZJZ6+VdAvCg66X+FwL/XnfAQ5
 bGu8HutDieoRahIv8/hFNMG1KbKYdXoLg3f1FJ9Bu2M2b2HpvebiEU6yPPSbZhElezcu
 8ENLhjEdYBUEyfM6ol/KV+NIzDJpv6A4MUXBjKXeHfdVRp0vzOVX9LuqLxOJ/fVK3iGk
 lVHg==
X-Gm-Message-State: ANhLgQ1vw1GFDW1Kpu6d6AyHDPBbPS0SovpRMiJw3Omumb4jErw2k/sT
 4qQzi9WA7OlSFxQc1yNywQCyPcrc
X-Google-Smtp-Source: ADFU+vu59u1ZYMqMFuGruHz6M//Sj6wC7n6mAyKKeYF8lGTJnEUIsMSdhZibCCTETRq33ueOAHt3ow==
X-Received: by 2002:a17:902:61:: with SMTP id 88mr7286967pla.17.1584687752407; 
 Fri, 20 Mar 2020 00:02:32 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:2190:a751:deeb:c09d:833a:659d])
 by smtp.gmail.com with ESMTPSA id l11sm3941232pjy.44.2020.03.20.00.02.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2020 00:02:31 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri, 20 Mar 2020 12:31:36 +0530
Message-Id: <20200320070157.4206-6-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200320070157.4206-1-jaskaransingh7654321@gmail.com>
References: <20200320070157.4206-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 20 Mar 2020 08:02:37 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 20 Mar 2020 08:02:34 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v3 05/26] parsing_cocci: visitor_ast: Add cases for
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
 parsing_cocci/visitor_ast.ml | 66 ++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/parsing_cocci/visitor_ast.ml b/parsing_cocci/visitor_ast.ml
index 3d5de794..6f2e3dab 100644
--- a/parsing_cocci/visitor_ast.ml
+++ b/parsing_cocci/visitor_ast.ml
@@ -318,6 +318,52 @@ let combiner bind option_default
     let lrb = string_mcode rb in
     multibind ([lty] @ lid @ [lb; lsize; lrb])
 
+  and parentype_type (lp,ty,(id : Ast.ident option),rp) =
+    let function_pointer ty1 array_dec =
+      match Ast.unwrap ty1 with
+       Ast.Type(_,_,fty1) ->
+        (match Ast.unwrap fty1 with
+          Ast.Pointer(ty2,star) ->
+           (match Ast.unwrap ty2 with
+             Ast.Type(_,_,fty3) ->
+              (match Ast.unwrap fty3 with
+                Ast.FunctionType(ty3,lp3,params,rp3) ->
+                 let ltyp = fullType ty3 in
+                 let llp = string_mcode lp in
+                 let lstar = string_mcode star in
+                 let lid =
+                   match id with
+                     Some idd -> [ident idd]
+                   | None -> [] in
+                 let larray =
+                   match array_dec with
+                     Some(lb1,size1,rb1) ->
+                       let llb1 = string_mcode lb1 in
+                       let lsize1 = get_option expression size1 in
+                       let lrb1 = string_mcode rb1 in
+                       [llb1;lsize1;lrb1]
+                   | None -> [] in
+                 let lrp = string_mcode rp in
+                 let llp3 = string_mcode lp3 in
+                 let lparams = parameter_dots params in
+                 let lrp3 = string_mcode rp3 in
+                 multibind
+                   ([ltyp;llp;lstar] @ lid @ larray @
+                    [lrp;llp3;lparams;lrp3])
+             | _ -> failwith "ParenType Visitor_ast")
+           | _ -> failwith "ParenType Visitor_ast")
+         | _ -> failwith "ParenType Visitor_ast")
+       | _ -> failwith "ParenType Visitor_ast" in
+    match Ast.unwrap ty with
+      Ast.Type(_,_,fty1) ->
+        (match Ast.unwrap fty1 with
+          Ast.Array(ty1,lb1,size,rb1) ->
+            function_pointer ty1 (Some(lb1,size,rb1))
+        | Ast.Pointer(ty1,star) ->
+            function_pointer ty None
+        | _ -> failwith "ParenType Visitor_ast")
+     | _ -> failwith "ParenType Visitor_ast"
+
   and typeC ty =
     let k ty =
       match Ast.unwrap ty with
@@ -332,6 +378,14 @@ let combiner bind option_default
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
@@ -384,6 +438,7 @@ let combiner bind option_default
 	  Ast.FunctionPointer(ty,lp1,star,rp1,lp2,params,rp2) ->
 	    function_pointer (ty, lp1, star, Some id, rp1, lp2, params, rp2)
 	| Ast.Array(ty,lb,size,rb) -> array_type (ty, Some id, lb, size, rb)
+        | Ast.ParenType(lp,ty,rp) -> parentype_type (lp, ty, Some id, rp)
 	| _ -> let lty = fullType ty in
 	       let lid = ident id in
 	       bind lty lid)
@@ -1253,6 +1308,17 @@ let rebuilder
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
