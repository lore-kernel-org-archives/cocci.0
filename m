Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E12CCA46C
	for <cocci@archiver.kernel.org>; Fri, 16 Oct 2026 15:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=F8ceADCtVim4hSawqefDQ+4n/w2lyt7tKkBi/Vqtw64=;
  b=uFVnx0s1UTyc2mkZfoJz2kBoFjQsQhU3IFDmFB1JkuN+mvkRb4VJ01LE
   WWGiNj0ljIauHVfZPq+xVWwWlrM5FHnrUjALEcE5oB1s9OHRnLf2p8dSQ
   JlcaKl41zlAFGywsuSeW/ue70W5jkwlV17J+eMvtAf0FjZKTrRvwr6/AE
   M=;
X-CSE-ConnectionGUID: uu2v+e8iS/iptc2oUkCWuw==
X-CSE-MsgGUID: WzuJ9AAhS4iTQOyP1VcLWQ==
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
X-IronPort-AV: E=Sophos;i="6.27,162,1787004000"; 
   d="scan'208";a="300607532"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Oct 2026 17:18:12 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id CED18806C7; Fri, 16 Oct 2026 17:18:11 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 7330E816F6
	for <cocci@sympa.inria.fr>; Fri, 16 Oct 2026 08:01:15 +0200 (CEST)
X-CSE-ConnectionGUID: G7yfZjR0QzecGKri2vumag==
X-CSE-MsgGUID: rNv+n1taR96v+ynXd9i3pA==
IronPort-SDR: 6ad1bdaa_S74FNuOw8SzQWuejH2fl9JTjqkpPB0+O0GM1bf9On3+NBRw
 f2L27sZM73hoDjHzyKPTgvSsvPsr4hBURF6qXAw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0H3AQABvNFqfC/dVdFaHgEBCxIMggULgkGBWRMzBFSEW?=
 =?us-ascii?q?I9SggQdA4t4kiQUgSs9Ag8BAwELAQFPAgQBAQECBDgPhDcCjhYCHgcBBDAJD?=
 =?us-ascii?q?gECBAMCAwEBAQEBAQEBAQEBCwEBAQQBAQECAQECBAMBAQEBAhABASIZBw4SK?=
 =?us-ascii?q?YZPDYwaAYEkYQIFAzsBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEFAixeAQEBAQIBIwQZARsdAQMMBgUYAgImAgIQEAIRAQUBHAYThSUBB?=
 =?us-ascii?q?hABAxAnAwSyEYp4en8WBQIWgQGCDQbaawoZKA1yA4FoAgcJAQoBAYEJLoR5K?=
 =?us-ascii?q?k8OAYI+IAGFeYQCeicbgUlEhEA+gh+CCoN1gmoEgiJ6EooQA40OCAcxCQkTB?=
 =?us-ascii?q?goCSAsKEgMEAwQEAQILEwkDAwIOAggDAggGGQE/EgQTCg0LBwUfCgIMFgooI?=
 =?us-ascii?q?gQOKwoDVjABCAYCAgQEAgQCCgIJAgIFBwIRAwQBAQgCAgMqAwEDGQgJCAILB?=
 =?us-ascii?q?REYDAsHMQMQCQMCHRcRBQgRNAgGFgEaBgUGCwEgFhQBBQwRAQIbAh8EHQEQC?=
 =?us-ascii?q?AMBBg4EAgEJAwQWBAIUCh8CAwMGAwoJAgUDGxgEAQICAwIBAggDBwgDCAUDB?=
 =?us-ascii?q?AIDAwMEAQICAQEBAgMBAwMEBwIBAwcCAgMDAwsBAgMDBQMDBQUCAgUFAwUCA?=
 =?us-ascii?q?goCAwMDAgEDAhoIAwYDEgEQAwMGAQMHAwcCBAMJAggDAwgIAxcDAwUBAgIEA?=
 =?us-ascii?q?wMICAQDAwQCAgMMBQMCAwMFAwMHAgQCBAMDAQUBAgcCAwcCARgDAgQIBwcFA?=
 =?us-ascii?q?gsEAggEDQkEAgQCAg8EBgMDBwEBAgEHBQYDAgIQAQgKBQYCAgIcAx0BAgENB?=
 =?us-ascii?q?gEJBQIBBQ4HBQICGAMGAQEDBgUBAwEKCwEBAgECCgECBAIFAwMBAwIDAgYDA?=
 =?us-ascii?q?wIFBQUDCQcFDgkBAwMGBQICAwIDAQIIBAYFAwICAwUBAwMEAwoDAggDAwgDD?=
 =?us-ascii?q?AIaAgUDAwMGCQMHBwIDBwMCBQIHBQMDBQMGAQMCAQMDCAsVIgMBBQMDAgEDA?=
 =?us-ascii?q?gUDAxgCAgQFAwMDAwMIBAICAQcGBAICAgEFBQUEBQYCBAMIAQEFAwMKDQECB?=
 =?us-ascii?q?wwDDAYDBwMDBAQDAgUKAgQBBwMKBwkHAwIDBwEBCwQBAwMKAwMFAgEBBwUDB?=
 =?us-ascii?q?gMHAgMDAwUEBQMCCwMHAgIDAwMCJwEBAQMDAwMDBAMBAwEDAwcDBQMCEAgBC?=
 =?us-ascii?q?gMCBgMHBgMFAwMCAQIDAwURAwYEBQYXAgYRMgEIAgMDARQEBAUCBRUCCAEDB?=
 =?us-ascii?q?QMDAwMCBQMBBQEBAwMFAwMDAwMDBAEDBAIDBwYIAQEBAggDAwIFAwMDBAMDA?=
 =?us-ascii?q?gENBAIFAwYCAgQCBAEHAwECAgMDAwMBAgQEAgcEBQIMAwQCAwMFAgMCAwsGA?=
 =?us-ascii?q?gsEAgMDAwMDDQECCwYDFAUJBAgFAw8FAQUHBwkBAwgFAwYDCwMUAwMGAwMDC?=
 =?us-ascii?q?gQCBQEGEAwNBAECBAkDAgIEAg8VBAQDBwEBDQsBAQQRAwQBBAEDBAYTBQIBA?=
 =?us-ascii?q?wgJBgcBCAICBQICAgMDAwIFCAIFAgQCAQQCAgcCBAkDAgMCAgIMCQgTPQwHM?=
 =?us-ascii?q?gQ2ARUUBSmBAJIiHoJlgQ+CKBeWe48Mi36TWU1xaYM/gWYMmW6GSYQEk09Ik?=
 =?us-ascii?q?lQuh2aQdIJZjzqXBAIKBwcRJBKBMjqBXDMaI4M3UAMZD44iDBaDYM49QTU9A?=
 =?us-ascii?q?gcCBw4DC4VDjFmBTAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 E7K
IronPort-HdrOrdr: A9a23:3YbPUa7nxqFrYiFmjgPXwOfXdLJyesId70hD6qkXc3Bom62j+P
 xG+c5w6faaslYssQ4b6La90cW7MBbhHLROkPIs1M6ZLXDbUTKTXflfBOjZsl7d8k/Fl9K1vJ
 0IG8VD4bvLfD9HZK3BkWuF+rgbruWvweSCjfrVzjNMYGhRGsVdBldCYTqmLg==
X-Talos-CUID: 9a23:LEf4P2N5Bu1Cqe5Dd3Z2+nwWIJgcYHDW41TKIhWmFGNgR+jA
X-Talos-MUID: 9a23:mt87tAW1P6jw69Xq/CXKmnJkbdth2fXwFgMcl6UK6sjfLQUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,161,1787004000"; 
   d="scan'208";a="159981329"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDE4f6WuryC7GDXuX2uS3Ry0hTDu/6U+SuQyKu?=
 =?us-ascii?q?IiIVf8ND3Ws5EMKdBYksKeieKOa+A7GMcEzAoMFFfCijLjGAFF4oLhgD?=
 =?us-ascii?q?9P68EwXarf4LLv/fIEO7rsQVMLz/16rnf6g3NwW8zvBPuKBFyuBaxpD0?=
 =?us-ascii?q?CgweaSXaQep6zQ2KFUIk5WPg=3D=3D?=
Received: from mail-wr1-f47.google.com ([209.85.221.47])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 08:01:15 +0200
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4887dbe4f2dso644724f8f.3
        for <cocci@inria.fr>; Thu, 15 Oct 2026 23:01:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792130474; x=1792735274;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F8ceADCtVim4hSawqefDQ+4n/w2lyt7tKkBi/Vqtw64=;
        b=Qy62lVmb5ejSewkRFO9CLjg4AIh9tuJsEqW9CeJQnNcOvBawisX/lTumxeCKj6wFmJ
         WGLmsPnUr7xuNqVn+JfWP+WnBt8sZZwXBeTS+SNvoNBxtuTKoC3bxUvADpWbchAZ4Q6Z
         lEZv7mqR6xN5X3znMkjqj9AQrKP0A5yHCWXdiGp5L1A05oULcfcavtzTzRxM6xTWOst1
         015/OpsV7bpIPpPOAuzMAZZafm9xYhF0A5qQwmhnv+cXaOIVO6KbX/iKuIbxQtHrNmnm
         cHf+yUShQ/mzq4CdLNBAOjcikqXfuRN1V7oXPBe5gSEvyuJozRUlcqT4K1aj7uvAXWy1
         u/HQ==
X-Forwarded-Encrypted: i=1; AKwUvByi8r9fc+kk7H5GPmX3/YlBfgYGM4lzOM92uGGgNp/GwV22ZrASqfPf5MRyZ5ZSNWHD6a51+w==@inria.fr
X-Gm-Message-State: AFq9FYIfHa+MN9x3K7+zRMSl4e0ca9PrwVaI3vY7FnDv+T6H6exewG68
	Q2BsCywGyTPx6p3no0I8PFlFGri8OIXtLbMoz8rRfu1e5Sjx0ZorAVgW
X-Gm-Gg: AYBFou27KVwdDIEzLTmUu5lZfN+rqFONg+0j40MVShZMaPkm8JBufWNqggqO22Sjn5q
	rZkOEV5+fWJgeiGj1dJIsrPAd+VzIt9Z3fFjHbyKdq23UH13VdHgTHwu9/Xdytk0CyLcW54Kj3Z
	61Jlgy8emXjBSLQURGjE/Iif6/uYI6HFz6P2tnsb809pmj0adsvOuvyxmrgYI8fdhXSWtwmkwcN
	9zYNT1qdUGi8EnYQgxaQMg0eLxvru0iEwn7/O0bjSRl2Pv2V3kSZXmbn1Ku7/s455GrMZgpst2O
	8qYsFjttjH+ErjMUog/zbLo9HAuweF5IOOUfmaCTubgH22hmnxhpyzMAK/RdoNLECljqpIXNAE7
	QgFkHh0m7Pb4RKDke31/pQNXxcK8JE87tuhHJJAUDlv8tzOpPX0820peTkewgLD45CKEPmz8YGg
	hwWky20jAc3jmgyj4e+au91eTaaZNt8w+IBppNKTTv+LFcAlfz0PhbP5dfutUMvIBOtYNUIfF3B
	ivkNObpeGTrsbbrETPDTM+62w==
X-Received: by 2002:a05:6000:4696:b0:48d:f1b3:7e82 with SMTP id ffacd0b85a97d-48df1b3802emr7524330f8f.0.1792130473816;
        Thu, 15 Oct 2026 23:01:13 -0700 (PDT)
Received: from scheduler.schedules ([85.100.66.184])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd471a64sm2962997f8f.6.2026.10.15.23.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 23:01:13 -0700 (PDT)
Date: Fri, 16 Oct 2026 09:01:09 +0300
From: Kayra Cizmeci <kayracizmeci@gmail.com>
To: Christian Loehle <christian.loehle@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, 
	cocci@inria.fr
Message-ID: <atG48yxevmlNFT7D@scheduler.schedules>
References: <20261015083317.3733733-1-christian.loehle@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261015083317.3733733-1-christian.loehle@arm.com>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCHv2] sched: Replace nr_iowait_cpu() with a bool
 accessor
Reply-To: Kayra Cizmeci <kayracizmeci@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3756
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-10/n59Q2Ac80tCcWDOaExeDng>

On Thu, Oct 15, 2026 at 09:33:17AM +0100, Christian Loehle wrote:
> The menu governor was the last consumer of the per-CPU I/O-wait count
> that needed its magnitude, apart from nr_iowait() summing it globally.
> Commit 38f83090f515 ("cpuidle: menu: Remove iowait influence") removed
> that use. All remaining per-CPU consumers only test for zero/nonzero.
> 
> Replace nr_iowait_cpu() with bool cpu_has_iowait() and update the generic
> and s390 idle accounting callers. Have nr_iowait() read the counters
> directly so that the global total and existing accounting are preserved.
> Replace the stale menu comment with a description of the predicate.

So, this is a cleanup patch? OK.

> 
> The conversion was done with coccinelle:
> 
> @ predicate depends on patch @
> expression cpu;
> @@
> 
> - nr_iowait_cpu(cpu) > 0
> + cpu_has_iowait(cpu)
> 
> @ callers depends on patch @
> expression cpu;
> @@
> 
> - nr_iowait_cpu(cpu)
> + cpu_has_iowait(cpu)

I had to figure out what coccinelle was first.
Well, I still don't know fully what it is but I think
it's an automatic replacement tool.

I also checked Prateek's findings, I couldn't find more than he finds.
With his changes, all of the places would be covered I think.

> 
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
> v2: Move the cocci excerpt to the commit message (Peter)
> 
> 
>  arch/s390/kernel/idle.c    |  4 ++--
>  include/linux/sched/stat.h |  2 +-
>  kernel/sched/core.c        | 13 +++++--------
>  kernel/sched/cputime.c     | 10 +++++-----
>  4 files changed, 13 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/s390/kernel/idle.c b/arch/s390/kernel/idle.c
> index dd12efb58201..ff9732ef494c 100644
> --- a/arch/s390/kernel/idle.c
> +++ b/arch/s390/kernel/idle.c
> @@ -82,13 +82,13 @@ static u64 arch_cpu_idle_time(int cpu, enum cpu_usage_stat idx, bool compute_del
>  
>  u64 arch_kcpustat_field_idle(int cpu)
>  {
> -	return arch_cpu_idle_time(cpu, CPUTIME_IDLE, !nr_iowait_cpu(cpu));
> +	return arch_cpu_idle_time(cpu, CPUTIME_IDLE, !cpu_has_iowait(cpu));
>  }
>  EXPORT_SYMBOL_GPL(arch_kcpustat_field_idle);
>  
>  u64 arch_kcpustat_field_iowait(int cpu)
>  {
> -	return arch_cpu_idle_time(cpu, CPUTIME_IOWAIT, nr_iowait_cpu(cpu));
> +	return arch_cpu_idle_time(cpu, CPUTIME_IOWAIT, cpu_has_iowait(cpu));
>  }
>  EXPORT_SYMBOL_GPL(arch_kcpustat_field_iowait);
>  
> diff --git a/include/linux/sched/stat.h b/include/linux/sched/stat.h
> index 0108a38bb64d..4810b14d0372 100644
> --- a/include/linux/sched/stat.h
> +++ b/include/linux/sched/stat.h
> @@ -20,7 +20,7 @@ extern int nr_processes(void);
>  extern unsigned int nr_running(void);
>  extern bool single_task_running(void);
>  extern unsigned int nr_iowait(void);
> -extern unsigned int nr_iowait_cpu(int cpu);
> +extern bool cpu_has_iowait(int cpu);
>  
>  static inline int sched_info_on(void)
>  {
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 1fe40de6ebe3..1bde5187dafd 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5588,15 +5588,12 @@ unsigned long long nr_context_switches(void)
>  }
>
>  /*
> - * Consumers of these two interfaces, like for example the cpuidle menu
> - * governor, are using nonsensical data. Preferring shallow idle state selection
> - * for a CPU that has IO-wait which might not even end up running the task when
> - * it does become runnable.
> + * Return whether any tasks are accounted as I/O waiters on this CPU.
> + * They may wake up on a different CPU.
>   */
> -
> -unsigned int nr_iowait_cpu(int cpu)
> +bool cpu_has_iowait(int cpu)
>  {
> -	return atomic_read(&cpu_rq(cpu)->nr_iowait);
> +	return atomic_read(&cpu_rq(cpu)->nr_iowait) != 0;
>  }
>  
>  /*
> @@ -5634,7 +5631,7 @@ unsigned int nr_iowait(void)
>  	unsigned int i, sum = 0;
>  
>  	for_each_possible_cpu(i)
> -		sum += nr_iowait_cpu(i);
> +		sum += atomic_read(&cpu_rq(i)->nr_iowait);
>  
>  	return sum;
>  }
> diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
> index 06bddaa738e5..1f84a950abed 100644
> --- a/kernel/sched/cputime.c
> +++ b/kernel/sched/cputime.c
> @@ -431,7 +431,7 @@ static void kcpustat_idle_stop(struct kernel_cpustat *kc, u64 now)
>  	if (!kc->idle_elapse)
>  		return;
>  
> -	iowait = nr_iowait_cpu(smp_processor_id()) > 0;
> +	iowait = cpu_has_iowait(smp_processor_id());
>  	delta = now - kc->idle_entrytime;
>  	steal = steal_account_process_time(delta);

Yeah, these look way more cleaner to me.

>  
> @@ -544,14 +544,14 @@ static u64 kcpustat_field_dyntick(int cpu, enum cpu_usage_stat idx,
>  u64 kcpustat_field_idle(int cpu)
>  {
>  	return kcpustat_field_dyntick(cpu, CPUTIME_IDLE,
> -				      !nr_iowait_cpu(cpu), ktime_get());
> +				      !cpu_has_iowait(cpu), ktime_get());
>  }
>  EXPORT_SYMBOL_GPL(kcpustat_field_idle);
>  
>  u64 kcpustat_field_iowait(int cpu)
>  {
>  	return kcpustat_field_dyntick(cpu, CPUTIME_IOWAIT,
> -				      nr_iowait_cpu(cpu), ktime_get());
> +				      cpu_has_iowait(cpu), ktime_get());
>  }
>  EXPORT_SYMBOL_GPL(kcpustat_field_iowait);
>  #else
> @@ -601,7 +601,7 @@ static u64 get_cpu_sleep_time_us(int cpu, enum cpu_usage_stat idx,
>  u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time)
>  {
>  	return get_cpu_sleep_time_us(cpu, CPUTIME_IDLE,
> -				     !nr_iowait_cpu(cpu), last_update_time);
> +				     !cpu_has_iowait(cpu), last_update_time);
>  }
>  EXPORT_SYMBOL_GPL(get_cpu_idle_time_us);
>  
> @@ -625,7 +625,7 @@ EXPORT_SYMBOL_GPL(get_cpu_idle_time_us);
>  u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time)
>  {
>  	return get_cpu_sleep_time_us(cpu, CPUTIME_IOWAIT,
> -				     nr_iowait_cpu(cpu), last_update_time);
> +				     cpu_has_iowait(cpu), last_update_time);
>  }
>  EXPORT_SYMBOL_GPL(get_cpu_iowait_time_us);
>  

BTW, this is tied to counter being correct, if its not...
Well we have problems. I think your other patch was covering that?
But I have a bad memory, so IDK.

Reviewed-by: Kayra Cizmeci <kayracizmeci@gmail.com>

Thanks!

Kayra



> -- 
> 2.34.1
> 
