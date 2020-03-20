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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C65C4332D
	for <cocci@archiver.kernel.org>; Fri, 20 Mar 2020 07:03:36 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6C4520775
	for <cocci@archiver.kernel.org>; Fri, 20 Mar 2020 07:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2lJQU/7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6C4520775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02K73Ptd016446;
	Fri, 20 Mar 2020 08:03:25 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 4453E780E;
	Fri, 20 Mar 2020 08:03:25 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 92E343B93
 for <cocci@systeme.lip6.fr>; Fri, 20 Mar 2020 08:03:23 +0100 (CET)
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1041])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02K73L2I003751
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 20 Mar 2020 08:03:22 +0100 (CET)
Received: by mail-pj1-x1041.google.com with SMTP id m15so2061324pje.3
 for <cocci@systeme.lip6.fr>; Fri, 20 Mar 2020 00:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Z5Vt+kSyi/RcHyrlEg6BWuNNcdeP5nA5wISFF/Yfsqg=;
 b=h2lJQU/7zdLelLAlaIhLie2WVLu/GMSm4rRKI3ihS1JY1coGc9AJtojAAidzc+7J0w
 K8zWJPfJ0kLDIM6YIj49T6okXJaH6PmeLyduVw3JaqI5asAsjZxNiM5ZovQb2lGxHHx3
 bHtz1sC0CHDJNN3WiB3FKSDJ7PvSqKv7rU83/OuKwlf3ulUq/mpAEYy3ddmMPV8TUjpd
 SIe/14uVN3A05JreGDQ368qEiVVQda8X8X4e7xR5idJS0yZCsA241a/HeB7ct93gzzAF
 HlKnqLT1xNL4mZys9K4QnXkJYVrTo/MqfTEIiXdYJnOL9KPYMC0uCrGeApFMoYTD8lM2
 W6XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Z5Vt+kSyi/RcHyrlEg6BWuNNcdeP5nA5wISFF/Yfsqg=;
 b=sY/u1kE+2nbOEN3eJH2nYpkoFANA3cj/L4h46kxIUvA5ybrEAUEjOz7J+isrO0SjoS
 ui2mCWNC6QYbBxBaMBkxtn9ennUuGu25IRQ75xAbSkKYlN9B7qSKFy6/mHpXYArnevpA
 HyP7x1tyKfFX1qb0i4xgJM03Xi3ZPCOYMzKpHnKMdF7a/DH+W8F3u7aH4NR+D9f3Jy1Z
 JgWebuntc5r6+cGjBEyWRWt+yrC94bziMuEl9SZYexP47hVOvQPO4EAL106tXc9ZnJ2Y
 PPgWzLDiuLJfQ/bRPIR40TgWcjnevt0fOoq244akTiABV6/bxrVgUJyVQ9H4784a1/mR
 kS+A==
X-Gm-Message-State: ANhLgQ1n6RjqwQBg1KJaEwMEuLnu/5OMM/1zXKtZwEQ0Lk0MHfyVshCP
 +LfxRvQeSCVA0nR8Xo+7O68gAKZe
X-Google-Smtp-Source: ADFU+vs9TTpFwFx/UTpzNrZoB+dOEhTvl/ynDB9FoEBmqaoYiyu2Pj7STIPvU8t4kWO6ugNb/uAfyg==
X-Received: by 2002:a17:902:b901:: with SMTP id
 bf1mr6998147plb.133.1584687801016; 
 Fri, 20 Mar 2020 00:03:21 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:2190:a751:deeb:c09d:833a:659d])
 by smtp.gmail.com with ESMTPSA id l11sm3941232pjy.44.2020.03.20.00.03.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2020 00:03:20 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri, 20 Mar 2020 12:31:49 +0530
Message-Id: <20200320070157.4206-19-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200320070157.4206-1-jaskaransingh7654321@gmail.com>
References: <20200320070157.4206-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 20 Mar 2020 08:03:25 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 20 Mar 2020 08:03:23 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v3 18/26] parsing_cocci: unify_ast: Add cases for
	ParenType/FunctionType
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

ParenType and FunctionType are now added to the SmPL ASTs. Add
cases for these types in unify_ast.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/unify_ast.ml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/parsing_cocci/unify_ast.ml b/parsing_cocci/unify_ast.ml
index d4ad3030..de86b1d3 100644
--- a/parsing_cocci/unify_ast.ml
+++ b/parsing_cocci/unify_ast.ml
@@ -336,6 +336,14 @@ and unify_typeC t1 t2 =
 	 unify_fullType tya tyb &&
 	 unify_dots unify_parameterTypeDef pdots paramsa paramsb
        else false
+  | (Ast.ParenType(lpa,tya,rpa),Ast.ParenType(lpb,tyb,rpb)) ->
+      unify_fullType tya tyb && unify_mcode lpa lpb && unify_mcode rpa rpb
+  | (Ast.FunctionType(tya,lpa,paramsa,rpa),
+     Ast.FunctionType(tyb,lpb,paramsb,rpb)) ->
+      unify_fullType tya tyb &&
+      unify_mcode lpa lpb &&
+      unify_dots unify_parameterTypeDef pdots paramsa paramsb &&
+      unify_mcode rpa rpb
   | (Ast.Array(ty1,lb1,e1,rb1),Ast.Array(ty2,lb2,e2,rb2)) ->
       unify_fullType ty1 ty2 && unify_option unify_expression e1 e2
   | (Ast.Decimal(dec1,lp1,len1,comma1,prec_opt1,rp1),
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
