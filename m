Return-Path: <SRS0=43Z/=6Z=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED51C54E4B
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:14:28 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 925C82075E
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSFKVkVY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 925C82075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04BAEGjv015844;
	Mon, 11 May 2020 12:14:16 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D802C3E6B;
	Mon, 11 May 2020 12:14:16 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B479E3DC8
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:14:15 +0200 (CEST)
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:441])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04BAEEEu001588
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:14:14 +0200 (CEST)
Received: by mail-pf1-x441.google.com with SMTP id d184so4544320pfd.4
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 03:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Z1IRKXoXy4oSxJMoDJYQIKQOJHNCxCdagozC+STAuSk=;
 b=XSFKVkVYc3FTkdicKvVqoQX1jedu+ryGGb2CmjnM2dETKczNe0o7O8vjpCWwv0B9sj
 R3ZUxMYykm8gtn3BZWsBaxfzYi2U1j8+2WwZOyjIvx+Icxe6eQ4EXJC2SDrJmhY53qbb
 o7BNnIUN0QAH8nB3mUNuAZDeFmhafEe/iOCNtVkzME5400Tj6x2JtfDtgn6p7ON1U4rl
 oQW88HOrNVmqF7aTCvWAGoU7/Dj7IOEd+m28uoEEXwGfWbxqbN1yyBqkcDoiRkF8MHHl
 t4mWYpZ+6nn+iG800NIHHgQgQ7j5066slf6MD0JoCpb9uxHILcGwqse4eevqhjbl8UjC
 lJpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Z1IRKXoXy4oSxJMoDJYQIKQOJHNCxCdagozC+STAuSk=;
 b=tnMeAKKmjeeGU3Zn/vQQfXMwUxgKw5NRVQhFNzqjvskW5u9LpwWl9vOa2rb/MbLSgb
 xSQtDn/ZnnzPN1ChaUCXIGmesdJXZ8xSvgK7Thqjb2dPn7NIjp1/fAQM8T1e1ymz0iFo
 lOIQPcYCtsh4aAkKElkXFb8+p14xBdspgoxLgOde8mmkjqU9Dv3rxwgoXTaAosREoFtj
 u15d5TV41YzjV4dsCoSYT3f5iso0d4ALzvm1GPhZ1nDZpm4u2vbZeqqNkMwVB4vCtZPH
 5TFfvycXw0QDYdurvrnf8cESNm++Zya7h/fVd/+DmdZSnLdr5aUjaPA/LUqtviRuxh1M
 nAHw==
X-Gm-Message-State: AGi0PuY1/ALmDCG/ehY0nHxWPxpDxlGys8cZVjmAxVX0Tadri58v68t/
 DJJeCPTaPzfcWdmLdpDZ6ODZFUDPlR0=
X-Google-Smtp-Source: APiQypIPnWlD29Ahi/Saw72hs2UWi0TVl+G5cCNW+vgxb7eYXVgxBw11N/Q45KXGZfZAoqiA+ZnSyw==
X-Received: by 2002:a65:6251:: with SMTP id q17mr13756226pgv.4.1589192053247; 
 Mon, 11 May 2020 03:14:13 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:382:66db:4729:1ab8:2139:8945])
 by smtp.gmail.com with ESMTPSA id
 j14sm10021121pjm.27.2020.05.11.03.14.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 03:14:12 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 11 May 2020 15:42:52 +0530
Message-Id: <20200511101300.11101-16-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200511101300.11101-1-jaskaransingh7654321@gmail.com>
References: <20200511101300.11101-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 11 May 2020 12:14:16 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 11 May 2020 12:14:15 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v3 15/23] parsing_cocci: visitor_ast: Visit
	Parameter attributes
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

Parameter attributes are added to the SmPL AST. Visit these attributes in
the AST visitor.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/visitor_ast.ml | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/parsing_cocci/visitor_ast.ml b/parsing_cocci/visitor_ast.ml
index 8e530114..63eab999 100644
--- a/parsing_cocci/visitor_ast.ml
+++ b/parsing_cocci/visitor_ast.ml
@@ -621,9 +621,18 @@ let combiner bind option_default
   and parameterTypeDef p =
     let k p =
       match Ast.unwrap p with
-	Ast.VoidParam(ty) -> fullType ty
-      | Ast.Param(ty,Some id) -> named_type ty id
-      | Ast.Param(ty,None) -> fullType ty
+        Ast.VoidParam(ty,attr) ->
+          let lty = fullType ty in
+          let lattr = multibind (List.map string_mcode attr) in
+          bind lty lattr
+      | Ast.Param(ty,Some id,attr) ->
+          let lid = named_type ty id in
+          let lattr = multibind (List.map string_mcode attr) in
+          bind lid lattr
+      | Ast.Param(ty,None,attr) ->
+          let lty = fullType ty in
+          let lattr = multibind (List.map string_mcode attr) in
+          bind lty lattr
       | Ast.MetaParam(name,_,_,_) -> meta_mcode name
       | Ast.MetaParamList(name,_,_,_,_) -> meta_mcode name
       |	Ast.AsParam(p,asexp) ->
@@ -1582,8 +1591,11 @@ let rebuilder
     let k p =
       Ast.rewrap p
 	(match Ast.unwrap p with
-	  Ast.VoidParam(ty) -> Ast.VoidParam(fullType ty)
-	| Ast.Param(ty,id) -> Ast.Param(fullType ty, get_option ident id)
+	  Ast.VoidParam(ty,attr) ->
+            Ast.VoidParam(fullType ty,List.map string_mcode attr)
+	| Ast.Param(ty,id,attr) ->
+            Ast.Param
+              (fullType ty, get_option ident id,List.map string_mcode attr)
 	| Ast.MetaParam(name,constraints,keep,inherited) ->
 	    Ast.MetaParam(meta_mcode name,constraints,keep,inherited)
 	| Ast.MetaParamList(name,lenname_inh,constraints,keep,inherited) ->
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
