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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0286C54E8D
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:14:20 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D3E12075E
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxoCjvbV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D3E12075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04BAE9Yo009184;
	Mon, 11 May 2020 12:14:09 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 28DF43E6B;
	Mon, 11 May 2020 12:14:09 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 538C53DC8
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:14:07 +0200 (CEST)
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1042])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04BAE5vN029159
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:14:06 +0200 (CEST)
Received: by mail-pj1-x1042.google.com with SMTP id mq3so7632769pjb.1
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 03:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8Gk3ffGaKEx6MgGnn2QBnBC8UunZy5aBosraxgOTrGU=;
 b=JxoCjvbVF6cBcmJPjxWZaSLMUOpjJtwvjetOiN/0pG5UT9gIh8R1DiIppJe0u4Q3hz
 5hg+kYjgBgArYkDRXhBUk94ZCo0tYhE9iNdb7w4Pd6d0IoipR5ShgEpdw8SowswQfT3Z
 SlJL4Xt9ZqeXrexUOT2O2GGzWbfk3byby3QMheW77GVbSltoVMM1oudQUuqxtrAxFDt2
 OWq9vUvkMegyyD6Mt3a/aRy1miMdNpwNCQPrxsbBJHW1dWc8GuYSmB3VRH/MdB1txMKH
 348/c0ldKqab8WofPw8U9e+Bm8+t6/cByewYNLdEaprZa5eXOsrpx//zZkUDdna7v+4O
 lhaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8Gk3ffGaKEx6MgGnn2QBnBC8UunZy5aBosraxgOTrGU=;
 b=O3YXjeBzUrxcFwiOvuzBnJG+DqCtewFi4lBxa2MfeXpIxXppSU3vxkNxICusRp+eu0
 sNWq6kK5yRfoujjiBihfSCpE7fjRl+6V9kIekbJ1fsZDhcSFxN12WqFABqoKMtaUF18c
 9H9umgYSs4d1uU/9h/9QnMP8jKqS0LqNRXy2cBTYEDHC9dfCNKrczbDNmSo5XPnN52Rz
 4y1eGpypfBoDINS3n+PAvRB8OVAP0ZRx6Y+tjKjT648ffxju11TbxZn8We361Gg/6zEk
 YJJP7pAEtdfGoYgDIbu/UgMU/1WDsNiyaqgeY7qihxNBGPXksCq6B++5YHdKfMNGlH44
 disQ==
X-Gm-Message-State: AGi0PubAlUnxEGFcqDs0MOH8vAYMVo0BeUzBrm3GUqS7vaVhtWrBS6e8
 wRC/Y8IZbe4mC7YP0ulNXRLvB/XXWJM=
X-Google-Smtp-Source: APiQypKjL0EwS22e12sdGvxiEVuNdRO3tWydlcsynh/IZgIAmcCvq1RTx2TSpBDc/EjR4o79oBcqyw==
X-Received: by 2002:a17:902:a408:: with SMTP id
 p8mr11439871plq.36.1589192044920; 
 Mon, 11 May 2020 03:14:04 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:382:66db:4729:1ab8:2139:8945])
 by smtp.gmail.com with ESMTPSA id
 j14sm10021121pjm.27.2020.05.11.03.14.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 03:14:04 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 11 May 2020 15:42:50 +0530
Message-Id: <20200511101300.11101-14-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200511101300.11101-1-jaskaransingh7654321@gmail.com>
References: <20200511101300.11101-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 11 May 2020 12:14:09 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 11 May 2020 12:14:06 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v3 13/23] parsing_c: unparse_cocci: Reflect
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

Parameter attributes are added to the SmPL AST. Print these attributes
correctly in unparse_cocci.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_c/unparse_cocci.ml | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/parsing_c/unparse_cocci.ml b/parsing_c/unparse_cocci.ml
index 395b3a3c..d3f97bf7 100644
--- a/parsing_c/unparse_cocci.ml
+++ b/parsing_c/unparse_cocci.ml
@@ -1089,10 +1089,18 @@ and designator = function
 
 and parameterTypeDef p =
   match Ast.unwrap p with
-    Ast.VoidParam(ty) -> fullType ty
-  | Ast.Param(ty,Some id) -> print_named_type ty (fun _ -> ident id)
-  | Ast.Param(ty,None) -> fullType ty
-
+    Ast.VoidParam(ty,attr) ->
+      fullType ty;
+      (if not (attr = []) then pr_space());
+      print_between pr_space (mcode print_string) attr;
+  | Ast.Param(ty,Some id,attr) ->
+      print_named_type ty (fun _ -> ident id);
+      (if not (attr = []) then pr_space());
+      print_between pr_space (mcode print_string) attr;
+  | Ast.Param(ty,None,attr) ->
+      fullType ty;
+      (if not (attr = []) then pr_space());
+      print_between pr_space (mcode print_string) attr;
   | Ast.MetaParam(name,_,_,_) ->
       handle_metavar name
 	(function
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
