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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF8DC433E0
	for <cocci@archiver.kernel.org>; Sun, 31 May 2020 15:27:27 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF14C206DA
	for <cocci@archiver.kernel.org>; Sun, 31 May 2020 15:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pfwMIDeI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF14C206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04VFRO8r021617;
	Sun, 31 May 2020 17:27:24 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 880DB7752;
	Sun, 31 May 2020 17:27:24 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 17D513C89
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 17:27:22 +0200 (CEST)
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1043])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04VFRK1o026437
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 17:27:21 +0200 (CEST)
Received: by mail-pj1-x1043.google.com with SMTP id ga6so716256pjb.1
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 08:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8h/pvSSdYfn3Zgzqr1TDoXPIV2JdP7GY8NAxupsolQM=;
 b=pfwMIDeIMZaUCusXBbpjxnNS1F/0w7ut65oFMsyX6s2agk1ccwAIrH2cKzWmlgh/Ck
 2o92UTKgjQWo123oWNCCvGtg1JrkAwWn0VpRBTWMjL42OoHN+MmZNGziu7GAuDZXe9QZ
 kkdZ2x3RSPnClotlPsQ26bz5YxgOkcLfD9vc3EsiqB7JKlddTO8IyGj5rJJQxj2CSniD
 WgJ7umW217FBfRYMwtRyBGDcsP9jwfo6a/PQoKJeBRNMHMZkU2Pz/VT79hz6KJSXyQn/
 aomWFEzH1QZxJyeRYL7mIdNRZtTwFI7WJHoa8Tqo1iuVzvqt4bpjncWmO9XABu4IZfwu
 O9Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8h/pvSSdYfn3Zgzqr1TDoXPIV2JdP7GY8NAxupsolQM=;
 b=Y/S6I03vueR7qTIh7VavX7Lb7fVSnmdnnzrk45ScYsSWJ+MDbw4JnkQ5FdngKRnXmi
 zvD8V87DlKCXVRSExLgL/nE35LUpkWrnrTrA1pQ05ADlpjwvcwvn0MY9zDk5oxVRuZj+
 hjtFXS80zlGyo8zx/7R8v1NmZik9p560a0fKq43ettLBUdG6PKETMI3flPc0WNjlkl3S
 s463HQi4qIe7FVw6qD2sfSWMbIJqq5dK5JjcbR4EVp12JfLb+LtrlQ2bgN7umWyc/tKm
 SZm9GYCXePDh4o9QDu/mvpHetBi29gBF7Der1JTc5JieDiFt+v5usJD8pFrI0CcSUnGR
 6r7w==
X-Gm-Message-State: AOAM532hOjEg9aOkuYpJ6hUDScxMhRA/i6R+lGyHydt4uBbMhIIss+vI
 8aI85A0UQb0ktGG9v3w0CYkP8cRCk/8=
X-Google-Smtp-Source: ABdhPJxjvQg4JI/oZeJCzJxB0WfYaXPkiDvMXpEQIu1ZaSqZkFWy4jmkalb3vEov+VsDvywEXcxAvg==
X-Received: by 2002:a17:902:a5c6:: with SMTP id
 t6mr5337878plq.287.1590938839426; 
 Sun, 31 May 2020 08:27:19 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:1863:fef5:a170:128b:8ef:499d])
 by smtp.gmail.com with ESMTPSA id 131sm12310443pfv.139.2020.05.31.08.27.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2020 08:27:19 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sun, 31 May 2020 20:55:59 +0530
Message-Id: <20200531152621.2886-6-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200531152621.2886-1-jaskaransingh7654321@gmail.com>
References: <20200531152621.2886-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 31 May 2020 17:27:24 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 31 May 2020 17:27:21 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 05/27] parsing_cocci: index: Reflect struct end
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
in index.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/index.ml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/parsing_cocci/index.ml b/parsing_cocci/index.ml
index fc04bd6f..8df048dd 100644
--- a/parsing_cocci/index.ml
+++ b/parsing_cocci/index.ml
@@ -119,7 +119,7 @@ let declaration d =
   | Ast0.FunProto(fi,name,lp1,params,va,rp1,sem) -> [132]
   | Ast0.MacroDecl(stg,name,lp,args,rp,attr,sem) -> [137]
   | Ast0.MacroDeclInit(stg,name,lp,args,rp,eq,ini,sem) -> [157]
-  | Ast0.TyDecl(ty,sem) -> [116]
+  | Ast0.TyDecl(ty,attr,sem) -> [116]
   | Ast0.Typedef(stg,ty,id,sem) -> [143]
   | Ast0.DisjDecl(_,decls,_,_) -> [97] (* added after *)
   | Ast0.ConjDecl(_,decls,_,_) -> [88] (* added after *)
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
