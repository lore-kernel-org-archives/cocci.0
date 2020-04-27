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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFBDC7C8A1
	for <cocci@archiver.kernel.org>; Mon, 27 Apr 2020 12:09:59 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ADED20656
	for <cocci@archiver.kernel.org>; Mon, 27 Apr 2020 12:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltstyDlC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ADED20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03RC9m9k012278;
	Mon, 27 Apr 2020 14:09:48 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 9D8D17807;
	Mon, 27 Apr 2020 14:09:48 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 591FC7769
 for <cocci@systeme.lip6.fr>; Mon, 27 Apr 2020 14:09:47 +0200 (CEST)
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:642])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03RC9jVC023903
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 27 Apr 2020 14:09:46 +0200 (CEST)
Received: by mail-pl1-x642.google.com with SMTP id t7so1001598plr.0
 for <cocci@systeme.lip6.fr>; Mon, 27 Apr 2020 05:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tOXqqQIKxCE3fAslrFlFgyBgp0iUgXeNGD0vo0kS0Yg=;
 b=ltstyDlCBCkshFtWKkjMVmxR8Frnie48g47uJy/N3KdF5yZKiRgAd+eVmshMIEjYXy
 FISM+fKL8q96IS2Njp0eWxr0CYL51S9k+uXJ1TftG0XKPubwIH0+aJ+PapRkmB6no0ps
 SEIwu8wq9pn+AyguI+1iDy4mPHZCezxjqnsgY11h6vQ+IJ58CUeN0PesvhZVBS5jrd2j
 RYZj1pWToaoVRnE3GVV45irfTZft2Uj+U3xHpyiXAQtvYCXYW9lTFK+Y8BlGZKzGNDaf
 la7TAhPuYpHnw+GQWP97Z+K02/pP+v4ABKmZGBY4ocwrI/yNkSiAl25IWNJqNQgTlLYM
 LiNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tOXqqQIKxCE3fAslrFlFgyBgp0iUgXeNGD0vo0kS0Yg=;
 b=FK7pFX1ePccHvem9SPsQqc4ekfSHiJ4zCiqfnAy2VoSlhia+sB2sdJxP5UeVPdZKya
 KwaOjVL1Qa700DZVGI5Tr2Q2hTHjw2fDXMFxpdAisbAgOzz1zxG/vAs2jHQcAZeEJamV
 b3m3OczZHijXuTvkfL/SEFRStKp6HcPU7ByYD99MyWiFrXqKRmSOU95eLNVNDD/a5RLP
 1Qy7FM93JxWBP4Ewtky9Fma90jG7cQf7ZbazZWKMWhxapsJWize6cHNe8MvCyhixZnhR
 2ZAsrJj5okcwkPAl+HX/+gf7GgQr5qinpK6ygS+ue0B4P9lo/hJ44qZJ0nSsAazVR9ql
 cFKg==
X-Gm-Message-State: AGi0PubDEy1i8SC7BOsmXvHTU4QrMxrzu6ioKEuqlFHwPbRlzMZK7/0x
 B+7D2ysMSfUIpHilYzdHbRo89rsbqbY=
X-Google-Smtp-Source: APiQypKjH4cv+7G1F3yBIyxw15J9bOo8j1X/fJMZ5hDYzDgJT9C1pb7c9G710zjE8W7Xlsd6nZc2sg==
X-Received: by 2002:a17:902:8202:: with SMTP id
 x2mr23045093pln.287.1587989384923; 
 Mon, 27 Apr 2020 05:09:44 -0700 (PDT)
Received: from localhost.localdomain ([1.38.220.114])
 by smtp.gmail.com with ESMTPSA id r17sm9623885pgn.35.2020.04.27.05.09.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2020 05:09:44 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 27 Apr 2020 17:38:25 +0530
Message-Id: <20200427120834.380-15-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200427120834.380-1-jaskaransingh7654321@gmail.com>
References: <20200427120834.380-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 27 Apr 2020 14:09:48 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 27 Apr 2020 14:09:46 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 14/23] parsing_cocci: ast_cocci: Add Parameter
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

Add parameter attributes to the SmPL AST. This is a list of attributes
in the VoidParam and Param types of the SmPL AST.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/ast_cocci.ml  | 4 ++--
 parsing_cocci/ast_cocci.mli | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/parsing_cocci/ast_cocci.ml b/parsing_cocci/ast_cocci.ml
index 9b147e5c..919d1dcc 100644
--- a/parsing_cocci/ast_cocci.ml
+++ b/parsing_cocci/ast_cocci.ml
@@ -487,8 +487,8 @@ and initialiser = base_initialiser wrap
 (* Parameter *)
 
 and base_parameterTypeDef =
-    VoidParam     of fullType
-  | Param         of fullType * ident option
+    VoidParam     of fullType * attr list
+  | Param         of fullType * ident option * attr list
 
   | MetaParam     of meta_name mcode * constraints * keep_binding * inherited
   | MetaParamList of meta_name mcode * listlen * constraints * keep_binding *
diff --git a/parsing_cocci/ast_cocci.mli b/parsing_cocci/ast_cocci.mli
index c56bba88..4b6e7296 100644
--- a/parsing_cocci/ast_cocci.mli
+++ b/parsing_cocci/ast_cocci.mli
@@ -468,8 +468,8 @@ and initialiser = base_initialiser wrap
 (* Parameter *)
 
 and base_parameterTypeDef =
-    VoidParam     of fullType
-  | Param         of fullType * ident option
+    VoidParam     of fullType * attr list
+  | Param         of fullType * ident option * attr list
 
   | MetaParam     of meta_name mcode * constraints * keep_binding * inherited
   | MetaParamList of meta_name mcode * listlen * constraints * keep_binding *
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
