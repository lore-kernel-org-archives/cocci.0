Return-Path: <SRS0=Ekfz=33=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD83C352A3
	for <cocci@archiver.kernel.org>; Fri,  7 Feb 2020 06:10:18 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C85F020726
	for <cocci@archiver.kernel.org>; Fri,  7 Feb 2020 06:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0u34J0C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C85F020726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0176A6Mv018888;
	Fri, 7 Feb 2020 07:10:06 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 9B49D77EF;
	Fri,  7 Feb 2020 07:10:06 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 9C24C772B
 for <cocci@systeme.lip6.fr>; Fri,  7 Feb 2020 07:10:04 +0100 (CET)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:42b])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 0176A2Gl025085
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 7 Feb 2020 07:10:03 +0100 (CET)
Received: by mail-pf1-x42b.google.com with SMTP id 84so721853pfy.6
 for <cocci@systeme.lip6.fr>; Thu, 06 Feb 2020 22:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5rugtx9GBe1lG9uj6KsKtPWifj61Jj2aO+D5dGd+5dc=;
 b=C0u34J0CQuA3AtCrs3KU7Rx/KbETZyMe+rxXgyf136mNdBFtCP8bijh7Pcb4TPSgsT
 Br0OWB9ttj3n3DawjVZ/8VwYp23+GoIKhVAIDmJoVVh6aD+pP8Cky6S3xcBgFpxSVCzg
 YAstmou2h2n0lnbSr4DbNojO/RMn0U13yKg3cZq/ErF2JYQrPteqbN3lS64IsYnH2Irg
 WLjrItqVsecvDBGXS4EuQFKGZNn57AkNyJLu73Q5iNp8QqXm4GrRtkfe38V6149ERPOR
 w4/LqKBEx5vWtD2Np1XnFBI1p7P7BtavUrG6tFK7Yh5t87w2hH0rVJ1a97XwudlbZzqZ
 LY1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5rugtx9GBe1lG9uj6KsKtPWifj61Jj2aO+D5dGd+5dc=;
 b=enlp3gpDANqUj+NSx4NA9vhkSGtX4qp6lUN4t04vV+J+UMSXisusQqf4J3aAr9klAW
 4mLIH197PIr2223SMmXiFccY4cw0w9DZzdglIj58QEMbXYC6vmStEUTzm5eXUgcSe9dl
 FFY7OuB9SBzZnoXKaaDqQ/wHi4asGDoNQj++5qtwV1ZEVRrs9VqdCQ41n/IjeW/K10jf
 Qu1nq0g65hiYd7kUEbGmT1bltv/iMsm66T8oYvJkz7q1Lq4jdS66fzD2AG05xIX32NxV
 2kNj7hsfXtXbRru9DqDM0bdzOhekUvGcLnL9GrtqaxYgCgDtGnf2PWeyrrU8fe+bG6Lb
 AGHw==
X-Gm-Message-State: APjAAAVPntVbwB9jAkiHG57HFAWNxoIAgDWBiEJCEFZLCeYRcEFaJLmN
 ylQkHqavG2YYss6jYXnGkqzCqs5K
X-Google-Smtp-Source: APXvYqzb6ZNcOTAoD3YRsT4XoPmaNI/WchLdOUTfKst9SB0WjLpRBsXVSxiunpQOkjYYoWqO2r4I1w==
X-Received: by 2002:a63:7c4d:: with SMTP id l13mr7800295pgn.275.1581055802199; 
 Thu, 06 Feb 2020 22:10:02 -0800 (PST)
Received: from localhost.localdomain ([2405:204:30e:4a31:b268:7a3:7dc6:f288])
 by smtp.gmail.com with ESMTPSA id
 b130sm1243438pga.4.2020.02.06.22.09.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 22:10:01 -0800 (PST)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri,  7 Feb 2020 11:39:38 +0530
Message-Id: <20200207060938.9531-3-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200207060938.9531-1-jaskaransingh7654321@gmail.com>
References: <20200205130327.6812-1-jaskaransingh7654321@gmail.com>
 <20200207060938.9531-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 07 Feb 2020 07:10:06 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 07 Feb 2020 07:10:04 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v2 2/2] tests: Add test case to match const pointer
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
