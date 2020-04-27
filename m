Return-Path: <SRS0=J+r8=6L=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 068BEC7C8A2
	for <cocci@archiver.kernel.org>; Mon, 27 Apr 2020 12:09:32 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95E3920656
	for <cocci@archiver.kernel.org>; Mon, 27 Apr 2020 12:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWqBepbk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95E3920656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03RC9K9C018384;
	Mon, 27 Apr 2020 14:09:20 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 1515C7807;
	Mon, 27 Apr 2020 14:09:20 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 8AF597769
 for <cocci@systeme.lip6.fr>; Mon, 27 Apr 2020 14:09:18 +0200 (CEST)
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:442])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03RC9GSj024149
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 27 Apr 2020 14:09:17 +0200 (CEST)
Received: by mail-pf1-x442.google.com with SMTP id 145so8900864pfw.13
 for <cocci@systeme.lip6.fr>; Mon, 27 Apr 2020 05:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=g+hmXtZ57pQJX3p5KJ9XlKjgGvth6luZ+JpfwnCkOoM=;
 b=kWqBepbk7UgcMugPEi2YR9kQ8UEnNrYeKXwrVeRlaJcUDBM4Yz7w0EMICFs0gZDC6D
 NTvagrm3yDphzcxs5GupLP5RxvVyuat71kwYuydPNL4MmL3lT8Bv9sxiY/uR5PCEWE5Z
 HelYyzUJJ4gN54kb/wI7SjzQrSyaMbEX09qE21rPp2EKrsjUh0/ufn5rJNM9ti4VpOMM
 lyDFaJDlJpDkwXbM21gkjrY4qmkhmZy+KxTnNrMO4lASqA38sMvx9hDeZNZ1ReZxMa+z
 A4TGMkjIuyWse+lL1nptB7LJicTOB2v9GpMbRwlu/YK3NqnmkCI1Uevm+j7UFM57/KDw
 8WHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=g+hmXtZ57pQJX3p5KJ9XlKjgGvth6luZ+JpfwnCkOoM=;
 b=jZZ6R+fk4xQeqxIOgT5JDJQs5rYxOjdVFdU5ZZqUibYYgOOEQlo1Ep+umxsm+HPo/W
 470avQjKnuHpq8mQ5ZbjRsI2CrokfbTSCjoia1pKhamifKNjHZl8IbMPQHVVDxOHix95
 m5WJKvHmUSB0kI9OJnXHacI0oT+B85bubovB8opeLA2NgwJrafixVAp9XG8tF6K3vAOq
 XAO0sUapoADXrcfPr5fNiEUVn1A1t5kOQE2uCyZYM9Yr8w+Dx2RhSECkKmAEokFAXlxn
 JXmS1imhmqU3/DQJCvO8afwamv9tFwMMUbP5LjgGBZUhaWLQQkOkUoRdc8G3fO7g4OBY
 EUfQ==
X-Gm-Message-State: AGi0PuYOAqbUUH+Y/owduRGTIbrvDQND7d3fqI3LuJsyvK81NJN0djOy
 PWQFL2PTILeCCH4IWI80Pak8afOuuBw=
X-Google-Smtp-Source: APiQypLHsX0EM8hFaHZVhsbAFfjivuIWxNtUdTjJb9wHFNjdb0XIz/eb/z5RWIXZCFSL6IpxuS5wpw==
X-Received: by 2002:a63:fb16:: with SMTP id o22mr21858031pgh.86.1587989356084; 
 Mon, 27 Apr 2020 05:09:16 -0700 (PDT)
Received: from localhost.localdomain ([1.38.220.114])
 by smtp.gmail.com with ESMTPSA id r17sm9623885pgn.35.2020.04.27.05.09.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2020 05:09:15 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 27 Apr 2020 17:38:19 +0530
Message-Id: <20200427120834.380-9-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200427120834.380-1-jaskaransingh7654321@gmail.com>
References: <20200427120834.380-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 27 Apr 2020 14:09:20 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 27 Apr 2020 14:09:18 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 08/23] parsing_cocci: function_prototypes: Reflect
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

Parameter attributes are added to the SmPL AST. Reflect these changes in
function_prototypes.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/function_prototypes.ml | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/parsing_cocci/function_prototypes.ml b/parsing_cocci/function_prototypes.ml
index 71bf1a2a..e223013b 100644
--- a/parsing_cocci/function_prototypes.ml
+++ b/parsing_cocci/function_prototypes.ml
@@ -185,7 +185,7 @@ and changed_proto = function
 (* --------------------------------------------------------------------- *)
 (* make rules *)
 
-let collect_ident_strings id =
+let collect_id_strings id =
   let bind x y = x @ y in
   let option_default = [] in
   let donothing r k e = k e in
@@ -261,10 +261,10 @@ let rec attach_right strings ty =
 let rec drop_param_name p =
   Ast0.rewrap p
     (match Ast0.unwrap p with
-      Ast0.Param(p,Some id) ->
-	let strings = collect_ident_strings id in
+      Ast0.Param(p,Some id,attr) ->
+	let strings = collect_id_strings id in
 	let p = attach_right strings p in
-	Ast0.Param(p,None)
+	Ast0.Param(p,None,attr)
     | Ast0.OptParam(p) -> Ast0.OptParam(drop_param_name p)
     | p -> p)
 
@@ -297,7 +297,7 @@ let new_iname name index =
 
 let rec rename_param old_name all param index =
   match Ast0.unwrap param with
-    Ast0.Param(ty,Some id) when all ->
+    Ast0.Param(ty,Some id,attr) when all ->
       (match Ast0.unwrap id with
 	Ast0.MetaId
 	  (((_,name),arity,info,mcodekind,pos,adj),constraints,seed,pure) ->
@@ -308,7 +308,7 @@ let rec rename_param old_name all param index =
 		 ((nm,arity,info,mcodekind,pos,adj),constraints,seed,
 		  Ast0.Pure)) in
 	  ([Ast.MetaIdDecl(Ast.NONE,nm)],
-	   Ast0.rewrap param (Ast0.Param(ty,Some new_id)))
+	   Ast0.rewrap param (Ast0.Param(ty,Some new_id,attr)))
       |	_ -> ([],param))
   | Ast0.Pdots(d) ->
       let nm = (old_name,new_iname "__P" index) in
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
