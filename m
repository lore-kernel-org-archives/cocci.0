Return-Path: <SRS0=15MF=5F=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6EBC4332D
	for <cocci@archiver.kernel.org>; Fri, 20 Mar 2020 07:03:05 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CCE120775
	for <cocci@archiver.kernel.org>; Fri, 20 Mar 2020 07:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMC26n8A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CCE120775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02K72rfP020960;
	Fri, 20 Mar 2020 08:02:53 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A8C5A780E;
	Fri, 20 Mar 2020 08:02:53 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 6CDEA3B93
 for <cocci@systeme.lip6.fr>; Fri, 20 Mar 2020 08:02:51 +0100 (CET)
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:541])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02K72niW029332
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 20 Mar 2020 08:02:50 +0100 (CET)
Received: by mail-pg1-x541.google.com with SMTP id x7so2610524pgh.5
 for <cocci@systeme.lip6.fr>; Fri, 20 Mar 2020 00:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VZmo0/Lb0Y8z14Hq9S6by+eeq93LQdEyR+kcPvQctng=;
 b=dMC26n8AsGyheA7HF1Kuoh/6tGyn4oZO5iK7bt8PHc2AfJJxZ+2WZwCPZwSXHG3/ZS
 8E2aauMRkIsuFpVQ9JXMJCWbAWQg2OvJLHnvXNN7QdyHqkfsFCbCtbjiQP9CMHzmtu6O
 WpwjB1+uG6Vvi1kDmzZjLdB7eF4FAYRg/vQxkdKgFY3/dg9gxSYUVmbsL6al55+6RwXj
 DJRsEiaHR4c2KTB9Vc+qL2g0P7aOXDLtVl2U9yH+IwhlTz8mTF8VPfyQ3LLcScm2sV01
 TyWSoArNBBoTP7OkjQE021KaXXS0vo1uEVkEP9eCrEmAx6AoT28Lfvw3LgXYSn+QSezw
 Qofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VZmo0/Lb0Y8z14Hq9S6by+eeq93LQdEyR+kcPvQctng=;
 b=ecTVJBmejTxsplnnyQ0zmEtZzPgiSDIxpwZA6Dw4c6C1NgaGp71j6px6w4CWlDHwsE
 L5Ljb2Fbva2lbDNN1IkKgRUXquhqQvBEU10L+/B8Qc0iwe4npt0HLRF9sGFkz5yaBxos
 xAtaWyGI07VhQWrCiH0Ve4LizPzodsCa8IkZ2rmLbSH7yL3g0R/ubD4/VrXAberG4JE8
 ALJp6Ge+P/Z7AAMbPxsNVXpbsEnGayYPRVChk2nKhtyBfH51B7oAMHks2vfQABVd5X+l
 SJ2G2vIvI+n1WbRq0AbdXVOpj7fDExpL12ICy3FJNc1JDU4wUKACTVrgTwEwcst0xiOP
 3OrA==
X-Gm-Message-State: ANhLgQ0t+elLnVr5V0o1tczLuIJ0xhysiSSr5dERHuq8Q3gDb5FUoK70
 iRAQorxdQPSs85Ws24FfGL1lyDT2
X-Google-Smtp-Source: ADFU+vtjA+wHlLooR9LSnBtZr5nOOPzdwxefStc1MH/1OUoLhEsd2kLu6wmHWCB5X+a+cHzNHZMM+g==
X-Received: by 2002:a63:ce0a:: with SMTP id y10mr6997582pgf.44.1584687769011; 
 Fri, 20 Mar 2020 00:02:49 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:2190:a751:deeb:c09d:833a:659d])
 by smtp.gmail.com with ESMTPSA id l11sm3941232pjy.44.2020.03.20.00.02.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2020 00:02:48 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri, 20 Mar 2020 12:31:41 +0530
Message-Id: <20200320070157.4206-11-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200320070157.4206-1-jaskaransingh7654321@gmail.com>
References: <20200320070157.4206-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 20 Mar 2020 08:02:53 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 20 Mar 2020 08:02:51 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v3 10/26] parsing_cocci: single_statement: Add cases
	for ParenType/FunctionType
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

ParenType/FunctionType are now types in the SmPL ASTs. Add
cases for these types in single_statement.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/single_statement.ml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/parsing_cocci/single_statement.ml b/parsing_cocci/single_statement.ml
index 46408b73..2bd4c202 100644
--- a/parsing_cocci/single_statement.ml
+++ b/parsing_cocci/single_statement.ml
@@ -166,6 +166,8 @@ and left_typeC t =
   | Ast0.Signed(sgn,ty) -> modif_before_mcode sgn
   | Ast0.Pointer(ty,star) -> left_typeC ty
   | Ast0.FunctionPointer(ty,lp1,star,rp1,lp2,params,rp2) -> left_typeC ty
+  | Ast0.ParenType(lp,ty,rp) -> modif_before_mcode lp
+  | Ast0.FunctionType(ty,lp,params,rp) -> left_typeC ty
   | Ast0.Array(ty,lb,size,rb) -> left_typeC ty
   | Ast0.Decimal(dec,lp,length,comma,precision_opt,rp) ->
       modif_before_mcode dec
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
