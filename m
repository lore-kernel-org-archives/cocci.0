Return-Path: <SRS0=PnfW=3F=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A453C33CB1
	for <cocci@archiver.kernel.org>; Thu, 16 Jan 2020 10:46:00 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 043972077B
	for <cocci@archiver.kernel.org>; Thu, 16 Jan 2020 10:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sz3DhRC4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 043972077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00GAji7u015643;
	Thu, 16 Jan 2020 11:45:44 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id C65E977E5;
	Thu, 16 Jan 2020 11:45:44 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 38E9D771F
 for <cocci@systeme.lip6.fr>; Thu, 16 Jan 2020 11:45:43 +0100 (CET)
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1042])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00GAjYwu005583
 for <cocci@systeme.lip6.fr>; Thu, 16 Jan 2020 11:45:34 +0100 (CET)
Received: by mail-pj1-x1042.google.com with SMTP id kx11so1346344pjb.4
 for <cocci@systeme.lip6.fr>; Thu, 16 Jan 2020 02:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/bjJlXg6aQ0sdQZeUUmyebQ6K6s748binPw0SD7Jvao=;
 b=sz3DhRC4GqfMusKItSwQVX4Wi0Syw2AvRgg9NZXRpL/LxEbo2WiScO2xLf/PNxKzI6
 Hfv3jMrKyMCYNcpP6Etbdw4CXqfI5VGLJjp8e65Q/Vg2sJuLRKRUDAOQ3Ma9jihhtfO7
 lE6lFw7+7FIAgmLkxIzwczeOIw54XSu3OZtQFYT6T9eWuTXZpe2Xgo3/RpufAnSEnD5+
 Nsv26kO3HlyFDX5dC+gV4c3G9hUuEQ9ALviEBqZ/hacbwXDdV/bEtaXNO8QIw1xLGyTE
 n9WZU62UjoEtHhTH3vJZYtxN0o6uFYqLLxJf/CAaPfLuI5IRROWzArUPOhBS1n8tkRuG
 gp1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/bjJlXg6aQ0sdQZeUUmyebQ6K6s748binPw0SD7Jvao=;
 b=TcJjj7T0uaSE3z7D9xGCd9ufSCWLEFz9J69jtecOEkcG3c48Y5NcZ9O1l4xEuWGcFz
 /ESP/H1voCGhvN3wp/NifHhUwXTZJxKiW8IJa8bVw/04cyPtZdl1iX8LLkxkUl9YMClE
 Hqb9dMLggqVrTAjGifbrIYKFxmndeYMpg0m8xjS/Qmqd5NzIL6fltithYHpqr7Az0kgm
 RLiVVPmnWqDvug5sIn1uwBLpzzHJRbR9WlT362WNUuEE4xcvwaR1avi7y+DrAd0UJRKy
 yDZ/glZ7AgPB4ltrMfFnFMXGz/jgOvrZUAjEDjcYJ38whiit5W2ndd+Gx0XCLUAtKTxQ
 qt4g==
X-Gm-Message-State: APjAAAXXvsH526GqiqFn03Jq902WycZ3k3wX4RkCANDkfjd0Jrjb2m/o
 wABC58Elvu0LM5TZQccig8/i3W1p
X-Google-Smtp-Source: APXvYqzSbHRoEyi5/NJU90QhV6t2d5GZOyTPUMlpCsJrFN2aJ/KbQZbS8Zl1/C7Lze/Ap5vIDCA4Ag==
X-Received: by 2002:a17:902:82cc:: with SMTP id
 u12mr29409078plz.342.1579171533729; 
 Thu, 16 Jan 2020 02:45:33 -0800 (PST)
Received: from localhost.localdomain
 ([2402:3a80:1677:7d6f:b2c8:b07a:d4f3:9a2c])
 by smtp.gmail.com with ESMTPSA id a69sm25948799pfa.129.2020.01.16.02.45.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2020 02:45:33 -0800 (PST)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Thu, 16 Jan 2020 16:14:48 +0530
Message-Id: <20200116104448.15539-3-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200116104448.15539-1-jaskaransingh7654321@gmail.com>
References: <20200116051843.3328-1-jaskaransingh7654321@gmail.com>
 <20200116104448.15539-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 16 Jan 2020 11:45:44 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Thu, 16 Jan 2020 11:45:34 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 2/2] tests: Add test case for * const *
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

Previously, a space would not be added after the * const. Add
a test case for testing spacing with use of the type.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 tests/ptrconstptr.c     | 3 +++
 tests/ptrconstptr.cocci | 7 +++++++
 tests/ptrconstptr.res   | 3 +++
 3 files changed, 13 insertions(+)
 create mode 100644 tests/ptrconstptr.c
 create mode 100644 tests/ptrconstptr.cocci
 create mode 100644 tests/ptrconstptr.res

diff --git a/tests/ptrconstptr.c b/tests/ptrconstptr.c
new file mode 100644
index 00000000..a2a3cf71
--- /dev/null
+++ b/tests/ptrconstptr.c
@@ -0,0 +1,3 @@
+void main() {
+	const char * const * x;
+}
diff --git a/tests/ptrconstptr.cocci b/tests/ptrconstptr.cocci
new file mode 100644
index 00000000..030bc024
--- /dev/null
+++ b/tests/ptrconstptr.cocci
@@ -0,0 +1,7 @@
+@@
+type t;
+@@
+void main() {
+-	t x;
++	t y;
+}
diff --git a/tests/ptrconstptr.res b/tests/ptrconstptr.res
new file mode 100644
index 00000000..f5b2210c
--- /dev/null
+++ b/tests/ptrconstptr.res
@@ -0,0 +1,3 @@
+void main() {
+	const char *const *y;
+}
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
