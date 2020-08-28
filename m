Return-Path: <SRS0=g0NP=CG=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C451C433E2
	for <cocci@archiver.kernel.org>; Fri, 28 Aug 2020 16:32:27 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B278B20872
	for <cocci@archiver.kernel.org>; Fri, 28 Aug 2020 16:32:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B278B20872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 07SGWAew014695;
	Fri, 28 Aug 2020 18:32:10 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 885B6777D;
	Fri, 28 Aug 2020 18:32:10 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 8B1B64316
 for <cocci@systeme.lip6.fr>; Fri, 28 Aug 2020 18:32:08 +0200 (CEST)
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com
 [209.85.208.196])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 07SGW7X6016007
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 28 Aug 2020 18:32:07 +0200 (CEST)
Received: by mail-lj1-f196.google.com with SMTP id w25so1962531ljo.12
 for <cocci@systeme.lip6.fr>; Fri, 28 Aug 2020 09:32:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=MTrVSpZ9C8pbL/8BIE49vy9556f5oKETpreng4WhtvM=;
 b=uOx16t1ueeDYpgwk4dXSlEOufSdWHHyhp4X2rNPmS+leF1YrR8e1AfQjN/23viQz1P
 sAYGr3393xjrBDEWZ/v7FdbdskQW/ZHFTsw7AfJOWnqOkpyWR9BK92fTHxBb/bhAgGLe
 d8lAmb8GtR0IOVKKlpuwJURVhnVzZWHZsW1lmPgJdzOMGHIgjyktqHe/YmxoT4RV9I/E
 zN0mjjIO1z/B0bCYIbWmgpY6B4+7YhbfE1VZk7xJftfMoL7SdKfzF1v7MSIJQqKGhkbG
 Pks9Wf2hYk6QZfFslHCkw0RaQsYsjCF2tzhOn99wKDrzEe//Cm+7dVs0iuU/FpwKSDfA
 5tzQ==
X-Gm-Message-State: AOAM530VTZ5PTQkBaPZXq5x8v0id2ncWcIIupcuh41ToBhztx+dHqB55
 bH9ur/W/26XDs1enG8RsJFQ=
X-Google-Smtp-Source: ABdhPJxVhozefzKCWuOnKCweTEB6t3+HJdnKnvpGPQLql/uMye5UbfzGnGlvc9KOk15WHazGtYLUXg==
X-Received: by 2002:a2e:918e:: with SMTP id f14mr1210827ljg.66.1598632327161; 
 Fri, 28 Aug 2020 09:32:07 -0700 (PDT)
Received: from localhost.localdomain ([213.87.147.111])
 by smtp.googlemail.com with ESMTPSA id w6sm397882lfn.73.2020.08.28.09.32.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 09:32:06 -0700 (PDT)
From: Denis Efremov <efremov@linux.com>
To: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Fri, 28 Aug 2020 19:31:34 +0300
Message-Id: <20200828163134.496386-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 28 Aug 2020 18:32:10 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 28 Aug 2020 18:32:07 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Kees Cook <keescook@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [Cocci] [RFC PATCH] coccinelle: api: add flex_array_size.cocci
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

Suggest flex_array_size() wrapper to compute the size of a
flexible array member in a structure. The macro additionally
checks for integer overflows.

The cocci script intentionally skips cases where count argument
is not a member of a structure because this introduce false
positives.

Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Denis Efremov <efremov@linux.com>
---
Kees, Gustavo, may I have your acks if you find this script useful?
Currently, it emits following warnings:
./fs/select.c:994:25-26: WARNING opportunity for flex_array_size
./include/linux/avf/virtchnl.h:711:34-35: WARNING opportunity for flex_array_size
./include/linux/avf/virtchnl.h:722:43-44: WARNING opportunity for flex_array_size
./include/linux/avf/virtchnl.h:738:40-41: WARNING opportunity for flex_array_size
./include/linux/avf/virtchnl.h:749:46-47: WARNING opportunity for flex_array_size
./drivers/dma/qcom/bam_dma.c:1055:35-36: WARNING opportunity for flex_array_size
./drivers/md/dm-crypt.c:2895:45-46: WARNING opportunity for flex_array_size
./drivers/md/dm-crypt.c:3381:47-48: WARNING opportunity for flex_array_size
./drivers/md/dm-crypt.c:2484:45-46: WARNING opportunity for flex_array_size
./drivers/md/dm-crypt.c:2484:45-46: WARNING opportunity for flex_array_size
./net/sched/em_canid.c:198:48-49: WARNING opportunity for flex_array_size
./include/linux/filter.h:741:42-43: WARNING opportunity for flex_array_size
./fs/aio.c:677:42-43: WARNING opportunity for flex_array_size
./include/rdma/rdmavt_qp.h:537:31-32: WARNING opportunity for flex_array_size
./include/rdma/rdmavt_qp.h:537:31-32: WARNING opportunity for flex_array_size
./lib/ts_fsm.c:311:49-50: WARNING opportunity for flex_array_size
./mm/slab.c:3407:59-60: WARNING opportunity for flex_array_size
./mm/slab.c:2139:55-56: WARNING opportunity for flex_array_size
./mm/slab.c:3407:59-60: WARNING opportunity for flex_array_size
./mm/slab.c:2139:55-56: WARNING opportunity for flex_array_size

 scripts/coccinelle/api/flex_array_size.cocci | 180 +++++++++++++++++++
 1 file changed, 180 insertions(+)
 create mode 100644 scripts/coccinelle/api/flex_array_size.cocci

diff --git a/scripts/coccinelle/api/flex_array_size.cocci b/scripts/coccinelle/api/flex_array_size.cocci
new file mode 100644
index 000000000000..b5264a826c29
--- /dev/null
+++ b/scripts/coccinelle/api/flex_array_size.cocci
@@ -0,0 +1,180 @@
+// SPDX-License-Identifier: GPL-2.0-only
+///
+/// Suggest flex_array_size() wrapper to compute the size of a
+/// flexible array member in a structure. The macro additionally
+/// checks for integer overflows.
+///
+// Confidence: High
+// Copyright: (C) 2020 Denis Efremov ISPRAS
+// Options: --no-includes --include-headers
+//
+// Keywords: flex_array_size
+//
+
+
+virtual context
+virtual report
+virtual org
+virtual patch
+
+@decl_flex@
+identifier name, array, size;
+type TA, TS;
+@@
+
+  struct name {
+    ...
+    TS size;
+    ...
+(
+    TA array[];
+|
+    TA array[\(0\|1\)];
+)
+  };
+
+@ptr_flex@
+identifier decl_flex.name;
+identifier instance;
+@@
+
+  struct name *instance;
+
+@struct_flex@
+identifier decl_flex.name;
+identifier instance;
+@@
+
+  struct name instance;
+
+@ptr_flex_size depends on !patch@
+identifier decl_flex.array, decl_flex.size;
+identifier ptr_flex.instance;
+type decl_flex.TA;
+position p;
+@@
+
+(
+* instance->size * sizeof(TA)@p
+|
+* instance->size * sizeof(*instance->array)@p
+)
+
+@depends on patch exists@
+identifier decl_flex.array, decl_flex.size;
+identifier ptr_flex.instance;
+type decl_flex.TA;
+@@
+
+(
+- instance->size * sizeof(TA)
++ flex_array_size(instance, array, instance->size)
+|
+- instance->size * sizeof(*instance->array)
++ flex_array_size(instance, array, instance->size)
+)
+
+@struct_flex_size depends on !patch@
+identifier decl_flex.array, decl_flex.size;
+identifier struct_flex.instance;
+type decl_flex.TA;
+position p;
+@@
+
+(
+* instance.size * sizeof(TA)@p
+|
+* instance.size * sizeof(*instance->array)@p
+)
+
+@depends on patch exists@
+identifier decl_flex.array, decl_flex.size;
+identifier struct_flex.instance;
+type decl_flex.TA;
+@@
+
+(
+- instance.size * sizeof(TA)
++ flex_array_size(instance, array, instance.size)
+|
+- instance.size * sizeof(*instance->array)
++ flex_array_size(instance, array, instance.size)
+)
+
+@func_arg_flex_size depends on !patch@
+identifier decl_flex.name, decl_flex.array, decl_flex.size;
+identifier func, instance;
+type decl_flex.TA;
+position p;
+@@
+
+  func(..., struct name *instance, ...) {
+    ... when any
+(
+*   instance->size * sizeof(TA)@p
+|
+*   instance->size * sizeof(*instance->array)@p
+)
+    ...
+  }
+
+@depends on patch exists@
+identifier decl_flex.name, decl_flex.array, decl_flex.size;
+identifier func, instance;
+type decl_flex.TA;
+@@
+
+  func(..., struct name *instance, ...) {
+    ... when any
+(
+-   instance->size * sizeof(TA)
++   flex_array_size(instance, array, instance->size)
+|
+-   instance->size * sizeof(*instance->array)
++   flex_array_size(instance, array, instance->size)
+)
+    ...
+  }
+
+
+@script:python depends on report@
+p << ptr_flex_size.p;
+@@
+
+coccilib.report.print_report(p[0],
+  "WARNING opportunity for flex_array_size")
+
+@script:python depends on org@
+p << ptr_flex_size.p;
+@@
+
+coccilib.org.print_todo(p[0],
+  "WARNING opportunity for flex_array_size")
+
+@script:python depends on report@
+p << struct_flex_size.p;
+@@
+
+coccilib.report.print_report(p[0],
+  "WARNING opportunity for flex_array_size")
+
+@script:python depends on org@
+p << struct_flex_size.p;
+@@
+
+coccilib.org.print_todo(p[0],
+  "WARNING opportunity for flex_array_size")
+
+@script:python depends on report@
+p << func_arg_flex_size.p;
+@@
+
+coccilib.report.print_report(p[0],
+  "WARNING opportunity for flex_array_size")
+
+@script:python depends on org@
+p << func_arg_flex_size.p;
+@@
+
+coccilib.org.print_todo(p[0],
+  "WARNING opportunity for flex_array_size")
-- 
2.26.2

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
