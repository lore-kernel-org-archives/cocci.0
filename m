Return-Path: <SRS0=43Z/=6Z=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78439C47255
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:14:02 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E454A20720
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hb84SZpr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E454A20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04BADpjm019127;
	Mon, 11 May 2020 12:13:51 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 30C2C3E6B;
	Mon, 11 May 2020 12:13:51 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 39E403DC8
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:13:49 +0200 (CEST)
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1041])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04BADl6B015208
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:13:48 +0200 (CEST)
Received: by mail-pj1-x1041.google.com with SMTP id ms17so7562128pjb.0
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 03:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=U5/XClYRjVE2OZVb+vj8MCi+FDKxhb61twexwoM2+tQ=;
 b=Hb84SZprwnaA7c0IQSYXeIuTG8QRBxNhoMSGAXArGBRVVMDOnwJWdA9eKn3Gopdlo0
 48Cdowz+FGcALnD3q6PP4Aijfu7SDB9PRMmSONXv1GVAfXyTpKvuJ1U7RDoxtpXkvROZ
 mBHiQIIct/pVYcaKMvpE5boCXcscJ20ggdp6XJmHqknC29w4SAktSSptLhKRx8Pf5WjZ
 v6D8WukURRfwcVyDJyr+mAJCi+8AZGYji5VL6MM+49DQxTqEI8iC25zlYzWizsWpxFW1
 /uUGCey/3VxmEKG6NHpHLR2NYTwAIoRKEL2dCHmxOdd5y3yOBcDJ3BGnBkblOcJ86KAA
 kSRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=U5/XClYRjVE2OZVb+vj8MCi+FDKxhb61twexwoM2+tQ=;
 b=r2Me8ASv7yYBzgTULb7KmmJKS+Gx3Pdm4zdhrnqnbCwzhFz5sbpWroHSsELC0zTXML
 t+FWEfKCIa2M7KbUn3YzV/0Qu3AxmxKdMSSzHF0AqPKqhFDqBKyn2StJSK/dy7wMzco/
 DyVrUtnaA/A82uDuiiXRHweBtdGfaARJCHk5S7yIexs4rSQ/LmaRHTQuSpXcdhISIFtg
 W6FKo5Md0lQ9o9hBsIWFD7DjJzwhaTj/IDHrTnsRSlyRTbNpVDzMr8PjUI/W+eMhPAtU
 Ilibj55RFSrhYhtgm7N9fwXrYAj/wA10uFvwIx4iL6Yqz9vAIiqvxz+LJjVxP6S+y5TY
 DBew==
X-Gm-Message-State: AGi0Pub3ZBAbFb+3YJUfQjg9lSzAhxuK1tsAGj1jFasRu80Fzy2BPnoT
 1L6EA2lbyvo1w5hn6HR4B7Ks1dFXzsM=
X-Google-Smtp-Source: APiQypJgfd9RgkAPJjVO1tIEtw51oV6HBfxt0LUlX07sUciNESt57G9qlZjdpNMRlxb+XywfiZz6hA==
X-Received: by 2002:a17:90a:db91:: with SMTP id
 h17mr19964683pjv.7.1589192026829; 
 Mon, 11 May 2020 03:13:46 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:382:66db:4729:1ab8:2139:8945])
 by smtp.gmail.com with ESMTPSA id
 j14sm10021121pjm.27.2020.05.11.03.13.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 03:13:46 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 11 May 2020 15:42:45 +0530
Message-Id: <20200511101300.11101-9-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200511101300.11101-1-jaskaransingh7654321@gmail.com>
References: <20200511101300.11101-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 11 May 2020 12:13:51 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 11 May 2020 12:13:48 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v3 08/23] parsing_cocci: function_prototypes:
	Reflect Parameter attributes
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
 parsing_cocci/function_prototypes.ml | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/parsing_cocci/function_prototypes.ml b/parsing_cocci/function_prototypes.ml
index 71bf1a2a..966369b8 100644
--- a/parsing_cocci/function_prototypes.ml
+++ b/parsing_cocci/function_prototypes.ml
@@ -261,10 +261,10 @@ let rec attach_right strings ty =
 let rec drop_param_name p =
   Ast0.rewrap p
     (match Ast0.unwrap p with
-      Ast0.Param(p,Some id) ->
+      Ast0.Param(p,Some id,attr) ->
 	let strings = collect_ident_strings id in
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
