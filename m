From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Thu,  5 May 2016 13:03:41 -0700
Subject: [Cocci] [PATCH 2/5] pycocci: add git branch support to git library
In-Reply-To: <1462478624-25117-1-git-send-email-mcgrof@kernel.org>
References: <1462478624-25117-1-git-send-email-mcgrof@kernel.org>
Message-ID: <1462478624-25117-3-git-send-email-mcgrof@kernel.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

This will be used later on an new command for pycocci.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 tools/pycocci | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/pycocci b/tools/pycocci
index a7b0f69b25f0..b53bcb778be2 100755
--- a/tools/pycocci
+++ b/tools/pycocci
@@ -276,6 +276,15 @@ def git_checkout(tree=None, extra_args=None):
     process.wait()
     _check(process)
 
+def git_branch(tree=None, extra_args=None):
+    cmd = ['git', 'branch' ] + extra_args
+    process = subprocess.Popen(cmd,
+                               stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
+                               close_fds=True, universal_newlines=True, cwd=tree)
+    stdout = process.communicate()[0]
+    process.wait()
+    _check(process)
+
 def git_commit_all(message, tree=None):
     git_add('.', tree=tree)
     process = subprocess.Popen(['git', 'commit', '--allow-empty', '-a', '-m', message],
-- 
2.7.2
