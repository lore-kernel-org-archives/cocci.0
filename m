Return-Path: <SRS0=eOls=DQ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47862C433E7
	for <cocci@archiver.kernel.org>; Fri,  9 Oct 2020 12:55:51 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F8E7222BA
	for <cocci@archiver.kernel.org>; Fri,  9 Oct 2020 12:55:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F8E7222BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 099CtWn5015999;
	Fri, 9 Oct 2020 14:55:32 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 06D65769A;
	Fri,  9 Oct 2020 14:55:32 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id DC15F74CE
 for <cocci@systeme.lip6.fr>; Fri,  9 Oct 2020 14:55:29 +0200 (CEST)
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com
 [209.85.167.67])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 099CtSfs020488
 for <cocci@systeme.lip6.fr>; Fri, 9 Oct 2020 14:55:28 +0200 (CEST)
Received: by mail-lf1-f67.google.com with SMTP id l2so10617185lfk.0
 for <cocci@systeme.lip6.fr>; Fri, 09 Oct 2020 05:55:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vaa2gki9lHlNHOZf+n4diLXX/JkJWpxYyjzMUffhof0=;
 b=VHmUS3tfS3Qg9p0B58MzS++e94ccH/i/Jqzn2W6yICf0UHWuvH9VJhGMjkCMg3JwiD
 v9/LPFI70gm40xlicy3HyOJur/ztkQat9M2WMskpag7kOuBmfTHjfNV+5ixCLN5TrjRs
 L4hc2pSemcsPC0z0+TTpRn2KN/fguB5kEzhWfEeTdWlYOgDREJPZounaLoNSSY6xKlw9
 j6Y2lYopF2bNnlfDUYHU0tobIxqIjbMGVP+2ZG9U5hLftpGTg8QqRkhIJnyFYNyAYGmL
 4VH17TrzfzW8dAPHJmbRnFFTKWiDZz9OAUFCMe19kniE3Hnur1gCVZzAklQlUUrk4yT2
 vfLQ==
X-Gm-Message-State: AOAM530K+9OkCH90tV4Q3eywJlFJXDau566qXoLZPD1B91USj4Mr+kwn
 TlBvraZwyaVDrWhCMd7/Ra8=
X-Google-Smtp-Source: ABdhPJz1uv7MF9SZwcCxoq4RFK+tbdV76yVtzdEs/H/O5j14hy0E1eruWWPcP9ZSTrMpAnaDRbMa+Q==
X-Received: by 2002:a05:6512:512:: with SMTP id
 o18mr4643809lfb.328.1602248128518; 
 Fri, 09 Oct 2020 05:55:28 -0700 (PDT)
Received: from localhost.localdomain (broadband-37-110-38-130.ip.moscow.rt.ru.
 [37.110.38.130])
 by smtp.googlemail.com with ESMTPSA id t21sm1538684ljh.65.2020.10.09.05.55.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2020 05:55:27 -0700 (PDT)
From: Denis Efremov <efremov@linux.com>
To: julia.lawall@inria.fr
Date: Fri,  9 Oct 2020 15:54:53 +0300
Message-Id: <20201009125453.31217-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 09 Oct 2020 14:55:32 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 09 Oct 2020 14:55:28 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: [Cocci] [PATCH] coccinelle: api: kfree_sensitive: print memset
	position
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

Print memset() call position in addition to the kfree() position to
ease issues identification.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 scripts/coccinelle/api/kfree_sensitive.cocci | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/scripts/coccinelle/api/kfree_sensitive.cocci b/scripts/coccinelle/api/kfree_sensitive.cocci
index e4a066a0b77d..8d980ebf3223 100644
--- a/scripts/coccinelle/api/kfree_sensitive.cocci
+++ b/scripts/coccinelle/api/kfree_sensitive.cocci
@@ -85,14 +85,16 @@ type T;
 
 @script:python depends on report@
 p << r.p;
+m << r.m;
 @@
 
-coccilib.report.print_report(p[0],
-  "WARNING: opportunity for kfree_sensitive/kvfree_sensitive")
+msg = "WARNING opportunity for kfree_sensitive/kvfree_sensitive (memset at line %s)"
+coccilib.report.print_report(p[0], msg % (m[0].line))
 
 @script:python depends on org@
 p << r.p;
+m << r.m;
 @@
 
-coccilib.org.print_todo(p[0],
-  "WARNING: opportunity for kfree_sensitive/kvfree_sensitive")
+msg = "WARNING opportunity for kfree_sensitive/kvfree_sensitive (memset at line %s)"
+coccilib.org.print_todo(p[0], msg % (m[0].line))
-- 
2.26.2

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
