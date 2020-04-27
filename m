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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF59BC7C8A0
	for <cocci@archiver.kernel.org>; Mon, 27 Apr 2020 12:10:12 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CC2720656
	for <cocci@archiver.kernel.org>; Mon, 27 Apr 2020 12:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAaMcfac"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CC2720656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03RCA1Sh012144;
	Mon, 27 Apr 2020 14:10:01 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 888F27807;
	Mon, 27 Apr 2020 14:10:01 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B031C7769
 for <cocci@systeme.lip6.fr>; Mon, 27 Apr 2020 14:09:59 +0200 (CEST)
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1041])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03RC9wA0024865
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 27 Apr 2020 14:09:59 +0200 (CEST)
Received: by mail-pj1-x1041.google.com with SMTP id fu13so6774361pjb.5
 for <cocci@systeme.lip6.fr>; Mon, 27 Apr 2020 05:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LiameRiyJLzWrc6OD69O6jqN0a7XU1kU6x01nq1+tvI=;
 b=JAaMcfacE5oMU8iIXKUk2JgY/cT/d+6SE2Cybrrhgqj1yg9x0kSqP/7KEywxIj2G+T
 g/jZETpPz/vLjP29hAD/Gsgt9IF8M8yLxaZA0EdPoAyKK+yMzAqsIWXbZ29h9/FGwZ4g
 +Ep7Lb8neopU/mEJs5q8uA/WKD0iEfPjNpJ1ZQsV/MxanXtPYYAqnHhlmTQKa1OUhn0Q
 o+7uWV1uRHsAPdryv+xuDgCrf8rLjVrO8VfNI3irQz157MKCfRb2Vl6+PVN/v4V+heRR
 LAHFxO3YlvHKxpEUKbC5OpQq0D9ByKGGGw9gQ7aWxhYoODX4TDfWE2xUeTfpZByWO3A7
 uzSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LiameRiyJLzWrc6OD69O6jqN0a7XU1kU6x01nq1+tvI=;
 b=rsRdQzaTLjDMcqTnszLDpPFqZPY8G35PmBDTmzhdjsw+mvXq9VVgnvjHIARyVjzHgU
 BSLAVC4SMFRye5KJVQy05kkzX/X0XifLniPkY8NKtM+uIRtDesnbfZhgADKfdW7/qDH6
 9TQNbmwjbgX2LqR6A9llDGqzf/SCH51/dKIz83rFoJ0HhyXtZNp9bi2V3bqQJqLCgHrr
 xec6lohqKwXjS1QZwA8T/Pl6T7t29Pz4c46NLC1HQI5BNZLbK9lqlAS3d+0ffY+Oz78K
 R/iPA1Wm75u+s2TcNXvSiBtWSrW8R+Z3dBjE+vOptEErDOj4ftZked20Pn9wBlARjWx9
 vGYQ==
X-Gm-Message-State: AGi0PuZHEOe1ni7DeiZFwTnDV1qfIJLP1jEnatwO7bGEV9KWGrLZfQ+J
 TUcZLA5zWmTO/IBaA9CMbflmjnhVMrE=
X-Google-Smtp-Source: APiQypKPC2r4pDKctnh18u1fpSW9NeXVPc0nKeYKKUbaRiWQuTeLwooEdOBsoKH5IA6GDIals6kLzg==
X-Received: by 2002:a17:902:740a:: with SMTP id
 g10mr12901897pll.137.1587989397166; 
 Mon, 27 Apr 2020 05:09:57 -0700 (PDT)
Received: from localhost.localdomain ([1.38.220.114])
 by smtp.gmail.com with ESMTPSA id r17sm9623885pgn.35.2020.04.27.05.09.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2020 05:09:56 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 27 Apr 2020 17:38:29 +0530
Message-Id: <20200427120834.380-19-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200427120834.380-1-jaskaransingh7654321@gmail.com>
References: <20200427120834.380-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 27 Apr 2020 14:10:01 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 27 Apr 2020 14:09:59 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 18/23] parsing_cocci: pretty_print_cocci: Reflect
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
correctly in pretty_print_cocci.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/pretty_print_cocci.ml | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/parsing_cocci/pretty_print_cocci.ml b/parsing_cocci/pretty_print_cocci.ml
index 7628882b..a9eb4a8b 100644
--- a/parsing_cocci/pretty_print_cocci.ml
+++ b/parsing_cocci/pretty_print_cocci.ml
@@ -688,9 +688,18 @@ and designator = function
 
 and parameterTypeDef p =
   match Ast.unwrap p with
-    Ast.VoidParam(ty) -> fullType ty
-  | Ast.Param(ty,Some id) -> print_named_type ty (fun _ -> ident id);
-  | Ast.Param(ty,None) -> fullType ty
+    Ast.VoidParam(ty,attr) ->
+      fullType ty;
+      (if not (attr = []) then print_string " ");
+      print_between print_space (mcode print_string) attr
+  | Ast.Param(ty,Some id,attr) ->
+      print_named_type ty (fun _ -> ident id);
+      (if not (attr = []) then print_string " ");
+      print_between print_space (mcode print_string) attr
+  | Ast.Param(ty,None,attr) ->
+      fullType ty;
+      (if not (attr = []) then print_string " ");
+      print_between print_space (mcode print_string) attr
   | Ast.MetaParam(name,_,_,_) -> mcode print_meta name
   | Ast.MetaParamList(name,_,_,_,_) -> mcode print_meta name
   | Ast.PComma(cm) -> mcode print_string cm; print_space()
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
