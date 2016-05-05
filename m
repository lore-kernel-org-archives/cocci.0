From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Thu,  5 May 2016 13:03:42 -0700
Subject: [Cocci] [PATCH 3/5] pycocci: skip proof if git dir is dirty
In-Reply-To: <1462478624-25117-1-git-send-email-mcgrof@kernel.org>
References: <1462478624-25117-1-git-send-email-mcgrof@kernel.org>
Message-ID: <1462478624-25117-4-git-send-email-mcgrof@kernel.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

SmPL <=> Patch equivalence proof support requires your
git tree to be clean, if it is dirty it will fail. To
avoid confusing users complain if their tree is dirty.

You will either need commit any local pending changes
or discard them before proceeding with SmPL <=> Patch
equivalence proof support.

Extend documentation for this.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 docs/pycocci.1 | 3 +++
 tools/pycocci  | 9 +++++++++
 2 files changed, 12 insertions(+)

diff --git a/docs/pycocci.1 b/docs/pycocci.1
index 63df731fdf46..e7f6b072589c 100644
--- a/docs/pycocci.1
+++ b/docs/pycocci.1
@@ -201,6 +201,9 @@ will set the tree back to the master branch. Each run of \fBpycocci --show-proof
 will create two new git branches. 8 random characters are postixed to each new
 git branch created to avoid conflicts with previous runs.
 
+You must run this option with a clean git tree, if you have any pending changes
+you must commit them or discard them.
+
 .SH AUTHOR
 \fBpycocci\fP and this man page was written by Luis R. Rodriguez <mcgrof@do-not-panic.com>
 
diff --git a/tools/pycocci b/tools/pycocci
index b53bcb778be2..4bcfb46af24b 100755
--- a/tools/pycocci
+++ b/tools/pycocci
@@ -575,6 +575,15 @@ def _main():
             logwrite("Path (%s) not part of a git tree, creating one for you...\n" % (args.target_dir))
             git_init(tree=args.target_dir)
             git_commit_all(tree=args.target_dir, message="Initial commit")
+        else:
+            diff_stat = git_diff(tree=args.target_dir, extra_args = [ '--stat' ] )
+            if len(diff_stat) != 0:
+                logwrite("SmPL <--> Patch proof equivalence requires a "
+                         "clean tree.\nYou have a dirty tree with "
+                         "uncommitted changes:\n\n")
+                logwrite(diff_stat)
+                logwrite("\nEither commit these changes, or stash them away somewhere\n")
+                return -2
         cmd = [ '--abbrev-ref', 'HEAD' ]
         current_branch = git_rev_parse(tree=args.target_dir, extra_args = cmd)
         logwrite("\n")
-- 
2.7.2
