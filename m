Return-Path: <SRS0=lKqB=5J=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50769C4332B
	for <cocci@archiver.kernel.org>; Tue, 24 Mar 2020 13:04:43 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95D2B208CA
	for <cocci@archiver.kernel.org>; Tue, 24 Mar 2020 13:04:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95D2B208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02OD4JYD018582;
	Tue, 24 Mar 2020 14:04:19 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 9E00C77FC;
	Tue, 24 Mar 2020 14:04:19 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 3C7A67749
 for <cocci@systeme.lip6.fr>; Mon, 23 Mar 2020 23:03:12 +0100 (CET)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02NM3AfP019233
 (version=TLSv1.2 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Mon, 23 Mar 2020 23:03:11 +0100 (CET)
Received: from mail-qk1-f200.google.com ([209.85.222.200])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <gpiccoli@canonical.com>) id 1jGUtr-0004qo-ST
 for cocci@systeme.lip6.fr; Mon, 23 Mar 2020 21:46:24 +0000
Received: by mail-qk1-f200.google.com with SMTP id g25so3587840qka.0
 for <cocci@systeme.lip6.fr>; Mon, 23 Mar 2020 14:46:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=IyEq9cC0p84R074N8knqi4eTkTH1auwI+4lEtYST0ds=;
 b=fvT/bJGiUWkasAuL7rpSlXXNDx71xtG6DpVaIkHJqCmpUc8Jue1ZWYewApjav3aRhJ
 6fJaSglvQtYt296i3XHLWsATRwf6P4E9+lyq3pxUI9+fCKkqrFt/oebLUMqfQ+PM4VW7
 MPg5G5SegOZHCKD+Ey4vLZQVYB8wYQkddxpH9dhEu+32c63gby6X4Q59pmAXGFtGOD1n
 ng+GNvzXsFw+p4DtoRGnvC5Us7c/EpjT5dmx3zPC3BwkX445hbALg5vA3Y6qL3IWSS6q
 pHA50yqywCHosMvZl8NOGB6DDdewqcgXr6LBUBDl48kYhlZTmolrZEzWX6+e1BBU0bHZ
 5l/w==
X-Gm-Message-State: ANhLgQ3+B6HhK3tFNJtJ+Xn1GWjpoxTfItSJCjn+Jh0Ed4SQWjYU9mZJ
 8IqNN/bhTvw3zrpuTTDIr4sWgsG7GLzNwfIDqQlPKWxcoQs6oHYXUgTHBqGBBn7/JnaclUK0TXi
 dX5iSk44UGbGGnI/pvkUemBoAXNlzo1Wx
X-Received: by 2002:a37:6244:: with SMTP id w65mr23140467qkb.350.1584999982760; 
 Mon, 23 Mar 2020 14:46:22 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuI4/eAcWMUFjJrQ5h020CG4ZX670DnngXSCdDt0sTCtBJ+f49LvAshp3E1er5aV0Dy6bfepA==
X-Received: by 2002:a37:6244:: with SMTP id w65mr23140424qkb.350.1584999982307; 
 Mon, 23 Mar 2020 14:46:22 -0700 (PDT)
Received: from localhost (189-47-87-73.dsl.telesp.net.br. [189.47.87.73])
 by smtp.gmail.com with ESMTPSA id 5sm3398651qka.16.2020.03.23.14.46.20
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 23 Mar 2020 14:46:21 -0700 (PDT)
From: "Guilherme G. Piccoli" <gpiccoli@canonical.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date: Mon, 23 Mar 2020 18:46:18 -0300
Message-Id: <20200323214618.28429-1-gpiccoli@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 24 Mar 2020 14:04:20 +0100 (CET)
X-Greylist: Delayed for 00:16:46 by milter-greylist-4.4.3 (isis.lip6.fr
 [132.227.60.2]); Mon, 23 Mar 2020 23:03:11 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Tue, 24 Mar 2020 14:04:18 +0100
Cc: kernel@gpiccoli.net, keescook@chromium.org, linux-doc@vger.kernel.org,
        penguin-kernel@I-love.SAKURA.ne.jp, linux-api@vger.kernel.org,
        gpiccoli@canonical.com, cocci@systeme.lip6.fr, tglx@linutronix.de,
        yzaikin@google.com, akpm@linux-foundation.org
Subject: [Cocci] [PATCH V2] kernel/hung_task.c: Introduce sysctl to print
	all traces when a hung task is detected
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

Commit 401c636a0eeb ("kernel/hung_task.c: show all hung tasks before panic")
introduced a change in that we started to show all CPUs backtraces when a
hung task is detected _and_ the sysctl/kernel parameter "hung_task_panic"
is set. The idea is good, because usually when observing deadlocks (that
may lead to hung tasks), the culprit is another task holding a lock and
not necessarily the task detected as hung.

The problem with this approach is that dumping backtraces is a slightly
expensive task, specially printing that on console (and specially in many
CPU machines, as servers commonly found nowadays). So, users that plan to
collect a kdump to investigate the hung tasks and narrow down the deadlock
definitely don't need the CPUs backtrace on dmesg/console, which will delay
the panic and pollute the log (crash tool would easily grab all CPUs traces
with 'bt -a' command).
Also, there's the reciprocal scenario: some users may be interested in
seeing the CPUs backtraces but not have the system panic when a hung task
is detected. The current approach hence is almost as embedding a policy in
the kernel, by forcing the CPUs backtraces' dump (only) on hung_task_panic.

This patch decouples the panic event on hung task from the CPUs backtraces
dump, by creating (and documenting) a new sysctl/kernel parameter called
"hung_task_all_cpu_backtrace", analog to the approach taken on soft/hard
lockups, that have both a panic and an "all_cpu_backtrace" sysctl to allow
individual control. The new mechanism for dumping the CPUs backtraces on
hung task detection respects "hung_task_warnings" by not dumping the
traces in case there's no warnings left.

Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@canonical.com>
---


V2: Followed suggestions from Kees and Tetsuo (and other grammar
improvements). Also, followed Tetsuo suggestion to itereate kernel
testing community - but I don't really know a ML for that, so I've
CCed Coccinelle community and kernel-api ML.

Also, Tetsuo suggested that this option could be default to 1 - I'm
open to it, but given it is only available if hung_task panic is set
as of now and the goal of this patch is give users more flexibility,
I vote to keep default as 0. I can respin a V3 in case more people
want to see it enabled by default. Thanks in advance for the review!
Cheers,

Guilherme


 .../admin-guide/kernel-parameters.txt         |  6 ++++
 Documentation/admin-guide/sysctl/kernel.rst   | 15 ++++++++++
 include/linux/sched/sysctl.h                  |  7 +++++
 kernel/hung_task.c                            | 30 +++++++++++++++++--
 kernel/sysctl.c                               | 11 +++++++
 5 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index c07815d230bc..7a14caac6c94 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1453,6 +1453,12 @@
 			x86-64 are 2M (when the CPU supports "pse") and 1G
 			(when the CPU supports the "pdpe1gb" cpuinfo flag).
 
+	hung_task_all_cpu_backtrace=
+			[KNL] Should kernel generate backtraces on all cpus
+			when a hung task is detected. Defaults to 0 and can
+			be controlled by hung_task_all_cpu_backtrace sysctl.
+			Format: <integer>
+
 	hung_task_panic=
 			[KNL] Should the hung task detector generate panics.
 			Format: <integer>
diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index def074807cee..8b4ff69d2348 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -40,6 +40,7 @@ show up in /proc/sys/kernel:
 - hotplug
 - hardlockup_all_cpu_backtrace
 - hardlockup_panic
+- hung_task_all_cpu_backtrace
 - hung_task_panic
 - hung_task_check_count
 - hung_task_timeout_secs
@@ -338,6 +339,20 @@ Path for the hotplug policy agent.
 Default value is "/sbin/hotplug".
 
 
+hung_task_all_cpu_backtrace:
+================
+
+If this option is set, the kernel will send an NMI to all CPUs to dump
+their backtraces when a hung task is detected. This file shows up if
+CONFIG_DETECT_HUNG_TASK and CONFIG_SMP are enabled.
+
+0: Won't show all CPUs backtraces when a hung task is detected.
+This is the default behavior.
+
+1: Will non-maskably interrupt all CPUs and dump their backtraces when
+a hung task is detected.
+
+
 hung_task_panic:
 ================
 
diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index d4f6215ee03f..8cd29440ec8a 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -7,6 +7,13 @@
 struct ctl_table;
 
 #ifdef CONFIG_DETECT_HUNG_TASK
+
+#ifdef CONFIG_SMP
+extern unsigned int sysctl_hung_task_all_cpu_backtrace;
+#else
+#define sysctl_hung_task_all_cpu_backtrace 0
+#endif /* CONFIG_SMP */
+
 extern int	     sysctl_hung_task_check_count;
 extern unsigned int  sysctl_hung_task_panic;
 extern unsigned long sysctl_hung_task_timeout_secs;
diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 14a625c16cb3..0d76f9d25820 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -53,9 +53,28 @@ int __read_mostly sysctl_hung_task_warnings = 10;
 static int __read_mostly did_panic;
 static bool hung_task_show_lock;
 static bool hung_task_call_panic;
+static bool hung_task_show_all_bt;
 
 static struct task_struct *watchdog_task;
 
+#ifdef CONFIG_SMP
+/*
+ * Should we dump all CPUs backtraces in a hung task event?
+ * Defaults to 0, can be changed either via cmdline or sysctl.
+ */
+unsigned int __read_mostly sysctl_hung_task_all_cpu_backtrace;
+
+static int __init hung_task_backtrace_setup(char *str)
+{
+	int rc = kstrtouint(str, 0, &sysctl_hung_task_all_cpu_backtrace);
+
+	if (rc)
+		return rc;
+	return 1;
+}
+__setup("hung_task_all_cpu_backtrace=", hung_task_backtrace_setup);
+#endif /* CONFIG_SMP */
+
 /*
  * Should we panic (and reboot, if panic_timeout= is set) when a
  * hung task is detected:
@@ -137,6 +156,9 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
 			" disables this message.\n");
 		sched_show_task(t);
 		hung_task_show_lock = true;
+
+		if (sysctl_hung_task_all_cpu_backtrace)
+			hung_task_show_all_bt = true;
 	}
 
 	touch_nmi_watchdog();
@@ -201,10 +223,14 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
 	rcu_read_unlock();
 	if (hung_task_show_lock)
 		debug_show_all_locks();
-	if (hung_task_call_panic) {
+
+	if (hung_task_show_all_bt) {
+		hung_task_show_all_bt = false;
 		trigger_all_cpu_backtrace();
+	}
+
+	if (hung_task_call_panic)
 		panic("hung_task: blocked tasks");
-	}
 }
 
 static long hung_timeout_jiffies(unsigned long last_checked,
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index ad5b88a53c5a..238f268de486 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1098,6 +1098,17 @@ static struct ctl_table kern_table[] = {
 	},
 #endif
 #ifdef CONFIG_DETECT_HUNG_TASK
+#ifdef CONFIG_SMP
+	{
+		.procname	= "hung_task_all_cpu_backtrace",
+		.data		= &sysctl_hung_task_all_cpu_backtrace,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
+#endif /* CONFIG_SMP */
 	{
 		.procname	= "hung_task_panic",
 		.data		= &sysctl_hung_task_panic,
-- 
2.25.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
