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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00B4C7C8A0
	for <cocci@archiver.kernel.org>; Mon, 27 Apr 2020 12:09:57 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A8B420656
	for <cocci@archiver.kernel.org>; Mon, 27 Apr 2020 12:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6Kps00R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A8B420656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03RC9imF009707;
	Mon, 27 Apr 2020 14:09:44 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 411C17807;
	Mon, 27 Apr 2020 14:09:44 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 1BFB47769
 for <cocci@systeme.lip6.fr>; Mon, 27 Apr 2020 14:09:43 +0200 (CEST)
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:541])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03RC9fdn027698
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 27 Apr 2020 14:09:42 +0200 (CEST)
Received: by mail-pg1-x541.google.com with SMTP id t11so8615167pgg.2
 for <cocci@systeme.lip6.fr>; Mon, 27 Apr 2020 05:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8Gk3ffGaKEx6MgGnn2QBnBC8UunZy5aBosraxgOTrGU=;
 b=F6Kps00RScLeKF8qfxjPjVhvBHpzF75y1Q/IqQqCSlZT0DJdGhszzxbRhXbqyKEDhu
 m5Id/so0Zhdvxk/eWuXglCRLW5B/QFUBErBMtJhbu8UX46alShBP+jfM12Enln9Pq7gp
 x3T1ygr59U5mBN60a+st/jhlHJILRH5pfWopo775iwk+csW+YweTmIHauVMPEhHidyqD
 t2ebCBDRBUdAd82+0y9/tts10rO8jZEPutX+7Egqzv0xkVQ8KCqVziwXGhcezzKrvVqX
 aSUk3sVUpHADCklED1yOh7+0iL8DfAz4Om0ZbHbKis15X8mPjUjkbhHuzHlpu6RakkUY
 uFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8Gk3ffGaKEx6MgGnn2QBnBC8UunZy5aBosraxgOTrGU=;
 b=VV2OFRgTc6nA9t/7XazC+BIe/w5ZRnYkcOqp7rT1ob6PHE2u0sck1LZ/War9Zs22pq
 loKl8LFHKJifxL64jhsmZ4wMvIK/b5dH3kxob0HjtpbhkE7MTkqi+rZsFu+O7YxQ3gun
 632hizwZo6KKxxpubguqcHuFMzWg0HaOBNXKkTVBfAD0/PGUp6WPozry2R6yoKvtpEaY
 2CP6QQ+y7jaFsqWyJI6LCUYIjbCV7VLS8+Bv83EswqPcKUs9QzRFv1hE80YfVWDmNmV/
 7jnj1uQftoEfWa3o4v1ikobxx2MGJO79EAivtfq9OxqhYHWpnzUb4UF8V8s7Sr3ztDUE
 5WdA==
X-Gm-Message-State: AGi0PuaQUhPZtkaZiHzpzc4BZkwAVX4qq19KZgrGfR/hCPmSMCRhWUhH
 soL947jp4SA34yptK2I/qm8P4kP8n/U=
X-Google-Smtp-Source: APiQypKRwzcIMnYViIfuzsIXvVd6nM6ccAkI1aa826G3FvOzYvlY1rq58Cvj3bdN78zGBE32k2PbxQ==
X-Received: by 2002:aa7:9491:: with SMTP id z17mr23998764pfk.264.1587989380736; 
 Mon, 27 Apr 2020 05:09:40 -0700 (PDT)
Received: from localhost.localdomain ([1.38.220.114])
 by smtp.gmail.com with ESMTPSA id r17sm9623885pgn.35.2020.04.27.05.09.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2020 05:09:40 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 27 Apr 2020 17:38:24 +0530
Message-Id: <20200427120834.380-14-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200427120834.380-1-jaskaransingh7654321@gmail.com>
References: <20200427120834.380-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 27 Apr 2020 14:09:44 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 27 Apr 2020 14:09:42 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 13/23] parsing_c: unparse_cocci: Reflect Parameter
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
