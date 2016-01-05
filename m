From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 5 Jan 2016 15:17:57 +0100 (CET)
Subject: [Cocci] [PATCH v6] coccinelle: tests: unsigned value cannot be
 lesser than zero
In-Reply-To: <1451893531-15817-1-git-send-email-a.hajda@samsung.com>
References: <alpine.DEB.2.02.1512301502100.2048@localhost6.localdomain6>
 <1451893531-15817-1-git-send-email-a.hajda@samsung.com>
Message-ID: <alpine.DEB.2.10.1601051512010.2521@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> + at script:python depends on org@
> +p << r_cmp.p;
> +e << r.e = "";
> +@@
> +
> +msg = "WARNING: Unsigned expression compared with zero: %s" % (e)
> +coccilib.org.print_todo(p[0], msg)
> +
> + at script:python depends on report@
> +p << r_cmp.p;
> +e << r.e = "";
> +@@
> +
> +msg = "WARNING: Unsigned expression compared with zero: %s" % (e)
> +if e:
> +    coccilib.report.print_report(p[0], msg)

Is it intentional that these don't do the same thing?  The report case has
an if on e, while the org case does not.  If you don't want a report when e
doesn't have a value, you could just remove the = "" from the declaration of
e.  That is to give a default value of e, to allow the rule to be executed
when e doesn't have a value.

julia
