From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Wed, 29 Jun 2016 15:14:56 -0700
Subject: [Cocci] [PATCH v4 6/9] scripts: add Linux .cocciconfig for
	coccinelle
In-Reply-To: <1467238499-10889-1-git-send-email-mcgrof@kernel.org>
References: <1467238499-10889-1-git-send-email-mcgrof@kernel.org>
Message-ID: <1467238499-10889-7-git-send-email-mcgrof@kernel.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Coccinelle supports reading .cocciconfig, the order of precedence for
variables for .cocciconfig is as follows:

 o Your current user's home directory is processed first
 o Your directory from which spatch is called is processed next
 o The directory provided with the --dir option is processed last, if used

Since coccicheck runs through make, it naturally runs from the kernel
proper dir, as such the second rule above would be implied for picking up a
.cocciconfig when using 'make coccicheck'.

'make coccicheck' also supports using M= targets.If you do not supply
any M= target, it is assumed you want to target the entire kernel.
The kernel coccicheck script has:

    if [ "$KBUILD_EXTMOD" = "" ] ; then
        OPTIONS="--dir $srctree $COCCIINCLUDE"
    else
        OPTIONS="--dir $KBUILD_EXTMOD $COCCIINCLUDE"
    fi

KBUILD_EXTMOD is set when an explicit target with M= is used. For both cases
the spatch --dir argument is used, as such third rule applies when
whether M= is used or not, and when M= is used the target directory can
have its own .cocciconfig file. When M= is not passed as an argument to
coccicheck the target directory is the same as the directory from where
spatch was called.

If not using the kernel's coccicheck target, keep the above precedence order
logic of .cocciconfig reading. If using the kernel's coccicheck target,
override any of the kernel's .coccicheck's settings using SPFLAGS.

We help Coccinelle when used against Linux with a set of sensible defaults
options for Linux with our own Linux .cocciconfig. This hints to coccinelle
git can be used for 'git grep' queries over coccigrep. A timeout of 200
seconds should suffice for now.

The options picked up by coccinelle when reading a .cocciconfig do not appear
as arguments to spatch processes running on your system, to confirm what
options will be used by Coccinelle run:

  spatch --print-options-only

You can override with your own preferred index option by using SPFLAGS.
Coccinelle supports both glimpse and idutils. Glimpse had historically
provided the best performance, however recent benchmarks reveal idutils
is performing just as well. Due to some recent fixes however you however
will need at least coccinelle >= 1.0.6 if using idutils.

Coccinelle carries a script scripts/idutils_index.sh which creates the
idutils database with as follows:

    mkid -i C --output .id-utils.index

If using just "--use-idutils" coccinelle expects your idutils database to be
on the top level of the kernel as a file named ".id-utils.index". If you do
not use this you can symlink your database file to it, or you can specify the
database file following the "--use-idutils" argument. Examples:

    make SPFLAGS=--use-idutils coccicheck

This assumes you have $srctree/.id-utils.index, where $srctree is
the top level of the kernel.

    make SPFLAGS="--use-idutils /full-path/to/ID" coccicheck

Here you specify the full path of the idutils ID database. Using
.cocciconfig is possible, however given the order of precedence followed
by Coccinelle, and since the kernel now carries its own .cocciconfig,
you will need to use SPFLAGS to use idutils if desired.

v4:

o Recommend upgrade for using idutils with coccinelle due to some
  recent fixes.

o Refer to using --print-options-only for testing what options are
  picked up by .cocciconfig reading.

o Expand commit log considerably explaining *why* .cocconfig from
  two precedence rules are used when using coccicheck, and how to
  properly override these if needed.

o Expand Documentation/coccinelle.txt

v3: Expand commit log a bit more

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
Acked-by: Julia Lawall <julia.lawall@lip6.fr>
---
 .cocciconfig                 |  3 ++
 .gitignore                   |  1 +
 Documentation/coccinelle.txt | 70 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 74 insertions(+)
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
index 66e822f8caee..b50ac7e126e8 100644
--- a/Documentation/coccinelle.txt
+++ b/Documentation/coccinelle.txt
@@ -189,6 +189,60 @@ work.
 
 DEBUG_FILE support is only supported when using coccinelle >= 1.2.
 
+ .cocciconfig support
+~~~~~~~~~~~~~~~~~~~~~~
+
+Coccinelle supports reading .cocciconfig for default Coccinelle options that
+should be used every time spatch is spawned, the order of precedence for
+variables for .cocciconfig is as follows:
+
+  o Your current user's home directory is processed first
+  o Your directory from which spatch is called is processed next
+  o The directory provided with the --dir option is processed last, if used
+
+Since coccicheck runs through make, it naturally runs from the kernel
+proper dir, as such the second rule above would be implied for picking up a
+.cocciconfig when using 'make coccicheck'.
+
+'make coccicheck' also supports using M= targets.If you do not supply
+any M= target, it is assumed you want to target the entire kernel.
+The kernel coccicheck script has:
+
+    if [ "$KBUILD_EXTMOD" = "" ] ; then
+        OPTIONS="--dir $srctree $COCCIINCLUDE"
+    else
+        OPTIONS="--dir $KBUILD_EXTMOD $COCCIINCLUDE"
+    fi
+
+KBUILD_EXTMOD is set when an explicit target with M= is used. For both cases
+the spatch --dir argument is used, as such third rule applies when whether M=
+is used or not, and when M= is used the target directory can have its own
+.cocciconfig file. When M= is not passed as an argument to coccicheck the
+target directory is the same as the directory from where spatch was called.
+
+If not using the kernel's coccicheck target, keep the above precedence
+order logic of .cocciconfig reading. If using the kernel's coccicheck target,
+override any of the kernel's .coccicheck's settings using SPFLAGS.
+
+We help Coccinelle when used against Linux with a set of sensible defaults
+options for Linux with our own Linux .cocciconfig. This hints to coccinelle
+git can be used for 'git grep' queries over coccigrep. A timeout of 200
+seconds should suffice for now.
+
+The options picked up by coccinelle when reading a .cocciconfig do not appear
+as arguments to spatch processes running on your system, to confirm what
+options will be used by Coccinelle run:
+
+      spatch --print-options-only
+
+You can override with your own preferred index option by using SPFLAGS. Take
+note that when there are conflicting options Coccinelle takes precedence for
+the last options passed. Using .cocciconfig is possible to use idutils, however
+given the order of precedence followed by Coccinelle, since the kernel now
+carries its own .cocciconfig, you will need to use SPFLAGS to use idutils if
+desired. See below section "Additional flags" for more details on how to use
+idutils.
+
  Additional flags
 ~~~~~~~~~~~~~~~~~~
 
@@ -197,8 +251,24 @@ variable. This works as Coccinelle respects the last flags
 given to it when options are in conflict.
 
     make SPFLAGS=--use-glimpse coccicheck
+
+Coccinelle supports idutils as well but requires coccinelle >= 1.0.6.
+When no ID file is specified coccinelle assumes your ID database file
+is in the file .id-utils.index on the top level of the kernel, coccinelle
+carries a script scripts/idutils_index.sh which creates the database with
+
+    mkid -i C --output .id-utils.index
+
+If you have another database filename you can also just symlink with this
+name.
+
     make SPFLAGS=--use-idutils coccicheck
 
+Alternatively you can specify the database filename explicitly, for
+instance:
+
+    make SPFLAGS="--use-idutils /full-path/to/ID" coccicheck
+
 See spatch --help to learn more about spatch options.
 
 Note that the '--use-glimpse' and '--use-idutils' options
-- 
2.8.4
