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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD2EC54E4B
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:14:52 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1C8D2075E
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVAxggjS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1C8D2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04BAEfKG026501;
	Mon, 11 May 2020 12:14:41 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 6C0463E6B;
	Mon, 11 May 2020 12:14:41 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 2FB063DC8
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:14:39 +0200 (CEST)
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:543])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04BAEbH5012294
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:14:38 +0200 (CEST)
Received: by mail-pg1-x543.google.com with SMTP id r22so2765788pga.12
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 03:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9rp94vOsb/WaVd2HONzi5/Y3mPcPmoWehtgmjY+02Yc=;
 b=mVAxggjSUktZATDW/AKuRVG6NV6v6VAYOz6SPYtFE2XbqMJnTbFsFRWqfbOUSazZL6
 qFFQ6MPRUQWb2lBhFFUtLeY5mrsk2IgaLBcERRzIFXTSdkdaWD0L8J1zPtvC8qnpq6KO
 DA6fdVVJB6tsHLCNaMNbLBMYzboKsaza782mT+8S9iPT0OYxxAJHYoq49W21z1IwyyEf
 x+NdXaTaoErVv0Nqr++8gIkaZaDvzK6mbFG2MoZ7RbIi8xawDJk6wYyOQJCITT4ZJd0q
 kptuDd8qroeVtALhDHrhWExRNEg6N2/QZsCun1UYreJFrjiXbDAltq2cBTW5xNJHnba/
 FZow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9rp94vOsb/WaVd2HONzi5/Y3mPcPmoWehtgmjY+02Yc=;
 b=t9fRd+qVvM+5G3DNRMp6eEXBhY6Q632OFGIl1sc4C+VySwMHJyUVg+OwZAWW1Ivf/4
 v//0kgvwU2VR6jsggTfn9XWJXDrlw26uAA0KsInQ54pfMYjinP1veKXjt9R3ZceWA1LF
 Qo0LfKOPTHftE5hbuXfgkrZSjvYH8Cny9u+jgejylYq2DRrrw/VbzMEnQSbBgXfN02ZE
 zL4MvlTs8LK+/15xLzFrWaUqUak1qoFdQivVqMrf1rkyt4cGLRXhFlqMEAc8+RzTo//V
 NYvAcRpsX6BxnDk2NCyW7y7vCyYA0jyX6x2xU/6fs9+8AwvP9OxiPtLoGqG1ZlOYMFl0
 rqkA==
X-Gm-Message-State: AGi0PuYTYsEEUYNeBmz1A5GMi1XETWKbQ+gVXvdPaKQIyRHixvjZFLoL
 pVsfz7SpOjnXjFvt8kSxOtQviVtGB/I=
X-Google-Smtp-Source: APiQypKkEsjecjpPON+uAKVh4rqgd934MqnjM1VhCYaY39ZAp7bqP1hNcQoIYgHOo4urQowhg70yuA==
X-Received: by 2002:aa7:9a11:: with SMTP id w17mr15331171pfj.314.1589192076774; 
 Mon, 11 May 2020 03:14:36 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:382:66db:4729:1ab8:2139:8945])
 by smtp.gmail.com with ESMTPSA id
 j14sm10021121pjm.27.2020.05.11.03.14.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 03:14:36 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 11 May 2020 15:42:58 +0530
Message-Id: <20200511101300.11101-22-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200511101300.11101-1-jaskaransingh7654321@gmail.com>
References: <20200511101300.11101-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 11 May 2020 12:14:41 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 11 May 2020 12:14:38 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v3 21/23] ocaml: coccilib: Reflect Parameter
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
coccilib.mli.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 ocaml/coccilib.mli | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/ocaml/coccilib.mli b/ocaml/coccilib.mli
index 0e807c9a..59c58aea 100644
--- a/ocaml/coccilib.mli
+++ b/ocaml/coccilib.mli
@@ -2825,8 +2825,8 @@ module Ast_cocci :
     and initialiser = base_initialiser wrap
     and base_parameterTypeDef =
       Ast_cocci.base_parameterTypeDef =
-        VoidParam of fullType
-      | Param of fullType * ident option
+        VoidParam of fullType * attr list
+      | Param of fullType * ident option * attr list
       | MetaParam of meta_name mcode * constraints * keep_binding * inherited
       | MetaParamList of meta_name mcode * listlen * constraints *
           keep_binding * inherited
@@ -3455,8 +3455,8 @@ module Ast0_cocci :
     and initialiser_list = initialiser dots
     and base_parameterTypeDef =
       Ast0_cocci.base_parameterTypeDef =
-        VoidParam of typeC
-      | Param of typeC * ident option
+        VoidParam of typeC * attr list
+      | Param of typeC * ident option * attr list
       | MetaParam of Ast_cocci.meta_name mcode * constraints * pure
       | MetaParamList of Ast_cocci.meta_name mcode * listlen * constraints *
           pure
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
