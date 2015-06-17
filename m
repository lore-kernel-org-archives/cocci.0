From: mcgrof@do-not-panic.com (Luis R. Rodriguez)
Date: Wed, 17 Jun 2015 16:13:20 -0700
Subject: [Cocci] [RFC] pycocci: use internal parallel processing
	functionality
Message-ID: <1434582800-23806-1-git-send-email-mcgrof@do-not-panic.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

From: "Luis R. Rodriguez" <mcgrof@suse.com>

The paramap multiprocessor functionalty is better than
the Python wrappers, use that. Since we still want folks
to not have to figure out what arguments to use for a
basic run on git development environments keep pycocci
around for just that.

We may extend this later with SmPL proof hooks.

Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
---

Does anyone object to keep pycocci around which would just exist
as a wrapper with sensible defeaults to Coccinelle for typical
day to day development on C code on git environments? I use it
so, figure I'd keep it as I figure others might. If you don't,
do you realloy fill out all those arguments to spatch every time
or do you carry your own wrappers? Just curious.

Also, I figure we might use pycocci to extend it with SmPL proof
support [0], I did that work for backports but since it seems
we keep abusing gentree.py we decided to look for another home for
such functionality. Would pycocci be a good home for such things
or should we try to aim for somethinge else?

[0] https://systeme.lip6.fr/pipermail/cocci/2015-June/002100.html

 tools/pycocci | 117 ++++++++++------------------------------------------------
 1 file changed, 20 insertions(+), 97 deletions(-)

diff --git a/tools/pycocci b/tools/pycocci
index 4aa1d36..baaa88d 100755
--- a/tools/pycocci
+++ b/tools/pycocci
@@ -11,61 +11,23 @@
 
 from multiprocessing import Process, cpu_count, Queue
 import argparse, subprocess, os, sys
-import tempfile, shutil
-
-# simple tempdir wrapper object for 'with' statement
-#
-# Usage:
-# with tempdir.tempdir() as tmpdir:
-#     os.chdir(tmpdir)
-#     do something
-#
-class tempdir(object):
-    def __init__(self, suffix='', prefix='', dir=None, nodelete=False):
-        self.suffix = ''
-        self.prefix = ''
-        self.dir = dir
-        self.nodelete = nodelete
-
-    def __enter__(self):
-        self._name = tempfile.mkdtemp(suffix=self.suffix,
-                                      prefix=self.prefix,
-                                      dir=self.dir)
-        return self._name
-
-    def __exit__(self, type, value, traceback):
-        if self.nodelete:
-            print('not deleting directory %s!' % self._name)
-        else:
-            shutil.rmtree(self._name)
 
 class CoccinelleError(Exception):
     pass
 
-class ExecutionErrorThread(CoccinelleError):
-    def __init__(self, errcode, fn, cocci_file, threads, t, logwrite, print_name):
+class ExecutionError(CoccinelleError):
+    def __init__(self, errcode, output, cocci_file, logwrite, print_name):
         self.error_code = errcode
         logwrite("Failed to apply changes from %s\n" % print_name)
+        logwrite(output)
 
-        logwrite("Specific log output from change that failed using %s\n" % print_name)
-        tf = open(fn, 'r')
-        for line in tf.read():
-            logwrite(line)
-        tf.close()
-
-        logwrite("Full log using %s\n" % print_name)
-        for num in range(threads):
-            fn = os.path.join(t, '.tmp_spatch_worker.' + str(num))
-            if (not os.path.isfile(fn)):
-                continue
-            tf = open(fn, 'r')
-            for line in tf.read():
-                logwrite(line)
-            tf.close()
-            os.unlink(fn)
+def spatch(cocci_file, outdir, logwrite, num_jobs, print_name, extra_args=[]):
+    num_cpus = cpu_count()
+    if num_jobs:
+        threads = int(num_jobs)
+    else:
+        threads = num_cpus
 
-def spatch(cocci_file, outdir,
-           max_threads, thread_id, temp_dir, ret_q, extra_args=[]):
     cmd = ['spatch',
             '--sp-file', cocci_file,
             '--in-place',
@@ -75,56 +37,20 @@ def spatch(cocci_file, outdir,
             '--timeout', '120',
             '--dir', outdir ]
 
-    if (max_threads > 1):
-        cmd.extend(['-max', str(max_threads), '-index', str(thread_id)])
+    if (threads > 1):
+        cmd.extend(['--jobs', str(threads)])
 
     cmd.extend(extra_args)
-
-    fn = os.path.join(temp_dir, '.tmp_spatch_worker.' + str(thread_id))
-    outfile = open(fn, 'w')
     logwrite("%s\n" % " ".join(cmd))
 
     sprocess = subprocess.Popen(cmd,
-                               stdout=outfile, stderr=subprocess.STDOUT,
-                               close_fds=True, universal_newlines=True)
+                                stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
+                                close_fds=True, universal_newlines=True)
+    output = sprocess.communicate()[0]
     sprocess.wait()
-    outfile.close()
-    ret_q.put((sprocess.returncode, fn))
-
-def threaded_spatch(cocci_file, outdir, logwrite, num_jobs,
-                    print_name, extra_args=[]):
-    num_cpus = cpu_count()
-    if num_jobs:
-        threads = int(num_jobs)
-    else:
-        threads = num_cpus
-    jobs = list()
-    output = ""
-    ret_q = Queue()
-    with tempdir() as t:
-        for num in range(threads):
-            p = Process(target=spatch, args=(cocci_file, outdir,
-                                             threads, num, t, ret_q,
-                                             extra_args))
-            jobs.append(p)
-        for p in jobs:
-            p.start()
-
-        for num in range(threads):
-            ret, fn = ret_q.get()
-            if ret != 0:
-                raise ExecutionErrorThread(ret, fn, cocci_file, threads, t,
-                                           logwrite, print_name)
-        for job in jobs:
-            p.join()
-
-        for num in range(threads):
-            fn = os.path.join(t, '.tmp_spatch_worker.' + str(num))
-            tf = open(fn, 'r')
-            output = output + tf.read()
-            tf.close()
-            os.unlink(fn)
-        return output
+    if sprocess.returncode != 0:
+        raise ExecutionError(sprocess.returncode, output, cocci_file, logwrite, print_name)
+    return output
 
 def logwrite(msg):
     sys.stdout.write(msg)
@@ -158,12 +84,9 @@ def _main():
     if args.jobs > 0:
         jobs = args.jobs
 
-    output = threaded_spatch(args.cocci_file,
-                             args.target_dir,
-                             logwrite,
-                             jobs,
-                             os.path.basename(args.cocci_file),
-                             extra_args=extra_spatch_args)
+    output = spatch(args.cocci_file, args.target_dir, logwrite, jobs,
+                    os.path.basename(args.cocci_file),
+                    extra_args=extra_spatch_args)
     if args.verbose:
         logwrite(output)
     return 0
-- 
2.3.2.209.gd67f9d5.dirty
