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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E041EC352A3
	for <cocci@archiver.kernel.org>; Tue, 11 Feb 2020 14:02:16 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F8EA20870
	for <cocci@archiver.kernel.org>; Tue, 11 Feb 2020 14:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTdHcoeh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F8EA20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 01BE235g016401;
	Tue, 11 Feb 2020 15:02:03 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D725077FF;
	Tue, 11 Feb 2020 15:02:03 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 31D5477EF
 for <cocci@systeme.lip6.fr>; Tue, 11 Feb 2020 15:02:02 +0100 (CET)
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:541])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 01BE20Ji022621
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Tue, 11 Feb 2020 15:02:01 +0100 (CET)
Received: by mail-pg1-x541.google.com with SMTP id u131so5761460pgc.10
 for <cocci@systeme.lip6.fr>; Tue, 11 Feb 2020 06:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wJEO2wGMQKJV/ohpKPyAeBTsL/tteXWNt2JClbfnv8c=;
 b=TTdHcoehFybxRnpxrE9970V4uoBp61a/a4yvdGqQcF338YHtr3/X/2l6DiUvMxHiRf
 TU3IJoIw98hGtjNHps5/37RafyS5cv+TzthIs3ADfA+F59rhZ7g8WixCu20rMLJJR295
 VWNW6lNrFtnasaNJfsqDpf24GW1NtjRKF7+FikAd5Yd6uxIXlpKihUVwrzi//4yChfY5
 Rx9FILhQtp4nUIM3HPfHmzXzW4t3qkwD/xP+Zfv20kdHa7E9PZXhqyewD1hj8iwrfLy8
 B9vNOWYiFBZV5yHiIqkv+fJmdzdUTA6WV5sgn+f0mUkWN3Vbrw2bq/g/X791RVrTA2ZM
 Rq9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wJEO2wGMQKJV/ohpKPyAeBTsL/tteXWNt2JClbfnv8c=;
 b=O6tMc2yeW8ZewSwC8gnLxKXGsRamQSOT/ruec252+J5ejqV2Rdlm/ucaOxu1a42FTo
 U1rXLQM+ZVOfLTIoyfSnjL+4KmiQX1boPxMsENisZ+NgysVmwZVnyFXYKSAmEkjP8uis
 E1KX8efUwJNGx7ksYoOtUTZ602AaQ5Mcu7FYh2y6viq2nKafd2aHj53BJS+875aQn07i
 dK2mclVKNbiLStDlBSPELAO7mLgvRUbXsA1Mo1hHpdZReqPD+GFqEnL1j+eyQUCVwZza
 XsL24SL2f7ORr0Y32uQlNIepVAPe+4huxRfmizC1tdL4A3PbceUe6PGLbTNKPOAGZBuE
 JIwA==
X-Gm-Message-State: APjAAAWFxzjxLaCtWgQ+neOxbiRxPNqYdMev9p988TPl1tINcQFVTL21
 wm6GHa66KIxBgoNfA29YG/FbOl0I
X-Google-Smtp-Source: APXvYqytyOepmttl8yIXfongmNaFy+5daVnKlRgc2Q9Kj4mkbgvLSGyDivcfJt/8DtVoyYqKfWsahg==
X-Received: by 2002:a65:5ac7:: with SMTP id d7mr6896958pgt.175.1581429719544; 
 Tue, 11 Feb 2020 06:01:59 -0800 (PST)
Received: from localhost.localdomain ([2405:204:22ac:7250:d1c8:6411:2f12:731d])
 by smtp.gmail.com with ESMTPSA id z26sm4203575pgu.80.2020.02.11.06.01.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2020 06:01:59 -0800 (PST)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Tue, 11 Feb 2020 19:31:36 +0530
Message-Id: <20200211140137.2304-3-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200211140137.2304-1-jaskaransingh7654321@gmail.com>
References: <20200211140137.2304-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 11 Feb 2020 15:02:03 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Tue, 11 Feb 2020 15:02:01 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v5 2/3] tests: Add space between * and const in
	ptrconstptr.res
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

A space is now added between the * and qualifier. Reflect this
change in the ptrconstptr test case.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 tests/ptrconstptr.res | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/ptrconstptr.res b/tests/ptrconstptr.res
index f5b2210c..1d0c3c1d 100644
--- a/tests/ptrconstptr.res
+++ b/tests/ptrconstptr.res
@@ -1,3 +1,3 @@
 void main() {
-	const char *const *y;
+	const char * const *y;
 }
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
