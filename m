Return-Path: <SRS0=Yx51=7L=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30B1C433DF
	for <cocci@archiver.kernel.org>; Fri, 29 May 2020 12:10:42 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BA642077D
	for <cocci@archiver.kernel.org>; Fri, 29 May 2020 12:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3orgzLh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BA642077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04TCAdCU023274;
	Fri, 29 May 2020 14:10:39 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B8BDA7783;
	Fri, 29 May 2020 14:10:39 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 5B5895D47
 for <cocci@systeme.lip6.fr>; Fri, 29 May 2020 14:10:38 +0200 (CEST)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:52b])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04TCAafC026818
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 29 May 2020 14:10:37 +0200 (CEST)
Received: by mail-pg1-x52b.google.com with SMTP id u5so1417929pgn.5
 for <cocci@systeme.lip6.fr>; Fri, 29 May 2020 05:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ji5NtgAzooxdhdMeMZ3zeDyqNKeDtDsiR9XjjkqT74Q=;
 b=T3orgzLhrBsQr18/NgTgO8qw1cJXruGXUjlPnR3bsJI69r4csWtyQZR8292HrlmOpA
 1ErLVJWqBWKlWaE4j7UTClf2eu6wJgQ5eH4Isemj8o3DET9yCEhl5YDNaIJSA5hdIH/S
 DKbOzVdJj3jRqa4AVeIZLWacy1zZv9GOYm0jPyP5e8v2zpXwaQ2Pobx6YlT/Ys+7oPf7
 hDaZpZDHMx6r09IYG2EtLUcOgDD4TYodUtdq0NPTRMZt+A0dWvw19zNgOV0mfFbM4WyO
 wX8qYD0TkGZ+QzODLjouwBcW3YTVzR1W53yKq16K2481YBFejJ4V49dWuwq2FsckrIX9
 wuAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ji5NtgAzooxdhdMeMZ3zeDyqNKeDtDsiR9XjjkqT74Q=;
 b=r3icQpiHdkoHeqJOXZNObH0hBkioi8jYi+Yn9iYD/8p+xp4Y1fhGhYvgjWpU3cM7Kc
 I5aeDSI3lP9kqtbn2IYPyq6mT/+JC8prNWruGnKLJrfSPRB/ijgylV0S8sKIrmY0hJAV
 WoNP1WB3Onz3hWED4DT+VU9anSUAxoYFzcba6/Ktaer2cNElMOmcHR6wbVZs/GViyzgp
 +vpPoKnbiXyqBQIjFt3dGvBIU4ajd27yIVw85R6Cwm+JxGMKJgbWdPgDvdyG7ZOmfF9u
 xvlYczMxluzHyrFAj83FRh0hf8I2i+ROatDSrXyz5F3B4tTLyd/0WGoJBrWFXIC/1EuD
 V5tA==
X-Gm-Message-State: AOAM5324rR4uKURvFgg1QGDQyukXewpemPFDydiokFX8DJmlAdFQfqfS
 BfcixUXk3mR4oRCT+ICbtsAr3iRN
X-Google-Smtp-Source: ABdhPJxKFE+w4BBziy90FFuDaUvyNolgko7x+lcEHfp9HSA7z/VnyO207GxHKFpsSYrvhKx3+1P48w==
X-Received: by 2002:aa7:9466:: with SMTP id t6mr8562459pfq.299.1590754235888; 
 Fri, 29 May 2020 05:10:35 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:694:e576:19d1:a79b:707d:59f2])
 by smtp.gmail.com with ESMTPSA id dw13sm7975161pjb.40.2020.05.29.05.10.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2020 05:10:35 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri, 29 May 2020 17:37:02 +0530
Message-Id: <20200529120703.31145-33-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200529120703.31145-1-jaskaransingh7654321@gmail.com>
References: <20200529120703.31145-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 29 May 2020 14:10:39 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 29 May 2020 14:10:37 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v3 32/32] tests: Add test case to detect cast
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

Add a test case to detect a cast attribute. The following cases are
covered for when a attribute is:

- Before the cast type.
- After the cast type.
- After the cast type and before the *.
- After the cast type and *.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 tests/detect_cast_attr.c     | 10 ++++++++++
 tests/detect_cast_attr.cocci | 11 +++++++++++
 tests/detect_cast_attr.res   | 10 ++++++++++
 3 files changed, 31 insertions(+)
 create mode 100644 tests/detect_cast_attr.c
 create mode 100644 tests/detect_cast_attr.cocci
 create mode 100644 tests/detect_cast_attr.res

diff --git a/tests/detect_cast_attr.c b/tests/detect_cast_attr.c
new file mode 100644
index 00000000..2458ef05
--- /dev/null
+++ b/tests/detect_cast_attr.c
@@ -0,0 +1,10 @@
+#define __cast_attr MACROANNOTATION
+
+int func()
+{
+	char *a = (int __cast_attr) x;
+	char *a = (__cast_attr int) x;
+	char *a = (int __cast_attr *) x;
+	char *a = (int *__cast_attr) x;
+	char *a = (int) x;
+}
diff --git a/tests/detect_cast_attr.cocci b/tests/detect_cast_attr.cocci
new file mode 100644
index 00000000..d626048f
--- /dev/null
+++ b/tests/detect_cast_attr.cocci
@@ -0,0 +1,11 @@
+@r0@
+type T;
+attribute name __cast_attr;
+identifier x;
+@@
+
+  (
+-	T
++	char *
+ 	__cast_attr
+  ) x
diff --git a/tests/detect_cast_attr.res b/tests/detect_cast_attr.res
new file mode 100644
index 00000000..2a273316
--- /dev/null
+++ b/tests/detect_cast_attr.res
@@ -0,0 +1,10 @@
+#define __cast_attr MACROANNOTATION
+
+int func()
+{
+	char *a = (char *__cast_attr) x;
+	char *a = (__cast_attr char *) x;
+	char *a = (char *__cast_attr) x;
+	char *a = (char *__cast_attr) x;
+	char *a = (int) x;
+}
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
