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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16AF1C47255
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:15:07 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9C87207DD
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GoTenM56"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9C87207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04BAEndB024940;
	Mon, 11 May 2020 12:14:49 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 340C13E6B;
	Mon, 11 May 2020 12:14:49 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B4C603DC8
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:14:47 +0200 (CEST)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:62e])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04BAEkY7018202
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:14:47 +0200 (CEST)
Received: by mail-pl1-x62e.google.com with SMTP id x10so3746080plr.4
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 03:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=teePH2Ulat8wodcKd5cQjWVTcK7pUQ3XouFRKvY7zBg=;
 b=GoTenM5697ZnDs74wlK89k1TnX1ADHjDvlW3XdLBQbdTwmzgUWttoJ9B24Zwi8i2qx
 OWfuN23RdxMZbMsCo3IHfjKdtRKRUfjN6QksZbkwwBGnzuiuWmeXhajflUgyrFHxjj4P
 OPGqq30oNzqw5/Ybuu0UbZ1845lHl49YAfVSGDVlwM6bvEt1dkVc49WQ9DjOa+D4Yhg6
 wyjRzLu4jrCuV1H/EI58kJHZUh5eCpwZ69JJqwxIk7HLaurTNZUZ3+AWeZ0kWuGfkvom
 5AjowPlHmDRTO/4kEzwW1ygcF8TEhZjrKcPYHxlEINHvGpLiquSRjD4YTbdrOB5uTrQY
 Z7dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=teePH2Ulat8wodcKd5cQjWVTcK7pUQ3XouFRKvY7zBg=;
 b=fhYeqfVxEo7c/9xJ5/RiqejVUc3Ra6D6nTL4zJXfl1hI3No5+ilSFUtcgyLvOBguB4
 Hl7cBJgsvxmwO2GxZO12wYiLrZJVLeRqmndi2IEMYuvMMTRHHiZ14m33vnDI4r1MkSuY
 nkUgyNHfw5WTixcLYx4ti/FjoJjaQaWGlMomIxc+4zKTKi2T/LuZwVlZb4heWMb55gf0
 JqDFm3pDH84Ysf8yoNTjcMPu9Rvl/dMYUkPcNINOKGildtOqc20RALak0yay0q4JM9rk
 HGFsSk9Ny8xAHnBRDDO1/HjXJZdvIdJFXFvl5P59u7Wg1QedAhxU6R76DFSCkPsts4Yk
 tZdQ==
X-Gm-Message-State: AGi0PubX0EdMaLU5LoR1cFYzY66y0w3P92V3miTgsgnlEfCYXogcKnHr
 C66inKntogL9bPjvZqV6+KklqngfV04=
X-Google-Smtp-Source: APiQypKf5mo4ixZTBH4n8qhFX+5NZdpNjTdpgFqwckBo/YPOpy/rstxypbti1GZqqy72NFPs28M/sA==
X-Received: by 2002:a17:90a:32e3:: with SMTP id
 l90mr20849005pjb.214.1589192085433; 
 Mon, 11 May 2020 03:14:45 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:382:66db:4729:1ab8:2139:8945])
 by smtp.gmail.com with ESMTPSA id
 j14sm10021121pjm.27.2020.05.11.03.14.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 03:14:45 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 11 May 2020 15:43:00 +0530
Message-Id: <20200511101300.11101-24-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200511101300.11101-1-jaskaransingh7654321@gmail.com>
References: <20200511101300.11101-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 11 May 2020 12:14:49 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 11 May 2020 12:14:47 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v3 23/23] tests: Add test case to detect parameter
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

Add a test case to detect parameter attributes in C. The test case
changes the type of the parameter if it has the attribute. The cases
covered are for when the attribute is:

- before the parameter type.
- after the parameter type and before the parameter identifier.
- after the parameter identifier.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 tests/detect_param_attr.c     |  3 +++
 tests/detect_param_attr.cocci | 13 +++++++++++++
 tests/detect_param_attr.res   |  3 +++
 3 files changed, 19 insertions(+)
 create mode 100644 tests/detect_param_attr.c
 create mode 100644 tests/detect_param_attr.cocci
 create mode 100644 tests/detect_param_attr.res

diff --git a/tests/detect_param_attr.c b/tests/detect_param_attr.c
new file mode 100644
index 00000000..160d6af2
--- /dev/null
+++ b/tests/detect_param_attr.c
@@ -0,0 +1,3 @@
+int func1(int __nocast u, __nocast int z, int q __nocast, int w) {
+	return 0;
+}
diff --git a/tests/detect_param_attr.cocci b/tests/detect_param_attr.cocci
new file mode 100644
index 00000000..53b8668f
--- /dev/null
+++ b/tests/detect_param_attr.cocci
@@ -0,0 +1,13 @@
+@@
+type T1, T2;
+attribute name __nocast;
+identifier x, y;
+@@
+
+T1 x(
+	...,
+-	T2
++	char
+	y __nocast,
+	...
+   ) {...}
diff --git a/tests/detect_param_attr.res b/tests/detect_param_attr.res
new file mode 100644
index 00000000..b3db290e
--- /dev/null
+++ b/tests/detect_param_attr.res
@@ -0,0 +1,3 @@
+int func1(char __nocast u, __nocast char z, char q __nocast, int w) {
+	return 0;
+}
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
