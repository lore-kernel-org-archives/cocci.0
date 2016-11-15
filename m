From: elena.reshetova@intel.com (Reshetova, Elena)
Date: Tue, 15 Nov 2016 11:58:56 +0000
Subject: [Cocci] Help in interpreting results
In-Reply-To: <alpine.DEB.2.10.1611151215240.3153@hadrien>
References: <2236FBA76BA1254E88B949DDB74E612B41C009A9@IRSMSX102.ger.corp.intel.com>
 <alpine.DEB.2.10.1611151215240.3153@hadrien>
Message-ID: <2236FBA76BA1254E88B949DDB74E612B41C00A21@IRSMSX102.ger.corp.intel.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>On Tue, 15 Nov 2016, Reshetova, Elena wrote:
>
>
> Good day,
>
> ?
>
> I am very new to coccinelle, and therefore my question is rather 
> basic, but unfortunately I wasn?t able to find the info online.
>
> I have a very simple cocci rule:
>
> ?
>
> ------------------------------
>
> ?
>
> @r exists@
> identifier a;
> identifier x;
> position p1, p2;
> @@
>
> atomic_dec_and_test(&a->x)@p1
> ...
> kfree(a)@p2;
>
> @script:python@
> p1 << r.p1;
> p2 << r.p2;
> @@
>
> print "* file: %s atomic_dec_and_test %s before kfree %s" %
> (p1[0].file,p1[0].line,p2[0].line)
>
> ?
>
> --------------------------------
>
> ?
>
> I just want to find all occurrences of atomic_dec_and_test(), which 
> are somewhere later in the code flow (maybe called using some 
> intermediate function, such as kfree_rcu() or others) followed by 
> kfree() on the same pointer.
>
> ?
>
> When this rule is applied to Linux kernel tree, it results in 80 of 
> such occurrences found. However, the output is a bit confusing. For example:
>
> ?
>
> ?
>
> Skipping:./linux-stable/kernel/rcu/srcu.c
> Skipping:./linux-stable/kernel/rcu/rcuperf.c
> Skipping:./linux-stable/kernel/rcu/waketorture.c
> HANDLING: ./linux-stable/kernel/rcu/rcutorture.c
> Skipping:./linux-stable/kernel/rcu/update.c
> Skipping:./linux-stable/kernel/rcu/tree.c
> Skipping:./linux-stable/kernel/panic.c
> Skipping:./linux-stable/kernel/utsname.c
> Skipping:./linux-stable/kernel/cgroup_freezer.c
> HANDLING: ./linux-stable/kernel/workqueue.c
> HANDLING: ./linux-stable/kernel/cgroup.c
>
> ?.
>
> ?
>
> I understand that ?Skipping? means that the pattern was not found in 
> that .c file. But what does ?HANDLING? actually mean?
>
> There are 330 of such ?HANDLING? happen with above rule and when I 
> manually check some of them, for example linux-stable/kernel/cgroup.c, 
> it is actually the correct case that I want to be found, and it seems 
> to be ?HANDLED?, but not reported.

>You need to separate standard output and standard error.  Skipping and HANDLING indicate just that the file is totaly irrelevant and so ignored
>(Skipping) or possibly relevant and thus parsed and matched against your rule (HANDLING).  This is just useful for checking that Coccinelle is progressing.  You may also see information about cases that run for a long time.  This is all on standard error.  The > results from your print statements will be on standard output.

Thank you for your promt reply, Julia!
I did get the results with my print statement, this wasn't the issue. But now I understand what rest of output means, thanks to your explanation!

So, "Skipping" means "not a single search token was found in file", "Handling" (without result print) means "one or more tokens were found, processing was done, but rule search pattern wasn't detected".
I was just trying to understand how it works underneath. Thank you again!

Best Regards,
Elena
