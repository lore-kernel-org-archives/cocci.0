From: knut.omang@oracle.com (Knut Omang)
Date: Thu,  4 Jan 2018 14:39:34 +0100
Subject: [Cocci] [PATCH v3 1/1] runchecks: Generalize make C={1,
	2} to support multiple checkers
In-Reply-To: <cover.5b56d020b8e826a7da33b1823c059acd0c123f8b.1515072782.git-series.knut.omang@oracle.com>
References: <cover.5b56d020b8e826a7da33b1823c059acd0c123f8b.1515072782.git-series.knut.omang@oracle.com>
Message-ID: <5f292b7effba0efcf4855bff83b7b9313ac45895.1515072782.git-series.knut.omang@oracle.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Add scripts/runchecks which has generic support for running
checker tools in a convenient and user friendly way that
the author hopes can contribute to rein in issues detected
by these tools in a manageable and convenient way.

scripts/runchecks provides the following basic functionality:

* Makes it possible to selectively suppress output from individual
  checks on a per file or per subsystem basis.
* Unifies output and suppression input from different tools
  by providing a single unified syntax and presentation for the
  underlying tools in the style of "scripts/checkpatch.pl --show-types".
* Allows selective run of one, or more (or all) configured tools
  for each file.

In the Makefile system, the sparse specific setup has been replaced
by setup for runchecks.

This version of runchecks together with a "global" configuration
file in "scripts/runchecks.cfg" supports sparse, checkpatch, and checkdoc,
a trivial abstraction above a call to 'kernel-doc -none'.
It also supports forwarding calls to coccicheck for coccinelle support
but this is not quite as worked through as the three other checkers,
mainly because of lack of error data as all checks pass by default
right now.

The code is designed to be easily extensible to support more checkers
as they emerge, and some generic checker support is even available
just via simple additions to "scripts/runchecks.cfg".

The runchecks program unifies configuration, processing
and output for multiple checker tools to make them
all run as part of the C=1 or C=2 option to make.

Currently with full support and unified behaviour for
sparse:     sparse
checkpatch: scripts/checkpatch.pl
checkdoc:   kernel-doc -none

In principle supported but not unified in output(yet):
coccinelle: scripts/coccicheck

Introduces a new documentation section titled
"Makefile support for running checkers"

Also updates documentation for the make C= option
in some other doc files, as the behaviour has
been changed to be less sparse specific and more
generic. The coccinelle documentation also had the
behaviour of C=1 and C=2 swapped.

Signed-off-by: Knut Omang <knut.omang@oracle.com>
Reviewed-by: H?kon Bugge <haakon.bugge@oracle.com>
Reviewed-by: ?smund ?stvold <asmund.ostvold@oracle.com>
Reviewed-by: John Haxby <john.haxby@oracle.com>
---
 Documentation/dev-tools/coccinelle.rst |  12 +-
 Documentation/dev-tools/index.rst      |   1 +-
 Documentation/dev-tools/runchecks.rst  | 215 ++++++++-
 Documentation/dev-tools/sparse.rst     |  30 +-
 Documentation/kbuild/kbuild.txt        |   9 +-
 Makefile                               |  23 +-
 scripts/Makefile.build                 |   4 +-
 scripts/runchecks                      | 734 ++++++++++++++++++++++++++-
 scripts/runchecks.cfg                  |  63 ++-
 scripts/runchecks_help.txt             |  43 ++-
 10 files changed, 1114 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/dev-tools/runchecks.rst
 create mode 100755 scripts/runchecks
 create mode 100644 scripts/runchecks.cfg
 create mode 100644 scripts/runchecks_help.txt

diff --git a/Documentation/dev-tools/coccinelle.rst b/Documentation/dev-tools/coccinelle.rst
index 94f41c2..c98cc44 100644
--- a/Documentation/dev-tools/coccinelle.rst
+++ b/Documentation/dev-tools/coccinelle.rst
@@ -157,17 +157,19 @@ For example, to check drivers/net/wireless/ one may write::
 
     make coccicheck M=drivers/net/wireless/
 
-To apply Coccinelle on a file basis, instead of a directory basis, the
-following command may be used::
+To apply Coccinelle as the only checker on a file basis,
+instead of a directory basis, the following command may be used::
 
-    make C=1 CHECK="scripts/coccicheck"
+    make C=2 CF="--run:coccicheck"
 
-To check only newly edited code, use the value 2 for the C flag, i.e.::
+To check only newly edited code, use the value 1 for the C flag, i.e.::
 
-    make C=2 CHECK="scripts/coccicheck"
+    make C=1 CF="--run:coccicheck"
 
 In these modes, which works on a file basis, there is no information
 about semantic patches displayed, and no commit message proposed.
+For more information about options in this calling mode, see
+Documentation/dev-tools/runchecks.rst .
 
 This runs every semantic patch in scripts/coccinelle by default. The
 COCCI variable may additionally be used to only apply a single
diff --git a/Documentation/dev-tools/index.rst b/Documentation/dev-tools/index.rst
index e313925..cb4506d 100644
--- a/Documentation/dev-tools/index.rst
+++ b/Documentation/dev-tools/index.rst
@@ -16,6 +16,7 @@ whole; patches welcome!
 
    coccinelle
    sparse
+   runchecks
    kcov
    gcov
    kasan
diff --git a/Documentation/dev-tools/runchecks.rst b/Documentation/dev-tools/runchecks.rst
new file mode 100644
index 0000000..1a43c05
--- /dev/null
+++ b/Documentation/dev-tools/runchecks.rst
@@ -0,0 +1,215 @@
+.. Copyright 2017 Knut Omang <knut.omang@oracle.com>
+
+Makefile support for running checkers
+=====================================
+
+Tools like sparse, coccinelle, and scripts/checkpatch.pl are able to detect a
+lot of syntactic and semantic issues with the code, and are also constantly
+evolving and detecting more. In an ideal world, all source files should
+adhere to whatever rules imposed by checkpatch.pl and sparse etc. with all
+bells and whistles enabled, in a way that these checkers can be run as a reflex
+by developers (and by bots) from the top level Makefile for every changing
+source file. In the real world however there's a number of challenges:
+
+* Sometimes there are valid reasons for accepting violations of a checker
+  rule, even if that rule is a sensible one in the general case.
+* Some subsystems have different restrictions and requirements.
+  (Ideally, the number of subsystems with differing restrictions and
+  requirements will diminish over time.)
+* Similarly, the kernel contains a lot of code that predates the tools, or at
+  least some of the newer rules, and we would like these tools to evolve without
+  requiring the need to fix all issues detected with it in the same commit.
+  We also want to accommodate new tools, so that each new tool does not
+  have to reinvent its own mechanism for running checks.
+* On the other hand, we want to make sure that files that are clean
+  (to some well defined extent, such as passing checkpatch or sparse
+  with checks only for certain important types of issues) keep being so.
+
+This is the purpose of ``scripts/runchecks``.
+
+The ``runchecks`` program looks for files named ``runchecks.cfg`` in the
+``scripts`` directory, then in the directory hierarchy of the source file,
+starting from where the source file is located, searching upwards. If at least
+one such file exists in the source tree, ``runchecks`` parses a set of
+rules from it, and uses them to determine how to invoke a set of individual
+checker tools for a particular file. The kernel Makefile system supports
+this feature as an integrated part of compiling the code, using the
+``C={1,2}`` option. With::
+
+	make C=1
+
+runchecks will be invoked if the file needs to be recompiled. With ::
+
+	make C=2
+
+runchecks will be invoked for all source files, even if they do not need
+recompiling. Based on the configuration, ``runchecks`` will invoke one or
+more checkers. The number and types of checkers to run are configurable and
+can also be selected on the command line::
+
+	make C=2 CF="--run:sparse,checkpatch"
+
+If only one checker is run, any parameter that is not recognized by
+``runchecks`` itself will be forwarded to the checker. If more than one checker
+is enabled, parameters can be forwarded to a specific checker by means of
+this syntax::
+
+	make C=2 CF="--to-checkpatch:--terse"
+
+A comma separated list of parameters can be supplied if necessary.
+
+Supported syntax of the runchecks.cfg configuration file
+--------------------------------------------------------
+
+The ``runchecks`` configuration file chain can be used to set policies and "rein in"
+checker errors piece by piece for a particular subsystem or driver. It can
+also be used to mitigate and extend checkers that do not support
+selective suppression of all it's checks.
+
+Two classes of configuration are available. The first class is configuration
+that defines what checkers are enabled, and some logic to allow better
+suppression or a more unified output of warning messages.
+This type of configuration should go into the first accessed
+configuration file, and has been preconfigured for the currently supported
+checkers in ``scripts/runchecks.cfg``. The second class is the features for
+configuring the output of the checkers by selectively suppressing checks on
+a per file or per check basis. These typically go in the source tree in
+the directory of the source file or above. Some of the syntax is generic
+and some is only supported by some checkers.
+
+For the first class of configuration the following syntax is supported::
+
+	# comments
+	checker checkpatch [command]
+	addflags <list of extra flags and parameters>
+	cflags
+	typedef NAME <regular expression>
+	run [checker list|all]
+
+The ``checker`` command switches ``runchecks``'s attention to a particular
+checker. The following commands until the next ``checker`` statement
+apply to that particular checker. The first occurrence of ``checker``
+also serves as a potentially defining operation, if the checker name
+has not been preconfigured. In that case, a second parameter can be used
+to provide the name of the command used to run the checker.
+A full checker integration into runchecks will typically require some
+additions to runchecks, and will then have been preconfigured,
+but simple checkers might just be configured on the fly.
+
+The ``addflags`` command incrementally adds more flags and parameters to
+the command line used to invoke the checker. This applies to all
+invocations of the checker from runchecks.
+
+The ``cflags`` command forwards all the flags and options passed to
+the compiler invocation to the checker. The default is to suppress these
+parameters when invoking the checker.
+
+The ``typedef`` command adds ``NAME`` and associates it with the given regular
+expression. This expression is used to match against standard error output from
+the checker. In the kernel tree, ``NAME`` can then be used in local
+``runcheck.cfg`` files as a new named check that runchecks understands and that
+can be used with checker supported names below to selectively suppress that
+particular set of warning or error messages. This is useful to handle output
+checks for which the underlying checker does not provide any suppression.  Check
+type namespaces are separate for the individual checkers. You can list the state
+of the built in and configured checker and check types with::
+
+	scripts/runchecks --list
+
+The checker implementations of the ``typedef`` command also allow runchecks to
+perform some unification of output by rewriting the output lines, and use of the
+new type names in the error output, to ease the process of updating the
+runchecks.cfg files.  It also adds some limited optional color support.  Having
+a unified representation of the error output also makes it much easier to do
+statistics or other operations on top of an aggregated output from several
+checkers.
+
+For the second class of configuration the following syntax is supported::
+
+	# comments
+	checker checker_name
+	except check_type [files ...]
+	pervasive check_type1 [check_type2 ...]
+	line_len <n>
+
+The ``except`` directive takes a check type such as for example
+``MACRO_ARG_REUSE``, and a set of files that should not be subject to this
+particular check type. The ``pervasive`` command disables the listed types
+of checks for all the files in the subtree.  The ``except`` and
+``pervasive`` directives can be used cumulatively to add more exceptions.
+The ``line_len`` directive defines the upper bound of characters per line
+tolerated in this directory. Currently only ``checkpatch`` supports this
+command.
+
+Options when running checker programs from make
+-----------------------------------------------
+
+A make variable ``CF`` allows passing additional parameters to
+``runchecks``. You can for instance use::
+
+	make C=2 CF="--run:checkpatch --fix-inplace"
+
+to run only the ``checkpatch`` checker, and to have checkpatch try to fix
+issues it finds - *make sure you have a clean git tree and carefully review
+the output afterwards!* Combine this with selectively enabling of types of
+errors via changes under ``checker checkpatch`` to the local
+``runchecks.cfg``, and you can focus on fixing up errors subsystem or
+driver by driver on a type by type basis.
+
+By default runchecks will skip all files if a ``runchecks.cfg`` file cannot
+be found in the directory of the file or in the tree above.  This is to
+allow builds with ``C=2`` to pass even for subsystems that have not yet done
+anything to rein in checker errors. At some point when all subsystems and
+drivers either have fixed all checker errors or added proper
+``runchecks.cfg`` files, this can be changed.
+Note that the runchecks.cfg file in the scripts/ directory is special, in that
+it can be present without triggering checker runs in the main kernel tree.
+
+To force runchecks to run a full run in directories/trees where runchecks
+does not find  a ``runchecks.cfg`` file as well, use::
+
+	make C=2 CF="-f"
+
+If you like to see all the warnings and errors produced by the checkers, ignoring
+any runchecks.cfg files except the one under ``scripts``, you can use::
+
+	make C=2 CF="-n"
+
+or for a specific module directory::
+
+	make C=2 M=drivers/infiniband/core CF="--color -n -w"
+
+with the -w option to ``runchecks`` to suppress errors from any of the
+checkers and just continue on, and the ``--color`` option to present errors
+with colors where supported.
+
+Ever tightening checker rules
+-----------------------------
+
+Commit the changes to the relevant ``runchecks.cfg`` together with the code
+changes that fixes a particular type of issue, this will allow automatic
+checker running by default. This way we can ensure that new errors of that
+particular type do not inadvertently sneak in again! This can be done at
+any subsystem or module maintainer's discretion and at the right time
+without having to do it all at the same time.
+
+Before submitting your changes, verify that a full "make C=2" passes
+with no errors.
+
+Extending and improving checker support in ``runchecks``
+--------------------------------------------------------
+
+The runchecks program has been written with extensibility in mind.
+If the checker starts its reporting lines with filename:lineno, there's a
+good chance that a new checker can simply be added by adding::
+
+	checker mychecker path_to_mychecker
+
+to ``scripts/runchecks.cfg`` and suitable ``typedef`` expressions to provide
+selective suppressions of output, however it is likely that some quirks are
+needed to make the new checker behave similarly to the others, and to support
+the full set of features, such as the ``--list`` option. This is done by
+implementing a new subclass of the Checker class in ``runchecks``. This is the
+way all the available default supported checkers are implemented, and those
+relatively lean implementations could serve as examples for support for future
+checkers.
diff --git a/Documentation/dev-tools/sparse.rst b/Documentation/dev-tools/sparse.rst
index 78aa00a..e3e8b27 100644
--- a/Documentation/dev-tools/sparse.rst
+++ b/Documentation/dev-tools/sparse.rst
@@ -101,5 +101,31 @@ recompiled, or use "make C=2" to run sparse on the files whether they need to
 be recompiled or not.  The latter is a fast way to check the whole tree if you
 have already built it.
 
-The optional make variable CF can be used to pass arguments to sparse.  The
-build system passes -Wbitwise to sparse automatically.
+The "make C={1,2}" form of kernel make indirectly calls sparse via "runchecks",
+which dependent on configuration and command line options may dispatch calls to
+other checkers in addition to sparse. Details on how this works is covered
+in Documentation/dev-tools/runchecks.rst .
+
+The optional make variable CF can be used to pass arguments to runchecks for dispatch
+to sparse. If sparse is the only tool enabled, any option not recognized by
+runchecks will be forwarded to sparse. If more than one tool is active, you must
+add the parameters you want sparse to get as a comma separated list prefixed by
+``--to-sparse:``. If you want sparse to be the only checker run, and you want
+some nice colored output, you can specify this as::
+
+	make C=2 CF="--run:sparse --color"
+
+This will cause sparse to be called for all files which are supported by a valid
+runchecks configuration (again see Documentation/dev-tools/runchecks.rst for
+details). If you want to run sparse on all files and ignore any missing
+configuration files(s), just add ``-n`` to the list of options passed to
+runchecks. This will cause runchecks to call sparse with all errors enabled for
+all files even if no valid configuration is found in the tree for the source files.
+
+By default "runchecks" is set to enable all sparse errors, but you can
+configure what checks to be applied by sparse on a per file or per subsystem
+basis. With the above invocation, make will fail and stop on the first file
+encountered with sparse errors or warnings in it. If you want to continue
+anyway, you can use::
+
+	make C=2 CF="--run:sparse --color -w"
diff --git a/Documentation/kbuild/kbuild.txt b/Documentation/kbuild/kbuild.txt
index ac2363e..260e688 100644
--- a/Documentation/kbuild/kbuild.txt
+++ b/Documentation/kbuild/kbuild.txt
@@ -103,10 +103,13 @@ CROSS_COMPILE is also used for ccache in some setups.
 
 CF
 --------------------------------------------------
-Additional options for sparse.
-CF is often used on the command-line like this:
+Additional options for runchecks, the generic checker runner.
+CF is often used on the command-line for instance like this:
 
-    make CF=-Wbitwise C=2
+    make C=2 CF="--run:sparse --color -w"
+
+to run the sparse tool only, and to use colored output and continue on warnings
+or errors.
 
 INSTALL_PATH
 --------------------------------------------------
diff --git a/Makefile b/Makefile
index eb1f597..bba07b9 100644
--- a/Makefile
+++ b/Makefile
@@ -159,14 +159,22 @@ ifeq ($(skip-makefile),)
 # so that IDEs/editors are able to understand relative filenames.
 MAKEFLAGS += --no-print-directory
 
-# Call a source code checker (by default, "sparse") as part of the
-# C compilation.
+# Do source code checking as part of the C compilation.
+#
 #
 # Use 'make C=1' to enable checking of only re-compiled files.
 # Use 'make C=2' to enable checking of *all* source files, regardless
 # of whether they are re-compiled or not.
 #
-# See the file "Documentation/dev-tools/sparse.rst" for more details,
+# Source code checking is done via the runchecks script, which
+# has knowledge of each individual cheker and how it wants to be called,
+# as well as options for rules as to which checks that are applicable
+# to different parts of the kernel, at source file granularity.
+#
+# Several types of checking is available, and custom checkers can also
+# be added.
+#
+# See the file "Documentation/dev-tools/runchecks.rst" for more details,
 # including where to get the "sparse" utility.
 
 ifeq ("$(origin C)", "command line")
@@ -383,10 +391,9 @@ INSTALLKERNEL  := installkernel
 DEPMOD		= /sbin/depmod
 PERL		= perl
 PYTHON		= python
-CHECK		= sparse
 
-CHECKFLAGS     := -D__linux__ -Dlinux -D__STDC__ -Dunix -D__unix__ \
-		  -Wbitwise -Wno-return-void $(CF)
+CHECK		= $(srctree)/scripts/runchecks
+CHECKFLAGS      =
 NOSTDINC_FLAGS  =
 CFLAGS_MODULE   =
 AFLAGS_MODULE   =
@@ -429,7 +436,7 @@ GCC_PLUGINS_CFLAGS :=
 export ARCH SRCARCH CONFIG_SHELL HOSTCC HOSTCFLAGS CROSS_COMPILE AS LD CC
 export CPP AR NM STRIP OBJCOPY OBJDUMP HOSTLDFLAGS HOST_LOADLIBES
 export MAKE AWK GENKSYMS INSTALLKERNEL PERL PYTHON UTS_MACHINE
-export HOSTCXX HOSTCXXFLAGS LDFLAGS_MODULE CHECK CHECKFLAGS
+export HOSTCXX HOSTCXXFLAGS LDFLAGS_MODULE CHECK CHECK_CFLAGS CHECKFLAGS
 
 export KBUILD_CPPFLAGS NOSTDINC_FLAGS LINUXINCLUDE OBJCOPYFLAGS LDFLAGS
 export KBUILD_CFLAGS CFLAGS_KERNEL CFLAGS_MODULE CFLAGS_KASAN CFLAGS_UBSAN
@@ -778,7 +785,7 @@ endif
 
 # arch Makefile may override CC so keep this after arch Makefile is included
 NOSTDINC_FLAGS += -nostdinc -isystem $(call shell-cached,$(CC) -print-file-name=include)
-CHECKFLAGS     += $(NOSTDINC_FLAGS)
+CHECK_CFLAGS     += $(NOSTDINC_FLAGS)
 
 # warn about C99 declaration after statement
 KBUILD_CFLAGS += $(call cc-option,-Wdeclaration-after-statement,)
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index cb8997e..13325b3 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -93,10 +93,10 @@ __build: $(if $(KBUILD_BUILTIN),$(builtin-target) $(lib-target) $(extra-y)) \
 ifneq ($(KBUILD_CHECKSRC),0)
   ifeq ($(KBUILD_CHECKSRC),2)
     quiet_cmd_force_checksrc = CHECK   $<
-          cmd_force_checksrc = $(CHECK) $(CHECKFLAGS) $(c_flags) $< ;
+          cmd_force_checksrc = $(CHECK) $(CF) $< -- $(CHECKFLAGS) $(c_flags);
   else
       quiet_cmd_checksrc     = CHECK   $<
-            cmd_checksrc     = $(CHECK) $(CHECKFLAGS) $(c_flags) $< ;
+            cmd_checksrc     = $(CHECK) $(CF) $< -- $(CHECKFLAGS) $(c_flags);
   endif
 endif
 
diff --git a/scripts/runchecks b/scripts/runchecks
new file mode 100755
index 0000000..4dd2969
--- /dev/null
+++ b/scripts/runchecks
@@ -0,0 +1,734 @@
+#!/usr/bin/python
+
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (c) 2017, Oracle and/or its affiliates. All rights reserved.
+#    Author: Knut Omang <knut.omang@oracle.com>
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2
+# as published by the Free Software Foundation.
+
+# The program implements a generic and extensible code checker runner
+# that supports running various checker tools from the kernel Makefile
+# or standalone, with options for selectively suppressing individual
+# checks on a per file or per check basis.
+#
+# The program has some generic support for checkers, but to implement
+# support for a new checker to the full extent, it might be necessary to
+#   1) subclass the Checker class in this file with checker specific processing.
+#   2) add typedef definitions in runchecks.cfg in this directory
+#
+# This version of runchecks has full support for the following tools:
+#   sparse:      installed separately
+#   checkpatch:  checkpatch.pl
+#   checkdoc:    kernel-doc -none
+#
+# See file "Documentation/dev-tools/runchecks.rst" for more details
+#
+
+import sys, os, subprocess, fcntl, select, re
+from os.path import dirname, basename
+
+class CheckError(Exception):
+    def __init__(self, value):
+        self.value = value
+    def __str__(self):
+        return self.value
+
+def usage():
+    manual = os.path.join(srctree, "scripts/runchecks_help.txt")
+    f = open(manual, "r")
+    for line in f:
+        sys.stdout.write(line)
+    f.close()
+    print ""
+    print "Configured checkers:"
+    for (c, v) in checker_types.iteritems():
+        enabled = "[default disabled]"
+        for c_en in config.checkers:
+            if c_en.name == c:
+                enabled = ""
+                break
+        print "  %-20s %s" % (c, enabled)
+    exit(1)
+
+
+# A small configuration file parser:
+#
+class Config:
+    def __init__(self, srctree, workdir, filename):
+        self.path = []
+        self.relpath = {}
+        relpath = ""
+
+        # Look for a global config file in the scripts directory:
+        file = os.path.join(srctree, "scripts/%s" % filename)
+        if os.path.exists(file):
+            self.path.append(file)
+            self.relpath[file] = relpath
+
+        while not ignore_config:
+            self.file = os.path.join(workdir,filename)
+            if os.path.exists(self.file):
+                self.path.append(self.file)
+                self.relpath[self.file] = relpath
+            if len(workdir) <= len(srctree):
+                break
+            relpath = "%s/%s" % (basename(workdir), relpath)
+            workdir = dirname(workdir)
+
+        self.checkers = []
+        self.cur_chk = None
+        self.color = False
+        self.list_only = False
+
+        self.command = {
+            "checker"	: self.checker,
+            "addflags"	: self.addflags,
+            "run"	: self.runlist,
+            "except"	: self.exception,
+            "pervasive" : self.pervasive,
+            "cflags"	: self.cflags,
+            "typedef"	: self.typedef
+        }
+
+        if verbose:
+            print "  ** runchecks: config path: %s" % self.path
+        for f in self.path:
+            self.ParseConfig(f)
+
+    def checker(self, argv):
+        try:
+            self.cur_chk = checker_types[argv[0]]
+        except KeyError:
+            if len(argv) < 2:
+                d1 = "generic checker configurations!"
+                raise CheckError("%s:%d: use 'checker %s command' for %s" % \
+                                 (self.file, self.lineno, argv[0], d1))
+
+            AddChecker(Checker(argv[0], argv[1], srctree, workdir))
+            self.cur_chk = checker_types[argv[0]]
+
+    def addflags(self, argv):
+        self.cur_chk.addflags(argv)
+
+    def exception(self, argv):
+        type = argv[0]
+        if self.cur_chk:
+            relpath = self.relpath[self.file]
+            self.cur_chk.exception(type, relpath, argv[1:])
+        else:
+            raise CheckError("%s:%d: checker has not been set" % (self.file, self.lineno))
+
+    def pervasive(self, argv):
+        self.cur_chk.pervasive(argv)
+
+    def runlist(self, argv):
+        try:
+            for c in argv:
+                self.checkers.append(checker_types[c])
+        except KeyError, k:
+            if str(k) == "'all'":
+                self.checkers = checker_types.values()
+            else:
+                available = "\n  -- avaliable checkers are: %s" % ",".join(checker_types.keys())
+                raise CheckError("Checker %s not found - not configured?%s" % (str(k), available))
+
+    def cflags(self, argv):
+        self.cur_chk.cflags = True
+
+    def typedef(self, argv):
+        self.cur_chk.typedef(argv)
+
+    # Parse one configuration file in the configuration file list:
+    #
+    def ParseConfig(self, file):
+        f = open(file, 'r')
+        self.file = file
+        self.lineno = 0
+        for line in f:
+            self.lineno = self.lineno + 1
+            token = line.split()
+            if len(token) < 1:
+                continue
+            if token[0][0] == '#':
+                continue
+            try:
+                self.command[token[0]](token[1:])
+            except KeyError:
+                if not self.cur_chk:
+                    raise CheckError("%s:%s: checker has not been set" % (self.file, self.lineno))
+                self.cur_chk.ParseOptional(token[0], token[1:])
+            except AttributeError:
+                if not self.cur_chk:
+                    raise CheckError("%s:%s: checker has not been set" % (self.file, self.lineno))
+
+        f.close()
+        self.cur_chk = None
+
+    # Option forwarding to checkers
+    # and optional selection of which checkers to run:
+    def ProcessOpts(self, opts):
+        for opt in opts:
+            if opt == "--color":
+                self.color = True
+                continue
+            elif opt == "--list":
+                self.list_only = True
+                continue
+            elif opt == "--help":
+                usage_only = True
+
+            fw = re.match("^--to-(\w+):(.*)$", opt)
+            if fw:
+                try:
+                    cname = fw.group(1)
+                    checker = checker_types[cname]
+                except:
+                    raise CheckError("Unknown checker '%s' specified in option '%s'" % (cname, opt))
+                newargs = fw.group(2).split(',')
+                checker.cmdvec += newargs
+                if verbose:
+                    print "Added extra args for %s: %s" % (cname, newargs)
+                continue
+
+            runopt = re.match("^--run:(.*)$", opt)
+            if runopt:
+                clist = runopt.group(1).split(",")
+                # Command line override: reset list of checkers
+                self.checkers = []
+                self.runlist(clist)
+                continue
+
+            if len(self.checkers) == 1:
+                # If only one checker enabled, just pass everything we don't know about through:
+                self.checkers[0].cmdvec.append(opt)
+            else:
+                raise CheckError("Unknown option '%s'" % opt)
+
+    # We always expect@least one config file that sets up the active checkers:
+    #
+    def HasPathConfig(self):
+        return len(self.path) > 1
+
+
+# The base class for checkers:
+# For specific support a particular checker, implement a subclass of this:
+#
+class Checker:
+    def __init__(self, name, cmd, srctree, workdir, ofilter = None, efilter = None):
+        self.name = name
+        self.srctree = srctree
+	self.workdir = workdir
+	self.efilter = efilter
+        if ofilter:
+            self.ofilter = ofilter
+        else:
+            self.ofilter = self.suppress
+        self.strout = ""
+        self.strerr = ""
+        self.cflags = False
+        if cmd[0:7] == "scripts":
+            cmd = os.path.join(self.srctree, cmd)
+        self.cmd = cmd
+        self.cmdvec = cmd.split()
+        self.pervasive_opts = [] # "global" ignore list
+        self.exceptions = []     # exception list for this file
+        self.file_except = []    # Aggregated list of check types to ignore for this file
+        self.re_except_def = {}  # check_type -> <regex to match it in stderr>
+        self.doc = {}		 # Used when parsing documentation: check type -> doc string
+        self.cont = []
+        self.last_ignore = False
+        self.unclassified = 0	 # With RegexFilter: Number of "red" lines not classified
+
+    def filter_env(self, dict):
+        return dict
+
+    def readline(self, is_stdout, fd):
+        tmp_str = ""
+        try:
+            s = os.read(fd, 1000)
+            while s != '':
+                tmp_str += s
+                s = os.read(fd, 1)
+        except OSError:
+            None
+
+        if is_stdout:
+            self.strout += tmp_str
+            tmp_str = self.strout
+        else:
+            self.strerr += tmp_str
+            tmp_str = self.strerr
+
+        inx = tmp_str.find('\n') + 1
+        if inx != 0:
+            t = tmp_str[:inx]
+            if is_stdout:
+                self.strout = tmp_str[inx:]
+            else:
+                self.strerr = tmp_str[inx:]
+        else:
+            return ''
+        return t
+
+    def SetNonblocking(self, fd):
+        fl = fcntl.fcntl(fd, fcntl.F_GETFL)
+        try:
+            fcntl.fcntl(fd, fcntl.F_SETFL, fl | os.O_NDELAY)
+        except AttributeError:
+            fcntl.fcntl(fd, fcntl.F_SETFL, fl | fcntl.FNDELAY)
+
+    def Run(self, file, verbose):
+        cmdvec = self.cmdvec
+        if self.cflags:
+            cmdvec += c_argv
+        if not force:
+            self.file_except = set(self.exceptions + self.pervasive_opts)
+        self.Postprocess()
+        if not file:
+            raise CheckError("error: missing file parameter")
+        cmdvec.append(file)
+        if debug:
+            print "  ** running %s: %s" % (self.name, " ".join(cmdvec))
+        elif verbose:
+            print "  -- checker %s --" % self.name
+        try:
+            ret = self.RunCommand(cmdvec, self.ofilter, self.efilter)
+        except OSError, e:
+            if re.match(".*No such file or directory", str(e)):
+                if len(config.checkers) == 1:
+                    raise CheckError("Failed to run checker %s: %s: %s" % (self.name, self.cmd, str(e)))
+                if verbose:
+                    print "  ** %s does not exist - ignoring %s **" % (self.name, self.cmd)
+                return 0
+        ret = self.PostRun(ret)
+        return ret
+
+    def RunCommand(self, cmdvec, ofilter, efilter):
+	my_env = self.filter_env(os.environ)
+        child = subprocess.Popen(cmdvec, shell = False, \
+                     stdout=subprocess.PIPE, stderr=subprocess.PIPE, cwd=".", env=my_env)
+        sout = child.stdout
+        serr = child.stderr
+        ofd = sout.fileno()
+        efd = serr.fileno()
+        oeof = False
+        eeof = False
+        check_errors = []
+        self.SetNonblocking(ofd)
+        self.SetNonblocking(efd)
+        while True:
+            ready = select.select([ofd,efd],[],[],0.1)
+            if ofd in ready[0]:
+                if child.poll() != None:
+                    oeof = True
+                oline = self.readline(True, ofd)
+                while oline != '':
+                    if ofilter:
+                        ofilter(oline, verbose)
+                    else:
+                        sys.stdout.write(oline)
+                    oline = self.readline(True, ofd)
+            if efd in ready[0]:
+                if child.poll() != None:
+                    eeof = True
+                eline = self.readline(False, efd)
+                while eline != '':
+                    if efilter:
+                        check_err = efilter(eline, verbose)
+                        if check_err != None:
+                                check_errors.append(check_err)
+                    else:
+                        sys.stderr.write(eline)
+                    eline = self.readline(False, efd)
+            if oeof and eeof:
+                break
+        serr.close()
+        sout.close()
+        retcode = child.wait()
+        if check_errors != []:
+            estr = "".join(check_errors)
+            if estr != "":
+                sys.stderr.write(estr)
+                if not retcode:
+                    retcode = 131
+            else:
+                if verbose:
+                    print "%s  ** %d suppressed errors/warnings from %s%s" % (BLUE, len(check_errors), self.name, ENDCOLOR)
+                retcode = 0
+        return retcode
+
+    def ParseOptional(self, cmd, argv):
+        raise CheckError("Undefined command '%s' for checker '%s'" % (cmd, self.name))
+
+    # Called as final step before running the checker:
+    def Postprocess(self):
+        # Do nothing - just for redefinition in subclasses
+        return
+
+    # Called as a post processing step after running the checker:
+    # Input parameter is return value from Run()
+    def PostRun(self, retval):
+        # Do nothing - just for redefinition in subclasses
+        return retval
+
+    # Default standard output filter:
+    def suppress(self, line, verbose):
+        if verbose:
+            sys.stdout.write(line)
+
+    # A matching filter for stderr:
+    def RegexFilter(self, line, verbose):
+        if self.cont:
+            m = re.match(self.cont[0], line)
+            self.cont = self.cont[1:]
+            if m:
+                if self.last_ignore:
+                    return ""
+                else:
+                    return line
+
+        for t, regex in self.re_except_def.iteritems():
+            r = "^(.*:\d+:)\s(\w+:)\s(%s.*)$" % regex[0]
+            m = re.match(r, line)
+            if m:
+                if len(regex) > 1:
+                    self.cont = regex[1:]
+                if t in self.file_except:
+                    self.last_ignore = True
+                    return ""
+                else:
+                    self.last_ignore = False
+                    return "%s%s %s:%s%s%s: %s %s\n" % (BROWN, m.group(1), self.name.upper(), BLUE, t, ENDCOLOR, m.group(2), m.group(3))
+        self.unclassified = self.unclassified + 1
+        return RED + line + ENDCOLOR
+
+    def ListTypes(self):
+        if len(self.re_except_def) > 0:
+            print BLUE + BOLD + "  Check types declared for %s in runchecks configuration%s" % (self.name, ENDCOLOR)
+        for t, regex in self.re_except_def.iteritems():
+            print "\t%-22s %s" % (t, "\\n".join(regex))
+        if len(self.re_except_def) > 0:
+            print ""
+        return 0
+
+    def addflags(self, argv):
+        self.cmdvec += argv
+
+    def exception(self, type, relpath, argv):
+        for f in argv:
+            if f == ("%s%s" % (relpath, bfile)):
+                self.exceptions.append(type)
+
+    def pervasive(self, argv):
+        self.pervasive_opts += argv
+
+    def typedef(self, argv):
+        exp = " ".join(argv[1:])
+        elist = exp.split("\\n")
+        self.re_except_def[argv[0]] = elist
+
+
+# Individual checker implementations:
+#
+
+# checkpatch
+class CheckpatchRunner(Checker):
+    def __init__(self, srctree, workdir):
+        Checker.__init__(self, "checkpatch", "scripts/checkpatch.pl", srctree, workdir)
+        self.cmdvec.append("--file")
+        self.line_len = 0
+        # checkpatch sends all it's warning and error output to stdout,
+        # redirect and do limited filtering:
+        self.ofilter = self.out_filter
+
+    def ParseOptional(self, cmd, argv):
+        if cmd == "line_len":
+            self.line_len = int(argv[0])
+        else:
+            Checker.ParseOptional(self, cmd, argv)
+
+    def Postprocess(self):
+        if config.color:
+            self.cmdvec.append("--color=always")
+        if self.line_len:
+            self.cmdvec.append("--max-line-length=%d" % self.line_len)
+        if self.file_except:
+            self.cmdvec.append("--ignore=%s" % ",".join(self.file_except))
+
+    # Extracting a condensed doc of types to filter on:
+    def man_filter(self, line, verbose):
+        t = line.split()
+        if len(t) > 1 and t[1] != "Message":
+            sys.stdout.write("\t%s\n" % t[1])
+
+    def out_filter(self, line, verbose):
+        # --terse produces this message even with no errors,
+        #  suppress unless run with -v:
+        if not verbose and re.match("^total: 0 errors, 0 warnings, 0 checks,", line):
+            return
+        sys.write.stderr(line)
+
+    def ListTypes(self):
+        print BLUE + BOLD + "  Supported check types for checkpatch" + ENDCOLOR
+        # Parse help output:
+        cmdvec = ["%s/scripts/checkpatch.pl" % self.srctree, "--list-types"]
+        self.RunCommand(cmdvec, self.man_filter, None)
+        print ""
+        return 0
+
+# sparse
+class SparseRunner(Checker):
+    def __init__(self, srctree, workdir):
+        Checker.__init__(self, "sparse", "sparse", srctree, workdir)
+        self.efilter = self.RegexFilter
+
+    def sparse_name(self, rs_type):
+        l_name = rs_type.lower()
+        s_name = ""
+        for c in l_name:
+            if c == '_':
+                s_name += '-'
+            else:
+                s_name += c
+        return s_name
+
+    def runchecks_name(self, sparse_type):
+        u_name = sparse_type.upper()
+        rc_name =""
+        for c in u_name:
+            if c == '-':
+                rc_name += '_'
+            else:
+                rc_name += c
+        return rc_name
+
+    def Postprocess(self):
+        if self.file_except:
+            for e in self.file_except:
+                self.cmdvec.append("-Wno-%s" % self.sparse_name(e))
+
+    # Extracting a condensed doc of types to filter on:
+    def man_filter(self, line, verbose):
+        if self.doc_next:
+            doc = line.strip()
+            self.doc[self.doc_next] = doc
+            self.doc_next = False
+            return
+        match = re.search("^\s+-W([\w-]+)\s*$", line)
+        if match:
+            name = match.group(1)
+            if re.match("sparse-", name):
+                return
+            rs_type = self.runchecks_name(name)
+            self.doc_next = rs_type
+
+    def ListTypes(self):
+        # Parse manual output:
+        cmdvec = ["man", "sparse"]
+        self.doc_next = False
+        ret = self.RunCommand(cmdvec, self.man_filter, None)
+        if ret:
+            return ret
+        print BLUE + BOLD + "\n  Types derived from sparse from documentation in manpage" + ENDCOLOR
+        for t, doc in self.doc.iteritems():
+            print "\t%-22s %s" % (t, doc)
+            try:
+                regex = self.re_except_def[t]
+                print "\t%-22s %s" % ("", GREEN + "\\n".join(regex) + ENDCOLOR)
+            except:
+                print "\t%-22s %s" % ("", RED + "(regex match (typedef) missing)" + ENDCOLOR)
+        print BLUE + BOLD + "\n  Types for sparse only declared for runchecks or not documented in manpage" + ENDCOLOR
+        for t, regex in self.re_except_def.iteritems():
+            try:
+                self.doc[t]
+            except:
+                print "\t%-22s %s" % (t, GREEN + "\\n".join(regex) + ENDCOLOR)
+        print ""
+        return 0
+
+# checkdoc
+class CheckdocRunner(Checker):
+    def __init__(self, srctree, workdir):
+        Checker.__init__(self, "checkdoc", "scripts/kernel-doc", srctree, workdir)
+        self.cmdvec.append("-none")
+        self.efilter = self.RegexFilter
+
+# coccicheck (coccinelle) (WIP)
+class CoccicheckRunner(Checker):
+    def __init__(self, srctree, workdir):
+        Checker.__init__(self, "coccicheck", "scripts/coccicheck", srctree, workdir)
+        self.debug_file = None
+        self.efilter = self.CoccicheckFilter
+
+    def filter_env(self, dict):
+        newdict = os.environ
+        # If debug file is not set by the user, override it and present the output on stderr:
+        try:
+            df = newdict["DEBUG_FILE"]
+        except:
+            print "*** debug_file!"
+            self.debug_file = '/tmp/cocci_%s.log' % os.getpid()
+            newdict["DEBUG_FILE"] = self.debug_file
+        return newdict
+
+    def CoccicheckFilter(self, line, verbose):
+        self.unclassified = self.unclassified + 1
+        if re.match(".*spatch -D report", line):
+            if verbose:
+                sys.stdout.write(line)
+        else:
+            return RED + line + ENDCOLOR
+
+    def PostRun(self, retval):
+        if not self.debug_file:
+            return retval
+        f = open(self.debug_file)
+        for line in f:
+            line = self.CoccicheckFilter(line, verbose)
+            if line:
+                sys.stderr.write(line)
+        f.close()
+        if self.debug_file:
+            os.remove(self.debug_file)
+        if retval == 0:
+            reval = ret
+        return retval
+
+checker_types = {}
+
+def AddChecker(checker):
+    checker_types[checker.name] = checker
+
+#
+# Start main program:
+#
+program = os.path.realpath(sys.argv[0])
+progname = basename(program)
+scriptsdir = dirname(program)
+srctree = dirname(scriptsdir)
+force = False
+ignore_config = False
+verbose = False
+debug = False
+error = True
+error_on_red = False
+usage_only = False
+argv = []
+c_argv = []
+fw_opts = []
+workdir = os.getcwd()
+optarg = False
+argc = 0
+
+AddChecker(CheckpatchRunner(srctree, workdir))
+AddChecker(SparseRunner(srctree, workdir))
+AddChecker(CheckdocRunner(srctree, workdir))
+AddChecker(CoccicheckRunner(srctree, workdir))
+
+for arg in sys.argv[1:]:
+    argc = argc + 1
+
+    if arg == "--":
+        argc = argc + 1
+        c_argv = sys.argv[argc:]
+        break;
+    elif arg == "-f":
+        force = True
+    elif arg == "-n":
+        ignore_config = True
+        force = True
+    elif arg == "-w":
+        error = False
+    elif arg == "-t":
+        error_on_red = True
+        error = False
+    elif arg == "-d":
+        debug = True
+    elif arg == "-v":
+        verbose = True
+    elif arg == "-h":
+        usage_only = True
+    else:
+        opt = re.match("^-.*$", arg)
+        if opt:
+            # Delay processing of these until we know the configuration:
+            fw_opts.append(opt.group(0))
+        else:
+            argv.append(arg)
+
+if not verbose:
+    try:
+        verb = int(os.environ["V"])
+        if verb != 0:
+            verbose = True
+    except KeyError:
+        verbose = False
+
+if not os.path.exists(os.path.join(srctree, "MAINTAINERS")):
+    srctree = None
+
+try:
+    file = argv[0]
+    bfile = basename(file)
+    workdir = dirname(file)
+except:
+    bfile = None
+    file = None
+
+unclassified = 0
+
+if debug:
+    print "Kernel root:\t%s\nFile:\t\t%s\nWorkdir:\t%s" % \
+        (srctree, bfile, workdir)
+    print "C args:\t\t%s\nargv:\t\t%s\n" % (" ".join(c_argv), " ".join(argv))
+
+try:
+    config = Config(srctree, workdir, "runchecks.cfg")
+    config.ProcessOpts(fw_opts)
+
+    if usage_only:
+        usage()
+    if not config.HasPathConfig() and not config.list_only and not force:
+        if verbose:
+            print "  ** %s: No configuration found - skip checks for %s" % (progname, file)
+        exit(0)
+
+    if config.color:
+        GREEN = '\033[32m'
+        RED = '\033[91m'
+        BROWN = '\033[33m'
+        BLUE = '\033[34m'
+        BOLD = '\033[1m'
+        ENDCOLOR = '\033[0m'
+    else:
+        BOLD = ''
+        GREEN = ''
+        RED = ''
+        BROWN = ''
+        BLUE = ''
+        ENDCOLOR = ''
+
+    ret = 0
+    for checker in config.checkers:
+        if config.list_only:
+            ret = checker.ListTypes()
+        else:
+            ret = checker.Run(file, verbose)
+            unclassified += checker.unclassified
+        if ret and error:
+            break
+
+    if not error and not (error_on_red and unclassified > 0):
+        ret = 0
+except CheckError, e:
+    print "  ** %s: %s" % (progname, str(e))
+    ret = 22
+except KeyboardInterrupt:
+    if verbose:
+        print "  ** %s: Interrupted by user" % progname
+    ret = 4
+
+exit(ret)
diff --git a/scripts/runchecks.cfg b/scripts/runchecks.cfg
new file mode 100644
index 0000000..c0b12cf
--- /dev/null
+++ b/scripts/runchecks.cfg
@@ -0,0 +1,63 @@
+checker checkpatch
+addflags  --quiet --show-types --strict --emacs
+line_len 110
+
+checker sparse
+addflags -D__linux__ -Dlinux -D__STDC__ -Dunix -D__unix__ -Wsparse-all
+cflags
+
+#	Name		Regular expression for matching in checker output
+typedef DECL		symbol '.*' was not declared. Should it be static\?
+typedef SHADOW		symbol '\w+' shadows an earlier one\n.*originally declared here
+typedef TYPESIGN	incorrect type in argument \d+ \(different signedness\)\n.*expected\n.*got
+typedef RETURN_VOID	returning void-valued expression
+typedef SIZEOF_BOOL	expression using sizeof bool
+typedef CONTEXT		context imbalance in '.*'
+typedef MEMCPY_MAX_COUNT \w+ with byte count of
+typedef CAST_TO_AS	cast adds address space to expression
+typedef ADDRESS_SPACE	incorrect type in .* \(different address spaces\)\n.*expected\n.*got
+typedef PTR_INHERIT	incorrect type in .* \(different base types\)\n.*expected\n.*got
+typedef PTR_SUBTRACTION_BLOWS potentially expensive pointer subtraction
+typedef VLA		Variable length array is used
+typedef OVERFLOW	constant [x\dA-F]+ is so big it is \w+
+typedef TAUTOLOGICAL_COMPARE self-comparison always evaluates to (true|false)
+typedef NON_POINTER_NULL Using plain integer as NULL pointer
+typedef BOOL_CAST_RESTRICTED restricted \w+ degrades to integer
+typedef TYPESIGN	incorrect type in .* \(different signedness\)\n.*expected\n.*got
+typedef FUNCTION_REDECL symbol '.*' redeclared with different type \(originally declared at
+typedef COND_ADDRESS_ARRAY the address of an array will always evaluate as true
+typedef BITWISE 	cast (to|from) restricted
+
+# Type names invented here - not maskable from sparse?
+typedef NO_DEREF	dereference of noderef expression
+typedef ARG_TYPE_MOD	incorrect type in .* \(different modifiers\)\n.*expected\n.*got
+typedef ARG_TYPE_COMP	incorrect type in .* \(incompatible .*\(.*\)\)\n.*expected\n.*got
+typedef ARG_AS_COMP	incompatible types in comparison expression \(different address spaces\)
+typedef CMP_TYPE	incompatible types in comparison expression \(different base types\)
+typedef SPARSE_OFF	"Sparse checking disabled for this file"
+typedef CAST_TRUNC	cast truncates bits from constant value
+typedef CAST_FROM_AS	cast removes address space of expression
+typedef EXT_LINK_DEF	function '\w+' with external linkage has definition
+typedef FUNC_ARITH	arithmetics on pointers to functions
+typedef CALL_NO_TYPE	call with no type!
+typedef FUNC_SUB	subtraction of functions\? Share your drugs
+typedef STRING_CONCAT	trying to concatenate \d+-character string \(\d+ bytes max\)
+typedef INARG_DIRECTIVE directive in argument list
+typedef NONSCALAR_CAST  cast (to|from) non-scalar
+
+checker checkdoc
+typedef PARAM_DESC	No description found for parameter
+typedef X_PARAM    	Excess function parameter
+typedef X_STRUCT	Excess struct member
+typedef FUN_PROTO    	cannot understand function prototype
+typedef DOC_FORMAT   	Incorrect use of kernel-doc format
+typedef BAD_LINE	bad line
+typedef AMBIGUOUS	Cannot understand.*\n on line
+typedef BOGUS_STRUCT	Cannot parse struct or union
+typedef DUPL_SEC	duplicate section name
+
+checker coccicheck
+cflags
+
+run sparse checkpatch checkdoc
+#run all
diff --git a/scripts/runchecks_help.txt b/scripts/runchecks_help.txt
new file mode 100644
index 0000000..a0a4a34
--- /dev/null
+++ b/scripts/runchecks_help.txt
@@ -0,0 +1,43 @@
+Usage: runchecks  [<options>] c_file [-- <c_parameters>]
+  - run code checkers in a conformant way.
+
+Options:
+  -h|--help	List this text
+  --list	List the different configured checkers and the list of interpreted check
+		types for each of them.
+  --		Separator between parameters to runchecks and compiler parameters to be
+		passed directly to the checkers.
+  --run:[checker1[,checker2..]|all]
+		Override the default set of checkers to be run for each source file. By
+		default the checkers to run will be the intersection of the checkers
+		configured by ``run`` commands in the configuration file and the
+		checkers that is actually available on the machine. Use 'all'
+		to run all the configured checkers.
+  --color	Use coloring in the error and warning output. In this mode
+		output from checkers that are supported by typedefs but not
+		captured by any such will be highlighted in red to make it
+		easy to detect that a typedef rule is missing. See -t below.
+  -f		Force mode: force runchecks to run a full run in directories/trees
+		where runchecks does not find a	runchecks.cfg file. The default
+		behaviour is to skip running checkers in directories/trees
+		where no matching runchecks.cfg file is found either in the
+		source file directory or above.
+  -n		Ignore all runchecks.cfg files except the one in scripts,
+		which are used for basic runchecks configuration. This allows
+		an easy way to run a "bare" version of checking where all
+		issues are reported, even those intended to be suppressed.
+		Implicitly enables force mode.
+  -w		Behave as if 0 on exit from all checkers. Normally
+		runchecks will fail on the first checker to produce errors or
+		warnings, in fact anything that produces not suppressed
+		output on stderr. This is to make it easy to work interactively,
+		avoiding overlooking anything, but sometimes it is useful to
+		be able to produce a full report of status.
+  -t		Typedef setup mode: For checkers where runchecks enable typedefs:
+		Behaves as -w except for stderr output that is not captured
+		by any typedefs. This is a convenience mode while
+		fixing/improving typedef setup. Use with --color to get red
+		output for the statements to capture with new typedefs.
+  -v		Verbose output. Also enabled if called from make with V=1,
+		but it is useful to be able to only enable verbose mode for runchecks.
+  -d		Debugging output - more verbose.
-- 
git-series 0.9.1
