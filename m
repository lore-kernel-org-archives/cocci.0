Return-Path: <SRS0=5LVs=CK=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F60C433E6
	for <cocci@archiver.kernel.org>; Tue,  1 Sep 2020 07:16:21 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1938206CD
	for <cocci@archiver.kernel.org>; Tue,  1 Sep 2020 07:16:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1938206CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0817FnPa003647;
	Tue, 1 Sep 2020 09:15:49 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 5B98C742E;
	Tue,  1 Sep 2020 09:15:49 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 40F6C4385
 for <cocci@systeme.lip6.fr>; Tue,  1 Sep 2020 09:15:47 +0200 (CEST)
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com
 [209.85.167.67])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 0817Fkpd019934
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Tue, 1 Sep 2020 09:15:46 +0200 (CEST)
Received: by mail-lf1-f67.google.com with SMTP id 12so158057lfb.11
 for <cocci@systeme.lip6.fr>; Tue, 01 Sep 2020 00:15:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Co9oqe1Y6OTWYaD/3lckLQ7GP6ZEbdv5SQNbrFyFhyg=;
 b=YC60jAKKEeCDPSPem0FjRdT+0obE3t6vRyQ+zWX7ULnvGAlkDqyUyfmGRn5XRMUBws
 KODdSNJHv0L7nVeDQX2SYlWljGh4TBi47+aYOGSbBDFOqTNvNEd0Fnw/2L8RiPYecAM+
 7Ntit/HOQI+WpMmlw3KjtAup4SJklyVrEVbk9wDgOzngj/9/ZSMIECEqdLrnNgGyWyxD
 tbtwDqa8kpW7XPZ4KdMAvQw55HEIw18aXSRRSv65RJep3uaJP6cQFhW2314EqIA/tvCx
 jDQkFRSjLYBOSYtDZaYfhCPTKdShHAdRFBCm75rzUcB5K4MePPsh6H5ASkx9pUj4Lzfv
 Pf3w==
X-Gm-Message-State: AOAM5306rUFGIur3QNC5ksDEnuUS1n4Z4slyKsQAT3O2dJSq1mdn794p
 BAIe4oTThsTRl8ky2I+EfVA=
X-Google-Smtp-Source: ABdhPJwFGXfAFKD7x0IJSDRyswcl+3dk0laqBAIJbk1OXCBhafXcmpl3+z9cCet1hiFDcTlsT7yHwg==
X-Received: by 2002:a19:f808:: with SMTP id a8mr468287lff.62.1598944545980;
 Tue, 01 Sep 2020 00:15:45 -0700 (PDT)
Received: from localhost.localdomain (broadband-37-110-38-130.ip.moscow.rt.ru.
 [37.110.38.130])
 by smtp.googlemail.com with ESMTPSA id i187sm62263lfd.65.2020.09.01.00.15.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 00:15:45 -0700 (PDT)
From: Denis Efremov <efremov@linux.com>
To: julia.lawall@inria.fr
Date: Tue,  1 Sep 2020 10:15:33 +0300
Message-Id: <20200901071533.2725-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200811210127.11889-1-efremov@linux.com>
References: <20200811210127.11889-1-efremov@linux.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 01 Sep 2020 09:15:49 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 01 Sep 2020 09:15:46 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Kees Cook <keescook@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [Cocci] [PATCH v2] coccinelle: misc: add uninitialized_var.cocci
	script
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

Commit 63a0895d960a ("compiler: Remove uninitialized_var() macro") and
commit 4b19bec97c88 ("docs: deprecated.rst: Add uninitialized_var()")
removed uninitialized_var() and deprecated it.

The purpose of this script is to prevent new occurrences of open-coded
variants of uninitialized_var().

Cc: Kees Cook <keescook@chromium.org>
Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Denis Efremov <efremov@linux.com>
---
Changes in v2:
 - Documentation cited in the script's description
 - kernel.org link added to the diagnostics messages
 - "T *var = &var;" pattern removed
 - "var =@p var", "var =@p *(&(var))" patterns added

 .../coccinelle/misc/uninitialized_var.cocci   | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 scripts/coccinelle/misc/uninitialized_var.cocci

diff --git a/scripts/coccinelle/misc/uninitialized_var.cocci b/scripts/coccinelle/misc/uninitialized_var.cocci
new file mode 100644
index 000000000000..8fa845cefe11
--- /dev/null
+++ b/scripts/coccinelle/misc/uninitialized_var.cocci
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0-only
+///
+/// Please, don't reintroduce uninitialized_var().
+/// From Documentation/process/deprecated.rst:
+///  For any compiler warnings about uninitialized variables, just add
+///  an initializer. Using warning-silencing tricks is dangerous as it
+///  papers over real bugs (or can in the future), and suppresses unrelated
+///  compiler warnings (e.g. "unused variable"). If the compiler thinks it
+///  is uninitialized, either simply initialize the variable or make compiler
+///  changes. Keep in mind that in most cases, if an initialization is
+///  obviously redundant, the compiler's dead-store elimination pass will make
+///  sure there are no needless variable writes.
+///
+// Confidence: High
+// Copyright: (C) 2020 Denis Efremov ISPRAS
+// Options: --no-includes --include-headers
+//
+
+virtual context
+virtual report
+virtual org
+
+@r@
+identifier var;
+type T;
+position p;
+@@
+
+(
+* T var =@p var;
+|
+* T var =@p *(&(var));
+|
+* var =@p var
+|
+* var =@p *(&(var))
+)
+
+@script:python depends on report@
+p << r.p;
+@@
+
+coccilib.report.print_report(p[0],
+  "WARNING this kind of initialization is deprecated (https://www.kernel.org/doc/html/latest/process/deprecated.html#uninitialized-var)")
+
+@script:python depends on org@
+p << r.p;
+@@
+
+coccilib.org.print_todo(p[0],
+  "WARNING this kind of initialization is deprecated (https://www.kernel.org/doc/html/latest/process/deprecated.html#uninitialized-var)")
-- 
2.26.2

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
