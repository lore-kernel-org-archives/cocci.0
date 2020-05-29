Return-Path: <SRS0=Yx51=7L=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C69C433DF
	for <cocci@archiver.kernel.org>; Fri, 29 May 2020 12:10:36 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96FAC2077D
	for <cocci@archiver.kernel.org>; Fri, 29 May 2020 12:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZjjGtyF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96FAC2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04TCAWEY017396;
	Fri, 29 May 2020 14:10:32 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id CF2AB7783;
	Fri, 29 May 2020 14:10:32 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 59FCC5D47
 for <cocci@systeme.lip6.fr>; Fri, 29 May 2020 14:10:30 +0200 (CEST)
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:541])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04TCASr9001879
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 29 May 2020 14:10:29 +0200 (CEST)
Received: by mail-pg1-x541.google.com with SMTP id w20so1405675pga.6
 for <cocci@systeme.lip6.fr>; Fri, 29 May 2020 05:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=B+UOGyiCUJNuhbwqPHUKqo90Wxp/xQ4Ay09qO0K/Zhg=;
 b=UZjjGtyFVprQysqOgN3B+W8IEgsY0OVnhEVQQGtLg2LZrN05TGQcgEFIJBCRsj7Xst
 QxwWEMVp3GmjzMcMYefJxCvtEvslOP+pXWO/Av/pv0psp7oGQESm3Vf94Cw5kILRvG9A
 m29P3bBSEkP/FitbQehA3maWUrt3C6rLlfipB+DNAPK6tneU/cXNgjjAOTV0Q2Dv0Ftz
 GQX3bY59Jarm1H06C+xJvSIXx3gEJo+urBFS5j97TF+/SIP/AVgWVMK6YnP5/iGb6qa5
 8k4xUi9JBKu7aHPDCcimA55zEFozusTIUlK6RLZoqIXh3AsL5ofucMBBwObZ//NYCKti
 oATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=B+UOGyiCUJNuhbwqPHUKqo90Wxp/xQ4Ay09qO0K/Zhg=;
 b=eTL5xlbmd5aN1D7JGomQWzhilWlb14PaO7H/7mD21NRGPQ+HVVtL1L3+SQxVBGuvqU
 Wk913KHJuO3CUTZ59PJXpnzNqX9C5FhWyVq1qBxbmPz9c8z19mMu+rpOxnhQ4uc6bCxh
 S6XgyhWspPjhwc211ZNxVK4WcV3exeAD5gazmxiItgID7Tm0AZHLfxzAABFLTtZS+iKu
 rNnxsEBIeHZpPEnbxohNlwXSOPY0ExNL4CJ6d/kLiM8cBFiPAydgP68eOEzwh/pHThtm
 2kjxKvM3asdFSHF6SVWl3StDAKQ4OdKtT82XwqmFWfxfN6Ft4DeIbuiwbWOVAv1cYl1D
 y7Bg==
X-Gm-Message-State: AOAM530K0uo3YIS7bLt2rmG8q1I02SMfr4LvVF+A/9/IHJgzGLwSwXky
 nwS4rlFlp0gld5O39cTc7JfF3MpW
X-Google-Smtp-Source: ABdhPJyyrltPFfJ67re0ODsw736KVDzPmGE34UubTb3DbQhGFwQIAg0paOMZ0Klxut/eEXAXpYBkYA==
X-Received: by 2002:a63:d70f:: with SMTP id d15mr8285745pgg.322.1590754227895; 
 Fri, 29 May 2020 05:10:27 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:694:e576:19d1:a79b:707d:59f2])
 by smtp.gmail.com with ESMTPSA id dw13sm7975161pjb.40.2020.05.29.05.10.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2020 05:10:27 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri, 29 May 2020 17:37:00 +0530
Message-Id: <20200529120703.31145-31-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200529120703.31145-1-jaskaransingh7654321@gmail.com>
References: <20200529120703.31145-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 29 May 2020 14:10:33 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 29 May 2020 14:10:29 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v3 30/32] tests: Add test case to check cast
	attribute allminus
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
