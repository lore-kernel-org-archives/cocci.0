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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D7EC433E0
	for <cocci@archiver.kernel.org>; Sun, 24 May 2020 17:22:45 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C8CD207DA
	for <cocci@archiver.kernel.org>; Sun, 24 May 2020 17:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qe5K+uTL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C8CD207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04OHMhDO009503;
	Sun, 24 May 2020 19:22:43 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E807C3DC8;
	Sun, 24 May 2020 19:22:42 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 0D5DB3D0F
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 19:22:42 +0200 (CEST)
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:642])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04OHMeo0010344
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 19:22:41 +0200 (CEST)
Received: by mail-pl1-x642.google.com with SMTP id x10so6623330plr.4
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 10:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GAD46fD01aNyn20JNooZb90mKKDcnOlC71QcSJBDLwE=;
 b=qe5K+uTL/WjhPUP1FJu5+Uj6kg18IWM+Kmd6qWk22kds9B5bn8T/Q1AxuJGTfuhKZn
 pPpxyTq98F1Kak8prEO2wYuuREvu4cm17djz/YvBa+UrBOdyin9cKsjIzMAMnXWsaCV5
 mheWeqk8IDp62pdySglgxtSrdh99YLUPA9WKUUi6+ma0VAZ/164C4/b2bGeFpcDk3J/s
 jdwrWGx8pJU1k4CZ67b6PMUzeOM2GbXQLbyghgnrFlYTYmV/M8xA7PPHUaByuMTTkFuU
 +9H9uIfVEjUnpp790E+H+N/iu96YxBicq8YXXG2DKI6YWCgF738zn82sS9QECFzPZUjd
 HFeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GAD46fD01aNyn20JNooZb90mKKDcnOlC71QcSJBDLwE=;
 b=f38ZeEFeOhMMaxqQF/jZXiS81SrbPqBvVQ7cQqBy1jhePHih29dwUK0hQteBgblHB2
 QPyg3Tb2WhBVOnNDN4MQGVdJX4Cb3MdQFUrjEfdb1b+XWrNYtNTb5RQyCwg9+IjgsaC2
 n0Zv7tkeUYcLAJmlefcJHtBaixpwfxHcxUi3XXN/B+Dx45GtDPdQF3fqYvXc7/VzS3T9
 CZk4H7/KcPwblEAR8Accd3gXZ0uRtEaPY2uEtnWMUdBctKKUZmq/n+J0MS7McG9gsS7E
 RavtnyK+RAshPDw9matalq11HQkVqUHW6g5TbUDAhmf4AKmYA9s9vp6VByKIYu2lEHU6
 sThw==
X-Gm-Message-State: AOAM533aeJtMuxUjFgS68rhMwwVLhEC2N7Y1csTyP22oW+Q6J4eTkvQg
 8vD17Q+syrqYUwUboLn9fgVTcBQVxWA=
X-Google-Smtp-Source: ABdhPJz6ng3nBuHvVtD1aI+okrXPWNFLjXpkbaMjzOr3Ske9SWRUk2nQOU0J+h3MvaKaIXLycxINgw==
X-Received: by 2002:a17:90a:fd85:: with SMTP id
 cx5mr16284420pjb.146.1590340959627; 
 Sun, 24 May 2020 10:22:39 -0700 (PDT)
Received: from localhost.localdomain ([1.38.220.54])
 by smtp.gmail.com with ESMTPSA id d9sm6556497pfn.72.2020.05.24.10.22.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2020 10:22:39 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sun, 24 May 2020 22:49:32 +0530
Message-Id: <20200524171935.2504-28-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200524171935.2504-1-jaskaransingh7654321@gmail.com>
References: <20200524171935.2504-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 24 May 2020 19:22:43 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 24 May 2020 19:22:41 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 27/30] ocaml: coccilib: Reflect Macrodecl attributes
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

Macrodecl attributes are added to the C and SmPL ASTs. Reflect these
changes in coccilib.mli.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 ocaml/coccilib.mli | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/ocaml/coccilib.mli b/ocaml/coccilib.mli
index 5e31eec3..264c01b2 100644
--- a/ocaml/coccilib.mli
+++ b/ocaml/coccilib.mli
@@ -288,7 +288,9 @@ module Ast_c :
     and declaration =
       Ast_c.declaration =
         DeclList of onedecl wrap2 list wrap
-      | MacroDecl of (storagebis * string * argument wrap2 list * bool) wrap
+      | MacroDecl of
+          (storagebis * string * argument wrap2 list * attribute list * bool)
+            wrap
       | MacroDeclInit of
           (storagebis * string * argument wrap2 list * initialiser) wrap
     and onedecl =
@@ -2765,7 +2767,7 @@ module Ast_cocci :
           (string mcode * string mcode) option * string mcode * string mcode
       | TyDecl of fullType * string mcode
       | MacroDecl of storage mcode option * ident * string mcode *
-          expression dots * string mcode * string mcode
+          expression dots * string mcode * attr list * string mcode
       | MacroDeclInit of storage mcode option * ident * string mcode *
           expression dots * string mcode * string mcode * initialiser *
           string mcode
@@ -3400,7 +3402,7 @@ module Ast0_cocci :
           (string mcode * string mcode) option * string mcode * string mcode
       | TyDecl of typeC * string mcode
       | MacroDecl of Ast_cocci.storage mcode option * ident * string mcode *
-          expression dots * string mcode * string mcode
+          expression dots * string mcode * attr list * string mcode
       | MacroDeclInit of Ast_cocci.storage mcode option * ident *
           string mcode * expression dots * string mcode * string mcode *
           initialiser * string mcode
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
