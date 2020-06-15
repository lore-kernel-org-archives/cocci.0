Return-Path: <SRS0=AA88=74=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F4DBC433DF
	for <cocci@archiver.kernel.org>; Mon, 15 Jun 2020 13:02:45 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCE9B206B7
	for <cocci@archiver.kernel.org>; Mon, 15 Jun 2020 13:02:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCE9B206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 05FD2g7C026402;
	Mon, 15 Jun 2020 15:02:42 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 3BF6A7577;
	Mon, 15 Jun 2020 15:02:42 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 86159402B
 for <cocci@systeme.lip6.fr>; Mon, 15 Jun 2020 15:02:40 +0200 (CEST)
Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com
 [209.85.208.194])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 05FD2dMg001638
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 15 Jun 2020 15:02:39 +0200 (CEST)
Received: by mail-lj1-f194.google.com with SMTP id i27so19030110ljb.12
 for <cocci@systeme.lip6.fr>; Mon, 15 Jun 2020 06:02:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/9kSSTxyPh85kVvOo6maTc8rLC2WWVwxqEzTRiJwKx0=;
 b=rnmBRzqLgXLfw5ebvCOImgZrcudonEbj8Km1rDVyNtYinE4tFAiHIvJ2LfkGL7zOwC
 o833LzRkOh7m9XlxRXQIAMVl9Tq+L7kidVdZJoC2gBEb8sENmlyusZ5bYfYuEIs0imL5
 4niA6/KTaKFU1VgsoItpRTM71zvvJDdqkwaIxKInNAQjROLaG+AXfBirFanEyTi76xWG
 H0gBAfgH2Sa+avv9JdISYZtscH8D9Q4z3epFKi7oiEquHsY0kUVR9bh4NU7eex/1QT0Q
 rfJ/Yv8GhzX9QQ+g0TqZAx4OXjsIiSc8RvQilWVQflOaZL2LEOqqXZ2fGJ6CQ87K9Nn/
 GPKA==
X-Gm-Message-State: AOAM53023ZG1A0WtMES6W/SzM01xsuQYvEEdUPtz2lKlLxw36jzX60Hh
 Zfm1DfnmsYUPd5Q5BglhyeQ=
X-Google-Smtp-Source: ABdhPJyK1JHuTlXvPOFk8NgbU1HL0MIpvqofgxnk8qHo3E7yCHzViANb2kLHco5d6KxHNPWsXWVcfA==
X-Received: by 2002:a2e:8043:: with SMTP id p3mr11906174ljg.217.1592226159211; 
 Mon, 15 Jun 2020 06:02:39 -0700 (PDT)
Received: from localhost.localdomain (broadband-37-110-38-130.ip.moscow.rt.ru.
 [37.110.38.130])
 by smtp.googlemail.com with ESMTPSA id f19sm4548072lfk.24.2020.06.15.06.02.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2020 06:02:38 -0700 (PDT)
From: Denis Efremov <efremov@linux.com>
To: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Mon, 15 Jun 2020 16:02:42 +0300
Message-Id: <20200615130242.11825-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 15 Jun 2020 15:02:42 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 15 Jun 2020 15:02:40 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: linux-kernel@vger.kernel.org, cocci@systeme.lip6.fr
Subject: [Cocci] [PATCH] coccinelle: api: add device_attr_show script
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

According to the documentation[1] show() methods of device attributes
should return the number of bytes printed into the buffer. This is
the return value of scnprintf(). show() must not use snprintf()
when formatting the value to be returned to user space. snprintf()
returns the length the resulting string would be, assuming it all
fit into the destination array[2]. scnprintf() return the length of
the string actually created in buf. If one can guarantee that an
overflow will never happen sprintf() can be used otherwise scnprintf().

[1] Documentation/filesystems/sysfs.txt
[2] "snprintf() confusion" https://lwn.net/Articles/69419/

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 scripts/coccinelle/api/device_attr_show.cocci | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 scripts/coccinelle/api/device_attr_show.cocci

diff --git a/scripts/coccinelle/api/device_attr_show.cocci b/scripts/coccinelle/api/device_attr_show.cocci
new file mode 100644
index 000000000000..d8ec4bb8ac41
--- /dev/null
+++ b/scripts/coccinelle/api/device_attr_show.cocci
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0-only
+///
+/// From Documentation/filesystems/sysfs.txt:
+///  show() must not use snprintf() when formatting the value to be
+///  returned to user space. If you can guarantee that an overflow
+///  will never happen you can use sprintf() otherwise you must use
+///  scnprintf().
+///
+// Confidence: High
+// Copyright: (C) 2020 Denis Efremov ISPRAS
+// Options: --no-includes --include-headers
+//
+
+virtual report
+virtual org
+virtual context
+virtual patch
+
+@r depends on !patch@
+identifier show, dev, attr, buf;
+position p;
+@@
+
+ssize_t show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	<...
+*	return snprintf@p(...);
+	...>
+}
+
+@rp depends on patch@
+identifier show, dev, attr, buf;
+@@
+
+ssize_t show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	<...
+	return
+-		snprintf
++		scnprintf
+			(...);
+	...>
+}
+
+@script: python depends on report@
+p << r.p;
+@@
+
+coccilib.report.print_report(p[0], "WARNING: use scnprintf or sprintf")
+
+@script: python depends on org@
+p << r.p;
+@@
+
+coccilib.org.print_todo(p[0], "WARNING: use scnprintf or sprintf")
-- 
2.26.2

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
