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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CD3C4332D
	for <cocci@archiver.kernel.org>; Fri, 20 Mar 2020 07:03:44 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 629FD20774
	for <cocci@archiver.kernel.org>; Fri, 20 Mar 2020 07:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dap1DcRa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 629FD20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02K73XhV020067;
	Fri, 20 Mar 2020 08:03:33 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A7927780E;
	Fri, 20 Mar 2020 08:03:33 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id D93ED3B93
 for <cocci@systeme.lip6.fr>; Fri, 20 Mar 2020 08:03:32 +0100 (CET)
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1041])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02K73VKl013563
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 20 Mar 2020 08:03:32 +0100 (CET)
Received: by mail-pj1-x1041.google.com with SMTP id v13so2072578pjb.0
 for <cocci@systeme.lip6.fr>; Fri, 20 Mar 2020 00:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=m2efzd5IZRl0b0Z89qpMcgnyNMT8Z6sNaXDMpfksIfQ=;
 b=Dap1DcRaANmR5V5iQdY+kYI5aorAHAg/wtiKDaaaAwZLm8lWHqyPNjdildC6b/iiZ7
 eDvINVZNZukfa2qV2dvTnbzpNQDEJkLsX08/1j8dUTMivBtXCm7pRZrYo/q/zV8XRDiU
 hty2vVO4KOLPMZauREEXiIhefTRQjg327TdLtMIDexwOP/07+MwMhksQ9pPNBwS0ahn8
 W0s3gbaMWtP0ohDj7yh/sNGH3+lKU/y5o8FUPfpoCdakn6sVMVKgK2XXGmaJTj8/v7ko
 +tUbqk5Y8/rxeztzlvjC5QPSVDwWInzGOzfUzWeXTZXoGKRplm6FAcyanYBRejaG4vRG
 VSpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=m2efzd5IZRl0b0Z89qpMcgnyNMT8Z6sNaXDMpfksIfQ=;
 b=K4pKTRPacbtCs9a43d72nYt3OwxOEZSF6FiJBR1h2ZEXZNSOUJ7+InI+pj4xEvEweV
 qSxwwBbeuuBwANoDmksSocKZLZvz7CTwAdZlGOXd6EW3pC+5iTlEthkM/3ZysshVBYTv
 buXKZdAlhNpp9j5Rn3VJOp3YhlsddUA8YIXjSzIO0A/xPQsLHy6vXQSq86mQeSGshX76
 PyqcXSFYQh8TrNB8ENNV+xFQ/jGY5XIVyOAc9tnfxeT1zTPfhgXywcLsNgUwTNewxY9G
 Di4NrxkZrqqmgAbKCvBoKvdpgLo2YdMVBAgegAB8FLvkAT80qzIxG5rQvYwM0nfGvDKa
 mO3w==
X-Gm-Message-State: ANhLgQ0y2quCr0Arr5+RhQC1EqZyXm/UZx91yyKU7lhA4t7riSwWIy5L
 WxYA2NQUOLfQ/b7VcL4/wTEEFOK/
X-Google-Smtp-Source: ADFU+vsYGWlDAP47bxMdGxZx7YzKb4jCJX1sVr4zXcUVMru9HrxEYzDbwcoLkxuHEgPhXhC7lK8jhg==
X-Received: by 2002:a17:90a:cf96:: with SMTP id
 i22mr8181121pju.66.1584687810292; 
 Fri, 20 Mar 2020 00:03:30 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:2190:a751:deeb:c09d:833a:659d])
 by smtp.gmail.com with ESMTPSA id l11sm3941232pjy.44.2020.03.20.00.03.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2020 00:03:29 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri, 20 Mar 2020 12:31:52 +0530
Message-Id: <20200320070157.4206-22-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200320070157.4206-1-jaskaransingh7654321@gmail.com>
References: <20200320070157.4206-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 20 Mar 2020 08:03:33 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 20 Mar 2020 08:03:32 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v3 21/26] parsing_cocci: pretty_print_cocci: Print
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
 parsing_cocci/pretty_print_cocci.ml | 50 +++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/parsing_cocci/pretty_print_cocci.ml b/parsing_cocci/pretty_print_cocci.ml
index 6338e464..8055ba3b 100644
--- a/parsing_cocci/pretty_print_cocci.ml
+++ b/parsing_cocci/pretty_print_cocci.ml
@@ -403,6 +403,47 @@ and print_function_pointer (ty,lp1,star,rp1,lp2,params,rp2) fn =
   mcode print_string rp1; mcode print_string lp1;
   parameter_list params; mcode print_string rp2
 
+and print_parentype (lp,ty,rp) fn =
+  let function_pointer ty1 array_dec =
+    match Ast.unwrap ty1 with
+     Ast.Type(_,_,fty1) ->
+      (match Ast.unwrap fty1 with
+        Ast.Pointer(ty2,star) ->
+         (match Ast.unwrap ty2 with
+           Ast.Type(_,_,fty3) ->
+            (match Ast.unwrap fty3 with
+              Ast.FunctionType(ty3,lp3,params,rp3) ->
+               fullType ty3;
+               print_space();
+               mcode print_string lp;
+               mcode print_string star;
+               fn();
+               let _ =
+                 match array_dec with
+                   Some(lb1,size,rb1) ->
+                      mcode print_string lb1;
+                      print_option expression size;
+                      mcode print_string rb1
+                 | None -> () in
+               mcode print_string rp;
+               mcode print_string lp3;
+               parameter_list params;
+               mcode print_string rp3
+           | _ -> failwith "ParenType Pretty_print_cocci")
+         | _ -> failwith "ParenType Pretty_print_cocci")
+       | _ -> failwith "ParenType Pretty_print_cocci")
+     | _ -> failwith "ParenType Pretty_print_cocci" in
+  match Ast.unwrap ty with
+    Ast.Type(_,_,fty1) ->
+      (match Ast.unwrap fty1 with
+        Ast.Array(ty1,lb1,size,rb1) ->
+          function_pointer ty1 (Some(lb1,size,rb1))
+      | Ast.Pointer(ty1,star) ->
+          function_pointer ty None
+      | _ -> failwith "ParenType Pretty_print_cocci")
+   | _ -> failwith "ParenType Pretty_print_cocci"
+
+
 and varargs = function
   | None -> ()
   | Some (comma, ellipsis) ->
@@ -424,6 +465,13 @@ and typeC ty =
   | Ast.FunctionPointer(ty,lp1,star,rp1,lp2,params,rp2) ->
       print_function_pointer (ty,lp1,star,rp1,lp2,params,rp2)
 	(function _ -> ())
+  | Ast.ParenType(lp,ty,rp) ->
+      print_parentype (lp,ty,rp) (function _ -> ())
+  | Ast.FunctionType(ty,lp,params,rp) ->
+      fullType ty;
+      mcode print_string lp;
+      parameter_list params;
+      mcode print_string rp
   | Ast.Array(ty,lb,size,rb) ->
       fullType ty; mcode print_string lb; print_option expression size;
       mcode print_string rb
@@ -498,6 +546,8 @@ and print_named_type ty id =
 		| _ -> failwith "complex array types not supported")
 	    | _ -> typeC ty; id(); k () in
 	  loop ty1 (function _ -> ())
+      | Ast.ParenType(lp,ty,rp) ->
+          print_parentype (lp,ty,rp) (function _ -> id())
       | _ -> fullType ty; id())
   | _ -> fullType ty; id()
 
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
