Return-Path: <SRS0=0GNs=4Z=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C28C10F28
	for <cocci@archiver.kernel.org>; Sun,  8 Mar 2020 08:45:17 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3989A206D7
	for <cocci@archiver.kernel.org>; Sun,  8 Mar 2020 08:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZOpaRZL3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3989A206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0288j0lf020669;
	Sun, 8 Mar 2020 09:45:00 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 12226781A;
	Sun,  8 Mar 2020 09:45:00 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 595FC7742
 for <cocci@systeme.lip6.fr>; Sun,  8 Mar 2020 09:44:58 +0100 (CET)
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:641])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 0288iuYm018471
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 8 Mar 2020 09:44:57 +0100 (CET)
Received: by mail-pl1-x641.google.com with SMTP id y1so2757196plp.7
 for <cocci@systeme.lip6.fr>; Sun, 08 Mar 2020 00:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pN3fYF/WUsAoyz1cgrMGrvu9VIDZsdxapnqkdhrA3LQ=;
 b=ZOpaRZL3SygYG3iOy2WOLV3foacXo1ls8I2xoGnphPKx5Dzv1ypG780JKxF6mDYobH
 UGpB1eRfNehzXhegxzmBD1M5Vu1l1L5kfOj/Pm1vbnjWW2zmb2Bh7qaYY0aUtPVj7nmz
 wDMI1LgYUr3cwFLnn6jGlyGbbyr2C6MoSTOkkIrfdLFed6gY64s8hPztGiMSEF/LppLO
 mDknSqZAy/cYY2hmfXBQtoxakjV/bdGyBnBFvfI7BjwxplDJvElSLSUbiGsCO8NAR47Q
 V8gEr70MqUjiDOtGUZKsAzD2ZBlAjAj770KYVYa/BlJXWCl5SfFOP/rVnPFnnuvg6Sss
 NE2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pN3fYF/WUsAoyz1cgrMGrvu9VIDZsdxapnqkdhrA3LQ=;
 b=QWJwBGaQdRN6XlRWiPE5FFLg9lB8tJcmqFBWFORAuLHhR5j2driVhlCvw79NNJKIJa
 rvE9QOy8Xz0qPnEGpXRbSRH6OOrnbaLeYHYyKlrpMjc/FQiG+CuXbPaNCODYw5C4CuOf
 cbeByoWw6ZhBEWOz9Ykn3/wKjOILR3uGVMWRMW3mlKUzBz6sNIFyJSPwYRnnUK+VBzYT
 NoyyyL34VHNHhCyYec+hA5/cCOf5sDcrUxt2kCp0CSwXhcvLBhO/wII74o9FG6OjRLSq
 xhrfXNv0lPbEYKhbkKsCbaf3jY7wi6o+pML1+ptm+6nvDDEn9HyTCL7uT4bPzRcOd863
 lgeQ==
X-Gm-Message-State: ANhLgQ3YRo2DOLuo8+9eAXmR9W6Tqo4W5xzChwjHTfhxNnTH90Y9FBDc
 4wPPvafqTb8oNlRMMGNLB8q9fal6
X-Google-Smtp-Source: ADFU+vsqzlsWvo1HT7ryuvWzTajYOyQ/efsAsZtgE04qcU68NIrwoyPAYEP4rXl08DBujTEHltzz9g==
X-Received: by 2002:a17:90b:3009:: with SMTP id
 hg9mr12176644pjb.181.1583657095578; 
 Sun, 08 Mar 2020 00:44:55 -0800 (PST)
Received: from localhost.localdomain ([1.38.148.20])
 by smtp.gmail.com with ESMTPSA id b3sm14587244pjo.30.2020.03.08.00.44.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Mar 2020 00:44:55 -0800 (PST)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sun,  8 Mar 2020 14:13:56 +0530
Message-Id: <20200308084356.14506-14-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200308084356.14506-1-jaskaransingh7654321@gmail.com>
References: <20200308084356.14506-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 08 Mar 2020 09:45:00 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 08 Mar 2020 09:44:57 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 13/13] tools: spgen: Reflect visitor changes
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

Visitor_ast0 has changes with respect to enums. Reflect these
changes in spgen by adding additional arguments in the combiners
and rebuilders.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 tools/spgen/source/detect_patch.ml  | 6 ++++--
 tools/spgen/source/meta_variable.ml | 6 ++++--
 tools/spgen/source/rule_body.ml     | 6 ++++--
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/tools/spgen/source/detect_patch.ml b/tools/spgen/source/detect_patch.ml
index 6cf1c538..0489afec 100644
--- a/tools/spgen/source/detect_patch.ml
+++ b/tools/spgen/source/detect_patch.ml
@@ -101,11 +101,13 @@ let patch_combiner =
   let dotsparamfn = donothing in
   let dotsdeclfn = donothing in
   let dotsfieldfn = donothing in
+  let dotsenumdeclfn = donothing in
   let dotscasefn = donothing in
   let dotsdefparfn = donothing in
   let assignOpfn = donothing in
   let binaryOpfn = donothing in
   let initfn = donothing in
+  let enumdeclfn = donothing in
   let paramfn = donothing in
   let forinfofn = donothing in
   let string_fragmentfn = donothing in
@@ -159,9 +161,9 @@ let patch_combiner =
     fix_mcode unary_mcode arithOp_mcode logicalOp_mcode cv_mcode sign_mcode
     struct_mcode storage_mcode inc_mcode
     dotsexprfn dotsinitfn dotsparamfn dotsstmtfn dotsdeclfn dotsfieldfn
-    dotscasefn dotsdefparfn
+    dotsenumdeclfn dotscasefn dotsdefparfn
     identfn exprfn assignOpfn binaryOpfn tyfn initfn paramfn declfn fieldfn
-    stmtfn forinfofn casefn string_fragmentfn topfn
+    enumdeclfn stmtfn forinfofn casefn string_fragmentfn topfn
 
 
 (* ------------------------------------------------------------------------- *)
diff --git a/tools/spgen/source/meta_variable.ml b/tools/spgen/source/meta_variable.ml
index 7adfacad..a1804a05 100644
--- a/tools/spgen/source/meta_variable.ml
+++ b/tools/spgen/source/meta_variable.ml
@@ -390,11 +390,13 @@ let metavar_combiner rn =
   let dotsstmtfn = donothing in
   let dotsdeclfn = donothing in
   let dotsfieldfn = donothing in
+  let dotsenumdeclfn = donothing in
   let dotscasefn = donothing in
   let dotsdefparfn = donothing in
   let forinfofn = donothing in
   let casefn = donothing in
   let topfn = donothing in
+  let enumdeclfn = donothing in
 
   (* --- These are shortened formatting functions that return MVSets --- *)
 
@@ -574,9 +576,9 @@ let metavar_combiner rn =
     fix_mcode unary_mcode arithOp_mcode logicalOp_mcode cv_mcode sign_mcode
     struct_mcode storage_mcode inc_mcode
     dotsexprfn dotsinitfn dotsparamfn dotsstmtfn dotsdeclfn dotsfieldfn
-    dotscasefn dotsdefparfn
+    dotsenumdeclfn dotscasefn dotsdefparfn
     identfn exprfn assignOpfn binaryOpfn tyfn initfn paramfn declfn fieldfn
-    stmtfn forinfofn casefn string_fragmentfn topfn
+    enumdeclfn stmtfn forinfofn casefn string_fragmentfn topfn
 
 
 (* ------------------------------------------------------------------------- *)
diff --git a/tools/spgen/source/rule_body.ml b/tools/spgen/source/rule_body.ml
index 6345c9df..163dff9a 100644
--- a/tools/spgen/source/rule_body.ml
+++ b/tools/spgen/source/rule_body.ml
@@ -219,12 +219,14 @@ let rec gen_combiner ~context_mode =
   let dotsparamfn = donothing in
   let dotsdeclfn = donothing in
   let dotsfieldfn = donothing in
+  let dotsenumdeclfn = donothing in
   let dotscasefn = donothing in
   let dotsdefparfn = donothing in
   let assignOpfn = donothing in
   let binaryOpfn = donothing in
   let tyfn = donothing in
   let initfn = donothing in
+  let enumdeclfn = donothing in
   let paramfn = donothing in
   let forinfofn = donothing in
   let casefn = donothing in
@@ -349,9 +351,9 @@ let rec gen_combiner ~context_mode =
     fix_mcode unary_mcode arithOp_mcode logicalOp_mcode cv_mcode sign_mcode
     struct_mcode storage_mcode inc_mcode
     dotsexprfn dotsinitfn dotsparamfn dotsstmtfn dotsdeclfn dotsfieldfn
-    dotscasefn dotsdefparfn
+    dotsenumdeclfn dotscasefn dotsdefparfn
     identfn exprfn assignOpfn binaryOpfn tyfn initfn paramfn declfn fieldfn
-    stmtfn forinfofn casefn string_fragmentfn topfn
+    enumdeclfn stmtfn forinfofn casefn string_fragmentfn topfn
 
 
 (* ------------------------------------------------------------------------- *)
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
