Return-Path: <SRS0=Qcbb=7G=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3F7C433DF
	for <cocci@archiver.kernel.org>; Sun, 24 May 2020 17:22:14 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ED94206C3
	for <cocci@archiver.kernel.org>; Sun, 24 May 2020 17:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uhRNW/wd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ED94206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04OHMBUN023521;
	Sun, 24 May 2020 19:22:11 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 0AA363DC8;
	Sun, 24 May 2020 19:22:11 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id EC1723D0F
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 19:22:08 +0200 (CEST)
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:544])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04OHM7BO029020
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 19:22:08 +0200 (CEST)
Received: by mail-pg1-x544.google.com with SMTP id m1so1448246pgk.1
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 10:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=R7WLD42QMXJ7Bz5Ic0YLn9Kq01ou66iO00yz3ADGlF8=;
 b=uhRNW/wdU7CJ8IRiWqT7nThf5Tu8C92kF03fXDdAYyB3MP3pqjRKrJEYG9v1rodsAi
 LBfub3ssWDuiwBxXAuMDuZdPCIDpgbenp/snhlqaN1pHRfoiBCbiOa4NDKHjFwR0ZZAO
 nOeizT0HiFXf+DDfK3qxZGpRxuo3B/fNOtMblBVT4nmAyKeRxMOpLoFqBFJ4FgtqHal1
 TDA9qeAdZ/cGtHS4N5ixD9HKkLEc6shT5U8u2JBXgzTz0F076ZEjIppgPxXOHIFnDiFy
 IIMDIB1Rdy3GjwCWWAvw8/m/R6jlalV8zH0ByzB3WIAD+Pfg3XNt0CRRDZ7KBwIwbPa/
 qjjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=R7WLD42QMXJ7Bz5Ic0YLn9Kq01ou66iO00yz3ADGlF8=;
 b=BEmGXnaMxYxCqDtGmMBf/zjMBxbB0Q2ZAbrAd87KwcvcjEFzJwU274GDaKz7CGe5Gr
 m4k53EIyawchtIwdV8+3xGzdVBebeLoCBxOWQvp+GlSgcBbMq7papdW4wnTVqNmuP/97
 L6o0AyF3ondhtPpXVoo49wc+x80hcVV0ibknFcHkc9aJJ7jNo+vEOU1mZ1wgkW2DvndG
 Koth+Y7/ZBbFLN3HmXADknRpKlC/INtEAM4Qii5q5Mbcudl19dHJtto17afJL+r+EQZS
 6ngk1pKUijz8js4ftdfy8Ypz2hVMkfq3snV1dofHguTO3w4vUt6820eGDL317uLlgNp/
 N8Ag==
X-Gm-Message-State: AOAM533/9ZB/H6IJKsJq2jvEExMThWuNQtxZ9kvZq1CzvFwhwIAWtccT
 X+ZyLzkOrxhtH4YggXOQoSDS0RMHCvQ=
X-Google-Smtp-Source: ABdhPJz/rUYzbG84Hv+HnMaQ+sXPbnjCLU/2UFZ1GOUq6+NF/b3ZeFefHavO3NExBUIKsV4UrPO4kA==
X-Received: by 2002:a62:2e84:: with SMTP id u126mr1101181pfu.196.1590340926622; 
 Sun, 24 May 2020 10:22:06 -0700 (PDT)
Received: from localhost.localdomain ([1.38.220.54])
 by smtp.gmail.com with ESMTPSA id d9sm6556497pfn.72.2020.05.24.10.21.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2020 10:22:06 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sun, 24 May 2020 22:49:28 +0530
Message-Id: <20200524171935.2504-24-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200524171935.2504-1-jaskaransingh7654321@gmail.com>
References: <20200524171935.2504-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 24 May 2020 19:22:11 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 24 May 2020 19:22:08 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 23/30] parsing_c: pretty_print_c: Reflect Macrodecl
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

Macrodecl attributes are added to the C AST. Print these changes in
pretty_print_c.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_c/pretty_print_c.ml | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/parsing_c/pretty_print_c.ml b/parsing_c/pretty_print_c.ml
index b9b9b929..4faa188d 100644
--- a/parsing_c/pretty_print_c.ml
+++ b/parsing_c/pretty_print_c.ml
@@ -1043,7 +1043,8 @@ and pp_string_format (e,ii) =
 
 	pr_elem iivirg;
 
-    | MacroDecl ((sto, s, es, true), iis::lp::rp::iiend::ifakestart::iisto) ->
+    | MacroDecl
+      ((sto, s, es, attrs, true), iis::lp::rp::iiend::ifakestart::iisto) ->
 	pr_elem ifakestart;
 	iisto +> List.iter pr_elem; (* static and const *)
 	pr_elem iis;
@@ -1053,11 +1054,11 @@ and pp_string_format (e,ii) =
           opt +> List.iter pr_elem;
           pp_argument e;
 	);
-
 	pr_elem rp;
 	pr_elem iiend;
 
-    | MacroDecl ((sto, s, es, false), iis::lp::rp::ifakestart::iisto) ->
+    | MacroDecl
+      ((sto, s, es, attrs, false), iis::lp::rp::ifakestart::iisto) ->
 	pr_elem ifakestart;
 	iisto +> List.iter pr_elem; (* static and const *)
 	pr_elem iis;
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
