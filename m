Return-Path: <SRS0=c99d=35=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F94C35250
	for <cocci@archiver.kernel.org>; Sun,  9 Feb 2020 11:55:17 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7176520726
	for <cocci@archiver.kernel.org>; Sun,  9 Feb 2020 11:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uYmmcPAD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7176520726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 019Bt60Z014033;
	Sun, 9 Feb 2020 12:55:06 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A32BD772F;
	Sun,  9 Feb 2020 12:55:06 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id D03147718
 for <cocci@systeme.lip6.fr>; Sun,  9 Feb 2020 12:55:05 +0100 (CET)
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:441])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 019Bt3wH024935
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 9 Feb 2020 12:55:04 +0100 (CET)
Received: by mail-pf1-x441.google.com with SMTP id s1so2216054pfh.10
 for <cocci@systeme.lip6.fr>; Sun, 09 Feb 2020 03:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wJEO2wGMQKJV/ohpKPyAeBTsL/tteXWNt2JClbfnv8c=;
 b=uYmmcPADm2M3dK/UsVpCaQ4FDiRW6XnIX3PzgPZYcrp1SIpcGu7P00MSlB/TWYm7Bc
 19xbhJS5xY+uQesEkvPzEIiUfd8iTJ2ZqWqP9Bm1CVUPloogs5qtcDEWnNbFxfj+X8Zv
 je8YfFK7ztYt7HciC3Lmg8/5ZxWJs5wq3FnLHIfJXcg4kZI/G7xjDrSZ1lxmhMrmaxzp
 M+T1byEFlHYTLP2xXFWOeerTe4lM56p/Vb6XfUOFQocjJ2hr0cUOWqjHK6Q/8ne1rFeF
 NaMfGPY4KgtaxvAuHkKU+cLsFTqnEidZshvF6aLXnEUhTF/5o8zqquCTw/gA/ewPgjSc
 D8Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wJEO2wGMQKJV/ohpKPyAeBTsL/tteXWNt2JClbfnv8c=;
 b=gHzXkb/ZxQ5LP65HQRq/53ZdFzyBvY+GfKiv/JSnmfDTpQ/U1b2/ZsAYMezMN4cDyU
 DPzslP1c3J+cVzXoEIIytxs6d5SUkKXQYntNTQft/TUjt8PYaEOEQADY8BodHTEVk6Vb
 7rDZqyjdUQqcGGzoLtrwyrMow+zioUpWTYbj3X1RHQCZwu9AMtTSetucwMj8tfCMIlZ1
 qcx54I2yORLdlX+eiYg8a2exbc1Qu6+uCzKpn1VS56j/+JQnRA0v2RNBMDBpJXZ577RC
 TGU9+SFaK2oRyTQ8QS1BMYGd0QZbz6MjLvrws/CrtlGKMLEp7hfSwnHenuiKVBa5j9nn
 ChwQ==
X-Gm-Message-State: APjAAAXmJYF+y4ftS8jO5zMtKzpkgsJnmzw6ra/MGAwhvtLPhydxTE/1
 2v6N+yETsZaJOU/yKIKPQRxMOSrfORE=
X-Google-Smtp-Source: APXvYqzlm14hWoLEfV7e/xmB5v83nE004rAs1AaeVedhH+3dB2RLdVHTcdGRZz9kN8UXW3zOzeuYcQ==
X-Received: by 2002:aa7:8618:: with SMTP id p24mr8303225pfn.3.1581249302742;
 Sun, 09 Feb 2020 03:55:02 -0800 (PST)
Received: from localhost.localdomain
 ([2402:3a80:166e:dca2:8d98:ad42:3c3b:8544])
 by smtp.gmail.com with ESMTPSA id y6sm8947429pgc.10.2020.02.09.03.54.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2020 03:55:02 -0800 (PST)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sun,  9 Feb 2020 17:24:18 +0530
Message-Id: <20200209115419.32337-3-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200209115419.32337-1-jaskaransingh7654321@gmail.com>
References: <20200209115419.32337-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 09 Feb 2020 12:55:06 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 09 Feb 2020 12:55:04 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v3 2/3] tests: Add space between * and const in
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
