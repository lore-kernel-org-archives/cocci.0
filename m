Return-Path: <SRS0=m0DH=ZT=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F7DC43141
	for <cocci@archiver.kernel.org>; Wed, 27 Nov 2019 17:39:44 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD868207DD
	for <cocci@archiver.kernel.org>; Wed, 27 Nov 2019 17:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nzWRGVM/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD868207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xARHdStU011989;
	Wed, 27 Nov 2019 18:39:28 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id C0B0177E4;
	Wed, 27 Nov 2019 18:39:27 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id A559577E0
 for <cocci@systeme.lip6.fr>; Wed, 27 Nov 2019 18:39:25 +0100 (CET)
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:443] (may be forged))
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xARHdOnc015065
 for <cocci@systeme.lip6.fr>; Wed, 27 Nov 2019 18:39:24 +0100 (CET)
Received: by mail-pf1-x443.google.com with SMTP id b19so11379729pfd.3
 for <cocci@systeme.lip6.fr>; Wed, 27 Nov 2019 09:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XI2+aCDvSDzw7sp0F3NSfsmqm2bx8d6RjVRQ43Sv6SI=;
 b=nzWRGVM/s3nDWNoHhBrxShxfFMTVYkQ4JsR9X6x+AmyO2eoUIwmihEut8p5pn+1Jsq
 IOTz7NpH1Z5cxJ/VYnhLAo/T6a4OhQqAmulMm2bWYrwlyh0pzYUt3aV1KVqN7MpToMMB
 I8BzJ9oqcEwDLIOpLEWUR2qabSpI/8GGdnvba0E16HHVFdM9sZnx8Z35p0VnBdDauS74
 DTl6jGHnqNIouIwFo3MqDSqyU3eURsT3xGqGacnc7MU7Iljqndg2wuzw7e/qGKHwLY3W
 GRaeQ81O782Lv4KsZCFkJIEH/9ifPYV45JOI9QltanZsFg5OEKJLiFTaCQCxehJF5S8I
 8y6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XI2+aCDvSDzw7sp0F3NSfsmqm2bx8d6RjVRQ43Sv6SI=;
 b=lHNJfjb42HllEAZ5lBJwTbAG0mLWTF9sOLPVvQL4uoCVOZCgxEFdHF2RW/K9hWMm4g
 LS3O4XVOBL5AjF2Si+vd1PFAXpUkW5ZsPNQoNkdaVku+yXyZQrrRW4NUzwAWmYAa96dP
 YgShJSUjWASF695XA+CXdboYJuXrI9sX/bYR9MLmWwocKZ4xre40cGj/G96ON087H/Bx
 KidKPjaI6Zo2CdK82HFjggb9kUHeh1vF63t/BHy8dYZYkdcmDBKHY/2s8cwjc/Zcj5ZL
 gfI563ite0+yu2TCqVQBR8m8FLuW2v0ZkQNeLPi/FoXj10nn0rRnVrCGm3yYckz8IGhY
 WHvw==
X-Gm-Message-State: APjAAAUJZibySPIYzeBuJKQAsGApfeRsrA3iBFb440ftN/Sz9GYV3tgD
 HL0TVmNilpRJ7Mv7ZQw0paQgrYKUpgU=
X-Google-Smtp-Source: APXvYqyVJYEQFE0zdBAikqy01aRhDIZuH1OYQFvPgZep80EZyVkbnbpSLwr6N52fxk8t51p+v4aUfw==
X-Received: by 2002:aa7:828c:: with SMTP id s12mr47700052pfm.166.1574876363779; 
 Wed, 27 Nov 2019 09:39:23 -0800 (PST)
Received: from localhost.localdomain
 ([2402:3a80:167f:97a7:3939:930e:5cf8:fd50])
 by smtp.googlemail.com with ESMTPSA id j23sm17028240pfe.95.2019.11.27.09.39.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Nov 2019 09:39:23 -0800 (PST)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Wed, 27 Nov 2019 23:08:15 +0530
Message-Id: <20191127173815.24988-3-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191127173815.24988-1-jaskaransingh7654321@gmail.com>
References: <20191127173815.24988-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 27 Nov 2019 18:39:28 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Wed, 27 Nov 2019 18:39:25 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org, skhan@linuxfoundation.org
Subject: [Cocci] [PATCH 2/2] tests: Add test case for statement removed and
	added
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

This is in response to the following "continue statement of death"
report:

https://www.mail-archive.com/cocci@systeme.lip6.fr/msg06199.html

Coccinelle would crash in similar cases, so add a test case for it.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 tests/stmt_removed_and_added.c     | 8 ++++++++
 tests/stmt_removed_and_added.cocci | 7 +++++++
 tests/stmt_removed_and_added.res   | 8 ++++++++
 3 files changed, 23 insertions(+)
 create mode 100644 tests/stmt_removed_and_added.c
 create mode 100644 tests/stmt_removed_and_added.cocci
 create mode 100644 tests/stmt_removed_and_added.res

diff --git a/tests/stmt_removed_and_added.c b/tests/stmt_removed_and_added.c
new file mode 100644
index 00000000..cbc64f42
--- /dev/null
+++ b/tests/stmt_removed_and_added.c
@@ -0,0 +1,8 @@
+void main()
+{
+	for(i; j; k) {
+		if (1)
+			continue;
+		c++;
+	}
+}
diff --git a/tests/stmt_removed_and_added.cocci b/tests/stmt_removed_and_added.cocci
new file mode 100644
index 00000000..93558a19
--- /dev/null
+++ b/tests/stmt_removed_and_added.cocci
@@ -0,0 +1,7 @@
+@@
+expression I, J, K;
+statement S;
+@@
+
+- for (I; J; K) S
++ while(1) S
diff --git a/tests/stmt_removed_and_added.res b/tests/stmt_removed_and_added.res
new file mode 100644
index 00000000..4b20027a
--- /dev/null
+++ b/tests/stmt_removed_and_added.res
@@ -0,0 +1,8 @@
+void main()
+{
+	while (1) {
+		if (1)
+			continue;
+		c++;
+	}
+}
-- 
2.21.0

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
