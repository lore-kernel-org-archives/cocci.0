Return-Path: <SRS0=J+r8=6L=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBD2C7C8A0
	for <cocci@archiver.kernel.org>; Mon, 27 Apr 2020 12:10:18 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FD6420656
	for <cocci@archiver.kernel.org>; Mon, 27 Apr 2020 12:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7A/x+0c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FD6420656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03RCA7s8000090;
	Mon, 27 Apr 2020 14:10:07 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 732B17807;
	Mon, 27 Apr 2020 14:10:07 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7D0197769
 for <cocci@systeme.lip6.fr>; Mon, 27 Apr 2020 14:10:06 +0200 (CEST)
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:442])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03RCA4kV022014
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 27 Apr 2020 14:10:05 +0200 (CEST)
Received: by mail-pf1-x442.google.com with SMTP id y25so8921960pfn.5
 for <cocci@systeme.lip6.fr>; Mon, 27 Apr 2020 05:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=R+I2fipbkPh/x4luyQPKwshG6xdLZBLuUkkno04EsbE=;
 b=C7A/x+0cTcOtHIp/r0N4M1fTJsC+l7JjXhvYSluP1mNnw4fOf70AEz1ri5nL9Gyqpc
 BmYahTsV+hryK/LSk1l8aKpE1T4wEWDOiorzeGfSzQd4otAmpYpFmjFUIEXaVKQ99aY2
 IHeVxK7lRF1XJxalE071O6b7a5sHbN82NBaiS2kjHxJPljrvkueNn56vIV/+rNJ72toV
 hfp1EZNPxprzlAS3mPVUyi3wZXg67DGtXUCn6aDxF6FnwSHq3L3WPWG1S0ZP//BBW4Rk
 8zSQ/VdK+7RZ0bYxgJbdmnsACYkP+zlzYmlZdrAnYrYh2CG1YUTshn2uAigICIhMLJle
 eofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=R+I2fipbkPh/x4luyQPKwshG6xdLZBLuUkkno04EsbE=;
 b=QRog+Yw9U1vT1M2nFhqFubyGU4q0ER2TStWYVUjYRhNNqw8sM8HzoRpAd4Q1Ji2HqU
 wPZcpy+YlEcoaayop02d+YVqAJcoxj8uZxAbpb8IUnHeqVWMk7MDs1pT8dsS9Obt1YQC
 903AOjoE4PnqKL0mY0rgGQR7amK63EhBCwD/SExNrfLKJ/76FjkC62PL98nyCTFG3+mr
 3KuiNsIFn/lMp8virL0abyMk1Tif4WYjLXAkBgLJWZumMu6A7Do0d2c1h3nyLcHYUVSO
 S+3a2rhf/Mf1PatsS7I5c70rvt9NOxBgBxy6PrxIxcB5ETzA/q0LH15uI9vBjLPfZUMg
 1NOQ==
X-Gm-Message-State: AGi0PuZA4qhvNTKg32xnk6CFCUctlEULfhi5pudXxK1IP7vSzQyV6f5m
 PnEnIlc61Uf+Alu2QV901otEPQNkPjw=
X-Google-Smtp-Source: APiQypLdbN4EeakYJ5OUp34/aA5yKBmFxdsrRqwoilpp6zmvhgv+jQy1Pg1d9XEwYMPoUD4iMnU4xw==
X-Received: by 2002:a63:1e18:: with SMTP id e24mr19944852pge.296.1587989403982; 
 Mon, 27 Apr 2020 05:10:03 -0700 (PDT)
Received: from localhost.localdomain ([1.38.220.114])
 by smtp.gmail.com with ESMTPSA id r17sm9623885pgn.35.2020.04.27.05.10.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2020 05:10:03 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 27 Apr 2020 17:38:31 +0530
Message-Id: <20200427120834.380-21-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200427120834.380-1-jaskaransingh7654321@gmail.com>
References: <20200427120834.380-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 27 Apr 2020 14:10:07 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 27 Apr 2020 14:10:06 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 20/23] engine: cocci_vs_c: Match Parameter attributes
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

Parameter attributes are added to the C and SmPL AST. Match the
attributes correctly in cocci_vs_c.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 engine/cocci_vs_c.ml | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/engine/cocci_vs_c.ml b/engine/cocci_vs_c.ml
index 317fa71e..66cb104a 100644
--- a/engine/cocci_vs_c.ml
+++ b/engine/cocci_vs_c.ml
@@ -2112,14 +2112,14 @@ and parameters_bis eas ebs =
   let special_cases ea eas ebs =
     (* a case where one smpl parameter matches a list of C parameters *)
     match A.unwrap ea,ebs with
-      A.VoidParam ta, ys ->
+      A.VoidParam (ta, attrsa), ys ->
 	Some
           (match eas, ebs with
           | [], [Left eb] ->
               let {B.p_register=(hasreg,iihasreg);
                     p_namei = idbopt;
                     p_type=tb;
-                    p_attr=attrs; } = eb in
+                    p_attr=attrsb; } = eb in
 
               let attr_allminus =
                 check_allminus.Visitor_ast.combiner_parameter ea in
@@ -2128,10 +2128,10 @@ and parameters_bis eas ebs =
                 match tb with
                 | (qub, (B.BaseType B.Void,_)) ->
                     fullType ta tb >>= (fun ta tb ->
-                    attribute_list attr_allminus [] attrs >>=
+                    attribute_list attr_allminus attrsa attrsb >>=
                     (fun attrsa attrsb ->
                       return (
-                      [(A.VoidParam ta) +> A.rewrap ea],
+                      [(A.VoidParam (ta, attrsa)) +> A.rewrap ea],
                       [Left {B.p_register=(hasreg, iihasreg);
                               p_namei = idbopt;
                               p_type = tb;
@@ -2171,23 +2171,23 @@ and parameter = fun parama paramb ->
 	      return
 		(A.MetaParam(ida,constraints,keep,inherited)+>
 		 A.rewrap parama,eb)))
-  | A.Param (typa, idaopt), eb ->
+  | A.Param (typa, idaopt, attrsa), eb ->
       let {B.p_register = (hasreg,iihasreg);
 	    p_namei = nameidbopt;
 	    p_type = typb;
-            p_attr = attrs;} = paramb in
+            p_attr = attrsb;} = paramb in
 
       let attr_allminus =
         check_allminus.Visitor_ast.combiner_parameter parama in
 
       fullType typa typb >>= (fun typa typb ->
-      attribute_list attr_allminus [] attrs >>= (fun attrsa attrsb ->
+      attribute_list attr_allminus attrsa attrsb >>= (fun attrsa attrsb ->
 	match idaopt, nameidbopt with
 	| Some ida, Some nameidb ->
       (* todo: if minus on ida, should also minus the iihasreg ? *)
 	    ident_cpp DontKnow ida nameidb >>= (fun ida nameidb ->
               return (
-              A.Param (typa, Some ida)+> A.rewrap parama,
+              A.Param (typa, Some ida, attrsa)+> A.rewrap parama,
               {B.p_register = (hasreg, iihasreg);
 		p_namei = Some (nameidb);
                 p_type = typb;
@@ -2196,7 +2196,7 @@ and parameter = fun parama paramb ->
 
 	| None, None ->
 	    return (
-            A.Param (typa, None)+> A.rewrap parama,
+            A.Param (typa, None, attrsa)+> A.rewrap parama,
             {B.p_register=(hasreg,iihasreg);
               p_namei = None;
               p_type = typb;
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
