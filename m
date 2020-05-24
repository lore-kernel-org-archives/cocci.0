Return-Path: <SRS0=Qcbb=7G=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3CB0C433DF
	for <cocci@archiver.kernel.org>; Sun, 24 May 2020 17:21:48 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AAFF206C3
	for <cocci@archiver.kernel.org>; Sun, 24 May 2020 17:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sEeo/ccl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AAFF206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04OHLjD3012650;
	Sun, 24 May 2020 19:21:45 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D04B83DC8;
	Sun, 24 May 2020 19:21:45 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 631EF3D0F
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 19:21:44 +0200 (CEST)
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:543])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04OHLgeY014598
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 19:21:43 +0200 (CEST)
Received: by mail-pg1-x543.google.com with SMTP id j21so7688896pgb.7
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 10:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LwXHrBD+rmq9gdOcoavOOb0N3UvZHXCtuCVe4UcJ9D0=;
 b=sEeo/cclPX9AMnvlalYglPPiHiRdTleXiIRY3/3xckIGZ83965nkFuzOs+yCm9vMaa
 NL8lzUfFgv03WNoabO5XwniVDf7mj8q6iub0eArrGbd4dCse+W147sGzN6oYF/EdwLjo
 vgjzKr922olBizK4OSg4/rhnY23NEI2UUrb2PkyA+VcJe6iPzinYwQg34Tz68FhrIz2R
 48lHa/uHTWz3+dj/kOEYcJnhU9+oqZ7bB9f3QlDorUPUdvif9drFqYGH6ZhpwIAI5zo/
 DpwuvvOKigt1coc/FYH7thQw8FxE5cZkrjD09VGn2D3qwiNcbd+tK7ygSDdKK97n8j6H
 v6Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LwXHrBD+rmq9gdOcoavOOb0N3UvZHXCtuCVe4UcJ9D0=;
 b=iFPoWSoVZwmvaZTDtx763uMWI3rGBZsBxdriWOi5IAY3F1Qs0OKBTF0JBsLS7MOuHI
 IWevkJLw0UgqTp4noIAro9OtK14LR6GabSQH/CwfzgFbY74JLmB/WQaCTx9gNwlsqCPD
 nzYuTvbu1JwUan+SLzZiVJcrqS3xyhKotwjtGS4GGS115NbpjEryWb7TDvvJiv/dCcdl
 yIdyOXfQuu2CrYj+VqseWtu8PNnr7BJ0vfrNBvUUZenWNipgc8UBTtVTID1jwI4allev
 bzhEhEBRQh3OmPA8nbKNZF+hTwYPo82CnsVkR1ey+YzZCR1Km0HFyCRoh4YppePVEGoV
 Th1Q==
X-Gm-Message-State: AOAM531dYbm5C10e+0pahFBuD3AJ/GB0Z9nzHCN+tSxDvoU7XIlXWyOL
 e+W09VNPKzl8BA2rumgpDiMLKyg+No0=
X-Google-Smtp-Source: ABdhPJy9UHE2uySp1fP7Q7tceRsZo5fjJGyZ0fS9lNHE3abeyXcRjQbJQzeJ77/Q4pKEHTabSCc+ag==
X-Received: by 2002:a63:df42:: with SMTP id h2mr23942179pgj.216.1590340902072; 
 Sun, 24 May 2020 10:21:42 -0700 (PDT)
Received: from localhost.localdomain ([1.38.220.54])
 by smtp.gmail.com with ESMTPSA id d9sm6556497pfn.72.2020.05.24.10.21.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2020 10:21:39 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sun, 24 May 2020 22:49:25 +0530
Message-Id: <20200524171935.2504-21-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200524171935.2504-1-jaskaransingh7654321@gmail.com>
References: <20200524171935.2504-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 24 May 2020 19:21:45 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 24 May 2020 19:21:43 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 20/30] parsing_c: ast_c: Add Macrodecl attributes
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

Add cast attributes to the C AST. This is a list of attributes in the
Macrodecl type of the C AST.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_c/ast_c.ml  | 3 ++-
 parsing_c/ast_c.mli | 4 +++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/parsing_c/ast_c.ml b/parsing_c/ast_c.ml
index 204bd412..f666d33c 100644
--- a/parsing_c/ast_c.ml
+++ b/parsing_c/ast_c.ml
@@ -561,7 +561,8 @@ and declaration =
   (* cppext: *)
     (* bool is true if there is a ; at the end *)
   | MacroDecl of
-      (storagebis * string * argument wrap2 list * bool) wrap (* fakestart *)
+      (storagebis * string * argument wrap2 list * attribute list * bool)
+        wrap (* fakestart *)
   | MacroDeclInit of
       (storagebis * string * argument wrap2 list * initialiser)
 	wrap (* fakestart *)
diff --git a/parsing_c/ast_c.mli b/parsing_c/ast_c.mli
index 5411bbb3..95da1f5f 100644
--- a/parsing_c/ast_c.mli
+++ b/parsing_c/ast_c.mli
@@ -201,7 +201,9 @@ and exec_code_bis = ExecEval of expression | ExecToken
 and exec_code = exec_code_bis wrap
 and declaration =
     DeclList of onedecl wrap2 list wrap
-  | MacroDecl of (storagebis * string * argument wrap2 list * bool) wrap
+  | MacroDecl of
+      (storagebis * string * argument wrap2 list * attribute list * bool)
+        wrap
   | MacroDeclInit of
       (storagebis * string * argument wrap2 list * initialiser) wrap
 and onedecl = {
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
