Return-Path: <SRS0=VaV3=27=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54182C33CA2
	for <cocci@archiver.kernel.org>; Fri, 10 Jan 2020 13:16:10 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE43B2072E
	for <cocci@archiver.kernel.org>; Fri, 10 Jan 2020 13:16:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE43B2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00ADFqHV023768;
	Fri, 10 Jan 2020 14:15:53 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id CFAD877EA;
	Fri, 10 Jan 2020 14:15:52 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id D539A77E3
 for <cocci@systeme.lip6.fr>; Fri, 10 Jan 2020 14:15:51 +0100 (CET)
Received: from out4436.biz.mail.alibaba.com (out4436.biz.mail.alibaba.com
 [47.88.44.36])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00ADFn4F022727
 for <cocci@systeme.lip6.fr>; Fri, 10 Jan 2020 14:15:50 +0100 (CET)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R171e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e07486; MF=wenyang@linux.alibaba.com;
 NM=1; PH=DS; RN=12; SR=0; TI=SMTPD_---0TnKZRe1_1578662128; 
Received: from localhost(mailfrom:wenyang@linux.alibaba.com
 fp:SMTPD_---0TnKZRe1_1578662128) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 10 Jan 2020 21:15:37 +0800
From: Wen Yang <wenyang@linux.alibaba.com>
To: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Fri, 10 Jan 2020 21:15:26 +0800
Message-Id: <20200110131526.60180-1-wenyang@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 10 Jan 2020 14:15:53 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 10 Jan 2020 14:15:51 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Michal Marek <michal.lkml@markovi.net>,
        Wen Yang <wenyang@linux.alibaba.com>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Matthias Maennich <maennich@google.com>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, cocci@systeme.lip6.fr
Subject: [Cocci] [PATCH v3] coccinelle: semantic patch to check for
	inappropriate do_div() calls
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

do_div() does a 64-by-32 division.
When the divisor is unsigned long, u64, or s64,
do_div() truncates it to 32 bits, this means it
can test non-zero and be truncated to zero for division.
This semantic patch is inspired by Mateusz Guzik's patch:
commit b0ab99e7736a ("sched: Fix possible divide by zero in avg_atom() calculation")

Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
Cc: Julia Lawall <julia.lawall@inria.fr>
Cc: Gilles Muller <Gilles.Muller@lip6.fr>
Cc: Nicolas Palix <nicolas.palix@imag.fr>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Matthias Maennich <maennich@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: cocci@systeme.lip6.fr
Cc: linux-kernel@vger.kernel.org
---
v3:
- also filter out safe consts for context mode.
- cleanup code.

v2:
- add a special case for constants and checking whether the value is obviously safe and no warning is needed.
- fix 'WARNING:' twice in each case.
- extend the warning to say "consider using div64_xxx instead".

 scripts/coccinelle/misc/do_div.cocci | 155 +++++++++++++++++++++++++++
 1 file changed, 155 insertions(+)
 create mode 100644 scripts/coccinelle/misc/do_div.cocci

diff --git a/scripts/coccinelle/misc/do_div.cocci b/scripts/coccinelle/misc/do_div.cocci
new file mode 100644
index 000000000000..79db083c5208
--- /dev/null
+++ b/scripts/coccinelle/misc/do_div.cocci
@@ -0,0 +1,155 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/// do_div() does a 64-by-32 division.
+/// When the divisor is long, unsigned long, u64, or s64,
+/// do_div() truncates it to 32 bits, this means it can test
+/// non-zero and be truncated to 0 for division on 64bit platforms.
+///
+//# This makes an effort to find those inappropriate do_div() calls.
+//
+// Confidence: Moderate
+// Copyright: (C) 2020 Wen Yang, Alibaba.
+// Comments:
+// Options: --no-includes --include-headers
+
+virtual context
+virtual org
+virtual report
+
+@initialize:python@
+@@
+
+def get_digit_type_and_value(str):
+    is_digit = False
+    value = 0
+
+    try:
+        if (str.isdigit()):
+           is_digit = True
+           value =  int(str, 0)
+        elif (str.upper().endswith('ULL')):
+           is_digit = True
+           value = int(str[:-3], 0)
+        elif (str.upper().endswith('LL')):
+           is_digit = True
+           value = int(str[:-2], 0)
+        elif (str.upper().endswith('UL')):
+           is_digit = True
+           value = int(str[:-2], 0)
+        elif (str.upper().endswith('L')):
+           is_digit = True
+           value = int(str[:-1], 0)
+        elif (str.upper().endswith('U')):
+           is_digit = True
+           value = int(str[:-1], 0)
+    except Exception as e:
+          print('Error:',e)
+          is_digit = False
+          value = 0
+    finally:
+        return is_digit, value
+
+def filter_out_safe_constants(str):
+    is_digit, value = get_digit_type_and_value(str)
+    if (is_digit):
+        if (value >= 0x100000000):
+            return True
+        else:
+            return False
+    else:
+        return True
+
+def construct_warnings(suggested_fun):
+    msg="WARNING: do_div() does a 64-by-32 division, please consider using %s instead."
+    return  msg % suggested_fun
+
+@depends on context@
+expression f;
+long l: script:python() { filter_out_safe_constants(l) };
+unsigned long ul : script:python() { filter_out_safe_constants(ul) };
+u64 ul64 : script:python() { filter_out_safe_constants(ul64) };
+s64 sl64 : script:python() { filter_out_safe_constants(sl64) };
+
+@@
+(
+* do_div(f, l);
+|
+* do_div(f, ul);
+|
+* do_div(f, ul64);
+|
+* do_div(f, sl64);
+)
+
+@r depends on (org || report)@
+expression f;
+position p;
+long l: script:python() { filter_out_safe_constants(l) };
+unsigned long ul : script:python() { filter_out_safe_constants(ul) };
+u64 ul64 : script:python() { filter_out_safe_constants(ul64) };
+s64 sl64 : script:python() { filter_out_safe_constants(sl64) };
+@@
+(
+do_div@p(f, l);
+|
+do_div@p(f, ul);
+|
+do_div@p(f, ul64);
+|
+do_div@p(f, sl64);
+)
+
+@script:python depends on org@
+p << r.p;
+ul << r.ul;
+@@
+
+coccilib.org.print_todo(p[0], construct_warnings("div64_ul"))
+
+@script:python depends on org@
+p << r.p;
+l << r.l;
+@@
+
+coccilib.org.print_todo(p[0], construct_warnings("div64_long"))
+
+@script:python depends on org@
+p << r.p;
+ul64 << r.ul64;
+@@
+
+coccilib.org.print_todo(p[0], construct_warnings("div64_u64"))
+
+@script:python depends on org@
+p << r.p;
+sl64 << r.sl64;
+@@
+
+coccilib.org.print_todo(p[0], construct_warnings("div64_s64"))
+
+@script:python depends on report@
+p << r.p;
+ul << r.ul;
+@@
+
+coccilib.report.print_report(p[0], construct_warnings("div64_ul"))
+
+@script:python depends on report@
+p << r.p;
+l << r.l;
+@@
+
+coccilib.report.print_report(p[0], construct_warnings("div64_long"))
+
+@script:python depends on report@
+p << r.p;
+sl64 << r.sl64;
+@@
+
+coccilib.report.print_report(p[0], construct_warnings("div64_s64"))
+
+@script:python depends on report@
+p << r.p;
+ul64 << r.ul64;
+@@
+
+coccilib.report.print_report(p[0], construct_warnings("div64_u64"))
-- 
2.23.0

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
