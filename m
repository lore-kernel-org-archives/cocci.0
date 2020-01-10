Return-Path: <SRS0=VaV3=27=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED9D1C282DD
	for <cocci@archiver.kernel.org>; Fri, 10 Jan 2020 17:12:40 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CC9B2072E
	for <cocci@archiver.kernel.org>; Fri, 10 Jan 2020 17:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3QMATZq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CC9B2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00AHCP12005533;
	Fri, 10 Jan 2020 18:12:25 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 100D077EA;
	Fri, 10 Jan 2020 18:12:25 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 0AC6A77E3
 for <cocci@systeme.lip6.fr>; Fri, 10 Jan 2020 18:12:23 +0100 (CET)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:62f])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00AHCMj1015838
 for <cocci@systeme.lip6.fr>; Fri, 10 Jan 2020 18:12:22 +0100 (CET)
Received: by mail-pl1-x62f.google.com with SMTP id b22so1070139pls.12
 for <cocci@systeme.lip6.fr>; Fri, 10 Jan 2020 09:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1tkAbUZB3kx045DRrFSHvA/csk2W/zuhmEtYJ2YpWGs=;
 b=R3QMATZqiFDcjoJNE88i+UddlTUPayeO5QgM7hXDd8xqYx9Ic22UqBe8DR/h03uv8G
 rwEwGKZ6I9bp8+ZoGB/TU3zg633+CpFvBC7MDVMuQabvs8J7R961X9kr+NV1hGwJKo7A
 rBrhuwkk5T3gvG/w25FoacKJVag57yuTEOtQn+EPPgsGVX6PXRdaOy3MKsGrkmRFUrtj
 L5z8OzFfT2vI1vJ8wPvJZmCuPNLJdDHVn/We5+ZzVg38zOHuSNH5LygJE1596gUVkJOy
 6GLGXI2wPCvJoVUfTIMgCDObSAGx1+VhHDn7dpeQpYPZ3Iv0Cb3i7Seon9IDYB1UueUL
 imxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1tkAbUZB3kx045DRrFSHvA/csk2W/zuhmEtYJ2YpWGs=;
 b=DwbprFQQmlegmq0YA0yPyqd5CNUQrBy/9InRfgN2CkXBgbUaWusa8Jkb/Aoa1vbcFI
 65E6vkZV1DsXu05jld+CGm0eUNDLdvE1npddjCLC/CDjRq8i7dYT1bWEl4S1TU1XL5wL
 FaL3qXC/61opMJM9VOo6ltoAImT3+2gcVOmPofrj6FaJo7RYWjATXrOGnXqdJQ5vm79d
 foINql8qypQdJhWu452oQ6H1zk7tugaqvBf2mYkXInA/zjHQ0iRxS9ge4Yesf2gYkui7
 w/t5qNXjp0XDCk1jm46MobILPHh1DfkMs9xYpdSw2pG6CrjK/h5LzFd91Cvjn5lw/qnh
 kUSQ==
X-Gm-Message-State: APjAAAUc6YrLteZjtBTVBSuvoSfUtBGRx2f9oMnVltalJtVPQGp8SHzj
 9RWBNsUeBqo2O9Ojh/kJhnQmGgqvCXM=
X-Google-Smtp-Source: APXvYqwPpyTQHDNlkYoaXyT5xs3VtX/1Q4NpsI8e6Ag1oAOLUpywkcSvZgx0x6bXpDD6DcAlvITeLQ==
X-Received: by 2002:a17:902:bf0a:: with SMTP id
 bi10mr5626849plb.324.1578676341351; 
 Fri, 10 Jan 2020 09:12:21 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:1662:5ce0:c587:cd6:22a3:e892])
 by smtp.gmail.com with ESMTPSA id b24sm3534920pfo.55.2020.01.10.09.12.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2020 09:12:20 -0800 (PST)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri, 10 Jan 2020 22:41:50 +0530
Message-Id: <20200110171150.14695-3-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200110171150.14695-1-jaskaransingh7654321@gmail.com>
References: <20200110171150.14695-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 10 Jan 2020 18:12:25 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 10 Jan 2020 18:12:22 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org, skhan@linuxfoundation.org
Subject: [Cocci] [PATCH 2/2] tests: Add test case for user comments attached
	to ident
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

When comments were appended to an identifier passed from python to cocci or
ocaml to cocci, two cases showed pretty printing errors. Add a test case
for both of the erroneous cases.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 tests/id_comments.c     |  4 ++++
 tests/id_comments.cocci | 19 +++++++++++++++++++
 tests/id_comments.res   |  6 ++++++
 3 files changed, 29 insertions(+)
 create mode 100644 tests/id_comments.c
 create mode 100644 tests/id_comments.cocci
 create mode 100644 tests/id_comments.res

diff --git a/tests/id_comments.c b/tests/id_comments.c
new file mode 100644
index 00000000..b92f346b
--- /dev/null
+++ b/tests/id_comments.c
@@ -0,0 +1,4 @@
+foo () {
+	const void * const id;
+	pgd_t *__meminit id;
+}
diff --git a/tests/id_comments.cocci b/tests/id_comments.cocci
new file mode 100644
index 00000000..971616a5
--- /dev/null
+++ b/tests/id_comments.cocci
@@ -0,0 +1,19 @@
+@ r0 @
+type t;
+position p;
+@@
+t@p
+
+@ script:python r1 @
+id;
+@@
+coccinelle.id = "id/* user comment */"
+
+@ r2 @
+identifier r1.id;
+type r0.t;
+@@
+foo() {
+...
+++ t id;
+}
diff --git a/tests/id_comments.res b/tests/id_comments.res
new file mode 100644
index 00000000..b29ac113
--- /dev/null
+++ b/tests/id_comments.res
@@ -0,0 +1,6 @@
+foo() {
+	const void * const id;
+	pgd_t *__meminit id;
+	const void *const id/* user comment */;
+	pgd_t *__meminit id/* user comment */;
+}
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
