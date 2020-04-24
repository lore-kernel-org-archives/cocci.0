Return-Path: <SRS0=cw0N=6I=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A01CC55194
	for <cocci@archiver.kernel.org>; Fri, 24 Apr 2020 09:19:44 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07E6020724
	for <cocci@archiver.kernel.org>; Fri, 24 Apr 2020 09:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJICzcm6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07E6020724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03O9JWDl020007;
	Fri, 24 Apr 2020 11:19:32 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A828E7827;
	Fri, 24 Apr 2020 11:19:32 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id C6BF47827
 for <cocci@systeme.lip6.fr>; Fri, 24 Apr 2020 11:19:31 +0200 (CEST)
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1042])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03O9JTxU000972
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 24 Apr 2020 11:19:30 +0200 (CEST)
Received: by mail-pj1-x1042.google.com with SMTP id fu13so3104971pjb.5
 for <cocci@systeme.lip6.fr>; Fri, 24 Apr 2020 02:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KfRA+3R9ZzJveL4ru1tMAAgz/8T168ipuotIP5e5FwI=;
 b=nJICzcm6XnqiAn4T+CuPnVtAABJ/JJgq+yxS9N/lglJYb4ML2KGllFV3/vZZYKwmcA
 OEmTaFd0VgV9VbXVsqd924DE4pqgREDCAQOurPAPdM3wVqFz/ixK9oECNe+2na18TtXK
 YRcDWpVwah9DgBfdWioo8xvKXpnQLIy0nrfqREVKeelw0Ed3Cu715wurZ3gnG8+aMH19
 riIRBzgmbojK7WgGzZZv5otpx3LTYkhrx0PrWn0y2KNdwfq1smz1cI5lS1hrTurq6co5
 NQ5GLSJCjV02NPKZMJoSd5lxckgxGDhC+JdDACiVafKqE5WKPw7jcqy/bERHJojc/nlp
 0Akg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KfRA+3R9ZzJveL4ru1tMAAgz/8T168ipuotIP5e5FwI=;
 b=AzvJv7PZIeXVWZuFDIxm2j6jQexQwi5NpjnX6usCdgwuxukN8dgwQGUaExC5O6TDgA
 y+lB0uMXxJx1KtTFcA45M8MS8izDWmg4Xn1BuPCiX2OOcjVq1VMzHDsCF3FR1yK4Fh8j
 Ur+C6ybn+CsFSrgS7Wz1hKMtZNDAxqDjBYqNCbTO5MGJzo8nG0IN3S5i+xOklIgdDyBz
 Dp4cHQQNdQWvGNYCjYRJ8++ozO/PtpGlalW4Jysje1j3dflhYZOfMLYmKztuJjZVQJ0Q
 YHLOH+pb8t/2J1GeywCiDuwTTA/Zlppkgqli6HNpJNnS5eBhn6lFq4yDeQMapne8RkUn
 pwuA==
X-Gm-Message-State: AGi0PuYCYw/fpeWSrR7yqQgyOr6kdVKQzOk4wVvJ5nlg0kAp9Ut9AvHF
 Iq9uxG3qqW/rKOucSDUl9YP6Vz/z95U=
X-Google-Smtp-Source: APiQypKuhTtyoFJta0Pp0Ngex9fnXkqqVI7XmX7+p3ZKVoG7MyZ7A4dDHoUV98Om0Z9dGUqMYU82tg==
X-Received: by 2002:a17:902:a98a:: with SMTP id
 bh10mr7940909plb.340.1587719969134; 
 Fri, 24 Apr 2020 02:19:29 -0700 (PDT)
Received: from localhost.localdomain ([1.38.216.60])
 by smtp.gmail.com with ESMTPSA id c80sm5043933pfb.82.2020.04.24.02.19.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2020 02:19:28 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri, 24 Apr 2020 14:47:52 +0530
Message-Id: <20200424091801.13871-17-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200424091801.13871-1-jaskaransingh7654321@gmail.com>
References: <20200424091801.13871-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 24 Apr 2020 11:19:32 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 24 Apr 2020 11:19:31 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [RFC PATCH 16/25] engine: Add distrf_attr to PARAM functor
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

distrf_attr can be used to match a single attribute at a time. Add this
matcher function to the PARAM functor.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 engine/cocci_vs_c.ml       | 3 +++
 engine/cocci_vs_c.mli      | 3 +++
 engine/pattern_c.ml        | 1 +
 engine/transformation_c.ml | 5 +++++
 4 files changed, 12 insertions(+)

diff --git a/engine/cocci_vs_c.ml b/engine/cocci_vs_c.ml
index 2a3c3f94..e383aef8 100644
--- a/engine/cocci_vs_c.ml
+++ b/engine/cocci_vs_c.ml
@@ -700,6 +700,9 @@ module type PARAM =
     val distrf_exec_code_list :
       (A.meta_name A.mcode, (Ast_c.exec_code, Ast_c.il) either list) matcher
 
+    val distrf_attr :
+      (A.meta_name A.mcode, Ast_c.attribute) matcher
+
     val distrf_attrs :
       (A.meta_name A.mcode, (Ast_c.attribute, Ast_c.il) either list) matcher
 
diff --git a/engine/cocci_vs_c.mli b/engine/cocci_vs_c.mli
index ef55d478..70354e19 100644
--- a/engine/cocci_vs_c.mli
+++ b/engine/cocci_vs_c.mli
@@ -162,6 +162,9 @@ module type PARAM =
       (Ast_cocci.meta_name Ast_cocci.mcode,
        (Ast_c.exec_code, Ast_c.il) Common.either list) matcher
 
+    val distrf_attr :
+      (Ast_cocci.meta_name Ast_cocci.mcode, Ast_c.attribute) matcher
+
     val distrf_attrs :
       (Ast_cocci.meta_name Ast_cocci.mcode,
        (Ast_c.attribute, Ast_c.il) Common.either list) matcher
diff --git a/engine/pattern_c.ml b/engine/pattern_c.ml
index 7b1d0c0a..e6796368 100644
--- a/engine/pattern_c.ml
+++ b/engine/pattern_c.ml
@@ -335,6 +335,7 @@ module XMATCH = struct
   let distrf_define_params  = distrf Lib_parsing_c.ii_of_define_params
   let distrf_ident_list     = distrf Lib_parsing_c.ii_of_ident_list
   let distrf_exec_code_list = distrf Lib_parsing_c.ii_of_exec_code_list
+  let distrf_attr           = distrf Lib_parsing_c.ii_of_attr
   let distrf_attrs          = distrf Lib_parsing_c.ii_of_attrs
 
 
diff --git a/engine/transformation_c.ml b/engine/transformation_c.ml
index 4de8fe51..eecd4858 100644
--- a/engine/transformation_c.ml
+++ b/engine/transformation_c.ml
@@ -621,6 +621,9 @@ module XTRANS = struct
   let distribute_mck_ini (maxpos, minpos) = fun (lop,mop,rop,bop) -> fun x ->
     Visitor_c.vk_ini_s (mk_bigf (maxpos, minpos) (lop,mop,rop,bop)) x
 
+  let distribute_mck_attr (maxpos, minpos) = fun (lop,mop,rop,bop) -> fun x ->
+    Visitor_c.vk_attribute_s (mk_bigf (maxpos, minpos) (lop,mop,rop,bop)) x
+
   let distribute_mck_inis (maxpos, minpos) = fun (lop,mop,rop,bop) -> fun x ->
     Visitor_c.vk_inis_splitted_s (mk_bigf (maxpos, minpos) (lop,mop,rop,bop)) x
 
@@ -750,6 +753,8 @@ module XTRANS = struct
     distrf (Lib_parsing_c.ii_of_ident_list,distribute_mck_ident_list)
   let distrf_exec_code_list =
     distrf (Lib_parsing_c.ii_of_exec_code_list,distribute_mck_exec_code_list)
+  let distrf_attr =
+    distrf (Lib_parsing_c.ii_of_attr,distribute_mck_attr)
   let distrf_attrs =
     distrf (Lib_parsing_c.ii_of_attrs,distribute_mck_attrs)
 
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
