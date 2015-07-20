From: mcgrof@do-not-panic.com (Luis R. Rodriguez)
Date: Mon, 20 Jul 2015 15:32:21 -0700
Subject: [Cocci] [PATCH v3 2/5] pycocci: add git class
In-Reply-To: <1437431544-32662-1-git-send-email-mcgrof@do-not-panic.com>
References: <1437431544-32662-1-git-send-email-mcgrof@do-not-panic.com>
Message-ID: <1437431544-32662-3-git-send-email-mcgrof@do-not-panic.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

From: "Luis R. Rodriguez" <mcgrof@suse.com>

This will let us check and use git for both inference
of whether or not --use-gitgrep is needed later, and
also for SmPL patch equivalence proof support later.

Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
---
 tools/pycocci | 80 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/tools/pycocci b/tools/pycocci
index 5a11e5c770c7..141f9783d09b 100755
--- a/tools/pycocci
+++ b/tools/pycocci
@@ -215,6 +215,86 @@ class Req:
     def gcc(self, version):
         return self.require_version('gcc', '--version', version, 3, self.linux_version_cmp)
 
+class GitError(Exception):
+    pass
+class ExecutionGitError(GitError):
+    def __init__(self, errcode):
+        self.error_code = errcode
+
+def _check(process):
+    if process.returncode != 0:
+        raise ExecutionError(process.returncode)
+
+def git_init(tree=None):
+    process = subprocess.Popen(['git', 'init'],
+                               stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
+                               close_fds=True, universal_newlines=True, cwd=tree)
+    stdout = process.communicate()[0]
+    process.wait()
+    _check(process)
+
+def git_rev_parse(tree=None, extra_args=None):
+    cmd = ['git', 'rev-parse' ] + extra_args
+    process = subprocess.Popen(cmd,
+                               stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
+                               close_fds=True, universal_newlines=True, cwd=tree)
+    stdout = process.communicate()[0]
+    process.wait()
+    if process.returncode != 0:
+        return None
+    return stdout.split('\n', 1)[0]
+
+def gitname(path=None):
+    work_dir = path
+    if not os.path.isdir(path):
+        work_dir = os.path.dirname(path)
+    process = subprocess.Popen(['git', 'rev-parse', '--show-toplevel', path],
+                               stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
+                               close_fds=True, universal_newlines=True, cwd=work_dir)
+    stdout = process.communicate()[0]
+    process.wait()
+    if process.returncode != 0:
+        return None
+    return stdout.split('\n', 1)[0]
+
+def git_add(path, tree=None):
+    process = subprocess.Popen(['git', 'add', '--ignore-removal', path],
+                               stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
+                               close_fds=True, universal_newlines=True, cwd=tree)
+    stdout = process.communicate()[0]
+    process.wait()
+    _check(process)
+
+def git_checkout(tree=None, extra_args=None):
+    cmd = ['git', 'checkout' ] + extra_args
+    process = subprocess.Popen(cmd,
+                               stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
+                               close_fds=True, universal_newlines=True, cwd=tree)
+    stdout = process.communicate()[0]
+    process.wait()
+    _check(process)
+
+def git_commit_all(message, tree=None):
+    git_add('.', tree=tree)
+    process = subprocess.Popen(['git', 'commit', '--allow-empty', '-a', '-m', message],
+                               stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
+                               close_fds=True, universal_newlines=True, cwd=tree)
+    stdout = process.communicate()[0]
+    process.wait()
+    _check(process)
+
+def git_diff(tree=None, extra_args=None):
+    cmd = ['git', 'diff', '--color=always'] + extra_args
+
+    process = subprocess.Popen(cmd,
+                               stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
+                               close_fds=True, universal_newlines=True, cwd=tree)
+    stdout = process.communicate()[0]
+    process.wait()
+    _check(process)
+
+    return stdout
+
 # simple tempdir wrapper object for 'with' statement
 #
 # Usage:
-- 
2.3.2.209.gd67f9d5.dirty
