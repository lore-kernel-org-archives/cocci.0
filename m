Return-Path: <SRS0=FJ6B=7K=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E675DC433E0
	for <cocci@archiver.kernel.org>; Thu, 28 May 2020 12:25:45 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66C99212CC
	for <cocci@archiver.kernel.org>; Thu, 28 May 2020 12:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tvx8kNhv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66C99212CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04SCPgA8026000;
	Thu, 28 May 2020 14:25:42 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 99DF75D47;
	Thu, 28 May 2020 14:25:42 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id E75B83E1D
 for <cocci@systeme.lip6.fr>; Thu, 28 May 2020 14:25:40 +0200 (CEST)
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:541])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04SCPdbu018646
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Thu, 28 May 2020 14:25:40 +0200 (CEST)
Received: by mail-pg1-x541.google.com with SMTP id s10so13415109pgm.0
 for <cocci@systeme.lip6.fr>; Thu, 28 May 2020 05:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=H7rNN90I+VvWsyT//Ny3D6RN+JUCIC4Hn7sEnZwtroc=;
 b=Tvx8kNhvJpbRrcNox3id4fLIEYCgDMkgdLBCshnX5crQv95RBjjKwvIES6p8AKDhlk
 QZUI6Pvc3SgqGAf6RHsE6+mczyuCJMSZFTaeR+FNikgJ/7NVKOxXI4RI9DVhlTlRUNXu
 bkTrelhZMMjA+xwjNJAaSp3iSOLHYZsb73RYpD7ywyCz9/PrwUI4BmKL13p//VTZdQuR
 avu7YtLPfu6KwiuUJ7gGsUMtXSOFQrFjp5rYyLc4cymiPmGeVvfY1H3B4yhz3O7kqE4y
 AaiZ6/FGZpxO4Md8GC6It32NjhjPDUXynDp+t26CK6aSOld3QV/IaVCX/T+kRw6QKWEM
 nNuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=H7rNN90I+VvWsyT//Ny3D6RN+JUCIC4Hn7sEnZwtroc=;
 b=L3arGUv3AYe2rsVw8QaJDWCdG6XpherDuSNP/KILfKhvpdc+dJHO7SAZM9MfE65ZRJ
 7cMwyGMr8IRhjkr+krydFbQQxFn+QSwItJvC556sVW7DGsYxO4G1wBQV9+Hg6ceeZa62
 GLGVE6lgzfxzAqq2XeWABMqoxhV0iJSgJHTP1bpTLhg5fLbUwX26dT8NMtti/ur9QyZ/
 24E93/3WVkFN+e6xL2rmbik9vQDM4D6oubhOi9l8HP3J0PPzLO9KrbV5spyEyPTFJfTK
 tcYHuOCilyIb0O6MFzB1v8SjfBbD77WbwagGzpvY9P3kekCnYwSGVZNHtmFwwQa6FmBe
 niVA==
X-Gm-Message-State: AOAM530lU9D2Uq8/+5LT8ncyfZ2kj/9jcGXiXeKSpoioS1J6QGLETgU8
 +y4ZRDIMUUBikY7VvXfU9j87DiFc
X-Google-Smtp-Source: ABdhPJzYLoRdTHCf7MqU3spL3f7Vq0gE6jY+4E/Q1odGEDHF6uvEDrKTskGqWX6urs4UV55+dbG9Hw==
X-Received: by 2002:a63:5015:: with SMTP id e21mr2737964pgb.54.1590668738322; 
 Thu, 28 May 2020 05:25:38 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:2183:e360:deba:7bf4:98ef:5568])
 by smtp.gmail.com with ESMTPSA id 1sm5722888pje.26.2020.05.28.05.25.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2020 05:25:37 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Thu, 28 May 2020 17:54:18 +0530
Message-Id: <20200528122428.4212-17-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200528122428.4212-1-jaskaransingh7654321@gmail.com>
References: <20200528122428.4212-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 28 May 2020 14:25:42 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Thu, 28 May 2020 14:25:40 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v2 16/25] engine: Add distrf_attr to PARAM functor
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
index b1d80abb..12b1c170 100644
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
