Return-Path: <SRS0=5T8e=7M=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B65C433DF
	for <cocci@archiver.kernel.org>; Sat, 30 May 2020 20:54:37 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A60F2076B
	for <cocci@archiver.kernel.org>; Sat, 30 May 2020 20:54:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A60F2076B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04UKsYke026509;
	Sat, 30 May 2020 22:54:34 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B9AB13E1D;
	Sat, 30 May 2020 22:54:34 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id C00D53C89
 for <cocci@systeme.lip6.fr>; Sat, 30 May 2020 22:54:32 +0200 (CEST)
Received: from mail-lj1-f195.google.com (mail-lj1-f195.google.com
 [209.85.208.195])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04UKsWig015842
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sat, 30 May 2020 22:54:32 +0200 (CEST)
Received: by mail-lj1-f195.google.com with SMTP id z18so3427856lji.12
 for <cocci@systeme.lip6.fr>; Sat, 30 May 2020 13:54:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aMfolX8wThjJ39hizZseRxSztCFPO1pn1hg6I+CItf8=;
 b=a3MGXBzAJIa1OIPKXuCoi15/fByFCwYAw/iq43AVK1yKAwpk9bu4Te4mD3SeO8v9sy
 lzuZyj55nS+YtJ6+ZNhVGmQSMoFA5cv11wm2eIs2Rz55+otJZYJ5s6EberXAmkFG4yIz
 DJ/ygcd4er9NBpmTDjVnCZG3q5GApejsNhC/7nLPKsi1IXVf2o1ByV6B0Z8BGLkwdQGK
 s3qkCHgLGX1FLyNZd18p8gtUTfaWrlL0HVZIE5akQkccFzsl57pC+i4UwnSvHjpdk0lh
 fcdpu7YAr8tqnSkJ5jw4sPiLFmvXUwx5B8exR0lMRApv1Za3zuatzgFfUNy+mFcY1zvM
 hTTA==
X-Gm-Message-State: AOAM5326WhgeZf+b1WquG2iF2TMxk9I9cBBATj88Q33BNSSkVg+zoqll
 S7+C6TcV56rVV+krGbIgx0OvGaNv
X-Google-Smtp-Source: ABdhPJxPYaHknn01FnFquKivQn0/VA1YjDLPZh9Tb3gOcaZpaPaTlV6q/zNvgSXIbNVQcvAlBeFFhg==
X-Received: by 2002:a2e:b0f9:: with SMTP id h25mr7425165ljl.18.1590872071790; 
 Sat, 30 May 2020 13:54:31 -0700 (PDT)
Received: from localhost.localdomain ([213.87.147.196])
 by smtp.googlemail.com with ESMTPSA id f6sm2816670ljn.91.2020.05.30.13.54.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2020 13:54:31 -0700 (PDT)
From: Denis Efremov <efremov@linux.com>
To: Julia Lawall <Julia.Lawall@lip6.fr>, Joe Perches <joe@perches.com>
Date: Sat, 30 May 2020 23:53:48 +0300
Message-Id: <20200530205348.5812-3-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200530205348.5812-1-efremov@linux.com>
References: <20200530205348.5812-1-efremov@linux.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 30 May 2020 22:54:34 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 30 May 2020 22:54:32 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: [Cocci] [PATCH 2/2] Coccinelle: extend memdup_user rule with
	vmemdup_user()
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

Add vmemdup_user() transformations to the memdup_user.cocci rule.
Commit 50fd2f298bef ("new primitive: vmemdup_user()") introduced
vmemdup_user(). The function uses kvmalloc with GPF_USER flag.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 scripts/coccinelle/api/memdup_user.cocci | 49 +++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 2 deletions(-)

diff --git a/scripts/coccinelle/api/memdup_user.cocci b/scripts/coccinelle/api/memdup_user.cocci
index 49f487e6a5c8..a50def35136e 100644
--- a/scripts/coccinelle/api/memdup_user.cocci
+++ b/scripts/coccinelle/api/memdup_user.cocci
@@ -37,6 +37,28 @@ identifier l1,l2;
 -    ...+>
 -  }
 
+@depends on patch@
+expression from,to,size;
+identifier l1,l2;
+@@
+
+-  to = \(kvmalloc\|kvzalloc\)(size,\(GFP_KERNEL\|GFP_USER\));
++  to = vmemdup_user(from,size);
+   if (
+-      to==NULL
++      IS_ERR(to)
+                 || ...) {
+   <+... when != goto l1;
+-  -ENOMEM
++  PTR_ERR(to)
+   ...+>
+   }
+-  if (copy_from_user(to, from, size) != 0) {
+-    <+... when != goto l2;
+-    -EFAULT
+-    ...+>
+-  }
+
 @r depends on !patch@
 expression from,to,size;
 position p;
@@ -48,14 +70,37 @@ statement S1,S2;
    if (copy_from_user(to, from, size) != 0)
    S2
 
-@script:python depends on org@
+@rv depends on !patch@
+expression from,to,size;
+position p;
+statement S1,S2;
+@@
+
+*  to = \(kvmalloc@p\|kvzalloc@p\)(size,\(GFP_KERNEL\|GFP_USER\));
+   if (to==NULL || ...) S1
+   if (copy_from_user(to, from, size) != 0)
+   S2
+
+@script:python depends on org && r@
 p << r.p;
 @@
 
 coccilib.org.print_todo(p[0], "WARNING opportunity for memdup_user")
 
-@script:python depends on report@
+@script:python depends on report && r@
 p << r.p;
 @@
 
 coccilib.report.print_report(p[0], "WARNING opportunity for memdup_user")
+
+@script:python depends on org && rv@
+p << rv.p;
+@@
+
+coccilib.org.print_todo(p[0], "WARNING opportunity for vmemdup_user")
+
+@script:python depends on report && rv@
+p << rv.p;
+@@
+
+coccilib.report.print_report(p[0], "WARNING opportunity for vmemdup_user")
-- 
2.26.2

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
