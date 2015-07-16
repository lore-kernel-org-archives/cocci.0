From: mcgrof@do-not-panic.com (Luis R. Rodriguez)
Date: Wed, 15 Jul 2015 17:21:30 -0700
Subject: [Cocci] [PATCH 2/2] pycocci: figure out if to enable --jobs,
	--use-gitgrep or --use-glimpse
In-Reply-To: <1437006090-25479-1-git-send-email-mcgrof@do-not-panic.com>
References: <1437006090-25479-1-git-send-email-mcgrof@do-not-panic.com>
Message-ID: <1437006090-25479-3-git-send-email-mcgrof@do-not-panic.com>
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
code still needs a bit of work, as the public releases don't yet
build correctly, but nevertheless we should support it.

Instead of removing the old built-in warpper parallelism support
lets keep it and instead check the version of coccinelle you have
and let pycocci figure out what options you need.

The index preference works well if your target is the base for
development, but if its a file we don't yet have support to check
to see where the base for development for that file comes from
and check if it a git directory or glimpse index if there, we
should be easily able to extend to add support this, but for those
cases using --use-coccigrep may suffice anyway for now.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 tools/pycocci | 85 ++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 76 insertions(+), 9 deletions(-)

diff --git a/tools/pycocci b/tools/pycocci
index 5a11e5c770c7..98b6ac257e09 100755
--- a/tools/pycocci
+++ b/tools/pycocci
@@ -266,14 +266,57 @@ class ExecutionErrorThread(CoccinelleError):
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
 
@@ -360,12 +403,36 @@ def _main():
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
+    glimpse_index = os.path.abspath(os.path.join(args.target_dir, '.glimpse_index'))
+    git_dir = os.path.abspath(os.path.join(args.target_dir, '.git'))
+
+    if os.path.isfile(glimpse_index):
+       extra_spatch_args.append('--use-glimpse')
+    elif os.path.isdir(git_dir):
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
