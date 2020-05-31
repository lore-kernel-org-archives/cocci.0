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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A827C433DF
	for <cocci@archiver.kernel.org>; Sun, 31 May 2020 15:28:11 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECE1D206DA
	for <cocci@archiver.kernel.org>; Sun, 31 May 2020 15:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxNc46aO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECE1D206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04VFS8UQ007823;
	Sun, 31 May 2020 17:28:08 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B29F47752;
	Sun, 31 May 2020 17:28:08 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 995853C89
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 17:28:06 +0200 (CEST)
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1044])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04VFS4Ee012694
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 17:28:05 +0200 (CEST)
Received: by mail-pj1-x1044.google.com with SMTP id ga6so716724pjb.1
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 08:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=obqNGxFsfHrERCBXtTBHwvV1zwpfqul+fXkOGRiP1R4=;
 b=YxNc46aOSu7nfqHQ882OAhGogOqY8qKxndjpe0hUgzV1Dy2Rz32F0u+acJTKp4pyOc
 QaQDLiuRMQj2s0zePXTlIz8UepPtujll/C+uHrU+T7SJaVnzeD1eNIAbzLEw2LfdYTCQ
 nstibB//ib5a14qU3ohO5Qhl64o2QFgQ91E0wT6t0ApHVxq9bDpnL6bv7XHCNUTeakX7
 RH1w1qCokZBuZSrerf1C3EA2MS82vuezbTYEcnVG9n/BF3MJWKbWjWAGJwflz+iDvGfy
 gnbfNibGZLXDRudEmPJlBXDX7V7BWl8gyk0MABM59Le5c4k65Vie8LxjA+gw/PIztHNT
 QbwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=obqNGxFsfHrERCBXtTBHwvV1zwpfqul+fXkOGRiP1R4=;
 b=BdwEpLSWxx9ddcW/F1DnlpbSqGc9TNVD++g+A6VKyC+37Zw4CaF2t1XDJxcO5lteDX
 0yo4hBI/kuTqwgUet4PY1OMSb10M9FxRFbPmVPoYSzY65DSc13/sMl/NQVraHrrkuGrT
 EC/Ynca1r66e1+ia6Lfaj6/R05qLDHOVTUk406M+PUAXiirYtKplDA7aotaXQsdYNReW
 1mmgP+D9r0rVsUTR2x5WAftOfSQc5vOiDd2KyLYSQtsyzQlup+cTjoV8z8/ZFaI2HBRv
 o7EJYpdpCNjkm/UtnmSURRO6rYT4mqT7rCqSEF+4in1TBLXAnY/mQO+kD/vOCEbX/HK5
 2NJg==
X-Gm-Message-State: AOAM530u+n99jBJQI6ILVfikQsPyHCdp0HdV1sTW5q+gGYnIpmJnJF15
 66vKiTsqlhwbVOiwsL6Yv7pXs1By
X-Google-Smtp-Source: ABdhPJznDS+HNNBCyhjJlQ40vBSqmQrmslTeUYRFYxgO+5r82BKKA3sgQNO5p/CjkUU9Yk/FDc3wdA==
X-Received: by 2002:a17:90a:cb0b:: with SMTP id
 z11mr19293884pjt.58.1590938884324; 
 Sun, 31 May 2020 08:28:04 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:1863:fef5:a170:128b:8ef:499d])
 by smtp.gmail.com with ESMTPSA id 131sm12310443pfv.139.2020.05.31.08.28.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2020 08:28:03 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sun, 31 May 2020 20:56:13 +0530
Message-Id: <20200531152621.2886-20-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200531152621.2886-1-jaskaransingh7654321@gmail.com>
References: <20200531152621.2886-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 31 May 2020 17:28:08 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 31 May 2020 17:28:06 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 19/27] parsing_cocci: ast0toast: Reflect struct end
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
in ast0toast.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/ast0toast.ml | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/parsing_cocci/ast0toast.ml b/parsing_cocci/ast0toast.ml
index 30e27cc5..cba32af6 100644
--- a/parsing_cocci/ast0toast.ml
+++ b/parsing_cocci/ast0toast.ml
@@ -679,9 +679,10 @@ and declaration d =
 	let ini = initialiser ini in
 	let sem = mcode sem in
 	Ast.MacroDeclInit(stg,name,lp,args,rp,eq,ini,sem)
-    | Ast0.TyDecl(ty,sem) ->
+    | Ast0.TyDecl(ty,attr,sem) ->
 	let allminus = check_allminus.VT0.combiner_rec_declaration d in
-	Ast.TyDecl(typeC allminus ty,mcode sem)
+	let attr = List.map mcode attr in
+	Ast.TyDecl(typeC allminus ty,attr,mcode sem)
     | Ast0.Typedef(stg,ty,id,sem) ->
 	let allminus = check_allminus.VT0.combiner_rec_declaration d in
 	let id = typeC allminus id in
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
