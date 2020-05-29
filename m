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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24186C433E0
	for <cocci@archiver.kernel.org>; Fri, 29 May 2020 12:10:18 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA2CE2077D
	for <cocci@archiver.kernel.org>; Fri, 29 May 2020 12:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FwI7iK9o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA2CE2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04TCAFLa026712;
	Fri, 29 May 2020 14:10:15 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 07BC57783;
	Fri, 29 May 2020 14:10:15 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 8E27A5D47
 for <cocci@systeme.lip6.fr>; Fri, 29 May 2020 14:10:13 +0200 (CEST)
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:644])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04TCABaf021121
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 29 May 2020 14:10:12 +0200 (CEST)
Received: by mail-pl1-x644.google.com with SMTP id y11so1087124plt.12
 for <cocci@systeme.lip6.fr>; Fri, 29 May 2020 05:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Rrzz3VKyAplkiQoSTk8Ir4A1V86JltGAz16X3d5PyBk=;
 b=FwI7iK9oZSq3JzOLnRL2D2txLv2lBqcpbxv57gSNM42+HdP7X3/RIYdCHO9z3FSWkZ
 DiyEBMyOTFHSEmKZmEj/eD9f5Ws48mIWQ7/1nNFvwqBa9ykxQQmc8Y42TUMQNkAFqv5g
 TEIcVaFbKQ7cK0Z0hVCDQsCXTOs1UHQRs16yNvNeMjAnrbPHnVp7oiLgGVJxV7IbJQC4
 irR7kpuvAuizy8ALBUjaarq31rMgp8xEmHQvsoSva7avusQWJTHQJQ66Hxy+6yoAe6ac
 /mIUr21FOLMWQUQcFpLXGFkOz5PdSldcSTMNzM0bl5IiVgPEgTOATG467eh+Ay+iRh0i
 wMig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Rrzz3VKyAplkiQoSTk8Ir4A1V86JltGAz16X3d5PyBk=;
 b=dasIciStKL54Ic6XUXqArmBkqehbuQUOLEehvR5Bch1Wn7S0VfkK2zgLeBkT9/qIdE
 oCve3Gf4D6cJO7o+l/5Oif/LyyHYl/EUf+jwmX/PjDrITm2Sz//kcUD3FTLpPzgG8l+Y
 05A8Z6YpVLT8Ab5VtZ/NwSpQoML2FMbDIEejFoP43iawZbzIa+Oe9CvBmdMDIrftFLpJ
 x3mj6G0A19QwkwL6Nf9jMGHuUSd8Xprn9iZdbplrDljlVUYKfDNfENutsg59okFqtiZJ
 SSLtfFSUBuTBQPVf6+ubIUTBepb1KSka6UL2UA2aZ938cwN/ewz42bxPogjFgSfgStZV
 Rcbg==
X-Gm-Message-State: AOAM530XmPf5Pd41+jZEaAousO4/G0lhg6rFse/JwCfZltvTLI0N2jT6
 +RcXp0pkcQOr9FvffaP//xUn32t4
X-Google-Smtp-Source: ABdhPJyPjI+r/IC2c3zc+IChSKwm5QUQMCYlZvALKxIroBwVeTRmfw0Bpw+jSmhpYMXWRA5G9JM4jA==
X-Received: by 2002:a17:90a:3622:: with SMTP id
 s31mr1298703pjb.222.1590754211066; 
 Fri, 29 May 2020 05:10:11 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:694:e576:19d1:a79b:707d:59f2])
 by smtp.gmail.com with ESMTPSA id dw13sm7975161pjb.40.2020.05.29.05.10.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2020 05:10:10 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri, 29 May 2020 17:36:56 +0530
Message-Id: <20200529120703.31145-27-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200529120703.31145-1-jaskaransingh7654321@gmail.com>
References: <20200529120703.31145-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 29 May 2020 14:10:15 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 29 May 2020 14:10:13 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v3 26/32] engine: check_exhaustive_pattern: Reflect
	Cast attributes
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
check_exhaustive_pattern.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 engine/check_exhaustive_pattern.ml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/engine/check_exhaustive_pattern.ml b/engine/check_exhaustive_pattern.ml
index 903c32ff..d7785fc7 100644
--- a/engine/check_exhaustive_pattern.ml
+++ b/engine/check_exhaustive_pattern.ml
@@ -123,7 +123,7 @@ let dumb_astcocci_expr = function
  | A.ArrayAccess (ea1, _, ea2, _) -> ()
  | A.RecordAccess (ea, _, ida) -> ()
  | A.RecordPtAccess (ea, _, ida) -> ()
- | A.Cast (_, typa, _, ea) -> ()
+ | A.Cast (_, typa, attra, _, ea) -> ()
  | A.SizeOfExpr (_, ea) -> ()
  | A.SizeOfType (_, _, typa, _) -> ()
  | A.TypeExp (typa) -> ()
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
