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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA38C433DF
	for <cocci@archiver.kernel.org>; Sun, 24 May 2020 17:20:33 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D456206C3
	for <cocci@archiver.kernel.org>; Sun, 24 May 2020 17:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICUogsdn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D456206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04OHKU1U014086;
	Sun, 24 May 2020 19:20:30 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 9FE023DC8;
	Sun, 24 May 2020 19:20:30 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 862583D0F
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 19:20:29 +0200 (CEST)
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1041])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04OHKR9Z018763
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 19:20:28 +0200 (CEST)
Received: by mail-pj1-x1041.google.com with SMTP id ci21so7596198pjb.3
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 10:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7JayPzVO73mHgocfSrJ3HFPybIFIGUU87Sf08ZFQsyc=;
 b=ICUogsdnfr6UZE4IPq0kCgbYua8Rm36w3b/wlNvqhwxztWwQ9HtkTrXthYM6Qzj06s
 kKM4plh7UNxwV47iomgAbgE6/vqfLM9u2l9M3EfQthWTufEE1Dsguk3DFTGDfIC7lxeg
 oTtNXg+2fr7dJBxIZrvm73rs2pD0Uuy0PnXmu3XC0pFeIDmdsckj1m6Yvo+4tISAUB/w
 YZv7rxw5S5PX/sMIWzQVbyqOs0ImVqJL7gn9FgiS2rDEmpJzC+6K2qG5MZOQfr224SuO
 N4KVwbrdnyvqUT6At0aHzlWCR1zAF7I/ujlvvz+QQrjZ5fSqGDqc+a6pn0q3KCvFc6/b
 i5AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7JayPzVO73mHgocfSrJ3HFPybIFIGUU87Sf08ZFQsyc=;
 b=VtVoM03ZSdjYMlzP7+9RC6JLMfqLTV0n68zVj1KDNEW9CmYoApRms35c9dR+5mi4Gw
 +A3gzr7J4BjD6TJKKjWyKsV2nSZLwFblonfSTqP2YHjz0vT8nATiyIyz/tJhbAwK66V5
 q9yfc3PYWFY5tCD8r2nbWt54w7OVO8gcZ1pM1umsAbMQ2g6Knx9LaIo9LXA+2GoavJZE
 NqNDgGjjSdQJ559YKNNFSVwHROMp8/Mz661DhrWrXMFknypWa0aZoghZsr/nuSqexANo
 ZB9fKHcwZIWeVPvvUK21huLkRINpsU8b2Sbj+RBepPgmQe6aRI2mwVQFoX82d63Skybs
 rArg==
X-Gm-Message-State: AOAM530b5wKNSdzQRZIdkEtfE5SPCQBPnURDxHhqqUKWwmu0+TRSn4q3
 N8WrWfpZkAbFQxCUN16gorfA8MjbRcE=
X-Google-Smtp-Source: ABdhPJyQpH4Dy8Dz8sIUBmyiIcmR6FNtyrFXaHs+stWQupsaCtiAyRB70ru/+FXFCC5J+ky9tmtReg==
X-Received: by 2002:a17:90a:248c:: with SMTP id
 i12mr16513450pje.213.1590340827224; 
 Sun, 24 May 2020 10:20:27 -0700 (PDT)
Received: from localhost.localdomain ([1.38.220.54])
 by smtp.gmail.com with ESMTPSA id d9sm6556497pfn.72.2020.05.24.10.20.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2020 10:20:26 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sun, 24 May 2020 22:49:10 +0530
Message-Id: <20200524171935.2504-6-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200524171935.2504-1-jaskaransingh7654321@gmail.com>
References: <20200524171935.2504-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 24 May 2020 19:20:30 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 24 May 2020 19:20:29 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 05/30] parsing_cocci: index: Reflect Macrodecl
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

Macrodecl attributes are added to the SmPL AST. Reflect these changes in
index.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/index.ml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/parsing_cocci/index.ml b/parsing_cocci/index.ml
index 6bda797e..3d74fc41 100644
--- a/parsing_cocci/index.ml
+++ b/parsing_cocci/index.ml
@@ -117,7 +117,7 @@ let declaration d =
   | Ast0.Init(stg,ty,id,attr,eq,exp,sem) -> [54]
   | Ast0.UnInit(stg,ty,id,attr,sem) -> [55]
   | Ast0.FunProto(fi,name,lp1,params,va,rp1,sem) -> [132]
-  | Ast0.MacroDecl(stg,name,lp,args,rp,sem) -> [137]
+  | Ast0.MacroDecl(stg,name,lp,args,rp,attr,sem) -> [137]
   | Ast0.MacroDeclInit(stg,name,lp,args,rp,eq,ini,sem) -> [157]
   | Ast0.TyDecl(ty,sem) -> [116]
   | Ast0.Typedef(stg,ty,id,sem) -> [143]
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
