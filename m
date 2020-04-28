Return-Path: <SRS0=bJsz=6M=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B885C83009
	for <cocci@archiver.kernel.org>; Tue, 28 Apr 2020 17:03:55 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB1AF205C9
	for <cocci@archiver.kernel.org>; Tue, 28 Apr 2020 17:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LEXHR4pa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB1AF205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03SH3gdL024417;
	Tue, 28 Apr 2020 19:03:42 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 294497807;
	Tue, 28 Apr 2020 19:03:42 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id CAF843DC8
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 19:03:40 +0200 (CEST)
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:643])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03SH3d5U027091
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 19:03:40 +0200 (CEST)
Received: by mail-pl1-x643.google.com with SMTP id d24so8623160pll.8
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 10:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=g8ObZEU8oQgITaiHCYVY8TZYA9FdrqRe/dufNnhXR+s=;
 b=LEXHR4paTAfENXSm1fPyuMh2Y9HGrBp0yzn6UhF/cZwHQSEn2767OVRIDBqfmZFzGa
 gGaddEzo9mssxwBshNmwkOO+4YCjQ7FXRijzELpep3CkGsDEc8wNb0fws7fhQcrc9+8M
 cSK+cO4S3gjGhN3nMw8vGVUdLMk/R37pDWFu9m3pY+Bys8pwwYegl6Gu4FeUlJmVRkY5
 d5LHsUrVaNSu2v1/vaK9T9GiYF1i+wK6WZd3Ik9rJnpkfHJVpSlgT6W4ncEb+oZunRUR
 +Zd6H6//If0OzRhKQEPRicHgt5Z9rOVqCtjTU9/mXQXrPS8Dp9KYgMukS7Nb3jVviSP1
 jUEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=g8ObZEU8oQgITaiHCYVY8TZYA9FdrqRe/dufNnhXR+s=;
 b=WaM++l0nVoHIf733jkGFioorgIgWqCTrfFV9OoEVYdYaoqoZopWbgbbBAUtTfDWbK2
 nr9FRZtMXULRlXnAPYthDbIhS4v5nOtutFuu3pjP7lp4qwTaB/Zzyf1aFvQMemsMmh22
 xtU/LG6Ehr2uMtmYUs+OPFVizBnaROcWGKJjMs4OOIBhHPsn9HD1eI1AWO9uJsnVqAkN
 7Kz3Js4o31WeqHHWf8/mu2dl6BjOK2yOP98lvyzE1x5N5GYKsuXO7fp8tkzy68SHq8Yz
 AhU6+8iq10RqqvHQya4bbcU1cEtbvJILNks+zPEhEKd04Lw5tPHxlJ6ptyS2K+Ulr3W1
 QS5A==
X-Gm-Message-State: AGi0PuZeA63ccz5CoOHCZbWar2pGzt9yB39x4oDITdjMyvVgp429NrPJ
 x3LIJZUM/81q2vQUlJ1uZxDO4LADbf0=
X-Google-Smtp-Source: APiQypL0m7kGPLHbxYE2D4ptgxLVbXDupMFYZfKFe91ctu+0dqB7nMuTAdlLBHrybKoE0/7Hj1K+Sw==
X-Received: by 2002:a17:90a:734b:: with SMTP id
 j11mr6205428pjs.108.1588093418264; 
 Tue, 28 Apr 2020 10:03:38 -0700 (PDT)
Received: from localhost.localdomain ([1.38.220.163])
 by smtp.gmail.com with ESMTPSA id u15sm2505097pjm.47.2020.04.28.10.03.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2020 10:03:37 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Tue, 28 Apr 2020 22:32:10 +0530
Message-Id: <20200428170228.7002-15-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200428170228.7002-1-jaskaransingh7654321@gmail.com>
References: <20200428170228.7002-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 28 Apr 2020 19:03:42 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Tue, 28 Apr 2020 19:03:40 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 14/32] parsing_cocci: ast_cocci: Add cast attributes
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

Add cast attributes to the SmPL AST. This is a list of attributes in the
Cast type of the SmPL AST.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/ast_cocci.ml  | 4 ++--
 parsing_cocci/ast_cocci.mli | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/parsing_cocci/ast_cocci.ml b/parsing_cocci/ast_cocci.ml
index 9b147e5c..b0190fa1 100644
--- a/parsing_cocci/ast_cocci.ml
+++ b/parsing_cocci/ast_cocci.ml
@@ -194,8 +194,8 @@ and base_expression =
 	              string mcode (* ] *)
   | RecordAccess   of expression * string mcode (* . *) * ident
   | RecordPtAccess of expression * string mcode (* -> *) * ident
-  | Cast           of string mcode (* ( *) * fullType * string mcode (* ) *) *
-                      expression
+  | Cast           of string mcode (* ( *) * fullType * attr list *
+                      string mcode (* ) *) * expression
   | SizeOfExpr     of string mcode (* sizeof *) * expression
   | SizeOfType     of string mcode (* sizeof *) * string mcode (* ( *) *
                       fullType * string mcode (* ) *)
diff --git a/parsing_cocci/ast_cocci.mli b/parsing_cocci/ast_cocci.mli
index c56bba88..ff81692c 100644
--- a/parsing_cocci/ast_cocci.mli
+++ b/parsing_cocci/ast_cocci.mli
@@ -178,8 +178,8 @@ and base_expression =
 	              string mcode (* ] *)
   | RecordAccess   of expression * string mcode (* . *) * ident
   | RecordPtAccess of expression * string mcode (* -> *) * ident
-  | Cast           of string mcode (* ( *) * fullType * string mcode (* ) *) *
-                      expression
+  | Cast           of string mcode (* ( *) * fullType * attr list *
+                      string mcode (* ) *) * expression
 
   | SizeOfExpr     of string mcode (* sizeof *) * expression
   | SizeOfType     of string mcode (* sizeof *) * string mcode (* ( *) *
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
