From: mcgrof@do-not-panic.com (Luis R. Rodriguez)
Date: Fri, 17 Jul 2015 22:05:10 -0700
Subject: [Cocci] [PATCH v2 3/4] pycocci: figure out if to enable --jobs,
	--use-gitgrep or --use-glimpse
In-Reply-To: <1437195911-28821-1-git-send-email-mcgrof@do-not-panic.com>
References: <1437195911-28821-1-git-send-email-mcgrof@do-not-panic.com>
Message-ID: <1437195911-28821-4-git-send-email-mcgrof@do-not-panic.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

pycocci was originally written to set sensible defaults for doing
development with Coccinelle with a git tree and to also add
parallelism wrapper support. Coccinelle now has a '--jobs' argument
which does the same but it works better. This feature is available
as of 1.0.0 but will have some fixes which will go in on 1.0.2.

Likewise the 1.0.1 release has --use-gitgrep support which works
better than --use-coccigrep. An old feature that has been in place
for a long time is --use-glimpse, and since we have that code
released now as open source we should provide support for it as
its expected we'd get the best results with it. The glimpse
code still needs a bit of work, as the public releases doesn't yet
build correctly, but nevertheless we should support it as glimpse
is now open sourced under the ISC license.

Instead of removing the old built-in wrapper for parallelism support
lets keep it and instead check the version of coccinelle you have
and let pycocci figure out what options you need.

Pycocci will also investingate your work area and determine if your
path is part of a git tree or not. That is, you can provide a target
path say drivers/net/tun.c and pycocci will be smart enough to know
that two levels below a .git directory exists. This also works with
directories. It does this by recursing each subdirectory and if it
finds a .git then checking if the target is part of the git tree.
The check in place for this is implemented as gitname(), upon
investingating git code setup_git_directory_gently() is the shortest
possible path to determine if a path is part of a git tree, and
respectively git rev-parse the easiest tool we can use to infer this
from a given path. Something similar is not implemented but can be
done for glimpse. This is not a priority however as glimpse can't
even build yet as-is with the new public release of code.

If all index options fail to check out we resort to --use-coccigrep as
the last-resort default.

Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
---
 tools/pycocci | 97 +++++++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 85 insertions(+), 12 deletions(-)

diff --git a/tools/pycocci b/tools/pycocci
index 141f9783d09b..51d89f618add 100755
--- a/tools/pycocci
+++ b/tools/pycocci
@@ -346,14 +346,57 @@ class ExecutionErrorThread(CoccinelleError):
             tf.close()
             os.unlink(fn)
 
-def spatch(cocci_file, outdir,
-           max_threads, thread_id, temp_dir, ret_q, extra_args=[]):
+class ExecutionErrorCocci(CoccinelleError):
+    def __init__(self, errcode, output, cocci_file, logwrite, print_name):
+        self.error_code = errcode
+        logwrite("Failed to apply changes from %s\n" % print_name)
+        logwrite(output)
+
+def spatch(cocci_file, outdir, logwrite, num_jobs, print_name, extra_args=[]):
+
+    req = Req(chatty=True)
+    req.coccinelle('1.0.2')
+
+    if not req.reqs_match():
+        sys.exit(1)
+
+    num_cpus = cpu_count()
+    if num_jobs:
+        threads = int(num_jobs)
+    else:
+        threads = num_cpus
+
+    cmd = ['spatch',
+            '--sp-file', cocci_file,
+            '--in-place',
+            '--recursive-includes',
+            '--relax-include-path',
+            '--timeout', '120',
+            '--dir', outdir ]
+
+    if (threads > 1):
+            cmd.extend(['--jobs', str(threads)])
+
+    cmd.extend(extra_args)
+
+    logwrite("%s\n" % " ".join(cmd))
+
+    sprocess = subprocess.Popen(cmd,
+                                stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
+                                close_fds=True, universal_newlines=True)
+    output = sprocess.communicate()[0]
+    sprocess.wait()
+    if sprocess.returncode != 0:
+        raise ExecutionErrorCocci(sprocess.returncode, output, cocci_file, logwrite, print_name)
+    return output
+
+def spatch_old(cocci_file, outdir,
+               max_threads, thread_id, temp_dir, ret_q, extra_args=[]):
     cmd = ['spatch',
             '--sp-file', cocci_file,
             '--in-place',
             '--recursive-includes',
             '--relax-include-path',
-            '--use-coccigrep',
             '--timeout', '120',
             '--dir', outdir ]
 
@@ -385,9 +428,9 @@ def threaded_spatch(cocci_file, outdir, logwrite, num_jobs,
     ret_q = Queue()
     with tempdir() as t:
         for num in range(threads):
-            p = Process(target=spatch, args=(cocci_file, outdir,
-                                             threads, num, t, ret_q,
-                                             extra_args))
+            p = Process(target=spatch_old, args=(cocci_file, outdir,
+                                                 threads, num, t, ret_q,
+                                                 extra_args))
             jobs.append(p)
         for p in jobs:
             p.start()
@@ -440,12 +483,42 @@ def _main():
     if args.jobs > 0:
         jobs = args.jobs
 
-    output = threaded_spatch(args.cocci_file,
-                             args.target_dir,
-                             logwrite,
-                             jobs,
-                             os.path.basename(args.cocci_file),
-                             extra_args=extra_spatch_args)
+    has_spatch_1_0_1 = Req(chatty=False)
+    has_spatch_1_0_1.coccinelle('1.0.1')
+
+    has_spatch_1_0_2 = Req(chatty=False)
+    has_spatch_1_0_2.coccinelle('1.0.2')
+
+    git_reqs = Req(chatty=False)
+    git_reqs.require('git')
+
+    glimpse_index = os.path.abspath(os.path.join(args.target_dir, '.glimpse_index'))
+    git_dir = None
+
+    if git_reqs.reqs_match():
+        git_dir = gitname(args.target_dir)
+
+    if os.path.isfile(glimpse_index):
+       extra_spatch_args.append('--use-glimpse')
+    elif git_dir:
+        if has_spatch_1_0_1.reqs_match():
+            extra_spatch_args.append('--use-gitgrep')
+        else:
+            extra_spatch_args.append('--use-coccigrep')
+    else:
+        extra_spatch_args.append('--use-coccigrep')
+
+    if has_spatch_1_0_2.reqs_match():
+        output = spatch(args.cocci_file, args.target_dir, logwrite, jobs,
+                        os.path.basename(args.cocci_file),
+                        extra_args=extra_spatch_args)
+    else:
+        output = threaded_spatch(args.cocci_file,
+                                 args.target_dir,
+                                 logwrite,
+                                 jobs,
+                                 os.path.basename(args.cocci_file),
+                                 extra_args=extra_spatch_args)
     if args.verbose:
         logwrite(output)
     return 0
-- 
2.3.2.209.gd67f9d5.dirty
