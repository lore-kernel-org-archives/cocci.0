From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Wed, 29 Jun 2016 15:10:23 -0700
Subject: [Cocci] [RFC v4 6/9] scripts: add Linux .cocciconfig for coccinelle
In-Reply-To: <1467238226-10822-1-git-send-email-mcgrof@kernel.org>
References: <1467238226-10822-1-git-send-email-mcgrof@kernel.org>
Message-ID: <1467238226-10822-7-git-send-email-mcgrof@kernel.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Coccinelle supports reading .cocciconfig, the order of precedence for
variables for .coccoconfig is as follows:

 o Your current user's home directory is processed first
 o Your directory from which spatch is called is processed next
 o The directory provided with the --dir option is processed last, if used

Since coccicheck runs through make, it naturally runs from the kernel
proper dir, as such the second rule above would be implied for picking up a
.cocciconfig when using 'make coccicheck'.

'make coccicheck' also supports using M= targets, and you can also avoid
supplying any target, in the later case its assumed you want to target
the entire kernel. coccicheck has:

    if [ "$KBUILD_EXTMOD" = "" ] ; then
        OPTIONS="--dir $srctree $COCCIINCLUDE"
    else
        OPTIONS="--dir $KBUILD_EXTMOD $COCCIINCLUDE"
    fi

For both cases --dir is used, as such following the third rule the target
also can have its own .cocciconfig file, since make is used for it, its the
same file when no M=path is passed.

If using spatch manually just keep the above order logic in mind when
making changes, if you need to override any settings use SPFLAGS.

We help Coccinelle when used against Linux with a set of sensible defaults
options for Linux with our own Linux .cocciconfig. This hints to coccinelle
git can be used for 'git grep' queries over coccigrep. A timeout of 200
seconds should suffice for now.

To confirm what options will be used by Coccinelle run:

  spatch --print-options-only

The options picked up by .cocciconfig can ony be verified with the
above, by default Coccinelle does not paste these the spawned command
line run for an spatch instance.

Coccinelle also has support for idutils and this helps, if you use it,
however its use is obviously optional. Upstream coccinelle has a
script scripts/idutils_index.sh in its repository, it assumes you
do:

  mkid -i C --output .id-utils.index

Coccinelle searches for the index in the directory on which it is working
...

If you use idutils you can override for 'make coccicheck' by using the
SPFLAGS option as follows:

First build the index, for example:
mkid -s

Pick the cocci file you wnat to work with:
export COCCI=scripts/coccinelle/misc/irqf_oneshot.cocci

Then run coccicheck:
$ make coccicheck V=1 MODE=report SPFLAGS="--use-idutils ID"

Coccinelle supports reading .cocciconfig from different directories,
the later one overriding the previous reads in the following order:

 o Your current user's home directory is processed first
 o Your directory from which spatch is called is processed next
 o The directory provided with the --dir option is processed last, if used

v4:

o Refer to using --print-options-only for testing what options are
  picked up by .cocciconfig reading.

o Expand commit log considerably explaining *why* .cocconfig from
  two precedence rules are used when using coccicheck, and how to
  properly override these if needed.

o Expand Documentation/coccinelle.txt

v3: Expand commit log a bit more

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 .cocciconfig                 |  3 +++
 .gitignore                   |  1 +
 Documentation/coccinelle.txt | 47 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+)
 create mode 100644 .cocciconfig

diff --git a/.cocciconfig b/.cocciconfig
new file mode 100644
index 000000000000..43967c6b2015
--- /dev/null
+++ b/.cocciconfig
@@ -0,0 +1,3 @@
+[spatch]
+	options = --timeout 200
+	options = --use-gitgrep
diff --git a/.gitignore b/.gitignore
index 2be25f771bd8..c2ed4ecb0acd 100644
--- a/.gitignore
+++ b/.gitignore
@@ -67,6 +67,7 @@ Module.symvers
 #
 !.gitignore
 !.mailmap
+!.cocciconfig
 
 #
 # Generated include files
diff --git a/Documentation/coccinelle.txt b/Documentation/coccinelle.txt
index 4f5b2287a2b1..a425b1f1df99 100644
--- a/Documentation/coccinelle.txt
+++ b/Documentation/coccinelle.txt
@@ -189,6 +189,53 @@ work.
 
 DEBUG_FILE support is only supported when using coccinelle >= 1.2.
 
+ .cocciconfig support
+~~~~~~~~~~~~~~~~~~~~~~
+
+Coccinelle supports reading .cocciconfig for default Coccinelle options that
+should be used every time spatch is spawned, the order of precedence for
+variables for .coccoconfig is as follows:
+
+  o Your current user's home directory is processed first
+  o Your directory from which spatch is called is processed next
+  o The directory provided with the --dir option is processed last, if used
+
+Since coccicheck runs through make, it naturally runs from the kernel
+proper dir, as such the second rule above would be implied for picking up a
+.cocciconfig when using 'make coccicheck'.
+
+'make coccicheck' also supports using M= targets, and you can also avoid
+supplying any target, in the later case its assumed you want to target
+the entire kernel. coccicheck has:
+
+    if [ "$KBUILD_EXTMOD" = "" ] ; then
+        OPTIONS="--dir $srctree $COCCIINCLUDE"
+    else
+        OPTIONS="--dir $KBUILD_EXTMOD $COCCIINCLUDE"
+    fi
+
+For both cases --dir is used, as such following the third rule the target
+also can have its own .cocciconfig file, since make is used for it, its the
+same file when no M=path is passed.
+
+If using spatch manually just keep the above order logic in mind when
+making changes, if you need to override any settings use SPFLAGS.
+
+To verify what options are taking effect run:
+
+  spatch --print-options-only
+
+The options picked up by .cocciconfig can only be verified with the
+above, by default Coccinelle does not paste these the spawned command
+line run for an spatch instance.
+
+Take note that when there are conflicting options Coccinelle takes
+precedence for the last options passed. Linux supplies its own .cocciconfig
+with a suitable set of defaults, this includes using its internal
+'--use-gitgrep' for using 'git grep' when identifying what code to
+look for, for processing. Refer to the "Additional flags" section below
+to learn how to override default .cocciconfig supplied by Linux.
+
  Additional flags
 ~~~~~~~~~~~~~~~~~~
 
-- 
2.8.4
