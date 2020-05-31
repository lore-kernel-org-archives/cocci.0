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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4B3C433E0
	for <cocci@archiver.kernel.org>; Sun, 31 May 2020 15:28:34 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDA66206DA
	for <cocci@archiver.kernel.org>; Sun, 31 May 2020 15:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qg5MOcEQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDA66206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04VFSV9c021122;
	Sun, 31 May 2020 17:28:31 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 378257752;
	Sun, 31 May 2020 17:28:31 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 190053C89
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 17:28:29 +0200 (CEST)
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:441])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04VFSRkf006042
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 17:28:28 +0200 (CEST)
Received: by mail-pf1-x441.google.com with SMTP id y18so2259261pfl.9
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 08:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=86EVu5+u+nNHYvgKzJSdx7Ox/swx4obSjpJyAcAeBA8=;
 b=qg5MOcEQxSPX/nyDJSnZFHCjLM1RqRIsVJOOGFAN7CF9CaJ0ndfDC1ph2y9C3bjz35
 EcShk0OY/8/LAjhf9iIAuNNW3674ZK2aTpjh52qSEQbPY9LGj0GC3C0R9aD+WUT+cKpy
 ZqKK2CeX2Q8WCWFMvxX4Zm4BuAdPx7plMlVQ7bE8amnx78GfC8J5pn7zeRtsm6NY2eqg
 q3/IOLGMMeeBNTBn+Ua/9udE+aZRiq2+9Qo3y/V3aPggNlnlDeProbPs7typzGVGaRrf
 iMUbRZJAJeD/MZ8MlyyY6UOK75ZlOwfY2oChTs9CSMj5SQ0lhTpF1uMNXgUVqdNP58vI
 YxMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=86EVu5+u+nNHYvgKzJSdx7Ox/swx4obSjpJyAcAeBA8=;
 b=e4ZUEwjLQ1AQri3NQ4Ve32FNUM9p2o5UIG3mKeCCmEGOCs7oOUhLag0BF/TEpOQH4z
 0TF8CmGDzPhFpYuFQapUIhjscWzqCgLpeo30ur7/pkVf1IvH7imrFXp4yhBcbiaQT2tl
 KzjhrXH7sigpEoecukTiXsfKigT7pOutgIimig71roQK9nnzOx7xEAKqctNCsGley5TZ
 yGoA9USoabdL/mfgbSRUZ6te7BL2VBvGL30Wb2iN3NDw5wCt+Qw4wnkmiCdnzSW/C62i
 CdYhLL4aDeMK33NjDW0s02adrfz7cHVEAG+DGuDodjSJLEwmIkRyg/lh/bySJStbaGBJ
 /c4g==
X-Gm-Message-State: AOAM533TjO8NZQrOMHAhEyrofhjSzNBMXXZiTfeazhd6vyM1c8n7neZp
 Z4/mBcRZLG5as4n6GA6KHWMCiDII
X-Google-Smtp-Source: ABdhPJyuSMShGJHRbzs1cGtOb4QLMyynrVSKM/6wMyxLjD6iYLBFYYFmWXa5LB6I9QA2ABt9vd7Aow==
X-Received: by 2002:a63:5f11:: with SMTP id t17mr15348813pgb.177.1590938906689; 
 Sun, 31 May 2020 08:28:26 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:1863:fef5:a170:128b:8ef:499d])
 by smtp.gmail.com with ESMTPSA id 131sm12310443pfv.139.2020.05.31.08.28.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2020 08:28:26 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sun, 31 May 2020 20:56:20 +0530
Message-Id: <20200531152621.2886-27-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200531152621.2886-1-jaskaransingh7654321@gmail.com>
References: <20200531152621.2886-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 31 May 2020 17:28:31 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 31 May 2020 17:28:28 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 26/27] tests: Add test case to detect a struct end
	attribute
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
to detect a struct end attribute.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 tests/detect_struct_endattr.c     | 13 +++++++++++++
 tests/detect_struct_endattr.cocci |  9 +++++++++
 tests/detect_struct_endattr.res   | 12 ++++++++++++
 3 files changed, 34 insertions(+)
 create mode 100644 tests/detect_struct_endattr.c
 create mode 100644 tests/detect_struct_endattr.cocci
 create mode 100644 tests/detect_struct_endattr.res

diff --git a/tests/detect_struct_endattr.c b/tests/detect_struct_endattr.c
new file mode 100644
index 00000000..240fcde9
--- /dev/null
+++ b/tests/detect_struct_endattr.c
@@ -0,0 +1,13 @@
+#define __struct_endattr MACROANNOTATION
+
+struct abcd {
+	int a;
+	int b;
+	int c;
+} __struct_endattr;
+
+struct abcd {
+	int a;
+	int b;
+	int c;
+};
diff --git a/tests/detect_struct_endattr.cocci b/tests/detect_struct_endattr.cocci
new file mode 100644
index 00000000..8b6ba797
--- /dev/null
+++ b/tests/detect_struct_endattr.cocci
@@ -0,0 +1,9 @@
+@@
+attribute name __struct_endattr;
+@@
+
+struct abcd {
+	...
+-	int b;
+	...
+} __struct_endattr;
diff --git a/tests/detect_struct_endattr.res b/tests/detect_struct_endattr.res
new file mode 100644
index 00000000..71002542
--- /dev/null
+++ b/tests/detect_struct_endattr.res
@@ -0,0 +1,12 @@
+#define __struct_endattr MACROANNOTATION
+
+struct abcd {
+	int a;
+	int c;
+} __struct_endattr;
+
+struct abcd {
+	int a;
+	int b;
+	int c;
+};
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
