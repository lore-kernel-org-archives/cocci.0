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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3FB1C41604
	for <cocci@archiver.kernel.org>; Tue,  6 Oct 2020 19:06:41 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB815206B5
	for <cocci@archiver.kernel.org>; Tue,  6 Oct 2020 19:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TdIMjj/N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB815206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 096J6JFO025379;
	Tue, 6 Oct 2020 21:06:19 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 80EEC769A;
	Tue,  6 Oct 2020 21:06:19 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id E100744D2
 for <cocci@systeme.lip6.fr>; Tue,  6 Oct 2020 21:06:17 +0200 (CEST)
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:441])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 096J6GSM012305
 for <cocci@systeme.lip6.fr>; Tue, 6 Oct 2020 21:06:16 +0200 (CEST)
Received: by mail-pf1-x441.google.com with SMTP id 144so9590012pfb.4
 for <cocci@systeme.lip6.fr>; Tue, 06 Oct 2020 12:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=S59CLvJk1ju+tb0DRKEkJbopm1JVSnijReq8sE5oqI8=;
 b=TdIMjj/NUNBepEvRubaDe/8GfKw3Icn3ZwxMrBQ+s3FhE1276H18es7JR3AViuYt4c
 C2aY8JdPuYlha7hXD2PX4XG1o30zQI2+Q3hPNAxbhOKlUUCawmxOhvx+Z+oka7Mh4Ugp
 is8efVZ9wELJgYTqVTMmLaNmJXlJpkcZ2u8JwrVsf0FXzgVcbrlsMK0CzPSMCHSmHDQK
 nnaQwX5EinZGBM8UKc6MlvVYkAr1RtRNcdDgjGyIY++2WkpQ/I8LAabk010LvgzNtTl2
 0qFfIZ91n/oDQlZti6wdPJz/g4TH+4RrNcNk+7XpRkwXwkqTY46MJzhU5WPHLz11Lk93
 be8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=S59CLvJk1ju+tb0DRKEkJbopm1JVSnijReq8sE5oqI8=;
 b=DgnbCi1LXQ+B1nUSfG/lpu2kyvVcbKivZUPsQt9SKa/0YpTFGzMWc8A+FQOa9APVcx
 E03GRfrm10uXekKzjTk6PTl6xTdz5cUzqWNIScm6YlgogSeFbenXivqSvjlY0oy9FHzX
 ZDl/ZDuY1SDctCMprtWwZF9IL4GcUCAyvh0yF7WQy3vgSCI2Lr7+1EznYgfMa7Vqft6P
 OV1RV9fqLOLfLxnqWIFkuh2nRLIvdWNBOH/8xNdhG+cesldUaEzVlFrzeNCzRDMdwV4k
 3QYo9AkMEXsDylPwnTkRceYp5Ew4x7FQ4PP4bP+wxWVPfqlH7ShEXIlabSHfB8Hd6sxm
 i90A==
X-Gm-Message-State: AOAM530EUpyBuKZ9Qmg0mYK1XzdSMoeXfZaPYnFh7Ge6vFBXH1YlGFFe
 +5x3kjiZ4cFfZPNgLaLnOwM=
X-Google-Smtp-Source: ABdhPJxyTXhwK+locjTAlQWxxM1VFrei2oZGqCjlKqd35PRuWS4DiDMdUQvecKz3LS7h3FUIJXSRGA==
X-Received: by 2002:aa7:9afc:0:b029:152:9d45:6723 with SMTP id
 y28-20020aa79afc0000b02901529d456723mr5918408pfp.35.1602011175862; 
 Tue, 06 Oct 2020 12:06:15 -0700 (PDT)
Received: from adolin ([49.207.211.213])
 by smtp.gmail.com with ESMTPSA id i1sm3476625pjh.52.2020.10.06.12.06.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 12:06:15 -0700 (PDT)
Date: Wed, 7 Oct 2020 00:36:10 +0530
From: Sumera Priyadarsini <sylphrenadin@gmail.com>
To: Julia.Lawall@lip6.fr
Message-ID: <bfda3151b26c8e16c67bd8ab32057e248540de42.1602010816.git.sylphrenadin@gmail.com>
References: <cover.1602010816.git.sylphrenadin@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1602010816.git.sylphrenadin@gmail.com>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 06 Oct 2020 21:06:19 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Tue, 06 Oct 2020 21:06:16 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: michal.lkml@markovi.net, linux-doc@vger.kernel.org, Gilles.Muller@lip6.fr,
        corbet@lwn.net, nicolas.palix@imag.fr, linux-kernel@vger.kernel.org,
        cocci@systeme.lip6.fr
Subject: [Cocci] [PATCH 1/2 V2] scripts: coccicheck: Change default value
 for parallelism
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
