Return-Path: <SRS0=FJ6B=7K=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADA8C433DF
	for <cocci@archiver.kernel.org>; Thu, 28 May 2020 12:25:56 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B4BA20888
	for <cocci@archiver.kernel.org>; Thu, 28 May 2020 12:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVCF/3Ut"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B4BA20888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04SCPrPn028024;
	Thu, 28 May 2020 14:25:53 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E2E8D5D47;
	Thu, 28 May 2020 14:25:52 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 044FB3E1D
 for <cocci@systeme.lip6.fr>; Thu, 28 May 2020 14:25:51 +0200 (CEST)
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1041])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04SCPnuJ029089
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Thu, 28 May 2020 14:25:50 +0200 (CEST)
Received: by mail-pj1-x1041.google.com with SMTP id cx22so3133719pjb.1
 for <cocci@systeme.lip6.fr>; Thu, 28 May 2020 05:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=thv5I0AzqjXXuHTBbXXaR1eYEonA5aOATmSFwn/Lm54=;
 b=MVCF/3UtTtALvLG9g4B0JSWTxccpc0vdMaLHcB0idOVl6KX8ZBkglWypkyHvLS/yT3
 ZgvLWCYABfRPLpDeqsCGJAAsyPCK06WoyTHZ6CsW1TuOXI69wuVD/mc8am7eStkdVbEs
 t4M84fc0t58RNkQGKyVg5mQKd9OPNIe7xcymCNBajukPtz9xsS1fwN22QF588udcLYvD
 mJGX9Ui+kAF/DaerT5LRE+E0U2QvZoKzTNT4jw9tEzdjY+Nk9wWvMLfO/+5QelvvEo9n
 OSc81zdxYcg/2ax0RJzQwtCMRpWYsjF5xJGMOUf6s2MN+STkMJY0ZVZJE2GqakdhImyy
 twQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=thv5I0AzqjXXuHTBbXXaR1eYEonA5aOATmSFwn/Lm54=;
 b=SSrtGTDMzpzmgmlRKU1nRG2maQcC4V+uSa6C1ItDikGVlqOkS76h6nSf4TgMzMlOQw
 pQh6C8D6MV7s+/cbljv/EiVuy+JMaZazYHcjoZb8gwZLwpU26Tj3QI9MQLs6q1cpn+P9
 fw6cOqvUd4Tw+ItAzWpu2+/rJQaCM8nHyNvwfp792GdkL2zV9sVBxN4GHczyKJoveAdZ
 Ecfek+7GWXDkrsvL0GwNa5+9rBQH/EvkKYqyl2bcrmAXDp9f13/qwORX8OmlK3kq5v/w
 VkmC+Yll+MQhYAdDrQRuRznpksWi1EnlfqcjuFJdgP2UTqZsmozghg+DmyLSnF4jomGt
 pRKw==
X-Gm-Message-State: AOAM531t2FDKQ5SReQofkoizapPGzO0alIK9Z/VgFd8A0G0gQfI2PMIX
 KaLik+UXx+pHZ+KgHbw4q7EA6YYN
X-Google-Smtp-Source: ABdhPJwoXPsAv5gXc7GjR6/Pw89dlO1qZKOf0QdW98OIG8QSlzXhFNk/mOB1Tdjq5n7Y44opMdAgDg==
X-Received: by 2002:a17:90b:4010:: with SMTP id
 ie16mr3504303pjb.138.1590668748574; 
 Thu, 28 May 2020 05:25:48 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:2183:e360:deba:7bf4:98ef:5568])
 by smtp.gmail.com with ESMTPSA id 1sm5722888pje.26.2020.05.28.05.25.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2020 05:25:48 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Thu, 28 May 2020 17:54:21 +0530
Message-Id: <20200528122428.4212-20-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200528122428.4212-1-jaskaransingh7654321@gmail.com>
References: <20200528122428.4212-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 28 May 2020 14:25:53 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Thu, 28 May 2020 14:25:50 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v2 19/25] cocci: Add parameter attributes to C AST
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

With extended support of attributes, parameter attributes are needed in
the C AST so that the nocast test case does not break.

Add the p_attr field to parameter in the C AST.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 ocaml/coccilib.mli  | 1 +
 parsing_c/ast_c.ml  | 1 +
 parsing_c/ast_c.mli | 1 +
 3 files changed, 3 insertions(+)

diff --git a/ocaml/coccilib.mli b/ocaml/coccilib.mli
index bc355512..5e31eec3 100644
--- a/ocaml/coccilib.mli
+++ b/ocaml/coccilib.mli
@@ -109,6 +109,7 @@ module Ast_c :
       p_namei : name option;
       p_register : bool wrap;
       p_type : fullType;
+      p_attr : attribute list;
     }
     and typeQualifier = typeQualifierbis wrap
     and typeQualifierbis =
diff --git a/parsing_c/ast_c.ml b/parsing_c/ast_c.ml
index b53c8060..204bd412 100644
--- a/parsing_c/ast_c.ml
+++ b/parsing_c/ast_c.ml
@@ -287,6 +287,7 @@ and fullType = typeQualifier * typeC
         { p_namei: name option;
           p_register: bool wrap;
           p_type: fullType;
+          p_attr: attribute list;
         }
         (* => (bool (register) * fullType) list * bool *)
 
diff --git a/parsing_c/ast_c.mli b/parsing_c/ast_c.mli
index 61935c18..5411bbb3 100644
--- a/parsing_c/ast_c.mli
+++ b/parsing_c/ast_c.mli
@@ -73,6 +73,7 @@ and parameterType = {
   p_namei : name option;
   p_register : bool wrap;
   p_type : fullType;
+  p_attr : attribute list;
 }
 and typeQualifier = typeQualifierbis wrap
 and typeQualifierbis = { const : bool; volatile : bool; }
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
