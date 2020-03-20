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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83309C4332D
	for <cocci@archiver.kernel.org>; Fri, 20 Mar 2020 07:03:01 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F196120774
	for <cocci@archiver.kernel.org>; Fri, 20 Mar 2020 07:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YoARcBd4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F196120774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02K72oKo009981;
	Fri, 20 Mar 2020 08:02:50 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 315FB780E;
	Fri, 20 Mar 2020 08:02:50 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 60E403B93
 for <cocci@systeme.lip6.fr>; Fri, 20 Mar 2020 08:02:48 +0100 (CET)
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1041])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02K72kDo009800
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 20 Mar 2020 08:02:47 +0100 (CET)
Received: by mail-pj1-x1041.google.com with SMTP id q16so3136010pje.1
 for <cocci@systeme.lip6.fr>; Fri, 20 Mar 2020 00:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hHQWLluwcRw7zGnfTxQ4FW/aOU4l5wA/J3oP9UErftM=;
 b=YoARcBd4x2AnDJa5fcow3Z4QWZom3XX4bjl4ddcL5E+dBxFhtDtf4iKpmE5jF5rFef
 OwdIu6QYDGMCyv3va2k57dVkbzYGLU3nQA1xitaS3yUAZ1TmPuQUbB+xdglVDfg4/VYK
 eFGrIwSLQjR5WfxBrXi7QnuVb3UTsYGTbjr6MdEVZ75EL1iIosXKu6W3evcAQny4dZJt
 tofXJtFOo3wADUvHVlXpzfn4jQ4d2mP12bFbS2RNNFEn3IutgfbY8eKjp8LLVn1iJsbN
 8g9PGY+gqQxq9zOBC3i8GnVbxlU2LCMuy61xyymcAIeh27hdfKhP1trWSZDd7tKrcfrX
 6U2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hHQWLluwcRw7zGnfTxQ4FW/aOU4l5wA/J3oP9UErftM=;
 b=unxNowdG7sQdhV9Mdimzxn3A65ieN3C+UDb5nBjjlru3veQHFMuo5lpxD8X5tqWjw0
 aezCnqmE53Z9Vi32hWo50fld/3li99asHWqT8lGGVrPip2n9qIP4uPyb3KvOgdAp8LJW
 KJV2Z37BswXjcZGdOSaTjRfD87KoZ0bI0XrWrCsYLyUmBq5HYzVa47pcUL770rVzTofv
 f0Aoc3VgKgbV3gjzqhv+wmd2SE4YnlV4PL8EuWix9V2dWBKvzlt4r/X7UwbVDijQU4Rg
 rFOnBQS+qMliBm7/ufLC5e/ZUL5s8lEC6O6Baw39loCS9ImdMdajooOwsxs3y5eh6saS
 0ZCQ==
X-Gm-Message-State: ANhLgQ3MpWoMa3M/igg5j3AVIz1ad5ZQK98s420hWQTZf/fclSw5kOu2
 fAzlebf4wvbpAbZqe7RX64sA0L6o
X-Google-Smtp-Source: ADFU+vtQFp2f9ypWs/oesIE2mMv38cOEKQoUkB0UeXbqvPnl2oup0ecOqof1K9z1/z7Fn62SGZTSOg==
X-Received: by 2002:a17:902:9f87:: with SMTP id
 g7mr7176306plq.32.1584687765795; 
 Fri, 20 Mar 2020 00:02:45 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:2190:a751:deeb:c09d:833a:659d])
 by smtp.gmail.com with ESMTPSA id l11sm3941232pjy.44.2020.03.20.00.02.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2020 00:02:45 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri, 20 Mar 2020 12:31:40 +0530
Message-Id: <20200320070157.4206-10-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200320070157.4206-1-jaskaransingh7654321@gmail.com>
References: <20200320070157.4206-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 20 Mar 2020 08:02:50 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 20 Mar 2020 08:02:47 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v3 09/26] parsing_cocci: unparse_ast0: Add cases for
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
 parsing_cocci/unparse_ast0.ml | 38 +++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/parsing_cocci/unparse_ast0.ml b/parsing_cocci/unparse_ast0.ml
index 5d450e0e..76288087 100644
--- a/parsing_cocci/unparse_ast0.ml
+++ b/parsing_cocci/unparse_ast0.ml
@@ -292,6 +292,35 @@ and print_function_pointer (ty,lp1,star,rp1,lp2,params,rp2) fn =
   mcode print_string rp1; mcode print_string lp2;
   parameter_list params; mcode print_string rp2
 
+and print_parentype (lp,ty,rp) fn =
+  let function_pointer ty1 array_decs =
+    match Ast0.unwrap ty1 with
+      Ast0.Pointer(ty2,star) ->
+        (match Ast0.unwrap ty2 with
+          Ast0.FunctionType(ty3,lp3,params,rp3) ->
+            typeC ty3;
+            mcode print_string lp;
+            mcode print_string star;
+            let _ =
+              match array_decs with
+                Some(lb1,size,rb1) ->
+                  mcode print_string lb1;
+                  print_option expression size;
+                  mcode print_string rb1
+              | None -> () in
+            mcode print_string rp;
+            mcode print_string lp3;
+            parameter_list params;
+            mcode print_string rp3;
+	| _ -> failwith "ParenType Unparse_ast0")
+    | _ -> failwith "ParenType Unparse_ast0" in
+  match Ast0.unwrap ty with
+    Ast0.Array(ty1,lb1,size,rb1) ->
+      function_pointer ty1 (Some(lb1,size,rb1))
+  | Ast0.Pointer(ty1,star) ->
+      function_pointer ty None
+  | _ -> failwith "ParenType Unparse_ast0"
+
 and typeC t =
   print_context t
     (function _ ->
@@ -306,6 +335,13 @@ and typeC t =
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
@@ -367,6 +403,8 @@ and print_named_type ty id =
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
