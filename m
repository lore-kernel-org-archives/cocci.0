Return-Path: <SRS0=kxF3=3K=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A392C3F68F
	for <cocci@archiver.kernel.org>; Tue, 21 Jan 2020 08:06:02 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 198C524125
	for <cocci@archiver.kernel.org>; Tue, 21 Jan 2020 08:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qpktwins"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 198C524125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00L85jTU029396;
	Tue, 21 Jan 2020 09:05:45 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 0B96677F5;
	Tue, 21 Jan 2020 09:05:44 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 2B77C77F4
 for <cocci@systeme.lip6.fr>; Tue, 21 Jan 2020 09:05:42 +0100 (CET)
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:641])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00L85aDq010696
 for <cocci@systeme.lip6.fr>; Tue, 21 Jan 2020 09:05:36 +0100 (CET)
Received: by mail-pl1-x641.google.com with SMTP id t14so990728plr.8
 for <cocci@systeme.lip6.fr>; Tue, 21 Jan 2020 00:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7o2v0dS94cjz4jidh7K1wn2GlfHDkvb7N3VB99YrJYE=;
 b=qpktwins7bhTbnQefJtI5zkmrkqDDkwHaSsFOD8KwH8wjzDn6uePmUld//7IAyOJc0
 9NYU5Z/OLb4cbOHTkLyqbNDHzLCp8fV+Xto8RLGXtMGIbAfM0+c/h0MN1Vb99AlnyYRG
 rVD6YYzfBMhEmajQrZhh6Wa9QraJT7xQT9Rz1DZ1ApHuX6HE9Gls0vc+fLgsEk/CeIPq
 rBBvIee68RY7+U6b8EVUuELrcPn2A9wlrQ2opbWdl+y92nbkme5shIR/6Ljv2LTBla+Y
 pWWJEvthROoJCokv90nTCm9CQOcBJCmTQM8gtCADfnlW3CiDVGo3NpzEgz8bqja0eMu5
 +sLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7o2v0dS94cjz4jidh7K1wn2GlfHDkvb7N3VB99YrJYE=;
 b=jb5h0/ZTRsUk79y7h7w+TfJIIIEXlOWx6NkeCvnErmGOh2OVK2mmy4VxnDWiAFl/Fd
 onQJkzyGWI3dAt+Ni3aptqxuRC+vNcUACeo2EO4dwbIQrJcD2HxKC2GgLJEFXcMGN5hf
 KklEujj9Z5CD0o/psJ5PniExJmzPGVV7ODZSMv0pOgOxsHn/qW6TM48xUkAjN7ZPuPH9
 DNiLG+6M8OzJ7CHZoDjTBZt1zkmyWylQTiBngC4wWPsg9M9qJIwsdoPsJJNWjlxEpdfj
 L9wYWyFSIiteCLbOBNMY7l/zqkevhajgfmQTMv3hnCCzF2PxZWvN/i+avamEeDe8aFl8
 ZknQ==
X-Gm-Message-State: APjAAAWr9I60zYmiXf/eBdkZJcDA6Ci9CDjXum3PQKPzOjQMKG3gRj2x
 pUjOO04rCqTbP7gBS86iUW6ut9Tk1/A=
X-Google-Smtp-Source: APXvYqy5qhJ+4iUUBbX6+fVQAQZJ1YgT0Z8Dh0OYV8WBGhXJouMhCrMtwkNBKJLzsr5zSuIqBaRFQw==
X-Received: by 2002:a17:90a:ba98:: with SMTP id
 t24mr3986773pjr.12.1579593935563; 
 Tue, 21 Jan 2020 00:05:35 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:167e:da7:fcf8:ab67:c0bb:e29])
 by smtp.gmail.com with ESMTPSA id
 k23sm39229604pgg.7.2020.01.21.00.05.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2020 00:05:35 -0800 (PST)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Tue, 21 Jan 2020 13:34:55 +0530
Message-Id: <20200121080455.24748-4-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200121080455.24748-1-jaskaransingh7654321@gmail.com>
References: <20200121080455.24748-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 21 Jan 2020 09:05:45 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Tue, 21 Jan 2020 09:05:36 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v2 3/3] tests: Add test case for <macro> bool <ident>
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

This would previously yield pretty printing errors,
i.e. bool would be printed on the next line, followed by ret on
the next to next line.

The metatype should be only bool and not <macro> bool.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 tests/macro_before_bool.c     | 4 ++++
 tests/macro_before_bool.cocci | 9 +++++++++
 tests/macro_before_bool.res   | 5 +++++
 3 files changed, 18 insertions(+)
 create mode 100644 tests/macro_before_bool.c
 create mode 100644 tests/macro_before_bool.cocci
 create mode 100644 tests/macro_before_bool.res

diff --git a/tests/macro_before_bool.c b/tests/macro_before_bool.c
new file mode 100644
index 00000000..a59cba5a
--- /dev/null
+++ b/tests/macro_before_bool.c
@@ -0,0 +1,4 @@
+static nokprobe_inline bool trace_kprobe_is_return(struct trace_kprobe *tk)
+{
+	return false;
+}
diff --git a/tests/macro_before_bool.cocci b/tests/macro_before_bool.cocci
new file mode 100644
index 00000000..53b2fd2e
--- /dev/null
+++ b/tests/macro_before_bool.cocci
@@ -0,0 +1,9 @@
+@@
+type t;
+identifier x;
+@@
+
+t x(...) {
++	t ret;
+	return false;
+}
diff --git a/tests/macro_before_bool.res b/tests/macro_before_bool.res
new file mode 100644
index 00000000..1b0ec319
--- /dev/null
+++ b/tests/macro_before_bool.res
@@ -0,0 +1,5 @@
+static nokprobe_inline bool trace_kprobe_is_return(struct trace_kprobe *tk)
+{
+	bool ret;
+	return false;
+}
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
