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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19EFCC54E8D
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:09:11 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 835DE20720
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+khDt8D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 835DE20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04BA8xZi006749;
	Mon, 11 May 2020 12:08:59 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 503483E6B;
	Mon, 11 May 2020 12:08:59 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id BC0963DC8
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:08:57 +0200 (CEST)
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:544])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04BA8umH016310
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:08:57 +0200 (CEST)
Received: by mail-pg1-x544.google.com with SMTP id u35so1363606pgk.6
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 03:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Kok0aW8gFlHjW7PHm/cxJ/jED6PTY9Z2/hiZotJQf4M=;
 b=S+khDt8DYlDuIFfayyfTpjvqWS5Jbj7ViwFzp/recHrW1KlSHznA99J71VZj04HvJb
 sg2pbK1Szk/ZUFMDL0PmxIB0klMjcU25jokx3pOHYd4+HHjESxGxL4okpP9Yru1A5ox7
 +Y7uWfec8Mhu0bJE0/ZgGFXpqkY588w70vSD23h+Lb4ECFZH9PUWbgpJXxG986x762Td
 qHu9D6Q2MCt6BauKD6XIbqrMQsrJa5YoBSx5WlSDe/ZFC3K8vBf+rf1+EZ2cHf0wKppz
 3hLQjXQ05zJdg65g6te+akJJXFkc6LiCF+L3aIC9Su+liqmt6geZQHqUeMhEOMK26zzb
 zXoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Kok0aW8gFlHjW7PHm/cxJ/jED6PTY9Z2/hiZotJQf4M=;
 b=C38h6EqPtqj/UfTlO5+l+zME97Bnm/XcuPyCSNN/0PAvRhqQnqnXToRbd6UZp+SReA
 g3ecZxHpsVDYujeJuOHcnYXl+rTrF6MR7OoCurlmGqy4WYUiLG22s6IDVM5OeqTHq6hx
 cbhAltZUBafIpCrT5PP+0BlyrQombV7T80XcZt6b8whqRvqRE8i/jzL/8i47D9LmDFK+
 ADSOJmBhhT5QNk8Pdgt3dhp5Q3iyDT1jsmlCiNV7uoqYoqI1EaKJg5ciESqWj8CluteY
 WOrYmIDE8YQhsR4fQ9Xdz+DUtU+EyaZ5CaIxS5pAJqJUfsJLMMu4lhgRhegFC9+CVzVX
 jreA==
X-Gm-Message-State: AGi0PubkY69DlhgKjyRFXOBgsghBtOuQDZB3a886NuUvyo04ctcYYNA8
 COkIlhdpGdGXrgRZLARQ3GgSOEJL30o=
X-Google-Smtp-Source: APiQypIr/DgoLnFkOBSEcd5V1O70aMrR8XkdBwchTYJTCHDAZGiMgSVQf/BFQpdA2X3CHCDG3E8JIA==
X-Received: by 2002:a63:e74f:: with SMTP id j15mr14189947pgk.153.1589191735420; 
 Mon, 11 May 2020 03:08:55 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:382:66db:4729:1ab8:2139:8945])
 by smtp.gmail.com with ESMTPSA id
 o99sm9772994pjo.8.2020.05.11.03.08.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 03:08:55 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 11 May 2020 15:37:03 +0530
Message-Id: <20200511100715.19819-21-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200511100715.19819-1-jaskaransingh7654321@gmail.com>
References: <20200511100715.19819-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 11 May 2020 12:08:59 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 11 May 2020 12:08:57 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v2 20/32] parsing_c: ast_c: Add Cast attributes
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
Cast type of the C AST.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_c/ast_c.ml  | 2 +-
 parsing_c/ast_c.mli | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/parsing_c/ast_c.ml b/parsing_c/ast_c.ml
index f25f9b55..1299d03c 100644
--- a/parsing_c/ast_c.ml
+++ b/parsing_c/ast_c.ml
@@ -343,7 +343,7 @@ and expression = (expressionbis * exp_info ref (* semantic: *)) wrap3
 
   | SizeOfExpr     of expression
   | SizeOfType     of fullType
-  | Cast           of fullType * expression
+  | Cast           of fullType * attribute list * expression
 
   (* gccext: *)
   | StatementExpr of compound wrap (* ( )     new scope *)
diff --git a/parsing_c/ast_c.mli b/parsing_c/ast_c.mli
index 8923a335..90dee9fd 100644
--- a/parsing_c/ast_c.mli
+++ b/parsing_c/ast_c.mli
@@ -104,7 +104,7 @@ and expressionbis =
   | RecordPtAccess of expression * name
   | SizeOfExpr of expression
   | SizeOfType of fullType
-  | Cast of fullType * expression
+  | Cast of fullType * attribute list * expression
   | StatementExpr of compound wrap
   | Constructor of fullType * initialiser
   | ParenExpr of expression
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
