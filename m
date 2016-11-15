From: elena.reshetova@intel.com (Reshetova, Elena)
Date: Tue, 15 Nov 2016 11:13:35 +0000
Subject: [Cocci] Help in interpreting results
Message-ID: <2236FBA76BA1254E88B949DDB74E612B41C009A9@IRSMSX102.ger.corp.intel.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Good day,

I am very new to coccinelle, and therefore my question is rather basic, but unfortunately I wasn't able to find the info online.
I have a very simple cocci rule:

------------------------------

@r exists@
identifier a;
identifier x;
position p1, p2;
@@

atomic_dec_and_test(&a->x)@p1
...
kfree(a)@p2;

@script:python@
p1 << r.p1;
p2 << r.p2;
@@

print "* file: %s atomic_dec_and_test %s before kfree %s" % (p1[0].file,p1[0].line,p2[0].line)

--------------------------------

I just want to find all occurrences of atomic_dec_and_test(), which are somewhere later in the code flow (maybe called using some intermediate function, such as kfree_rcu() or others) followed by kfree() on the same pointer.

When this rule is applied to Linux kernel tree, it results in 80 of such occurrences found. However, the output is a bit confusing. For example:

...
Skipping:./linux-stable/kernel/rcu/srcu.c
Skipping:./linux-stable/kernel/rcu/rcuperf.c
Skipping:./linux-stable/kernel/rcu/waketorture.c
HANDLING: ./linux-stable/kernel/rcu/rcutorture.c
Skipping:./linux-stable/kernel/rcu/update.c
Skipping:./linux-stable/kernel/rcu/tree.c
Skipping:./linux-stable/kernel/panic.c
Skipping:./linux-stable/kernel/utsname.c
Skipping:./linux-stable/kernel/cgroup_freezer.c
HANDLING: ./linux-stable/kernel/workqueue.c
HANDLING: ./linux-stable/kernel/cgroup.c
....

I understand that "Skipping" means that the pattern was not found in that .c file. But what does "HANDLING" actually mean?
There are 330 of such "HANDLING" happen with above rule and when I manually check some of them, for example linux-stable/kernel/cgroup.c, it is actually the correct case that I want to be found, and it seems to be "HANDLED", but not reported.

I am a bit confused on what is happening. Any help is greatly appreciated!

Best Regards,
Elena.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20161115/a861f8c3/attachment.html>
