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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A442DC433DF
	for <cocci@archiver.kernel.org>; Fri, 29 May 2020 12:09:14 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A0DC206F0
	for <cocci@archiver.kernel.org>; Fri, 29 May 2020 12:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ibLh+1t3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A0DC206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04TC9BVx000406;
	Fri, 29 May 2020 14:09:11 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 6D3797783;
	Fri, 29 May 2020 14:09:11 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 850EE5D47
 for <cocci@systeme.lip6.fr>; Fri, 29 May 2020 14:09:08 +0200 (CEST)
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:443])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04TC96km024234
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 29 May 2020 14:09:07 +0200 (CEST)
Received: by mail-pf1-x443.google.com with SMTP id e11so1304998pfn.3
 for <cocci@systeme.lip6.fr>; Fri, 29 May 2020 05:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nSmlrjAHfZOlddz2MaB5gQMonyonjZjCpiZ33/I4Bac=;
 b=ibLh+1t3BBgFvZouYCCuKvXrAz7V4zdNU0fgYriDKOUzlyAoMOxzlvEgLtJuyrCw1H
 627+1exy55lXiAnbr6dbuCG/zhSbQSXTDcGVzh3F4xmTdDs6U4GcdfexG4ihqI7ZwGss
 Lau6aCz3UF2GQxl6m6oYexz6PAaxXdKOyKck7unDt3HOXXxdK1xLwaACMRRQBv9qGsUb
 GoHi5VAzusCDlvpb62EGEEgmY5usNxvJkFqOlTjC3l/+X64slh/iSHfvbf7JMT9K7h+C
 1cMJJvGnNd/QdeCyg7Kx8QpvKd/D3IW7AJNUuLU2qpgGMuWOmBr21eHeqicKXiFm9+AG
 4FBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nSmlrjAHfZOlddz2MaB5gQMonyonjZjCpiZ33/I4Bac=;
 b=S0lnXvvpjXaA11c+ZkYf+YjojS8D+a93GmX66KMMdLO95tIXArJqwz7/0Pf+vYRar3
 NJM3QzZsnHnCUsHJXaX4y6afV4OnASq3LlHc2bVu0gMFKyXXrZcIGnm64Y1d7M6yE9MF
 o0mg0e3PgAmFIAngRukyocNPPQcdmT1Ksjkq0PQvGN1hVg2rjuhEvjkLR3fEgxqr170p
 n4z1FzT7SXCP/avo44yeWZ/4P9VT2MS/p5dyuFgM2Yxzz9fwo3XnMJmWVSrND3O6FeC1
 wEZ9gaxZvDR0IBTCEbZTWbCGqfHtYg3sNOkqCxWO6BTwzMQE1dcSBOoPtWQrx2jRmk5p
 X4zA==
X-Gm-Message-State: AOAM530OP0kuMVIkKS7p9qTDWQG15YwGtjV7Uq9jgbLYnJts7guDY36l
 pV/CF760fk/oxG9ISnx6KCQZEjIM
X-Google-Smtp-Source: ABdhPJzxmq8yphOcYDPVe6uf1/hAfMh3FY0AqgAfU85FmFVPynZJze3+jNkXJKZAr6ShF7+0CVevDQ==
X-Received: by 2002:a63:145f:: with SMTP id 31mr8091842pgu.383.1590754146136; 
 Fri, 29 May 2020 05:09:06 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:694:e576:19d1:a79b:707d:59f2])
 by smtp.gmail.com with ESMTPSA id dw13sm7975161pjb.40.2020.05.29.05.09.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2020 05:09:05 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri, 29 May 2020 17:36:42 +0530
Message-Id: <20200529120703.31145-13-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200529120703.31145-1-jaskaransingh7654321@gmail.com>
References: <20200529120703.31145-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 29 May 2020 14:09:11 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 29 May 2020 14:09:08 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v3 12/32] parsing_cocci: context_neg: Reflect Cast
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
context_neg.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/context_neg.ml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/parsing_cocci/context_neg.ml b/parsing_cocci/context_neg.ml
index 98b96ac5..8734b9d8 100644
--- a/parsing_cocci/context_neg.ml
+++ b/parsing_cocci/context_neg.ml
@@ -630,7 +630,7 @@ let rec equal_expression e1 e2 =
       equal_mcode pt1 pt2
   | (Ast0.RecordPtAccess(_,ar1,_),Ast0.RecordPtAccess(_,ar2,_)) ->
       equal_mcode ar1 ar2
-  | (Ast0.Cast(lp1,_,rp1,_),Ast0.Cast(lp2,_,rp2,_)) ->
+  | (Ast0.Cast(lp1,_,_,rp1,_),Ast0.Cast(lp2,_,_,rp2,_)) ->
       equal_mcode lp1 lp2 && equal_mcode rp1 rp2
   | (Ast0.SizeOfExpr(szf1,_),Ast0.SizeOfExpr(szf2,_)) ->
       equal_mcode szf1 szf2
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
