Return-Path: <SRS0=O8dQ=7N=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC40C433E0
	for <cocci@archiver.kernel.org>; Sun, 31 May 2020 15:28:21 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABC7F206DA
	for <cocci@archiver.kernel.org>; Sun, 31 May 2020 15:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BH9hhXu3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABC7F206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04VFSIpv013624;
	Sun, 31 May 2020 17:28:18 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 380477752;
	Sun, 31 May 2020 17:28:18 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 32C9C7752
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 17:28:17 +0200 (CEST)
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:641])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04VFSEEk026949
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 17:28:15 +0200 (CEST)
Received: by mail-pl1-x641.google.com with SMTP id t7so3234757plr.0
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 08:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0iJ/SpOKHprtyfp+JlT83C1TdGzXjsrUvgAcn3ScZVM=;
 b=BH9hhXu3dc5XX6rvIR+QBpbjZmFfZmpsEzpliHxrYyy2+uAFB3rsThKvs3WJhClV2H
 iGWCdJMB31a0VxY7zy1kmrFAc6ihs9jtcxXZr33srEHBnHduVY9bKGHEts4tAm//6h2H
 Fy/nGBZCvA8BSjqkfLX+VBirWxhw7KIOuNVFpJ8WPwA/U8n1UFdjJs6HIQCuRRdTXG78
 j9g5wNtdgsf+KMWjn++ARv2y8Q5GPSTi3oSYAP5Wxci6TPZCK07qqemxrtD/9eWpCn2l
 FITSf6Us9i4SpS3yER0HeIVxpiGmlQc93QdXTGdbD35uGysgCKBeD8hz/tW96ilQscWb
 kDwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0iJ/SpOKHprtyfp+JlT83C1TdGzXjsrUvgAcn3ScZVM=;
 b=F7QkKlsmCWaHpL59oMf6R4vQPOtVq7IvD5AGd11vKV85o0iX2SJLfkS83dCkkx2amL
 U5i5jHtpUfyvaWAArz1mPxO2kdqJYlXzoEX+ekb6nZxaSkiLJ+lxH+mfbxqxQaFIAu4Q
 WQacohMkKXqMssnKsNSC1gwRb+b2N3LFBXiBCPJEzfwsPdh2LjEYusFIgoSwt8ccIakK
 0xzymnSTyre/HLmnvz1PCrnKJYyuWpppY3lUcS+GzPbxlOJXSxnrTbTn0axwe3k6/vUT
 RbrdZ4hb32JCNt6EBVMjVMKiVWyUed6uAOihC+bVRB/rZhwTfvEvq80y22M1rIuIn7Hl
 7HEw==
X-Gm-Message-State: AOAM5337oZ3DW7FczYCVl+GWNQRd+D1cIxlyHlxD/fIILe6I5lvhx5LL
 MdOxcLBHWmq3jFYzh4xcGlXRogV1
X-Google-Smtp-Source: ABdhPJztUkvu5OIEvrPT3/6YFREcKtq3Iyq1ne7lgGFjk1GKbKZ//0VrWc4ABrQtofQac/qJ/rZ91g==
X-Received: by 2002:a17:90a:9f02:: with SMTP id
 n2mr19910481pjp.173.1590938894057; 
 Sun, 31 May 2020 08:28:14 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:1863:fef5:a170:128b:8ef:499d])
 by smtp.gmail.com with ESMTPSA id 131sm12310443pfv.139.2020.05.31.08.28.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2020 08:28:13 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sun, 31 May 2020 20:56:16 +0530
Message-Id: <20200531152621.2886-23-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200531152621.2886-1-jaskaransingh7654321@gmail.com>
References: <20200531152621.2886-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 31 May 2020 17:28:18 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 31 May 2020 17:28:16 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 22/27] engine: cocci_vs_c: Match struct end
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

Struct end attributes are added to the SmPL AST. Match these attributes
in cocci_vs_c.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 engine/cocci_vs_c.ml | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/engine/cocci_vs_c.ml b/engine/cocci_vs_c.ml
index 83141bf5..7abc4d53 100644
--- a/engine/cocci_vs_c.ml
+++ b/engine/cocci_vs_c.ml
@@ -2461,7 +2461,7 @@ and onedecl = fun allminus decla (declb, iiptvirgb, iistob) ->
   * T { }; that we want to match against typedef struct { } xx_t;
   *)
 
- | A.TyDecl (tya0, ptvirga),
+ | A.TyDecl (tya0, attra, ptvirga),
    ({B.v_namei = Some (nameidb, B.NoInit);
      B.v_type = typb0;
      B.v_storage = (B.StoTypedef, inl);
@@ -2503,6 +2503,7 @@ and onedecl = fun allminus decla (declb, iiptvirgb, iistob) ->
        in
 
        struct_fields (A.unwrap declsa) declsb >>= (fun undeclsa declsb ->
+         attribute_list allminus attra endattrs >>= (fun attra endattrs ->
          tokenf ptvirga iiptvirgb >>= (fun ptvirga iiptvirgb ->
          tokenf lba lbb >>= (fun lba lbb ->
          tokenf rba rbb >>= (fun rba rbb ->
@@ -2531,7 +2532,8 @@ and onedecl = fun allminus decla (declb, iiptvirgb, iistob) ->
 			   check_constraints cstr ida (B.MetaTypeVal typ')
 			     (fun () ->
 			       return (
-			       (A.TyDecl (tya0, ptvirga)) +> A.rewrap decla,
+			       (A.TyDecl (tya0, attra, ptvirga))
+			        +> A.rewrap decla,
 			       (({B.v_namei = Some (nameidb, B.NoInit);
 				  B.v_type = typb0;
 				  B.v_storage = (B.StoTypedef, inl);
@@ -2563,7 +2565,7 @@ and onedecl = fun allminus decla (declb, iiptvirgb, iistob) ->
                    let typb0 = ((qu, il), typb1) in
 
                    return (
-                     (A.TyDecl (tya0, ptvirga)) +> A.rewrap decla,
+                     (A.TyDecl (tya0, attra, ptvirga)) +> A.rewrap decla,
                      (({B.v_namei = Some (nameidb, B.NoInit);
                         B.v_type = typb0;
                         B.v_storage = (B.StoTypedef, inl);
@@ -2579,7 +2581,7 @@ and onedecl = fun allminus decla (declb, iiptvirgb, iistob) ->
            | _ -> raise (Impossible 31)
            )
          | _ -> fail
-       )))))
+       ))))))
      | _ -> fail
      )
    | _ -> fail
@@ -2718,7 +2720,7 @@ and onedecl = fun allminus decla (declb, iiptvirgb, iistob) ->
 	      )))))))))
 
    (* do iso-by-absence here ? allow typedecl and var ? *)
-   | A.TyDecl (typa, ptvirga),
+   | A.TyDecl (typa, attra, ptvirga),
      ({B.v_namei = None; B.v_type = typb;
        B.v_storage = stob;
        B.v_local = local;
@@ -2730,9 +2732,10 @@ and onedecl = fun allminus decla (declb, iiptvirgb, iistob) ->
        if stob = (B.NoSto, false)
        then
          fullType typa typb >>= (fun typa typb ->
+         attribute_list allminus attra endattrs >>= (fun attra endattrs ->
          tokenf ptvirga iiptvirgb >>= (fun ptvirga iiptvirgb ->
            return (
-             (A.TyDecl (typa, ptvirga)) +> A.rewrap decla,
+             (A.TyDecl (typa, attra, ptvirga)) +> A.rewrap decla,
              (({B.v_namei = None;
                 B.v_type = typb;
                 B.v_storage = stob;
@@ -2741,7 +2744,7 @@ and onedecl = fun allminus decla (declb, iiptvirgb, iistob) ->
                 B.v_endattr = endattrs;
                 B.v_type_bis = typbbis;
              }, iivirg), iiptvirgb, iistob)
-           )))
+           ))))
        else fail
 
 
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
