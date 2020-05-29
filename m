Return-Path: <SRS0=Yx51=7L=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C7A6C433DF
	for <cocci@archiver.kernel.org>; Fri, 29 May 2020 12:08:58 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00BB8206F0
	for <cocci@archiver.kernel.org>; Fri, 29 May 2020 12:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQcyNTOx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00BB8206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04TC8tkD025387;
	Fri, 29 May 2020 14:08:55 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 8DA1F7783;
	Fri, 29 May 2020 14:08:55 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B50A95D47
 for <cocci@systeme.lip6.fr>; Fri, 29 May 2020 14:08:53 +0200 (CEST)
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:643])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04TC8q04010054
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 29 May 2020 14:08:53 +0200 (CEST)
Received: by mail-pl1-x643.google.com with SMTP id t7so1107530plr.0
 for <cocci@systeme.lip6.fr>; Fri, 29 May 2020 05:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ck/Z1yVAY7wCuc43KSF9d7wKbt95rlPl8lFedilqwoY=;
 b=CQcyNTOxy9jXO/JETq0zk5aQ1dv5u6tdNBDbJW5PM0tcMmyhbfHncQ36lQcybv4R3I
 Kq97V9GraKtzyQHCb99Ql3ikeLT0HJLrNEPDNN2JE8gJUIPZGNFRl1JiUgoObLtQ4Wrn
 vQP+nmmO/MwIlFWf7MhKToDvPU/cVAB0vhu5+BXvkmFErSDXylm//SYErQYx6qqhkU11
 2yJsmL0rD+5NQb2WVZhw5l/2VLkwHtwFfwKqq1Cap/WFEHGXqfdO9138/VOUxtlyKRpU
 pLS32J+p/0GCstnMJRQIga1eeoIrKxyVvzyzVgVm/swY5t4DSCSHlf2zZG3aq+6jCD1Z
 M8jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ck/Z1yVAY7wCuc43KSF9d7wKbt95rlPl8lFedilqwoY=;
 b=YdTNQFeGsGzn5cJeozG/lQF3lpv+KCwuktZh9xqNkbyec2VRdZjfnqHuhSZ1JYo1ag
 q+IuaFSx83xKHKRsSutnv1AMNKIMTvKFkziQXTpWSOKsOQAFvPYKT/DGAIVkU+rnhb0l
 sLE9vxfjE1qBE3+Q50j9GlnmFrMdcPsGcnzx2VtlwoeI8+3lKqAKv9uMs87Ib/V7+Kg+
 /lzL1pFTGzXaZEsZYHHBUIef4/65VL0yvunzf/bPDd5sbLJ5fH0h/Ft8loZk9nLCeN5e
 l/i44T3TBH0t5kk3qvMI65NRMt1Qw9Ei6IBtcRCsoLDuV82leOhUPXS6hJT+O5iDCGFe
 iwDg==
X-Gm-Message-State: AOAM530XlvFVgM7cCtxCFfbszdDvs/275jgtxCfHnUgcVN/rs6VYQOq3
 AcbtT2YHjOJ9R94Ig8g+NYYZRqiF
X-Google-Smtp-Source: ABdhPJzPR1u56Mse70yO1i30ZAZw/bWOY+Dld3iVd8uS9AMg0XPSQKJJEhLdahf2rw20hgFUgSmAUg==
X-Received: by 2002:a17:90a:3622:: with SMTP id
 s31mr1292828pjb.222.1590754131291; 
 Fri, 29 May 2020 05:08:51 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:694:e576:19d1:a79b:707d:59f2])
 by smtp.gmail.com with ESMTPSA id dw13sm7975161pjb.40.2020.05.29.05.08.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2020 05:08:50 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri, 29 May 2020 17:36:38 +0530
Message-Id: <20200529120703.31145-9-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200529120703.31145-1-jaskaransingh7654321@gmail.com>
References: <20200529120703.31145-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 29 May 2020 14:08:55 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 29 May 2020 14:08:53 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v3 08/32] parsing_cocci: type_infer: Reflect Cast
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

Cast attributes are added to the SmPL AST. Reflect these changes in
type_infer.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/type_infer.ml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/parsing_cocci/type_infer.ml b/parsing_cocci/type_infer.ml
index 495d7974..e1cd8941 100644
--- a/parsing_cocci/type_infer.ml
+++ b/parsing_cocci/type_infer.ml
@@ -291,7 +291,7 @@ let rec propagate_types env =
                | Some x ->
                    let ty = Ast0.wrap x in
                    err exp ty "non-structure pointer type in field ref")
-	| Ast0.Cast(lp,ty,rp,exp) -> Some ty
+	| Ast0.Cast(lp,ty,attr,rp,exp) -> Some ty
 	| Ast0.SizeOfExpr(szf,exp) -> Some (Ast0.wrap int_type)
 	| Ast0.SizeOfType(szf,lp,ty,rp) -> Some (Ast0.wrap int_type)
 	| Ast0.TypeExp(ty) -> None
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
