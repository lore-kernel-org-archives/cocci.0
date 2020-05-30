Return-Path: <SRS0=5T8e=7M=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2887BC433DF
	for <cocci@archiver.kernel.org>; Sat, 30 May 2020 20:54:34 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C34412074D
	for <cocci@archiver.kernel.org>; Sat, 30 May 2020 20:54:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C34412074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04UKsVGF020869;
	Sat, 30 May 2020 22:54:31 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 5B7F43E1D;
	Sat, 30 May 2020 22:54:31 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id A3AF23C89
 for <cocci@systeme.lip6.fr>; Sat, 30 May 2020 22:54:29 +0200 (CEST)
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com
 [209.85.167.67])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04UKsSbk020768
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sat, 30 May 2020 22:54:29 +0200 (CEST)
Received: by mail-lf1-f67.google.com with SMTP id w15so1689548lfe.11
 for <cocci@systeme.lip6.fr>; Sat, 30 May 2020 13:54:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=x1LVz2RKLdTewPVi7JzuKq6wTk2wWGIzWE4uj9Rz3Oo=;
 b=NP/D6XYGKhpcLr4iIs9xSGWPwa4FgDAMTC5VRXmQXO/XjTjwsgUi2CiViq1p8O+RXl
 TUTcMYIrD02I3pNXdyE/B70C+CExSjU4uqp7rnLw8249GF1MrxeiDfnHEduwfwwey3CP
 ORCo49pWgPph31oDPZVeJX9dSMkG6X5zf3R5rNpRIeI2ZsOllR040btGyd3wh2KOb8NY
 urQFXF8YvoiJTzjI8EtqeMSv74RS6d+6h075Fsm8uhHLMUL+qGhFbHhskb8qAqsMkyrz
 VFMTGYGpWpmaDMcmTM4dB0loMX+KMVOeBG8tI9trm+9sReARgLs1eOchMoCvUy352Q2Y
 A89w==
X-Gm-Message-State: AOAM532Ju3TChHOLB7y3zvWvnrXpkm2aDUJhWQxfBcQRrmvJwRXjAy74
 TsCGLh5pS1gqa3z7urA8M7E=
X-Google-Smtp-Source: ABdhPJy80CEmSIpmFE4qQC/NX9BXx1VXOkCwwIEjYO9wC7axPGWRTs6T7T71Vum0XD0dGpz+JcQCFQ==
X-Received: by 2002:ac2:48a3:: with SMTP id u3mr7595076lfg.115.1590872068706; 
 Sat, 30 May 2020 13:54:28 -0700 (PDT)
Received: from localhost.localdomain ([213.87.147.196])
 by smtp.googlemail.com with ESMTPSA id f6sm2816670ljn.91.2020.05.30.13.54.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2020 13:54:28 -0700 (PDT)
From: Denis Efremov <efremov@linux.com>
To: Julia Lawall <Julia.Lawall@lip6.fr>, Joe Perches <joe@perches.com>
Date: Sat, 30 May 2020 23:53:47 +0300
Message-Id: <20200530205348.5812-2-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200530205348.5812-1-efremov@linux.com>
References: <20200530205348.5812-1-efremov@linux.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 30 May 2020 22:54:31 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 30 May 2020 22:54:29 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: [Cocci] [PATCH 1/2] Coccinelle: extend memdup_user transformation
	with GFP_USER
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

Match GFP_USER allocations with memdup_user.cocci rule.
Commit 6c2c97a24f09 ("memdup_user(): switch to GFP_USER") switched
memdup_user() from GFP_KERNEL to GFP_USER. In most cases it is still
a good idea to use memdup_user() for GFP_KERNEL allocations. The
motivation behind altering memdup_user() to GFP_USER is here:
https://lkml.org/lkml/2018/1/6/333

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 scripts/coccinelle/api/memdup_user.cocci | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/coccinelle/api/memdup_user.cocci b/scripts/coccinelle/api/memdup_user.cocci
index c809ab10bbce..49f487e6a5c8 100644
--- a/scripts/coccinelle/api/memdup_user.cocci
+++ b/scripts/coccinelle/api/memdup_user.cocci
@@ -20,7 +20,7 @@ expression from,to,size;
 identifier l1,l2;
 @@
 
--  to = \(kmalloc\|kzalloc\)(size,GFP_KERNEL);
+-  to = \(kmalloc\|kzalloc\)(size,\(GFP_KERNEL\|GFP_USER\));
 +  to = memdup_user(from,size);
    if (
 -      to==NULL
@@ -43,7 +43,7 @@ position p;
 statement S1,S2;
 @@
 
-*  to = \(kmalloc@p\|kzalloc@p\)(size,GFP_KERNEL);
+*  to = \(kmalloc@p\|kzalloc@p\)(size,\(GFP_KERNEL\|GFP_USER\));
    if (to==NULL || ...) S1
    if (copy_from_user(to, from, size) != 0)
    S2
-- 
2.26.2

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
