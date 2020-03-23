Return-Path: <SRS0=tcx8=5I=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB2DC4332B
	for <cocci@archiver.kernel.org>; Mon, 23 Mar 2020 21:51:35 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25637206C3
	for <cocci@archiver.kernel.org>; Mon, 23 Mar 2020 21:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n5jPAGZq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25637206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02NLpHJe010873;
	Mon, 23 Mar 2020 22:51:17 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 6B95077FC;
	Mon, 23 Mar 2020 22:51:17 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 918E87749
 for <cocci@systeme.lip6.fr>; Mon, 23 Mar 2020 22:51:14 +0100 (CET)
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1041])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02NLpBWM015812
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 23 Mar 2020 22:51:12 +0100 (CET)
Received: by mail-pj1-x1041.google.com with SMTP id l36so482059pjb.3
 for <cocci@systeme.lip6.fr>; Mon, 23 Mar 2020 14:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=rwVl0RUGYbVVd53EKmMU44a5cDo2y4Opjc0SA6TNhKc=;
 b=n5jPAGZqZ62oMKHsAqYIOK+4ZJVnWLyYFROPJ55BWbJ0NCCGoDQz8PNzrrEY7PZU58
 3FvDt/jRcU60R48KkkI8q7V6Fr8tyo4swdYizYqqTGfY3aynIWfA0a+0F7ZxCR7Yf2q0
 4vw5/OqB+d2YMdywgKWH4sMEa+nbmm308lu10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=rwVl0RUGYbVVd53EKmMU44a5cDo2y4Opjc0SA6TNhKc=;
 b=FtcSpgmUpvJvbRbuqvwxANFRSZWCMgJbaTtQQHv6Lok/Ml+8SfFNKMn9myZOYL7DWx
 ChPV5PNCw4mx/+4blqHTo1W06oSkpsMP7et8BMQbthDiHfcFBwJVJqrR1oK8lzNdZHpM
 df118h0pZnu2mYgbE8Cinpormgfj2hx8uL8Er9Rqzy8i/6WDBZncuerP1B5+1/QGncJS
 D+TwMtNp/PGAgEnN9l4v0CHrLqN4AH98wgtrAVJL+mhS2BnnJ22wTd7FlpOc/285EvDJ
 OKf3gmhT1c31d3n31h502BWs8GkIeYz/IHzOQZPKxHpyKGA0MLAbbyXPajGDhvMDJlws
 PD6g==
X-Gm-Message-State: ANhLgQ3NFhILZKDJUULAtjyFC7vAM5Dg62k6lIEFj8W9Zz+QlHn+CFlU
 PtNuvzKdrqeHdfk4ogNPvIyWEw==
X-Google-Smtp-Source: ADFU+vvU28lLGB57K22+cEicr73FO2MRtPgwjuBZdyX+DYdCd5z4XmBA5begWk059u/7EyN7YQqLNg==
X-Received: by 2002:a17:902:148:: with SMTP id
 66mr24090778plb.148.1585000270792; 
 Mon, 23 Mar 2020 14:51:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id m12sm505440pjf.25.2020.03.23.14.51.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2020 14:51:09 -0700 (PDT)
Date: Mon, 23 Mar 2020 14:51:08 -0700
From: Kees Cook <keescook@chromium.org>
To: "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Message-ID: <202003231447.0574B783CF@keescook>
References: <20200323214618.28429-1-gpiccoli@canonical.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200323214618.28429-1-gpiccoli@canonical.com>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 23 Mar 2020 22:51:18 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 23 Mar 2020 22:51:13 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-doc@vger.kernel.org, penguin-kernel@I-love.SAKURA.ne.jp,
        linux-api@vger.kernel.org, kernel@gpiccoli.net,
        linux-kernel@vger.kernel.org, cocci@systeme.lip6.fr,
        linux-fsdevel@vger.kernel.org, tglx@linutronix.de, yzaikin@google.com,
        akpm@linux-foundation.org
Subject: Re: [Cocci] [PATCH V2] kernel/hung_task.c: Introduce sysctl to
 print all traces when a hung task is detected
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

On Mon, Mar 23, 2020 at 06:46:18PM -0300, Guilherme G. Piccoli wrote:
> Commit 401c636a0eeb ("kernel/hung_task.c: show all hung tasks before panic")
> introduced a change in that we started to show all CPUs backtraces when a
> hung task is detected _and_ the sysctl/kernel parameter "hung_task_panic"
> is set. The idea is good, because usually when observing deadlocks (that
> may lead to hung tasks), the culprit is another task holding a lock and
> not necessarily the task detected as hung.
> 
> The problem with this approach is that dumping backtraces is a slightly
> expensive task, specially printing that on console (and specially in many
> CPU machines, as servers commonly found nowadays). So, users that plan to
> collect a kdump to investigate the hung tasks and narrow down the deadlock
> definitely don't need the CPUs backtrace on dmesg/console, which will delay
> the panic and pollute the log (crash tool would easily grab all CPUs traces
> with 'bt -a' command).
> Also, there's the reciprocal scenario: some users may be interested in
> seeing the CPUs backtraces but not have the system panic when a hung task
> is detected. The current approach hence is almost as embedding a policy in
> the kernel, by forcing the CPUs backtraces' dump (only) on hung_task_panic.
> 
> This patch decouples the panic event on hung task from the CPUs backtraces
> dump, by creating (and documenting) a new sysctl/kernel parameter called
> "hung_task_all_cpu_backtrace", analog to the approach taken on soft/hard
> lockups, that have both a panic and an "all_cpu_backtrace" sysctl to allow
> individual control. The new mechanism for dumping the CPUs backtraces on
> hung task detection respects "hung_task_warnings" by not dumping the
> traces in case there's no warnings left.
> 
> Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@canonical.com>
> ---
> 
> 
> V2: Followed suggestions from Kees and Tetsuo (and other grammar
> improvements). Also, followed Tetsuo suggestion to itereate kernel
> testing community - but I don't really know a ML for that, so I've
> CCed Coccinelle community and kernel-api ML.
> 
> Also, Tetsuo suggested that this option could be default to 1 - I'm
> open to it, but given it is only available if hung_task panic is set
> as of now and the goal of this patch is give users more flexibility,
> I vote to keep default as 0. I can respin a V3 in case more people
> want to see it enabled by default. Thanks in advance for the review!

Yeah, most things like this we've tried to be conservative. I'd like to
see it stay zero too.

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> Cheers,
> 
> Guilherme
> 
> 
>  .../admin-guide/kernel-parameters.txt         |  6 ++++
>  Documentation/admin-guide/sysctl/kernel.rst   | 15 ++++++++++
>  include/linux/sched/sysctl.h                  |  7 +++++
>  kernel/hung_task.c                            | 30 +++++++++++++++++--
>  kernel/sysctl.c                               | 11 +++++++
>  5 files changed, 67 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index c07815d230bc..7a14caac6c94 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1453,6 +1453,12 @@
>  			x86-64 are 2M (when the CPU supports "pse") and 1G
>  			(when the CPU supports the "pdpe1gb" cpuinfo flag).
>  
> +	hung_task_all_cpu_backtrace=
> +			[KNL] Should kernel generate backtraces on all cpus
> +			when a hung task is detected. Defaults to 0 and can
> +			be controlled by hung_task_all_cpu_backtrace sysctl.
> +			Format: <integer>
> +
>  	hung_task_panic=
>  			[KNL] Should the hung task detector generate panics.
>  			Format: <integer>
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> index def074807cee..8b4ff69d2348 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -40,6 +40,7 @@ show up in /proc/sys/kernel:
>  - hotplug
>  - hardlockup_all_cpu_backtrace
>  - hardlockup_panic
> +- hung_task_all_cpu_backtrace
>  - hung_task_panic
>  - hung_task_check_count
>  - hung_task_timeout_secs
> @@ -338,6 +339,20 @@ Path for the hotplug policy agent.
>  Default value is "/sbin/hotplug".
>  
>  
> +hung_task_all_cpu_backtrace:
> +================
> +
> +If this option is set, the kernel will send an NMI to all CPUs to dump
> +their backtraces when a hung task is detected. This file shows up if
> +CONFIG_DETECT_HUNG_TASK and CONFIG_SMP are enabled.
> +
> +0: Won't show all CPUs backtraces when a hung task is detected.
> +This is the default behavior.
> +
> +1: Will non-maskably interrupt all CPUs and dump their backtraces when
> +a hung task is detected.
> +
> +
>  hung_task_panic:
>  ================
>  
> diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
> index d4f6215ee03f..8cd29440ec8a 100644
> --- a/include/linux/sched/sysctl.h
> +++ b/include/linux/sched/sysctl.h
> @@ -7,6 +7,13 @@
>  struct ctl_table;
>  
>  #ifdef CONFIG_DETECT_HUNG_TASK
> +
> +#ifdef CONFIG_SMP
> +extern unsigned int sysctl_hung_task_all_cpu_backtrace;
> +#else
> +#define sysctl_hung_task_all_cpu_backtrace 0
> +#endif /* CONFIG_SMP */
> +
>  extern int	     sysctl_hung_task_check_count;
>  extern unsigned int  sysctl_hung_task_panic;
>  extern unsigned long sysctl_hung_task_timeout_secs;
> diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> index 14a625c16cb3..0d76f9d25820 100644
> --- a/kernel/hung_task.c
> +++ b/kernel/hung_task.c
> @@ -53,9 +53,28 @@ int __read_mostly sysctl_hung_task_warnings = 10;
>  static int __read_mostly did_panic;
>  static bool hung_task_show_lock;
>  static bool hung_task_call_panic;
> +static bool hung_task_show_all_bt;
>  
>  static struct task_struct *watchdog_task;
>  
> +#ifdef CONFIG_SMP
> +/*
> + * Should we dump all CPUs backtraces in a hung task event?
> + * Defaults to 0, can be changed either via cmdline or sysctl.
> + */
> +unsigned int __read_mostly sysctl_hung_task_all_cpu_backtrace;
> +
> +static int __init hung_task_backtrace_setup(char *str)
> +{
> +	int rc = kstrtouint(str, 0, &sysctl_hung_task_all_cpu_backtrace);
> +
> +	if (rc)
> +		return rc;
> +	return 1;
> +}
> +__setup("hung_task_all_cpu_backtrace=", hung_task_backtrace_setup);
> +#endif /* CONFIG_SMP */
> +
>  /*
>   * Should we panic (and reboot, if panic_timeout= is set) when a
>   * hung task is detected:
> @@ -137,6 +156,9 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
>  			" disables this message.\n");
>  		sched_show_task(t);
>  		hung_task_show_lock = true;
> +
> +		if (sysctl_hung_task_all_cpu_backtrace)
> +			hung_task_show_all_bt = true;
>  	}
>  
>  	touch_nmi_watchdog();
> @@ -201,10 +223,14 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
>  	rcu_read_unlock();
>  	if (hung_task_show_lock)
>  		debug_show_all_locks();
> -	if (hung_task_call_panic) {
> +
> +	if (hung_task_show_all_bt) {
> +		hung_task_show_all_bt = false;
>  		trigger_all_cpu_backtrace();
> +	}
> +
> +	if (hung_task_call_panic)
>  		panic("hung_task: blocked tasks");
> -	}
>  }
>  
>  static long hung_timeout_jiffies(unsigned long last_checked,
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index ad5b88a53c5a..238f268de486 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -1098,6 +1098,17 @@ static struct ctl_table kern_table[] = {
>  	},
>  #endif
>  #ifdef CONFIG_DETECT_HUNG_TASK
> +#ifdef CONFIG_SMP
> +	{
> +		.procname	= "hung_task_all_cpu_backtrace",
> +		.data		= &sysctl_hung_task_all_cpu_backtrace,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= SYSCTL_ZERO,
> +		.extra2		= SYSCTL_ONE,
> +	},
> +#endif /* CONFIG_SMP */
>  	{
>  		.procname	= "hung_task_panic",
>  		.data		= &sysctl_hung_task_panic,
> -- 
> 2.25.1
> 

-- 
Kees Cook
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
