Return-Path: <SRS0=bJsz=6M=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44187C83001
	for <cocci@archiver.kernel.org>; Tue, 28 Apr 2020 17:06:15 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5D9A20730
	for <cocci@archiver.kernel.org>; Tue, 28 Apr 2020 17:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q4SZB4xe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5D9A20730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03SH64g1027951;
	Tue, 28 Apr 2020 19:06:04 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 54B3E7807;
	Tue, 28 Apr 2020 19:06:04 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 3D7E53DC8
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 19:06:02 +0200 (CEST)
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:544])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03SH60aC007990
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 19:06:01 +0200 (CEST)
Received: by mail-pg1-x544.google.com with SMTP id n16so10634303pgb.7
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 10:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=B+UOGyiCUJNuhbwqPHUKqo90Wxp/xQ4Ay09qO0K/Zhg=;
 b=q4SZB4xeVvKOBALjbc9vKge8j7+PUWUu0X54FAOpxommTSdnTUSFbs1dVFdNLphhmy
 8Tkauy9uyuz05RTTUwz/hXiStFODvxiDmb0HdSi6IzdcJIlLhBR1nHq+J7jhjuuWxJD3
 +EFTuv9st/YKtS9i01a1j3FD5PEI+fXslJz1axm3SDcHE0WRbX3n48TfZL10miiJ0tCy
 M+SfTv0jX8rajJ6PpoLy4Rl9MBsLn4K7rBTTSoC4K1t1URF4wz7ieuEElhkrcVUaPbrN
 aaP7J4AvYcUKiJsZG2fFzoQmWDg2vGPLIA+PtTxd3CKn7kDWze52092RQxoV8lGiHYig
 7Ejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=B+UOGyiCUJNuhbwqPHUKqo90Wxp/xQ4Ay09qO0K/Zhg=;
 b=R7WrLypDPe1UNV7mR4g4oMjkZKHzoUvvWUoNpHPM6z9ptoksiMyJmD9LCdz666aJ51
 H1eKDNgRkpvgu/6I7juladVKPKgLUX4bgX3wKqLMmjFUTVp8VJ5YrWuQHfTujrsaiLwB
 yvvDTydt3ia34HsD2ZNz7F/9fslUmR+WBz5dgajNVU9iXXkwTlSwirD4LwnPXmGxnrbI
 Ohn3JKdSB6k6Wtzgs5P8W1a7+2kLfEs05xOM/l0Qs7wuuIKieeRMkE6fQuM0OlGU+Wrb
 Y2p+NaDfMB6kUodWlN4KgM1dYKtDyf2rCf8DpPs13sM9db2h/KSybyXVNtV+rW17V2ZO
 58bQ==
X-Gm-Message-State: AGi0PuaWW4Ea5cI4lscAHVebo/tPgi05nIXkdfSHILnQnLZDFOgDLfLa
 gM3bRAUxGXQgGAm7ev3Iue8bc4K6vvw=
X-Google-Smtp-Source: APiQypLouT7zrIuJqnHZuxoUUsI3qpiYT/XmxYgMsCzD7xmheaw40tmVNqYr+IUykTXf9iUpB3ytAw==
X-Received: by 2002:a62:f908:: with SMTP id o8mr359724pfh.170.1588093559767;
 Tue, 28 Apr 2020 10:05:59 -0700 (PDT)
Received: from localhost.localdomain ([1.38.220.163])
 by smtp.gmail.com with ESMTPSA id u15sm2505097pjm.47.2020.04.28.10.05.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2020 10:05:59 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Tue, 28 Apr 2020 22:32:26 +0530
Message-Id: <20200428170228.7002-31-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200428170228.7002-1-jaskaransingh7654321@gmail.com>
References: <20200428170228.7002-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 28 Apr 2020 19:06:04 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Tue, 28 Apr 2020 19:06:01 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 30/32] tests: Add test case to check cast attribute
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
