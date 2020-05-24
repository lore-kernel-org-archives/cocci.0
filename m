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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5FEAC433E1
	for <cocci@archiver.kernel.org>; Sun, 24 May 2020 17:20:23 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60BEB206C3
	for <cocci@archiver.kernel.org>; Sun, 24 May 2020 17:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uFhRGs/B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60BEB206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04OHKHF1012073;
	Sun, 24 May 2020 19:20:17 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B539D7831;
	Sun, 24 May 2020 19:20:12 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id DA7257829
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 19:20:10 +0200 (CEST)
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1043])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04OHK99l001959
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 19:20:10 +0200 (CEST)
Received: by mail-pj1-x1043.google.com with SMTP id s69so7579602pjb.4
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 10:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zKPGjrkPgCc5+L/QF59TLkvDaDdORkt/dY/weLlHyUU=;
 b=uFhRGs/BpBeCRLDZwJndYuBKYqxJr7vEjcroSpPXRMSdKiZ6PHuO8oRORSDd43QRH+
 +UaxEE7skT3QenPEyctOmLHDgtNIBkFseZjlz/UwykV29/FSRbbDN0E9kF3BGiukE6Lo
 QEZuytuAs1iy/UDlaqKxBPAyqUJ93oFCGlasVi3McW5kW7sHEVMmncZn+6QImnnZDZ6G
 Cx7OOkQGRsytMKd6EHO8mZBrJh9shG6zNMbvX0vqpQn7UYo4JeFnq7Be//gTefGfIjLi
 FY4hY3TAJX15FgbtKE+TX9UEx1ejhjjUBTP5FN23RQwkOh4wizIkt3PAPVxcv5vgLYJ3
 jkgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zKPGjrkPgCc5+L/QF59TLkvDaDdORkt/dY/weLlHyUU=;
 b=CdgIneAJExuLy3EzQ4ZH7STPVFkTvlj2KiAUVPClyeiUT52rP/cep/iYj6c3jqzmJf
 XraJ5UrlNCMVleSX8CCEZbD0wdpjYqYgBXXK2vB7QTWRK0ylz5plOJUGQwfIdQzlUYJi
 o0riCuS4Qd6qNWqmaeFB8XDEiVfrAoLramStBvCw1PNnVEy7V9+tuyQyCKi0Lftlca7h
 Id1FsuApFPvUxAN3Az29JxCLpGPk4B1vhXXcoSYAk6HcSQ6DRSoJB2vRfKGZEV2d4uad
 O/HblQs9+MZ9G2smbS/HZMAClM89hAwoZs0w49IqPxa9Iwe2J+5eB2BAPCY7sziT0duA
 pNbg==
X-Gm-Message-State: AOAM530Kqvns5QW9kxUOHpYDpiaHk6Dwas1Ipx5grx2iVe4BSVjvSLhB
 6iFVXLPWDJcnbuPY4U/Habi9G45Gnas=
X-Google-Smtp-Source: ABdhPJxiyNKWFliGgR/L22FbeWd81ju1lWjJXRsKXRcrd5qWe6WiP+WjJLHqQBfR7iBepWyPoh2sJQ==
X-Received: by 2002:a17:90a:30ef:: with SMTP id
 h102mr16318903pjb.110.1590340808477; 
 Sun, 24 May 2020 10:20:08 -0700 (PDT)
Received: from localhost.localdomain ([1.38.220.54])
 by smtp.gmail.com with ESMTPSA id d9sm6556497pfn.72.2020.05.24.10.20.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2020 10:20:08 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sun, 24 May 2020 22:49:06 +0530
Message-Id: <20200524171935.2504-2-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200524171935.2504-1-jaskaransingh7654321@gmail.com>
References: <20200524171935.2504-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 24 May 2020 19:20:17 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 24 May 2020 19:20:10 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 01/30] parsing_cocci: ast0_cocci: Add Macrodecl
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

Add Macrodecl attributes to AST0 of SmPL. These attributes are for the
MacroDecl type of SmPL AST0.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/ast0_cocci.ml  | 3 ++-
 parsing_cocci/ast0_cocci.mli | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/parsing_cocci/ast0_cocci.ml b/parsing_cocci/ast0_cocci.ml
index a06d99ae..bf2b5633 100644
--- a/parsing_cocci/ast0_cocci.ml
+++ b/parsing_cocci/ast0_cocci.ml
@@ -255,7 +255,8 @@ and base_declaration =
   | TyDecl of typeC * string mcode (* ; *)
   | MacroDecl of Ast.storage mcode option *
 	ident (* name *) * string mcode (* ( *) *
-        expression dots * string mcode (* ) *) * string mcode (* ; *)
+        expression dots * string mcode (* ) *) *
+        attr list * string mcode (* ; *)
   | MacroDeclInit of Ast.storage mcode option *
 	ident (* name *) * string mcode (* ( *) *
         expression dots * string mcode (* ) *) * string mcode (*=*) *
diff --git a/parsing_cocci/ast0_cocci.mli b/parsing_cocci/ast0_cocci.mli
index 5c2520be..e2a9a9d8 100644
--- a/parsing_cocci/ast0_cocci.mli
+++ b/parsing_cocci/ast0_cocci.mli
@@ -243,7 +243,8 @@ and base_declaration =
   | TyDecl of typeC * string mcode (* ; *)
   | MacroDecl of Ast_cocci.storage mcode option *
 	ident (* name *) * string mcode (* ( *) *
-        expression dots * string mcode (* ) *) * string mcode (* ; *)
+        expression dots * string mcode (* ) *) *
+        attr list * string mcode (* ; *)
   | MacroDeclInit of Ast_cocci.storage mcode option *
 	ident (* name *) * string mcode (* ( *) *
         expression dots * string mcode (* ) *) * string mcode (*=*) *
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
