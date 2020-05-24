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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27370C433E0
	for <cocci@archiver.kernel.org>; Sun, 24 May 2020 17:21:02 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9055206C3
	for <cocci@archiver.kernel.org>; Sun, 24 May 2020 17:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IoJ1KQHe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9055206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04OHKxCO025619;
	Sun, 24 May 2020 19:20:59 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 6ED663DC8;
	Sun, 24 May 2020 19:20:59 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 75F6D3D0F
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 19:20:58 +0200 (CEST)
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:643])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04OHKuQ5001563
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 19:20:57 +0200 (CEST)
Received: by mail-pl1-x643.google.com with SMTP id t16so6620317plo.7
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 10:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oaqB0eFbbqjwOp8kwNjw6yCTOqMGnl831G6vpg8CDQM=;
 b=IoJ1KQHemTtRezT3n7xBs3PUOY/5AhGb9EHMaVFsJq12shl5NU5Mu1QziwSgUBbMnx
 Y+dJKyUUo5rj/59rS4uRswTwTzgNf9uLia80LiOddSU+TAvl1FS5jOfLWZKZQ65coUv9
 EwSjuGDwfaQcPB+ZvATJDdQrHmNWk56PapPZqoo+rovqrTFbTwm2kHdGgTOiT8AhKq55
 ndYFrzLIM85PqYpN+orlHOrZ3Yo+O8ms1g2m0ZurIYSxZiYyKQrOdeLrMOjglFNE3cEI
 zrqQpWO3Hi84q3jd/9pH6WKEaTzGPNioaXySS2FI/8nfr3J2s1NOzLw/sDUQY1WBs+o6
 lPkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oaqB0eFbbqjwOp8kwNjw6yCTOqMGnl831G6vpg8CDQM=;
 b=bA5tq4W1+QIfCtMoIMrFIBj0DAHNKsW6zcShkxmuRyls4w/aYd10YOnIygb0ki4cUU
 jANm+WSeUq8WfVjDmyHrjI8an0g2fGFSC3I5LnZkKv056NxhyOHBxP7NlAHonnSd0Ken
 UR7aXB2M1IUDAJAwcUr/myLnqsaYl9i5tcIBGM1ab/wfok287e0ralvVqa7C4KvsICv9
 UcpjCtIDFRAPGrj2O+XZOEhs5IwKdlXqyIlyIvjT3V/g2rQujQnXd5l08hv8X1QGLCuy
 x2mw5KNamzuaftf5aWpQ1iNr97aoTqoaMd5kEnq40Uz8OBCDJqFxl5PD+Nv/KiDfBpvc
 6Iww==
X-Gm-Message-State: AOAM531UjrDWTJYljp1TuF1q+71C0oIyvpXz7daI2wwjyVc7CFSjKFOE
 icb74rdSZL4bhNWsz1HR16ffQZ5MVH8=
X-Google-Smtp-Source: ABdhPJzND+6hCrF+1O1I0Q6k+fwr1C/oekuPWahRZGGjdLTVNYcpZPU3Ci+tA+28GuKOA4G/yDidYQ==
X-Received: by 2002:a17:90a:d70a:: with SMTP id
 y10mr16298199pju.53.1590340856151; 
 Sun, 24 May 2020 10:20:56 -0700 (PDT)
Received: from localhost.localdomain ([1.38.220.54])
 by smtp.gmail.com with ESMTPSA id d9sm6556497pfn.72.2020.05.24.10.20.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2020 10:20:55 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sun, 24 May 2020 22:49:16 +0530
Message-Id: <20200524171935.2504-12-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200524171935.2504-1-jaskaransingh7654321@gmail.com>
References: <20200524171935.2504-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 24 May 2020 19:20:59 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 24 May 2020 19:20:58 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 11/30] parsing_cocci: context_neg: Reflect Macrodecl
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
context_neg.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/context_neg.ml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/parsing_cocci/context_neg.ml b/parsing_cocci/context_neg.ml
index dd768a61..4b1376cf 100644
--- a/parsing_cocci/context_neg.ml
+++ b/parsing_cocci/context_neg.ml
@@ -752,9 +752,9 @@ let equal_declaration d1 d2 =
        List.for_all2 equal_fninfo fninfo1 fninfo2 &&
        equal_mcode lp1 lp2 && equal_varargs va1 va2 &&
        equal_mcode rp1 rp2 && equal_mcode sem1 sem2
-  | (Ast0.MacroDecl(stg1,nm1,lp1,_,rp1,sem1),
-     Ast0.MacroDecl(stg2,nm2,lp2,_,rp2,sem2)) ->
-      equal_option stg1 stg2 &&
+  | (Ast0.MacroDecl(stg1,nm1,lp1,_,rp1,attr1,sem1),
+     Ast0.MacroDecl(stg2,nm2,lp2,_,rp2,attr2,sem2)) ->
+      equal_option stg1 stg2 && List.for_all2 equal_mcode attr1 attr2 &&
       equal_mcode lp1 lp2 && equal_mcode rp1 rp2 && equal_mcode sem1 sem2
   | (Ast0.MacroDeclInit(stg1,nm1,lp1,_,rp1,eq1,_,sem1),
      Ast0.MacroDeclInit(stg2,nm2,lp2,_,rp2,eq2,_,sem2)) ->
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
