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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A14C18E5B
	for <cocci@archiver.kernel.org>; Mon, 16 Mar 2020 10:05:05 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D356520663
	for <cocci@archiver.kernel.org>; Mon, 16 Mar 2020 10:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ix1Md+nu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D356520663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02GA4sHm020069;
	Mon, 16 Mar 2020 11:04:54 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E4F137809;
	Mon, 16 Mar 2020 11:04:53 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 773E57802
 for <cocci@systeme.lip6.fr>; Mon, 16 Mar 2020 11:04:52 +0100 (CET)
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:542])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02GA4otf001704
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 16 Mar 2020 11:04:51 +0100 (CET)
Received: by mail-pg1-x542.google.com with SMTP id h8so9462584pgs.9
 for <cocci@systeme.lip6.fr>; Mon, 16 Mar 2020 03:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YP8chb4YLhUSAHVqKo/Ox5/Ns8GtQ+94RvYTwzBShIo=;
 b=Ix1Md+nuQOP1YawTkyWlECWZlfBG0qx9JMf1zcdeKjxqLXVtHbDBPHvsoz9w2LUYLf
 2ozGp8ZNMn9R9FVqxCPMsTvDr7gK+y6VlwF5vBxFJff4Zc1savPrXyOQPORAEaQA1SdY
 aH6SafgYgNo+UMmHf+JPkbpf8ogCQcImJk5WUdTVN60tJaqDYtIeQ/I7LeNIpGjj2KQy
 Vwh5jFvESx+jmH2ir16Et0yqjSJzJkY3pJjBJjgAkW54Ec3uUsIcJ2AzqeabZcXw651n
 v1XL30GnW9V/ACS69Kk1PHEjkPPHzud506Icx7oPN0JFogn7mKRvPd+/S8FxgcJiAW/a
 b01w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YP8chb4YLhUSAHVqKo/Ox5/Ns8GtQ+94RvYTwzBShIo=;
 b=MhxGfHxEIukKVuVv50SVwz3sRn7UoZvXHrsW4N41ZSUWfs8tGaaaBpKXsk7r/0cfiH
 YZ9dWmybwi0JUEvvWf6vzudmaF5JO583j8E5osMzORWs9VzAdmtskLQCXy6Tgb3aPUzn
 +aFWOZxprKio7tFZp0IFjkl8GFLJMwlYWQS1g00XmwX0aWa15WwI/iTGqi4ZA3iHMKmU
 O6zCmMJACX/OdhT1+6+8bkrPqYMcUB76xPaygLUXZ9F5WcKS8LAVzAi4f9jOp2h+3PUY
 il7gBfLz8yUCIZvWgfKjhFyo1aHFx7E6fjS+BZTiPkZK4JqqFIy3hyjfPFl5kcC+7Rzy
 F1fw==
X-Gm-Message-State: ANhLgQ1q3IQtAfWaClgHNOyKaZrfwGQsvH57rbSiQoKgiwAbb4NaTsmg
 7e1SodTci4oYiklsuELNXWCYvW7A
X-Google-Smtp-Source: ADFU+vs3I8j/KuwpO8HfIFEaD2vYElXsLusPl3AwSFvu5/WYzekgLVHLNml1pg5A6ZF6eUiZd+5WxA==
X-Received: by 2002:a62:382:: with SMTP id 124mr26700784pfd.11.1584353089877; 
 Mon, 16 Mar 2020 03:04:49 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:284:a4f2:cc63:b7fc:551c:dce5])
 by smtp.gmail.com with ESMTPSA id
 u3sm19803374pjv.32.2020.03.16.03.04.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 03:04:49 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 16 Mar 2020 15:33:15 +0530
Message-Id: <20200316100319.27935-23-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200316100319.27935-1-jaskaransingh7654321@gmail.com>
References: <20200316100319.27935-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 16 Mar 2020 11:04:54 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 16 Mar 2020 11:04:51 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 22/26] parsing_c: unparse_cocci: Print
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
 parsing_c/unparse_cocci.ml | 60 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/parsing_c/unparse_cocci.ml b/parsing_c/unparse_cocci.ml
index 30e755e9..9dd84821 100644
--- a/parsing_c/unparse_cocci.ml
+++ b/parsing_c/unparse_cocci.ml
@@ -722,6 +722,13 @@ and typeC ty =
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
@@ -786,6 +793,57 @@ and storage = function
   | Ast.Register -> print_string "register"
   | Ast.Extern -> print_string "extern"
 
+(* --------------------------------------------------------------------- *)
+(* ParenType *)
+
+and print_parentype (lp,ty,rp) fn =
+  match Ast.unwrap ty with
+   Ast.Type(_,_,fty1) ->
+    (match Ast.unwrap fty1 with
+      Ast.Pointer(ty1,star) ->
+       (match Ast.unwrap ty1 with
+         Ast.Type(_,_,fty2) ->
+          (match Ast.unwrap fty2 with
+            Ast.FunctionType(ty2,lp2,params,rp2) ->
+             fullType ty2;
+             pr_space();
+             mcode print_string lp;
+             mcode print_string star;
+             fn();
+             mcode print_string rp;
+             mcode print_string lp2;
+             parameter_list params;
+             mcode print_string rp2
+         | _ -> failwith "ParenType Unparse_cocci")
+       | _ -> failwith "ParenType Unparse_cocci")
+    | Ast.Array(ty1,lb1,size1,rb1) ->
+       (match Ast.unwrap ty1 with
+         Ast.Type(_,_,fty2) ->
+          (match Ast.unwrap fty2 with
+            Ast.Pointer(ty2,star) ->
+             (match Ast.unwrap ty2 with
+               Ast.Type(_,_,fty3) ->
+                (match Ast.unwrap fty3 with
+                  Ast.FunctionType(ty3,lp3,params,rp3) ->
+                  fullType ty3;
+                  pr_space();
+                  mcode print_string lp;
+                  mcode print_string star;
+                  fn();
+                  mcode print_string lb1;
+                  print_option expression size1;
+                  mcode print_string rb1;
+                  mcode print_string rp;
+                  mcode print_string lp3;
+                  parameter_list params;
+                  mcode print_string rp3
+                | _ -> failwith "ParenType Unparse_cocci")
+             | _ -> failwith "ParenType Unparse_cocci")
+          | _ -> failwith "ParenType Unparse_cocci")
+       | _ -> failwith "ParenType Unparse_cocci")
+    | _ -> failwith "ParenType Unparse_cocci")
+  | _ -> failwith "ParenType Unparse_cocci"
+
 (* --------------------------------------------------------------------- *)
 (* Variable declaration *)
 
@@ -818,6 +876,8 @@ and print_named_type ty id =
 		pretty_print_c.Pretty_print_c.type_with_ident ty
 		  (function _ -> id())
             | _ -> error name ty "type value expected")
+      | Ast.ParenType(lp,ty,rp) ->
+          print_parentype (lp,ty,rp) (function _ -> id())
     (*| should have a case here for pointer to array or function type
         that would put ( * ) around the variable.  This makes one wonder
         why we really need a special case for function pointer *)
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
