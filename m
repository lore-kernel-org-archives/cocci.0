Return-Path: <SRS0=O8dQ=7N=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405E2C433DF
	for <cocci@archiver.kernel.org>; Sun, 31 May 2020 15:27:22 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F240206DA
	for <cocci@archiver.kernel.org>; Sun, 31 May 2020 15:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lr7Cznm6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F240206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04VFRIZ9008867;
	Sun, 31 May 2020 17:27:18 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 4695F782D;
	Sun, 31 May 2020 17:27:10 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 41037782A
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 17:27:09 +0200 (CEST)
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1044])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04VFR7ZO003910
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 17:27:08 +0200 (CEST)
Received: by mail-pj1-x1044.google.com with SMTP id q9so3797908pjm.2
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 08:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nAkigKwio/NZLH//7Y0ZynzE7Fji0Kc43KzUv5ZRwR4=;
 b=lr7Cznm6clQCN3kSfdSjl1xs4gpzm8/0YcNI3/ltDPt44sqotfFXmPZQ8/WJjdiQMh
 aJ6Cdx8dKWvRNj5wlS24KQ7uLIGYI9+V2q16lsef54UWej+bOj1LPXeoyBN+VPN/A7np
 bD2ddkn1lWXGb4d0n61g5OzYdcd1oHLEIHSvbqdHyjT2Wd5u4NXmshxgp7rH/yadeZoC
 9l+CafPktatxCZ1Q2u5V+ptVDxPn1qXJazDTRkWc1Cf34vUSxbI+CsF6LuJBnfWCMfR4
 eUcM3gPET6dMeFf/hqQyuckCbOELyO+ItUqmrOZwaco4UUPtPg6hLRfQv62/wu9zoyGA
 tLYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nAkigKwio/NZLH//7Y0ZynzE7Fji0Kc43KzUv5ZRwR4=;
 b=s9A45ZosrFFxtlKB0H2V6/7d+eiHPpMhfdRJZ6W5ydDkAEIjF0Bjfqg7mp36CniDxZ
 AYiqn+FKrBc2FnPV6B//1fRlB97Ou1w31jnasa3zQmV2QWhs4xZ7NfDrtkaIN3OOTcgI
 gBhrrwqERnXGyieMpRnSdtgZjN2z6xnKVq82mcpF/zf75hBFWL3sAKl2fgNWgmfrZ9Ct
 4Rm5ARlB1xyL9YAayE8sNqV+p7vX/Ch7OYqN3QHRe9wdOe1DB3H2s6yV/tAWx8YWkrXS
 kKE6IvYHHgeEpodpEzreQmXpSdScgwaRdh5SehqYek8qh79zITLVx8D/HzaTbSQGH17c
 kDzQ==
X-Gm-Message-State: AOAM533VgrWpUXvX9ftgqBWImEWsjy2EUbvVo6WpC+Eixl5mL8Zx2NUR
 pgMatCXI/LcyYRJCzTezh/JSDW3x9MY=
X-Google-Smtp-Source: ABdhPJw5ela95bIzkdkfLh7K7w35fZgRCAen8HZjbH3vJAJoVJXDLtsscd89PBRt6KKgMEw2B4INAg==
X-Received: by 2002:a17:902:d70a:: with SMTP id
 w10mr16958191ply.256.1590938826844; 
 Sun, 31 May 2020 08:27:06 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:1863:fef5:a170:128b:8ef:499d])
 by smtp.gmail.com with ESMTPSA id 131sm12310443pfv.139.2020.05.31.08.27.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2020 08:27:06 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sun, 31 May 2020 20:55:55 +0530
Message-Id: <20200531152621.2886-2-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200531152621.2886-1-jaskaransingh7654321@gmail.com>
References: <20200531152621.2886-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 31 May 2020 17:27:18 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 31 May 2020 17:27:08 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 01/27] parsing_cocci: ast0_cocci: Add struct end
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

Add struct end attributes to AST0 of SmPL. This is a list of attributes
in the TyDecl type of AST0.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/ast0_cocci.ml  | 2 +-
 parsing_cocci/ast0_cocci.mli | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/parsing_cocci/ast0_cocci.ml b/parsing_cocci/ast0_cocci.ml
index 7714fd16..743fab86 100644
--- a/parsing_cocci/ast0_cocci.ml
+++ b/parsing_cocci/ast0_cocci.ml
@@ -252,7 +252,7 @@ and base_declaration =
         (string mcode (* , *) * string mcode (* ...... *) ) option *
 	string mcode (* ) *) *
 	string mcode (* ; *)
-  | TyDecl of typeC * string mcode (* ; *)
+  | TyDecl of typeC * attr list * string mcode (* ; *)
   | MacroDecl of Ast.storage mcode option *
 	ident (* name *) * string mcode (* ( *) *
         expression dots * string mcode (* ) *) *
diff --git a/parsing_cocci/ast0_cocci.mli b/parsing_cocci/ast0_cocci.mli
index f4b25abc..470c837f 100644
--- a/parsing_cocci/ast0_cocci.mli
+++ b/parsing_cocci/ast0_cocci.mli
@@ -240,7 +240,7 @@ and base_declaration =
 	string mcode (* ( *) * parameter_list *
         (string mcode (* , *) * string mcode (* ...... *) ) option *
 	string mcode (* ) *) * string mcode (* ; *)
-  | TyDecl of typeC * string mcode (* ; *)
+  | TyDecl of typeC * attr list * string mcode (* ; *)
   | MacroDecl of Ast_cocci.storage mcode option *
 	ident (* name *) * string mcode (* ( *) *
         expression dots * string mcode (* ) *) *
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
