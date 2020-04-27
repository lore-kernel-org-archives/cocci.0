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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1824AC5519A
	for <cocci@archiver.kernel.org>; Mon, 27 Apr 2020 12:09:18 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AC09206BF
	for <cocci@archiver.kernel.org>; Mon, 27 Apr 2020 12:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F38hnRqt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AC09206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03RC92rs027442;
	Mon, 27 Apr 2020 14:09:02 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 199A7783A;
	Mon, 27 Apr 2020 14:08:55 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 748197839
 for <cocci@systeme.lip6.fr>; Mon, 27 Apr 2020 14:08:53 +0200 (CEST)
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:441])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03RC8pp8019741
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 27 Apr 2020 14:08:52 +0200 (CEST)
Received: by mail-pf1-x441.google.com with SMTP id x15so8934212pfa.1
 for <cocci@systeme.lip6.fr>; Mon, 27 Apr 2020 05:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bpLTgt82Ti31oCPVD1pdgcNX51JVNVAJJuqnmPIy5S0=;
 b=F38hnRqtkDW6hCSyIln+Tt5oq5BOvM4Q+wlhnr+GrxtTX9wNkm9/untzFs2/3Wsji+
 ZtIyoXX70buMyRQvhCoxh5kwVg6IdahF8NiAg2OBByElQFOplYNCMzCUr+cJHaPG65Mv
 wweO1GOb5xDtAJTHBQTlLX8X83A23+SbUny0Y+vMZZrhHINWFjPr6goNXBbYqRV940+N
 Hc0eXReLY2wY9AiDtlN2W3TF6D+vj4TGHaYOK2cw8hgUSVkal85sv7VFXF3huaAk/DaA
 u2E7dq/AQM5Q0KHIOEqZaftUcvcUZs6su7PvlgeRYUwjERcqXpm054XrosOmZPQw/VAM
 +waQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bpLTgt82Ti31oCPVD1pdgcNX51JVNVAJJuqnmPIy5S0=;
 b=eHUfj4Wwdg/LHe6FBCWOpN53cgBtCfhvL8I4p2+kUiHLPgG3PL/2ILl3PvnLFvU3Zx
 DpV37d5Q1bYrmazscudK/+Ow7u0K3VEe9n+hAw++wAtXznIR2R5+mzgfp/RRkZ96qcK5
 ADTFmLcyL4fzGYLMs9voBOnnJXLU5a8EZ16uffI2kZlQmrPE6n4YE/2+dhi15gwRPc11
 ukGzqV3blqS10EDxp5JTA0cuIESUWK8DQWz19mCe15F1hp1gmUSTqgKjM6v7dqEzE8D+
 kuaAMpt8ytlsfBynRHSXMtNLkTxqa+CYZNYXOWlRNVwp0uLJzkjus0qZ4T9HrvX8FDOr
 xRxg==
X-Gm-Message-State: AGi0Pub2U/4AGKdGV887ws+VZ5k8crQFX33DMliQdPvPVnb7XREXeuwt
 kRyaVGgn8dj+C4niSAfeKoKwgqAYsqw=
X-Google-Smtp-Source: APiQypKbFcu4Ch6ZHpnK5cxFhHh8/790Xgu/biQNivMdIlQMkDNcLyvHokCcjJOltgbDLnOQ/k+5Cw==
X-Received: by 2002:a63:1414:: with SMTP id u20mr5354822pgl.47.1587989330808; 
 Mon, 27 Apr 2020 05:08:50 -0700 (PDT)
Received: from localhost.localdomain ([1.38.220.114])
 by smtp.gmail.com with ESMTPSA id r17sm9623885pgn.35.2020.04.27.05.08.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2020 05:08:50 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 27 Apr 2020 17:38:12 +0530
Message-Id: <20200427120834.380-2-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200427120834.380-1-jaskaransingh7654321@gmail.com>
References: <20200427120834.380-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 27 Apr 2020 14:09:02 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 27 Apr 2020 14:08:53 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 01/23] parsing_cocci: ast0_cocci: Add parameter
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

Add parameter attributes to AST0 of SmPL. This is a list of attributes
in the VoidParam and Param types of AST0.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/ast0_cocci.ml  | 4 ++--
 parsing_cocci/ast0_cocci.mli | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/parsing_cocci/ast0_cocci.ml b/parsing_cocci/ast0_cocci.ml
index a06d99ae..8d30daea 100644
--- a/parsing_cocci/ast0_cocci.ml
+++ b/parsing_cocci/ast0_cocci.ml
@@ -334,8 +334,8 @@ and initialiser_list = initialiser dots
 (* Parameter *)
 
 and base_parameterTypeDef =
-    VoidParam     of typeC
-  | Param         of typeC * ident option
+    VoidParam     of typeC * attr list
+  | Param         of typeC * ident option * attr list
   | MetaParam     of Ast.meta_name mcode * constraints * pure
   | MetaParamList of Ast.meta_name mcode * listlen * constraints * pure
   | AsParam       of parameterTypeDef * expression (* expr, always metavar *)
diff --git a/parsing_cocci/ast0_cocci.mli b/parsing_cocci/ast0_cocci.mli
index 5c2520be..f66a1fac 100644
--- a/parsing_cocci/ast0_cocci.mli
+++ b/parsing_cocci/ast0_cocci.mli
@@ -320,8 +320,8 @@ and initialiser_list = initialiser dots
 (* Parameter *)
 
 and base_parameterTypeDef =
-    VoidParam     of typeC
-  | Param         of typeC * ident option
+    VoidParam     of typeC * attr list
+  | Param         of typeC * ident option * attr list
   | MetaParam     of Ast_cocci.meta_name mcode * constraints * pure
   | MetaParamList of Ast_cocci.meta_name mcode * listlen * constraints * pure
   | AsParam       of parameterTypeDef * expression (* expr, always metavar *)
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
