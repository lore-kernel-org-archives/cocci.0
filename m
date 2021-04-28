Return-Path: <SRS0=OWXH=JZ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F052FC433ED
	for <cocci@archiver.kernel.org>; Wed, 28 Apr 2021 06:04:10 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5500F613EE
	for <cocci@archiver.kernel.org>; Wed, 28 Apr 2021 06:04:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5500F613EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 13S643eQ022195;
	Wed, 28 Apr 2021 08:04:03 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id BFA7E7634;
	Wed, 28 Apr 2021 08:04:03 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 63AD574DE
 for <cocci@systeme.lip6.fr>; Wed, 28 Apr 2021 08:04:02 +0200 (CEST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com
 [209.85.167.45])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 13S641MG011417
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Wed, 28 Apr 2021 08:04:02 +0200 (CEST)
Received: by mail-lf1-f45.google.com with SMTP id 12so97001880lfq.13
 for <cocci@systeme.lip6.fr>; Tue, 27 Apr 2021 23:04:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=cvKqJAsDp0hVwDeBdNNZxr3x2/ARRj4tE0SxrkqqX3k=;
 b=N2b55lgBsIYCT3wLxLjr84KU7/5sUMTWUQjCX0Y4Wc0/EZLzQIupH28jU66NGe1nBw
 m32WLt5CBAplqgkea67wDLCaZ6qKSYTPXBXEcrL89BvW3MGj8hLPW3FhwPnNsmemgo80
 doei69RjM5MSOlC/LVON5MQUa8rL06uETOEm/Xyf+wnrRvhD2GUW8cgQBeOpl/lD4SvG
 Hv1mCYv1pNMpImYiJByy9lbknoPnFDu3wzOm3s1nwa1qmFr2KGpaOIzW0OiSbZXKhyS/
 hK0vJsX3ksELHx1NZh2qa0wy2f/FiS2siPDKvzpU7CenTWSJGmlGroLprS986WhN61i+
 UR2A==
X-Gm-Message-State: AOAM530CYA+d7ANB4B7mj+YgiSoAJzxWJn74oGQTFT3yoWAf6YEvNd9D
 eEJh6Ou9jWkZxhDH0gIRyMU=
X-Google-Smtp-Source: ABdhPJw/nA6FH2uObm/AiJzOWE/0qdvWWBNoTXCn5Zk44FXeMnRESfOreomZJGLVLPz2Os3MNmty8w==
X-Received: by 2002:a05:6512:717:: with SMTP id
 b23mr6357504lfs.210.1619589841375; 
 Tue, 27 Apr 2021 23:04:01 -0700 (PDT)
Received: from black.localdomain (broadband-188-32-236-56.ip.moscow.rt.ru.
 [188.32.236.56])
 by smtp.googlemail.com with ESMTPSA id b29sm943745ljf.87.2021.04.27.23.04.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Apr 2021 23:04:00 -0700 (PDT)
From: Denis Efremov <efremov@linux.com>
To: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Wed, 28 Apr 2021 09:03:50 +0300
Message-Id: <20210428060350.57661-1-efremov@linux.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 28 Apr 2021 08:04:04 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 28 Apr 2021 08:04:02 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: [Cocci] [RESEND PATCH] coccinelle: misc: minmax: suppress patch
	generation for err returns
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

There is a standard idiom for "if 'ret' holds an error, return it":
	return ret < 0 ? ret : 0;

Developers prefer to keep the things as they are because stylistic
change to "return min(ret, 0);" breaks readability.

Let's suppress automatic generation for this type of patches.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 scripts/coccinelle/misc/minmax.cocci | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/scripts/coccinelle/misc/minmax.cocci b/scripts/coccinelle/misc/minmax.cocci
index eccdd3eb3452..fcf908b34f27 100644
--- a/scripts/coccinelle/misc/minmax.cocci
+++ b/scripts/coccinelle/misc/minmax.cocci
@@ -116,16 +116,32 @@ func(...)
 	...>
 }
 
+// Don't generate patches for errcode returns.
+@errcode depends on patch@
+position p;
+identifier func;
+expression x;
+binary operator cmp = {<, <=};
+@@
+
+func(...)
+{
+	<...
+	return ((x) cmp@p 0 ? (x) : 0);
+	...>
+}
+
 @pmin depends on patch@
 identifier func;
 expression x, y;
 binary operator cmp = {<=, <};
+position p != errcode.p;
 @@
 
 func(...)
 {
 	<...
--	((x) cmp (y) ? (x) : (y))
+-	((x) cmp@p (y) ? (x) : (y))
 +	min(x, y)
 	...>
 }
-- 
2.30.2

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
