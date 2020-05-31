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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095A3C433E0
	for <cocci@archiver.kernel.org>; Sun, 31 May 2020 15:28:08 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BBE4206DA
	for <cocci@archiver.kernel.org>; Sun, 31 May 2020 15:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLinAs4a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BBE4206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04VFS5VV019394;
	Sun, 31 May 2020 17:28:05 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 3B0447752;
	Sun, 31 May 2020 17:28:05 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 38BD03C89
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 17:28:03 +0200 (CEST)
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:644])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04VFS13B024796
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 17:28:02 +0200 (CEST)
Received: by mail-pl1-x644.google.com with SMTP id t7so3234631plr.0
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 08:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ypa/cklCORNcjL2zJfyieYe20TrbHtL6loA03muDGMI=;
 b=dLinAs4a98u9mNXs9OzbFlNlRuy05DJn2pvPGTFW9Gzt6qeWYMhXI+skzs7mgtT3b1
 ihoDwXDTxuJeIx/EGUo2AfrX1vVRSGnMdv3Qhxn4wiNl2AquEaGS0OaqIw/2Zi9EU+ca
 oYC4Jv/Y3n8MsCxf13aSvWolbbw7IkqS5E+Jyv60uUjvKEmkEg+IgUbT4i3ejhQUpYOf
 hUkQLD6DxaA8fnwGeVinvR3tyNlqci335aQQFCSpqG/w7lfBnGEyadhAHQoeRPhn//5o
 V5c97t6XbFkx8ySQGNqamws4Zd5h7ItFgWSaUcnrqtmUvZq/ykNleDkSxBv1OfH4Tw/I
 fY9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ypa/cklCORNcjL2zJfyieYe20TrbHtL6loA03muDGMI=;
 b=WtjfDUlQs25aAg8rsBNM4PPdy+Y6yM9wifxNHp59jtWbrMzyYurn3g5zLZq98G0byX
 ZuTvmebVzRjzmQM/NLHiAYyb3/oRyV+xOATH6Q/wpMmsIAiqhjnFlsGYT0a8VmUM/K/k
 zO0KhDQiUtb0hrSQsk92SCgwLmy+vZVma8gHWp+USbVl7SX3Te1z9IwJ7H6LOwOr7Mw0
 NzJkgk/iIOGltBlZI+lemSxskxsEZ1f00QgxIQg8MN1+rqXPt5/O95RA9z25n9CyuiQY
 h4RVnRMd6R75UE6pqCyEIHCnNcdxg8hJZrDoy7oVQlR1C6pwxTApR54cFXKsDrI8ghhU
 TVOg==
X-Gm-Message-State: AOAM533nAED39f9aUetdyngCmlnnCetdo+zBYAyfxaBNa1/B04haOn0Y
 /fzwk3D5e/17VVAhRZrUcefBqqAc
X-Google-Smtp-Source: ABdhPJwoEV5KCw1Ucud+mmhhzCYudK3vnmTEsq50AstMn/RBC7o1sp3jVgKednb8LkzPTxuSNA5KJA==
X-Received: by 2002:a17:90a:64c6:: with SMTP id
 i6mr17963995pjm.14.1590938880889; 
 Sun, 31 May 2020 08:28:00 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:1863:fef5:a170:128b:8ef:499d])
 by smtp.gmail.com with ESMTPSA id 131sm12310443pfv.139.2020.05.31.08.27.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2020 08:28:00 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sun, 31 May 2020 20:56:12 +0530
Message-Id: <20200531152621.2886-19-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200531152621.2886-1-jaskaransingh7654321@gmail.com>
References: <20200531152621.2886-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 31 May 2020 17:28:05 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 31 May 2020 17:28:02 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 18/27] parsing_cocci: unify_ast: Reflect struct end
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

Struct end attributes are added to the SmPL AST. Reflect these changes
in unify_ast.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/unify_ast.ml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/parsing_cocci/unify_ast.ml b/parsing_cocci/unify_ast.ml
index e36c0807..752e9283 100644
--- a/parsing_cocci/unify_ast.ml
+++ b/parsing_cocci/unify_ast.ml
@@ -426,7 +426,10 @@ and unify_declaration d1 d2 =
 	 unify_dots unify_expression edots args1 args2 &&
 	 unify_initialiser ini1 ini2
        else false
-  | (Ast.TyDecl(ft1,s1),Ast.TyDecl(ft2,s2)) -> unify_fullType ft1 ft2
+  | (Ast.TyDecl(ft1,attr1,s1),Ast.TyDecl(ft2,attr2,s2)) ->
+      if List.for_all2 unify_mcode attr1 attr2
+      then unify_fullType ft1 ft2
+      else false
   | (Ast.Typedef(stg1,ft1,id1,s1),Ast.Typedef(stg2,ft2,id2,s2)) ->
       unify_fullType ft1 ft2 && unify_typeC id1 id2
   | (Ast.DisjDecl(d1),_) ->
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
