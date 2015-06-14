From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 14 Jun 2015 09:02:24 +0200 (CEST)
Subject: [Cocci] [PATCH RFC V2] coccinelle: flag constants being passed
 for jiffies
In-Reply-To: <1434128979-2096-1-git-send-email-hofrat@osadl.org>
References: <1434128979-2096-1-git-send-email-hofrat@osadl.org>
Message-ID: <alpine.DEB.2.02.1506140900580.2085@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> + at script:python depends on report@
> +p << cc.p;
> +timeout << cc.C;
> +@@
> +
> +if str.isdigit(timeout):
> +   if (int(timeout) != 1):
> +      msg = "WARNING: timeout (%s) seems HZ dependent" % (timeout)
> +      coccilib.report.print_report(p[0], msg)

The parentheses in the warning messages around the timeouts seem a little
strange to me.

Otherwise, as a semantic patch, it looks fine.  I can't judge the problem 
being solved though.

julia

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
