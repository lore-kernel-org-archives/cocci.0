Return-Path: <SRS0=+m3J=5B=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5079BC2BB1D
	for <cocci@archiver.kernel.org>; Mon, 16 Mar 2020 10:04:17 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF6B620663
	for <cocci@archiver.kernel.org>; Mon, 16 Mar 2020 10:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gj+1dwRK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF6B620663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02GA45fj006519;
	Mon, 16 Mar 2020 11:04:05 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 597DA7809;
	Mon, 16 Mar 2020 11:04:05 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id C3EF97802
 for <cocci@systeme.lip6.fr>; Mon, 16 Mar 2020 11:04:03 +0100 (CET)
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:441])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02GA42qH015247
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 16 Mar 2020 11:04:02 +0100 (CET)
Received: by mail-pf1-x441.google.com with SMTP id c144so9635731pfb.10
 for <cocci@systeme.lip6.fr>; Mon, 16 Mar 2020 03:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6sjOqxS7d54zf4aLI3lcmfbO7ppNxNf6CCvjF5yxP4Q=;
 b=Gj+1dwRKHSqYsHJ6qD2LMhpUfq8+VNT4DbunAzafEnGjUNGD4YiRhYCbEzNeW/SCUG
 yo5MPZKGvFPZZdL5nzkEacEX9AILH1LyvCEUsoN8eblIJkQmL+WExwj/+fyMEvyC0j5q
 UxPCGmNEioa8Inm1i9xTcx1/iNCEyFt/Av5OG1ROWO0Fu+SktR3riwUTJN2cC+OBYpIr
 7KDRoibooXzUbogD1QW48xtnUJ+ZvlTCFoL6IK07k9dmFXybYD4BFrbUS8+cX0xFNNEW
 g6zI02368rzhRxxwX3HzEd6o/vkDFhRmrtjcw0Uskk3qan3UtEFz1W0KTDNEGN2kRUrz
 /ZzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6sjOqxS7d54zf4aLI3lcmfbO7ppNxNf6CCvjF5yxP4Q=;
 b=EmC15ySdioTcLLwvaVSZwIeF0by/0AhWsUJ1oLgdcWGzubNs8B5x0XdeDw1uWcbDi9
 K6Nz0QyRP3u3fd6UmemkE2OgQFg8p4Mz/W4v8tdjc7ygDlYBl3TvoAVn3FYfVNOeArFH
 +Q2CWp6WBEE+EnWZy5t2A3ivJhjZZbCkUJIMY9nlKhc4E7El9kLBdMPXTV5biB142CXk
 l/GcX7S/VkCwle1Ek+3e3/xm+cAxKi/ZABny3EfBNWYImg7NF1F22L5YxB4hnuuA6LCs
 cht3fxZv+2Ml/RtLmilZs3ega/zbicrGcr/lTZhtp0ukRPxYHI7ZaamexUpStGY5n3fI
 mlSA==
X-Gm-Message-State: ANhLgQ2NOOVgyl6CGVqvJEG1I55nzoTJJeupkmaF1mGnGd4rkUZfCJ+c
 IeGZOzqkbF7Z75NGM2uMDOE51Pf1
X-Google-Smtp-Source: ADFU+vuAflvs79Tr+OyPNdCnqOcqcdiiq+FqzfdMDbOgDUnB3Dtqjr4ZM1o2QzMBaijMtmHxoKzY2g==
X-Received: by 2002:a63:27c5:: with SMTP id n188mr9244527pgn.345.1584353041238; 
 Mon, 16 Mar 2020 03:04:01 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:284:a4f2:cc63:b7fc:551c:dce5])
 by smtp.gmail.com with ESMTPSA id
 u3sm19803374pjv.32.2020.03.16.03.03.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 03:04:00 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 16 Mar 2020 15:33:02 +0530
Message-Id: <20200316100319.27935-10-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200316100319.27935-1-jaskaransingh7654321@gmail.com>
References: <20200316100319.27935-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 16 Mar 2020 11:04:05 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 16 Mar 2020 11:04:03 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 09/26] parsing_cocci: unparse_ast0: Add cases for
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

ParenType/FunctionType are now types in the SmPL ASTs. Add
cases for these types in unparse_ast0.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/unparse_ast0.ml | 43 +++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/parsing_cocci/unparse_ast0.ml b/parsing_cocci/unparse_ast0.ml
index 5d450e0e..f8684dd2 100644
--- a/parsing_cocci/unparse_ast0.ml
+++ b/parsing_cocci/unparse_ast0.ml
@@ -292,6 +292,40 @@ and print_function_pointer (ty,lp1,star,rp1,lp2,params,rp2) fn =
   mcode print_string rp1; mcode print_string lp2;
   parameter_list params; mcode print_string rp2
 
+and print_parentype (lp,ty,rp) fn =
+ match Ast0.unwrap ty with
+   Ast0.Pointer(ty1,star) ->
+     (match Ast0.unwrap ty1 with
+       Ast0.FunctionType(ty2,lp2,params,rp2) ->
+         typeC ty2;
+         mcode print_string lp;
+         mcode print_string star;
+         fn();
+         mcode print_string rp;
+         mcode print_string lp2;
+         parameter_list params;
+         mcode print_string rp2;
+       | _ -> failwith "ParenType Unparse_ast0")
+ | Ast0.Array(ty1,lb1,size1,rb1) ->
+     (match Ast0.unwrap ty1 with
+       Ast0.Pointer(ty2,star) ->
+         (match Ast0.unwrap ty2 with
+           Ast0.FunctionType(ty3,lp3,params,rp3) ->
+             typeC ty3;
+             mcode print_string lp;
+             mcode print_string star;
+             fn();
+             mcode print_string lb1;
+             print_option expression size1;
+             mcode print_string rb1;
+             mcode print_string rp;
+             mcode print_string lp3;
+             parameter_list params;
+             mcode print_string rp3;
+ 	| _ -> failwith "ParenType Unparse_ast0")
+     | _ -> failwith "ParenType Unparse_ast0")
+ | _ -> failwith "ParenType Unparse_ast0"
+
 and typeC t =
   print_context t
     (function _ ->
@@ -306,6 +340,13 @@ and typeC t =
       | Ast0.FunctionPointer(ty,lp1,star,rp1,lp2,params,rp2) ->
 	  print_function_pointer (ty,lp1,star,rp1,lp2,params,rp2)
 	    (function _ -> ())
+      | Ast0.ParenType(lp,ty,rp) ->
+          print_parentype (lp,ty,rp) (function _ -> ())
+      | Ast0.FunctionType(ty,lp,params,rp) ->
+          typeC ty;
+          mcode print_string lp;
+          parameter_list params;
+          mcode print_string rp
       | Ast0.Array(ty,lb,size,rb) ->
 	  typeC ty; mcode print_string lb; print_option expression size;
 	  mcode print_string rb
@@ -367,6 +408,8 @@ and print_named_type ty id =
 		mcode print_string rb)
 	| _ -> typeC ty; ident id; k () in
       loop ty (function _ -> ())
+  | Ast0.ParenType(lp,ty,rp) ->
+      print_parentype (lp,ty,rp) (function _ -> ident id)
   | _ -> typeC ty; ident id
 
 and declaration d =
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
