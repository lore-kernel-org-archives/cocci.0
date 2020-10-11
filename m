Return-Path: <SRS0=4Vt5=DS=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0421C433DF
	for <cocci@archiver.kernel.org>; Sun, 11 Oct 2020 10:30:03 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DA97207F7
	for <cocci@archiver.kernel.org>; Sun, 11 Oct 2020 10:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipdTQFud"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DA97207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 09BATnWD027498;
	Sun, 11 Oct 2020 12:29:49 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id C0713778E;
	Sun, 11 Oct 2020 12:29:49 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 1A30F578C
 for <cocci@systeme.lip6.fr>; Sun, 11 Oct 2020 12:29:48 +0200 (CEST)
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:443])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 09BATlV1017187
 for <cocci@systeme.lip6.fr>; Sun, 11 Oct 2020 12:29:47 +0200 (CEST)
Received: by mail-pf1-x443.google.com with SMTP id e10so10810613pfj.1
 for <cocci@systeme.lip6.fr>; Sun, 11 Oct 2020 03:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=C1KPnMgJ65IAvAdqRGhP0IKoKnOw4H6Tv8QLXkVMTpk=;
 b=ipdTQFudIgX+/95HPKoeJDSTGlYyY1R4AKjV7AJXPFvcYYUUaM/kSLKsGZBw1PCtC+
 ERu0QKF5gAevSBOohzbf24jz7MHg3trLtifirLqKgsmXu646cO4unhmrsJ0xcr43w7GG
 2STcH0kDbnc9lIn2VH+WBxu4K00qyenMr6m1CSXKEzxdh9MEYIfbdwq1Kg4gLE58wza4
 2lO3DNLa7x1EjyZQlYxBz/JAvYXai1v9pgtWzlCHXV0iByU0E9VjrEh5l3fylytfBUKZ
 I1ySo56Y4sPK5bxAwD9fY0BwXZZlhr2jEnd1cfOynkz4SJE+LPJhwJ0rnYH4MuxWghKD
 b1cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=C1KPnMgJ65IAvAdqRGhP0IKoKnOw4H6Tv8QLXkVMTpk=;
 b=jrlBKadtQtGLw/dMm5bPMSh7x5vKC/wFwMM87oUhltVywQKtKGsD0o6l9K61eGqyDF
 2v4ldXLnl3/PqIasSyvqzUW9umCvfbCiiGmiYH4UWoSx1UrEw1ezhwdrO8FvcH8dETLW
 JrwGvKcT8jscqe8EYCXGHWMGhWNfMOUOA8UHq+6xTRopgej4MR/4ma1m14ga0IxR/XTX
 fUlmtAl9qj5B+5td8VscD4cB1PNNUWmCWErqEXGuJCoprYpMShz50ekC/ELdEGc4xc5t
 OvXEJEmeZmxoBOFn3RwmAGHxUx1g5q330hfGmBu/AxTCx5gR1SWQfsMYnSRPQWykljNp
 JZ2Q==
X-Gm-Message-State: AOAM532GGkToz1u6xDL3M+hVkp3IaqXCAQ60MZnrEj0OYCixT4GDYyRb
 Jmc0eSlYlBN10JMLUqiuAoQckbvMqxfulA==
X-Google-Smtp-Source: ABdhPJwnb69Aqohdd1/q0tobIuWCkoI//DISJfM5lGloQ9TYgzKNGcZiha9HsOOfOFKfB5b4dOaKDA==
X-Received: by 2002:a17:90a:dd46:: with SMTP id
 u6mr15384584pjv.67.1602412186950; 
 Sun, 11 Oct 2020 03:29:46 -0700 (PDT)
Received: from adolin ([49.207.215.73])
 by smtp.gmail.com with ESMTPSA id e16sm17421201pfh.45.2020.10.11.03.29.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2020 03:29:46 -0700 (PDT)
Date: Sun, 11 Oct 2020 15:59:42 +0530
From: Sumera Priyadarsini <sylphrenadin@gmail.com>
To: Julia.Lawall@lip6.fr
Message-ID: <13de95fe3959459ac9ae8c74d99eb7e3c5702a2d.1602410019.git.sylphrenadin@gmail.com>
References: <cover.1602410019.git.sylphrenadin@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1602410019.git.sylphrenadin@gmail.com>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 11 Oct 2020 12:29:49 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 11 Oct 2020 12:29:47 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: michal.lkml@markovi.net, linux-doc@vger.kernel.org, Gilles.Muller@lip6.fr,
        corbet@lwn.net, nicolas.palix@imag.fr, linux-kernel@vger.kernel.org,
        cocci@systeme.lip6.fr
Subject: [Cocci] [PATCH v4 2/3] scripts: coccicheck: Change default
 condition for parallelism
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

Currently, Coccinelle uses at most one thread per core by default in
machines with more than 2 hyperthreads. However, for systems with only 4
hyperthreads, this does not improve performance.

Modify coccicheck to use all available threads in machines with
upto 4 hyperthreads.

Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
---
 scripts/coccicheck | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index d67907b8a38b..209bb0427b43 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -79,7 +79,7 @@ else
     THREADS_PER_CORE=$(lscpu | grep "Thread(s) per core: " | tr -cd "[:digit:]")
     if [ -z "$J" ]; then
         NPROC=$(getconf _NPROCESSORS_ONLN)
-	if [ $THREADS_PER_CORE -gt 1 -a $NPROC -gt 2 ] ; then
+	if [ $THREADS_PER_CORE -gt 1 -a $NPROC -gt 4 ] ; then
 		NPROC=$((NPROC/2))
 	fi
     else
-- 
2.25.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
