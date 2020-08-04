Return-Path: <SRS0=V5+4=BO=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C41C433DF
	for <cocci@archiver.kernel.org>; Tue,  4 Aug 2020 07:40:57 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69AA82086A
	for <cocci@archiver.kernel.org>; Tue,  4 Aug 2020 07:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKcu90js"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69AA82086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0747eWcP018864;
	Tue, 4 Aug 2020 09:40:32 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 790AB76BF;
	Tue,  4 Aug 2020 09:40:32 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 6DA56428B
 for <cocci@systeme.lip6.fr>; Tue,  4 Aug 2020 04:34:33 +0200 (CEST)
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1044])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 0742YVRJ000417
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Tue, 4 Aug 2020 04:34:32 +0200 (CEST)
Received: by mail-pj1-x1044.google.com with SMTP id f9so1187909pju.4
 for <cocci@systeme.lip6.fr>; Mon, 03 Aug 2020 19:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=gk1n9r93n5xzn2rKO1ZKzoYAJi9jZTqeFwpABIqhBHQ=;
 b=RKcu90jsK3dX6vNsb59fWWIKejmewqQMDcSpVmACXTzhaOWbJrRkAQzyrxFSAjGZRD
 65HYehXNNjB8ie/+MBhH8gOdt8xJjQAl1KO2QVPNw6EvtyLpZO63mrvmg5dIJY+d8aRm
 gr+LYxFVJvq9ugnhbFE+e6HnX7fSBLJWzkftlMgp2LVQEHTgWXYgfpjFqilIAymEbEgN
 QQs7Aw309e4ZqLYmCvVk2AopAVxCGjxPraMquUs7qi92BrBQFn2f348p7tVwSFoJvVb4
 7H4XP+P2OtTyempPDSHk8ihMvrDQgv/nNZxdArbBeOjhzZtDeQqrE6eSqmVrBqolkArf
 QV6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=gk1n9r93n5xzn2rKO1ZKzoYAJi9jZTqeFwpABIqhBHQ=;
 b=NiR73wkXLikX4UbATpGAdOeUnhXrG5DoQ18M6/NXfmSr77ZmOMi3vUICzZPfEZCMFO
 zJm3nOm5KjhOjtDJo9dG5CwPZBJXCYbVDVPtLWOq9fFPAW/z057LoaTOGgYChrFuyVLX
 7gnlcngwYmcnm3RlxcDwgr7XXyNkPgKaVWU7j2N3rAuYCJQxNY0QHftM+dHY23Ph5ILL
 L97WyNnIYpMu1BXVu67icX3A10qLGP3NY4tzmM33FCreZVHTNsTobRBbrrzACuqrNJtv
 8hFGssnOzdl08ZVcbRhI5HnynINNCwq1VUYWJ2GdRVV7y34LuXuIlhBhS3jD9N0/sRWB
 Kqhw==
X-Gm-Message-State: AOAM532pIN1ventARJ2Ws9pUgi+mPG2+R3iCNCVP9Et0A73q+CsAvKnD
 aYGfEfNb/Hu+LiqIua83E+4=
X-Google-Smtp-Source: ABdhPJyjSM6GGnwIOwT4czYh0dSYoXR+QvwkKyqQxdz2oiHqEE85lJNjtRm2tz+pnXC014ud9ADZ/g==
X-Received: by 2002:a17:90a:fd03:: with SMTP id
 cv3mr2100743pjb.111.1596508471324; 
 Mon, 03 Aug 2020 19:34:31 -0700 (PDT)
Received: from localhost.localdomain ([106.51.110.64])
 by smtp.gmail.com with ESMTPSA id u65sm754508pjb.22.2020.08.03.19.34.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2020 19:34:30 -0700 (PDT)
From: Sumera Priyadarsini <sylphrenadin@gmail.com>
To: Julia.Lawall@lip6.fr
Date: Tue,  4 Aug 2020 08:01:41 +0530
Message-Id: <20200804023141.9510-1-sylphrenadin@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 04 Aug 2020 09:40:32 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Tue, 04 Aug 2020 04:34:33 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
X-Mailman-Approved-At: Tue, 04 Aug 2020 09:40:30 +0200
Cc: michal.lkml@markovi.net, Sumera Priyadarsini <sylphrenadin@gmail.com>,
        Gilles.Muller@lip6.fr, gregkh@linuxfoundation.org,
        nicolas.palix@imag.fr, linux-kernel@vger.kernel.org,
        cocci@systeme.lip6.fr
Subject: [Cocci] [PATCH] scripts: coccicheck: Add chain mode to list of modes
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

This patch adds chain mode to the list of available modes in coccinelle.

Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
---
 scripts/coccicheck | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index e04d328210ac..6e37cf36caae 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -99,7 +99,7 @@ fi
 if [ "$MODE" = "" ] ; then
     if [ "$ONLINE" = "0" ] ; then
 	echo 'You have not explicitly specified the mode to use. Using default "report" mode.'
-	echo 'Available modes are the following: patch, report, context, org'
+	echo 'Available modes are the following: patch, report, context, org, chain'
 	echo 'You can specify the mode with "make coccicheck MODE=<mode>"'
 	echo 'Note however that some modes are not implemented by some semantic patches.'
     fi
-- 
2.17.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
