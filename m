Return-Path: <SRS0=Qcbb=7G=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D50C433DF
	for <cocci@archiver.kernel.org>; Sun, 24 May 2020 17:22:42 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F62A206C3
	for <cocci@archiver.kernel.org>; Sun, 24 May 2020 17:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4z7eoBY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F62A206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04OHMdT0026975;
	Sun, 24 May 2020 19:22:39 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 5D5513DC8;
	Sun, 24 May 2020 19:22:39 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7EDEE3D0F
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 19:22:37 +0200 (CEST)
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:443])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04OHMZq3005428
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 19:22:36 +0200 (CEST)
Received: by mail-pf1-x443.google.com with SMTP id y198so7871351pfb.4
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 10:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sYx2A/rvZUMqfb7yE0l7tN8ntav6DCEcObh5qrmNPHE=;
 b=E4z7eoBYA6Rh5+3ZxXbDy//lKV1uctDNtp6X8dF30KCs+Ht55QcxZ7yvCxcEPLnglW
 AFqvfvlVqXj/3PuWwB04xM4yT7JeGQtYGNym1vItAntYzg/NWtw5jVuJxfI5N55tNelf
 bRKL1SVaOaonzKQzYrq5PLoNYY6POua0Mv/luNfsk06x64lsjZzwmqbjTvrHi8R2RN/N
 PHr8ohtxrBUdNOqbSmJom829wvzJfERRbT9H5tuARHKAkLhHt3mWw7LZ3v3OB8rZGJhj
 1LiK9Z2NLQJVxqHYQbOc25zcFNuQPajgDvgWE6aJCppbqWVPEEah9P5Lzxtz2MNOq9kn
 rgnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sYx2A/rvZUMqfb7yE0l7tN8ntav6DCEcObh5qrmNPHE=;
 b=UfpJP/b7+NC2fgBAI8y843P/ZZF2LR3KZnNPFYVX3ZWAnF69XaqGb6Ql4kYKGdshtm
 e/hdGvPmG4AHyvqzDud0hvbpltTFfgPqNOy0mZD5tOIv+fy+6zj0KRuWxqiiBtknEt3G
 8OQac349PCtIfs6tVNHbEMhanEWqk/A54HgQMpK2DH7SLgDfzvq6y5cRY7pAEWS8QGcY
 DBDRhLAhi+5wWPKUgCj27E2f4XoSe/ILDLJtyRUejZXuVFC5/y6tOeYTxf1pO6/E7ISu
 ufHBkjVLEnTcJS7GEFfS1CWNuMlehTinwAR0FsxEACVUCRUyXt/7xb2gGU42KXOrUuG+
 9Z2Q==
X-Gm-Message-State: AOAM5314YPr+bOjyNHn73o1p6CEFWD3UVTzd+hF1jv2DG1rMABifOF1G
 bYGl3qDw0TAFzCrUSp1L+0iyxWzinPE=
X-Google-Smtp-Source: ABdhPJz4R1+YhIcTPwUjHmUnBlY8syjh9efWJIOkFhpNbmB9oyAuMjJlbiai/bxIf5geH3zGu+E2sg==
X-Received: by 2002:a63:3c17:: with SMTP id j23mr22376345pga.343.1590340954916; 
 Sun, 24 May 2020 10:22:34 -0700 (PDT)
Received: from localhost.localdomain ([1.38.220.54])
 by smtp.gmail.com with ESMTPSA id d9sm6556497pfn.72.2020.05.24.10.22.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2020 10:22:34 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sun, 24 May 2020 22:49:31 +0530
Message-Id: <20200524171935.2504-27-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200524171935.2504-1-jaskaransingh7654321@gmail.com>
References: <20200524171935.2504-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 24 May 2020 19:22:39 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 24 May 2020 19:22:36 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 26/30] engine: cocci_vs_c: Match Macrodecl attributes
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

Macrodecl attributes are added to the C and SmPL ASTs. Match these
attributes in cocci_vs_c.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 engine/cocci_vs_c.ml | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/engine/cocci_vs_c.ml b/engine/cocci_vs_c.ml
index 317fa71e..ca911765 100644
--- a/engine/cocci_vs_c.ml
+++ b/engine/cocci_vs_c.ml
@@ -2340,8 +2340,8 @@ and (declaration: (A.mcodekind * bool * A.declaration,B.declaration) matcher) =
 	      fail
 	end
 
-  | A.MacroDecl (stoa,sa,lpa,eas,rpa,enda),
-	B.MacroDecl ((stob,sb,ebs,true),ii) ->
+  | A.MacroDecl (stoa,sa,lpa,eas,rpa,attrsa,enda),
+	B.MacroDecl ((stob,sb,ebs,attrsb,true),ii) ->
       let (iisb, lpb, rpb, iiendb, iifakestart, iistob) =
         (match ii with
         | iisb::lpb::rpb::iiendb::iifakestart::iisto ->
@@ -2352,6 +2352,7 @@ and (declaration: (A.mcodekind * bool * A.declaration,B.declaration) matcher) =
           stoa ((stob, false), iistob) >>= (fun stoa ((stob, _), iistob) ->
         X.tokenf_mck mckstart iifakestart >>= (fun mckstart iifakestart ->
 	ident DontKnow sa (sb, iisb) >>= (fun sa (sb, iisb) ->
+	attribute_list allminus attrsa attrsb >>= (fun attrsa attrsb ->
         tokenf lpa lpb >>= (fun lpa lpb ->
         tokenf rpa rpb >>= (fun rpa rpb ->
         tokenf enda iiendb >>= (fun enda iiendb ->
@@ -2360,13 +2361,13 @@ and (declaration: (A.mcodekind * bool * A.declaration,B.declaration) matcher) =
 
           return (
             (mckstart, allminus,
-            (A.MacroDecl (stoa,sa,lpa,eas,rpa,enda)) +> A.rewrap decla),
-            (B.MacroDecl ((stob,sb,ebs,true),
+            (A.MacroDecl (stoa,sa,lpa,eas,rpa,attrsa,enda)) +> A.rewrap decla),
+            (B.MacroDecl ((stob,sb,ebs,attrsb,true),
                          [iisb;lpb;rpb;iiendb;iifakestart] @ iistob))
-          ))))))))
+          )))))))))
 
-  | A.MacroDecl (None,sa,lpa,eas,rpa,enda),
-      B.MacroDecl ((B.NoSto,sb,ebs,false),ii) ->
+  | A.MacroDecl (None,sa,lpa,eas,rpa,attrsa,enda),
+      B.MacroDecl ((B.NoSto,sb,ebs,attrsb,false),ii) ->
 	(* This is for macrodecls with no semicolons, which come from
 	   a parsing rule that deals with function prototypes with no
 	   return type.  That parsing rule would have a conflict if there
@@ -2383,6 +2384,7 @@ and (declaration: (A.mcodekind * bool * A.declaration,B.declaration) matcher) =
 	    X.tokenf_mck mckstart iifakestart >>=
 	    (fun mckstart iifakestart ->
 	      ident DontKnow sa (sb, iisb) >>= (fun sa (sb, iisb) ->
+	      attribute_list allminus attrsa attrsb >>= (fun attrsa attrsb ->
 	      tokenf lpa lpb >>= (fun lpa lpb ->
 	      tokenf rpa rpb >>= (fun rpa rpb ->
 	      arguments (seqstyle eas) (A.unwrap eas) ebs >>=
@@ -2391,10 +2393,11 @@ and (declaration: (A.mcodekind * bool * A.declaration,B.declaration) matcher) =
 
 		  return (
 		  (mckstart, allminus,
-		   (A.MacroDecl (None,sa,lpa,eas,rpa,enda)) +> A.rewrap decla),
-		  (B.MacroDecl ((B.NoSto,sb,ebs,false),
+		   (A.MacroDecl
+                     (None,sa,lpa,eas,rpa,attrsa,enda)) +> A.rewrap decla),
+		  (B.MacroDecl ((B.NoSto,sb,ebs,attrsb,false),
 				[iisb;lpb;rpb;iifakestart]))
-		  ))))))
+		  )))))))
       | _ -> fail)
 
   | A.MacroDeclInit (stoa,sa,lpa,eas,rpa,weqa,inia,enda),
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
