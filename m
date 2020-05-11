Return-Path: <SRS0=43Z/=6Z=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56138C54E4B
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:14:55 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE3EF2075E
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfaUFwrZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE3EF2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04BAEbUq027020;
	Mon, 11 May 2020 12:14:37 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 0E5673E6B;
	Mon, 11 May 2020 12:14:37 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 17CED3DC8
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:14:35 +0200 (CEST)
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:643])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04BAEXJe023619
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:14:34 +0200 (CEST)
Received: by mail-pl1-x643.google.com with SMTP id x10so3745915plr.4
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 03:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=R+I2fipbkPh/x4luyQPKwshG6xdLZBLuUkkno04EsbE=;
 b=gfaUFwrZLnpI1Yu0IZAu8R9ckzX7LqrbymwRO6u7rd+7f2cZVLkz9p73SiAzaIh4Yp
 CAtwMDZkLl/4OwwMG0t7IlYTXRDAorlSTsj1+fmk9VKBrGytN5Y5xIsWE+O6Ag5gx0p9
 UIe3X8abHDbOalB/4mN2B/mXOpP+3qPIN9L3AV0JZ2INSYg7nH4gAFMAHTiKOrUWTcTS
 L+ZAiXA9yOxIPwSK3qFFGqBKQ4ij8+XAmBK2qeqnxvJ6MwXpPbYiR3BBnRN58M1MrKES
 o4QbrsMHj8deYxKttJr9O0hIuiZpJezW6w5sYpsIKOoNx0A5GIV8BOxWSexk7JC8iaAG
 Qt6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=R+I2fipbkPh/x4luyQPKwshG6xdLZBLuUkkno04EsbE=;
 b=KAeeXqpONrmGB4RQsxr7k7vuYPFCjtiAw1Nykb35J3Xs0Q2REQR080BWVA+oWZ0fTk
 OZ0FWYQ8zsWuTqLhITtR8sZljMcxQadDq1LuQ0Xi7IoVn2WpCEFEfH8YPh1dFHZWOqTO
 eaAsCvdXktikDZG4wcSsuaNa20bEJOCrZALEULLgxElQ/O1Ny8FfkmOh2E1Ab344VO+j
 VCjqRMvLh/KEMnCfHhDJheQOent7my0pyTMzjeuiZSiPLMLoms8mCeJDnvrsuIueycg/
 X3zQ+5j1g2PpBbb5EiQhzCan4Kr3dtmHYe/EtwZJJFoETRZYCM0o4QZkzg0BsVzkttJK
 EjBw==
X-Gm-Message-State: AGi0PubExHA9wskq16J2zK6eRZDX5mlCv0Om8raUSBDp2SUqsIgSpMb9
 Nkw6nn6kT7SOjLraTfb/lwygxCylcjU=
X-Google-Smtp-Source: APiQypK9ANMEXBiaW3LgqNcwFD7K18vuXfuAXR72W25gnSovhFGX7UezhxBrka4mgR8KsN8zzZsOIA==
X-Received: by 2002:a17:90a:20ee:: with SMTP id
 f101mr21837127pjg.197.1589192072516; 
 Mon, 11 May 2020 03:14:32 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:382:66db:4729:1ab8:2139:8945])
 by smtp.gmail.com with ESMTPSA id
 j14sm10021121pjm.27.2020.05.11.03.14.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 03:14:32 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 11 May 2020 15:42:57 +0530
Message-Id: <20200511101300.11101-21-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200511101300.11101-1-jaskaransingh7654321@gmail.com>
References: <20200511101300.11101-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 11 May 2020 12:14:37 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 11 May 2020 12:14:34 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v3 20/23] engine: cocci_vs_c: Match Parameter
	attributes
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
