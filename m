Return-Path: <SRS0=LIJV=BY=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C8AC433E1
	for <cocci@archiver.kernel.org>; Fri, 14 Aug 2020 12:46:04 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A29FB2087D
	for <cocci@archiver.kernel.org>; Fri, 14 Aug 2020 12:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYwO7AyH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A29FB2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 07ECjiOj008850;
	Fri, 14 Aug 2020 14:45:44 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 2669F7780;
	Fri, 14 Aug 2020 14:45:44 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 483DD3C97
 for <cocci@systeme.lip6.fr>; Fri, 14 Aug 2020 14:45:42 +0200 (CEST)
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:643])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 07ECjdGc026338
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 14 Aug 2020 14:45:40 +0200 (CEST)
Received: by mail-pl1-x643.google.com with SMTP id f5so4131604plr.9
 for <cocci@systeme.lip6.fr>; Fri, 14 Aug 2020 05:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=SmHbAJCevR0amMN/Zfcj3PyJxNcwE0n/cl6TTUsXdNc=;
 b=AYwO7AyHkiDBNjn47cDqSTJQl4femmkIULUnFnOa5ljUbDmk+Tm7P8+9xmnzF0Lwer
 TA0ivp6FbtknhP/WR6JVeNYVi3NlSzTySdzCIY7CwtddtOqZB15W9rOL+qAw/JCxIEyT
 pmYGQzRjPKpAPdgRKSeRqaLnDd+nDXZzbc6ToGyJHiEV1b1QoXuiP0/takARs+DzfcEt
 033BhFsxQKqnbpCoBMtCZnxu0nPnPrTu/hs5jCi6bjcNyJiOa4p/S35irh43zJXVr1Bu
 BtaMjUs1m79AWPWtVYB5kWXqACOH14tXsROrzUSjjxGGkW8WzpVf/FYqoaJ6bOkT21lx
 iKag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=SmHbAJCevR0amMN/Zfcj3PyJxNcwE0n/cl6TTUsXdNc=;
 b=mWclo+7ex8j6OICzawBRvFaPSdgFieYkwOsq3yTrzOI1aSq8Bp1l9dNUZd10wh6CRx
 wrhGNe/QyV77JEx5hxV7eqi6ohrghx9aw5uS1H2H/hkBXyeqAPSnjhbdEW9fhFqggZg9
 noZ+85ZDoGN4xRo3sBmt4OPZgGsG3nMHgmg0bVLt/ATEzgEfuL/vY1vD02etIG8TQ2vL
 3bUUAd+0SmAlh7ZRHzRlCqHXl1+osr4+7jvB3L99D1zpBb4YJ7TdAX+vyoffFnqQH655
 2g7rGtC5UiT8ulOJU5e5g7lx/NiKESrxzdr656bltMbwYuBGOFCFfrPKSqYj1wDSq6wP
 BFSw==
X-Gm-Message-State: AOAM533xOgKPCl8n8QOSIIju3eB1WdgL4lPm5JAV+2jzVWQuWRL2XJO+
 Csbqj3VcC2KsIVkozyGD/nk=
X-Google-Smtp-Source: ABdhPJzQRmyvNdWQHzsF9IF129kcaTj8mszVA6io9lQ2/cejD/Rnnk/oKhGnREbYAB4E/NgpTNokQA==
X-Received: by 2002:a17:90a:bf86:: with SMTP id
 d6mr2075391pjs.83.1597409138981; 
 Fri, 14 Aug 2020 05:45:38 -0700 (PDT)
Received: from localhost.localdomain ([106.51.107.61])
 by smtp.gmail.com with ESMTPSA id 196sm9592765pfc.178.2020.08.14.05.45.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2020 05:45:38 -0700 (PDT)
From: Sumera Priyadarsini <sylphrenadin@gmail.com>
To: Julia.Lawall@lip6.fr
Date: Fri, 14 Aug 2020 18:15:30 +0530
Message-Id: <20200814124530.24793-1-sylphrenadin@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 14 Aug 2020 14:45:44 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 14 Aug 2020 14:45:40 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: michal.lkml@markovi.net, Gilles.Muller@lip6.fr, gregkh@linuxfoundation.org,
        nicolas.palix@imag.fr, linux-kernel@vger.kernel.org,
        cocci@systeme.lip6.fr
Subject: [Cocci] [PATCH V2] scripts: coccicheck: Change default value for
	parallelism
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

By default, coccicheck utilizes all available threads to implement
parallelisation. However, when all available threads are used,
a decrease in performance is noted. The elapsed time is  minimum
when at most one thread per core is used.

For example, on benchmarking the semantic patch kfree.cocci for
usb/serial using hyperfine, the outputs obtained for J=5 and J=2
are 1.32 and 1.90 times faster than those for J=10 and J=9
respectively for two separate runs. For the larger drivers/staging
directory, minimium elapsed time is obtained for J=3 which is 1.86
times faster than that for J=12. The optimal J value does not
exceed 6 in any of the test runs. The benchmarks are run on a machine
with 6 cores, with 2 threads per core, i.e, 12 hyperthreads in all.

To improve performance, modify coccicheck to use at most only
one thread per core by default.

Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
---
 scripts/coccicheck | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index e04d328210ac..dd228dcc915e 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -75,8 +75,17 @@ else
         OPTIONS="--dir $KBUILD_EXTMOD $COCCIINCLUDE"
     fi
 
+    # Use only one thread per core by default if hyperthreading is enabled
+    THREADS_PER_CORE=$(lscpu | grep "Thread(s) per core: " | tr -cd [:digit:])
     if [ -z "$J" ]; then
         NPROC=$(getconf _NPROCESSORS_ONLN)
+	if [ $THREADS_PER_CORE -gt 1 -a $NPROC -gt 2 ] ; then
+		if [ $NPROC -gt 8 ] ; then
+			NPROC=$((NPROC/4))
+		else
+			NPROC=$((NPROC/2))
+		fi
+	fi
     else
         NPROC="$J"
     fi
-- 
2.17.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
