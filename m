Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7EE0CC6B34
	for <cocci@archiver.kernel.org>; Thu, 15 Oct 2026 09:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=ExvDT2AzoMDU82xsRrvps81uSchqujVYxtL0UzexeFU=;
  b=ueY0WCm9BfPPLV4nwQzO0QXew4NlKVysv08RgJCE05S0YzEEaQ5yvFVR
   Zwf+79w3Ahs2iIw4PfdWjvh6Tpumv+UKI9rmQ8R49UVNJKO28NIFHlGr5
   S6MYcm8WrTOy/pJpial/gEHJDa6rvDfFXq064/QiXZHOLWTCcIcays8cP
   Y=;
X-CSE-ConnectionGUID: i0hd8ym7RGajZHuU4QdPjg==
X-CSE-MsgGUID: iyn0CJa7SFmuTRGR0p9tPA==
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
X-IronPort-AV: E=Sophos;i="6.27,159,1787004000"; 
   d="scan'208";a="300323137"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Oct 2026 11:24:26 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 45B6B81A10; Thu, 15 Oct 2026 11:24:26 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 3682681D5B
	for <cocci@sympa.inria.fr>; Thu, 15 Oct 2026 10:33:30 +0200 (CEST)
X-CSE-ConnectionGUID: mHQkpLJjTU+xEYaRuYyO8Q==
X-CSE-MsgGUID: E1YlXdc1RGm4F+gxM73uyw==
IronPort-SDR: 6ad08fd9_oAMqoM5GP5ijd6JxNpbQe3xHF2lK+UkYEzrAjEC3xBSHcrQ
 JAE67No1o4se47WdZ/2k5oAqIKuPdzFxBrroCcQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HpAABhjtBqhaxujNlaHgEBCxIMggULgkEWgVU0BwhJt?=
 =?us-ascii?q?GoUgSs9Ag8BAwFbAQIEAQEBAgSEfo4XAh8GAQQwCQ4BAgQDAgMBAQEBAQEBA?=
 =?us-ascii?q?QEBAQsBAQEEAQEBAgEBAgQDAQEBAQIQAQEBAUBJhk8NjBoBgSReSAEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBARQCCGMBISsLAQ0BATcBKIEUARKDAoIjB0sHvRkzg?=
 =?us-ascii?q?QGCDAEBBtw0gWgBAgkUAYE4hXKHcXaEAoEhD4FVRIR+hCmGX4ImehKKEAOMd?=
 =?us-ascii?q?0iBHgNZLAFVEw0KCwcFgTUzAyAKCxISGBUCFC8PGjIdcAwnEiwXgQcbBgWBH?=
 =?us-ascii?q?XUrghYjGTZ6gQlegSspYAEQF4EJggcCglSCAAIBSUEOB0VTCSVDEkcmIggSC?=
 =?us-ascii?q?QETGjALgRs4PAkoQRcMcQIJAx0FTgIiCAINCQ0YDUgRLDcGDxkEPm4HkXweg?=
 =?us-ascii?q?mWBD4IolxKuY4EKNAeEIYFgBgyfak2EBJQXklQuh2aQdCOCNqhROoFcMxojg?=
 =?us-ascii?q?zdQAxkPjiIMDQmDYM47RjI9AgcCBw4DC4VEAQGMVoFMAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:LXpXx6zlzWDcgDgSsK8YKrPwO71zdoMgy1knxilNoHtuA6ilfq
 GV7ZEmPHrP4wr5N0tMpTntAsa9qArnlaKduLNhXotKPzOW2ldATrsC0WKK+VSJcREWndQy6U
 4PScRDNOE=
X-Talos-CUID: 9a23:/DL+DW+PX9pXsk5A5j6Vv0s0I8M9Vl/f8EqTM2KJAFx0eayyGWbFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3AXm3nug7cFGQ1LRs7YRVD2gIhxoxFupWqOEwGyK8?=
 =?us-ascii?q?pvpWqdiNgHmjGkSWoF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,159,1787004000"; 
   d="scan'208";a="159882731"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDExC70j13PO8+ihldIfrlDB0huppXt/9U8Kwk?=
 =?us-ascii?q?R7qqFET1zZEpQLAp7DTIlIHnoQJcKpE/NolgAqdO1diNk3EmZE2g+hlP?=
 =?us-ascii?q?4uAQcjX2ch9mKbQyGgHFa9w3xk9qh73keKg9zFnaJRmhHXb6xjbkj9Kn?=
 =?us-ascii?q?3vo752QE+nm+2RTc2UsXFLCg=3D=3D?=
Received: from foss.arm.com ([217.140.110.172])
  by mail3-smtp-sop.national.inria.fr with ESMTP; 15 Oct 2026 10:33:28 +0200
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C73D2F;
	Thu, 15 Oct 2026 01:33:23 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.88.29])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4AEA93F871;
	Thu, 15 Oct 2026 01:33:22 -0700 (PDT)
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
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cocci@inria.fr,
	Christian Loehle <christian.loehle@arm.com>
Date: Thu, 15 Oct 2026 09:33:17 +0100
Message-Id: <20261015083317.3733733-1-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCHv2] sched: Replace nr_iowait_cpu() with a bool
 accessor
Reply-To: Christian Loehle <christian.loehle@arm.com>
X-Loop: cocci@inria.fr
X-Sequence: 3753
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-10/7OCe-NXNyFJZ0uUXWCO-yQ>

The menu governor was the last consumer of the per-CPU I/O-wait count
that needed its magnitude, apart from nr_iowait() summing it globally.
Commit 38f83090f515 ("cpuidle: menu: Remove iowait influence") removed
that use. All remaining per-CPU consumers only test for zero/nonzero.

Replace nr_iowait_cpu() with bool cpu_has_iowait() and update the generic
and s390 idle accounting callers. Have nr_iowait() read the counters
directly so that the global total and existing accounting are preserved.
Replace the stale menu comment with a description of the predicate.

The conversion was done with coccinelle:

@ predicate depends on patch @
expression cpu;
@@

- nr_iowait_cpu(cpu) > 0
+ cpu_has_iowait(cpu)

@ callers depends on patch @
expression cpu;
@@

- nr_iowait_cpu(cpu)
+ cpu_has_iowait(cpu)

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
v2: Move the cocci excerpt to the commit message (Peter)


 arch/s390/kernel/idle.c    |  4 ++--
 include/linux/sched/stat.h |  2 +-
 kernel/sched/core.c        | 13 +++++--------
 kernel/sched/cputime.c     | 10 +++++-----
 4 files changed, 13 insertions(+), 16 deletions(-)

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
 
-- 
2.34.1

