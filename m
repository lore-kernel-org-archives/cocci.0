From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 22 Jul 2016 18:56:47 +0200 (CEST)
Subject: [Cocci] [PATCH RFC] coccinelle: tests: if and else branch
 should probably not be identical
In-Reply-To: <1469178343-29192-1-git-send-email-hofrat@osadl.org>
References: <1469178343-29192-1-git-send-email-hofrat@osadl.org>
Message-ID: <alpine.DEB.2.10.1607221855500.4131@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> +virtual context
> +virtual org
> +virtual report
> +
> + at cond@
> +statement S1;
> +position p;
> +@@
> +
> +<+...
> +* if at p (...) S1 else S1
> +...+>

You don't need the <+... ...+>.  Just put the if by itself.

julia

> +
> + at script:python depends on org@
> +p << cond.p;
> +@@
> +
> +cocci.print_main("WARNING: possible condition with no effect (if == else)",p)
> +
> + at script:python depends on report@
> +p << cond.p;
> +@@
> +
> +coccilib.report.print_report(p[0],"WARNING: possible condition with no effect (if == else)")
> --
> 2.1.4
>
>
