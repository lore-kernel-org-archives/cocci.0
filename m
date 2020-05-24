Return-Path: <SRS0=Qcbb=7G=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E07CC433DF
	for <cocci@archiver.kernel.org>; Sun, 24 May 2020 17:23:04 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B68BB206C3
	for <cocci@archiver.kernel.org>; Sun, 24 May 2020 17:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZG7J427c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B68BB206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04OHN1Ts000583;
	Sun, 24 May 2020 19:23:01 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 441E13DC8;
	Sun, 24 May 2020 19:23:01 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id F2AC93D0F
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 19:22:59 +0200 (CEST)
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1043])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04OHMwWW028663
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 19:22:59 +0200 (CEST)
Received: by mail-pj1-x1043.google.com with SMTP id fs4so635482pjb.5
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 10:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QKt5b00unFqdMIBEAxoAAwrEPkaBpKFIH7Eo5vQ20nc=;
 b=ZG7J427c0DizovDEfaZ9AXdW6fBuYiXaZm82xZFHicxMc8zdbwNCyZ7Z12+122nCHY
 sN/qrNZ76Dj652zFE1ozV5AsIRs9odRJI8TB8yORD1Dks5hcDyp13wFM4TlR7asoyp0D
 JlvkTgQ4ckWnLtf/YTBJ1tG83zn1ycKhuE7TEAx2wFDFhQrVqkSmcx11b53lCmyvi0Yi
 LKQyNDCm+5si4/i05vQeXD2vX9d5/dQ89o4NCZN58lUjMuYrOFsX8QxA74FGFqI4rgJW
 o6rjtZlmF+y/GzzdK5ETGh1zOb7PioDLcjyCbbUJTw/WJcBSZPMasM7tM/9MasXbU5qn
 Tz1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QKt5b00unFqdMIBEAxoAAwrEPkaBpKFIH7Eo5vQ20nc=;
 b=LTqO/e/rdw2AUjBy3Crt09lKItSK2wMp0mWfO9t1Dh+FYV/LpmP6KPLpg44PGdc8gB
 y3z+sJy8RPLxS6eX85jSPnKD6YBvq0JzGjeGB6soBhhNLT9eSPbuJRxovpVbAiAOTWu+
 WG/NY4fiMDsXLcoJXbEZ3YM6YJDLluuldNePtFixKSM4HlNo4CeSj4/iw+QJH5s6Wscp
 kkmgbwLljgstxaue433oZJvQMbqBUMExZVDub41PUCOUxFy4jFtgDqsuyrKmkJvb4n7+
 STWd5RYA30ssXJd9CINgcZksFn57+n+L32ZQtC9iBhAwjLJ8Bcrm9H4bSzcln+dz3j3Q
 9xqw==
X-Gm-Message-State: AOAM530ZLLdR2zSld/XGCIN1T6m58i8A76oHZ1FcdV7LG48H3K09n4LY
 FgAfTt9muDnb1t2dWYEBWc59J1dzMBA=
X-Google-Smtp-Source: ABdhPJxhrX7RZx2WhIrbU1IOS/rRnKzGK3RpCZAtAkCqkzuanIzrli4/VcVhe6ILHOHUzfkXqEal2w==
X-Received: by 2002:a17:90a:e28d:: with SMTP id
 d13mr16397813pjz.128.1590340977695; 
 Sun, 24 May 2020 10:22:57 -0700 (PDT)
Received: from localhost.localdomain ([1.38.220.54])
 by smtp.gmail.com with ESMTPSA id d9sm6556497pfn.72.2020.05.24.10.22.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2020 10:22:57 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sun, 24 May 2020 22:49:35 +0530
Message-Id: <20200524171935.2504-31-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200524171935.2504-1-jaskaransingh7654321@gmail.com>
References: <20200524171935.2504-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 24 May 2020 19:23:01 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 24 May 2020 19:22:59 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 30/30] tests: Add test case to detect a macrodecl
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

Macrodecl attributes are added to the SmPL and C ASTs. Add a test case
to detect a macrodecl attribute.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 tests/detect_macrodecl_attr.c     |  5 +++++
 tests/detect_macrodecl_attr.cocci | 12 ++++++++++++
 tests/detect_macrodecl_attr.res   |  5 +++++
 3 files changed, 22 insertions(+)
 create mode 100644 tests/detect_macrodecl_attr.c
 create mode 100644 tests/detect_macrodecl_attr.cocci
 create mode 100644 tests/detect_macrodecl_attr.res

diff --git a/tests/detect_macrodecl_attr.c b/tests/detect_macrodecl_attr.c
new file mode 100644
index 00000000..3dd89410
--- /dev/null
+++ b/tests/detect_macrodecl_attr.c
@@ -0,0 +1,5 @@
+#define __macro_attr MACROANNOTATION
+
+DECLARER(a, b) __macro_attr;
+
+DECLARER(a, b);
diff --git a/tests/detect_macrodecl_attr.cocci b/tests/detect_macrodecl_attr.cocci
new file mode 100644
index 00000000..70182f49
--- /dev/null
+++ b/tests/detect_macrodecl_attr.cocci
@@ -0,0 +1,12 @@
+@r0@
+declarer name DECLARER;
+attribute name __macro_attr;
+@@
+
+DECLARER(
+	...,
+-	a
++	c
+	,
+	...
+  ) __macro_attr;
diff --git a/tests/detect_macrodecl_attr.res b/tests/detect_macrodecl_attr.res
new file mode 100644
index 00000000..6574a7ea
--- /dev/null
+++ b/tests/detect_macrodecl_attr.res
@@ -0,0 +1,5 @@
+#define __macro_attr MACROANNOTATION
+
+DECLARER(c, b) __macro_attr;
+
+DECLARER(a, b);
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
