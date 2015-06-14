From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 14 Jun 2015 08:49:34 +0200 (CEST)
Subject: [Cocci] [PATCH RFC V2] coccinelle: flag constants being passed
 for jiffies
In-Reply-To: <1434128979-2096-1-git-send-email-hofrat@osadl.org>
References: <1434128979-2096-1-git-send-email-hofrat@osadl.org>
Message-ID: <alpine.DEB.2.02.1506140847380.2085@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> diff --git a/scripts/coccinelle/api/timeout_HZ_dependent.cocci b/scripts/coccinelle/api/timeout_HZ_dependent.cocci
> new file mode 100644
> index 0000000..9ec00cc
> --- /dev/null
> +++ b/scripts/coccinelle/api/timeout_HZ_dependent.cocci
> @@ -0,0 +1,121 @@
> +/// Check for hardcoded numeric timeout values which are thus HZ dependent
> +//# only report findings if the value is digits and != 1 as hardcoded

only -> Only

> +virtual context
> +virtual patch

Does Coccincheck require that you put virtual rules for things you don't 
support?  You don't support patch, but you don't support context either.  
There are no *s in your rules.  And there can't be with the current 
organization, due to the filtering being done in the python code.

julia

> +virtual org
> +virtual report
> +virtual strict
> +
> + at cc depends on !patch && (context || org || report || strict)@
> +constant C;
> +position p;
> +@@
> +
> +(
> +schedule_timeout at p(C)
> +|
> +schedule_timeout_interruptible at p(C)
> +|
> +schedule_timeout_killable at p(C)
> +|
> +schedule_timeout_uninterruptible at p(C)
> +|
> +mod_timer(...,C)
> +|
> +mod_timer_pinned(...,C)
> +|
> +mod_timer_pending(...,C)
> +|
> +apply_slack(...,C)
> +|
> +queue_delayed_work(...,C)
> +|
> +mod_delayed_work(...,C)
> +|
> +schedule_delayed_work_on(...,C)
> +|
> +schedule_delayed_work(...,C)
> +|
> +schedule_timeout(C)
> +|
> +schedule_timeout_interruptible(C)
> +|
> +schedule_timeout_killable(C)
> +|
> +schedule_timeout_uninterruptibl(C)
> +|
> +wait_event_timeout(...,C)
> +|
> +wait_event_interruptible_timeout(...,C)
> +|
> +wait_event_uninterruptible_timeout(...,C)
> +|
> +wait_event_interruptible_lock_irq_timeout(...,C)
> +|
> +wait_on_bit_timeout(...,C)
> +|
> +wait_for_completion_timeout(...,C)
> +|
> +wait_for_completion_io_timeout(...,C)
> +|
> +wait_for_completion_interruptible_timeout(...,C)
> +|
> +wait_for_completion_killable_timeout(...,C)
> +)
> +
> + at script:python depends on org@
> +p << cc.p;
> +timeout << cc.C;
> +@@
> +
> +# schedule_timeout(1) for a "short" delay is not really HZ dependent
> +# as it always would be converted to 1 by msecs_to_jiffies as well
> +# so count this as false positive
> +if str.isdigit(timeout):
> +   if (int(timeout) != 1):
> +      msg = "WARNING: timeout is HZ dependent"
> +      coccilib.org.print_safe_todo(p[0], msg)
> +
> + at script:python depends on report@
> +p << cc.p;
> +timeout << cc.C;
> +@@
> +
> +if str.isdigit(timeout):
> +   if (int(timeout) != 1):
> +      msg = "WARNING: timeout (%s) seems HZ dependent" % (timeout)
> +      coccilib.report.print_report(p[0], msg)
> +
> + at script:python depends on strict@
> +p << cc.p;
> +timeout << cc.C;
> +@@
> +
> +# "strict" mode prints the cases that use C-constants != HZ
> +# as well as the numeric constants != 1. This will deliver a false
> +# positives if the C-constant is already in jiffies !
> +if str.isdigit(timeout):
> +   if (int(timeout) != 1):
> +      msg = "WARNING: timeout (%s) is HZ dependent" % (timeout)
> +      coccilib.report.print_report(p[0], msg)
> +elif (timeout != "HZ"):
> +   msg = "INFO: timeout (%s) may be HZ dependent" % (timeout)
> +   coccilib.report.print_report(p[0], msg)
> -- 
> 1.7.10.4
> 
> 
