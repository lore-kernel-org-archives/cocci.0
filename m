Return-Path: <SRS0=YRku=BR=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD80C433E0
	for <cocci@archiver.kernel.org>; Fri,  7 Aug 2020 10:55:20 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3310E20866
	for <cocci@archiver.kernel.org>; Fri,  7 Aug 2020 10:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6A9/7dd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3310E20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 077At4D5004596;
	Fri, 7 Aug 2020 12:55:05 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D9C3741F5;
	Fri,  7 Aug 2020 12:55:04 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 3D4934084
 for <cocci@systeme.lip6.fr>; Fri,  7 Aug 2020 12:55:03 +0200 (CEST)
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:441])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 077At1nX002507
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 7 Aug 2020 12:55:02 +0200 (CEST)
Received: by mail-pf1-x441.google.com with SMTP id s26so809451pfm.4
 for <cocci@systeme.lip6.fr>; Fri, 07 Aug 2020 03:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=mQD91896fqSImQlNI/D1wRvbkGKkNIM/QmIoYxf+jig=;
 b=E6A9/7ddfeasTHEroC50Tvr1p4SczIVGHSmEQP35KNoOMEWeViQ/KRuUNFmwVJjmmt
 lBYJWIovym8wP5YXZI9Gc7myabHnIwmWMzmdHQ/+6fUttIFuxqRmyJ+8Pn/OvjRoZOa/
 rIbc9ocpWC/TG3Te9WP4Gl/8M3egRw+A2/imnI+c7jBkh0C98bn3PvoRovk4yWuy5EsS
 qYBcog7ya1aTvmi1jyqk3e7+Z3AtD28UZf5+XLrgR/moQPCu+mmK0+D9/ZW6P1o4nD09
 iFuvxiD05YdkygG+mZSvIb4esjtQq/7Ur6MW1BhMW/CixkKj8cnv8G/uQv7JtFpTVfjp
 ndVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=mQD91896fqSImQlNI/D1wRvbkGKkNIM/QmIoYxf+jig=;
 b=XoiLEB6c6skuaKIx+wPOuJMnZB5+8xP37UcBrD/9DLqFbXVoSGE88j8B99nXcaObKZ
 KcyYwXU+yZILe8gSUuJnyyS+fBOoR4TU5Yy9t4zQX8i4XZdR/tQz8yQkJ+7mb+oDpuE6
 1arYRK32iH1Ovf0ZDO3kMPrenjhaYvIzi4wIWkljlGTwy37U5ksUlrsh0MBMhL+h+vG1
 59wV5g7/+oHDwqa4p0tcNoFwiEOyZ/X5u1gtFHvIEdO0brLqPYK6NnBG2Yyo9Sz5gttP
 SlQ1c/C+hdIA5MgeAKzHFuM28dqLdKgkYEJcgAi7UzV4YhGkAOTwNrA+NfF9O4O+eZsC
 poPg==
X-Gm-Message-State: AOAM531H27zcspKIKjrc8kMBZcd0AphlMKC/rXEKT2vnVkRyKJZEeh9n
 JjGEyT9GO5mIStkk3SwTqyw=
X-Google-Smtp-Source: ABdhPJz0u2aQIMgnqf737ni1/xJSYiS47HjMakimVVtVcxfHQwGSLfzd2KgUIPPEfrfN0lt8zzOgSQ==
X-Received: by 2002:a63:f04d:: with SMTP id s13mr10884524pgj.100.1596797700866; 
 Fri, 07 Aug 2020 03:55:00 -0700 (PDT)
Received: from localhost.localdomain ([106.51.107.165])
 by smtp.gmail.com with ESMTPSA id w2sm10221548pjt.19.2020.08.07.03.54.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2020 03:55:00 -0700 (PDT)
From: Sumera Priyadarsini <sylphrenadin@gmail.com>
To: Julia.Lawall@lip6.fr
Date: Fri,  7 Aug 2020 16:24:45 +0530
Message-Id: <20200807105445.16712-1-sylphrenadin@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 07 Aug 2020 12:55:05 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 07 Aug 2020 12:55:02 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: michal.lkml@markovi.net, linux-doc@vger.kernel.org, corbet@lwn.net,
        gregkh@linuxfoundation.org, Gilles.Muller@lip6.fr,
        nicolas.palix@imag.fr, cocci@systeme.lip6.fr
Subject: [Cocci] [PATCH] documentation: coccinelle: Improve command example
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

This patch modifies the coccinelle documentation to add further
description for the usage of the C variable flags by coccicheck.

Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
---
 Documentation/dev-tools/coccinelle.rst | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/coccinelle.rst b/Documentation/dev-tools/coccinelle.rst
index 6c791af1c859..dfc5d390307b 100644
--- a/Documentation/dev-tools/coccinelle.rst
+++ b/Documentation/dev-tools/coccinelle.rst
@@ -177,9 +177,12 @@ For example, to check drivers/net/wireless/ one may write::
 To apply Coccinelle on a file basis, instead of a directory basis, the
 following command may be used::
 
+To check only recompiled files, use the value 1 for the C flag, i.e.::
+
     make C=1 CHECK="scripts/coccicheck"
 
-To check only newly edited code, use the value 2 for the C flag, i.e.::
+To check sourcefiles regardless of whether they are recompiled or not, 
+use the value 2 for the C flag, i.e.::
 
     make C=2 CHECK="scripts/coccicheck"
 
-- 
2.17.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
