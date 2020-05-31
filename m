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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36217C433E0
	for <cocci@archiver.kernel.org>; Sun, 31 May 2020 15:27:52 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7DE4206DA
	for <cocci@archiver.kernel.org>; Sun, 31 May 2020 15:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYaAn/2T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7DE4206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04VFRm5E000511;
	Sun, 31 May 2020 17:27:48 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id DD2957752;
	Sun, 31 May 2020 17:27:48 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 349333C89
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 17:27:47 +0200 (CEST)
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1042])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04VFRjbP020610
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 17:27:46 +0200 (CEST)
Received: by mail-pj1-x1042.google.com with SMTP id q24so3806368pjd.1
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 08:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mSFkdGTHEJ1lLgnaIQE+lT+3xEfFvshh+vBMY9FtqDc=;
 b=YYaAn/2Tr2wj10lgdWP6KL5gizj1XydwVFvPvYzY1boiC0YMbQU2Ddka2iWKoC3Zgn
 wcZIif9L+ajVVZaUVEnNPy1AzzfVNsRUkkzZbkx/7Rskb/O8ciIRxnIpxcfMu/KUXlDB
 0AY/FihvDRtsC2dTjCH/WXinv2J7oZFLP+s8bsigXKP43okZ+RwROIe2yDzoPbIckFit
 MvlolqMjhhdco/66Y6MJR/mmtxBQ6ISAO5+j1boG73moHSFyHxv10jbSWuh1ArQoQKr5
 k53xqkjbkEsAuUhaVMt1FChEhr8SbyIOt4C4ljAF3POFwt+3de3fUyqQcWu/w0Tw9eTm
 TBBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mSFkdGTHEJ1lLgnaIQE+lT+3xEfFvshh+vBMY9FtqDc=;
 b=PhAcP6RxLur7QKW/eQThlkPscvE+ktoKmpC7bUlPBPhyaTWZkB8j9E8Ao+PX1FWUgq
 d47OabfqlsEH4FtEDnxyAgFkc3qlh7CowTap4CP9uLWsQ4LdKGU9ck01QoyyyNjnn0xu
 reYytoZzMgJBWdbD2JXwOfCtLj10DrZo8uSqM1iaC+XyrN3eYqaiUFtnSdwS0pIwhM5y
 NhV91K3TNYyUwxhyoMRW4v4wTGFKWEQnDWmFK+c0VHSFaGHtwFZdqr0Oi/4Wa5KCw2vz
 F9mEMcO4TttHcwPcyay2rtkGU+sxS00DuZpoQ0kmHUCF9mJ71VFOh7AyMKWyxbgYLYf2
 peVg==
X-Gm-Message-State: AOAM532csSRaNHvN/aZL46nhe1nIPNlVK5zaoJD+SaZA6b5l/0n/isMM
 VWrGtfnzkujNObW9NPBLwUYO+rIH
X-Google-Smtp-Source: ABdhPJwoxIw5ZQPlqXzkv/Qn/EbYy10PzLaP+ayaY0dprYqzJvUnfFPPeFptusep5FfGq0/vzITmKg==
X-Received: by 2002:a17:90a:3426:: with SMTP id
 o35mr5274980pjb.27.1590938864864; 
 Sun, 31 May 2020 08:27:44 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:1863:fef5:a170:128b:8ef:499d])
 by smtp.gmail.com with ESMTPSA id 131sm12310443pfv.139.2020.05.31.08.27.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2020 08:27:44 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sun, 31 May 2020 20:56:07 +0530
Message-Id: <20200531152621.2886-14-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200531152621.2886-1-jaskaransingh7654321@gmail.com>
References: <20200531152621.2886-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 31 May 2020 17:27:48 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 31 May 2020 17:27:46 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 13/27] parsing_cocci: ast_cocci: Add struct end
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

Add struct end attributes to the SmPL AST. This is a list of attributes
in the TyDecl type of the SmPL AST.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/ast_cocci.ml  | 2 +-
 parsing_cocci/ast_cocci.mli | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/parsing_cocci/ast_cocci.ml b/parsing_cocci/ast_cocci.ml
index b4b74a67..403756c4 100644
--- a/parsing_cocci/ast_cocci.ml
+++ b/parsing_cocci/ast_cocci.ml
@@ -396,7 +396,7 @@ and base_declaration =
 	string mcode (* ( *) * parameter_list *
 	(string mcode (* , *) * string mcode (* ...... *) ) option *
 	string mcode (* ) *) * string mcode (* ; *)
-  | TyDecl of fullType * string mcode (* ; *)
+  | TyDecl of fullType * attr list * string mcode (* ; *)
   | MacroDecl of storage mcode option *
 	ident (* name *) * string mcode (* ( *) *
         expression dots * string mcode (* ) *) *
diff --git a/parsing_cocci/ast_cocci.mli b/parsing_cocci/ast_cocci.mli
index 77dba10f..873e1d31 100644
--- a/parsing_cocci/ast_cocci.mli
+++ b/parsing_cocci/ast_cocci.mli
@@ -378,7 +378,7 @@ and base_declaration =
 	string mcode (* ( *) * parameter_list *
 	(string mcode (* , *) * string mcode (* ...... *) ) option *
 	string mcode (* ) *) * string mcode (* ; *)
-  | TyDecl of fullType * string mcode (* ; *)
+  | TyDecl of fullType * attr list * string mcode (* ; *)
   | MacroDecl of storage mcode option *
 	ident (* name *) * string mcode (* ( *) *
         expression dots * string mcode (* ) *) *
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
