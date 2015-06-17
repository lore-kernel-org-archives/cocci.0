From: mcgrof@do-not-panic.com (Luis R. Rodriguez)
Date: Wed, 17 Jun 2015 15:09:48 -0700
Subject: [Cocci] [PATCH] gentree.py: use Coccinelle's new Parallelism support
Message-ID: <1434578988-18411-1-git-send-email-mcgrof@do-not-panic.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

As of coccinelle-1.0.0-rc24 Coccinelle got its own built-in
parallelism support which does not require use of the separate
instances to be spawned. Coccinelle's new built-in parallelism
uses the parmap library for this.

Replace the pycocci script, which is no longer needed. I've
tested this with the 1.0.0 and 1.0.0-rc24 release and get
the same results for both releases.

When comparing our old way of doing things (using pycocci)
vs using the new parallellism support (-j option for spatch)
I see a general performance boost of at least ~10 seconds
right on average now when generating code using gentree.py
on the backports build server.

Cc: Xavier Clerc <xavier.clerc@inria.fr>
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 devel/pycocci | 174 ----------------------------------------------------------
 gentree.py    |  23 +++++---
 2 files changed, 16 insertions(+), 181 deletions(-)
 delete mode 100755 devel/pycocci

diff --git a/devel/pycocci b/devel/pycocci
deleted file mode 100755
index 4aa1d36..0000000
--- a/devel/pycocci
+++ /dev/null
@@ -1,174 +0,0 @@
-#!/usr/bin/env python
-#
-# Copyright (c) 2014 Luis R. Rodriguez  <mcgrof@suse.com>
-# Copyright (c) 2013 Johannes Berg <johannes@sipsolutions.net>
-#
-# This file is released under the GPLv2.
-#
-# Python wrapper for Coccinelle for multithreaded support,
-# designed to be used for working on a git tree, and with sensible
-# defaults, specifically for kernel developers.
-
-from multiprocessing import Process, cpu_count, Queue
-import argparse, subprocess, os, sys
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
-
-class CoccinelleError(Exception):
-    pass
-
-class ExecutionErrorThread(CoccinelleError):
-    def __init__(self, errcode, fn, cocci_file, threads, t, logwrite, print_name):
-        self.error_code = errcode
-        logwrite("Failed to apply changes from %s\n" % print_name)
-
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
-
-def spatch(cocci_file, outdir,
-           max_threads, thread_id, temp_dir, ret_q, extra_args=[]):
-    cmd = ['spatch',
-            '--sp-file', cocci_file,
-            '--in-place',
-            '--recursive-includes',
-            '--relax-include-path',
-            '--use-coccigrep',
-            '--timeout', '120',
-            '--dir', outdir ]
-
-    if (max_threads > 1):
-        cmd.extend(['-max', str(max_threads), '-index', str(thread_id)])
-
-    cmd.extend(extra_args)
-
-    fn = os.path.join(temp_dir, '.tmp_spatch_worker.' + str(thread_id))
-    outfile = open(fn, 'w')
-    logwrite("%s\n" % " ".join(cmd))
-
-    sprocess = subprocess.Popen(cmd,
-                               stdout=outfile, stderr=subprocess.STDOUT,
-                               close_fds=True, universal_newlines=True)
-    sprocess.wait()
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
-
-def logwrite(msg):
-    sys.stdout.write(msg)
-    sys.stdout.flush()
-
-def _main():
-    parser = argparse.ArgumentParser(description='Multithreaded Python wrapper for Coccinelle ' +
-                                     'with sensible defaults, targetted specifically ' +
-                                     'for git development environments')
-    parser.add_argument('cocci_file', metavar='<Coccinelle SmPL rules file>', type=str,
-                        help='This is the Coccinelle file you want to use')
-    parser.add_argument('target_dir', metavar='<target directory>', type=str,
-                        help='Target source directory to modify')
-    parser.add_argument('-p', '--profile-cocci', const=True, default=False, action="store_const",
-                        help='Enable profile, this will pass --profile  to Coccinelle.')
-    parser.add_argument('-j', '--jobs', metavar='<jobs>', type=str, default=None,
-                        help='Only use the cocci file passed for Coccinelle, don\'t do anything else, ' +
-                        'also creates a git repo on the target directory for easy inspection ' +
-                        'of changes done by Coccinelle.')
-    parser.add_argument('-v', '--verbose', const=True, default=False, action="store_const",
-                        help='Enable output from Coccinelle')
-    args = parser.parse_args()
-
-    if not os.path.isfile(args.cocci_file):
-        return -2
-
-    extra_spatch_args = []
-    if args.profile_cocci:
-        extra_spatch_args.append('--profile')
-    jobs = 0
-    if args.jobs > 0:
-        jobs = args.jobs
-
-    output = threaded_spatch(args.cocci_file,
-                             args.target_dir,
-                             logwrite,
-                             jobs,
-                             os.path.basename(args.cocci_file),
-                             extra_args=extra_spatch_args)
-    if args.verbose:
-        logwrite(output)
-    return 0
-
-if __name__ == '__main__':
-    ret = _main()
-    if ret:
-        sys.exit(ret)
diff --git a/gentree.py b/gentree.py
index 636ea60..c2766bb 100755
--- a/gentree.py
+++ b/gentree.py
@@ -5,6 +5,7 @@
 
 import argparse, sys, os, errno, shutil, re, subprocess
 import tarfile, gzip
+from multiprocessing import cpu_count
 
 # find self
 source_dir = os.path.abspath(os.path.dirname(__file__))
@@ -582,18 +583,26 @@ def apply_patches(args, desc, source_dir, patch_src, target_dir, logwrite=lambda
 
     sempatches.sort()
     prefix_len = len(os.path.join(source_dir, patch_src)) + 1
+    num_cpus = cpu_count()
 
     for cocci_file in sempatches:
-        # Until Coccinelle picks this up
-        pycocci = os.path.join(source_dir, 'devel/pycocci')
-        cmd = [pycocci, cocci_file]
-        extra_spatch_args = []
-        if args.profile_cocci:
-            cmd.append('--profile-cocci')
-        cmd.append(os.path.abspath(target_dir))
         print_name = cocci_file[prefix_len:]
         if args.verbose:
             logwrite("Applying SmPL patch %s" % print_name)
+
+        cmd = ['spatch',
+                '--sp-file', cocci_file,
+                '--in-place',
+                '--recursive-includes',
+                '--relax-include-path',
+                '--use-coccigrep',
+                '--timeout', '120',
+                '--jobs', str(num_cpus) ]
+
+        if args.profile_cocci:
+            cmd.append('--profile-cocci')
+
+        cmd.extend(['--dir', os.path.abspath(target_dir)])
         sprocess = subprocess.Popen(cmd,
                                     stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
                                     close_fds=True, universal_newlines=True,
-- 
2.3.2.209.gd67f9d5.dirty
