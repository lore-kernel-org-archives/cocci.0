Return-Path: <SRS0=0GNs=4Z=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD16C10F29
	for <cocci@archiver.kernel.org>; Sun,  8 Mar 2020 08:45:10 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CCC120838
	for <cocci@archiver.kernel.org>; Sun,  8 Mar 2020 08:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLYHosbb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CCC120838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0288iveL000332;
	Sun, 8 Mar 2020 09:44:57 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 6039C7819;
	Sun,  8 Mar 2020 09:44:57 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 66EF37814
 for <cocci@systeme.lip6.fr>; Sun,  8 Mar 2020 09:44:55 +0100 (CET)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:102e])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 0288irsP025184
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 8 Mar 2020 09:44:54 +0100 (CET)
Received: by mail-pj1-x102e.google.com with SMTP id l8so3032991pjy.1
 for <cocci@systeme.lip6.fr>; Sun, 08 Mar 2020 00:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OAgaf6f/g8C77m/ZDRBPmrtY2bP/QHsonyCPsjIZw/U=;
 b=nLYHosbblarsu+jNX0qmOgQv0OXnyZyzPSP+u9P7VGUkZriHsQQXSD4CODIg4lMm60
 RR38WjbvCM5dpFvetEA5ttRfOnmFQbuJUGWNDObwv6/WAYuvA9gNbREdM1AHHTMGjR5t
 lQuu/4YkAy4azj2mNeXmEiSo1s18ZsWVmEP0hUvudU5XGJyPmp3ZZl7aqx3r+AL1UH6r
 DEIZihnbfCm+vhAIS6PvFVDcu1KDXrDUNtPd+L7pRbWizGJI7xP4GnjJKAPRqUoC/ETd
 tT3pzbkEizLqJbyy4hIeh6pKOrZxF+xERd4WNK8LcwHxViE6RbBzmnCNTivewASVr6PN
 UdSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OAgaf6f/g8C77m/ZDRBPmrtY2bP/QHsonyCPsjIZw/U=;
 b=mWhCYImOvrbZbWXH0kmz4/7DaGpm3iv+EIoiby5v//3H7AEhE/ErqOxhRnBoS1z9Ni
 TVjjwldiJai3tY//X4k+NdQQ59DQPttbmk94v89bdqx5rd4Ek3jq2M4QfHXYTzknTrtX
 v4MrgtJTYEzQSnBOgtocwtZ/fxDD6Y5C1Xlm4SOFaE9XdyrpD1czhX/Qzcl2gyUbsker
 6/OKU68x7GybeVX8sJvUe104XJS54pvAiFFnPujn7wZFutJh1H11yXrqiIdAHGsDGS9L
 k+CHUmMjoDEpGcFTsL0YCCjw4H4ozU/hktPxIrXV31YWPB94REJ3xQhXhPcs8oXOqlXf
 jbGQ==
X-Gm-Message-State: ANhLgQ293Q/nt8+2/c438ksJ7kBTqUueLUMSdXBnIiV+wFIAb7ezxWsW
 aj1uW5+JtL7EGazydciqjUvIY3vI
X-Google-Smtp-Source: ADFU+vuV3eswFrpa7AXYG+ZZ4kW1n+P7XnLdC0H8c6UN/irj0Ldjz1NyKWqGy3I11B0tyK4DsENs3A==
X-Received: by 2002:a17:902:ab8f:: with SMTP id
 f15mr11029537plr.280.1583657092804; 
 Sun, 08 Mar 2020 00:44:52 -0800 (PST)
Received: from localhost.localdomain ([1.38.148.20])
 by smtp.gmail.com with ESMTPSA id b3sm14587244pjo.30.2020.03.08.00.44.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Mar 2020 00:44:52 -0800 (PST)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sun,  8 Mar 2020 14:13:55 +0530
Message-Id: <20200308084356.14506-13-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200308084356.14506-1-jaskaransingh7654321@gmail.com>
References: <20200308084356.14506-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 08 Mar 2020 09:44:57 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 08 Mar 2020 09:44:54 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 12/13] tests: Add test case for assigned enumerator
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

Add a test case to verify correct pretty printing of
enumerators that are assigned. The test case should cover
minused assigned enumerators, plussed assigned enumerators
and correct matching of an enum with an assigned enumerator.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 tests/enum_assign.c     |  6 ++++++
 tests/enum_assign.cocci | 11 +++++++++++
 tests/enum_assign.res   |  7 +++++++
 3 files changed, 24 insertions(+)
 create mode 100644 tests/enum_assign.c
 create mode 100644 tests/enum_assign.cocci
 create mode 100644 tests/enum_assign.res

diff --git a/tests/enum_assign.c b/tests/enum_assign.c
new file mode 100644
index 00000000..9c2d16df
--- /dev/null
+++ b/tests/enum_assign.c
@@ -0,0 +1,6 @@
+enum h {
+	a = 0,
+	c,
+	x,
+	b
+};
diff --git a/tests/enum_assign.cocci b/tests/enum_assign.cocci
new file mode 100644
index 00000000..a1a59ef8
--- /dev/null
+++ b/tests/enum_assign.cocci
@@ -0,0 +1,11 @@
+@@
+@@
+
+enum h {
+  ...,
+- a = 0,
++ q = 0,
+  ...,
+  b,
++ z
+};
diff --git a/tests/enum_assign.res b/tests/enum_assign.res
new file mode 100644
index 00000000..3b204aa0
--- /dev/null
+++ b/tests/enum_assign.res
@@ -0,0 +1,7 @@
+enum h {
+	q = 0,
+	c,
+	x,
+	b,
+	z
+};
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
