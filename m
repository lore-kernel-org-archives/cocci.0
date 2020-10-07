Return-Path: <SRS0=67nU=DO=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63617C4363C
	for <cocci@archiver.kernel.org>; Wed,  7 Oct 2020 08:23:17 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BB6F2076C
	for <cocci@archiver.kernel.org>; Wed,  7 Oct 2020 08:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r5BnuTJL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BB6F2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0978N22D009470;
	Wed, 7 Oct 2020 10:23:02 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id EECB7769A;
	Wed,  7 Oct 2020 10:23:01 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 67C90578C
 for <cocci@systeme.lip6.fr>; Wed,  7 Oct 2020 10:23:00 +0200 (CEST)
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:543])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0978MxVo002291
 for <cocci@systeme.lip6.fr>; Wed, 7 Oct 2020 10:23:00 +0200 (CEST)
Received: by mail-pg1-x543.google.com with SMTP id 34so887610pgo.13
 for <cocci@systeme.lip6.fr>; Wed, 07 Oct 2020 01:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=DTMIeAb4199BQec+LNtvo77g56g0FGiP7OwneWm/qvY=;
 b=r5BnuTJLumHmMsoWOjoCTn0gMd3jUUw8iI1MJypztqgE5nG9CU48UfVtN/rMXQM1VV
 9T9wzdYfyxDvwqIKaC0Uogef32LbP8aY80dXceZCT9SmtMe947Ezwe8v/TGV3kT5cBG8
 AvzvzQRrY5FfVf9RXlA/0HWbScgyo+BejsLtuefOVV0oD9IgY9DZWmZlM8jBHwXq8Rcq
 z2awCSt0XRi26cQC4dhwsEtoJLVapdo2WzkklbaRzMiosk9p6zCRYbWZJ9DzXdUafiyr
 4IjmhXbwG1+APq65/HQKdO33dC8UgGaA52aZV89jTuvhqCVNzSoWFyRAjEl832NMqUnv
 sZPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=DTMIeAb4199BQec+LNtvo77g56g0FGiP7OwneWm/qvY=;
 b=XLt8mlJpj1MRJElGW/XDHLByDrKbMcRRfnDECz6k5VvsDKgCTAT/+MXvOkUbEFkqg5
 cQLeIqXV0Iykjbfpikgn7CwUHNbTX97N6JbFwHeitatqLETYAj4kINeEjTKTuc6slRlG
 O+vptfG/sN3hl9brLiDHz8+E+lIyUgQqZtzk4Y5ltsT98FO0JdOdVfZA/KaSWr5wm0sE
 Im8LJcP4ErKYvnnL+ci1SMEZ0aZbJllx394DE9B1qKp3wuaYvlAyR2gqAFUuz4kRXLKC
 +RtBIkBzvB/z6mU+Wm3ukQnvil4MREGcTe5vUhmKYCBZ+DyCPLQaxtbxPhTLiY2C4q43
 mA1A==
X-Gm-Message-State: AOAM5315Ogpd5anmXBsuk0fNSDLJLUoMDCQt1WrlMk6U5yCHRvXH2mXE
 /y/R2YSx9xKYIdISKeTXhsQ=
X-Google-Smtp-Source: ABdhPJw7aCjvWh+9f5ZHF7Si16K7xRCRQhAenNZXmtVZEZmwMh2/En9ERkjHqxmnFwxsTNeJFHnCUQ==
X-Received: by 2002:a63:4e4a:: with SMTP id o10mr391023pgl.384.1602058979301; 
 Wed, 07 Oct 2020 01:22:59 -0700 (PDT)
Received: from adolin ([49.207.194.78])
 by smtp.gmail.com with ESMTPSA id g4sm2042335pgh.65.2020.10.07.01.22.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 01:22:58 -0700 (PDT)
Date: Wed, 7 Oct 2020 13:52:53 +0530
From: Sumera Priyadarsini <sylphrenadin@gmail.com>
To: Julia.Lawall@lip6.fr
Message-ID: <25adae324909605cdbe5ae88a9d60c34aeb515d7.1602054065.git.sylphrenadin@gmail.com>
References: <cover.1602054065.git.sylphrenadin@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1602054065.git.sylphrenadin@gmail.com>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 07 Oct 2020 10:23:02 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Wed, 07 Oct 2020 10:23:00 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: michal.lkml@markovi.net, linux-doc@vger.kernel.org, Gilles.Muller@lip6.fr,
        corbet@lwn.net, nicolas.palix@imag.fr, linux-kernel@vger.kernel.org,
        cocci@systeme.lip6.fr
Subject: [Cocci] [PATCH 2/2 V3] Documentation: Coccinelle: Modify
 parallelisation information in docs
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

This patchset modifies coccicheck to use at most one thread per core by
default in machines with more than 4 hyperthreads for optimal performance.
Modify documentation in coccinelle.rst to reflect the same.

Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
---
Changes in V2:
	Update scripts/coccicheck to use all available threads
	in machines with upto 4 hyperthreads.
---
 Documentation/dev-tools/coccinelle.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/dev-tools/coccinelle.rst b/Documentation/dev-tools/coccinelle.rst
index 74c5e6aeeff5..6fdc462689d5 100644
--- a/Documentation/dev-tools/coccinelle.rst
+++ b/Documentation/dev-tools/coccinelle.rst
@@ -130,8 +130,9 @@ To enable verbose messages set the V= variable, for example::
 Coccinelle parallelization
 --------------------------
 
-By default, coccicheck tries to run as parallel as possible. To change
-the parallelism, set the J= variable. For example, to run across 4 CPUs::
+By default, coccicheck uses at most 1 thread per core in a machine with more
+than 4 hyperthreads. In a machine with upto 4 threads, all threads are used.
+To change the parallelism, set the J= variable. For example, to run across 4 CPUs::
 
    make coccicheck MODE=report J=4
 
-- 
2.25.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
