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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F284BC2D0E2
	for <cocci@archiver.kernel.org>; Thu, 24 Sep 2020 11:28:17 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C8002395B
	for <cocci@archiver.kernel.org>; Thu, 24 Sep 2020 11:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WuRgE8Jj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C8002395B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08OBRqrF015935;
	Thu, 24 Sep 2020 13:27:52 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id DF5B9778D;
	Thu, 24 Sep 2020 13:27:52 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id C71DA4452
 for <cocci@systeme.lip6.fr>; Thu, 24 Sep 2020 13:27:51 +0200 (CEST)
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:542])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08OBRoOD015210
 for <cocci@systeme.lip6.fr>; Thu, 24 Sep 2020 13:27:50 +0200 (CEST)
Received: by mail-pg1-x542.google.com with SMTP id 34so1704790pgo.13
 for <cocci@systeme.lip6.fr>; Thu, 24 Sep 2020 04:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=YDFIQq/o1hm+LPrfCgI+XDiyZGlyHTyQEBbo9XIzVSg=;
 b=WuRgE8Jjopy30o3FSLNz3iDk57XIlZh37vnPbLS1kM2vsI5akChLVS3hNvv/ZBe/jK
 KY8+uhar453Fa7ME8SSX3VbMX8bsPw9cQl++OLNKH9aDEGXHtCQ9Fh5IPuXk1IlBR5/K
 qNQ+anXXi7d9KPta2u3CPqMrNqWD9bG8unkPjETicAV3sqUDXEoJljMAXMrowuwKky2z
 5eZ9rnc/54B5dZy1jcAH7BLeiSbRk46KOBCODjninAflSOxojrtubRDkDICSdsDr8SZy
 kenaEFDVuD4uH6/KONa+GdT3oDCKesM5T+SPvCUBh2KxjgJ90PArh1b461RkMBkZ86Ir
 Y7RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=YDFIQq/o1hm+LPrfCgI+XDiyZGlyHTyQEBbo9XIzVSg=;
 b=tTCpfRvC094EhLs2qAdLZ2e2IFYh/FRPYE/45CVR+vUCQZ6YSphlxpSsyACIEYiyim
 UYYEQwIUCU0+7CMNBQMcUUzM+6qEPtnhklicsXWgOU8gBvvQNtQ2/GbL6/bWp4/sARwG
 ciYtDhgwV1OIbni6JxY8ZkJ5XNqs94me+0rXLKI6KmF4kh50q091H0+RKwnFEVZUXesy
 snqK0CzS3fuQZNgaSjQbnftYxbQ5i/dz+1lHCe8W/OZMQEciGKCmzAVaFSGKysUU7z1d
 RLd9W601NDGm/H4cwfRtMP01dzKReZ/arDELlr0Y+NvY7cjvuFZYfZStLerGC4sJsxlk
 HhLQ==
X-Gm-Message-State: AOAM53198W/3fWvXUL1xQLr9cM25cTY8oqXQnuthNRwtRb949GmproAA
 8/04r3rVM7e8G8HUlVpLsSo=
X-Google-Smtp-Source: ABdhPJwLhKbyQz7qDtizIH2JGxD8Qq8fkhyk4avxo67t4ta6TF8+O3ly5vMX7Xu0cVlAynT9iJaHRQ==
X-Received: by 2002:a63:4e52:: with SMTP id o18mr3530830pgl.171.1600946870002; 
 Thu, 24 Sep 2020 04:27:50 -0700 (PDT)
Received: from adolin ([49.207.208.43])
 by smtp.gmail.com with ESMTPSA id c3sm2739187pfn.23.2020.09.24.04.27.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2020 04:27:49 -0700 (PDT)
Date: Thu, 24 Sep 2020 16:57:44 +0530
From: Sumera Priyadarsini <sylphrenadin@gmail.com>
To: Julia.Lawall@lip6.fr
Message-ID: <3ecfe0e7f95021525b7bbf783a45eb3a176791a9.1600945451.git.sylphrenadin@gmail.com>
References: <cover.1600945451.git.sylphrenadin@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1600945451.git.sylphrenadin@gmail.com>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 24 Sep 2020 13:27:53 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Thu, 24 Sep 2020 13:27:50 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: corbet@lwn.net, michal.lkml@markovi.net, Gilles.Muller@lip6.fr,
        linux-doc@vger.kernel.org, nicolas.palix@imag.fr,
        linux-kernel@vger.kernel.org, cocci@systeme.lip6.fr
Subject: [Cocci] [PATCH 2/2] Documentation: Coccinelle: Modify
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
