Return-Path: <SRS0=bJsz=6M=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AF4C83000
	for <cocci@archiver.kernel.org>; Tue, 28 Apr 2020 17:03:46 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3A15205C9
	for <cocci@archiver.kernel.org>; Tue, 28 Apr 2020 17:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5f8h2R0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3A15205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03SH3YQv005956;
	Tue, 28 Apr 2020 19:03:34 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 37DDC7807;
	Tue, 28 Apr 2020 19:03:34 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id A37383DC8
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 19:03:32 +0200 (CEST)
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:541])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03SH3Vqh010523
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 19:03:31 +0200 (CEST)
Received: by mail-pg1-x541.google.com with SMTP id o185so10647718pgo.3
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 10:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+1Jx1GCzpkJYz5KJHR+2EEkLhsdfIdOz4vT4XJi1p5g=;
 b=K5f8h2R0vvMeVxVe/UYiPoET4qa9uU0UfJLHLsZXDh1Loshrh5vb09cHVa0UWox3bb
 hagNiVa2E9eILHgF89JbizRFw3Brj6R6Aul5YcVqWc1Hov+d4Xu9+AYJ+BTA3sS8iuSv
 0LHCl9IaDwIFhaEb18Uw977lVMVnUKBBpf8ZmDJ+/nrT0V2KLs1Bsy3lnZugWoNvVFz/
 vJrlgZYWdpnleS7QBPYTi1OKnTk5RPYFIiWvsgQ1UwcAH2d8pOA7daOyulOyFEfZc9Yw
 3/reGj5WXJfQPnZ85BceOLJ3OnaJFVDPXT5zxf4nMBe93nwTn7OtwboS32ljABU7UMDY
 HLuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+1Jx1GCzpkJYz5KJHR+2EEkLhsdfIdOz4vT4XJi1p5g=;
 b=VtIbtoChFThXN4l1wS2qtSiKMp2C70Zz7tMUG9f8twkFwE2FHyL5M5VK316V/9MfK7
 kqKJY0Ed7icscAF0aanuwShKA2Svuc9nMLfLBjZxcq0vc2ZVvwnZp/bHHNX7PaAe4bq6
 NBx8/++5/A/ylZWbcAKjTGMLqacJ7k+EjnFN+0m6p5pEzFVo/LPDty3zgcDrGfV77bAM
 aMaSItj6TREpcII7pOr9Edj1VKdQP0N9qexJjq3oyW4jRHrbhQPFBltbizhqLUEUG4JF
 ou//agkMY6Yk2jq+pS3Rot4JXJyacLPuzKB9n7dV+xFfHkQYW4hVZC6fwJLlcUPeZxmB
 nt0Q==
X-Gm-Message-State: AGi0PuYhXYNMTJvgQ2J3ruh3SKOzCzCKH37oPM7SCboiXkUZzmlTcBnC
 81q4KFR5s5ukOqnCUm6wKmVt7cXXmsc=
X-Google-Smtp-Source: APiQypL3PnnsEJMscFae2z/IleJpAvLlGBSGCzmF2K8s4v2sicN2wEGOr40tVKlfjfQApc5vYWMUTg==
X-Received: by 2002:a63:1709:: with SMTP id x9mr27513566pgl.390.1588093410257; 
 Tue, 28 Apr 2020 10:03:30 -0700 (PDT)
Received: from localhost.localdomain ([1.38.220.163])
 by smtp.gmail.com with ESMTPSA id u15sm2505097pjm.47.2020.04.28.10.03.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2020 10:03:29 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Tue, 28 Apr 2020 22:32:08 +0530
Message-Id: <20200428170228.7002-13-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200428170228.7002-1-jaskaransingh7654321@gmail.com>
References: <20200428170228.7002-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 28 Apr 2020 19:03:34 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Tue, 28 Apr 2020 19:03:32 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 12/32] parsing_cocci: context_neg: Reflect Cast
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
index dd768a61..b6378512 100644
--- a/parsing_cocci/context_neg.ml
+++ b/parsing_cocci/context_neg.ml
@@ -628,7 +628,7 @@ let rec equal_expression e1 e2 =
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
