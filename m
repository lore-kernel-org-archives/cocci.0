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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DED4C7C8A0
	for <cocci@archiver.kernel.org>; Mon, 27 Apr 2020 12:10:22 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A052620656
	for <cocci@archiver.kernel.org>; Mon, 27 Apr 2020 12:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTUKl3nY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A052620656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03RCABex003511;
	Mon, 27 Apr 2020 14:10:11 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 200337807;
	Mon, 27 Apr 2020 14:10:11 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 492E67769
 for <cocci@systeme.lip6.fr>; Mon, 27 Apr 2020 14:10:09 +0200 (CEST)
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:642])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03RCA7D8002857
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 27 Apr 2020 14:10:08 +0200 (CEST)
Received: by mail-pl1-x642.google.com with SMTP id t4so6907298plq.12
 for <cocci@systeme.lip6.fr>; Mon, 27 Apr 2020 05:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9rp94vOsb/WaVd2HONzi5/Y3mPcPmoWehtgmjY+02Yc=;
 b=MTUKl3nYdwXWzJYe10mdc4vBI+I+lB+g8bn0UlmiKN6OUFPpinSaiabKfIwAGvF0DU
 wygegplKBpp3GFjelM+lgzLYJjsE6MpUh3ycWjOZtcmnu/25LHbKckzGN82+wWEDiQG6
 BKdctNdt1MFThdMt0/STr2PG8seDfBbSOqZNUPJKVmCik8ymocf392L/q2Umj5+T6imU
 6Jpztiv5UeSx3wWbl5eigKCZaZvj7OvRrGUQwM81axH6kc+sKHQngNyZAYroR2C0mCRN
 ehlWOitxWhfOhYZ4R28ygAE8jUo8QpvfnfuNC3IwqvRn3dkHJai6A4yvd/lQwXCm3pI6
 8nHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9rp94vOsb/WaVd2HONzi5/Y3mPcPmoWehtgmjY+02Yc=;
 b=g3Hs4f+PY0KVRA/BhsQEM2s1yChrWyDLi8gAjH65tBa8S0LV8tkcbLdVHscq87sDNa
 NGuSiOcyb9Ix5qMUQ0rbC/6Z2a6QpTGuGps1ummC0akJwvNHxHMZST+9HxaXt5eG4N3g
 HrDuVI30H3cu0eltF/NZe6ouU9RWcg9/5z/cMBmhSq4TJHtcyL+3cJEOyckTVW1EMHCS
 aqq22Q2TDJkuJOPKxdYzOU+ZZXgsRvoss+CqQx+VhpMaU+YXOJF5Q6Bl4f9GUvbnPWkg
 dIgnePg0xi2Cd7ON8WWW7pydBvWywUWfPhQEy5XIEJrvDNGwNczPAny7XDVEekTuthnK
 r14w==
X-Gm-Message-State: AGi0PuabX6Bw4RZIJFC28zSkomF3UE8uEcErAP4RJhBuLzp9MvLgNS1F
 3K6BBbwcYH/aAPRXWyq5OJ6VXI4HVTA=
X-Google-Smtp-Source: APiQypLttKCJQx25f1PpyqB57wNN+tRB8JaesQWDcryJdWNNGdba10b3PR6gCeEbOsYMXAyllRkh4A==
X-Received: by 2002:a17:90a:21ee:: with SMTP id
 q101mr22653052pjc.24.1587989406854; 
 Mon, 27 Apr 2020 05:10:06 -0700 (PDT)
Received: from localhost.localdomain ([1.38.220.114])
 by smtp.gmail.com with ESMTPSA id r17sm9623885pgn.35.2020.04.27.05.10.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2020 05:10:06 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 27 Apr 2020 17:38:32 +0530
Message-Id: <20200427120834.380-22-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200427120834.380-1-jaskaransingh7654321@gmail.com>
References: <20200427120834.380-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 27 Apr 2020 14:10:11 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 27 Apr 2020 14:10:08 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 21/23] ocaml: coccilib: Reflect Parameter attributes
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
