Return-Path: <SRS0=pTva=3Z=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF31EC35254
	for <cocci@archiver.kernel.org>; Wed,  5 Feb 2020 13:04:18 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 886A0217F4
	for <cocci@archiver.kernel.org>; Wed,  5 Feb 2020 13:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egbNttUU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 886A0217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 015D44RW006322;
	Wed, 5 Feb 2020 14:04:04 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 36F61772B;
	Wed,  5 Feb 2020 14:04:04 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7742D7718
 for <cocci@systeme.lip6.fr>; Wed,  5 Feb 2020 14:04:02 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:635])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 015D40nq004378
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Wed, 5 Feb 2020 14:04:01 +0100 (CET)
Received: by mail-pl1-x635.google.com with SMTP id y8so850984pll.13
 for <cocci@systeme.lip6.fr>; Wed, 05 Feb 2020 05:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=32Y47SbuT10IdA/WyQebJ/4R/klDrpn3l0uQR85Y/JQ=;
 b=egbNttUUskY3YEA9gX0iL+5VLjTr+NqNVmDjlVRPHAjD4d/yR7tFH8YCFuwpkXroKt
 yxe7hlGJ/zaHFNtC9jwzCifFpdFk/mTLFFKi9EvqO+4eVml4uFTeast/mW15xBJVTQ/D
 9OaMmQc8rhoymXDA+ZtlrUVv6PY24fxvpNKXHWZqHdSpjcnkwx9LLqkzLRkKrZF9NYno
 SsHqj1jWAxZbGWZnLdAmnvvTGlcp/EX5UidYcCzHtfLQRQPe6aP1htObE5bTqjjpKY1U
 TFZYEvh/Fe8nldk5dhrM90JrMgYQulpLVFEi0HV4KDNJsFTH1J3bc1D7jmb91zMSqf08
 alCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=32Y47SbuT10IdA/WyQebJ/4R/klDrpn3l0uQR85Y/JQ=;
 b=GrogExBVBMtF/8KI1BTs1ZXTX3DwojQ7PXQ6sRZ+5pEt+R6st/3GOqY2mM6p9w0h43
 8UqO6qz1pBGq15BZQy5Opt4ZCYbtOetz1wwdPrKjuACjP9v5MHG/kLWITPtJZfmPwORQ
 kF2tgityMoxsYSV91dl3U3WCtz4TBPwUc6IJP6cGwlKvl6XTWUcP9QNCh3Fk5WqulNVa
 vDThMRn5yx+DrepagqGYqgNe4J/3I3eh3V0vcquXCuPQ+kzdPKlN2OJuKRVf/CL6TAPE
 NtK0ZQOkE6QRn//drsdOG46RKH5Wb4CM8DekXiXx5clS8d3rpx5F/5v2b3XWeEsTGPz0
 pDJA==
X-Gm-Message-State: APjAAAXfawaUC7+74DEBbboERm1lUz/EnRBPUXwIh4x9kK/vQm4Z1FgY
 6ZxEq9HNA21DwqrUUjqFboUzxoBwQWU=
X-Google-Smtp-Source: APXvYqx7w1WLfGWHTpBo+J9HYCB0UlysfQju0epJtu++DiFdp/GV2Oj65c6V5EN8uY4fPjQdWqYF3A==
X-Received: by 2002:a17:90a:928c:: with SMTP id
 n12mr5706717pjo.45.1580907839853; 
 Wed, 05 Feb 2020 05:03:59 -0800 (PST)
Received: from localhost.localdomain ([2405:204:30e:4a31:b268:7a3:7dc6:f288])
 by smtp.gmail.com with ESMTPSA id
 q6sm28137098pfh.127.2020.02.05.05.03.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 05:03:59 -0800 (PST)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Wed,  5 Feb 2020 18:33:27 +0530
Message-Id: <20200205130327.6812-3-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200205130327.6812-1-jaskaransingh7654321@gmail.com>
References: <20200205130327.6812-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 05 Feb 2020 14:04:04 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Wed, 05 Feb 2020 14:04:01 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 2/2] tests: Add test case for matching ptr to const
	ptr and variants
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

These types would not match previously. Add a test case for matching
a pointer to a const pointer and its variants.

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
