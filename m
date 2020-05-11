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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7794BC54E8D
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:09:57 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E559C20720
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lntl4s2C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E559C20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04BA9jh8029341;
	Mon, 11 May 2020 12:09:45 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A87A13E6B;
	Mon, 11 May 2020 12:09:45 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 835E83DC8
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:09:43 +0200 (CEST)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:429])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04BA9fud023944
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:09:42 +0200 (CEST)
Received: by mail-pf1-x429.google.com with SMTP id w65so4519057pfc.12
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 03:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yNcRDX9hmzicpYrIzSR1d5L189a5/jLnt2HECCkQKP0=;
 b=lntl4s2CDHie7lnxp/l+nPSEFmhCXANsCn5Lo6rNkpHECO8WHeqbs7E4+cPy/9YuTv
 rDKtkWEbDbEu6ljgHIlbQLQwB0ZLVVwckGuW8UQskQbHCCM0QaZSkYifYSjon136ZeoC
 P1rVxUzmBLVIeLfrddvbjtBIdvkL2m4yC2QTlRL1xFxWn/29pIbiwUwc9FCqp+GhNQwj
 T3SsLuOT+qYJvFQezVqgEfND04csIqGqIQDOOOgGAO+pMHkjNBzBvEQWxcmax7qWMGew
 NNtA7kpVkoCGH/MKccOGFRqN3l/YEgKsKbGlXyt+6V40A2opdMf7iQ9e2w73J5X1qw/o
 Vu/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yNcRDX9hmzicpYrIzSR1d5L189a5/jLnt2HECCkQKP0=;
 b=TpS+c8MhLSPLQa28VAtXys4I8kPJgHmueq7AtFx/NMiTv9ngRuYfdKFebXtTdWZfxw
 0syny/58IbBW9FroCB5v2x71m8BfVPLcYXlKhYgZ980SH4RKacdMf8YSJJuVJk3xG5A8
 lAH5VZAK10Ce1pYLcvMiVIzVdqkN4vG916YmVYOph7toSnbwba5d+VcufUr3sVrahuzo
 ZZRCtOfzcpVQmq7y6SxlgYsaK77oxAhY+eciO967ZpMS1++1RgQo0Ka3d4u/Arykiz3T
 m8NtQf8TolhSwcC3BbeDsrYzp44C5wYcVVTFe4QsAew6Y4V08wNBBt4gH35yuaGEjs3f
 1CdA==
X-Gm-Message-State: AGi0PuaVD7yRZIMgxBxIvpowXYPALcwhHgae9cgpm7Jh1XHhHqvbUzjx
 mF5BrcvGGU4PwXusWmhTT2fNMrMvQ64=
X-Google-Smtp-Source: APiQypL5XGgTAA+kvZjmuf+gSS7294obD7rRnP9loUThyoxrejIlhEypgkyQht2dm+Pi3zYDLOJDMQ==
X-Received: by 2002:aa7:8bdc:: with SMTP id s28mr15227599pfd.57.1589191781164; 
 Mon, 11 May 2020 03:09:41 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:382:66db:4729:1ab8:2139:8945])
 by smtp.gmail.com with ESMTPSA id
 o99sm9772994pjo.8.2020.05.11.03.09.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 03:09:40 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 11 May 2020 15:37:14 +0530
Message-Id: <20200511100715.19819-32-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200511100715.19819-1-jaskaransingh7654321@gmail.com>
References: <20200511100715.19819-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 11 May 2020 12:09:45 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 11 May 2020 12:09:43 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v2 31/32] tests: Add test case to remove cast
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

Add a test case to remove a cast attribute. The following cases are
covered for when a attribute is:

- Before the cast type.
- After the cast type.
- After the cast type and before the *.
- After the cast type and *.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 tests/remove_cast_attr.c     | 10 ++++++++++
 tests/remove_cast_attr.cocci | 10 ++++++++++
 tests/remove_cast_attr.res   | 10 ++++++++++
 3 files changed, 30 insertions(+)
 create mode 100644 tests/remove_cast_attr.c
 create mode 100644 tests/remove_cast_attr.cocci
 create mode 100644 tests/remove_cast_attr.res

diff --git a/tests/remove_cast_attr.c b/tests/remove_cast_attr.c
new file mode 100644
index 00000000..4f6da3e4
--- /dev/null
+++ b/tests/remove_cast_attr.c
@@ -0,0 +1,10 @@
+#define __cast_attr MACROANNOTATION
+
+int func()
+{
+	int *a = (int __cast_attr) x;
+	int *a = (__cast_attr int) x;
+	int *a = (int __cast_attr *) x;
+	int *a = (int *__cast_attr) x;
+	int *a = (int) x;
+}
diff --git a/tests/remove_cast_attr.cocci b/tests/remove_cast_attr.cocci
new file mode 100644
index 00000000..f171d44d
--- /dev/null
+++ b/tests/remove_cast_attr.cocci
@@ -0,0 +1,10 @@
+@r0@
+type T;
+attribute name __cast_attr;
+identifier x;
+@@
+
+  (
+	T
+-	__cast_attr
+  ) x
diff --git a/tests/remove_cast_attr.res b/tests/remove_cast_attr.res
new file mode 100644
index 00000000..fb5001b9
--- /dev/null
+++ b/tests/remove_cast_attr.res
@@ -0,0 +1,10 @@
+#define __cast_attr MACROANNOTATION
+
+int func()
+{
+	int *a = (int) x;
+	int *a = (int) x;
+	int *a = (int *) x;
+	int *a = (int *) x;
+	int *a = (int) x;
+}
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
