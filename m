Return-Path: <SRS0=v4mC=I2=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B6FC433C1
	for <cocci@archiver.kernel.org>; Sun, 28 Mar 2021 09:16:37 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B8176197C
	for <cocci@archiver.kernel.org>; Sun, 28 Mar 2021 09:16:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B8176197C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 12S9GE5k007520;
	Sun, 28 Mar 2021 11:16:14 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 9EDE277C4;
	Sun, 28 Mar 2021 11:16:14 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 387597610
 for <cocci@systeme.lip6.fr>; Fri, 19 Mar 2021 04:36:42 +0100 (CET)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:534])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 12J3afSb026388
 for <cocci@systeme.lip6.fr>; Fri, 19 Mar 2021 04:36:41 +0100 (CET)
Received: by mail-pg1-x534.google.com with SMTP id y27so2781553pga.9
 for <cocci@systeme.lip6.fr>; Thu, 18 Mar 2021 20:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YThJXKoad88QyIUzJQjgHEKYHEHZlB/t9+1Xws9BWbo=;
 b=VD/B9cBb2K0S5lmYwaCJosnP9TGGztKB/20JQ/fkjVjsoPdByO4kUXUEqrDflhCX+C
 HPiW2HJantqBOkGpty+EeKd1wDi1qXyxhree4Xy3osahOFJDq2flVQZcRIg5vZKsnMI9
 Folr58pqKFC1vWRJZan8ui7JUGvSXLHCgcRVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YThJXKoad88QyIUzJQjgHEKYHEHZlB/t9+1Xws9BWbo=;
 b=U9PzMiiueiL9RhDUCEiYw8TtogpQ0ajCiw/rPoLyQ7G8VjG9FNDVOAB2zZ9A1EXhZo
 j7RoY838fnv2csmZSGdO+5TQk3HTsLHI05V12PRU9QvJjWzfXSh7Hv4ueNj+3w/PxBu5
 HppxNF+9dZYv8Wp5Te/J/jeX1ImN2ZD7adUTsTycZwHgTDpy8sFZYqbx9TM3fCH/6pel
 nspudLD9zJiBuaVIiQyf6Rq/80r4Ndl3wVMJs4HNt+enFtVTgf57b5Nc9IbRYmY7dV90
 NVOvzFqRSA2gKKKNA0tEmN/wsqXkEEjeXDnq3TXR21odzpqBAAHvg3fc20TFT9HM7lAZ
 3vKw==
X-Gm-Message-State: AOAM531e0FAfJ/ikMqrKkqWxxbJgTm22yXZzdUS4uI/CuxVhiSlqQlrI
 tuRTAJl4YoNAQY2aUhfn9dIXBA==
X-Google-Smtp-Source: ABdhPJxcgUFvELXlvjD3ZpIDWD4ma+4r1W70Db0GBPaVPBvvUcnVbbUp9j1C3AIHlM2Zid/+2jEi5g==
X-Received: by 2002:a62:5b43:0:b029:1ef:21ad:846 with SMTP id
 p64-20020a625b430000b02901ef21ad0846mr7206410pfb.51.1616125000617; 
 Thu, 18 Mar 2021 20:36:40 -0700 (PDT)
Received: from evanbenn1.syd.corp.google.com
 ([2401:fa00:9:15:d0d6:1466:f005:1b0a])
 by smtp.gmail.com with ESMTPSA id z2sm3909741pfq.198.2021.03.18.20.36.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Mar 2021 20:36:40 -0700 (PDT)
From: Evan Benn <evanbenn@chromium.org>
To: Julia Lawall <Julia.Lawall@inria.fr>
Date: Fri, 19 Mar 2021 14:36:15 +1100
Message-Id: <20210319142952.1.I2c82789dba4e68d61595862188e8bf4d31a05d38@changeid>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 28 Mar 2021 11:16:15 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 19 Mar 2021 04:36:41 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
X-Mailman-Approved-At: Sun, 28 Mar 2021 11:16:13 +0200
Cc: Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        Evan Benn <evanbenn@chromium.org>, cocci@systeme.lip6.fr
Subject: [Cocci] [PATCH] scripts/coccinelle: Add script to detect sign
	extension
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

Hello,

I am attempting to create a coccinelle script that will detect possibly buggy
usage of the bitwise operators where integer promotion may result in bugs,
usually due to sign extension.

I know this script needs a lot more work, but I am just beginning to learn the
syntax of coccinelle. At this stage I am mainly looking for advice if this is
even worth continuing, or if I am on the wrong track entirely. 

Here is an example of the bug I hope to find:

https://lore.kernel.org/lkml/20210317013758.GA134033@roeck-us.net/

Where ints and unsigned are mixed in bitwise operations, and the sizes differ.

Thanks

Evan Benn

Signed-off-by: Evan Benn <evanbenn@chromium.org>
---

 .../coccinelle/tests/int_sign_extend.cocci    | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 scripts/coccinelle/tests/int_sign_extend.cocci

diff --git a/scripts/coccinelle/tests/int_sign_extend.cocci b/scripts/coccinelle/tests/int_sign_extend.cocci
new file mode 100644
index 000000000000..bad61e37e4e7
--- /dev/null
+++ b/scripts/coccinelle/tests/int_sign_extend.cocci
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/// Mixing signed and unsigned types in bitwise operations risks problems when
+/// the 'Usual arithmetic conversions' are applied.
+/// For example:
+/// https://lore.kernel.org/lkml/20210317013758.GA134033@roeck-us.net/
+/// When a signed int and an unsigned int are compared there is no problem.
+/// But if the unsigned is changed to a unsigned long, for example by using BIT
+/// the signed value will be sign-extended and could result in incorrect logic.
+// Confidence:
+// Copyright: (C) 2021 Evan Benn <evanbenn@chromium.org>
+// Comments:
+// Options:
+
+virtual context
+virtual org
+virtual report
+
+@r@
+position p;
+{int} s;
+{unsigned long} u;
+@@
+    s@p & u
+
+@script:python depends on org@
+p << r.p;
+@@
+
+cocci.print_main("sign extension when comparing bits of signed and unsigned values", p)
+
+@script:python depends on report@
+p << r.p;
+@@
+
+coccilib.report.print_report(p[0],"sign extension when comparing bits of signed and unsigned values")
-- 
2.31.0.291.g576ba9dcdaf-goog

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
