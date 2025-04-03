Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E4A6C36014
	for <cocci@archiver.kernel.org>; Thu,  3 Apr 2025 02:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:mime-version:
   content-transfer-encoding:sender:subject:reply-to:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=ZK+Fa8j60QJHXp8UVcWimQ95QtX5PdTafglcvWHGs+w=;
  b=MrUrImPD00n6YkZkQbGbnWJS44RvmJA268pxJUJuIZ6/zm/JV9cDFHgW
   bD4jFFq9Tpq0D8cYbLfXTF+GxZxNtcMftqyxpzz3mW2HMVeI3JVDkMO5J
   BheRSsqmqPZ72pkMRR1gw2XqJhnF7waQvZ5CBaKGkRb9dK9aDX7zNCwYR
   Q=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@infradead.org
X-IronPort-AV: E=Sophos;i="6.15,183,1739833200"; 
   d="scan'208";a="216102494"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Apr 2025 04:01:37 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4BEEAE0261; Thu,  3 Apr 2025 04:01:37 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 86CA2E007A
	for <cocci@sympa.inria.fr>; Thu,  3 Apr 2025 04:01:34 +0200 (CEST)
IronPort-SDR: 67edebfe_ZESA6P6R7OgP2suNsbgU2ThuiE3o0HFxjhOfYNlLEdaq9yN
 B5gIYEyEuVQrYJx3wrhopncyE6Xtpe+Wb5NH5kg==
X-IPAS-Result: =?us-ascii?q?A0GPAABA6u1nhYXKicZaHQEBAQEJARIBBQUBQIFCBQELA?=
 =?us-ascii?q?YJDfVk0BAtIBIRRkXKBFopgkjSBeQEDAQ05CwQBAQMEgWsBjj8CHgYGMwYOA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABAQEBQEmFQQEGATINg?=
 =?us-ascii?q?luBLIEmAQEBAQEBAQEBAQEBHQINgR4BCA8BDQEBNwEQCBwCGA4CcYMCAYJkA?=
 =?us-ascii?q?xGSQZtLeoEygQGCDAEBBt4FAwaBGi4BiE8BhHyFZycbfYEQgRWBO21KdoQGh?=
 =?us-ascii?q?BiCaYVzgWqKXot3iyGJYEiBBRwDWSwBVRMNCgsHBWGBCwM1DAsuFYFFe4I9a?=
 =?us-ascii?q?Uk6Ag0CNYIbfIImhEuEPIRAhU2CEYIEiR6EF0YtT4N9HUADCxgNSBEsNxQbB?=
 =?us-ascii?q?j0BbgejPAE6g0lcDgsHASwQGwEbBxMBByRUCSgMPDcbPwgRA5JAFJAfgiChB?=
 =?us-ascii?q?oQljBiVMBozqleYfowMgXmTPYJSN4RogX0kgVx9CBohgmcTPAMZD4dXhFeBc?=
 =?us-ascii?q?wsCFYhrxVAmMgIBOQIHAQoBAQMJj2gsCIFLAQE?=
IronPort-PHdr: A9a23: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
 DrdFFXsbGzrf9zBVhahK+hAgSiXehtEt9PlGis=
IronPort-Data: A9a23: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
 b4biYdAD6B6F0H/YZcUhu8=
IronPort-HdrOrdr: A9a23:66WxlKF8XI5RDkoOpLqE5ceALOsnbusQ8zAXPo5KJiC9Ffbo8/
 xG/c5rsCMc7Qx7ZJhOo7G90cW7LE80lqQFg7X5X43DYOCOggLBRr2KwrGSpAEIcBeRygcy78
 tdmtBFeb7NMWQ=
X-Talos-CUID: =?us-ascii?q?9a23=3ApLo3AGtuRcVGVAdbUho9zZsm6IsXfibX0liBBHW?=
 =?us-ascii?q?oMk1bYoaUFlOr5KdNxp8=3D?=
X-Talos-MUID: 9a23:91j4mQpgCGcxYYHZj1oez21sa/1134STNGQAjtIehNLZHnRBJTjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,183,1739833200"; 
   d="scan'208";a="216102491"
X-MGA-submission: =?us-ascii?q?MDHStFBMO1CbUx+cfYJdgIA45+Q3075SfwSNoH?=
 =?us-ascii?q?PvptZtrlZxLcMrvp7l2ku5+9OI35bTXIqbRyBlIOhC6RXXqg6awNtnkX?=
 =?us-ascii?q?SuFd3s7oZVWDBEmH/qcL6C6ljo+Yvdxk09chITLE0bbuR/yWUK3YZ8IZ?=
 =?us-ascii?q?MgXaLmAHazRTrh484t3Si8Nw=3D=3D?=
Received: from bombadil.infradead.org ([198.137.202.133])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 04:01:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=ZK+Fa8j60QJHXp8UVcWimQ95QtX5PdTafglcvWHGs+w=; b=uMEdsQ7sE2/nQrV+34c4ktZeFU
	fpAG5AfPTS3yb8poyGtcniv8xhNenDwQLQP+/5v4L3Fu0bEK0dgIZKqTrXgsUd8hcaHmlyGw+Ru/B
	mTCVurJ8XBPuZoxLvwh92C/SSxKk4juLgiI+zXcxBzZSa63mvpRMFa+f0NfnhsijOxwtoPaTRDn9m
	LW81jHznbJcO/Bm2EcwPeYW3PZ1nvyKAy/A9b1X1AV9YNl6TBtuBXbcsr4i/LQV/mZQq9A4M8LjOp
	JsF16cNkuqWGhRz2d82ptY/mAX+C1f1co8o+w3UcTXmi9QQTEFn0CYGMkzt5FxtjtSiMxyPG0Um4B
	L7OZUwQA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u09tX-00000007a3W-3org;
	Thu, 03 Apr 2025 02:01:27 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: kdevops@lists.linux.dev
Cc: cocci@inria.fr,
	julia.lawall@inria.fr,
	dave@stgolabs.net,
	jack@suse.cz,
	gost.dev@samsung.com,
	Luis Chamberlain <mcgrof@kernel.org>
Date: Wed,  2 Apr 2025 19:01:20 -0700
Message-ID: <20250403020123.1806887-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: cocci-request@inria.fr
Subject: [cocci] [PATCH kdevops] scripts/coccinelle/generation: add example
 generation script
Reply-To: Luis Chamberlain <mcgrof@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 2682
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-04/20250403020123.1806887-1-mcgrof%40kernel.org>

To do complicated tasks it is sometimes a bit difficult to write
a coccinelle rule. Such is the case when you want to use the iterator,
which can be used to help check for nested set of calls.

An example use case of this is when we want to check if a routine
may call an atomic context, or if a routine is calling any known
existing sleep routines.

This adds some initial examples we can go and try to enhance over
time with some very specific specialized tasks. What we see is
it is even hard to have code generate code (cocci python code)
which we can easily maintain.

Fortunately AI does *grok* this. So no shame, *different* gen AI agents
helped me get these to where they are. I suspect we'll need gen AIs
agents to continue to maintain them as well and enhance them.

What we should do is once we have high confidence is start using it
for tests to ensure we respect some golden rules. These all take
a long time to run because of the nested stuff. Its complicated.

I wrote these try to help with a bug we're trying to fix upstream [0]
on determining if __find_get_block_slow() really can't block and ...
determining exactly  *why*.

[0] https://lore.kernel.org/all/20250330064732.3781046-1-mcgrof@kernel.org/

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 
Posting this in case this is useful to others. I'll be merging it to
kdevops now, but long term if we find value, we can move to Linux too.
It has low confidence for now and so needs much more work and a bit more
of AI & human love.

 .../generation/check_for_atomic_calls.py      | 443 ++++++++++++
 .../generation/check_for_sleepy_calls.py      | 678 ++++++++++++++++++
 2 files changed, 1121 insertions(+)
 create mode 100755 scripts/coccinelle/generation/check_for_atomic_calls.py
 create mode 100755 scripts/coccinelle/generation/check_for_sleepy_calls.py

diff --git a/scripts/coccinelle/generation/check_for_atomic_calls.py b/scripts/coccinelle/generation/check_for_atomic_calls.py
new file mode 100755
index 000000000000..5849f9643de5
--- /dev/null
+++ b/scripts/coccinelle/generation/check_for_atomic_calls.py
@@ -0,0 +1,443 @@
+#!/usr/bin/env python3
+#
+# Copyright (C) 2025 Luis Chamberlain <mcgrof@kernel.org>
+# SPDX-License-Identifier: GPL-2.0-or-later OR copyleft-next-0.3.1
+
+# Generates a Coccinelle file which can be used to track down if a routine
+# can sleep up to --max-depth levels (defauilt is 1). You can either specify
+# the sleep routine you want to check for, or you can use our built-in db.
+# Huge work in progress, but its a start.
+#
+# This is work in progress.
+# Confidence: low
+
+import multiprocessing
+import argparse
+
+"""
+Generate a Coccinelle semantic patch that checks for atomic context
+in any transitive caller (up to N levels) of a target function.
+Example usage:
+    ./check_for_atomic_calls.py --levels 5 --target __find_get_block_slow --output atomic_check_find_block.cocci
+    make coccicheck MODE=report COCCI=find_block_check.cocci
+For an obvious atomic call:
+    ./check_for_atomic_calls.py --levels 5 --target netif_rx --output netif_rx.cocci
+    make coccicheck MODE=report COCCI=netif_rx.cocci
+"""
+parser = argparse.ArgumentParser(
+    description="Generate a Coccinelle checker for atomic context in transitive callers of a target function."
+)
+parser.add_argument(
+    "--levels", "-l",
+    type=int,
+    required=True,
+    help="Maximum number of transitive caller levels to follow (e.g., 5)"
+)
+parser.add_argument(
+    "--target", "-t",
+    type=str,
+    required=True,
+    help="Target function to trace (e.g., __find_get_block_slow)"
+)
+parser.add_argument(
+    "--output", "-o",
+    type=str,
+    required=True,
+    help="Output .cocci file to generate"
+)
+args = parser.parse_args()
+max_depth = args.levels
+target_func = args.target
+
+# Add a function to get the number of processors for parallel jobs
+def get_nprocs():
+    try:
+        return multiprocessing.cpu_count()
+    except:
+        return 1  # Default to 1 if can't determine
+
+outfile = args.output
+header = f"""// SPDX-License-Identifier: GPL-2.0
+/// Autogenerated by gen_atomic_context_chain.py
+/// Detect atomic context in ANY transitive caller (up to {max_depth} levels)
+/// of `{target_func}`
+// Options: --no-includes --include-headers
+virtual after_start
+virtual report
+@initialize:python@
+@@
+seen = set()
+seen_atomic = set()
+seen_irq_regions = set()
+seen_spinlock_regions = set()
+
+def register_caller(fn, file):
+    if fn not in seen:
+        seen.add(fn)
+        it = Iteration()
+        if file is not None:
+            it.set_files([file])
+        it.add_virtual_rule("after_start")
+        it.add_virtual_identifier("transitive_caller", fn)
+        it.register()
+
+// Look for direct calls to the target function
+@seed@
+identifier fn;
+position p;
+@@
+fn@p(...) {{
+  <+... {target_func}(...); ...+>
+}}
+
+@script:python depends on seed@
+fn << seed.fn;
+p  << seed.p;
+@@
+print(f"🌱 SEED HIT: {{fn}} calls {target_func} at {{p[0].file}}:{{p[0].line}}")
+register_caller(fn, p[0].file)
+
+// Special pattern for IRQ handler detection in macro definitions
+@irq_handler_def@
+identifier fn;
+@@
+(
+DEFINE_IRQ_HANDLER(fn, ...)
+|
+DECLARE_TASKLET(fn, ...)
+)
+
+@script:python depends on irq_handler_def@
+fn << irq_handler_def.fn;
+@@
+print(f"⚡ DEFINED IRQ HANDLER: {{fn}}")
+register_caller(fn, None)
+
+// Look for irq-related function names that haven't been caught yet
+@irq_func_names@
+identifier fn =~ "(_irq|_intr|_isr|_napi|_poll|_tasklet|_softirq|_bh)$";
+@@
+
+fn(...) {{ ... }}
+
+@script:python depends on irq_func_names@
+fn << irq_func_names.fn;
+@@
+print(f"⚡ NAMED IRQ HANDLER: {{fn}}")
+register_caller(fn, None)
+
+// Look for functions with interrupt prefix naming patterns
+@interrupt_prefixed@
+identifier fn =~ "^(irq_|intr_|isr_|napi_|poll_|do_softirq|tasklet_)";
+@@
+
+fn(...) {{ ... }}
+
+@script:python depends on interrupt_prefixed@
+fn << interrupt_prefixed.fn;
+@@
+print(f"⚡ PREFIXED IRQ HANDLER: {{fn}}")
+register_caller(fn, None)
+"""
+with open(outfile, "w") as f:
+    f.write(header)
+    
+    # Generate all the caller chain rules
+    for level in range(1, max_depth + 1):
+        f.write(f"""
+// Level {level} caller discovery
+@caller{level} depends on after_start exists@
+identifier virtual.transitive_caller;
+identifier fn;
+position p;
+@@
+fn@p(...) {{
+  <+... transitive_caller(...); ...+>
+}}
+
+@script:python depends on caller{level}@
+fn << caller{level}.fn;
+p << caller{level}.p;
+transitive_caller << virtual.transitive_caller;
+@@
+print(f"🔄 Chain level {level}: {{fn}} calls {{transitive_caller}} at {{p[0].file}}:{{p[0].line}}")
+register_caller(fn, p[0].file)
+""")
+
+    # Check for atomic context in each caller in our chain
+    for level in range(1, max_depth + 1):
+        # First, check for common atomic primitives
+        f.write(f"""
+// Level {level} atomic context check - Common atomic primitives
+@atomiccheck{level} depends on after_start exists@
+identifier virtual.transitive_caller;
+position p1, p2;
+@@
+(
+spin_lock@p1(...)
+|
+spin_lock_irq@p1(...)
+|
+spin_lock_irqsave@p1(...)
+|
+spin_lock_bh@p1(...)
+|
+read_lock@p1(...)
+|
+read_lock_irq@p1(...)
+|
+read_lock_irqsave@p1(...)
+|
+read_lock_bh@p1(...)
+|
+write_lock@p1(...)
+|
+write_lock_irq@p1(...)
+|
+write_lock_irqsave@p1(...)
+|
+write_lock_bh@p1(...)
+|
+raw_spin_lock@p1(...)
+|
+raw_spin_lock_irq@p1(...)
+|
+raw_spin_lock_irqsave@p1(...)
+|
+raw_spin_lock_bh@p1(...)
+|
+local_irq_disable@p1()
+|
+local_irq_save@p1(...)
+|
+local_bh_disable@p1()
+|
+preempt_disable@p1()
+|
+in_atomic@p1()
+|
+in_atomic_preempt_off@p1()
+|
+in_interrupt@p1()
+|
+in_irq@p1()
+|
+in_serving_softirq@p1()
+|
+in_nmi@p1()
+|
+in_task@p1()
+|
+rcu_read_lock@p1()
+|
+irq_enter@p1()
+|
+napi_disable@p1(...)
+)
+...
+transitive_caller@p2(...)
+
+@script:python depends on atomiccheck{level}@
+p1 << atomiccheck{level}.p1;
+p2 << atomiccheck{level}.p2;
+transitive_caller << virtual.transitive_caller;
+@@
+key = (p1[0].file, p1[0].line, transitive_caller)
+if key not in seen_atomic:
+    seen_atomic.add(key)
+    print(f"⚠️  WARNING: atomic context at level {level}: {{p1[0].current_element}} at {{p1[0].file}}:{{p1[0].line}} may reach {{transitive_caller}}() → eventually {target_func}()")
+""")
+
+        # Check for lock-related functions directly calling our chain
+        f.write(f"""
+// Level {level} atomic context check - Lock-related functions
+@atomic_fn_check{level} depends on after_start exists@
+identifier virtual.transitive_caller;
+identifier lock_fn;
+position p;
+@@
+// Common locking function patterns
+lock_fn(...) {{
+  ... when != unlock_irqrestore(...)
+      when != local_irq_restore(...)
+      when != spin_unlock(...)
+      when != rcu_read_unlock(...)
+  transitive_caller@p(...)
+  ...
+}}
+
+@script:python depends on atomic_fn_check{level}@
+lock_fn << atomic_fn_check{level}.lock_fn;
+p << atomic_fn_check{level}.p;
+transitive_caller << virtual.transitive_caller;
+@@
+# Only report functions with lock-related names
+atomic_keywords = ['lock', 'irq', 'atomic', 'bh', 'intr', 'preempt', 'disable', 'napi', 'rcu']
+if any(kw in lock_fn.lower() for kw in atomic_keywords):
+    print(f"⚠️  WARNING: potential atomic function at level {level}: {{lock_fn}} (name suggests lock handling) contains call to {{transitive_caller}}() at {{p[0].file}}:{{p[0].line}} → eventually {target_func}()")
+""")
+
+        # Check for spinlock regions
+        f.write(f"""
+// Level {level} spinlock region check
+@spinlock_region{level} depends on after_start exists@
+identifier virtual.transitive_caller;
+expression E1, flags;
+position p1, p3;
+@@
+(
+spin_lock@p1(E1,...)
+|
+spin_lock_irq@p1(E1,...)
+|
+spin_lock_irqsave@p1(E1, flags)
+|
+spin_trylock@p1(E1)
+|
+raw_spin_lock@p1(E1,...)
+|
+raw_spin_lock_irq@p1(E1,...)
+|
+raw_spin_lock_irqsave@p1(E1, flags)
+|
+raw_spin_trylock@p1(E1)
+)
+... when != spin_unlock(E1,...)
+    when != spin_unlock_irq(E1,...)
+    when != spin_unlock_irqrestore(E1, flags)
+    when != raw_spin_unlock(E1,...)
+    when != raw_spin_unlock_irq(E1,...)
+    when != raw_spin_unlock_irqrestore(E1, flags)
+transitive_caller@p3(...)
+
+@script:python depends on spinlock_region{level}@
+p1 << spinlock_region{level}.p1;
+p3 << spinlock_region{level}.p3;
+transitive_caller << virtual.transitive_caller;
+@@
+key = (p1[0].file, p1[0].line, p3[0].line, transitive_caller)
+if key not in seen_spinlock_regions:
+    seen_spinlock_regions.add(key)
+    print(f"⚠️  WARNING: spinlock region at level {level}: {{p1[0].current_element}} at {{p1[0].file}}:{{p1[0].line}} contains call to {{transitive_caller}}() at line {{p3[0].line}} → eventually {target_func}()")
+""")
+
+        # Look for functions that can't sleep
+        f.write(f"""
+// Level {level} check - Can't sleep contexts
+@cant_sleep{level} depends on after_start exists@
+identifier virtual.transitive_caller;
+position p1, p2;
+@@
+(
+GFP_ATOMIC@p1
+|
+cond_resched@p1()
+|
+__GFP_ATOMIC@p1
+|
+DECLARE_COMPLETION@p1(...)
+)
+...
+transitive_caller@p2(...)
+
+@script:python depends on cant_sleep{level}@
+p1 << cant_sleep{level}.p1;
+p2 << cant_sleep{level}.p2;
+transitive_caller << virtual.transitive_caller;
+@@
+print(f"⚠️  WARNING: Non-sleeping context at {{p1[0].file}}:{{p1[0].line}} but calls {{transitive_caller}}() at line {{p2[0].line}} → eventually {target_func}()")
+""")
+
+        # Check for network driver contexts
+        f.write(f"""
+// Level {level} check - Network driver contexts (commonly atomic)
+@netdriver{level} depends on after_start exists@
+identifier virtual.transitive_caller;
+position p1, p2;
+@@
+(
+alloc_skb@p1(...)
+|
+netif_receive_skb@p1(...)
+|
+netdev_alloc_skb@p1(...)
+|
+napi_complete@p1(...)
+|
+napi_schedule@p1(...)
+|
+napi_gro_receive@p1(...)
+|
+skb_reserve@p1(...)
+|
+consume_skb@p1(...)
+|
+dev_consume_skb_any@p1(...)
+|
+skb_put@p1(...)
+|
+skb_push@p1(...)
+|
+netif_rx_ni@p1(...)
+)
+...
+transitive_caller@p2(...)
+
+@script:python depends on netdriver{level}@
+p1 << netdriver{level}.p1;
+p2 << netdriver{level}.p2;
+transitive_caller << virtual.transitive_caller;
+@@
+print(f"⚠️  WARNING: Network driver context at {{p1[0].file}}:{{p1[0].line}} but calls {{transitive_caller}}() at line {{p2[0].line}} → eventually {target_func}()")
+""")
+
+        # Check for functions that might call from atomic context by name
+        f.write(f"""
+// Level {level} check - Function with name suggesting atomic context
+@atomic_name{level} depends on after_start exists@
+identifier virtual.transitive_caller;
+identifier atomic_fn =~ "(_irq|_intr|_isr|_napi|_poll|_bh|_softirq|_tasklet|_atomic)$";
+position p;
+@@
+atomic_fn(...) {{
+...
+transitive_caller@p(...)
+...
+}}
+
+@script:python depends on atomic_name{level}@
+atomic_fn << atomic_name{level}.atomic_fn;
+p << atomic_name{level}.p;
+transitive_caller << virtual.transitive_caller;
+@@
+print(f"⚠️  WARNING: Function with atomic-suggesting name {{atomic_fn}} calls {{transitive_caller}}() at {{p[0].file}}:{{p[0].line}} → eventually {target_func}()")
+""")
+
+        # Check for sleep-incompatible contexts but target function might sleep
+        f.write(f"""
+// Level {level} check - Target function called in context where might_sleep is used
+@might_sleep_check{level} depends on after_start exists@
+identifier virtual.transitive_caller;
+position p1, p2;
+@@
+(
+might_sleep@p1()
+|
+might_sleep_if@p1(...)
+|
+sched_might_sleep@p1()
+) 
+...
+transitive_caller@p2(...)
+
+@script:python depends on might_sleep_check{level}@
+p1 << might_sleep_check{level}.p1;
+p2 << might_sleep_check{level}.p2;
+transitive_caller << virtual.transitive_caller;
+@@
+print(f"⚠️  WARNING: Function has might_sleep() at {{p1[0].file}}:{{p1[0].line}} but also calls {{transitive_caller}}() at line {{p2[0].line}} → eventually {target_func}()")
+""")
+
+    f.write("\n")
+
+print(f"✅ Generated {outfile} with enhanced atomic checks for `{target_func}` up to {max_depth} levels. Run with: make coccicheck MODE=report COCCI={outfile} J={get_nprocs()}")
diff --git a/scripts/coccinelle/generation/check_for_sleepy_calls.py b/scripts/coccinelle/generation/check_for_sleepy_calls.py
new file mode 100755
index 000000000000..87bd5b264203
--- /dev/null
+++ b/scripts/coccinelle/generation/check_for_sleepy_calls.py
@@ -0,0 +1,678 @@
+#!/usr/bin/env python3
+#
+# Copyright (C) 2025 Luis Chamberlain <mcgrof@kernel.org>
+# SPDX-License-Identifier: GPL-2.0-or-later OR copyleft-next-0.3.1
+
+# Generates a Coccinelle file which can be used to track down if a routine
+# may be called from any known atomic context. Much work to de done with this.
+# Huge work in progress, but its a start.
+#
+# This is work in progress.
+# Confidence: low
+
+import argparse
+import multiprocessing
+import os
+import tempfile
+import json
+
+"""
+Generate a Coccinelle semantic patch that checks if a given function
+calls any functions that might sleep. It generates a report and the
+goal is to collect stats at the end as well.
+
+Example usage:
+    ./check_for_sleepy_calls.py --function folio_mc_copy --sleepy-function cond_resched --expected --max-depth 1 --output specific_sleep_check.cocci
+    make coccicheck MODE=report COCCI=specific_sleep_check.cocci
+
+Or to check for sleep function called:
+    ./check_for_sleepy_calls.py --function __find_get_block_slow --max-depth 1   --output all_sleep_check.cocci
+    make coccicheck MODE=report COCCI=all_sleep_check.cocci
+"""
+
+parser = argparse.ArgumentParser(
+    description="Generate a Coccinelle checker to find sleeping functions called by a target function."
+)
+parser.add_argument(
+    "--function", "-f",
+    type=str,
+    required=True,
+    help="Target function to analyze (e.g., netif_rx_ni)"
+)
+parser.add_argument(
+    "--max-depth", "-d",
+    type=int,
+    default=3,
+    help="Maximum depth of function call chain to analyze (default: 3)"
+)
+parser.add_argument(
+    "--output", "-o",
+    type=str,
+    required=True,
+    help="Output .cocci file to generate"
+)
+parser.add_argument(
+    "--sleepy-function", "-s",
+    type=str,
+    default=None,
+    help="Specific function to check for that may cause sleeping (e.g., folio_wait_locked)"
+)
+parser.add_argument(
+    "--expected", "-e",
+    action="store_true",
+    default=False,
+    help="Indicate that the function is expected to have a sleep path (verified by manual inspection)"
+)
+args = parser.parse_args()
+target_func = args.function
+max_depth = args.max_depth
+outfile = args.output
+sleepy_func = args.sleepy_function
+expected_to_sleep = args.expected
+
+# Add a function to get the number of processors for parallel jobs
+def get_nprocs():
+    try:
+        return multiprocessing.cpu_count()
+    except:
+        return 1  # Default to 1 if can't determine
+
+# List of common functions known to sleep
+known_sleepy_functions = [
+    "msleep", "ssleep", "usleep_range", "schedule", "schedule_timeout",
+    "wait_event", "wait_for_completion", "mutex_lock", "down_read", "down_write",
+    "kthread_create", "kthread_run", "kmalloc", "__kmalloc", "kmem_cache_alloc", 
+    "vmalloc", "vzalloc", "kvmalloc", "kzalloc", "__vmalloc", "kvzalloc",
+    "sock_create", "sock_create_kern", "sock_create_lite", "sock_socket", 
+    "filp_open", "open_bdev_exclusive", "create_workqueue", 
+    "alloc_workqueue", "__alloc_workqueue_key", "request_threaded_irq",
+    "request_module", "try_module_get", "module_put", "printk", "GFP_KERNEL",
+    "copy_from_user", "copy_to_user", "__copy_from_user", "__copy_to_user"
+]
+
+# If a specific sleepy function is provided, only check for that one
+if sleepy_func:
+    known_sleepy_functions = [sleepy_func]
+    print(f"Note: Only checking for calls to {sleepy_func}")
+
+# List of common GFP flags that indicate sleeping is allowed
+sleepy_gfp_flags = [
+    "GFP_KERNEL", "GFP_USER", "GFP_HIGHUSER", "GFP_DMA", 
+    "GFP_DMA32", "GFP_NOWAIT", "GFP_NOIO", "GFP_NOFS",
+    "__GFP_WAIT", "__GFP_IO", "__GFP_FS"
+]
+
+# Create a stats directory
+stats_dir = os.path.join(tempfile.gettempdir(), f"cocci_stats_{os.getpid()}")
+os.makedirs(stats_dir, exist_ok=True)
+
+# Generate the Coccinelle script
+with open(outfile, "w") as f:
+    title = f"Detect if function '{target_func}' calls any functions that might sleep"
+    if sleepy_func:
+        title = f"Detect if function '{target_func}' calls '{sleepy_func}'"
+    
+    f.write(f"""// SPDX-License-Identifier: GPL-2.0
+/// Autogenerated by check_for_sleepy_calls.py
+/// {title}
+// Options: --no-includes --include-headers
+
+virtual report
+
+@initialize:python@
+@@
+import re
+import os
+import json
+import hashlib
+import tempfile
+import time
+from datetime import datetime
+
+target_func = "{target_func}"
+sleepy_func = "{sleepy_func or ''}"
+expected_to_sleep = {str(expected_to_sleep).capitalize()}
+
+# Create a stats directory
+stats_dir = "{stats_dir}"
+os.makedirs(stats_dir, exist_ok=True)
+
+# Generate a unique ID for this process to avoid race conditions
+# Use a hash of time and process ID for uniqueness
+process_id = hashlib.md5(f"{{os.getpid()}}_{{time.time()}}".encode()).hexdigest()[:8]
+stats_file = os.path.join(stats_dir, f"stats_{{process_id}}.json")
+
+# Count of known sleepy functions we're checking for
+sleepy_funcs_count = {len(known_sleepy_functions) if not sleepy_func else 1}
+
+# Use sets to track what we've seen
+seen_calls = set()
+seen_sleep_points = set()
+seen_funcs = set([target_func])
+
+# Counters for work done
+total_funcs_analyzed = 0
+total_calls_checked = 0
+sleep_checks_performed = 0
+total_sleep_routines_checked = 0
+
+# Dictionary to track calls
+call_graph = dict()
+
+# List to track detailed sleep points for final report
+sleep_point_details = []
+
+def register_call(caller, callee, file, line):
+    global total_calls_checked
+    key = (caller, callee, file, line)
+    if key not in seen_calls:
+        seen_calls.add(key)
+        total_calls_checked += 1
+        
+        # Add to call graph for path tracking
+        if caller not in call_graph:
+            call_graph[caller] = []
+        call_graph[caller].append((callee, file, line))
+        
+        # Add to analysis queue
+        if callee not in seen_funcs:
+            seen_funcs.add(callee)
+        
+        return True
+    return False
+
+# Function to find path from target to a function
+def find_path_to(target, current=None, path=None, visited=None):
+    if current is None:
+        current = target_func
+    if path is None:
+        path = [current]
+    if visited is None:
+        visited = set([current])
+    
+    if current == target:
+        return path
+    
+    for callee, _, _ in call_graph.get(current, []):
+        if callee not in visited:
+            visited.add(callee)
+            new_path = path + [callee]
+            if callee == target:
+                return new_path
+            result = find_path_to(target, callee, new_path, visited)
+            if result:
+                return result
+    
+    return None
+
+# Function to register a sleep point
+def register_sleep_point(caller_func, sleep_func, file, line, reason=""):
+    global sleep_checks_performed
+    sleep_checks_performed += 1
+    
+    key = (caller_func, sleep_func, file, line)
+    if key not in seen_sleep_points:
+        seen_sleep_points.add(key)
+        
+        # Try to find call path
+        path = find_path_to(caller_func)
+        path_str = " → ".join(path) if path else caller_func
+        
+        # Use different symbol based on expected flag
+        symbol = "✅" if expected_to_sleep else "⚠️"
+        
+        if reason:
+            message = f"{{symbol}} {'VERIFIED' if expected_to_sleep else 'WARNING'}: {{caller_func}}() might sleep at {{file}}:{{line}} - {{reason}} (via {{sleep_func}})"
+            path_message = f"   Call path: {{path_str}} → {{sleep_func}}"
+            print(message)
+            print(path_message)
+        else:
+            message = f"{{symbol}} {'VERIFIED' if expected_to_sleep else 'WARNING'}: {{caller_func}}() might sleep at {{file}}:{{line}} (via {{sleep_func}})"
+            path_message = f"   Call path: {{path_str}} → {{sleep_func}}"
+            print(message)
+            print(path_message)
+        
+        # Store this for our final stats
+        if path:
+            path_value = path_str + " → " + sleep_func
+        else:
+            path_value = caller_func + " → " + sleep_func
+            
+        detail = dict()
+        detail["caller"] = caller_func
+        detail["sleep_func"] = sleep_func
+        detail["file"] = file
+        detail["line"] = line
+        detail["reason"] = reason
+        detail["path"] = path_value
+        sleep_point_details.append(detail)
+        
+        return True
+    return False
+
+# List to track functions we need to analyze next after this iteration
+functions_to_analyze = []
+
+def register_func_for_analysis(func_name):
+    global total_funcs_analyzed
+    if func_name not in seen_funcs:
+        seen_funcs.add(func_name)
+        functions_to_analyze.append(func_name)
+        total_funcs_analyzed += 1
+        print(f"🔍 Analyzing function: {{func_name}} (Total analyzed: {{total_funcs_analyzed}})")
+        return True
+    return False
+
+# Function to save statistics to our unique file
+def save_stats():
+    stats = dict()
+    stats["process_id"] = process_id
+    stats["timestamp"] = datetime.now().isoformat()
+    stats["target_func"] = target_func
+    stats["sleepy_func"] = sleepy_func
+    stats["total_funcs_analyzed"] = total_funcs_analyzed
+    stats["total_calls_checked"] = total_calls_checked
+    stats["total_sleep_routines_checked"] = total_sleep_routines_checked
+    stats["sleep_checks_performed"] = sleep_checks_performed
+    stats["seen_funcs_count"] = len(seen_funcs)
+    stats["seen_calls_count"] = len(seen_calls)
+    stats["seen_sleep_points_count"] = len(seen_sleep_points)
+    stats["sleep_point_details"] = sleep_point_details
+    
+    with open(stats_file, "w") as f:
+        json.dump(stats, f, indent=2)
+""")
+
+    # Define the rule to find direct calls to the target function
+    f.write(f"""
+// Find direct function calls made by target function
+@find_calls@
+identifier fn;
+position p;
+@@
+{target_func}(...) {{
+  <... 
+  fn@p(...);
+  ...>
+}}
+
+@script:python depends on find_calls@
+fn << find_calls.fn;
+p << find_calls.p;
+@@
+global total_calls_checked
+total_calls_checked += 1
+register_call(target_func, fn, p[0].file, p[0].line)
+register_func_for_analysis(fn)
+save_stats()
+""")
+
+    # Add direct checking for specific sleepy function if provided
+    if sleepy_func:
+        f.write(f"""
+// Direct check: Does target function call sleepy function directly?
+@direct_sleepy_call@
+position p;
+@@
+{target_func}(...) {{
+  <...
+  {sleepy_func}@p(...);
+  ...>
+}}
+
+@script:python depends on direct_sleepy_call@
+p << direct_sleepy_call.p;
+@@
+global total_sleep_routines_checked
+total_sleep_routines_checked += 1
+register_sleep_point(target_func, sleepy_func, p[0].file, p[0].line, "directly calls target sleep function")
+save_stats()
+""")
+    
+    # Generate rules for checking nested function calls
+    for depth in range(2, max_depth + 1):  # Start from 2 as level 1 is the direct call we already checked
+        # Find functions called by functions at the previous level
+        f.write(f"""
+// Level {depth} - Find functions called by level {depth-1} functions
+@find_calls_l{depth}@
+identifier fn1;
+identifier fn2;
+position p;
+@@
+fn1(...) {{
+  <...
+  fn2@p(...);
+  ...>
+}}
+
+@script:python depends on find_calls_l{depth}@
+fn1 << find_calls_l{depth}.fn1;
+fn2 << find_calls_l{depth}.fn2;
+p << find_calls_l{depth}.p;
+@@
+global total_calls_checked
+# Only analyze calls from functions we're tracking
+if fn1 in seen_funcs and fn1 != fn2:  # Avoid self-recursion
+    total_calls_checked += 1
+    register_call(fn1, fn2, p[0].file, p[0].line)
+    register_func_for_analysis(fn2)
+    save_stats()
+""")
+
+        if sleepy_func:
+            # If looking for a specific sleepy function, check at this level
+            f.write(f"""
+// Level {depth} - Find calls to sleepy function
+@sleepy_call_l{depth}@
+identifier fn;
+position p;
+@@
+fn(...) {{
+  <...
+  {sleepy_func}@p(...);
+  ...>
+}}
+
+@script:python depends on sleepy_call_l{depth}@
+fn << sleepy_call_l{depth}.fn;
+p << sleepy_call_l{depth}.p;
+@@
+global total_sleep_routines_checked
+total_sleep_routines_checked += 1
+# Only report if we're tracking this function
+if fn in seen_funcs:
+    register_sleep_point(fn, sleepy_func, p[0].file, p[0].line, f"level {depth} call to target sleep function")
+    save_stats()
+""")
+        else:
+            # If doing general sleep checking, check for known sleepy functions at this level
+            f.write(f"""
+// Level {depth} - Check for known sleepy functions
+@known_sleepers_l{depth}@
+identifier fn;
+position p;
+@@
+fn(...) {{
+  <...
+  (""")
+            # Add all known sleepy functions to the pattern
+            for i, sleepy_func_name in enumerate(known_sleepy_functions):
+                if i > 0:
+                    f.write(f"""
+  |""")
+                f.write(f"""
+  {sleepy_func_name}@p(...)""")
+            
+            f.write(f"""
+  )
+  ...>
+}}
+
+@script:python depends on known_sleepers_l{depth}@
+fn << known_sleepers_l{depth}.fn;
+p << known_sleepers_l{depth}.p;
+@@
+global total_sleep_routines_checked
+total_sleep_routines_checked += 1
+# Only report if we're tracking this function
+if fn in seen_funcs:
+    sleep_func = p[0].current_element
+    register_sleep_point(fn, sleep_func, p[0].file, p[0].line, f"level {depth} call to known sleeping function")
+    save_stats()
+""")
+
+    # Only add the other sleep detection rules if we're not constraining to a specific function
+    if not sleepy_func:
+        # Check for GFP_KERNEL and other sleepy allocation flags
+        f.write(f"""
+// Check for sleepy memory allocation flags
+@check_sleepy_alloc@
+position p;
+identifier fn;
+@@
+fn(...) {{
+  <...
+  (""")
+        # Add patterns for all sleepy GFP flags
+        for i, flag in enumerate(sleepy_gfp_flags):
+            if i > 0:
+                f.write(f"""
+  |""")
+            f.write(f"""
+  {flag}@p""")
+        f.write(f"""
+  )
+  ...>
+}}
+
+@script:python depends on check_sleepy_alloc@
+fn << check_sleepy_alloc.fn;
+p << check_sleepy_alloc.p;
+@@
+global total_sleep_routines_checked
+total_sleep_routines_checked += 1
+# Only report if we're tracking this function
+if fn in seen_funcs:
+    flag = p[0].current_element
+    register_sleep_point(fn, flag, p[0].file, p[0].line, "uses allocation flag that may sleep")
+    save_stats()
+""")
+
+        # Check for mutex locks
+        f.write(f"""
+// Check for mutex locks
+@check_mutex@
+position p;
+identifier fn;
+@@
+fn(...) {{
+  <...
+  (
+  mutex_lock@p(...)
+  |
+  mutex_lock_interruptible@p(...)
+  |
+  mutex_lock_killable@p(...)
+  |
+  down@p(...)
+  |
+  down_interruptible@p(...)
+  |
+  down_killable@p(...)
+  |
+  down_read@p(...)
+  |
+  down_write@p(...)
+  |
+  wait_for_completion@p(...)
+  |
+  wait_for_completion_interruptible@p(...)
+  |
+  wait_for_completion_killable@p(...)
+  |
+  wait_event@p(...)
+  |
+  wait_event_interruptible@p(...)
+  |
+  wait_event_killable@p(...)
+  )
+  ...>
+}}
+
+@script:python depends on check_mutex@
+fn << check_mutex.fn;
+p << check_mutex.p;
+@@
+global total_sleep_routines_checked
+total_sleep_routines_checked += 1
+# Only report if we're tracking this function
+if fn in seen_funcs:
+    lock_func = p[0].current_element
+    register_sleep_point(fn, lock_func, p[0].file, p[0].line, "uses mutex or completion that may sleep")
+    save_stats()
+""")
+
+        # Check for might_sleep calls
+        f.write(f"""
+// Check for explicit might_sleep calls
+@check_might_sleep@
+position p;
+identifier fn;
+@@
+fn(...) {{
+  <...
+  (
+  might_sleep@p(...)
+  |
+  might_sleep_if@p(...)
+  |
+  sched_might_sleep@p(...)
+  )
+  ...>
+}}
+
+@script:python depends on check_might_sleep@
+fn << check_might_sleep.fn;
+p << check_might_sleep.p;
+@@
+global total_sleep_routines_checked
+total_sleep_routines_checked += 1
+# Only report if we're tracking this function
+if fn in seen_funcs:
+    sleep_func = p[0].current_element
+    register_sleep_point(fn, sleep_func, p[0].file, p[0].line, "contains explicit might_sleep() call")
+    save_stats()
+""")
+
+        # Check for functions with names suggesting they might sleep
+        f.write(f"""
+// Check for functions with sleep-suggesting names
+@check_sleep_names@
+position p;
+identifier fn;
+identifier sleep_fn =~ "(_sleep|_timeout|_wait|_block|_sync|_lock|create_|alloc_|_kmalloc|_mutex)";
+@@
+fn(...) {{
+  <...
+  sleep_fn@p(...)
+  ...>
+}}
+
+@script:python depends on check_sleep_names@
+fn << check_sleep_names.fn;
+sleep_fn << check_sleep_names.sleep_fn;
+p << check_sleep_names.p;
+@@
+global total_sleep_routines_checked
+total_sleep_routines_checked += 1
+# Only report if we're tracking this function
+if fn in seen_funcs:
+    # Filter out known safe functions
+    if not (sleep_fn.startswith("spin_") or 
+            sleep_fn.startswith("rcu_") or 
+            sleep_fn.startswith("atomic_") or
+            sleep_fn.startswith("local_")):
+        register_sleep_point(fn, sleep_fn, p[0].file, p[0].line, "calls function with name suggesting it might sleep")
+        save_stats()
+""")
+
+    # Add a finalization rule that summarizes the findings
+    f.write(f"""
+@finalize:python@
+@@
+# Save any final stats before finishing
+save_stats()
+
+# Now collect all stats from all parallel processes
+def collect_and_merge_stats():
+    import glob
+    import json
+    
+    # Aggregate stats from all files
+    merged_stats = dict()
+    merged_stats["total_funcs_analyzed"] = 0
+    merged_stats["total_calls_checked"] = 0
+    merged_stats["total_sleep_routines_checked"] = 0
+    merged_stats["sleep_checks_performed"] = 0
+    merged_stats["seen_funcs"] = set()
+    merged_stats["seen_calls"] = set()
+    merged_stats["seen_sleep_points"] = set()
+    merged_stats["sleep_point_details"] = []
+    
+    # Get all stats files
+    stats_files = glob.glob(os.path.join(stats_dir, "stats_*.json"))
+    
+    for file_path in stats_files:
+        try:
+            with open(file_path, "r") as f:
+                stats = json.load(f)
+                
+                # Merge counters
+                merged_stats["total_funcs_analyzed"] = max(merged_stats["total_funcs_analyzed"], stats.get("total_funcs_analyzed", 0))
+                merged_stats["total_calls_checked"] = max(merged_stats["total_calls_checked"], stats.get("total_calls_checked", 0))
+                merged_stats["total_sleep_routines_checked"] = max(merged_stats["total_sleep_routines_checked"], stats.get("total_sleep_routines_checked", 0))
+                merged_stats["sleep_checks_performed"] = max(merged_stats["sleep_checks_performed"], stats.get("sleep_checks_performed", 0))
+                
+                # Merge sleep point details (avoiding duplicates)
+                for detail in stats.get("sleep_point_details", []):
+                    # Create a unique key for this sleep point
+                    key = f"{{detail['caller']}}_{{detail['sleep_func']}}_{{detail['file']}}_{{detail['line']}}"
+                    if key not in merged_stats["seen_sleep_points"]:
+                        merged_stats["seen_sleep_points"].add(key)
+                        merged_stats["sleep_point_details"].append(detail)
+        except Exception as e:
+            print(f"Error processing stats file {{file_path}}: {{e}}")
+    
+    return merged_stats
+
+# Collect all the stats from all processes
+merged_stats = collect_and_merge_stats()
+total_sleep_points = len(merged_stats["seen_sleep_points"])
+
+# Print statistics
+print(f"\\n📊 STATISTICS:")
+print(f"   - Functions analyzed: {{merged_stats['total_funcs_analyzed']}}")
+print(f"   - Function calls checked: {{merged_stats['total_calls_checked']}}")
+print(f"   - Sleep checks performed: {{merged_stats['sleep_checks_performed']}}")
+print(f"   - Sleep points found: {{total_sleep_points}}")
+
+if total_sleep_points > 0:
+    print(f"\\n📊 SUMMARY: Found {{total_sleep_points}} potential sleep points across {{merged_stats['total_funcs_analyzed']}} analyzed functions")
+    if sleepy_func:
+        print(f"⚠️  Function '{{target_func}}' calls '{{sleepy_func}}' through call chain!")
+    else:
+        print(f"⚠️  The function '{{target_func}}' might sleep when called from atomic contexts!")
+    
+    # Sort sleep points by call path for better readability in the summary
+    sorted_sleep_points = sorted(merged_stats["sleep_point_details"], key=lambda x: x["path"])
+    
+    # Print unique sleep paths
+    print("\\n📋 UNIQUE SLEEP PATHS:")
+    for idx, detail in enumerate(sorted_sleep_points, 1):
+        path = detail["path"]
+        print(f"   {{idx}}. {{path}}")
+else:
+    symbol = "✅" if expected_to_sleep else "⚠️"
+    if sleepy_func:
+        message = f"\n\n{{symbol}}: {{caller_func}}() can sleep at {{file}}:{{line}} - {{reason}} (via {{sleep_func}})"
+        print(message)
+    else:
+        message = f"\n\n{{symbol}}: {{caller_func}}() found to may sleep."
+        print(message)
+    
+print("\\nNOTE: This analysis is conservative and may produce false positives.")
+print("      Always manually verify the findings.")
+
+# Clean up the temporary stats directory
+import shutil
+try:
+    shutil.rmtree(stats_dir)
+except Exception as e:
+    print(f"Note: Could not clean up stats directory: {{e}}")
+""")
+
+msg = f"✅ Generated {outfile} to check if '{target_func}' might sleep"
+if sleepy_func:
+    msg = f"✅ Generated {outfile} to check if '{target_func}' calls '{sleepy_func}'"
+print(msg)
+print(f"Run with: make coccicheck MODE=report COCCI={outfile} J={get_nprocs()}")
-- 
2.47.2

