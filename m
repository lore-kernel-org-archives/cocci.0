Return-Path: <SRS0=43Z/=6Z=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDEDCC47255
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:08:14 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BB9120720
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjgMzA/R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BB9120720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04BA82Nt024096;
	Mon, 11 May 2020 12:08:02 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 8E0403E6B;
	Mon, 11 May 2020 12:08:02 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 63B693DC8
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:08:01 +0200 (CEST)
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:442])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04BA7xb4000332
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:08:00 +0200 (CEST)
Received: by mail-pf1-x442.google.com with SMTP id v63so4522303pfb.10
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 03:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1+jQvFfCERdvlbrN50zvK3j7kjY87WUidq4SpOe7Ai4=;
 b=bjgMzA/RK7LgstBkIfT3MaYCw7K1EW5u+hfBiBBLKVOBs5evicIVY0V5L6rr/DkD5b
 JYORsB2fHY4KdOP/zT7wCGU5+Y0Qyrd77K+a73WhM2g5Dt27oT5FNkUUy4z+h5FpI0oe
 HrQgAuDBdNc6z6aw+nFGxBbSGUFcHTIdJ1vmRXQex5mu3UhEg0Uu1gmQLcMUL+MUnWKU
 65mjMC36YxSBfWUi/Ql/ZBjR68cqw3W+csmNsizQFmty26iewvSx201KMxgkSZQW62pR
 t4rbnYWusWjWnobw4bqPUYuISB0OZv41vjIIljX+hkleatoCKV/WFjwb3OWa/UhtabQq
 D71A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1+jQvFfCERdvlbrN50zvK3j7kjY87WUidq4SpOe7Ai4=;
 b=tXvJ6CzTJk0Ws8o9as54ww9hcXgza0oPfCBcysbc4jlbhz1ZL+8Klg/2K0puIZ6MFJ
 uy8PmUqx3f+rKwhbfE+Z3fTgR8QHSIPuX3er/gc/rqEOewKGVnQYDqE+XCFdCLadCSsh
 aFnCiPVQePhj+3OaBrR4DHDEERGqPMRdj67Mk8peDjmoH7BAwAbLfGy6Dr7mqWu5RUep
 cec+YKQ5otd0odIgGzaJhgb3SJz2A+XFEptt763Ftd97YxugPG3Z0mJrVqTtr7kzsZQA
 Swi/38AfRZIpud3zcLy32l0diE/qRvL9jApYwXNM11SXWiunLvc59DGMzs0Okui0ReXx
 B8gA==
X-Gm-Message-State: AGi0Pua+a4RvCEbSag9xDO9l5Xdq43+yxOiipjDdS3zmzjdx/pHBdaL9
 gCXAsXSAeZzyMXDIbxminO+7yQANb+0=
X-Google-Smtp-Source: APiQypKG+yzHImovqpGgz0UsdW7B8LkY/Ld1xRv+Qk0Szuk7kxhwBm8nmOsl3J6e/SIKedaCkhkSaQ==
X-Received: by 2002:a62:2544:: with SMTP id l65mr15615321pfl.288.1589191679055; 
 Mon, 11 May 2020 03:07:59 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:382:66db:4729:1ab8:2139:8945])
 by smtp.gmail.com with ESMTPSA id
 o99sm9772994pjo.8.2020.05.11.03.07.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 03:07:58 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 11 May 2020 15:36:49 +0530
Message-Id: <20200511100715.19819-7-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200511100715.19819-1-jaskaransingh7654321@gmail.com>
References: <20200511100715.19819-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 11 May 2020 12:08:02 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 11 May 2020 12:08:00 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v2 06/32] parsing_cocci: index: Reflect Cast
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
index f7ae48b4..a3b92c12 100644
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
