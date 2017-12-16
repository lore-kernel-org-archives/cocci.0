From: knut.omang@oracle.com (Knut Omang)
Date: Sat, 16 Dec 2017 15:42:27 +0100
Subject: [Cocci] [PATCH v2 2/5] Documentation: Add doc for runchecks,
	a checker runner
In-Reply-To: <cover.630ac8faeeda67bf7a778c158174422042942d08.1513430008.git-series.knut.omang@oracle.com>
References: <cover.630ac8faeeda67bf7a778c158174422042942d08.1513430008.git-series.knut.omang@oracle.com>
Message-ID: <7bd67f980fdf33031c54955f7e04b435c267886e.1513430008.git-series.knut.omang@oracle.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

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
 Documentation/dev-tools/runchecks.rst  | 215 ++++++++++++++++++++++++++-
 Documentation/dev-tools/sparse.rst     |  30 +++-
 Documentation/kbuild/kbuild.txt        |   9 +-
 5 files changed, 257 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/dev-tools/runchecks.rst

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
index 0000000..b25b3de
--- /dev/null
+++ b/Documentation/dev-tools/runchecks.rst
@@ -0,0 +1,215 @@
+.. Copyright 2017 Knut Omang <knut.omang@oracle.com>
+
+Makefile support for running checkers
+=====================================
+
+Tools like sparse, coccinelle and scripts/checkpatch.pl is able to detect a
+lot of syntactic and semantic issues with the code, and is also constantly
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
+  have to reinvent it's own mechanism for running checks.
+* On the other hand, we want to make sure that files that are clean
+  (to some well defined extent, such as passing checkpatch or sparse
+  with checks only for certain important types of issues) keep being so.
+
+This is the purpose of ``scripts/runchecks``.
+
+The ``runchecks`` program looks for files named ``runchecks.cfg`` in the
+``scripts`` directory, then in the directory hierarchy of the source file,
+starting where that source file is located, searching upwards. If at least
+one such file exists in the source tree, ``runchecks`` parses a set of
+rules from it, and use them to determine how to invoke a set of individual
+checker tools for a particular file. The kernel Makefile system supports using
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
+runchecks itself will be forwarded to the checker. If more than one checker
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
+The runchecks configuration file chain can be used to set policies and "rein in"
+checker errors piece by piece for a particular subsystem or driver. It can
+also be used to mitigate and extend checkers that does not support
+selective suppression of all it's checks.
+
+Two classes of configuration is available. The first class is configuration
+that defines what checkers are enabled, and also allow a limited form of
+pattern matching to extend checking, to mitigate for checks that cannot be
+selectively disabled by command line parameters to the underlying tool
+itself. This type of configuration should go into the first accessed
+configuration file, and has been preconfigured for the currently supported
+checkers in ``scripts/runchecks.cfg``. The second class is the features for
+configuring the output of the checkers by selectively suppressing checks on
+a per file or per check basis. These typically goes in the source tree in
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
+applies to that particular checker. The first occurrence of ``checker``
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
+The ``cflags`` command tells to forward all the flags and options passed to
+the compiler invocation to the checker. The default is to suppress these
+parameters when invoking the checker.
+
+The ``typedef`` command adds ``NAME`` and associates it with the given
+regular expression. This expression is used to match against standard error
+output from the checker and ``NAME`` can be used as a new named check that
+runchecks understands and that can be used with checker supported names
+below to selectively suppress that particular set of warning or error
+messages. This is useful to handle output checks for which the underlying
+checker is does not provide any suppression. Check type namespaces are
+separate for the individual checkers. You can list the state of the built in and
+configured checker and check types with::
+
+	scripts/runchecks --list
+
+The checker implementations of the ``typedef`` command also allows
+runchecks to perform some unification of output by rewriting the output
+lines, adding optional color support, and use of the new type names in the
+error output, to ease the process of updating the runchecks.cfg files.
+Having a unified representation of the error output also makes it much
+easier to do statistics or other operations on top of an aggregated output
+from several checkers.
+
+For the second class of configuration the following syntax is supported::
+
+	# comments
+	checker checker_name
+	line_len <n>
+	except check_type [files ...]
+	pervasive check_type1 [check_type2 ...]
+
+The ``line_len`` directive defines the upper bound of characters per line
+tolerated in this directory. Currently only ``checkpatch`` supports this
+command.  The ``except`` directive takes a check type such as for example
+``MACRO_ARG_REUSE``, and a set of files that should not be subject to this
+particular check type. The ``pervasive`` command disables the listed types
+of checks for all the files in the subtree.  The ``except`` and
+``pervasive`` directives can be used cumulatively to add more exceptions.
+
+Running checker programs from make
+----------------------------------
+
+You can run checkpatch subject to rules defined in ``runcheck.cfg`` in the
+directory of the source file by using "make P=1" to run checkpatch on all files
+that gets recompiled, or "make P=2" to run checkpatch on all source files.
+
+A make variable ``CF`` allows passing additional parameters to
+``runchecks``. You can for instance use::
+
+	make C=2 CF="--run:checkpatch --fix-inplace"
+
+to run only the ``checkpatch`` checker, and to have checkpatch trying to fix
+issues it finds - *make sure you have a clean git tree and carefully review
+the output afterwards!* Combine this with selectively enabling of types of
+errors via changes under ``checker checkpatch`` to the local
+``runchecks.cfg``, and you can focus on fixing up errors subsystem or
+driver by driver on a type by type basis.
+
+By default runchecks will skip all files if a ``runchecks.cfg`` file cannot
+be found in the directory of the file or in the tree above.  This is to
+allow builds with ``C=2`` to pass even for subsystems that has not yet done
+anything to rein in checker errors. At some point when all subsystems and
+drivers either have fixed all checker errors or added proper
+``runchecks.cfg`` files, this can be changed.
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
+Before submitting your changes, verify that a full "make C=2" passes with no
+errors.
+
+Extending and improving checker support in ``runchecks``
+--------------------------------------------------------
+
+The runchecks program has been written with extensibility in mind.
+If the checker starts it's reporting lines with filename:lineno, there's a
+good chance that a new checker can simply be added by adding::
+
+	checker mychecker path_to_mychecker
+
+to ``scripts/runchecks.cfg`` and suitable ``typedef`` expressions to provide
+selective suppressions of output, however it is likely that some quirks are
+needed to make the new checker behave similar to the others, and to support
+the full set of features, such as the ``--list`` option. This is done by
+implementing a new subclass of the Checker class in ``runchecks``. This is the way
+all the available default supported checkers are implemented, and those
+relatively lean implementations could serve as examples.
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
-- 
git-series 0.9.1
