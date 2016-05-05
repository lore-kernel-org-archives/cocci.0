From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Thu,  5 May 2016 13:03:40 -0700
Subject: [Cocci] [PATCH 1/5] pycocci: use os.path.abspath() for gitname
In-Reply-To: <1462478624-25117-1-git-send-email-mcgrof@kernel.org>
References: <1462478624-25117-1-git-send-email-mcgrof@kernel.org>
Message-ID: <1462478624-25117-2-git-send-email-mcgrof@kernel.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

gitname() is currently used for SmPL <=> Patch
equivalence proof support. It uses git to test
for proofs and also show any differences found.
If the target directory passed where the user
wishes to do work on has is not part of a git
tree, it creates a git tree for you there.

When using relative paths the check for if a
target directory is part of a git tree currently
always fails, the consequences of which are that
if you try to show proof on an existing git tree
you'll end up with a sub-git project, and as such
a new .git under some directory under your target
path.

Correct this by using absolute paths.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 tools/pycocci | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/pycocci b/tools/pycocci
index 43bb9a4dd412..a7b0f69b25f0 100755
--- a/tools/pycocci
+++ b/tools/pycocci
@@ -246,9 +246,10 @@ def git_rev_parse(tree=None, extra_args=None):
     return stdout.split('\n', 1)[0]
 
 def gitname(path=None):
+    path = os.path.abspath(path)
     work_dir = path
     if not os.path.isdir(path):
-        work_dir = os.path.dirname(path)
+        work_dir = os.path.abspath(os.path.dirname(path))
     process = subprocess.Popen(['git', 'rev-parse', '--show-toplevel', path],
                                stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
                                close_fds=True, universal_newlines=True, cwd=work_dir)
-- 
2.7.2
