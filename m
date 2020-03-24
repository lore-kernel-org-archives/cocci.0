Return-Path: <SRS0=lKqB=5J=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D87EEC4332B
	for <cocci@archiver.kernel.org>; Tue, 24 Mar 2020 13:04:48 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DC3A208CA
	for <cocci@archiver.kernel.org>; Tue, 24 Mar 2020 13:04:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DC3A208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02OD4bXq025969;
	Tue, 24 Mar 2020 14:04:37 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 2973377FC;
	Tue, 24 Mar 2020 14:04:37 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B92813B63
 for <cocci@systeme.lip6.fr>; Tue, 24 Mar 2020 09:27:43 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02O8ReSZ002743
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Tue, 24 Mar 2020 09:27:42 +0100 (CET)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 62F7BADB5;
 Tue, 24 Mar 2020 08:27:38 +0000 (UTC)
To: "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20200323214618.28429-1-gpiccoli@canonical.com>
From: Vlastimil Babka <vbabka@suse.cz>
Message-ID: <b73a6519-0529-e36f-fac5-e4b638ceb3cf@suse.cz>
Date: Tue, 24 Mar 2020 09:27:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200323214618.28429-1-gpiccoli@canonical.com>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 24 Mar 2020 14:04:37 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 24 Mar 2020 09:27:42 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Tue, 24 Mar 2020 14:04:35 +0100
Cc: keescook@chromium.org, linux-doc@vger.kernel.org,
        penguin-kernel@I-love.SAKURA.ne.jp, linux-api@vger.kernel.org,
        kernel@gpiccoli.net, cocci@systeme.lip6.fr, tglx@linutronix.de,
        yzaikin@google.com, akpm@linux-foundation.org
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

On 3/23/20 10:46 PM, Guilherme G. Piccoli wrote:
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

Before adding a new thing as both kernel parameter and sysctl, could we perhaps
not add the kernel parameter, in favor of the generic sysctl parameter solution?
[1] There were no objections and some support from Kees, so I will try to send a
new version ASAP that will work properly with all "static" sysctls - we don't
need to be blocked by a full solution for dynamically registered sysctls yet, I
guess?

Thanks,
Vlastimil

[1] https://lore.kernel.org/linux-api/20200317132105.24555-1-vbabka@suse.cz/

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
