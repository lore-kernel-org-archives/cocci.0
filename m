Return-Path: <SRS0=Kdcw=BQ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10BFC433E0
	for <cocci@archiver.kernel.org>; Thu,  6 Aug 2020 22:04:41 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 444FE22C9F
	for <cocci@archiver.kernel.org>; Thu,  6 Aug 2020 22:04:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 444FE22C9F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 076M4JK2018032;
	Fri, 7 Aug 2020 00:04:19 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 5565076BF;
	Fri,  7 Aug 2020 00:04:19 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7EA73428B
 for <cocci@systeme.lip6.fr>; Fri,  7 Aug 2020 00:04:17 +0200 (CEST)
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com
 [209.85.208.193])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 076M4GM4022628
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 7 Aug 2020 00:04:16 +0200 (CEST)
Received: by mail-lj1-f193.google.com with SMTP id w14so29073ljj.4
 for <cocci@systeme.lip6.fr>; Thu, 06 Aug 2020 15:04:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=iGMDoetbOMYP0glzodDz3vfCBu4RbxNIHhpUfK0pfdc=;
 b=pVEdirFeNEbpuNidoZcKTok4YR3XREodoW3px0bEGwqAdqmZaK1OsHo6VC6/F97B7f
 f7V5qDRLiR/iis6SdO6maBqkv49Ki/34kw7HwKd9WtE8f276rm32hfGBMrU8NDy3s76W
 OcBTrjv1SCvRFBrcNFIkzbffrmAwYgR8LrtP4kCIKRkRtSO1ZSMDPwd1h4Ql++EoF5xT
 y6VP06svJUQpURi6CC9X6rJh2SxQ5BKcpO1Mgz7jvqMcCy7h0UoNY1pxqjdaR2F6h/Gk
 skXWh3QVlmouv3PV5woF9pA/wx9ZJmr3m5sbEn2Bl2H1FQN3xok817enBrC0u3KIWSQ+
 z3sA==
X-Gm-Message-State: AOAM530ijPztKjM1glG2ZPPbQ5EVnUlfVaAzB6Tf7Cu+QBeiXa77FRJ5
 gc/pRrb/Xw5fxnVUl/l7KbA=
X-Google-Smtp-Source: ABdhPJzug0mOX8zn4tftuPfc1pWz4EEOTNUfRJEFL32daU/IIFhb9SmXiykwTOD1fJL4QcSRmbd3eQ==
X-Received: by 2002:a2e:9d08:: with SMTP id t8mr5016437lji.62.1596751456034;
 Thu, 06 Aug 2020 15:04:16 -0700 (PDT)
Received: from localhost.localdomain (broadband-37-110-38-130.ip.moscow.rt.ru.
 [37.110.38.130])
 by smtp.googlemail.com with ESMTPSA id z3sm2992489ljz.109.2020.08.06.15.04.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 15:04:15 -0700 (PDT)
From: Denis Efremov <efremov@linux.com>
To: Julia Lawall <julia.lawall@inria.fr>
Date: Fri,  7 Aug 2020 01:03:42 +0300
Message-Id: <20200806220342.25426-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 07 Aug 2020 00:04:19 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 07 Aug 2020 00:04:16 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Kees Cook <keescook@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [Cocci] [RFC PATCH] coccinelle: misc: add flexible_array.cocci
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

Commit 68e4cd17e218 ("docs: deprecated.rst: Add zero-length and one-element
arrays") marks one-element and zero-length arrays as deprecated. Kernel
code should always use "flexible array members" instead.

The script warns about one-element and zero-length arrays in structs.

Cc: Kees Cook <keescook@chromium.org>
Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Denis Efremov <efremov@linux.com>
---

Currently, it's just a draft. I've placed a number of questions in the
script and marked them as TODO. Kees, Gustavo, if you could help me with
my questions I think that this rule will be enough to close:
https://github.com/KSPP/linux/issues/76

BTW, I it's possible to not warn about files in uapi folder if
this is relevant. Do I need to do it in the script?

 scripts/coccinelle/misc/flexible_array.cocci | 158 +++++++++++++++++++
 1 file changed, 158 insertions(+)
 create mode 100644 scripts/coccinelle/misc/flexible_array.cocci

diff --git a/scripts/coccinelle/misc/flexible_array.cocci b/scripts/coccinelle/misc/flexible_array.cocci
new file mode 100644
index 000000000000..1e7165c79e60
--- /dev/null
+++ b/scripts/coccinelle/misc/flexible_array.cocci
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: GPL-2.0-only
+///
+/// Zero-length and one-element arrays are deprecated, see
+/// Documentation/process/deprecated.rst
+/// Flexible-array members should be used instead.
+///
+//
+// Confidence: High
+// Copyright: (C) 2020 Denis Efremov ISPRAS.
+// Comments:
+// Options: --no-includes --include-headers
+
+virtual context
+virtual report
+virtual org
+virtual patch
+
+@r depends on !patch@
+identifier name, size, array;
+// TODO: We can additionally restrict size and array to:
+// identifier size =~ ".*(num|len|count|size|ncpus).*";
+// identifier array !~ ".*(pad|reserved).*";
+// Do we need it?
+type TS, TA;
+position p;
+@@
+
+(
+  // This will also match: typedef struct name { ...
+  // However nested structs are not matched, i.e.:
+  //   struct name1 { struct name2 { int s; int a[0]; } st; int i; }
+  // will not be matched. Do we need to handle it?
+  struct name {
+    ...      // TODO: Maybe simple ... is enough? It will match structs with a
+    TS size; // single field, e.g.
+    ...      // https://elixir.bootlin.com/linux/v5.8/source/arch/arm/include/uapi/asm/setup.h#L127
+(
+*    TA array@p[0];
+|
+     // TODO: It seems that there are exception cases for array[1], e.g.
+     //  https://elixir.bootlin.com/linux/v5.8/source/arch/powerpc/boot/rs6000.h#L152
+     //  https://elixir.bootlin.com/linux/v5.8/source/include/uapi/linux/cdrom.h#L292
+     //  https://elixir.bootlin.com/linux/v5.8/source/drivers/net/wireless/ath/ath6kl/usb.c#L108
+     // We could either drop array[1] checking from this rule or
+     // restrict array name with regexp and add, for example, an "allowlist"
+     // with struct names where we allow this code pattern.
+     // TODO: How to handle: u8 data[1][MAXLEN_PSTR6]; ?
+*    TA array@p[1];
+)
+  };
+|
+  struct {
+    ...
+    TS size;
+    ...
+(
+*    TA array@p[0];
+|
+*    TA array@p[1];
+)
+  };
+|
+  // TODO: do we need to handle unions?
+  union name {
+    ...
+    TS size;
+    ...
+(
+*    TA array@p[0];
+|
+*    TA array@p[1];
+)
+  };
+|
+  union {
+    ...
+    TS size;
+    ...
+(
+*    TA array@p[0];
+|
+*    TA array@p[1];
+)
+  };
+)
+
+// FIXME: Patch mode doesn't work as expected.
+// Coccinelle handles formatting incorrectly.
+// Patch mode in this rule should be disabled until
+// proper formatting will be supported.
+@depends on patch exists@
+identifier name, size, array;
+type TS, TA;
+@@
+
+(
+  struct name {
+    ...
+    TS size;
+    ...
+(
+-    TA array[0];
+|
+-    TA array[1];
+)
++    TA array[];
+  };
+|
+  struct {
+    ...
+    TS size;
+    ...
+(
+-    TA array[0];
+|
+-    TA array[1];
+)
++    TA array[];
+  };
+|
+  union name {
+    ...
+    TS size;
+    ...
+(
+-    TA array[0];
+|
+-    TA array[1];
+)
++    TA array[];
+  };
+|
+  union {
+    ...
+    TS size;
+    ...
+(
+-    TA array[0];
+|
+-    TA array[1];
+)
++    TA array[];
+  };
+)
+
+@script: python depends on report@
+p << r.p;
+@@
+
+msg = "WARNING: use flexible-array member instead"
+coccilib.report.print_report(p[0], msg)
+
+@script: python depends on org@
+p << r.p;
+@@
+
+msg = "WARNING: use flexible-array member instead"
+coccilib.org.print_todo(p, msg)
-- 
2.26.2

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
