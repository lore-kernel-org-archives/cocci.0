From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Thu,  5 May 2016 13:03:43 -0700
Subject: [Cocci] [PATCH 4/5] pycocci: add clean version of SmPL <=> Patch
	equivalence proof support
In-Reply-To: <1462478624-25117-1-git-send-email-mcgrof@kernel.org>
References: <1462478624-25117-1-git-send-email-mcgrof@kernel.org>
Message-ID: <1462478624-25117-5-git-send-email-mcgrof@kernel.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

When working with automated tests against proofs you expect mosts
tests to pass. Currently SmPL <=> Patch equivalence proof support
is too chatty for automated tests, and it also leaves in place the
two git branches it uses to test for proof. Add a new option for
pycocci which will be silent unless errors occur, and will also
remove the temporary git branches used for the proof unless an
error is found.

Extend documentation for this. Note that these tests use git
branches on your tree, pycocc-* branches are only left in your
tree if an error has occured. Even if successful, even if branches
are deleted there will be a period of time during which you will
still see these branches on your git reflog, by default this is
about 30 days. If you want to expedite clearing your reflog you
can use this after testing:

	git reflog expire --all --expire=now

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 docs/pycocci.1 | 21 +++++++++++++++++-
 tools/pycocci  | 68 ++++++++++++++++++++++++++++++++++++++++------------------
 2 files changed, 67 insertions(+), 22 deletions(-)

diff --git a/docs/pycocci.1 b/docs/pycocci.1
index e7f6b072589c..2410022d641d 100644
--- a/docs/pycocci.1
+++ b/docs/pycocci.1
@@ -204,8 +204,27 @@ git branch created to avoid conflicts with previous runs.
 You must run this option with a clean git tree, if you have any pending changes
 you must commit them or discard them.
 
+.B\-c | \-\-clean\-proof
+This does what -\-show\-proof does but this is completely silent unless an
+error occurs. It will also remove the git branches used to test for the
+equivalence proof, unless an error is found. If an error is found you can
+inspect the two branches used to test for proof, refer to the documentation
+on \-\-show\-proof for details about these branches. This option is useful
+if you want to automate tests with proofs.
+
+Note that using this method will have created and subsequently if successful
+deleted two git branches on your git tree. As a consequence of using git
+branches your git reflog will show these branches, if you push your tree
+out these branches will not be pushed as they were deleted, your reflog
+however will keep these references locally until git expires them, by default
+this is 30 days. If this is too chatty for you, you can run:
+
+	git reflog expire \-\-all \-\-expire=now
+
+This will immediately clear old entries from your reflog.
+
 .SH AUTHOR
-\fBpycocci\fP and this man page was written by Luis R. Rodriguez <mcgrof@do-not-panic.com>
+\fBpycocci\fP and this man page was written by Luis R. Rodriguez <mcgrof@kernel.org>
 
 .SH REPORTING BUGS
 Send an mail to <cocci@systeme.lip6.fr>
diff --git a/tools/pycocci b/tools/pycocci
index 4bcfb46af24b..a667672ac2c5 100755
--- a/tools/pycocci
+++ b/tools/pycocci
@@ -346,7 +346,8 @@ def apply_patches(args, patch_src, target_dir, logwrite=lambda x:None):
     for pfile in patches:
         print_name = pfile[prefix_len:]
 
-        logwrite("Applying patch %s\n" % pfile)
+        if args.show_proof or args.verbose:
+            logwrite("Applying patch %s\n" % pfile)
 
         process = subprocess.Popen(['patch', '-p1'], stdout=subprocess.PIPE,
                                    stderr=subprocess.STDOUT, stdin=subprocess.PIPE,
@@ -401,7 +402,8 @@ class ExecutionErrorCocci(CoccinelleError):
         logwrite("Failed to apply changes from %s\n" % print_name)
         logwrite(output)
 
-def spatch(cocci_file, outdir, logwrite, num_jobs, print_name, extra_args=[]):
+def spatch(cocci_file, outdir, logwrite, num_jobs, print_name, extra_args=[],
+           verbose=False):
 
     req = Req(chatty=True)
     req.coccinelle('1.0.2')
@@ -428,7 +430,8 @@ def spatch(cocci_file, outdir, logwrite, num_jobs, print_name, extra_args=[]):
 
     cmd.extend(extra_args)
 
-    logwrite("%s\n" % " ".join(cmd))
+    if verbose:
+        logwrite("%s\n" % " ".join(cmd))
 
     sprocess = subprocess.Popen(cmd,
                                 stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
@@ -440,7 +443,8 @@ def spatch(cocci_file, outdir, logwrite, num_jobs, print_name, extra_args=[]):
     return output
 
 def spatch_old(cocci_file, outdir,
-               max_threads, thread_id, temp_dir, ret_q, extra_args=[]):
+               max_threads, thread_id, temp_dir, ret_q, extra_args=[],
+               verbose=False):
     cmd = ['spatch',
             '--sp-file', cocci_file,
             '--in-place',
@@ -456,7 +460,8 @@ def spatch_old(cocci_file, outdir,
 
     fn = os.path.join(temp_dir, '.tmp_spatch_worker.' + str(thread_id))
     outfile = open(fn, 'w')
-    logwrite("%s\n" % " ".join(cmd))
+    if verbose:
+        logwrite("%s\n" % " ".join(cmd))
 
     sprocess = subprocess.Popen(cmd,
                                stdout=outfile, stderr=subprocess.STDOUT,
@@ -466,7 +471,7 @@ def spatch_old(cocci_file, outdir,
     ret_q.put((sprocess.returncode, fn))
 
 def threaded_spatch(cocci_file, outdir, logwrite, num_jobs,
-                    print_name, extra_args=[]):
+                    print_name, extra_args=[], verbose=True):
     num_cpus = cpu_count()
     if num_jobs:
         threads = int(num_jobs)
@@ -515,6 +520,11 @@ def _main():
                         help='Enable profile, this will pass --profile  to Coccinelle.')
     parser.add_argument('-s', '--show-proof', const=True, default=False, action="store_const",
                         help='Show proof that the provided SmPL patch can replace a respective patch series')
+    parser.add_argument('-c', '--clean-proof', const=True, default=False, action="store_const",
+                        help='Show proof that the provided SmPL patch can replace a respective patch series, and' +
+                        'if the proof shows equivalence, delete any temporary branches used to test the proof.' +
+                        'If any errors were encountered the branches used to test the proof will be kept to ' +
+                        'enable debugging')
     parser.add_argument('-j', '--jobs', metavar='<jobs>', type=str, default=None,
                         help='Only use the cocci file passed for Coccinelle, don\'t do anything else, ' +
                         'also creates a git repo on the target directory for easy inspection ' +
@@ -553,9 +563,9 @@ def _main():
     git_dir = None
 
     if git_reqs.reqs_match():
-        git_dir = gitname(args.target_dir)
+        git_dir = gitname(path=args.target_dir)
 
-    if args.show_proof:
+    if args.show_proof or args.clean_proof:
         # As an example if you use --show-proof patches/collateral-evolutions/network/09-threaded-irq.cocci
         # the patches under 09-threaded-irq will be used for the proof.
         patch_src = args.cocci_file.split('/')[-1].split('.cocci')[0]
@@ -586,11 +596,12 @@ def _main():
                 return -2
         cmd = [ '--abbrev-ref', 'HEAD' ]
         current_branch = git_rev_parse(tree=args.target_dir, extra_args = cmd)
-        logwrite("\n")
-        logwrite("Current branch: %s\n" % (current_branch))
-        logwrite("Patch   branch: %s\n" % (patch_branch_name))
-        logwrite("SmPL    branch: %s\n" % (smpl_branch_name))
-        logwrite("\n")
+        if args.show_proof or args.verbose:
+            logwrite("\n")
+            logwrite("Current branch: %s\n" % (current_branch))
+            logwrite("Patch   branch: %s\n" % (patch_branch_name))
+            logwrite("SmPL    branch: %s\n" % (smpl_branch_name))
+            logwrite("\n")
         git_checkout(tree=args.target_dir, extra_args = ['-b', smpl_branch_name])
         git_checkout(tree=args.target_dir, extra_args = ['-b', patch_branch_name])
 
@@ -608,31 +619,46 @@ def _main():
     else:
         extra_spatch_args.append('--use-coccigrep')
 
+    show_spatch_cmd = True
+    if args.clean_proof and not args.verbose:
+        show_spatch_cmd = False
     if has_spatch_1_0_2.reqs_match():
         output = spatch(args.cocci_file, args.target_dir, logwrite, jobs,
                         os.path.basename(args.cocci_file),
-                        extra_args=extra_spatch_args)
+                        extra_args=extra_spatch_args, verbose=show_spatch_cmd)
     else:
         output = threaded_spatch(args.cocci_file,
                                  args.target_dir,
                                  logwrite,
                                  jobs,
                                  os.path.basename(args.cocci_file),
-                                 extra_args=extra_spatch_args)
+                                 extra_args=extra_spatch_args,
+                                 verbose=show_spatch_cmd)
     if args.verbose:
         logwrite(output)
-    if args.show_proof:
+    if args.show_proof or args.clean_proof:
         git_commit_all(tree=args.target_dir, message="Initial commit")
         git_checkout(tree=args.target_dir, extra_args = [current_branch])
         cmd = [ '--stat', patch_branch_name + ".." + smpl_branch_name ]
         diff_stat = git_diff(tree=args.target_dir, extra_args = cmd)
         if len(diff_stat) == 0:
-            logwrite('\nSmPL patch fully replaces patch series!\n')
+            if args.show_proof or args.verbose:
+                logwrite('\nSmPL patch fully replaces patch series!\n')
+            else:
+                logwrite('%s\t:OK\n' % args.cocci_file)
+            if args.clean_proof:
+                if args.verbose:
+                    logwrite('\nRequested clean proof, so deleting work branches\n')
+                git_branch(tree=args.target_dir, extra_args = ['-D', patch_branch_name])
+                git_branch(tree=args.target_dir, extra_args = ['-D', smpl_branch_name])
         else:
-            logwrite('\nDifferences found:\n\n')
-            logwrite('Change directory to %s and run:\n\n\tgit diff %s..%s\n\n' % (args.target_dir, patch_branch_name, smpl_branch_name))
-            logwrite('diffstat of the changes:\n')
-            logwrite(diff_stat)
+            if args.show_proof or args.verbose:
+                logwrite('\nDifferences found:\n\n')
+                logwrite('Change directory to %s and run:\n\n\tgit diff %s..%s\n\n' % (args.target_dir, patch_branch_name, smpl_branch_name))
+                logwrite('diffstat of the changes:\n')
+                logwrite(diff_stat)
+            else:
+                logwrite('%s\t:FAIL\n' % args.cocci_file)
     return 0
 
 if __name__ == '__main__':
-- 
2.7.2
