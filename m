Return-Path: <SRS0=WAcx=37=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BC7C352A3
	for <cocci@archiver.kernel.org>; Tue, 11 Feb 2020 14:02:35 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 608EE206ED
	for <cocci@archiver.kernel.org>; Tue, 11 Feb 2020 14:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SjBQEa6h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 608EE206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 01BE29x8003619;
	Tue, 11 Feb 2020 15:02:09 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 4631077FF;
	Tue, 11 Feb 2020 15:02:09 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 5018C77EF
 for <cocci@systeme.lip6.fr>; Tue, 11 Feb 2020 15:02:07 +0100 (CET)
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:541])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 01BE25Ge004546
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Tue, 11 Feb 2020 15:02:06 +0100 (CET)
Received: by mail-pg1-x541.google.com with SMTP id u131so5761583pgc.10
 for <cocci@systeme.lip6.fr>; Tue, 11 Feb 2020 06:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ci+Rbqp1YivjpLX9BG2inDxFW0vPbauOHc8MjODqOjk=;
 b=SjBQEa6h+4n8DntgZfs21FRfVn91W25NzjrKOsUmjkLc3WfHgTviZm3Xj4dGY/IiSB
 /7rxaXUkwTtZ/RJnK5Y3VJf0n/T0W8MUx/oV0Q/7dLJSegPkSUClq1WEeOPt5KX+TfTO
 3xImnIpGpD/rAzLqIFNPSnMrursNM91Gdfz3TV0tpXGLREpKFukhg6yiqbCOM2w01aEh
 VXIZWUj+AfFQzL+tKmZxPAO0S8LuMDzDUuW0wCl3G3/Pw9de0wgJYOz+EWuagPNDh3f5
 tBsH3Hd1fXWbQpMQpXQJH6XxITYwkGBXkjiFl4QWyIVWX9vXsxUpQlUMk9+7X4ZzB7Hu
 oOpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ci+Rbqp1YivjpLX9BG2inDxFW0vPbauOHc8MjODqOjk=;
 b=Bob3mkPhL1UEfdm7DU1CSiG8c/syGvznmbdd5JDo2GrXUaYJbHJ2RAe3pCEvVe1DKx
 Wb4of+56RnkCunMkSAKHaB3myWXWISRajcfgnrjNZaiR5ipxrtGJpOBSo3mGagEzBwr4
 7SWiEPFNGn/czeXRXQEJgZwLSibpvhzO3Yw4FcHzzjIP9JqWloPVeoKORoZGTIXCIiq5
 tu8t78LXrfVIEQi2qBZn4kmvzpzc6kaa4x8UgUENcrxGOGSHZYe1lbYXgWWU4MDCEaPB
 ejvy56YmPyQPaSJ0tWLOQUDmI9QllVI5D8DZdTn0Rur1BIOzEdFdz3ClpkExadVnP06d
 Uq+Q==
X-Gm-Message-State: APjAAAW/aTWA5xp6SW0Zb9ft/BblTveMvY/XSCCickiwIzsiIRUUJIeo
 KVvyediX6fb1WDjexq1nvCWHIgwD
X-Google-Smtp-Source: APXvYqzdRwFgv3sFFc52tz33AM1/sMoH6aUVDLoG2bEo3FkCCnwOQO+U6+qkwrAmIiGqqxjbI2PgJA==
X-Received: by 2002:aa7:9f5e:: with SMTP id h30mr3419244pfr.137.1581429724603; 
 Tue, 11 Feb 2020 06:02:04 -0800 (PST)
Received: from localhost.localdomain ([2405:204:22ac:7250:d1c8:6411:2f12:731d])
 by smtp.gmail.com with ESMTPSA id z26sm4203575pgu.80.2020.02.11.06.02.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2020 06:02:04 -0800 (PST)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Tue, 11 Feb 2020 19:31:37 +0530
Message-Id: <20200211140137.2304-4-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200211140137.2304-1-jaskaransingh7654321@gmail.com>
References: <20200211140137.2304-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 11 Feb 2020 15:02:09 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Tue, 11 Feb 2020 15:02:06 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v5 3/3] tests: Add test case to match const pointer
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
index 00000000..49f4af65
--- /dev/null
+++ b/tests/constptr.c
@@ -0,0 +1,7 @@
+int main()
+{
+	const char * const *id;
+	const char ** const *id;
+	const char * const **id;
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
index 00000000..62fe2513
--- /dev/null
+++ b/tests/constptr.res
@@ -0,0 +1,7 @@
+int main()
+{
+	const char * const *id1;
+	const char ** const *id2;
+	const char * const **id3;
+	const char * const id4;
+}
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
