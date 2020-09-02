Return-Path: <SRS0=bt/u=CL=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE01FC433E6
	for <cocci@archiver.kernel.org>; Wed,  2 Sep 2020 04:41:55 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 505FC20758
	for <cocci@archiver.kernel.org>; Wed,  2 Sep 2020 04:41:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 505FC20758
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0824fXZd027010;
	Wed, 2 Sep 2020 06:41:33 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id C9DDC742E;
	Wed,  2 Sep 2020 06:41:33 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 31A213F6C
 for <cocci@systeme.lip6.fr>; Wed,  2 Sep 2020 06:41:32 +0200 (CEST)
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com
 [209.85.208.193])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 0824fVli022998
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Wed, 2 Sep 2020 06:41:31 +0200 (CEST)
Received: by mail-lj1-f193.google.com with SMTP id t23so4247246ljc.3
 for <cocci@systeme.lip6.fr>; Tue, 01 Sep 2020 21:41:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CNQ+uOSUaXPsAHOE4jBatrY5v8vedinhiQESkHIW8co=;
 b=tANRYHK+BOwrQkaoPALWvjkY3N/KKnfoF6TfXUG3MyurlwzGV/k3GpAubiKj5xWBq2
 EvTvfJrYxR+oYSo0OES1tQAaEwVpGTqKSlxVommBdIfHWnuXlv8dPcBhCmrH+zWc3Vzd
 n5Od8wdSThHqAb4c8OUvVXsCvOSskiVVvptA+m4Q0LgM+EgDmFVxgPs2agW4FtvaxbTc
 5I3Es7zgdQPvjmwwGjC6Ou2BcTs5skhJB0JUd0Jzyx8jF1DcRzYNDwPnl0EZSm80Pm8c
 W0xrBkf3a7goO9npGl4MTsiTHuqtixyO20FlT+iIAoLZ0cW3ou0QPcxRC7fmFgRfr21f
 7L3w==
X-Gm-Message-State: AOAM532BC9rFWcztID7H4oYLmS/QSws3UXyplEMYeNp2wUT6RsfEaUv3
 c8YZwHCoCxJepLaTFnDwBs4=
X-Google-Smtp-Source: ABdhPJxfgSnF1CLTWj3u4dHFE+w+eNMO9yzG4J3SAAiH1jhnncu2lyxxvtzRku/oPsswKDk/3fPk9Q==
X-Received: by 2002:a05:651c:310:: with SMTP id
 a16mr2180211ljp.250.1599021691194; 
 Tue, 01 Sep 2020 21:41:31 -0700 (PDT)
Received: from localhost.localdomain (broadband-37-110-38-130.ip.moscow.rt.ru.
 [37.110.38.130])
 by smtp.googlemail.com with ESMTPSA id i26sm704823ljj.102.2020.09.01.21.41.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 21:41:30 -0700 (PDT)
From: Denis Efremov <efremov@linux.com>
To: Julia Lawall <julia.lawall@inria.fr>
Date: Wed,  2 Sep 2020 07:40:59 +0300
Message-Id: <20200902044059.7133-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 02 Sep 2020 06:41:34 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 02 Sep 2020 06:41:31 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: [Cocci] [PATCH] coccinelle: ifnullfree: add vfree(),
	kvfree*() functions
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

Extend the list of free functions with kvfree(), kvfree_sensitive(),
vfree().

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 scripts/coccinelle/free/ifnullfree.cocci | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/scripts/coccinelle/free/ifnullfree.cocci b/scripts/coccinelle/free/ifnullfree.cocci
index 2045391e36a0..285b92d5c665 100644
--- a/scripts/coccinelle/free/ifnullfree.cocci
+++ b/scripts/coccinelle/free/ifnullfree.cocci
@@ -20,8 +20,14 @@ expression E;
 - if (E != NULL)
 (
   kfree(E);
+|
+  kvfree(E);
 |
   kfree_sensitive(E);
+|
+  kvfree_sensitive(E, ...);
+|
+  vfree(E);
 |
   debugfs_remove(E);
 |
@@ -42,9 +48,10 @@ position p;
 @@
 
 * if (E != NULL)
-*	\(kfree@p\|kfree_sensitive@p\|debugfs_remove@p\|debugfs_remove_recursive@p\|
+*	\(kfree@p\|kvfree@p\|kfree_sensitive@p\|kvfree_sensitive@p\|vfree@p\|
+*         debugfs_remove@p\|debugfs_remove_recursive@p\|
 *         usb_free_urb@p\|kmem_cache_destroy@p\|mempool_destroy@p\|
-*         dma_pool_destroy@p\)(E);
+*         dma_pool_destroy@p\)(E, ...);
 
 @script:python depends on org@
 p << r.p;
-- 
2.26.2

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
