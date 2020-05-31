Return-Path: <SRS0=O8dQ=7N=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE57BC433DF
	for <cocci@archiver.kernel.org>; Sun, 31 May 2020 15:28:04 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AAFC206DA
	for <cocci@archiver.kernel.org>; Sun, 31 May 2020 15:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3QvUWvu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AAFC206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04VFS1p8027767;
	Sun, 31 May 2020 17:28:01 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B69B77752;
	Sun, 31 May 2020 17:28:01 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id EE8EA3C89
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 17:27:59 +0200 (CEST)
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:642])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04VFRwUp026863
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 17:27:59 +0200 (CEST)
Received: by mail-pl1-x642.google.com with SMTP id y18so1426328plr.4
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 08:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mB0J9jFpe+iFVZmvfWg1x2ixXm3XmVvZibanMHUFwpo=;
 b=j3QvUWvu5TdxaB+Jnsdp1BzDq9l/6fJO4xsmT89SI15QU9m0cMX+rMWYCM8QG3JRYb
 0HAexwILkF7N7xD6czlLdYkjq1p+2jQuc0htXWWBPmQT4lpD+R9l5Jj+8McLyKsJEGe+
 S+NjN0TXAGduFnts2xr5kgeLr+1yLWWG3yU2kc6ZsqsTToFughnnF/GoTXamvrQ/MiX4
 hVuUjRV+hUuX7kyQhyhA1/oMpDYpL/aaD+K4XYwgrTg5yLCvR9C5q8mXKd2NhclcYmwW
 iI/3jcOaSHNjWPLvl2Zz5t2ehBPSOIiP0Lk9PKywIaDE3aBy3g71qqTCjTI4wswUb+gf
 Vb/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mB0J9jFpe+iFVZmvfWg1x2ixXm3XmVvZibanMHUFwpo=;
 b=HSGlNbpjjmr82q89RLLhciJuBvisTlujn+fXaFOTa8NCXAB2msaaycZP9zGSKVk4zI
 2hhTR8vwX2VCG7Oi/Fgmq/ONmbDXROO8K/S0Bh3YLA6PKZW6uX5O7RCDeBiUDHyZNnca
 pxwMar8w5tIXrtDPVj2VKT6rwV/nN3C6lheynkaGVMYmBR9rqp+Qf04HMgRQeHOF4o05
 VJoMoJB7sNAMz4Fnw1bMFX8shNT/rpcVgPcuT+QcR7uoD26Q3bOOLOzxzl8pWcjnUX9R
 togN7ZMFhmFvIddh6o/SuFI3dO1O3uXtZ/XejAxUPAM+pYYuuGZ3Vkhjs5fwgeO4+pHF
 ic+g==
X-Gm-Message-State: AOAM533f9YCTKh1gpJFrvM4/S1Lz5SaovFCS0AiAfbWwkPKpD3TMpFjE
 fRUCFuvtIQUs17oai4A9Jwr7tdCc
X-Google-Smtp-Source: ABdhPJydpk7/X7mphC6nDNKXHa47j5dmAyPg7ecIvMooRakv6HJOLBu2UuZmPoKZpOPZVG14Fbingw==
X-Received: by 2002:a17:902:14f:: with SMTP id
 73mr16493574plb.86.1590938877594; 
 Sun, 31 May 2020 08:27:57 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:1863:fef5:a170:128b:8ef:499d])
 by smtp.gmail.com with ESMTPSA id 131sm12310443pfv.139.2020.05.31.08.27.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2020 08:27:57 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sun, 31 May 2020 20:56:11 +0530
Message-Id: <20200531152621.2886-18-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200531152621.2886-1-jaskaransingh7654321@gmail.com>
References: <20200531152621.2886-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 31 May 2020 17:28:01 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 31 May 2020 17:27:59 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 17/27] parsing_cocci: adjust_pragmas: Reflect struct
	end attributes
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

Struct end attributes are added to the SmPL AST. Reflect these changes
in adjust_pragmas.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/adjust_pragmas.ml | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/parsing_cocci/adjust_pragmas.ml b/parsing_cocci/adjust_pragmas.ml
index e5597943..b328ad27 100644
--- a/parsing_cocci/adjust_pragmas.ml
+++ b/parsing_cocci/adjust_pragmas.ml
@@ -60,9 +60,9 @@ let rec right_decl d =
   | Ast0.MacroDeclInit(stg,name,lp,args,rp,eq,ini,sem) ->
       call_right right_mcode sem d
 	(function sem -> Ast0.MacroDeclInit(stg,name,lp,args,rp,eq,ini,sem))
-  | Ast0.TyDecl(ty,sem) ->
+  | Ast0.TyDecl(ty,attr,sem) ->
       call_right right_mcode sem d
-	(function sem -> Ast0.TyDecl(ty,sem))
+	(function sem -> Ast0.TyDecl(ty,attr,sem))
   | Ast0.Typedef(stg,ty,id,sem) ->
       call_right right_mcode sem d
 	(function sem -> Ast0.Typedef(stg,ty,id,sem))
@@ -292,8 +292,8 @@ let rec left_decl decl =
   | Ast0.MacroDeclInit(None,name,lp,args,rp,eq,ini,sem) ->
       call_right left_ident name decl
 	(function name -> Ast0.MacroDeclInit(None,name,lp,args,rp,eq,ini,sem))
-  | Ast0.TyDecl(ty,sem) ->
-      call_right left_ty ty decl (function ty -> Ast0.TyDecl(ty,sem))
+  | Ast0.TyDecl(ty,attr,sem) ->
+      call_right left_ty ty decl (function ty -> Ast0.TyDecl(ty,attr,sem))
   | Ast0.Typedef(stg,ty,id,sem) ->
       call_right left_mcode stg decl
 	(function stg -> Ast0.Typedef(stg,ty,id,sem))
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
