From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 14 Feb 2016 17:28:08 +0100 (CET)
Subject: [Cocci] [PATCH v3 3/7] debugfs: add support for self-protecting
 attribute file fops
In-Reply-To: <87d1rzk8kg.fsf@gmail.com>
References: <87k2m8krhf.fsf@gmail.com> <8760xskrar.fsf@gmail.com>
 <alpine.DEB.2.02.1602140802540.2039@localhost6.localdomain6>
 <87d1rzk8kg.fsf@gmail.com>
Message-ID: <alpine.DEB.2.02.1602141727000.2066@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> >> diff --git a/scripts/coccinelle/api/debugfs/debugfs_simple_attr.cocci b/scripts/coccinelle/api/debugfs/debugfs_simple_attr.cocci
> >> new file mode 100644
> >> index 0000000..bdc418d
> >> --- /dev/null
> >> +++ b/scripts/coccinelle/api/debugfs/debugfs_simple_attr.cocci
> >> @@ -0,0 +1,68 @@
> >> +///

Could you drop the above line?

> >> +/// Use DEFINE_DEBUGFS_ATTRIBUTE rather than DEFINE_SIMPLE_ATTRIBUTE
> >> +/// for debugfs files.
> >> +///
> >> +/// Rationale: DEFINE_SIMPLE_ATTRIBUTE + debugfs_create_file()
> >> +/// imposes some significant overhead as compared to
> >> +/// DEFINE_DEBUGFS_ATTRIBUTE + debugfs_create_file_unsafe().

For the above three lines that give more detail, please use //#

thanks,
julia

> >> +// Copyright (C): 2016 Nicolai Stange
> >> +// Options: --no-includes
> >> +//
> >> +
> >> +virtual context
> >> +virtual patch
> >> +virtual org
> >> +virtual report
> >> +
> >> + at dsa@
> >> +declarer name DEFINE_SIMPLE_ATTRIBUTE;
> >> +identifier dsa_fops;
> >> +expression dsa_get, dsa_set, dsa_fmt;
> >> +position p;
> >> +@@
> >> +DEFINE_SIMPLE_ATTRIBUTE at p(dsa_fops, dsa_get, dsa_set, dsa_fmt);
> >> +
> >> + at dcf@
> >> +expression name, mode, parent, data;
> >> +identifier dsa.dsa_fops;
> >> +@@
> >> +debugfs_create_file(name, mode, parent, data, &dsa_fops)
> >> +
> >> +
> >> + at context_dsa depends on context && dcf@
> >> +declarer name DEFINE_DEBUGFS_ATTRIBUTE;
> >> +identifier dsa.dsa_fops;
> >> +expression dsa.dsa_get, dsa.dsa_set, dsa.dsa_fmt;
> >> +@@
> >> +* DEFINE_SIMPLE_ATTRIBUTE(dsa_fops, dsa_get, dsa_set, dsa_fmt);
> >> +
> >> +
> >> + at patch_dcf depends on patch expression@
> >> +expression name, mode, parent, data;
> >> +identifier dsa.dsa_fops;
> >> +@@
> >> +- debugfs_create_file(name, mode, parent, data, &dsa_fops)
> >> ++ debugfs_create_file_unsafe(name, mode, parent, data, &dsa_fops)
> >> +
> >> + at patch_dsa depends on patch_dcf && patch@
> >> +identifier dsa.dsa_fops;
> >> +expression dsa.dsa_get, dsa.dsa_set, dsa.dsa_fmt;
> >> +@@
> >> +- DEFINE_SIMPLE_ATTRIBUTE(dsa_fops, dsa_get, dsa_set, dsa_fmt);
> >> ++ DEFINE_DEBUGFS_ATTRIBUTE(dsa_fops, dsa_get, dsa_set, dsa_fmt);
> >> +
> >> +
> >> + at script:python depends on org && dcf@
> >> +fops << dsa.dsa_fops;
> >> +p << dsa.p;
> >> +@@
> >> +msg="%s should be defined with DEFINE_DEBUGFS_ATTRIBUTE" % (fops)
> >> +coccilib.org.print_todo(p[0], msg)
> >> +
> >> + at script:python depends on report && dcf@
> >> +fops << dsa.dsa_fops;
> >> +p << dsa.p;
> >> +@@
> >> +msg="WARNING: %s should be defined with DEFINE_DEBUGFS_ATTRIBUTE" % (fops)
> >> +coccilib.report.print_report(p[0], msg)
> >> -- 
> >> 2.7.1
> >> 
> >> 
> 
