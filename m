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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12166C433DF
	for <cocci@archiver.kernel.org>; Thu, 28 May 2020 12:25:50 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A217220888
	for <cocci@archiver.kernel.org>; Thu, 28 May 2020 12:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dVNySu5s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A217220888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04SCPl52027342;
	Thu, 28 May 2020 14:25:47 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 106B35D47;
	Thu, 28 May 2020 14:25:47 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 3F3645D47
 for <cocci@systeme.lip6.fr>; Thu, 28 May 2020 14:25:44 +0200 (CEST)
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:444])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04SCPghT028365
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Thu, 28 May 2020 14:25:43 +0200 (CEST)
Received: by mail-pf1-x444.google.com with SMTP id 131so5099277pfv.13
 for <cocci@systeme.lip6.fr>; Thu, 28 May 2020 05:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dyw+Qp7viQi2nyCbqX5ANdDvSch9vDo6f7qr8BxYN/4=;
 b=dVNySu5sirpr0kdQFs1o59tcvgYzh/3Yyn0DOanjD5Y1klz4fkqXCuuKkyGUJbAvoz
 /WMrFdKAdsMjHL+HzxNz3zuOtS5KbMu/fefCOMti5i44I+7/+mcuJcun5kRCaysEubYo
 VFP7klQr71JX/LKPUhTYqU+93Xw8gGu7HstXJs0GaNPY2p/IKfIzrNu3n2lyxugt8eWr
 6CYWJzl4W+R8IYoxYl8+wdBs61GNj8AuKGnh6RyX/Dgnl+mO7L4C/JVpOtRl1AAbJ+cl
 IxVvCm//DvoCyqz088cNG5QJla4OcqE0zO4wG4XmE7omS1dkyM8QALOzyic0kI0NOrMt
 +Y3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dyw+Qp7viQi2nyCbqX5ANdDvSch9vDo6f7qr8BxYN/4=;
 b=lUwEPfC1ORtIIW0VXf6F58g7Q/ZulrV0KqmA1EyLicUexm+1B8CLt2KOCqDbvRgxim
 J13P1hZkee/P36J2jP+9onGdchcVTfYN1PaTkVTKiDd725Ahv5TX9Fgbg/H422WGK2XT
 s/WFr6XuFinwZhrA26JKvwq1HrKfUWBlcq/Bem+Y0mme4nodvz2eqL+UgxzQZhTQCIg7
 dDuoDdeXdVbQxQpzDtbs9PS10v4gf8C6nMCteorRkQSzXQ4SQVAfT/dQPIrw0rpjRKc0
 L+20tQfhxRyqJyPexQcV/Ck0EyMeivR+ipdx3E9rv1n0r7AOgYO35cnCfKwuf/3v6EDE
 ympQ==
X-Gm-Message-State: AOAM533eJusme4xTPlDZoauiCLkQUIa5gz1d1MpwIUTtd93VjRZyb8MI
 cnVhelmpmZ3Jlgcfte97NUSa2JRV
X-Google-Smtp-Source: ABdhPJxxdyFLFycskXjNsunfTbgHjGRAxfH6nO/MkY+Brz9ixeeEasUmvoK7rqL1O3M9b9Kn2pQPJw==
X-Received: by 2002:a65:40c3:: with SMTP id u3mr2792760pgp.305.1590668741623; 
 Thu, 28 May 2020 05:25:41 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:2183:e360:deba:7bf4:98ef:5568])
 by smtp.gmail.com with ESMTPSA id 1sm5722888pje.26.2020.05.28.05.25.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2020 05:25:41 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Thu, 28 May 2020 17:54:19 +0530
Message-Id: <20200528122428.4212-18-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200528122428.4212-1-jaskaransingh7654321@gmail.com>
References: <20200528122428.4212-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 28 May 2020 14:25:47 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Thu, 28 May 2020 14:25:43 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v2 17/25] engine: cocci_vs_c: Add allminus argument
	to attribute_list
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

The allminus argument is used to denote when attributes should be
removed. This is with respect to the given SmPL program.

Add the allminus argument to attribute_list, and pass it correctly in
places where attribute_list is used.

This also makes sure that the test case unstruct does not break when
attributes are identified correctly by the C parser.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 engine/cocci_vs_c.ml | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/engine/cocci_vs_c.ml b/engine/cocci_vs_c.ml
index e383aef8..413ea220 100644
--- a/engine/cocci_vs_c.ml
+++ b/engine/cocci_vs_c.ml
@@ -2563,7 +2563,7 @@ and onedecl = fun allminus decla (declb, iiptvirgb, iistob) ->
        ident_cpp DontKnow ida nameidb >>= (fun ida nameidb ->
        tokenf ptvirga iiptvirgb >>= (fun ptvirga iiptvirgb ->
        fullType typa typb >>= (fun typa typb ->
-       attribute_list attrsa endattrs >>= (fun attrsa endattrs ->
+       attribute_list allminus attrsa endattrs >>= (fun attrsa endattrs ->
        storage_optional_allminus allminus stoa (stob, iistob) >>=
         (fun stoa (stob, iistob) ->
          return (
@@ -2592,7 +2592,7 @@ and onedecl = fun allminus decla (declb, iiptvirgb, iistob) ->
        tokenf ptvirga iiptvirgb >>= (fun ptvirga iiptvirgb ->
        tokenf eqa iieqb >>= (fun eqa iieqb ->
        fullType typa typb >>= (fun typa typb ->
-       attribute_list attrsa endattrs >>= (fun attrsa endattrs ->
+       attribute_list allminus attrsa endattrs >>= (fun attrsa endattrs ->
        storage_optional_allminus allminus stoa (stob, iistob) >>=
        (fun stoa (stob, iistob) ->
        initialiser inia inib >>= (fun inia inib ->
@@ -2651,7 +2651,7 @@ and onedecl = fun allminus decla (declb, iiptvirgb, iistob) ->
           inla (stob, iistob) >>= (fun inla (stob, iistob) ->
         storage_optional_allminus allminus
           stoa (stob, iistob) >>= (fun stoa (stob, iistob) ->
-        attribute_list attras attrs >>= (fun attras attrs ->
+        attribute_list allminus attras attrs >>= (fun attras attrs ->
         fullType_optional_allminus allminus tya tyb >>= (fun tya tyb ->
 	let fninfoa = put_fninfo stoa tya inla attras in
         parameters (seqstyle paramsa) (A.unwrap paramsa) paramsb >>=
@@ -4194,29 +4194,41 @@ and attribute_list attras attrbs =
 
 (* The cheap hackish version.  No wrapping requires... *)
 
-and attribute_list attras attrbs =
+and attribute_list allminus attras attrbs =
   X.optional_attributes_flag (fun optional_attributes ->
   match attras,attrbs with
     [], _ when optional_attributes || attrbs = [] ->
-      return ([], attrbs)
+      if allminus
+      then
+        let rec loop = function
+            [] -> return ([],[])
+          | ib::ibs ->
+              X.distrf_attr minusizer ib >>= (fun _ ib ->
+                  loop ibs >>= (fun l ibs ->
+                    return([],ib::ibs))) in
+        loop attrbs
+      else return ([], attrbs)
   | [], _ -> fail
   | [attra], [attrb] ->
-    attribute attra attrb >>= (fun attra attrb ->
+    attribute allminus attra attrb >>= (fun attra attrb ->
       return ([attra], [attrb])
     )
   | [attra], attrb -> fail
   | _ -> failwith "only one attribute allowed in SmPL")
 
-and attribute = fun ea eb ->
+and attribute = fun allminus ea eb ->
   match ea, eb with
     attra, (B.Attribute attrb, ii)
       when (A.unwrap_mcode attra) = attrb ->
       let ib1 = tuple_of_list1 ii in
       tokenf attra ib1 >>= (fun attra ib1 ->
+       (if allminus
+        then minusize_list [ib1]
+        else return ((), [ib1])) >>= (fun _ ib1 ->
 	return (
 	  attra,
-	  (B.Attribute attrb, [ib1])
-        ))
+          (B.Attribute attrb,ib1)
+        )))
   | _ -> fail
 
 (*---------------------------------------------------------------------------*)
@@ -4927,7 +4939,7 @@ let rec (rule_elem_node: (A.rule_elem, F.node) matcher) =
             inla (stob, iistob) >>= (fun inla (stob, iistob) ->
           storage_optional_allminus allminus
             stoa (stob, iistob) >>= (fun stoa (stob, iistob) ->
-          attribute_list attras attrs >>= (fun attras attrs ->
+          attribute_list allminus attras attrs >>= (fun attras attrs ->
               (
                 if isvaargs
                 then
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
