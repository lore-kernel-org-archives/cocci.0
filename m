Return-Path: <SRS0=R2Y6=A7=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876FAC433E7
	for <cocci@archiver.kernel.org>; Mon, 20 Jul 2020 16:23:18 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FDC52073A
	for <cocci@archiver.kernel.org>; Mon, 20 Jul 2020 16:23:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FDC52073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 06KGN39i013710;
	Mon, 20 Jul 2020 18:23:03 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 042A97775;
	Mon, 20 Jul 2020 18:23:03 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7588844A7
 for <cocci@systeme.lip6.fr>; Mon, 20 Jul 2020 18:23:01 +0200 (CEST)
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com
 [209.85.208.196])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 06KGN0sT024961
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 20 Jul 2020 18:23:00 +0200 (CEST)
Received: by mail-lj1-f196.google.com with SMTP id h22so20885135lji.9
 for <cocci@systeme.lip6.fr>; Mon, 20 Jul 2020 09:23:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+wuyYMorTCCTA+H9Rs20Q97XbYGdbTwxjgGpl65WNYw=;
 b=Rv3g6OCeO8MXE+RHhQuj/V4uaSDVvx9DtfmJoEG9N3KGZf/Jtov/j+fmVeLhdvtlHt
 rXlu4JohARtgZuSX+BE9fTMKPATRGjWTEROGC+JYHnMUF/pIUc8GNIwIJotoJpFgGUBe
 SPpNIZjN0KiYMoUpT8OA6yBU6TlxEWtimJkrRCse8LxDv1KoI/gH1lTsMM2N5JHaRLmb
 +pUKTw3f0bm7CWXt0V3FtzJraPK9XqL9JsEhhgFdmG37O3DeDXAjbtf38mkNn37kBbcN
 TNUviAo6dXxFdUPZEJtOLI5qcnHXkqggnAcyLkvW8jJdGkNAhih817DrRTeIu4+lKFiS
 xxWQ==
X-Gm-Message-State: AOAM531jSSRRwuSM0ILz0z1gaRVl45tME6rQqudXHSJO6l5zgs2i5fFM
 5NqmLx9CbCISeufqT22e0EI=
X-Google-Smtp-Source: ABdhPJwtuvD0JnLUZ74IJSS/UopcAkQaN3dcV/vkq3tMTs874syqhMAmZqLdcLgbz57nt9UeIk+bUQ==
X-Received: by 2002:a2e:7a03:: with SMTP id v3mr11527773ljc.141.1595262180283; 
 Mon, 20 Jul 2020 09:23:00 -0700 (PDT)
Received: from localhost.localdomain (broadband-37-110-38-130.ip.moscow.rt.ru.
 [37.110.38.130])
 by smtp.googlemail.com with ESMTPSA id a19sm925855lff.25.2020.07.20.09.22.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2020 09:22:59 -0700 (PDT)
From: Denis Efremov <efremov@linux.com>
To: Julia Lawall <julia.lawall@inria.fr>
Date: Mon, 20 Jul 2020 19:22:14 +0300
Message-Id: <20200720162216.13248-2-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200720162216.13248-1-efremov@linux.com>
References: <20200720162216.13248-1-efremov@linux.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 20 Jul 2020 18:23:03 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 20 Jul 2020 18:23:01 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: [Cocci] [PATCH v3 1/3] coccinelle: api: extend memdup_user
	transformation with GFP_USER
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

Match GFP_USER and optional __GFP_NOWARN allocations with
memdup_user.cocci rule.
Commit 6c2c97a24f09 ("memdup_user(): switch to GFP_USER") switched
memdup_user() from GFP_KERNEL to GFP_USER. In almost all cases it
is still a good idea to recommend memdup_user() for GFP_KERNEL
allocations. The motivation behind altering memdup_user() to GFP_USER:
https://lkml.org/lkml/2018/1/6/333

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 scripts/coccinelle/api/memdup_user.cocci | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/scripts/coccinelle/api/memdup_user.cocci b/scripts/coccinelle/api/memdup_user.cocci
index c809ab10bbce..0e29d41ecab8 100644
--- a/scripts/coccinelle/api/memdup_user.cocci
+++ b/scripts/coccinelle/api/memdup_user.cocci
@@ -20,7 +20,9 @@ expression from,to,size;
 identifier l1,l2;
 @@
 
--  to = \(kmalloc\|kzalloc\)(size,GFP_KERNEL);
+-  to = \(kmalloc\|kzalloc\)
+-		(size,\(GFP_KERNEL\|GFP_USER\|
+-		      \(GFP_KERNEL\|GFP_USER\)|__GFP_NOWARN\));
 +  to = memdup_user(from,size);
    if (
 -      to==NULL
@@ -43,7 +45,9 @@ position p;
 statement S1,S2;
 @@
 
-*  to = \(kmalloc@p\|kzalloc@p\)(size,GFP_KERNEL);
+*  to = \(kmalloc@p\|kzalloc@p\)
+		(size,\(GFP_KERNEL\|GFP_USER\|
+		      \(GFP_KERNEL\|GFP_USER\)|__GFP_NOWARN\));
    if (to==NULL || ...) S1
    if (copy_from_user(to, from, size) != 0)
    S2
-- 
2.26.2

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
