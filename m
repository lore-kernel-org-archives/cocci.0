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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5EAC47255
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:15:04 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A64B82075E
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gf+atby7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A64B82075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04BAEjbv029581;
	Mon, 11 May 2020 12:14:45 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D2A613E6B;
	Mon, 11 May 2020 12:14:45 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 2B10C3DC8
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:14:44 +0200 (CEST)
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:642])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04BAEgJc009090
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:14:43 +0200 (CEST)
Received: by mail-pl1-x642.google.com with SMTP id m7so3746848plt.5
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 03:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oiiyaaxVdFQ8E5eoYpxjpSkj51vxoyU7jiIbcmsszCg=;
 b=Gf+atby7kK3HnKx5+z65F5uyILaVJg7DhmduYBGEwx1U9RfKgZ0SwLCqv5ggykmIwc
 llWwL/KVZcCwyu7qHw1snXCscnp1WafN+ts1rl6cLliptorGJK++6YEpShUPoao06P7u
 M3LkvWjYadCgt4MjmX7gyaT0txPkLAhf39dCfXDV5YAHjmlCBABMlZRIxK+vr65eHR0q
 shYaSSgXppN+cz32NtmHxps42ld35Z4BOnN4EAAjBTvIcnK8vU1Fnjk+lcM74I7CKyk+
 VDDgalM17phC0AmWqH3N4q4ZACqsC63WteCSIUMvbLc00xbpGhRQSCkEJwJrH35aAd93
 WgjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oiiyaaxVdFQ8E5eoYpxjpSkj51vxoyU7jiIbcmsszCg=;
 b=E+8iH9I4TmArMTFpx4Inik5Vb/Qyt7QjtRD3RpBCR7fgJIy7vlsXdhzLZYKwysKJvW
 gjitT2TbGnAHZxAjHViWtnqzhLC/hC2NfKLKIF44qLPO1e2PQ2ls5cBf2qhR2lP8gAj5
 RR+z9Yw3EwHwCSCmX/hixjVvGO4YayzDi7Td6CrQTqsqMmAq9FxtZIhFQUFA5b42rTZE
 LBUMfwEM1WnXSRKZ7SbYGn2qR7P+HxURguQxYq589hCZnUNQyR8YKfs6KlqfdXX2W6yS
 O3hl2Gwh85DzwL93GtOscc/ZRSXoRnDX0HjCZoVYmQQvOVOUUvNLY/LXFC59fCOGK0DJ
 a8og==
X-Gm-Message-State: AGi0Puaal1V4u9K6priKB/KT+gT8mSx4x1gc2oWIyliNqcieUV6VWX80
 a11SULLoq7ZW52WCiyzxSebvyEXtpnA=
X-Google-Smtp-Source: APiQypJcul5aGu4ZUBIMjkLKpKd+vMpdGKNVuu624rYIRqdOPFoTqAZPFAqwdNq2eh5VNgsfK4wHHw==
X-Received: by 2002:a17:90a:718c:: with SMTP id
 i12mr21796289pjk.58.1589192081735; 
 Mon, 11 May 2020 03:14:41 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:382:66db:4729:1ab8:2139:8945])
 by smtp.gmail.com with ESMTPSA id
 j14sm10021121pjm.27.2020.05.11.03.14.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 03:14:41 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 11 May 2020 15:42:59 +0530
Message-Id: <20200511101300.11101-23-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200511101300.11101-1-jaskaransingh7654321@gmail.com>
References: <20200511101300.11101-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 11 May 2020 12:14:45 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 11 May 2020 12:14:43 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v3 22/23] tests: Add test case for removing
	parameter attributes
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

Add a test case for removing Parameter attributes. The test case checks
correct removal of the attribute when it is:

- before the parameter type.
- after the parameter type and before the parameter identifier.
- after the parameter identifier.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 tests/remove_param_attrs.c     | 11 +++++++++++
 tests/remove_param_attrs.cocci | 13 +++++++++++++
 tests/remove_param_attrs.res   | 11 +++++++++++
 3 files changed, 35 insertions(+)
 create mode 100644 tests/remove_param_attrs.c
 create mode 100644 tests/remove_param_attrs.cocci
 create mode 100644 tests/remove_param_attrs.res

diff --git a/tests/remove_param_attrs.c b/tests/remove_param_attrs.c
new file mode 100644
index 00000000..8ec1ffde
--- /dev/null
+++ b/tests/remove_param_attrs.c
@@ -0,0 +1,11 @@
+int func1(int x, __nocast int y) {
+	return 0;
+}
+
+int func2(int x, int __nocast y) {
+	return 0;
+}
+
+int func3(int x, int y __nocast) {
+	return 0;
+}
diff --git a/tests/remove_param_attrs.cocci b/tests/remove_param_attrs.cocci
new file mode 100644
index 00000000..43f5a204
--- /dev/null
+++ b/tests/remove_param_attrs.cocci
@@ -0,0 +1,13 @@
+@@
+type T,U;
+attribute name __nocast;
+identifier x,y;
+@@
+
+T x(
+    ...,
+    U y
+-	__nocast
+    ,
+    ...
+  ) {...}
diff --git a/tests/remove_param_attrs.res b/tests/remove_param_attrs.res
new file mode 100644
index 00000000..3705e814
--- /dev/null
+++ b/tests/remove_param_attrs.res
@@ -0,0 +1,11 @@
+int func1(int x, int y) {
+	return 0;
+}
+
+int func2(int x, int y) {
+	return 0;
+}
+
+int func3(int x, int y) {
+	return 0;
+}
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
