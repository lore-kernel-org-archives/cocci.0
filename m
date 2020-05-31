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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5DFC433DF
	for <cocci@archiver.kernel.org>; Sun, 31 May 2020 15:28:36 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F04F206DA
	for <cocci@archiver.kernel.org>; Sun, 31 May 2020 15:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uA1Opabl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F04F206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04VFSXhV029714;
	Sun, 31 May 2020 17:28:33 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A6CEA7752;
	Sun, 31 May 2020 17:28:33 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 674DF3C89
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 17:28:32 +0200 (CEST)
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:544])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04VFSU5u029011
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 17:28:31 +0200 (CEST)
Received: by mail-pg1-x544.google.com with SMTP id 185so2323840pgb.10
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 08:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1usUHRjT30UJ7SGo5+Abt4NssA1f9Eq27niEio+p3AQ=;
 b=uA1OpablRL1qDQ+32IjoVM1EqWFExrRT61D7NkaC7Yxt4Mcw7tsBN+XjcoxPqeM85R
 UfG7vkKEbhBVIVoI8DKXaPXkezq7RnkW3eWmGWzIxzuUQLtZZL305GFW5UvvdYJwmCDm
 IJv4BA3VKjqdLbQG7GjACk0hJnKLh/1R4s5yucfRTJwL/m62Vqr3BR8KsHgv460tgAC8
 5R6s/yv5EEUW+ehfuJ9RkkKZ54EPfoftwJLWo1Iy9sx9SRU4feQ/kfs6aLqMgpU5hUFg
 OqepqYy4W7lK+avZpkFg/+7NqHitBTLfK4k61D/bOnPOub1yMzwaolynikAvkupqZ4PE
 e5uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1usUHRjT30UJ7SGo5+Abt4NssA1f9Eq27niEio+p3AQ=;
 b=Svv+FIB2iqaYu4/1vdsSHUaYMNCSWkmgQpTzfiVeYaQavCmpkndcF239vqQtkZvc6g
 Smgqr/4H6FUtwds4EJn9BFJY4vzJV00k/BsfsTxnqpuXh4AfbUSDfqlMjft7HdCx3ahW
 KY8yzTasyBN/my2rJWIICRbThxLcfMJTdaMwGSL84Ai1RpBD0X+47mNswBSgtiauXWQG
 MMbsF117TLkjxYsamzItmZnA5amJt5sifxPLG4nKO8UWvelU1wLqdIndAK/LHbS9/vqb
 8riKoabYyrYJQa6BNDO6v9eM2N5vOXSroDNZ6ajm4QTcdGDu02I+7orB8spzHyrMJA6J
 oIYQ==
X-Gm-Message-State: AOAM530sLkI0Dn9X0kwbPFZHbgeJsXJ709lWaHTjjI1buAYozeU7WWf8
 CCpyqgsMOBeUoCuPULcat+kxweAA
X-Google-Smtp-Source: ABdhPJwViq0wDbk5rN3CW1tNbSkyICnLOyyguALodN7GLC3VEJOomwAzmrIF6P/Jz53N6LNqBVC6ig==
X-Received: by 2002:a63:f854:: with SMTP id v20mr16298897pgj.0.1590938910026; 
 Sun, 31 May 2020 08:28:30 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:1863:fef5:a170:128b:8ef:499d])
 by smtp.gmail.com with ESMTPSA id 131sm12310443pfv.139.2020.05.31.08.28.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2020 08:28:29 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sun, 31 May 2020 20:56:21 +0530
Message-Id: <20200531152621.2886-28-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200531152621.2886-1-jaskaransingh7654321@gmail.com>
References: <20200531152621.2886-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 31 May 2020 17:28:33 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 31 May 2020 17:28:32 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 27/27] tests: Add test case to check struct endattr
	allminus
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

Struct end attributes are added to the SmPL and C ASTs. Add a test case
to check allminus for struct end attributes.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 tests/remove_struct_endattr_allminus.c     | 13 +++++++++++++
 tests/remove_struct_endattr_allminus.cocci |  6 ++++++
 tests/remove_struct_endattr_allminus.res   |  1 +
 3 files changed, 20 insertions(+)
 create mode 100644 tests/remove_struct_endattr_allminus.c
 create mode 100644 tests/remove_struct_endattr_allminus.cocci
 create mode 100644 tests/remove_struct_endattr_allminus.res

diff --git a/tests/remove_struct_endattr_allminus.c b/tests/remove_struct_endattr_allminus.c
new file mode 100644
index 00000000..a99a7e9f
--- /dev/null
+++ b/tests/remove_struct_endattr_allminus.c
@@ -0,0 +1,13 @@
+#define __struct_endattr MACROANNOTATION
+
+struct abcd {
+	int a;
+	int b;
+	int c;
+} __struct_endattr;
+
+struct defg {
+	int a;
+	int b;
+	int c;
+};
diff --git a/tests/remove_struct_endattr_allminus.cocci b/tests/remove_struct_endattr_allminus.cocci
new file mode 100644
index 00000000..f63ab7cd
--- /dev/null
+++ b/tests/remove_struct_endattr_allminus.cocci
@@ -0,0 +1,6 @@
+@@
+identifier id;
+attribute name __struct_endattr;
+@@
+
+- struct id {...};
diff --git a/tests/remove_struct_endattr_allminus.res b/tests/remove_struct_endattr_allminus.res
new file mode 100644
index 00000000..e2f74e8f
--- /dev/null
+++ b/tests/remove_struct_endattr_allminus.res
@@ -0,0 +1 @@
+#define __struct_endattr MACROANNOTATION
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
