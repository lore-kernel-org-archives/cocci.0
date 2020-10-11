Return-Path: <SRS0=4Vt5=DS=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC7AC433DF
	for <cocci@archiver.kernel.org>; Sun, 11 Oct 2020 10:29:08 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F141A207F7
	for <cocci@archiver.kernel.org>; Sun, 11 Oct 2020 10:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5XX40Gw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F141A207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 09BASpuw027621;
	Sun, 11 Oct 2020 12:28:51 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 41972778E;
	Sun, 11 Oct 2020 12:28:51 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 59303578C
 for <cocci@systeme.lip6.fr>; Sun, 11 Oct 2020 12:28:50 +0200 (CEST)
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:443])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 09BASnNF011615
 for <cocci@systeme.lip6.fr>; Sun, 11 Oct 2020 12:28:49 +0200 (CEST)
Received: by mail-pf1-x443.google.com with SMTP id e7so1778082pfn.12
 for <cocci@systeme.lip6.fr>; Sun, 11 Oct 2020 03:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=w7mBbC6+mTqe++L9wrnVUKIMogpJ8L60knmXuK08frY=;
 b=O5XX40Gwz5NOfU4DYz01q0GZCGrMjhamVWg/YJogO1wiIoejGMsqHi9PbXOkS2MkAi
 xCi7UeL1yC3s4r6rapAXEOvCk/htxdAoxlqrve+gEP9N/DNGtZwH3Xy0Cc/ZzOEKjyxp
 yUpKO18sddLdQZwU2spmZkffUpP0Al5R93hAAv5q9mYDEAdAlA2vHQI4T3s3q7Npo7Jg
 lZaLVqRmN9x5/zvgs2EfWhOuIRFllJpWgE3RQLAJ2SqXMKq4ozu04N+O/LUR+jmPwe7b
 UTY8aAeTjkod/K7KEk4je/CzwkWw7evq19Jjm0T5N4GGpcRlnb3KZu52kzZRiWToTG5L
 xPXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=w7mBbC6+mTqe++L9wrnVUKIMogpJ8L60knmXuK08frY=;
 b=rpVkcSvCU3Rg6Ykzo20OzKEw10oxnV4SHlbd8+l1EfEHgDQ1WD1TPx6GypujAsSQ0I
 kaQpxQ50SyaGSRVOQ2OkRL8Lnr7z43uP45gAuZntV29t8/7hJXLLLPrX5v75vhBD1o7O
 M1Z+JoAVVNY+XS3ftYQS3b3VeQt/U1B4d2lXHGmFce0U50yegOsPBccziyn2Rs1wHdlI
 cDL2+hHwH/jWyizIPvbUdSB449pkcF5ZpQcaydGyPI1Y3NxvaTW1EP4JxKUFX2bHotcf
 gz36Y87ZvBqf28WQWnuTygmmqhT6l3apB04usY3gBtyG+nApl2RIXtywSb9MO7RDOZ+Q
 BW1Q==
X-Gm-Message-State: AOAM530ZYr+GeK8YvQU0G4lBmYQkfGlVodf/H7kpdswXAO71wBROnSG+
 lSl1orGPXknGdwbtHQqDQk0=
X-Google-Smtp-Source: ABdhPJwobw6Sc3tEqdMoLLqczAJos/HMXyFYZC5d+DZlAKgO3nQIOBe+WceRF/EAWbry+W9LMeBoFA==
X-Received: by 2002:a17:90a:db82:: with SMTP id
 h2mr14530648pjv.145.1602412129182; 
 Sun, 11 Oct 2020 03:28:49 -0700 (PDT)
Received: from adolin ([49.207.215.73])
 by smtp.gmail.com with ESMTPSA id m22sm15434027pfk.214.2020.10.11.03.28.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2020 03:28:48 -0700 (PDT)
Date: Sun, 11 Oct 2020 15:58:43 +0530
From: Sumera Priyadarsini <sylphrenadin@gmail.com>
To: Julia.Lawall@lip6.fr
Message-ID: <76ca49efc2ec4b8279e70c4bc4052fb7b543bc86.1602410019.git.sylphrenadin@gmail.com>
References: <cover.1602410019.git.sylphrenadin@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1602410019.git.sylphrenadin@gmail.com>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 11 Oct 2020 12:28:51 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 11 Oct 2020 12:28:49 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: michal.lkml@markovi.net, linux-doc@vger.kernel.org, Gilles.Muller@lip6.fr,
        corbet@lwn.net, nicolas.palix@imag.fr, linux-kernel@vger.kernel.org,
        cocci@systeme.lip6.fr
Subject: [Cocci] [PATCH v4 1/3] scripts: coccicheck: Add quotes to improve
	portability
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

While fetching the number of threads per core with lscpu,
the [:digit:] set is used for translation of digits from 0-9.
However, using [:digit:] instead of "[:digit:]" does not seem
to work uniformly for some shell types and configurations
(such as zsh).

Therefore, modify coccicheck to use double quotes around the
[:digit:] set for uniformity and better portability.

Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
---
 scripts/coccicheck | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index 6789751607f5..d67907b8a38b 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -76,7 +76,7 @@ else
     fi
 
     # Use only one thread per core by default if hyperthreading is enabled
-    THREADS_PER_CORE=$(lscpu | grep "Thread(s) per core: " | tr -cd [:digit:])
+    THREADS_PER_CORE=$(lscpu | grep "Thread(s) per core: " | tr -cd "[:digit:]")
     if [ -z "$J" ]; then
         NPROC=$(getconf _NPROCESSORS_ONLN)
 	if [ $THREADS_PER_CORE -gt 1 -a $NPROC -gt 2 ] ; then
-- 
2.25.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
