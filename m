Return-Path: <SRS0=fIkn=DB=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70DAC2D0E2
	for <cocci@archiver.kernel.org>; Thu, 24 Sep 2020 11:26:35 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6B8B2395B
	for <cocci@archiver.kernel.org>; Thu, 24 Sep 2020 11:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t++PTP8t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6B8B2395B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08OBQHtN024716;
	Thu, 24 Sep 2020 13:26:17 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 445E5778D;
	Thu, 24 Sep 2020 13:26:17 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 309CD4452
 for <cocci@systeme.lip6.fr>; Thu, 24 Sep 2020 13:26:15 +0200 (CEST)
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:442])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08OBQExC017609
 for <cocci@systeme.lip6.fr>; Thu, 24 Sep 2020 13:26:14 +0200 (CEST)
Received: by mail-pf1-x442.google.com with SMTP id k8so1727321pfk.2
 for <cocci@systeme.lip6.fr>; Thu, 24 Sep 2020 04:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=S59CLvJk1ju+tb0DRKEkJbopm1JVSnijReq8sE5oqI8=;
 b=t++PTP8tPJ+iwEph9QoBFhWCTUyYV2fQkZ2iBSq57pAwmIbTUx0kPCQf09yfu2fq1F
 OIxpMxl3aj1ZGzDHGG5NZihgM9UA/3OS8Y6ZM/3iVpmurVHkaR5WPgWIiHHmQbSllJeQ
 VyPf1Juwtf6kH3E36/xgegEkrj/jBafH3vmQ2LH+gdTai0FDVcSP6NEDtRuh9bzq3lsJ
 pCVJ9wI0tCSJ9UTaaaOw9ShuA8aP7OwEWUpJUWHt7nlJyB0o++EwiKnj8kZQz5bDBleI
 lbn/bV+bWac3y+oAzXhcTcGqEFd3ovKWzBaz9fbotXf6vdQj9lxo+dT4MEb7BpQLDtgl
 2dOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=S59CLvJk1ju+tb0DRKEkJbopm1JVSnijReq8sE5oqI8=;
 b=q1HJEf0ae8HFlQXiVFLoh/ysHJvTlPM1bPffCaX8rzLIP3ifZ75N3sVwFnriWrwvEx
 hVwKLS5HeSgrRwrzxvera8sgp4lt6hv/wSfsN434ORf9Rvye2OXj7PYN9oxd4w6rRZgT
 g9FaBoEzn8B0CVH0Nku8Thrw/2tgLeEEVW4+TvUJY1tOY82hk/klqPi15BsnriJ11/Gz
 X59qX75iPVKMtdZuclRnbfQdAcDxwNjV9v9pRSsLrhLFLrlgzNax6KsIyDOF1F8qUAfr
 60u6yiysS8qdRSlp/rLEAj/X+MqX1qDhMxeCDrns/BnuWRm0Oi/oG10VvzwELR1nrOSI
 gaqQ==
X-Gm-Message-State: AOAM533InH5Q5SI2M0NEuO+wbZLEMrAuwOr9JQxsM/HPHzIJ8vUpc+fn
 4xjRqpyyoZ4JC85ClHm2sZg=
X-Google-Smtp-Source: ABdhPJx/zQj0vFpIP5uEVYYgXRSvDmLS2gwhxhLt6NsgVR9TjnOA6keppJ0CV589fNd4/sIsy3SKoQ==
X-Received: by 2002:a62:dd02:0:b029:142:2501:398c with SMTP id
 w2-20020a62dd020000b02901422501398cmr3958291pff.81.1600946773777; 
 Thu, 24 Sep 2020 04:26:13 -0700 (PDT)
Received: from adolin ([49.207.208.43])
 by smtp.gmail.com with ESMTPSA id br22sm2146559pjb.35.2020.09.24.04.26.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2020 04:26:13 -0700 (PDT)
Date: Thu, 24 Sep 2020 16:56:08 +0530
From: Sumera Priyadarsini <sylphrenadin@gmail.com>
To: Julia.Lawall@lip6.fr
Message-ID: <3beb97122995eafe3f0b831e36167b1edadb47c5.1600945451.git.sylphrenadin@gmail.com>
References: <cover.1600945451.git.sylphrenadin@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1600945451.git.sylphrenadin@gmail.com>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 24 Sep 2020 13:26:17 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Thu, 24 Sep 2020 13:26:14 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: corbet@lwn.net, michal.lkml@markovi.net, Gilles.Muller@lip6.fr,
        linux-doc@vger.kernel.org, nicolas.palix@imag.fr,
        linux-kernel@vger.kernel.org, cocci@systeme.lip6.fr
Subject: [Cocci] [PATCH 1/2] scripts: coccicheck: Change default value for
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
Changes in V2:
	- Change commit message as suggested by Julia Lawall
Changes in V3:
	- Use J/2 as optimal value for machines with more
than 8 hyperthreads as well.
---
 scripts/coccicheck | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index e04d328210ac..a72aa6c037ff 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -75,8 +75,13 @@ else
         OPTIONS="--dir $KBUILD_EXTMOD $COCCIINCLUDE"
     fi
 
+    # Use only one thread per core by default if hyperthreading is enabled
+    THREADS_PER_CORE=$(lscpu | grep "Thread(s) per core: " | tr -cd [:digit:])
     if [ -z "$J" ]; then
         NPROC=$(getconf _NPROCESSORS_ONLN)
+	if [ $THREADS_PER_CORE -gt 1 -a $NPROC -gt 2 ] ; then
+		NPROC=$((NPROC/2))
+	fi
     else
         NPROC="$J"
     fi
-- 
2.25.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
