From: mcgrof@do-not-panic.com (Luis R. Rodriguez)
Date: Mon, 20 Jul 2015 15:32:24 -0700
Subject: [Cocci] [PATCH v3 5/5] pycocci: add man page and promote pycocci to
	install target
In-Reply-To: <1437431544-32662-1-git-send-email-mcgrof@do-not-panic.com>
References: <1437431544-32662-1-git-send-email-mcgrof@do-not-panic.com>
Message-ID: <1437431544-32662-6-git-send-email-mcgrof@do-not-panic.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

From: "Luis R. Rodriguez" <mcgrof@suse.com>

pycocci now has a bit different uses and purposes:

- Check your version of coccinelle and enables sensible defaults
  known to work best for your environment. For instance:

  * --jobs: although this was added as of 1.0.1 there are some
      issues with its implementation which will be fixe don 1.0.2,
      for older releases pycocci provides its own built-in
      multithreaded batched solution

  * --use-gitgrep: although added for 1.0.1 this has some issues
      which will be fixed on 1.0.2

  * although as of coccinelel 1.0.2 coccinelle users can safely use
    --use-gitgrep by default pycocci will avoid a failed 'git grep'
    call by checking if your target path is part of a git tree for
    you and that you have git installed, therefore avoiding a failed
    run to git grep.

  * pycocci will check if you need --use-glimpse for you, otherwise
    it will use --use-gitgrep when your path is part of a git tree.
    It will always fall back to --use-cocci grep otherwise.

- Add features to supplement / make it easier to do SmPL patch
  development. One feature added in this release is to provide
  support for SmPL patch equivalence proof; you can use
  --show-proof to replace a patch series and then show any
  differences produced between your patch series and an SmPL
  patch. This can be used to find -- in the worst case bugs in
  Coccinelle (although highly uncommon these days) -- but also any
  changes you may have missed. In practice this tool so far has
  been used to enable to split up patch series in the backports
  project into proper separate atomic pieces, and showing you the
  areas where by switching to Coccinelle you have now enabled
  new automatic backports (a lot of new code additions).

pycocci can be used as a generic wrapper to call coccinelle for a
variety of reasons and enables us to give home to expanding ideas
to further enhance doing SmPL patch development. In the future
we may also add statistics and metrics to help evaluate the
efficiency and impact of an SmPL patch on code base.

Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
---
 Makefile       |   3 +
 docs/pycocci.1 | 217 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/pycocci  |  11 ++-
 3 files changed, 225 insertions(+), 6 deletions(-)
 create mode 100644 docs/pycocci.1

diff --git a/Makefile b/Makefile
index 27904f150204..63130b00af0f 100644
--- a/Makefile
+++ b/Makefile
@@ -448,6 +448,7 @@ install-man:
 	$(MKDIR_P) $(DESTDIR)$(MANDIR)/man1
 	$(MKDIR_P) $(DESTDIR)$(MANDIR)/man3
 	$(INSTALL_DATA) docs/spatch.1 $(DESTDIR)$(MANDIR)/man1/
+	$(INSTALL_DATA) docs/pycocci.1 $(DESTDIR)$(MANDIR)/man1/
 	$(INSTALL_DATA) docs/Coccilib.3cocci $(DESTDIR)$(MANDIR)/man3/
 
 install-bash:
@@ -487,6 +488,8 @@ install-stubs:
 install: install-man install-common install-stubs $(PYTHON_INSTALL_TARGET)
 	rm -f $(DESTDIR)$(LIBDIR)/spatch
 	rm -f $(DESTDIR)$(LIBDIR)/spatch.opt
+	rm -f $(DESTDIR)$(LIBDIR)/pycocci
+	$(INSTALL_PROGRAM) tools/pycoci $(DESTDIR)$(LIBDIR)
 	@if test -x spatch -o -x spatch.opt; then \
 		$(MAKE) install-def;fi
 	@if test -x spatch ; then \
diff --git a/docs/pycocci.1 b/docs/pycocci.1
new file mode 100644
index 000000000000..ab9049c3e9d7
--- /dev/null
+++ b/docs/pycocci.1
@@ -0,0 +1,217 @@
+.\"  -*- nroff -*-
+.\" Please adjust this date whenever revising the manpage.
+.TH pycocci 1 "July 20, 2015"
+
+.\" see http://www.fnal.gov/docs/products/ups/ReferenceManual/html/manpages.html
+.\" see http://www.linuxjournal.com/article/1158
+.\" see http://www.schweikhardt.net/man_page_howto.html
+.\" groff -Tascii -man ./spatch.1 | more
+.\"
+.\" Some roff macros, for reference:
+.\" .nh        disable hyphenation
+.\" .hy        enable hyphenation
+.\" .ad l      left justify
+.\" .ad b      justify to both left and right margins
+.\" .nf        disable filling
+.\" .fi        enable filling
+.\" .br        insert line break
+.\" .sp <n>    insert n+1 empty lines
+.\" for manpage-specific macros, see man(7)
+.\"
+.\" TeX users may be more comfortable with the \fB<whatever>\fP and
+.\" \fI<whatever>\fP escape sequences to invode bold face and italics, 
+.\" respectively. Also \fR for roman.
+.\" pad: src: deputy man page
+.SH NAME
+pycocci \- Coccinelle wrapper for SmPL patch development
+
+.B pycocci
+.B [\-h | \-\-help]
+.B [\-p | \-\-profile\-cocci]
+.B [\-j | \-\-jobs <job-digit> ]
+.B [\-v | \-\-verbose]
+.B [\-s | \-\-show\-proof]
+.I <SmPL-patch.cocci>
+.I <target>
+.B ]
+.\"
+.SH DESCRIPTION
+\fBpycocci\fP is wrapper around \fBspatch\fP, it enables a set of default
+arguments and also uses a bit of heuristics to infers which arguments you
+likely want enabled. It takes two arguments, the <SmPL-patch.cocci> and your
+<target> which can either be a directory or file. The actual command run
+is always displayed on standard output.
+
+Coccinelle \fBspatch\fP is a very rich tool, it provides a large set of
+features for use with the Coccinelle engine. Typical day to day SmPL patch
+development may only require a base set of features though, we can also infer
+a set of features depending on your target. \fBpycocci\fP enables a set of
+flags which over time have been determined to be required for day to day
+Linux kernel development, for instance through a cronjob, it also uses a set
+of heuristics to infer a set of arguments to use depending on your release of
+Coccinelle. \fBpycocci\fP also checks to see which version of Coccinelle you
+have installed and looks to enable arguments depending on what version of
+Coccinelle you have installed.
+
+\fBpycocci\fP can also be used to help write and verify SmPL patches when
+replacing a regular patch series. \fBpycocci\fP checks the version of
+\fBspatch\fP installed and based on this enables a set of features. This man
+page will document what options it always enables by default, why it has
+done this and it will also document the heuristics used and logic behind them.
+
+.SH DEFAULT ARGUMENTS
+
+By default \fBpycocci\fP will always enable when running \fBspatch\fP:
+
+\fB--in-place\fP
+
+\fB--recursive-includes\fP
+
+\fB--relax-include-path\fP
+
+\fB--timeout 120\fP
+
+\fB--dir <target>\fP
+
+The \fB--in-place\fP option is enabled by default as most development these
+days happens on version control systems and built-in version control systems
+can typically display differences better.
+
+\fB--relax-include-path\fP and \fB--relax-include-path\fP are enabled by
+default given that at least for Linux kernel development some C files tend to
+include headers in paths only specified by a target's Makefile through
+utilities such as subdir-ccflags or ccflags-y making it difficult to ensure
+all required header files are read by Coccinelle. We are agressive with
+headers search and inclusion.
+
+A default timeout of 120 seconds is used by default. Not using a timeout
+is typically not a good idea. The value of 120 is used by default and is
+considered significantly large enough to support most SmPL patches.
+
+We make use of \fB--dir\fP to enable use of a target directory and its
+subdirectories recursively.
+
+.SH MULTITHREAD ARGUMENT HEURISTICS
+
+Coccinelle \fBspatch\fP prior to release 1.0.0 provided support for
+multithreading but required the developer to spawn each thread on
+their own, and provide an index reference number identifying each
+thread. Coccinelle would divide the amount of work required to be
+done and based on the index grant the thread a specific set of work.
+Some shell scripts could be used to help split the work out for you.
+\fBpycocci\fP was originally written to supercede these scripts and
+use Python's multithreaded support, while also enabling some sensible
+arguments by default.
+
+If you have a version of \fBspatch\fP older than 1.0.2 \fBpycocci\fP will
+provide its own built-in multithreaded batched solution, the \fBspatch\fP
+--jobs argument is enabled on \fBspatch\fP >= 1.0.2. The \fBspatch\fP --jobs
+arguments takes advantage of Coccinelle's built-in paramap support, and
+performance-wise yields better results than \fBpycocci\fP's multithreaded
+solution. The number of threads used will always default to the number of
+number of CPUs on your system, this is taken from what Python
+multiprocessing.cpu_count() returns. You can override the number of threads
+\fBpycocci\fP will use with the --jobs argument.
+
+.SH INDEXING ARGUMENT HEURISTICS
+
+Coccinelle \fBpycocci\fP supports using a series of indexing alternatives:
+
+\fB--use-glimpse\fP
+
+\fB--use-gitgrep\fP
+
+\fB--use-coccigrep\fP
+
+Coccinelle puts the onus of which indexing feature to enable on the developer.
+\fBpycocci\fP will figure things out for you and make sure that only supported
+options are used in specific supported releases of coccinelle. So for instance,
+although --use-gitgrep has been available on 1.0.1 \fBpycocci\fP will only
+it on 1.0.2. The order of preference for what indexing option to uses the
+following heuristics: If your target directory has a .glimpse_index file we
+assume you will want to use --use-glimpse. Glimpse is now released under the
+ISC license and performance-wise is known to work as the best indexing
+alternative, this is why we always check for a glimpse index first. This
+heuristic is however limited, you need the target path to be the base
+directory where the .glimpse_index file exists, otherwise \fBpycocci\fP
+will not recurse below on sub-directories. If we determine glimpse cannot
+be used then \fBpycocci\fP will use \fBgit rev-parse --toplevel\fP on the specified
+path to determine if the provided path is part of a git directory to enable
+--use-gitgrep. Although coccinelle provides a fail-safe mechanism to enable
+use of --use-gitgrep and fall back onto --use-coccigrep if a git tree is
+not used, we avoid the failure case ahead of time. \fBpycocci\fP will be
+tuned through each release to infer the best indexing option known to
+use on your target path.
+
+.PP
+Further information about spatch is available at
+\fBhttp://coccinelle.lip6.fr/\fP.
+
+.SH OPTIONS
+Here is a summary of the options available on \fBpycocci\fP:
+
+.SH SYNOPSIS
+.B pycocci
+.B [\-h | \-\-help]
+.B [\-p | \-\-profile\-cocci]
+.B [\-j | \-\-jobs]
+.B [\-v | \-\-verbose]
+.B [\-s | \-\-show\-proof]
+.I <SmPL patch>
+.I <target>
+.B ]
+
+.TP
+.B \-h | \-\-help
+print short help menu
+.TP
+.B\-p | \-\-profile\-cocci
+Profile the <SmPL patch> when run against <target>
+.TP
+.B\-j | \-\-jobs <job-digit>
+Override the default number of jobs to use with <job-digit>. You really
+only need this if the heuristics for the default number of jobs is
+determined to be incorrect.
+.TP
+.B\-v | \-\-verbose
+Output all possible information when run. By default \fBpycocci\fP will
+provide no output unless an error is found.
+.TP
+.B\-s | \-\-show\-proof
+Show that the <SmPL-patch.cocci> can replace a series of patches. The <SmPL-patch.cocci>
+must have a .cocci postfix. A series of patches are expected to exist in the
+directory named after the <SmPL-patch.cocci> with the .cocci postfix removed.
+\fBpycocci\fP will use git in order to show a proof of equivalence between the
+two. A new git branch will be created and used to apply the series of patches
+("pycocci-patch-8-random-chars") onto the <target>, another git branch will be created and
+used to apply the <SmPL-patch.cocci> ("pycocci-smpl-8-random-chars"). \fBpycocci\fP will
+display name of the newly created branches and finally provide the
+output of \fBgit diff --stat <pycocci-patch-8-random-chars>..<pycocci-smpl-8-random-chars>\fP. You should see
+no changes, and therefore a \fBperfect SmPL patch equivalence\fP, when the diffstat
+on the ouput shows no changes. The way to interpet a positive diffstat is that
+the <SmPL-patch.cocci> is introducing more changes than the patch series. The
+way to interpret a negative diffstat is that the <SmPL-patch.cocci> is lacking
+some changes in place on the patch series. \fBpycocci\fP will use \fBgit rev-parse --toplevel\fP
+against the <target> to see if the <target> is part of a git tree. If the <target>
+is not part of a git tree a git tree is created for you on <target> if <target>
+is a directory or on the base directory of <target> if <target> is a file.
+\fBpycocci\fP will return you to the branch previously set on the <target> if
+one was previously set, otherwise if a new git tree was created for you \fBpycocci\fP
+will set the tree back to the master branch. Each run of \fBpycocci --show-proof\fP
+will create two new git branches. 8 random characters are postixed to each new
+git branch created to avoid conflicts with previous runs.
+
+.SH AUTHOR
+\fBpycocci\fP and this man page was written by Luis R. Rodriguez <mcgrof@do-not-panic.com>
+
+.SH REPORTING BUGS
+Send an mail to <cocci@systeme.lip6.fr>
+
+.SH COPYRIGHT
+Copyright 2015, Luis R. Rodriguez
+pycocci is free software: you can redistribute it and/or modify
+it under the terms of the GNU General Public License as published by
+the Free Software Foundation, according to version 2 of the License.
+
+.SH SEE ALSO
+\fIspatch\fP(1), \fIpycocci\fP(1), \fIdiff\fP(1)
diff --git a/tools/pycocci b/tools/pycocci
index e9243aa1b0db..266957bd90cd 100755
--- a/tools/pycocci
+++ b/tools/pycocci
@@ -495,13 +495,12 @@ def logwrite(msg):
     sys.stdout.flush()
 
 def _main():
-    parser = argparse.ArgumentParser(description='Multithreaded Python wrapper for Coccinelle ' +
-                                     'with sensible defaults, targetted specifically ' +
-                                     'for git development environments')
-    parser.add_argument('cocci_file', metavar='<Coccinelle SmPL rules file>', type=str,
+    parser = argparse.ArgumentParser(description='Wrapper around Coccinelle spatch ' +
+                                     'which infers which options to enable.')
+    parser.add_argument('cocci_file', metavar='<SmPL patch>', type=str,
                         help='This is the Coccinelle file you want to use')
-    parser.add_argument('target_dir', metavar='<target directory>', type=str,
-                        help='Target source directory to modify')
+    parser.add_argument('target_dir', metavar='<target>', type=str,
+                        help='Target directory or file to modify')
     parser.add_argument('-p', '--profile-cocci', const=True, default=False, action="store_const",
                         help='Enable profile, this will pass --profile  to Coccinelle.')
     parser.add_argument('-s', '--show-proof', const=True, default=False, action="store_const",
-- 
2.3.2.209.gd67f9d5.dirty
