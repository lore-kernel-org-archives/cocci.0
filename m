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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED12C18E7A
	for <cocci@archiver.kernel.org>; Sun,  8 Mar 2020 08:45:10 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E6D320848
	for <cocci@archiver.kernel.org>; Sun,  8 Mar 2020 08:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oSzQHE7G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E6D320848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0288imHS029379;
	Sun, 8 Mar 2020 09:44:50 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A332777F4;
	Sun,  8 Mar 2020 09:44:50 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 97CBB77F4
 for <cocci@systeme.lip6.fr>; Sun,  8 Mar 2020 09:44:49 +0100 (CET)
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:542])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 0288ildh004577
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 8 Mar 2020 09:44:48 +0100 (CET)
Received: by mail-pg1-x542.google.com with SMTP id 7so3304936pgr.2
 for <cocci@systeme.lip6.fr>; Sun, 08 Mar 2020 00:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fysTmO4O6ghGhMX2wDtHaEm/Qh83ihIB7B1VYraQR1Q=;
 b=oSzQHE7Gc/cal9Z65QJEu5b4Ms9MhbDY3OInWYlRd4l4x5DvpQIP2e1MZHQ9kqXJbg
 OxkSmkQLriln+mvsJkEkVh3N1IPdf1I4pqxT5i+TQ7qcWB9lZT40MAhYPYptRdmyeUjK
 Fi1TXQ3ix+wSD7PZtQ7/Y/u7VXzLXqm4L4d8B0Fhvi4P7Ojk+DKJ+h1Of/0PylOG8X0R
 s8h4nZK4/u0+rf5O6VDOIUTIbyvtNTxXM2XU0C0osR7dwaxdJS/wUZMBvVL13w9DXrvu
 IoAUjRKqWq1KB8CiBeb6KpXKKjwxcoLc2SvtwEMVc7HU64hf5cEuka9RsACikW4w6ve6
 eYtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fysTmO4O6ghGhMX2wDtHaEm/Qh83ihIB7B1VYraQR1Q=;
 b=nF6KSFSaIYY5/HZLrT+NCR7aUC+ebcBQL0ol4LhqdBr22ubbtBzm9qvM7J7j6K+S/L
 H7Z7zl5tiiR73LEisJtci000bVrpkVUlZ9QI3Nr2xXHzoiMRTwhPDdnobQqAYrXlq9rB
 M9HXNB2MtRgXD8Scg/1OBrLUyyqqzmrmiuol75b6S1n9evEO6qvklUavfs7YFmUXNHLp
 6L5VVaCx7bb4zt93iasHQTi/2bGXsz/r1plOChOyZzFrCjXWAg1SQyYTVH5BZGsEddM8
 K+HjxrTsmYmK5Z7lRqVidM+9hgvn8OeT7QRine2yyYdeN7h3qMQC8LtRgEe1UruFcG5G
 am3Q==
X-Gm-Message-State: ANhLgQ2yfgpzGaWVImk3hTxxmZrvTSIfGOZzmJ1jk3drKf59a4vXKklH
 s7vk57K0QSNicoT1YJA2BJOB+cVt
X-Google-Smtp-Source: ADFU+vulayWYPzrfKfwu42D9NaMtCb3y0A5vlQay5Q6F+siN5gw4EB/NUvaixXVAyc+sBdXzjAy12g==
X-Received: by 2002:aa7:9a8c:: with SMTP id w12mr11669743pfi.218.1583657086994; 
 Sun, 08 Mar 2020 00:44:46 -0800 (PST)
Received: from localhost.localdomain ([1.38.148.20])
 by smtp.gmail.com with ESMTPSA id b3sm14587244pjo.30.2020.03.08.00.44.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Mar 2020 00:44:46 -0800 (PST)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sun,  8 Mar 2020 14:13:53 +0530
Message-Id: <20200308084356.14506-11-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200308084356.14506-1-jaskaransingh7654321@gmail.com>
References: <20200308084356.14506-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 08 Mar 2020 09:44:50 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 08 Mar 2020 09:44:48 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 10/13] engine: cocci_vs_c: Match enumerators
	properly as per enum_decl
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

The SmPL AST has a separate enum_decl type for an enumerator.
Make corresponding changes in Cocci_vs_c to correctly match
enumerators.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 engine/cocci_vs_c.ml | 44 ++++++++++++++++++--------------------------
 1 file changed, 18 insertions(+), 26 deletions(-)

diff --git a/engine/cocci_vs_c.ml b/engine/cocci_vs_c.ml
index 5d123164..1a9b3671 100644
--- a/engine/cocci_vs_c.ml
+++ b/engine/cocci_vs_c.ml
@@ -3304,14 +3304,14 @@ and (struct_field: (A.annotated_field, B.field) matcher) =
 and enum_fields = fun eas ebs ->
   let match_dots ea =
     match A.unwrap ea with
-      A.Edots(mcode, optexpr) -> Some (mcode, optexpr)
+      A.EnumDots(mcode, optexpr) -> Some (mcode, optexpr)
     | _ -> None in
-  let build_dots (mcode, optexpr) = A.Edots(mcode, optexpr) in
+  let build_dots (mcode, optexpr) = A.EnumDots(mcode, optexpr) in
   let match_comma ea =
     match A.unwrap ea with
-      A.EComma ia1 -> Some ia1
+      A.EnumComma ia1 -> Some ia1
     | _ -> None in
-  let build_comma ia1 = A.EComma ia1 in
+  let build_comma ia1 = A.EnumComma ia1 in
   let match_metalist ea = None in
   let build_metalist _ (ida,leninfo,cstr,keep,inherited) =
     failwith "enum: build meta list: not possible" in
@@ -3326,29 +3326,21 @@ and enum_fields = fun eas ebs ->
 and enum_field ida idb =
   X.all_bound (A.get_inherited ida) >&&>
   match A.unwrap ida, idb with
-    A.Ident(id),(nameidb,None) ->
-      ident_cpp DontKnow id nameidb >>= (fun id nameidb ->
-        return ((A.Ident id) +> A.rewrap ida, (nameidb,None)))
-  | A.Ident(id),(nameidb,Some _) -> fail (* should we have an iso? *)
-  | A.Assignment(ea1,opa,ea2,init),(nameidb,Some(opbi,eb2)) ->
-      (match A.unwrap ea1 with
-	A.Ident(id) ->
-	  let assignOp opa0 opbi =
-	    match A.unwrap opa0 with
-              A.SimpleAssign oa ->
-		tokenf oa opbi >>= fun oa opbi ->
-		  return
-                    (A.rewrap opa (A.SimpleAssign oa), opbi)
-            | _ -> failwith "only simple assignment possible here" in
-	  ident_cpp DontKnow id nameidb >>= (fun id nameidb ->
-	  expression ea2 eb2 >>= (fun ea2 eb2 ->
-          assignOp opa opbi >>= (fun opa opbi ->(* only one kind of assignop *)
+    A.Enum(nameida,enum_vala),(nameidb,enum_valb) ->
+      (match enum_vala,enum_valb with
+        (None, Some _)
+      | (Some _, None) -> fail
+      | (None, None) ->
+         ident_cpp DontKnow nameida nameidb >>=
+         (fun nameida nameidb ->
+           return (A.Enum(nameida,None) +> A.rewrap ida, (nameidb,None)))
+      | (Some (eqa,evala), Some(eqb,evalb)) ->
+	  ident_cpp DontKnow nameida nameidb >>= (fun nameida nameidb ->
+          tokenf eqa eqb >>= (fun eqa eqb ->
+	  expression evala evalb >>= (fun ea eb ->
 	    return (
-	    (A.Assignment((A.Ident(id)) +> A.rewrap ea1,opa,ea2,init)) +>
-	    A.rewrap ida,
-	    (nameidb,Some(opbi,eb2))))))
-      |	_ -> failwith "enum: assignment: not possible")
-  | A.Assignment(ea1,opa,ea2,init),(nameidb,None) -> fail
+	    (A.Enum(nameida,Some(eqa,ea)) +> A.rewrap ida),
+	    (nameidb,Some(eqb,eb)))))))
   | _ -> failwith ("not possible: "^(Dumper.dump (A.unwrap ida)))
 
 (* ------------------------------------------------------------------------- *)
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
