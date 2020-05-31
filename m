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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BC8C433DF
	for <cocci@archiver.kernel.org>; Sun, 31 May 2020 15:27:32 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6455206DA
	for <cocci@archiver.kernel.org>; Sun, 31 May 2020 15:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dl6zROxR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6455206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04VFRT8a002490;
	Sun, 31 May 2020 17:27:29 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 2A7307752;
	Sun, 31 May 2020 17:27:29 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 4F5ED3C89
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 17:27:28 +0200 (CEST)
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1041])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04VFRQYR028704
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 17:27:27 +0200 (CEST)
Received: by mail-pj1-x1041.google.com with SMTP id q9so3798219pjm.2
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 08:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JWAsQSn0NCXnW2R3p4nW1Uw8wyNBP6QIXBIJaWZEtGo=;
 b=Dl6zROxR4MPo5JFy9ww1jAU3LBH8zyQJjvTJ5I2tkSm0Da8aklmH1kFqmyh88iYnF9
 HVUsC4+J7Nhbm3YjxizbZdAuBWedzUOY/JByyCRCq/bNc1oo7naVWD3FX8OrehoQJZTK
 Ao1GNBXQuqTZ5Zq6iyjFPnZYHDggWzftW78474gaSDnllAgHPQRcsAkbcnmBW6zeMX4A
 RS2aoU+PZNuPJ+2UiAjYJMMTHwCYo1mI+scjOfZ1RCLzxI6dHm/H30Qv9IRo/zBT0nFg
 /YZbILS0cXKdgF4uenyj5Q2n2dRMHjh2Na9Fa4hrlgnMt7Fnt50Hj+ls5iFmkSKjoYLA
 Bf7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JWAsQSn0NCXnW2R3p4nW1Uw8wyNBP6QIXBIJaWZEtGo=;
 b=GpyWoPrpjoaNrLKpjrZY2ffP/LDrOjly+ovrlFh1yS+XbfxoC6Zfr7lVkEDCOzXPm1
 /FTEOP2NullIwzke6ktWuDuoW7ElmpIaF0m1xOXaU8pn/OkABGwHT+AA5gU7qpqPtPCo
 zIdUqlVkAGsmvqEW8NNUrnlil98u2upLkJXKLiReg2DZ1WzW6G+VnpxdxEp5gUWTmQ1n
 ZA+isGEGQAswQ/+gawPNIfedlwhTmYe3c6/CHQvn/FwJgpiVxwXUfYwrkX7S3HunD2n+
 r131ENuhDwWcn3Fcj43BKedQEgndELsDGKOVH6PqcE21kvYRLbewM/j+FbboBFoQMGJz
 P6zA==
X-Gm-Message-State: AOAM532GrrivcGwvpQfVSzYIgMpQ6j5xBjMWn8klhvZ2KZOfIQPt6XX+
 PG4zQUa3ayYcs+cFH3zKthFVrttm
X-Google-Smtp-Source: ABdhPJzEVd77ofGTk4+PPBGkdJ1rREjUfuSUrukd85DlM8HBLAr7AFTPnM2yvQsRUxCGaCDVtKoZNQ==
X-Received: by 2002:a17:90a:d783:: with SMTP id
 z3mr17740834pju.187.1590938846013; 
 Sun, 31 May 2020 08:27:26 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:1863:fef5:a170:128b:8ef:499d])
 by smtp.gmail.com with ESMTPSA id 131sm12310443pfv.139.2020.05.31.08.27.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2020 08:27:25 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sun, 31 May 2020 20:56:01 +0530
Message-Id: <20200531152621.2886-8-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200531152621.2886-1-jaskaransingh7654321@gmail.com>
References: <20200531152621.2886-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 31 May 2020 17:27:29 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 31 May 2020 17:27:27 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 07/27] parsing_cocci: type_infer: Reflect struct end
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
in type_infer.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/type_infer.ml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/parsing_cocci/type_infer.ml b/parsing_cocci/type_infer.ml
index b5bc3a38..02e300a2 100644
--- a/parsing_cocci/type_infer.ml
+++ b/parsing_cocci/type_infer.ml
@@ -384,7 +384,7 @@ let rec propagate_types env =
     | Ast0.MacroDeclInit(_,_,_,_,_,_,exp,_) ->
         let _ = (propagate_types env).VT0.combiner_rec_initialiser exp in
 	[]
-    | Ast0.TyDecl(ty,_) -> []
+    | Ast0.TyDecl(ty,_,_) -> []
               (* pad: should handle typedef one day and add a binding *)
     | Ast0.Typedef((a,_,_,_,_,_),b,c,(d,_,_,_,_,_)) ->
 	[]
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
