Return-Path: <SRS0=LWRJ=AA=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DF3C433DF
	for <cocci@archiver.kernel.org>; Fri, 19 Jun 2020 13:23:52 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B06D820DD4
	for <cocci@archiver.kernel.org>; Fri, 19 Jun 2020 13:23:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B06D820DD4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 05JDNPUj009677;
	Fri, 19 Jun 2020 15:23:25 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B93507577;
	Fri, 19 Jun 2020 15:23:25 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 39BB2438E
 for <cocci@systeme.lip6.fr>; Fri, 19 Jun 2020 15:23:24 +0200 (CEST)
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com
 [209.85.208.193])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 05JDNLMn014275
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 19 Jun 2020 15:23:21 +0200 (CEST)
Received: by mail-lj1-f193.google.com with SMTP id n24so11425630lji.10
 for <cocci@systeme.lip6.fr>; Fri, 19 Jun 2020 06:23:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=E/TRBC6roif3JRfR0eyS1Twcm7a48T8psf0xx78VupM=;
 b=p1ZvXBs9hKfY2jOvj/FgNHIz0APzcU3JFzZMfYAwpo3GUj/syKdvNyv1ALKUSDu2l8
 TQfskWrKGrXttIsNX0ppftGAgjl2d+ruVs4fk84oaE6lFNU2fsTJ7dUc7cGqHrSLKwwK
 XUVpEXqMp1EnTwGcpO2N3Wme+qShsWK6mHUl+iZR2LUv4zvvgd5I8QJ903sgtJRxpJmO
 CEwZxr7hFiEPfUXpfKvEnuyO6IIxOuA/FiYiQobdOYQyMmOXcIBz5/B7vfnC7lVMaMM+
 RIQqaH7lJKfFCnSVLXrWYssA8w/b0xt98A/zzlJ2KrE0eyW/r4erjKIEagMd/L0dEuoL
 WdrA==
X-Gm-Message-State: AOAM533wdfg7wZSew0tdUtd8VMC/Cj/ssOFgrj3PozFAlvefuRqesZHc
 +9SZgfLRiAHQ4VGyh0FT1PE=
X-Google-Smtp-Source: ABdhPJyDmos2erRDWIlEDAeX01T8RHF9cvr8rL7N4KSNa/VmvcUvm8MuMKsymrWUrrHGxoTzj6q3Ng==
X-Received: by 2002:a2e:b615:: with SMTP id r21mr1773433ljn.1.1592573000818;
 Fri, 19 Jun 2020 06:23:20 -0700 (PDT)
Received: from localhost.localdomain ([213.87.137.195])
 by smtp.googlemail.com with ESMTPSA id q11sm1398026lfe.34.2020.06.19.06.23.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2020 06:23:20 -0700 (PDT)
From: Denis Efremov <efremov@linux.com>
To: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Fri, 19 Jun 2020 16:23:07 +0300
Message-Id: <20200619132307.16612-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 19 Jun 2020 15:23:25 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 19 Jun 2020 15:23:21 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: [Cocci] [PATCH] coccinelle: api/kstrdup: fix coccinelle position
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

There is a typo in rule r2. Position p1 should be attached to kzalloc()
call.

Fixes: 29a36d4dec6c ("scripts/coccinelle: improve the coverage of some semantic patches")
Signed-off-by: Denis Efremov <efremov@linux.com>
---
 scripts/coccinelle/api/kstrdup.cocci | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coccinelle/api/kstrdup.cocci b/scripts/coccinelle/api/kstrdup.cocci
index 19f2645e6076..3c6dc5469ee4 100644
--- a/scripts/coccinelle/api/kstrdup.cocci
+++ b/scripts/coccinelle/api/kstrdup.cocci
@@ -66,7 +66,7 @@ position p1,p2;
 
 *   x = strlen(from) + 1;
     ... when != \( x = E1 \| from = E1 \)
-*   to = \(kmalloc@p1\|kzalloc@p2\)(x,flag);
+*   to = \(kmalloc@p1\|kzalloc@p1\)(x,flag);
     ... when != \(x = E2 \| from = E2 \| to = E2 \)
     if (to==NULL || ...) S
     ... when != \(x = E3 \| from = E3 \| to = E3 \)
-- 
2.26.2

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
