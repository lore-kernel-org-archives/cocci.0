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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0D1C54E4B
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:09:59 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D92C20720
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sinY7xrH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D92C20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04BA9fBT027645;
	Mon, 11 May 2020 12:09:41 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 307E83E6B;
	Mon, 11 May 2020 12:09:41 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id C737D3DC8
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:09:39 +0200 (CEST)
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1044])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04BA9cS8012257
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:09:39 +0200 (CEST)
Received: by mail-pj1-x1044.google.com with SMTP id y6so7621428pjc.4
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 03:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=B+UOGyiCUJNuhbwqPHUKqo90Wxp/xQ4Ay09qO0K/Zhg=;
 b=sinY7xrH6Je1mDGR9HP/gomZ7GLUM9jHd71gi/7u6poptK8PYvU+YJ317xspe3ayWT
 uXAZJb8206jR0bIiJd6neWcY4nG346D412b7t0YWXSyZ3VkruF0TxhmPvUlB4JezdCni
 yVbFT7lJ7rm3J9H+cND8MxSHx/W4qpO6P7MJfHSoUsPizcR9t5AfoSV8lVr8rWcNpca+
 izUnYPdrZbhMaodWA37axexzr9MRAY7vpdkuG30yo50ikV7zUnjfBOBTyoppikpbF3AM
 nBibZnS/nZjX7Fh2Bnhnq8Rrr4/jhmO73WmpwTBOTEpLwoY+cdn5jbqJjTna41/vmZ2Q
 Uvnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=B+UOGyiCUJNuhbwqPHUKqo90Wxp/xQ4Ay09qO0K/Zhg=;
 b=EMPsLm55Y+tjo75nX6xN3T22MiUdnpKCBbHKVA6STzM15dWbaXLgqdRftseKqCWxF2
 AGccVjqjp3MZtsJ22V8uRa6t0r61wJjj5ewVmvJ0aaDpNNuOJS0iy3xnEexPpQ/yqn2k
 BfGNih9dyzUY3D6C3lthY9IHO4Wb6fVUCFBQ1ZplbaAJHaM2H5yvvUbqmXRGHVDFQ22y
 pdPwenOpi2hGOeD33YWPuXcNf4mdwCeNvF4+Y0kohFBFJ4iqc38ak2uUr21IycPbocBa
 ncS4OVFpI3KsXGxoQRu4WiwqwGFD/3XF9hHxAY/PRRMYZcBHq/K1ZCNyE53mig8vws4O
 YZqA==
X-Gm-Message-State: AGi0PuaCibOWrY6fqudDa0W2cw+3elenjUwjgyuSzQx88ENajLXBr/qJ
 x8NcZI0/EnqNahn8rQcqWomq++JmdOA=
X-Google-Smtp-Source: APiQypIp7jKfHuS9NuO+ZGcKWoawuB759Z1gk2csBX2FUzxfWmjQdSIyuOOY30lUs9380Y9nkleVGw==
X-Received: by 2002:a17:902:8545:: with SMTP id
 d5mr14478615plo.34.1589191777319; 
 Mon, 11 May 2020 03:09:37 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:382:66db:4729:1ab8:2139:8945])
 by smtp.gmail.com with ESMTPSA id
 o99sm9772994pjo.8.2020.05.11.03.09.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 03:09:36 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 11 May 2020 15:37:13 +0530
Message-Id: <20200511100715.19819-31-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200511100715.19819-1-jaskaransingh7654321@gmail.com>
References: <20200511100715.19819-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 11 May 2020 12:09:41 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 11 May 2020 12:09:39 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v2 30/32] tests: Add test case to check cast
	attribute allminus
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

Add a test case to check allminus for cast attributes. The test case
replaces all the cast types in the C program. Cases covered are for when
the attribute is:

- Before the cast type.
- After the cast type.
- After the cast type and before the *.
- After the cast type and *.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 tests/remove_cast_attr_allminus.c     | 10 ++++++++++
 tests/remove_cast_attr_allminus.cocci |  9 +++++++++
 tests/remove_cast_attr_allminus.res   | 10 ++++++++++
 3 files changed, 29 insertions(+)
 create mode 100644 tests/remove_cast_attr_allminus.c
 create mode 100644 tests/remove_cast_attr_allminus.cocci
 create mode 100644 tests/remove_cast_attr_allminus.res

diff --git a/tests/remove_cast_attr_allminus.c b/tests/remove_cast_attr_allminus.c
new file mode 100644
index 00000000..4f6da3e4
--- /dev/null
+++ b/tests/remove_cast_attr_allminus.c
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
diff --git a/tests/remove_cast_attr_allminus.cocci b/tests/remove_cast_attr_allminus.cocci
new file mode 100644
index 00000000..320fee93
--- /dev/null
+++ b/tests/remove_cast_attr_allminus.cocci
@@ -0,0 +1,9 @@
+@r0@
+type T;
+identifier x;
+@@
+
+  (
+-	T
++	int *
+  ) x
diff --git a/tests/remove_cast_attr_allminus.res b/tests/remove_cast_attr_allminus.res
new file mode 100644
index 00000000..befec630
--- /dev/null
+++ b/tests/remove_cast_attr_allminus.res
@@ -0,0 +1,10 @@
+#define __cast_attr MACROANNOTATION
+
+int func()
+{
+	int *a = (int *) x;
+	int *a = (int *) x;
+	int *a = (int *) x;
+	int *a = (int *) x;
+	int *a = (int *) x;
+}
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
