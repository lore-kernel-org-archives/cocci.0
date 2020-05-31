Return-Path: <SRS0=O8dQ=7N=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB9AC433DF
	for <cocci@archiver.kernel.org>; Sun, 31 May 2020 15:28:32 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CEC0206DA
	for <cocci@archiver.kernel.org>; Sun, 31 May 2020 15:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ED1aNGT0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CEC0206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04VFSRC2000990;
	Sun, 31 May 2020 17:28:27 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B989A7752;
	Sun, 31 May 2020 17:28:27 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 19A1E3C89
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 17:28:26 +0200 (CEST)
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:442])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04VFSOXD021714
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 17:28:25 +0200 (CEST)
Received: by mail-pf1-x442.google.com with SMTP id n15so2282390pfd.0
 for <cocci@systeme.lip6.fr>; Sun, 31 May 2020 08:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wqCIwDScet/SSV7xUt/88H3gSHkZyzKqS7t7vQrsTB0=;
 b=ED1aNGT0qZkmpNi2FGH95YkZPgnAX3Un0vMTQw/WLnCiueBToJwkS/orpnemCYs1uD
 3dT+BRK+ld96nT11+sROqve3yp1H6VXWrxR6clgrPF7V/qa0FAhxHtYxZJfvu4X1sxxh
 f8GagLxA9Epqfsd4wbMUfSAcN0rVETgiPSGuwvr6tsVLzoMtch/FrO6ho7N7oI/LgbdB
 u7uDeMTEPqauXLaS1gF2GhqocUEZ90XyiX+zeGbxXBE2H48u0uZ4MsilpJMSDNBydYav
 ftJNWlFV4hciy0fMgMrhju8kqlh6321ycTf+osM6uCKWbEil/ZduO+FSdDrkqKGYYs7+
 xHSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wqCIwDScet/SSV7xUt/88H3gSHkZyzKqS7t7vQrsTB0=;
 b=PFU6+Cai2ez87e5rDyC1z5Y49002udrQJXHm12tdFpSeDjWYBnZzHW2y73izSSS9HT
 5zBOxQ2uHIH+Ac5zfax45VuRMT3NOxyMn8Cfbsmzpv8CGhlMl2clBHy+eSn82Hv81+qa
 iajoVUzKDYua1yOeoELMp/mG6Lz0PcW2uyzmoqdQEXuysM6zBa/y6LRrEef07DVLKUOx
 0n7UOgRD2H8B6+RXS7y9ZrTfFpNuPT4M5irB2J088fuJwnKTe++4+qmDTuDz+xzlR38o
 52S4C6/pfzATaOrwU7k+iy90e/agUx1a+9kyBvpgDaLXp3liIVW4SAMwU9gKIiHvWTVA
 SQog==
X-Gm-Message-State: AOAM532+9cxVgudyS0MZBKgy26kpnhxM5koSm3z7+Y26m+Ue0xzM1Exe
 I4N4hDmWoBNUQcQuatPkcMdivqB3
X-Google-Smtp-Source: ABdhPJxvj6eHj14bRlZ8UXcLWORmsvXbQ4IjVD7Lx7pQbAvf1ENVABb/DTOdTOXbWAu51gJLNogFqg==
X-Received: by 2002:a63:3756:: with SMTP id g22mr15811789pgn.304.1590938903649; 
 Sun, 31 May 2020 08:28:23 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:1863:fef5:a170:128b:8ef:499d])
 by smtp.gmail.com with ESMTPSA id 131sm12310443pfv.139.2020.05.31.08.28.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2020 08:28:23 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sun, 31 May 2020 20:56:19 +0530
Message-Id: <20200531152621.2886-26-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200531152621.2886-1-jaskaransingh7654321@gmail.com>
References: <20200531152621.2886-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 31 May 2020 17:28:27 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 31 May 2020 17:28:25 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 25/27] tests: Add test case to remove a struct end
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

Stuct end attributes are added to the SmPL and C ASTs. Add a test case
to remove struct end attributes.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 tests/remove_struct_endattr.c     | 7 +++++++
 tests/remove_struct_endattr.cocci | 7 +++++++
 tests/remove_struct_endattr.res   | 7 +++++++
 3 files changed, 21 insertions(+)
 create mode 100644 tests/remove_struct_endattr.c
 create mode 100644 tests/remove_struct_endattr.cocci
 create mode 100644 tests/remove_struct_endattr.res

diff --git a/tests/remove_struct_endattr.c b/tests/remove_struct_endattr.c
new file mode 100644
index 00000000..95aa8610
--- /dev/null
+++ b/tests/remove_struct_endattr.c
@@ -0,0 +1,7 @@
+#define __struct_endattr MACROANNOTATION
+
+struct abcd {
+	int a;
+	int b;
+	int c;
+} __struct_endattr;
diff --git a/tests/remove_struct_endattr.cocci b/tests/remove_struct_endattr.cocci
new file mode 100644
index 00000000..c4b86864
--- /dev/null
+++ b/tests/remove_struct_endattr.cocci
@@ -0,0 +1,7 @@
+@@
+attribute name __struct_endattr;
+@@
+
+struct abcd {...}
+-	__struct_endattr
+;
diff --git a/tests/remove_struct_endattr.res b/tests/remove_struct_endattr.res
new file mode 100644
index 00000000..dda83724
--- /dev/null
+++ b/tests/remove_struct_endattr.res
@@ -0,0 +1,7 @@
+#define __struct_endattr MACROANNOTATION
+
+struct abcd {
+	int a;
+	int b;
+	int c;
+};
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
