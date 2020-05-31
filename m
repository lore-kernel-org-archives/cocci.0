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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B29C433E0
	for <cocci@archiver.kernel.org>; Sun, 31 May 2020 15:27:50 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A642A206DA
	for <cocci@archiver.kernel.org>; Sun, 31 May 2020 15:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBUQtU7s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A642A206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04VFRlIh009123;
	Sun, 31 May 2020 17:27:47 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 496E5777D;
	Sun, 31 May 2020 17:27:47 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id C59513C89
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 17:27:45 +0200 (CEST)
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1043])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04VFRg0N023176
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 17:27:43 +0200 (CEST)
Received: by mail-pj1-x1043.google.com with SMTP id t8so3804895pju.3
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 08:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3UmE142ozk56WcTfAaRf9t+aGuZk/Kq1Cwoxxq1VvCc=;
 b=dBUQtU7sndU51C+4RGiua+6M8+9z0jUZ61tVMcIcFoJBjvcif/ZQd/vGz3i+Z5eoXI
 RJ7BrkMHu5OxIqzyfiZsxLBTLMtd67o+XEMSWl7oEH3h8q017sA3eAuSQMp+hnZrDYG2
 3Ds61BLHtjOirZRiDAeQRKfCiIsrTnZVUwk+Jf0LOepqUz8BM6G0UtTV44tJ+R1EGG/g
 NQrRK8eRsxx4iZyljiguHo32elXEaMb+Bly6Vb0E92I/RtTY0mKcrnv5e7ndH9OPO9B5
 vbJkKuWlGgbTpO2uN/d6oxlyZhV+C2GhdVWxuUU2g6C9+J9lr9pWZCKv9DL2PXhcoxsM
 NgOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3UmE142ozk56WcTfAaRf9t+aGuZk/Kq1Cwoxxq1VvCc=;
 b=mD1lp71b9Li/9+SQmgBp3ZmCw45sBMJcHXP3RZxAnFR8IdbJ5G7pjOAdCHxpvat4X5
 OcoHPG0ZXdw7OqEMFHbtS+C+3MjdGaed6pCT+fL6cV6NlyBhciUZJEs6R8mxdlZzxLaJ
 Z5D7qjlZ3bIvWpYi+ZxezUToF71/uJREPvKAJbIoo5iBCEONk+5PzZYrP/EIILMMzrxL
 Mxm7ZwJeRJ1u6BPr5tsbA47AnsJRuX3D1tmbQCimEX/xVY8imTmaJ+XDmkZ1oIsI29RY
 FZeoUm6akOzFrboBMjeyjLCAvKl8cck0VPx3KBZS/jW5wrgxW4ZsIZl8vSvaQK5/DqhU
 23rg==
X-Gm-Message-State: AOAM5305HPUsu0cc3VMFSYHfhBfuwQShfU7Xh5DGTMw64x7ZWNCxCAmh
 Jb9fKkgtxl9OqMPAY2PbChi94641
X-Google-Smtp-Source: ABdhPJzjkrPU0/5fmr1/I5c5a4sc/0Z3S2I3LvOfs+fbmNKr3Ek6nkYNniUrcDPhuAADRHgEYJ5WDA==
X-Received: by 2002:a17:90a:1704:: with SMTP id
 z4mr18768592pjd.181.1590938862062; 
 Sun, 31 May 2020 08:27:42 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:1863:fef5:a170:128b:8ef:499d])
 by smtp.gmail.com with ESMTPSA id 131sm12310443pfv.139.2020.05.31.08.27.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2020 08:27:41 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sun, 31 May 2020 20:56:06 +0530
Message-Id: <20200531152621.2886-13-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200531152621.2886-1-jaskaransingh7654321@gmail.com>
References: <20200531152621.2886-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 31 May 2020 17:27:47 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 31 May 2020 17:27:43 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 12/27] parsing_cocci: single_statement: Reflect
	struct end attributes
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
in single_statement.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/single_statement.ml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/parsing_cocci/single_statement.ml b/parsing_cocci/single_statement.ml
index cd1b2c05..df50df6a 100644
--- a/parsing_cocci/single_statement.ml
+++ b/parsing_cocci/single_statement.ml
@@ -205,7 +205,7 @@ and left_declaration d =
   | Ast0.MacroDeclInit(Some stg,name,lp,args,rp,eq,ini,sem) ->
       modif_before_mcode stg
   | Ast0.MacroDeclInit(None,name,lp,args,rp,eq,ini,sem) -> left_ident name
-  | Ast0.TyDecl(ty,sem) -> left_typeC ty
+  | Ast0.TyDecl(ty,attr,sem) -> left_typeC ty
   | Ast0.Typedef(stg,ty,id,sem) -> modif_before_mcode stg
   | Ast0.DisjDecl(_,decls,_,_) -> List.exists left_declaration decls
   | Ast0.ConjDecl(_,decls,_,_) -> List.exists left_declaration decls
@@ -221,7 +221,7 @@ and right_declaration d =
   | Ast0.FunProto(fninfo,name,lp1,params,va,rp1,sem) -> modif_after_mcode sem
   | Ast0.MacroDecl(_,name,lp,args,rp,attr,sem) -> modif_after_mcode sem
   | Ast0.MacroDeclInit(_,name,lp,args,rp,eq,ini,sem) -> modif_after_mcode sem
-  | Ast0.TyDecl(ty,sem) -> modif_after_mcode sem
+  | Ast0.TyDecl(ty,attr,sem) -> modif_after_mcode sem
   | Ast0.Typedef(stg,ty,id,sem) -> modif_after_mcode sem
   | Ast0.DisjDecl(_,decls,_,_) -> List.exists right_declaration decls
   | Ast0.ConjDecl(_,decls,_,_) -> List.exists right_declaration decls
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
