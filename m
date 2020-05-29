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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EBEC433DF
	for <cocci@archiver.kernel.org>; Fri, 29 May 2020 12:08:51 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 361FE206F0
	for <cocci@archiver.kernel.org>; Fri, 29 May 2020 12:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjpITujX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 361FE206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04TC8m2P029070;
	Fri, 29 May 2020 14:08:48 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A00BB7783;
	Fri, 29 May 2020 14:08:48 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7685F5D47
 for <cocci@systeme.lip6.fr>; Fri, 29 May 2020 14:08:46 +0200 (CEST)
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:441])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04TC8i8Z016963
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 29 May 2020 14:08:45 +0200 (CEST)
Received: by mail-pf1-x441.google.com with SMTP id z64so1305234pfb.1
 for <cocci@systeme.lip6.fr>; Fri, 29 May 2020 05:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1DE9vhHxJKqoZomKSzZvcW1hnN0FrGvk327V6ywbng8=;
 b=fjpITujXwWbFbkd1l8x3i13mzj1wgLtmHFLz8YgXNP0G91d2a8cHSFtQ9F6P11Dtv9
 /mgxiJAaHPuY9CqyRM60R3A8d2UZ8AEK0pOAPRCgl7MBeZskCTtGUvmcFap0eQqVk9c8
 pIrGvAdwjsfjXG5JGUUvBrNVnfbcPI58kBIUPooMcTsYBJUSAkJdbMPfJK62+glx6sek
 b02MZMp2y2Xqe8sL5ZAWarSdNUl2AipsicDfTD8eQbrvxVhigzHgDgEk90bBHeH4BmrI
 O9SzevhiVl7CrLiYIHrIhN1VsWpWl3C1sZEujFw3UtODYSzYh+qR9KDdIS2PzuuM59Ho
 e1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1DE9vhHxJKqoZomKSzZvcW1hnN0FrGvk327V6ywbng8=;
 b=IqHXrnsHz3h+Eq8TXdtY4sFw5Laxn3uaT4ozkBtZFndC1qhUolB1HUpa6uaPJvbIab
 Z+9iMe8+THHAGk9OrBejXgkhX6a7jxMC5GXwHdeTuv558UQTmNqDVMaTIhqjs712OYuE
 fru5m5qIQ++5ZrgVlcfnZM2K94l2TaEVfcjgwsZkz34sC/L7+wMmccXOT3UFb8Ahwnh7
 PSaqh86mmmfMksHt15uP6mtA2IwUIizX/yI/cxz+CUIP7ykZpD260EbCgLG+1yEYjBer
 EovhxXyx9eR1P1YN76QwqEb1IiA4r/Nw/CX3vOF9KbBb0s8kHHlMZ1KntRJyDMgwvGTN
 tZMg==
X-Gm-Message-State: AOAM533IuPp0ChLHFvZSTD0Nf6s+K+eoX0CY8hr3KQEqiQM53mVgQL8A
 rYXfkJz4yyM9aXfzoviK54sfst3W
X-Google-Smtp-Source: ABdhPJyzeSXJ+5aYQk3u4yEUYaTnt70LgC6Uq8xYsUSsLdHP1t1z0j4fSuyZBfAnNCkfrUkcZeb2Vg==
X-Received: by 2002:aa7:9052:: with SMTP id n18mr4311720pfo.319.1590754124041; 
 Fri, 29 May 2020 05:08:44 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:694:e576:19d1:a79b:707d:59f2])
 by smtp.gmail.com with ESMTPSA id dw13sm7975161pjb.40.2020.05.29.05.08.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2020 05:08:43 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri, 29 May 2020 17:36:36 +0530
Message-Id: <20200529120703.31145-7-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200529120703.31145-1-jaskaransingh7654321@gmail.com>
References: <20200529120703.31145-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 29 May 2020 14:08:48 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 29 May 2020 14:08:46 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v3 06/32] parsing_cocci: index: Reflect Cast
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
index.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/index.ml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/parsing_cocci/index.ml b/parsing_cocci/index.ml
index 0952c1a1..86d9c0bf 100644
--- a/parsing_cocci/index.ml
+++ b/parsing_cocci/index.ml
@@ -61,7 +61,7 @@ let expression e =
   | Ast0.ArrayAccess(exp1,lb,exp2,rb) -> [27]
   | Ast0.RecordAccess(exp,pt,field) -> [28]
   | Ast0.RecordPtAccess(exp,ar,field) -> [29]
-  | Ast0.Cast(lp,ty,rp,exp) -> [30]
+  | Ast0.Cast(lp,ty,attr,rp,exp) -> [30]
   | Ast0.SizeOfExpr(szf,exp) -> [98] (* added after *)
   | Ast0.SizeOfType(szf,lp,ty,rp) -> [99] (* added after *)
   | Ast0.TypeExp(ty) -> [123] (* added after *)
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
