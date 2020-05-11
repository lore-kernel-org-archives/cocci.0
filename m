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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BBDC54E4B
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:08:31 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E42F520720
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="th1SObh9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E42F520720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04BA8IcP007120;
	Mon, 11 May 2020 12:08:18 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 1EFE93E6B;
	Mon, 11 May 2020 12:08:18 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 75C903DC8
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:08:16 +0200 (CEST)
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:644])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04BA8ERi020309
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:08:15 +0200 (CEST)
Received: by mail-pl1-x644.google.com with SMTP id t7so3746255plr.0
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 03:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ya/wxKSqb2SwN0YcwXa6DDweA8dU0H84ms/FmoW8w/8=;
 b=th1SObh94hbucHniDvHUBo2VEFB8WmAbflICSE0XDJWzho3x7xxvnex3KsvracZBKD
 nCNxxtfLJ97IvWbOsPGQY9DDBYBJ1VuNsrhDAtrMwrpkijCBk2S5bmaGP8fAC2tJSPj6
 pFW+GcvDcu8ZRdUGzti8h8D8VJR4AooRdGcAmd/ElgC+JrkBVYQ4xSCXHmOscsgrnPG0
 KH+elIPYbyPR5zlErN9TpfD2A2ywimlJLWJuPhYgcbGSQl1Sway9dsZE2fbk/UPcRaU0
 9COlIqbbPCVfaXo1mGS1cV2ZNQ+kykb7q9seWGGJ0MGFQkt3JnwzASLnn+KTeJREkCMX
 witw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ya/wxKSqb2SwN0YcwXa6DDweA8dU0H84ms/FmoW8w/8=;
 b=tp35dGComOMJUage6BTewPDSOPhOq5Q+Ax9F+vtHXGlv8cdVBn2t3ih5V9KXZtXwgS
 poPhbWOEw0YWfKjBDi32zDBIwlyO60GhpqAjqJG1bk+UWj6XIIfG9np8APlmfQAG7qRd
 SXh1rGeMZLzP+jxgB5lwLNK/W5IwjfxTrKeX3SKwPpuckmGn7AQNZIQjeRHKQnwGf2U5
 DIigiVIBTiO5ffR4FywKvWsplkoERH3l/KfVgL3btWjwXnmaKngP2FmHiIlmUGembBrR
 JNY8+2UmmCpbrExE8Iwcl7p6+wLU05hvUUGq9rHmzGuutMLgpU6JO3c1+/Wd1sq/Bj2p
 RpfQ==
X-Gm-Message-State: AGi0PuZLRft2Rwtg7fObU+mLmcDDGFoKhq4cfiXFWwrnbt8Bp+XWNneu
 dUb57C2xCIVY2ol6g/s6tGT5KEWFQEE=
X-Google-Smtp-Source: APiQypJBvX+2nCKMG1bpOgI/8A8T06j8smA0YlH2C3uKMSrgbRpEa8akJI2IJcnhDrs8bflHRAPN+w==
X-Received: by 2002:a17:90a:f418:: with SMTP id
 ch24mr21284572pjb.68.1589191694190; 
 Mon, 11 May 2020 03:08:14 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:382:66db:4729:1ab8:2139:8945])
 by smtp.gmail.com with ESMTPSA id
 o99sm9772994pjo.8.2020.05.11.03.08.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 03:08:13 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 11 May 2020 15:36:53 +0530
Message-Id: <20200511100715.19819-11-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200511100715.19819-1-jaskaransingh7654321@gmail.com>
References: <20200511100715.19819-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 11 May 2020 12:08:18 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 11 May 2020 12:08:16 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v2 10/32] parsing_cocci: check_meta: Reflect Cast
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
check_meta.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/check_meta.ml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/parsing_cocci/check_meta.ml b/parsing_cocci/check_meta.ml
index 5a348ba3..4f7db813 100644
--- a/parsing_cocci/check_meta.ml
+++ b/parsing_cocci/check_meta.ml
@@ -172,7 +172,8 @@ let rec expression context old_metas table minus e =
   | Ast0.RecordPtAccess(exp,ar,field) ->
       expression ID old_metas table minus exp;
       ident FIELD old_metas table minus field
-  | Ast0.Cast(lp,ty,rp,exp) ->
+  | Ast0.Cast(lp,ty,attr,rp,exp) ->
+      (* No meta attribute yet *)
       typeC old_metas table minus ty; expression ID old_metas table minus exp
   | Ast0.SizeOfExpr(szf,exp) -> expression ID old_metas table minus exp
   | Ast0.SizeOfType(szf,lp,ty,rp) -> typeC old_metas table minus ty
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
