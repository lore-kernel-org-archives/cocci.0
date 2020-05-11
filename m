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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23028C47255
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:09:34 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5B4E20731
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqHt4Bg7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5B4E20731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04BA9Ela021617;
	Mon, 11 May 2020 12:09:14 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D86883E6B;
	Mon, 11 May 2020 12:09:14 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id A5E853DC8
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:09:13 +0200 (CEST)
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:641])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04BA9B0j029590
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:09:12 +0200 (CEST)
Received: by mail-pl1-x641.google.com with SMTP id y9so1149909plk.10
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 03:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=X7ELOxhs++R4PGiU/Iixh5yNByp0LLvXtJg2Z+Mbkz8=;
 b=eqHt4Bg7wJL8Bc0tlogP8vH8/6QqkOEuMwr0LezR/ZXT106HPnVI4vZ+oM8bR6YBAZ
 oaodNkIbtIAXP2JocjmM56vzmlAnp3AO6K6Es1dU/4QpJhkR8plMoKlY58vcwZBU++3b
 fLOkFPQ9eROukteHog1GSuQ//sF+690Cnspibwfo/79Ot0zcYJ6gWxmkMJa4/RuzypOH
 p4nJPjhdqgf5rB+53KDSrZvRCm+uRl5J3ynd3QBIKMpVbooCHQKwjjuwPDvS0Y728UoD
 nnN3vidg6QxNXZ8cMnoL3dxffVoiBa5UEAH+5S6yPrng5SHQTv0nqrdmEvy0WqR2uQ3W
 0vGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=X7ELOxhs++R4PGiU/Iixh5yNByp0LLvXtJg2Z+Mbkz8=;
 b=ccnncfhiVEE6YuMQEwIjJ9qKo4NQa4OsvOlYjpCPG7e8VpFUhJ6pDgSfY2+lkRDknN
 bWICXR20ZaiskChwt8ErgMz4ITHYb6oO2RTnmqXyCiJA3iHxU6oxaym0nYzttjGLM0vq
 ZLMHGdLRFmdHfAlOAKuTzyR57yA7UJ/krnyZTbBrSxT0hvClSjR63mHHFDFwHNqYUo1l
 fENxqNheAbTCKLuubFquXWaqI9AROcGKmgNkytl3YGxEJI4VIQBaRKzPGsCSrpphFIL0
 oQU15mLA5cy5GxvlQmvoRkJYrYNlxbikOA4YEhpS2vUJPalkJIyqPp7E2KXUBISXEWJR
 Dtxw==
X-Gm-Message-State: AGi0PuahAwsNO0hl3mQlIUbx0SaUnRwRUu5IobYCwb6izGwCOAKFwPc/
 CE1BqSte8gMLrO3caIVVOou8QudUtPU=
X-Google-Smtp-Source: APiQypKnbMUOri4JsEBkc6f16Vogf3OUq7q6+5/QR37gENBND0rEH3KF0ST7LO3IpAPbSi3gXHefvA==
X-Received: by 2002:a17:90a:cc6:: with SMTP id 6mr21530448pjt.17.1589191751263; 
 Mon, 11 May 2020 03:09:11 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:382:66db:4729:1ab8:2139:8945])
 by smtp.gmail.com with ESMTPSA id
 o99sm9772994pjo.8.2020.05.11.03.09.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 03:09:10 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 11 May 2020 15:37:07 +0530
Message-Id: <20200511100715.19819-25-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200511100715.19819-1-jaskaransingh7654321@gmail.com>
References: <20200511100715.19819-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 11 May 2020 12:09:14 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 11 May 2020 12:09:13 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v2 24/32] parsing_c: unparse_cocci: Reflect Cast
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

Cast attributes are added to the SmPL AST. Reflect these changes in
unparse_cocci.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_c/unparse_cocci.ml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/parsing_c/unparse_cocci.ml b/parsing_c/unparse_cocci.ml
index 395b3a3c..0c95c35e 100644
--- a/parsing_c/unparse_cocci.ml
+++ b/parsing_c/unparse_cocci.ml
@@ -455,7 +455,7 @@ let rec expression e =
     | Ast_c.RecordPtAccess (e, name) -> postfix
     | Ast_c.SizeOfExpr (e) -> unary
     | Ast_c.SizeOfType (t) -> unary
-    | Ast_c.Cast (t, e) -> cast
+    | Ast_c.Cast (t, a, e) -> cast
     | Ast_c.StatementExpr (statxs, _) -> top
     | Ast_c.Constructor (t, init) -> unary
     | Ast_c.ParenExpr (e) -> primary
@@ -503,8 +503,10 @@ let rec expression e =
       loop exp postfix; mcode print_string pt; ident field
   | Ast.RecordPtAccess(exp,ar,field) ->
       loop exp postfix; mcode print_string ar; ident field
-  | Ast.Cast(lp,ty,rp,exp) ->
+  | Ast.Cast(lp,ty,attr,rp,exp) ->
       mcode print_string_box lp; fullType ty; close_box();
+      (if not (attr = []) then pr_space());
+      print_between pr_space (mcode print_string) attr;
       mcode print_string rp; loop exp cast
   | Ast.SizeOfExpr(sizeof,exp) ->
       mcode print_string sizeof; loop exp unary
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
