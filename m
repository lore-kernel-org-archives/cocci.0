Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE2ECC6B2A
	for <cocci@archiver.kernel.org>; Wed, 14 Oct 2026 14:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=1ETuZw4ez4gymC0BsStCwdItMw1Wvv8CIHKwpyV2/zk=;
  b=owHuoVWHFnlpjJjyLuR3sqYqZcq9UMAMtoczzufo0jr2ybrEhqwewGg3
   6Wjby+lmODWojvqZrOku2f+8TnyrZ2OmcAZhbdLYvkbwzDrW09RMYY3Yn
   QGoiJ2P7jqBQkeRaGaCaBYlESYAcn8tirPDCTvOmKI3ZBcQUG9F1A/Rn4
   A=;
X-CSE-ConnectionGUID: i97CVRLSSvmgd70Qt9u8/Q==
X-CSE-MsgGUID: +ZA/V66hTCqosAQ2y7cTHQ==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.27,158,1787004000"; 
   d="scan'208";a="300198249"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 14 Oct 2026 16:19:08 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 5D5BE807C5; Wed, 14 Oct 2026 16:19:08 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 0A3BE82839
	for <cocci@sympa.inria.fr>; Wed, 14 Oct 2026 15:48:07 +0200 (CEST)
X-CSE-ConnectionGUID: YmV/cTkcSiGXA7iux1755A==
X-CSE-MsgGUID: AHsgR26jR92O5v6GhVa/9A==
IronPort-SDR: 6acf8815_5GrbozDi0mOuFxeImDHAtOJM37BaLt6c8+D2QkMPYW60P6/
 T6aiR9grLuoEJe0FrbWcz2m087jLHynSzB4maQA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HpAABSh89qhaxujNlaHgEBCxIMggULgkEWgVU0BwhJj?=
 =?us-ascii?q?VKIeZ4dFIErPQIPAQMBWwECBAEBAQIEhH6OFwIfBgEEMAkOAQIEAwIDAQEBA?=
 =?us-ascii?q?QEBAQEBAQELAQEBBAEBAQIBAQIEAwEBAQECEAEBAQFASYZPDYwaAYEkXkgBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEUAghjASErCwENAQE3ASiBFAESgwKCIwdLB?=
 =?us-ascii?q?70EM4EBggwBAQbcNIFoAQIJFAGBOIVyh3GEeIEhD4FVRIEVg2mEKYZfgzKKE?=
 =?us-ascii?q?AOMVEiBHgNZLAFVEw0KCwcFgTUzAyAKCxISGBUCFC8PGjIdcAwnEiwXgQcbB?=
 =?us-ascii?q?gWBHXUrghYjGTZ6gQlegSspYAEQF4EJggcCglSCAAIBSUEOB0VTCSVDEkcmI?=
 =?us-ascii?q?ggSCQETGjALgRs4PAkoQRcMcQIJAx0FTgIRGA1IESw3Bg8ZBD5uB5FaHoJig?=
 =?us-ascii?q?Q4BgUNlYZYxrmSBCjQHhCGBYAYMn2pNhASUF5JTAS6HZpB0I4I2qFI6gVwzG?=
 =?us-ascii?q?iODN1ADGQ+OIgwNCYNgzjhGMj0CBwIHDgMLhUQBAYxWgUwBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 ajZiF2omH2GdHM=
IronPort-HdrOrdr: A9a23:NgwLq6vw6qAMqykTtosrN3aT7skDZdV00zEX/kB9WHVpmwKj+f
 xG+85rsSMc7Qx9ZJhOo7C90cW7LU80lqQFhLX5Q43SPzUO0VHAROoJ0WKI+Vzd8kPFmdK1rZ
 0QEZRDNA==
X-Talos-CUID: =?us-ascii?q?9a23=3AC8r8vGmbFentx0DvbRCvjCNlj0rXOUzY8jDbH0y?=
 =?us-ascii?q?zMmdGeJTKSEKAofw5zuM7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AYDOxEA3aKm0dVTUFEPPjDe3wcjUjyoS1B3pXz5c?=
 =?us-ascii?q?86pOjaDIuFDejhXPma9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,157,1787004000"; 
   d="scan'208";a="159813325"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDE+RkxuNfbP49GcZiutotgQXlmBHqvF7TLgK3?=
 =?us-ascii?q?SRsNE6pMoGwpUXV2IGshUiMYwMXY2qum09DlGUztaIzR8riKytxuYuD0?=
 =?us-ascii?q?k7XHCiz7IAIkeeCPUvX4gw9Io6gd5LaBoqXF5jlLKWX+GQYN7UIgTRfj?=
 =?us-ascii?q?xyCMptO+YrKsHQXE0l5WhHOg=3D=3D?=
Received: from foss.arm.com ([217.140.110.172])
  by mail3-smtp-sop.national.inria.fr with ESMTP; 14 Oct 2026 15:48:05 +0200
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD45A1570;
	Wed, 14 Oct 2026 06:47:58 -0700 (PDT)
Received: from e127648.cambridge.arm.com (e127648.arm.com [10.0.128.106])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C0F623F7B4;
	Wed, 14 Oct 2026 06:47:57 -0700 (PDT)
From: Christian Loehle <christian.loehle@arm.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cocci@inria.fr,
	Christian Loehle <christian.loehle@arm.com>
Date: Wed, 14 Oct 2026 14:47:45 +0100
Message-Id: <20261014134745.3032405-1-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH] sched: Replace nr_iowait_cpu() with a bool accessor
Reply-To: Christian Loehle <christian.loehle@arm.com>
X-Loop: cocci@inria.fr
X-Sequence: 3751
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-10/BgyZRnSOk5NJIQRBFRLksA>

The menu governor was the last consumer of the per-CPU I/O-wait count
that needed its magnitude, apart from nr_iowait() summing it globally.
Commit 38f83090f515 ("cpuidle: menu: Remove iowait influence") removed
that use. All remaining per-CPU consumers only test for zero/nonzero.

Replace nr_iowait_cpu() with bool cpu_has_iowait() and update the generic
and s390 idle accounting callers. Have nr_iowait() read the counters
directly so that the global total and existing accounting are preserved.
Replace the stale menu comment with a description of the predicate.

Include the Coccinelle recipe for the code conversion, verified against
the original files. The helper's comment is updated manually. Reproduce
the conversion with:

  make coccicheck COCCI=scripts/coccinelle/api/cpu_has_iowait.cocci MODE=patch

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 arch/s390/kernel/idle.c                     |  4 +-
 include/linux/sched/stat.h                  |  2 +-
 kernel/sched/core.c                         | 13 ++---
 kernel/sched/cputime.c                      | 10 ++--
 scripts/coccinelle/api/cpu_has_iowait.cocci | 56 +++++++++++++++++++++
 5 files changed, 69 insertions(+), 16 deletions(-)
 create mode 100644 scripts/coccinelle/api/cpu_has_iowait.cocci

diff --git a/arch/s390/kernel/idle.c b/arch/s390/kernel/idle.c
index dd12efb58201..ff9732ef494c 100644
--- a/arch/s390/kernel/idle.c
+++ b/arch/s390/kernel/idle.c
@@ -82,13 +82,13 @@ static u64 arch_cpu_idle_time(int cpu, enum cpu_usage_stat idx, bool compute_del
 
 u64 arch_kcpustat_field_idle(int cpu)
 {
-	return arch_cpu_idle_time(cpu, CPUTIME_IDLE, !nr_iowait_cpu(cpu));
+	return arch_cpu_idle_time(cpu, CPUTIME_IDLE, !cpu_has_iowait(cpu));
 }
 EXPORT_SYMBOL_GPL(arch_kcpustat_field_idle);
 
 u64 arch_kcpustat_field_iowait(int cpu)
 {
-	return arch_cpu_idle_time(cpu, CPUTIME_IOWAIT, nr_iowait_cpu(cpu));
+	return arch_cpu_idle_time(cpu, CPUTIME_IOWAIT, cpu_has_iowait(cpu));
 }
 EXPORT_SYMBOL_GPL(arch_kcpustat_field_iowait);
 
diff --git a/include/linux/sched/stat.h b/include/linux/sched/stat.h
index 0108a38bb64d..4810b14d0372 100644
--- a/include/linux/sched/stat.h
+++ b/include/linux/sched/stat.h
@@ -20,7 +20,7 @@ extern int nr_processes(void);
 extern unsigned int nr_running(void);
 extern bool single_task_running(void);
 extern unsigned int nr_iowait(void);
-extern unsigned int nr_iowait_cpu(int cpu);
+extern bool cpu_has_iowait(int cpu);
 
 static inline int sched_info_on(void)
 {
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1fe40de6ebe3..1bde5187dafd 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5588,15 +5588,12 @@ unsigned long long nr_context_switches(void)
 }
 
 /*
- * Consumers of these two interfaces, like for example the cpuidle menu
- * governor, are using nonsensical data. Preferring shallow idle state selection
- * for a CPU that has IO-wait which might not even end up running the task when
- * it does become runnable.
+ * Return whether any tasks are accounted as I/O waiters on this CPU.
+ * They may wake up on a different CPU.
  */
-
-unsigned int nr_iowait_cpu(int cpu)
+bool cpu_has_iowait(int cpu)
 {
-	return atomic_read(&cpu_rq(cpu)->nr_iowait);
+	return atomic_read(&cpu_rq(cpu)->nr_iowait) != 0;
 }
 
 /*
@@ -5634,7 +5631,7 @@ unsigned int nr_iowait(void)
 	unsigned int i, sum = 0;
 
 	for_each_possible_cpu(i)
-		sum += nr_iowait_cpu(i);
+		sum += atomic_read(&cpu_rq(i)->nr_iowait);
 
 	return sum;
 }
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 06bddaa738e5..1f84a950abed 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -431,7 +431,7 @@ static void kcpustat_idle_stop(struct kernel_cpustat *kc, u64 now)
 	if (!kc->idle_elapse)
 		return;
 
-	iowait = nr_iowait_cpu(smp_processor_id()) > 0;
+	iowait = cpu_has_iowait(smp_processor_id());
 	delta = now - kc->idle_entrytime;
 	steal = steal_account_process_time(delta);
 
@@ -544,14 +544,14 @@ static u64 kcpustat_field_dyntick(int cpu, enum cpu_usage_stat idx,
 u64 kcpustat_field_idle(int cpu)
 {
 	return kcpustat_field_dyntick(cpu, CPUTIME_IDLE,
-				      !nr_iowait_cpu(cpu), ktime_get());
+				      !cpu_has_iowait(cpu), ktime_get());
 }
 EXPORT_SYMBOL_GPL(kcpustat_field_idle);
 
 u64 kcpustat_field_iowait(int cpu)
 {
 	return kcpustat_field_dyntick(cpu, CPUTIME_IOWAIT,
-				      nr_iowait_cpu(cpu), ktime_get());
+				      cpu_has_iowait(cpu), ktime_get());
 }
 EXPORT_SYMBOL_GPL(kcpustat_field_iowait);
 #else
@@ -601,7 +601,7 @@ static u64 get_cpu_sleep_time_us(int cpu, enum cpu_usage_stat idx,
 u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time)
 {
 	return get_cpu_sleep_time_us(cpu, CPUTIME_IDLE,
-				     !nr_iowait_cpu(cpu), last_update_time);
+				     !cpu_has_iowait(cpu), last_update_time);
 }
 EXPORT_SYMBOL_GPL(get_cpu_idle_time_us);
 
@@ -625,7 +625,7 @@ EXPORT_SYMBOL_GPL(get_cpu_idle_time_us);
 u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time)
 {
 	return get_cpu_sleep_time_us(cpu, CPUTIME_IOWAIT,
-				     nr_iowait_cpu(cpu), last_update_time);
+				     cpu_has_iowait(cpu), last_update_time);
 }
 EXPORT_SYMBOL_GPL(get_cpu_iowait_time_us);
 
diff --git a/scripts/coccinelle/api/cpu_has_iowait.cocci b/scripts/coccinelle/api/cpu_has_iowait.cocci
new file mode 100644
index 000000000000..cc903b1d2586
--- /dev/null
+++ b/scripts/coccinelle/api/cpu_has_iowait.cocci
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Replace nr_iowait_cpu() with a boolean accessor after menu stopped using
+// the per-CPU count. Preserve the count used by nr_iowait().
+//
+// The accompanying update to the helper's comment is manual.
+//
+// Options: --include-headers
+
+virtual patch
+
+@ definition depends on patch @
+identifier cpu;
+typedef bool;
+@@
+
+- unsigned int nr_iowait_cpu(int cpu)
++ bool cpu_has_iowait(int cpu)
+  {
+-	return atomic_read(&cpu_rq(cpu)->nr_iowait);
++	return atomic_read(&cpu_rq(cpu)->nr_iowait) != 0;
+  }
+
+@ prototype_rule depends on patch @
+identifier cpu;
+typedef bool;
+@@
+
+- extern unsigned int nr_iowait_cpu
++ extern bool cpu_has_iowait
+  (int cpu);
+
+@ total depends on patch @
+expression cpu;
+@@
+
+ unsigned int nr_iowait(void)
+ {
+ <...
+- nr_iowait_cpu(cpu)
++ atomic_read(&cpu_rq(cpu)->nr_iowait)
+ ...>
+ }
+
+@ predicate depends on patch @
+expression cpu;
+@@
+
+- nr_iowait_cpu(cpu) > 0
++ cpu_has_iowait(cpu)
+
+@ callers depends on patch @
+expression cpu;
+@@
+
+- nr_iowait_cpu(cpu)
++ cpu_has_iowait(cpu)
-- 
2.34.1

