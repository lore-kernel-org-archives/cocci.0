Return-Path: <SRS0=wfZi=DN=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 366B4C41604
	for <cocci@archiver.kernel.org>; Tue,  6 Oct 2020 19:07:26 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48EFD206B5
	for <cocci@archiver.kernel.org>; Tue,  6 Oct 2020 19:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVAY2c6t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48EFD206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 096J773X019886;
	Tue, 6 Oct 2020 21:07:07 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 067B2769A;
	Tue,  6 Oct 2020 21:07:07 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 32F5544D2
 for <cocci@systeme.lip6.fr>; Tue,  6 Oct 2020 21:07:05 +0200 (CEST)
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1043])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 096J74fu011599
 for <cocci@systeme.lip6.fr>; Tue, 6 Oct 2020 21:07:04 +0200 (CEST)
Received: by mail-pj1-x1043.google.com with SMTP id a17so2013976pju.1
 for <cocci@systeme.lip6.fr>; Tue, 06 Oct 2020 12:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=YDFIQq/o1hm+LPrfCgI+XDiyZGlyHTyQEBbo9XIzVSg=;
 b=TVAY2c6tnOiTVeF6ZU7OajfKrQ4dLXku1bZ7uAV5WTVSFaxnsCS0Ln/JxQN6ibwzLt
 7sjbSogVb0kupW/N+cFDpW2gbMFAoD0qd/30ogozwCYqe44MvXn9QdSC325CnP3AdyyE
 bwxNkXUNcCl2onkwdaxMhgNREDTK4Uh8RfrIbZ4eZRlYobhub58obMEO6c0zjOXtxugc
 fvcoiwDPxuqQtIyQuU/VFcdZ/0Q4wNeiB5TAU8LfjMH4/VZ5eusZkh1Uxy/7qtZ+5hGL
 exmlCO+VZ/xKZOB7SJvpOgH7DCe7cgLRW2VOpcrYP3C8J7ASOYe6rLKht2KHwQG/UUQ4
 em5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=YDFIQq/o1hm+LPrfCgI+XDiyZGlyHTyQEBbo9XIzVSg=;
 b=RbYpiBWz2nye5FrXdVolV1dTfTYt6oZRXuB4YNrWMb7/hXXv4+UcmwdnqFI/RHQXN7
 K+MjF5s0D3uPhnZNpZiuCRVvOGk2Z+R+tl1ZjFvnDbiBIQ2f2/dwnNnFKS7wig/feYOk
 Du7/wYwcIXY14JnoIVwFhcUan2P/HBBZ2GlzZ4+7X/gdcWAsQbP90Td833Qdfj56irCV
 P2sPbdxdfnrPSR43UW2er8ZlFIXodPxF3EMIQ9IU91OX4ZzsBVlKn9Fp3BQ4UwlOBi7E
 EgVXvPg/WtrhuGbcJxsPUG+LWzvMuK9kO/gNTTAOCHHWMw3WWa2jae5ft9IdTJKLCm6q
 dH1w==
X-Gm-Message-State: AOAM530moBOFED7ISgRnuOd/CO3BtwL0ZGzfrTrF570jGYYU5G/jpvq9
 p7dilw54tkvGP8l2bI2mG9s=
X-Google-Smtp-Source: ABdhPJwmpDG6+mANDCPgRVfuvABQFO58x9fHsyIB74xKqjhgmQM0wDFJ+uO7uImTEahCXmsC9O8Z6A==
X-Received: by 2002:a17:902:760f:b029:d1:f8be:b0be with SMTP id
 k15-20020a170902760fb02900d1f8beb0bemr4612506pll.9.1602011223606; 
 Tue, 06 Oct 2020 12:07:03 -0700 (PDT)
Received: from adolin ([49.207.211.213])
 by smtp.gmail.com with ESMTPSA id x10sm4588100pfc.88.2020.10.06.12.06.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 12:07:03 -0700 (PDT)
Date: Wed, 7 Oct 2020 00:36:58 +0530
From: Sumera Priyadarsini <sylphrenadin@gmail.com>
To: Julia.Lawall@lip6.fr
Message-ID: <69bd5a72b18138df7a979532062ffc306fbc3b45.1602010816.git.sylphrenadin@gmail.com>
References: <cover.1602010816.git.sylphrenadin@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1602010816.git.sylphrenadin@gmail.com>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 06 Oct 2020 21:07:07 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Tue, 06 Oct 2020 21:07:04 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: michal.lkml@markovi.net, linux-doc@vger.kernel.org, Gilles.Muller@lip6.fr,
        corbet@lwn.net, nicolas.palix@imag.fr, linux-kernel@vger.kernel.org,
        cocci@systeme.lip6.fr
Subject: [Cocci] [PATCH 2/2 V2] Documentation: Coccinelle: Modify
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
default for optimal performance. Modify documentation in coccinelle.rst
to reflect the same.

Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
---
 Documentation/dev-tools/coccinelle.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/dev-tools/coccinelle.rst b/Documentation/dev-tools/coccinelle.rst
index 74c5e6aeeff5..a27a4867018c 100644
--- a/Documentation/dev-tools/coccinelle.rst
+++ b/Documentation/dev-tools/coccinelle.rst
@@ -130,8 +130,8 @@ To enable verbose messages set the V= variable, for example::
 Coccinelle parallelization
 --------------------------
 
-By default, coccicheck tries to run as parallel as possible. To change
-the parallelism, set the J= variable. For example, to run across 4 CPUs::
+By default, coccicheck uses at most only one thread per core of the system.
+To change the parallelism, set the J= variable. For example, to run across 4 CPUs::
 
    make coccicheck MODE=report J=4
 
-- 
2.25.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
