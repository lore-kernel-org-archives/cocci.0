Return-Path: <SRS0=02ua=7V=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2783C433DF
	for <cocci@archiver.kernel.org>; Mon,  8 Jun 2020 15:01:19 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5658E206C3
	for <cocci@archiver.kernel.org>; Mon,  8 Jun 2020 15:01:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5658E206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 058F1GlD012623;
	Mon, 8 Jun 2020 17:01:16 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id C74E97783;
	Mon,  8 Jun 2020 17:01:16 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id F3EA344A7
 for <cocci@systeme.lip6.fr>; Mon,  8 Jun 2020 17:01:15 +0200 (CEST)
Received: from mail-lj1-f195.google.com (mail-lj1-f195.google.com
 [209.85.208.195])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 058F1FSj028319
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 8 Jun 2020 17:01:15 +0200 (CEST)
Received: by mail-lj1-f195.google.com with SMTP id e4so20931217ljn.4
 for <cocci@systeme.lip6.fr>; Mon, 08 Jun 2020 08:01:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vbJ+Z5OJLPEUwZaiWYpSggd91RUgnOqEf/ZiRyDdXKM=;
 b=Cax+Sv2LCwP/EmZdGh0pLlQO6LAMPQ3PZMU60OMrLTpr+nO3xzfYuO969ZKpD46mBx
 zDR6I1K5IGbXqBfvA2v/YxWdbj1qkhcA3yv9X1mUXteF/2eCh7mi9q8Ug64ydRsuDu8n
 /qBU4HzfIAFUFOcLXT2VcYtRU4Suf4fKNVrBdZY3XwcEigyRP7ikB9347jKDXK0ev9OH
 xBfc3VC+rCrcVJO1PJCkDm+9Knfm5PQ+KwimuLxiq3rAObnSi+kxAVGaQYgenYinFbWp
 Lysaptu6VlKXzeNo5iEVuHx8lr44nGvYX388uv3wJww47IMzFverbG9bWyC6KYrhyuqa
 MmHw==
X-Gm-Message-State: AOAM5306K/OD9GnFOroEpWGaTLY8Vrx1bvKrZ49mXvLGFV77/dKOxXCE
 1Qt6aJkcGBZkb8M/bBdzAoM=
X-Google-Smtp-Source: ABdhPJzfzOMQjNBSsSPjaGFOHCOPEONcFWMdYszGjD9HW0FH6aBQCKJXjWPfKgO/l/Mw0S1rvulsug==
X-Received: by 2002:a2e:978a:: with SMTP id y10mr9281752lji.115.1591628474737; 
 Mon, 08 Jun 2020 08:01:14 -0700 (PDT)
Received: from localhost.localdomain ([213.87.137.116])
 by smtp.googlemail.com with ESMTPSA id r16sm279228ljn.106.2020.06.08.08.01.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 08:01:14 -0700 (PDT)
From: Denis Efremov <efremov@linux.com>
To: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Mon,  8 Jun 2020 18:00:35 +0300
Message-Id: <20200608150038.223747-2-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200608150038.223747-1-efremov@linux.com>
References: <20200608150038.223747-1-efremov@linux.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 08 Jun 2020 17:01:17 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 08 Jun 2020 17:01:15 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: linux-kernel@vger.kernel.org, cocci@systeme.lip6.fr
Subject: [Cocci] [PATCH v2 1/4] coccinelle: api: extend memdup_user
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
index c809ab10bbce..cadcc2e87881 100644
--- a/scripts/coccinelle/api/memdup_user.cocci
+++ b/scripts/coccinelle/api/memdup_user.cocci
@@ -20,7 +20,9 @@ expression from,to,size;
 identifier l1,l2;
 @@
 
--  to = \(kmalloc\|kzalloc\)(size,GFP_KERNEL);
+-  to = \(kmalloc\|kzalloc\)
+		(size,\(GFP_KERNEL\|GFP_USER\|
+		      \(GFP_KERNEL\|GFP_USER\)|__GFP_NOWARN\));
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
