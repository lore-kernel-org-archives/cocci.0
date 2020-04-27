Return-Path: <SRS0=J+r8=6L=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B56C7C8A0
	for <cocci@archiver.kernel.org>; Mon, 27 Apr 2020 12:09:41 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78C33206D4
	for <cocci@archiver.kernel.org>; Mon, 27 Apr 2020 12:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NmqQY35i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78C33206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03RC9SrQ017694;
	Mon, 27 Apr 2020 14:09:28 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 8D1CA7807;
	Mon, 27 Apr 2020 14:09:28 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 154157769
 for <cocci@systeme.lip6.fr>; Mon, 27 Apr 2020 14:09:26 +0200 (CEST)
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:641])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03RC9Oof003300
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 27 Apr 2020 14:09:25 +0200 (CEST)
Received: by mail-pl1-x641.google.com with SMTP id c21so6108211plz.4
 for <cocci@systeme.lip6.fr>; Mon, 27 Apr 2020 05:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Y8ZHPI+OwU9oMruCD+HaFNKjHqJkEPQxmCEE5Iwn03A=;
 b=NmqQY35iehVgxP4i8gvvBxszfvC8nkumeG/PxMJGLF23TqSpDyOcrpGZF5SeA1VXYZ
 AKdUeKfL4KpKvKkSUewbuIb7FqSqzPNLIltqqcnH5DfkYQwdxBDcO8AxrMr9hpQ1D1Ch
 X6tlUmDCKSSs+/pGs32DQ5Zm4XzdQvl4H/2xqaG55JVD6lb35ATH9iWenaYu43Bi1+oN
 9ZsakCeBN6FHQLs/zQU9jvCYW3xKME9VAiJ9xM9zaLTroxHYG83dh6kNfesdsK2CFBH3
 i13neGSVMJACd2RAyoC84KwehypyTx+Z5RzS57Aj6tBwYzsFHnoKrAPM+rVsS85Sg4VD
 VR3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Y8ZHPI+OwU9oMruCD+HaFNKjHqJkEPQxmCEE5Iwn03A=;
 b=kM7OMoN3fSDfKU6ME0iZL2Ejv5nG3oUQAmphKyV6BJGKwcpbek5no3dhcUO/IshZOg
 0qrJNdJq35Um/P/xHABIdWDqZqRoHhLpDMDCYIjadlR4EsMUJMQKy6JNm3Q32etVZF0O
 yBw2QBhQd0umGqKYebXDk7+gKCMLVI/ef4yUz2pcD7pvrWZxkHE46/BIChtYicJKTMWY
 dNzyp8yBNBhj5GCeIp16jSOoL7gdtlhMVHhFxMN2KrPLRwdCYZEZzCeROAIHnDKnA8EM
 hF0vS/6kE2Vmb2DuBDKR2sjuRZoAGckhP07R6spPjncXzv5I6AvcGUvKIZZ0dpuI1aZj
 Cz7A==
X-Gm-Message-State: AGi0PuZ+JYrmKkOiTBZ7KHpXc1jgD3T7Dwy16snW/2tlm96FjPJlgBWL
 kgDGbVUOgZLvFjaURlPwxP4T15PhfBc=
X-Google-Smtp-Source: APiQypIN3KbcpR6U44B6B55F3wf7t+GAMDkRx3Jvx3RARN2A8Y2599NacCy7P8Rjb6yZNISv9bv8hQ==
X-Received: by 2002:a17:902:c487:: with SMTP id
 n7mr19158966plx.316.1587989363512; 
 Mon, 27 Apr 2020 05:09:23 -0700 (PDT)
Received: from localhost.localdomain ([1.38.220.114])
 by smtp.gmail.com with ESMTPSA id r17sm9623885pgn.35.2020.04.27.05.09.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2020 05:09:22 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 27 Apr 2020 17:38:20 +0530
Message-Id: <20200427120834.380-10-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200427120834.380-1-jaskaransingh7654321@gmail.com>
References: <20200427120834.380-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 27 Apr 2020 14:09:28 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 27 Apr 2020 14:09:25 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 09/23] parsing_cocci: index: Reflect Parameter
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

Parameter attributes are added to the SmPL AST. Reflect these changes in
index.ml.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/index.ml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/parsing_cocci/index.ml b/parsing_cocci/index.ml
index f7ae48b4..1baeb2bb 100644
--- a/parsing_cocci/index.ml
+++ b/parsing_cocci/index.ml
@@ -157,8 +157,8 @@ let initialiser i =
 
 let parameterTypeDef p =
   match Ast0.unwrap p with
-    Ast0.VoidParam(ty) -> [59]
-  | Ast0.Param(ty,id) -> [60]
+    Ast0.VoidParam(ty,attr) -> [59]
+  | Ast0.Param(ty,id,attr) -> [60]
   | Ast0.MetaParam(name,_,_) -> [61]
   | Ast0.MetaParamList(name,_,_,_) -> [62]
   | Ast0.PComma(cm) -> [63]
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
