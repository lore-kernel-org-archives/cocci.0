Return-Path: <SRS0=J+r8=6L=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050D9C7C8A0
	for <cocci@archiver.kernel.org>; Mon, 27 Apr 2020 12:10:31 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99C8E206BF
	for <cocci@archiver.kernel.org>; Mon, 27 Apr 2020 12:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H13Xvzjx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99C8E206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03RCAKed004256;
	Mon, 27 Apr 2020 14:10:20 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 159AA7807;
	Mon, 27 Apr 2020 14:10:20 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 250B07769
 for <cocci@systeme.lip6.fr>; Mon, 27 Apr 2020 14:10:18 +0200 (CEST)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:530])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03RCAG8s003362
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 27 Apr 2020 14:10:17 +0200 (CEST)
Received: by mail-pg1-x530.google.com with SMTP id l20so665679pgb.11
 for <cocci@systeme.lip6.fr>; Mon, 27 Apr 2020 05:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=teePH2Ulat8wodcKd5cQjWVTcK7pUQ3XouFRKvY7zBg=;
 b=H13XvzjxiNkhxoX5mU8inrjyrwZV9hwECAlnqxGScbk6AwhrPT99ngiaxdy8YbNEpD
 6+TydPz84CTWznNJVZ1IcpPCDetzzEJnLZjBSc8GgbGIdTTn1lm81AQeH7cemNa24Wfe
 VllrGLXZj8FMaKlZX27JtnJ7YlND+7KXyg1oJ4KPK8akidvLK+3mfC6UPjxf+h6SSAV7
 BxrH7HrvfG6IGGHq+Cb8CbHGNzirPzntTCgaA8AQMVPyMraqQLbazmE20c24Xx/fHEwP
 30wpCwkSgyuhtfjkUBVptJgKj1fcw6BjNvsG1laqpyTN2Sgu4FE0KwJ8li7AtHOa6MWE
 VHcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=teePH2Ulat8wodcKd5cQjWVTcK7pUQ3XouFRKvY7zBg=;
 b=AGck4BsuI85jQNtePsEzhWCNcsgPTMVXii2xhhxNbjR/Key47No3aFd2wU2sprzrdG
 HZ14RfkKwh8T3i/s71y2hM9VlHcEfOLuRhwDobH8WQZobdavqavnqkhE8kC+kjbLfkPn
 qGTOfUjOqH0j02KYwTMkHWmbAp78dyPG8ACJ5WPsOjOpFl39dN7TxiBMNmLDeGhRRFVn
 YGuge6s8dBIpdhoZ+dWcUzz19/fESSlJ5e2BeXIC2rbQkgcDbrfA4EjTYYK3zDBJXqj1
 dGD58JRmQbVPzhqv63SJXS3KTQ7Fbk3WI24V0Fofg8YB5D0dlcJHt2oUfdNQv7z+e8vU
 9UOg==
X-Gm-Message-State: AGi0PubH3g3pdAVnpq2AMjfBqx0KvDQZ+2aUA61lIZiQ5k0PFUfBS1jg
 sAfFBrBuh5/Z9OZCDpWegmHB1Hd85nQ=
X-Google-Smtp-Source: APiQypKdoufF4WA7J9k8W8z5+kTddfvSszq1KidT+4yMqFxfI/9DhtaiUuRk4Jy86/XUrLfkzOn/tQ==
X-Received: by 2002:a63:d804:: with SMTP id b4mr22294219pgh.127.1587989415725; 
 Mon, 27 Apr 2020 05:10:15 -0700 (PDT)
Received: from localhost.localdomain ([1.38.220.114])
 by smtp.gmail.com with ESMTPSA id r17sm9623885pgn.35.2020.04.27.05.10.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2020 05:10:15 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 27 Apr 2020 17:38:34 +0530
Message-Id: <20200427120834.380-24-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200427120834.380-1-jaskaransingh7654321@gmail.com>
References: <20200427120834.380-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 27 Apr 2020 14:10:20 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 27 Apr 2020 14:10:17 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 23/23] tests: Add test case to detect parameter
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
