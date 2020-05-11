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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFF1C54E8D
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:08:40 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6F7820720
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/bv8DFA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6F7820720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04BA8T7r012201;
	Mon, 11 May 2020 12:08:29 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 4AF763E6B;
	Mon, 11 May 2020 12:08:29 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 12B613DC8
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:08:28 +0200 (CEST)
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:442])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04BA8QhX025071
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:08:27 +0200 (CEST)
Received: by mail-pf1-x442.google.com with SMTP id x2so4531967pfx.7
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 03:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=u8KQVzS3ah3vs2qqwXtIf9FY1LkUh04IBlZi8QJebGs=;
 b=f/bv8DFAI7W+ehUyYUAJu2tHzH7mzfNDwhIClieF6e+fAv23fHWo1u1yyLifCGXpUX
 yN3wbVMbo1u/e6NkNYa+rolYjy+KqN1ozIYERXKBRI25kFJM228zGIfqk55Iue74gury
 l6lj2+BdtY37qe62OpoceBVtoOv5EM2fio0WNglVgsliePh7mNmt+5lTlDUJcxKQbVCT
 RPo2bFe1/6bF5ys3q+JBY1403qqabcXPgbxMhAIHzL99qVUGVeTFAlaEjt7SHQ8ibe1c
 QD87yj8pCkMNqAialQUzYsH7u/fUpAomAoaACFzD3ufelNdi7z2Q0rU+LLhVaMqdbXwp
 ZGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=u8KQVzS3ah3vs2qqwXtIf9FY1LkUh04IBlZi8QJebGs=;
 b=oNGYaT6IpMe3wzqq8LrH+kEWZkoGlImdporHGRZ6So4S37bNtTnadbf/pdYwGPXboQ
 nthVwoebNxoMvnUcj2v9L5y6/oiQPy5mU70BekSk1DnNby5+axLF2fyb3+1jmJXp3S8g
 1x2vXPZKmIUeNabRQhwLaAuM4sUT/tdQXnC7CoRT+ewbbeEojEJCxZGEqagEw7gC4+YG
 gcOTAYfHojRLtnlDtbvMLU4qcnCxflk+cWpV6L/pfnkSulE02B0TYYuELIHjGKrP7g+m
 xGwXDaew5MiPPYZbj2hAozmNCjU8TyBhQoe0dEpu/g/lmjcPJWX83L9GGW9Obh9gMwwr
 57iQ==
X-Gm-Message-State: AGi0Pub2guAW1/sZUUNSMHRQy32B0li9GPosjPKPAPj/C6kMfq+a7xy5
 rQ0+8mmLae2JWcL9bj7oS0JMnoQrw5E=
X-Google-Smtp-Source: APiQypJ3gxIirL+0dqthlJIwHpjTYRgTzmKY/mYaqLgoCFnBwMuV642/jYFF+uB3+BF7am3qvWRChw==
X-Received: by 2002:a62:64cd:: with SMTP id
 y196mr14885547pfb.116.1589191705705; 
 Mon, 11 May 2020 03:08:25 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:382:66db:4729:1ab8:2139:8945])
 by smtp.gmail.com with ESMTPSA id
 o99sm9772994pjo.8.2020.05.11.03.08.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 03:08:25 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 11 May 2020 15:36:56 +0530
Message-Id: <20200511100715.19819-14-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200511100715.19819-1-jaskaransingh7654321@gmail.com>
References: <20200511100715.19819-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 11 May 2020 12:08:29 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 11 May 2020 12:08:27 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v2 13/32] parsing_cocci: single_statement: Reflect
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
single_statement.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/single_statement.ml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/parsing_cocci/single_statement.ml b/parsing_cocci/single_statement.ml
index 4ad1c4e4..73554e9c 100644
--- a/parsing_cocci/single_statement.ml
+++ b/parsing_cocci/single_statement.ml
@@ -138,7 +138,7 @@ let rec left_expression e =
   | Ast0.ArrayAccess(exp1,lb,exp2,rb) -> left_expression exp1
   | Ast0.RecordAccess(exp,pt,field) -> left_expression exp
   | Ast0.RecordPtAccess(exp,ar,field) -> left_expression exp
-  | Ast0.Cast(lp,ty,rp,exp) -> modif_before_mcode lp
+  | Ast0.Cast(lp,ty,attr,rp,exp) -> modif_before_mcode lp
   | Ast0.SizeOfExpr(szf,exp) -> modif_before_mcode szf
   | Ast0.SizeOfType(szf,lp,ty,rp) -> modif_before_mcode szf
   | Ast0.TypeExp(ty) -> left_typeC ty
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
