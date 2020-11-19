Return-Path: <SRS0=B3Pe=EZ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ACDBC63697
	for <cocci@archiver.kernel.org>; Thu, 19 Nov 2020 13:15:03 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52481208D5
	for <cocci@archiver.kernel.org>; Thu, 19 Nov 2020 13:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bTyNnkBy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52481208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0AJDETph025108;
	Thu, 19 Nov 2020 14:14:29 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id F00B97789;
	Thu, 19 Nov 2020 14:14:28 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 25CB275C8
 for <cocci@systeme.lip6.fr>; Thu, 19 Nov 2020 14:14:27 +0100 (CET)
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:543])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0AJDEPX6028310
 for <cocci@systeme.lip6.fr>; Thu, 19 Nov 2020 14:14:25 +0100 (CET)
Received: by mail-pg1-x543.google.com with SMTP id t21so4189075pgl.3
 for <cocci@systeme.lip6.fr>; Thu, 19 Nov 2020 05:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
 bh=y39Ja2Qa+p03XEnu3YP7k8KD0CyXh3oLYmik5VnqQLk=;
 b=bTyNnkBySDQVrsd4b1nzl2+6VTopPh8yIZSxu/mVi46eMI2/wbHEgidQbJlfH1XkKC
 /RI/t9gk29e64kidByzhHiBM0m28q+BnK5X4zPEy1v7lLj62UBznWAVhXL6I1iJJGcpA
 ZBRdWpj5u9Y1E211iG9NkevS8yWY7qCxsFc3VLw9AGBUXNhXAPBbONKcMGv2r91Ect6N
 5RtxQlyNBtTIvAYcDoPHUAi8CUOIbz5QsmqIxwkhY1+vSYwu0LVQPWuazBxCtAB6//IV
 JVw5+fgrw0kfB340cpTCMW1v7XMYmbBVzPqLHIDEABtoapm1kaJ11iM0tOu8lzB7sMuJ
 bxsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=y39Ja2Qa+p03XEnu3YP7k8KD0CyXh3oLYmik5VnqQLk=;
 b=hE+EBs/4r9vCnPxyt3qZfCogUfagcJ9X7FoiXZlHjg7BwZnhhQ7rwZRptYTZia4RtC
 B1TmxANubYFxqOeGVaOwFC5FKl4+uppCOBEnMexn/0Uj+lXEM0xPC7k+XmBsbdqIoLbk
 Iy6307nWLKI4dn/Djf1CbAs70cDgXDgEBReFJNFxdgtgvRR4rAvYnFoOIsTwpjRG4W1q
 kw8zAzHi6O/cjBcpE8Hs0KfGlWDzj9Wkz8uEuYNU8VGtJN8McI6pDEGrjfEYZX6QMnhZ
 KDpodwqPtQIRbFBM/Cn2j0LqKA2vEzOJYvlYlm7JWhgFpkxyhy80Wz0Hc6WJnAFZteFT
 RzYQ==
X-Gm-Message-State: AOAM530kQooMwp19nOSJdpj+Jd3IQf2nKdILXmvVsJQx6vQmcZxYyMoh
 ENw5vHbjOY5/aY/TKnYmOBs=
X-Google-Smtp-Source: ABdhPJz7MdA1FnKj4U1mGcgh4hr8O84BT6MlKvOaenxlYMFBIb+X16cP7QwujL2rK3DkCnb+rrY9lw==
X-Received: by 2002:a17:90a:b782:: with SMTP id
 m2mr4608363pjr.185.1605791664993; 
 Thu, 19 Nov 2020 05:14:24 -0800 (PST)
Received: from adolin ([49.207.204.100])
 by smtp.gmail.com with ESMTPSA id m2sm5218994pgv.0.2020.11.19.05.14.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2020 05:14:24 -0800 (PST)
Date: Thu, 19 Nov 2020 18:44:19 +0530
From: Sumera Priyadarsini <sylphrenadin@gmail.com>
To: Julia.Lawall@lip6.fr
Message-ID: <20201119131419.ygiqhzg5cezif5ow@adolin>
MIME-Version: 1.0
Content-Disposition: inline
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 19 Nov 2020 14:14:29 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Thu, 19 Nov 2020 14:14:26 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: michal.lkml@markovi.net, linux-doc@vger.kernel.org, corbet@lwn.net,
        nicolas.palix@imag.fr, linux-kernel@vger.kernel.org,
        Gilles.Muller@lip6.fr, cocci@systeme.lip6.fr
Subject: [Cocci] [PATCH] Documentation: Coccinelle: Improve command example
 for debugging patches
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

Modify Coccinelle documentation to clarify usage of make command to
run coccicheck on a single file.

Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
---
 Documentation/dev-tools/coccinelle.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/coccinelle.rst b/Documentation/dev-tools/coccinelle.rst
index 74c5e6aeeff5..9e60cf175fd6 100644
--- a/Documentation/dev-tools/coccinelle.rst
+++ b/Documentation/dev-tools/coccinelle.rst
@@ -224,7 +224,7 @@ you may want to use::
 
     rm -f err.log
     export COCCI=scripts/coccinelle/misc/irqf_oneshot.cocci
-    make coccicheck DEBUG_FILE="err.log" MODE=report SPFLAGS="--profile --show-trying" M=./drivers/mfd/arizona-irq.c
+    make C=2 CHECK=scripts/coccicheck DEBUG_FILE="err.log" MODE=report SPFLAGS="--profile --show-trying" ./drivers/mfd/arizona-irq.c
 
 err.log will now have the profiling information, while stdout will
 provide some progress information as Coccinelle moves forward with
-- 
2.25.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
