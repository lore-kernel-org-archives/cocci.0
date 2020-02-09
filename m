Return-Path: <SRS0=c99d=35=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ACF6C35250
	for <cocci@archiver.kernel.org>; Sun,  9 Feb 2020 11:55:32 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB82E20726
	for <cocci@archiver.kernel.org>; Sun,  9 Feb 2020 11:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oOdgrpkD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB82E20726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 019BtJeJ024427;
	Sun, 9 Feb 2020 12:55:19 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 22118772F;
	Sun,  9 Feb 2020 12:55:19 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 2F1617718
 for <cocci@systeme.lip6.fr>; Sun,  9 Feb 2020 12:55:17 +0100 (CET)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:102d])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 019BtFdG012261
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 9 Feb 2020 12:55:16 +0100 (CET)
Received: by mail-pj1-x102d.google.com with SMTP id ep11so2934964pjb.2
 for <cocci@systeme.lip6.fr>; Sun, 09 Feb 2020 03:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5rugtx9GBe1lG9uj6KsKtPWifj61Jj2aO+D5dGd+5dc=;
 b=oOdgrpkDg6c8nHcFjJVqD2ivvaHLJq8GeS1i23vHDxZuUBFeeBREniTRYIV5/slPMu
 bvgMOE0VZDavNvTXwis1Lg3krB9htJxAAFmrbO+bvZNqyZE5Ye6l/WdUQjktLX/HZvIq
 X5di9HAQWTvwwGuJb54pGbZCVFom6jdTJZNhIwnIa7ef6ejBi/8ReqVqIFIdF7zxHISe
 QRzwvrdWJFtQphKQUp834/84iMTP0azcEQimrb01eRdmNLsOT4MpRGudDYtvP5HtMFXG
 RW+wu2E+tPg+rUC8XiuWFRIujT+DTPTDu0xtHELWmXrOfrvu6g32z3t/hhpSOQHjRMgM
 J6Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5rugtx9GBe1lG9uj6KsKtPWifj61Jj2aO+D5dGd+5dc=;
 b=Y0TfYqa0R7tpQPV/Rbq2rxeU6QGWW4oEUqLrtACQMKOPl/QzavW5riSzQLou7r0lBi
 jtKwGOPIffgrwL42hbZF7qn7o/ADpYUdNuLOvdbbedMUmtZzSJ4aI3K3gt9W4FcgtqD0
 Tjo9ZPFZr42s3tZrYUjKWfSCYL6Kgza/xgisrBAEcdDtmLrODS0iLSX0oK8WEyOzAR/J
 CSWRo9J++27+LdjpX47U18KWkAZWpPaFt3YufzLstUbboU4DqfaKBq+59KttqQ3PxD5I
 5WF2n5WNeEiNuaOjOBHiTUociZ+Ylo0ms8o5T4XX75yeS/j+HsodRJSXEvgTJNoH12+9
 5Uvg==
X-Gm-Message-State: APjAAAXpkkKhWJSzduD6cxSYktSGK9yYF+dMnRoeG32WBJ1m9RRrw39W
 ZRpoWqUlcQLt7zNXgkp9xzyP3ldxoFg=
X-Google-Smtp-Source: APXvYqzWliVClIlk+PxpNWeAied0QvzrZ/Pv5sQJrXUXxXi6/uWwo6UFZQJZfXNhQXbiAGMA5XYcSA==
X-Received: by 2002:a17:90a:fa94:: with SMTP id
 cu20mr15181924pjb.114.1581249314796; 
 Sun, 09 Feb 2020 03:55:14 -0800 (PST)
Received: from localhost.localdomain
 ([2402:3a80:166e:dca2:8d98:ad42:3c3b:8544])
 by smtp.gmail.com with ESMTPSA id y6sm8947429pgc.10.2020.02.09.03.55.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2020 03:55:14 -0800 (PST)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sun,  9 Feb 2020 17:24:19 +0530
Message-Id: <20200209115419.32337-4-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200209115419.32337-1-jaskaransingh7654321@gmail.com>
References: <20200209115419.32337-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 09 Feb 2020 12:55:19 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 09 Feb 2020 12:55:16 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v3 3/3] tests: Add test case to match const pointer
	variants
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

Pointer to const pointer and its variants would not match previously.
Add a test case for matching these types.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 tests/constptr.c     |  7 +++++++
 tests/constptr.cocci | 19 +++++++++++++++++++
 tests/constptr.res   |  7 +++++++
 3 files changed, 33 insertions(+)
 create mode 100644 tests/constptr.c
 create mode 100644 tests/constptr.cocci
 create mode 100644 tests/constptr.res

diff --git a/tests/constptr.c b/tests/constptr.c
new file mode 100644
index 00000000..13fe064c
--- /dev/null
+++ b/tests/constptr.c
@@ -0,0 +1,7 @@
+int main()
+{
+	const char * const * id;
+	const char * * const * id;
+	const char * const * * id;
+	const char * const id;
+}
diff --git a/tests/constptr.cocci b/tests/constptr.cocci
new file mode 100644
index 00000000..29f0aa96
--- /dev/null
+++ b/tests/constptr.cocci
@@ -0,0 +1,19 @@
+@ r0 @
+identifier id;
+@@
+const char * const *
+- id
++ id1
+;
+const char * * const *
+- id
++ id2
+;
+const char * const * *
+- id
++ id3
+;
+const char * const
+- id
++ id4
+;
diff --git a/tests/constptr.res b/tests/constptr.res
new file mode 100644
index 00000000..0af4de9a
--- /dev/null
+++ b/tests/constptr.res
@@ -0,0 +1,7 @@
+int main()
+{
+	const char * const * id1;
+	const char * * const * id2;
+	const char * const * * id3;
+	const char * const id4;
+}
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
