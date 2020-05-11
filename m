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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34DAC47255
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:14:26 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22F6D207DD
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXAETA4U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22F6D207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04BAEDn1004670;
	Mon, 11 May 2020 12:14:13 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 7EF513E6B;
	Mon, 11 May 2020 12:14:13 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7D8FB3DC8
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:14:12 +0200 (CEST)
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:644])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04BAEAlg008401
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:14:11 +0200 (CEST)
Received: by mail-pl1-x644.google.com with SMTP id t16so3739075plo.7
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 03:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tOXqqQIKxCE3fAslrFlFgyBgp0iUgXeNGD0vo0kS0Yg=;
 b=KXAETA4UVCFUDV1AdBnlji0738eHHuB+3/xueJznEgFw3d2CJTH5eeEUVLeD1N5peV
 cYqFgzOaEcwsDopb25DxMeivl3OTj/lEFLBYKmHEQB+5iHBszN1SoASBhWBboRY/vUGb
 ke9ya5Jtdk7eDxK15wE0PGpL10DfgcGjFSVc4YQETCvX1VoSPXW+1R36tmzlB15qYEyQ
 eP+k3qUrB5IhWEG2q/ue+U/DrsYC+DAJvhKaP9LTNYM4i3DacIXZzD1UOgHP4UxMjVSp
 t29Ipc4lKzomXpH2kP+OtreboFrXp9EZEbhd9w6Jfj2mhCIm6qiZtSGqoWwCqqo0K0ED
 XaPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tOXqqQIKxCE3fAslrFlFgyBgp0iUgXeNGD0vo0kS0Yg=;
 b=JMndCCxDSJVVjw1dQk8xfCDr6xmlJL1boR55tEaAGMrj2nnPY+h3hmpAJ2+S+SVfZI
 l5x9nc/wQGtKSQ+LwvGemASNJUpuZ1RNVR/3bgbTt5k+Ht+PuVTeuGeA+tTWDY1DnmlV
 YQvKA8oI8OnJfqYODGVzwtr5f0k7Rnq6vhgtYSadFs5db0Dz48zm6nreNMIJIuGGT9Ae
 ik43qeM9u3aXGdL5oOXLGm70koSrllGWX9cYQ+V1cOOpUSmZJbotXzHzgFIWgNRUcYEH
 naqBRut8MljFT+c9szxUJW/TQGptiEZemhQFjafOoZe7KBzr29NN7694YvhjTGaiAm77
 2WUQ==
X-Gm-Message-State: AGi0PuZ6DmJQk6DFFjcPwAPDYHIpCrJ0R4NStUwk3hKJZfmHCWWOTPLB
 2h1s2FHWFbheflD9N2fpi75g3Xzbyr8=
X-Google-Smtp-Source: APiQypKAD+OW8E7wOVy9poLG0HCiaZzJIuRDy+ZQ0S1r3/++Zd7aPy3Yx9R1xkfobkQJVGX2oir5Ww==
X-Received: by 2002:a17:90a:2046:: with SMTP id
 n64mr21596646pjc.230.1589192050120; 
 Mon, 11 May 2020 03:14:10 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:382:66db:4729:1ab8:2139:8945])
 by smtp.gmail.com with ESMTPSA id
 j14sm10021121pjm.27.2020.05.11.03.14.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 03:14:09 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 11 May 2020 15:42:51 +0530
Message-Id: <20200511101300.11101-15-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200511101300.11101-1-jaskaransingh7654321@gmail.com>
References: <20200511101300.11101-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 11 May 2020 12:14:13 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 11 May 2020 12:14:12 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v3 14/23] parsing_cocci: ast_cocci: Add Parameter
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
