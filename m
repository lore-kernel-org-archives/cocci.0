Return-Path: <SRS0=O8dQ=7N=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82A0C433E1
	for <cocci@archiver.kernel.org>; Sun, 31 May 2020 15:28:27 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66F57206DA
	for <cocci@archiver.kernel.org>; Sun, 31 May 2020 15:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4I11BUH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66F57206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04VFSPao028023;
	Sun, 31 May 2020 17:28:25 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 32D227752;
	Sun, 31 May 2020 17:28:25 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 20C487752
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 17:28:23 +0200 (CEST)
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:642])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04VFSLcF028632
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 17:28:22 +0200 (CEST)
Received: by mail-pl1-x642.google.com with SMTP id y11so3213677plt.12
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 08:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NXUeytJ5uRBtX8W1ChtiyG/4HvNDjSGAAyZIqVaTHdw=;
 b=b4I11BUHNWbIm38/UnWDKfD2vpmg8rkjW7lirjMXKczqCxh7vxqZqF8QMiMC3J7u1f
 /lW3QAguRQwJ/NaHPDaWtU45/Vy4UTi1gfxmNMoBznK/Meseh94CUtbovIhZ3Mro0rrV
 KzoiiLsQnQ1axb2HHVczygjNwC7vdhG3IceYfovTlw0YA/fdX07jKSnCZsaR2t5946Jd
 1DJxnMxCm1Dwk8l+E5kUu/UmU5ifoLEB/zC647478TFXIgPY+nyOsuFnig4WDwEcx/1j
 RyjjjsPet7fHCov4sK69LmJvCNSHc0g/nCMNKkCCrL7hc3IgKlwGJ+zKpUWfSGXDfZGd
 gWkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NXUeytJ5uRBtX8W1ChtiyG/4HvNDjSGAAyZIqVaTHdw=;
 b=BdR/BZV2coxvQ3XO/XaGPq2jUBlIw6hzRWTdBBIVrQmtGcPW2KpUTXSS2gNYrwATUQ
 nOGrA9wApryCoQBUujx5Hmh4z2izGHgezTocDo0Cx979qGbo8CZ5o2gkrIuA3D7pdzJ7
 rJq3ahLoP6C2ff4xIaSlHyprl1VUfjJ6FNlsk3KjxTK4WGe2c0KcxiQsiADyUchQYued
 Jw139J3jioiv3cFgFke2P1wLtvbh/IMPIsRmQQV7PxrNHK62qR4EpN4jyR8v+lAKE4ga
 xHim67raDriQaZ8//j27WXCSmUsuUyAPccnPfeLyBMwv36gWurYZOyaLMpfLqEGbZ8L9
 u4JA==
X-Gm-Message-State: AOAM530p0tol/xHK0FYgPpZOAcslPHi9HsRratsDIlcemfZW+xOol0sa
 9+w+4r7tlXpucMot1A2rCApuaXtr
X-Google-Smtp-Source: ABdhPJyjbPoVru2z3LJr+IjdZ2gwKBF3O/42f+YAw0BKqoK8FgYFwLQFBqdpVhUCR/pagLdKv1WthQ==
X-Received: by 2002:a17:902:7e01:: with SMTP id
 b1mr2560600plm.234.1590938900707; 
 Sun, 31 May 2020 08:28:20 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:1863:fef5:a170:128b:8ef:499d])
 by smtp.gmail.com with ESMTPSA id 131sm12310443pfv.139.2020.05.31.08.28.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2020 08:28:20 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sun, 31 May 2020 20:56:18 +0530
Message-Id: <20200531152621.2886-25-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200531152621.2886-1-jaskaransingh7654321@gmail.com>
References: <20200531152621.2886-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 31 May 2020 17:28:25 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 31 May 2020 17:28:22 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 24/27] tools: spgen: Reflect struct end attributes
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

Struct end attributes are added to the SmPL AST. Reflect these changes
in spgen.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 tools/spgen/source/position_generator.ml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/spgen/source/position_generator.ml b/tools/spgen/source/position_generator.ml
index deca6f73..e70a47b4 100644
--- a/tools/spgen/source/position_generator.ml
+++ b/tools/spgen/source/position_generator.ml
@@ -412,8 +412,8 @@ let rec declaration_pos decl snp
       let _ = type_pos ty snp in (* sanity check *)
       let constructor ~id = Ast0.UnInit(st, ty, id, attr, sem) in
       id_wrap ~id ~constructor snp
-  | Ast0.TyDecl (t, sem) ->
-      let c ~item ~mc = Ast0.TyDecl(item, mc) in
+  | Ast0.TyDecl (t, attr, sem) ->
+      let c ~item ~mc = Ast0.TyDecl(item, attr, mc) in
       let alt() = mcode_wrap ~mc:sem ~constructor:(c ~item:t) snp in
       item_wrap ~item:t ~item_posfn:type_pos ~constructor:(c ~mc:sem) ~alt snp
   | Ast0.Typedef (tm, tc, tc2, sem) ->
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
