From: rjones@redhat.com (Richard W.M. Jones)
Date: Wed, 13 Jan 2016 13:48:18 +0000
Subject: [Cocci] Build failure on ppc64le: Failure("dump: impossible tag
	(1002)")
Message-ID: <20160113134818.GA30557@redhat.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr


https://bugzilla.redhat.com/show_bug.cgi?id=1297855
Build log:
http://ppc.koji.fedoraproject.org/kojifiles/work/tasks/345/3060345/build.log

In brief the build fails at:

+ /builddir/build/BUILDROOT/coccinelle-1.0.4-2.fc24.ppc64le/usr/bin/spatch -sp_file demos/simple.cocci demos/simple.c
init_defs_builtins: /builddir/build/BUILDROOT/coccinelle-1.0.4-2.fc24.ppc64le/usr/lib64/coccinelle/standard.h
Fatal error: exception Failure("dump: impossible tag (1002)")

When thinking about this bug, don't exclude the possibility that there
could be a problem in the OCaml compiler.  In Fedora we currently use
a non-upstream ppc64le code generator, although we are planning to
replace it soon(-ish) with the new upstream POWER code generator that
Xavier wrote last year.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org
