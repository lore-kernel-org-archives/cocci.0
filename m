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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91073C2D0DB
	for <cocci@archiver.kernel.org>; Tue, 21 Jan 2020 12:28:02 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EFBF20882
	for <cocci@archiver.kernel.org>; Tue, 21 Jan 2020 12:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UffiRM8g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EFBF20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00LCRkS3016537;
	Tue, 21 Jan 2020 13:27:46 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 15FA477E4;
	Tue, 21 Jan 2020 13:27:44 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 5A74277F5
 for <cocci@systeme.lip6.fr>; Tue, 21 Jan 2020 13:27:42 +0100 (CET)
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:542])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00LCRcIm008949
 for <cocci@systeme.lip6.fr>; Tue, 21 Jan 2020 13:27:38 +0100 (CET)
Received: by mail-pg1-x542.google.com with SMTP id b9so1381166pgk.12
 for <cocci@systeme.lip6.fr>; Tue, 21 Jan 2020 04:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jyO5Y6+8ERCgCwJfcrGe6hWYJAjbsP9FEu1YYGqGxxs=;
 b=UffiRM8grrXCjw1pJyCu8hQMZZ8VoMezuzMWoq+snmYgmFFwGkHhB5RbYAtuPDmbDu
 PHCVJN5PmJZeVtnPYjVIbWeSh1BcTvQ0CecH5lgM1NyqfU6XN9C6Og6ahulyf2TeAYH9
 xcT1ErYHfa5KWbGq4qrMWOoxq6pWWZfgLubTSSUSoby6QDVjxqM4U3DxPABjljIRa4Wz
 v4LiclmfCiBMmgOYdhHOO8/65z8NdXeod7HmbpRkMo+vTVQ3drRymTlKhdLagucHLTBR
 I5tjDYAR9SOflDlaq4AWXmP+5A00Rv0DjC6spWyl0BGFsLGiEjMXhHNm8w/Aj57fqXxN
 0aMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jyO5Y6+8ERCgCwJfcrGe6hWYJAjbsP9FEu1YYGqGxxs=;
 b=At4SHAk4dhAQuEVh1bC0N78zOAeEbmZRPpKHwVSRE4Fw7DrWTg0EqPfmOauxReNAVP
 uItloRTfaYJj70LdIrzE5TwMWxtOmfGGU9+4ojWiCaC9YDweCiazWyGygR2ey5Tc1jqi
 ZXkwfmRXTneg0Nuv2C8Ah/ePUBFDPww1pwujgY3Qcg2loEaXwnf+b9cV4700p7DP8hzM
 oPCgTrwkvEYM/NHCgWEsORQ6mFueP9tQD32Qtjagc25eMyyIhmDj7cpKfDnMLAbZdRgm
 dVTq1cmzmKiy/3PxG0KczA1RBefhJ8We4sVFiCzkTgXrKathPJSs+CL5D4uQUfnoFyJm
 8hFw==
X-Gm-Message-State: APjAAAUUnv3RSp5CQlr4TLxzF1gQbX1QTG9AXkCxulVK+kF/3yG1k/hP
 cdyxH6eEHeNkrP5dcwjRvGZN7EuAnGs=
X-Google-Smtp-Source: APXvYqw1pAO/taEwX4tig+r3OxJQQrb0yFBiTrKJnGGmq7X9NkrdNDZ3tjC8Sl1dzAfR2KkeiGhM7Q==
X-Received: by 2002:aa7:824d:: with SMTP id e13mr4260462pfn.247.1579609657586; 
 Tue, 21 Jan 2020 04:27:37 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:167e:da7:fcf8:ab67:c0bb:e29])
 by smtp.gmail.com with ESMTPSA id
 i9sm44381347pfk.24.2020.01.21.04.27.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2020 04:27:37 -0800 (PST)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Tue, 21 Jan 2020 17:57:19 +0530
Message-Id: <20200121122719.24226-3-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200121122719.24226-1-jaskaransingh7654321@gmail.com>
References: <20200121080455.24748-1-jaskaransingh7654321@gmail.com>
 <20200121122719.24226-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 21 Jan 2020 13:27:46 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Tue, 21 Jan 2020 13:27:38 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v3 3/3] tests: Add test case for <macro> bool <ident>
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
 tests/macro_before_bool.c     |  4 ++++
 tests/macro_before_bool.cocci | 10 ++++++++++
 tests/macro_before_bool.res   |  5 +++++
 3 files changed, 19 insertions(+)
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
index 00000000..667e4662
--- /dev/null
+++ b/tests/macro_before_bool.cocci
@@ -0,0 +1,10 @@
+@@
+type t;
+identifier x;
+symbol false;
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
