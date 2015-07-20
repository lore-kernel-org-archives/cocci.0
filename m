From: mcgrof@do-not-panic.com (Luis R. Rodriguez)
Date: Mon, 20 Jul 2015 15:32:23 -0700
Subject: [Cocci] [PATCH v3 4/5] pycocci: add Coccinelle SmPL patch proof
	support
In-Reply-To: <1437431544-32662-1-git-send-email-mcgrof@do-not-panic.com>
References: <1437431544-32662-1-git-send-email-mcgrof@do-not-panic.com>
Message-ID: <1437431544-32662-5-git-send-email-mcgrof@do-not-panic.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

From: "Luis R. Rodriguez" <mcgrof@suse.com>

At times you may need to replace a patch series with an
SmPL patch, but how can you grow certain that a patch series
replaces that patch series perfectly ? How do you visualize
such differences ?

This provides support for such proof mechanism. It assumes you
have a patch series and respective SmPL patch you wish to use to
replace the patch series. Say you have a foo.cocci SmPL patch,
you would also have a foo/ directory in which you have  series
of patches. The foo/ patches are the patches you wish to replace.

You can use then for instance:

  pycocci --show-proof foo.cocci /path/some-src-tree/

If you don't have git yet set up on /path/some-src-tree/ we'll create
a git repository for you there with the code there in place already as
the base of the repository. Otherwise if you already have git set up
we'll use that git tree to do work.

pycocci will create two git branches for proving the work. We leave
your original branch intact, whatever it was, and we'll return you
back to that same git branch.

As an example, you may end up with:

Current branch: master
Patch   branch: pycocci-patch-dd6b2fa4
SmPL    branch: pycocci-smpl-731f9863

A series of patches in the directory foo/ will be applied onto
the pycocci-patch-dd6b2fa4 branch, the foo.cocci SmPL patch
will be applied onto the pycocci-smpl-731f9863 branch.

You get a perfect patch equivalence when:

  git diff pycocci-patch-dd6b2fa4..pycocci-smpl-731f9863

yields no results. If there is any delta we give you the
diffstat through stdout, and tell you where to go and what
to do (above command) to inspect the changes in detail.

Below is a screenshot run:

mcgrof at ergon ~ $ /home/mcgrof/devel/coccinelle/tools/pycocci \
	--show-proof \
	/home/mcgrof/backports/patches/collateral-evolutions/media/0002-no_dmabuf.cocci \
	/home/mcgrof/build/backports-20150626-test

Current branch: master
Patch   branch: pycocci-patch-3a9fc1a5
SmPL    branch: pycocci-smpl-17d08bf3

Applying patch ...0002-no_dmabuf/v4l2.patch

spatch --sp-file ...0002-no_dmabuf.cocci --in-place --recursive-includes --relax-include-path --timeout 120 --dir ...backports-20150626-test -max 4 -index 0 --use-coccigrep
spatch --sp-file ...0002-no_dmabuf.cocci --in-place --recursive-includes --relax-include-path --timeout 120 --dir ...backports-20150626-test -max 4 -index 1 --use-coccigrep
spatch --sp-file ...0002-no_dmabuf.cocci --in-place --recursive-includes --relax-include-path --timeout 120 --dir ...backports-20150626-test -max 4 -index 2 --use-coccigrep
spatch --sp-file ...0002-no_dmabuf.cocci --in-place --recursive-includes --relax-include-path --timeout 120 --dir ...backports-20150626-test -max 4 -index 3 --use-coccigrep

Differences found:

Change directory to /home/mcgrof/build/backports-20150626-test and run:

        git diff pycocci-patch-3a9fc1a5..pycocci-smpl-17d08bf3

diffstat of the changes:
 drivers/media/pci/cobalt/cobalt-v4l2.c         |  2 ++
 drivers/media/platform/blackfin/bfin_capture.c |  2 ++
 drivers/media/platform/exynos-gsc/gsc-m2m.c    |  4 +++
 drivers/media/platform/s5p-mfc/s5p_mfc_dec.c   |  4 +++
 drivers/media/platform/s5p-mfc/s5p_mfc_enc.c   |  4 +++
 drivers/media/platform/s5p-tv/mixer_video.c    |  4 +++
 drivers/media/platform/soc_camera/soc_camera.c |  4 +++
 drivers/media/platform/sti/bdisp/bdisp-v4l2.c  |  2 ++
 drivers/media/usb/uvc/uvc_queue.c              |  2 --
 drivers/media/usb/uvc/uvc_v4l2.c               |  2 +-
 drivers/media/v4l2-core/Kconfig                |  6 ++--
 drivers/media/v4l2-core/v4l2-mem2mem.c         |  4 ---
 drivers/media/v4l2-core/videobuf2-core.c       | 20 ------------
 drivers/media/v4l2-core/videobuf2-dma-contig.c | 34 ++++++++++++++++++--
 drivers/media/v4l2-core/videobuf2-dma-sg.c     | 38 +++++++++++++++++++++--
 drivers/media/v4l2-core/videobuf2-vmalloc.c    | 43 +++++++++++++++++++++++---
 include/media/v4l2-mem2mem.h                   |  4 ---
 include/media/videobuf2-core.h                 |  8 -----
 18 files changed, 134 insertions(+), 53 deletions(-)

Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
---
 tools/pycocci | 94 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/tools/pycocci b/tools/pycocci
index 54486fd83442..e9243aa1b0db 100755
--- a/tools/pycocci
+++ b/tools/pycocci
@@ -12,6 +12,7 @@
 from multiprocessing import Process, cpu_count, Queue
 import argparse, subprocess, os, sys, re
 import tempfile, shutil
+import uuid
 
 class ReqError(Exception):
     pass
@@ -321,6 +322,44 @@ class tempdir(object):
         else:
             shutil.rmtree(self._name)
 
+def apply_patches(args, patch_src, target_dir, logwrite=lambda x:None):
+    """
+    Given a path of a directories of patches apply the patches
+    """
+    patches = []
+    for root, dirs, files in os.walk(patch_src):
+        for f in files:
+            if f.endswith('.patch'):
+                    patches.append(os.path.join(root, f))
+    patches.sort()
+    prefix_len = len(patch_src) + 1
+    for pfile in patches:
+        print_name = pfile[prefix_len:]
+
+        logwrite("Applying patch %s\n" % pfile)
+
+        process = subprocess.Popen(['patch', '-p1'], stdout=subprocess.PIPE,
+                                   stderr=subprocess.STDOUT, stdin=subprocess.PIPE,
+                                   close_fds=True, universal_newlines=True,
+                                   cwd=target_dir)
+        output = process.communicate(input=open(pfile, 'r').read())[0]
+        output = output.split('\n')
+        if output[-1] == '':
+            output = output[:-1]
+        if process.returncode != 0:
+            if not args.verbose:
+                logwrite("Failed to apply changes from %s" % print_name)
+                for line in output:
+                    logwrite('> %s' % line)
+            raise Exception('Patch failed')
+
+        # remove orig/rej files that patch sometimes creates
+        for root, dirs, files in os.walk(target_dir):
+            for f in files:
+                if f[-5:] == '.orig' or f[-4:] == '.rej':
+                    os.unlink(os.path.join(root, f))
+        git_commit_all(tree=target_dir, message="apply patch %s" % (print_name))
+
 class CoccinelleError(Exception):
     pass
 
@@ -465,6 +504,8 @@ def _main():
                         help='Target source directory to modify')
     parser.add_argument('-p', '--profile-cocci', const=True, default=False, action="store_const",
                         help='Enable profile, this will pass --profile  to Coccinelle.')
+    parser.add_argument('-s', '--show-proof', const=True, default=False, action="store_const",
+                        help='Show proof that the provided SmPL patch can replace a respective patch series')
     parser.add_argument('-j', '--jobs', metavar='<jobs>', type=str, default=None,
                         help='Only use the cocci file passed for Coccinelle, don\'t do anything else, ' +
                         'also creates a git repo on the target directory for easy inspection ' +
@@ -475,6 +516,13 @@ def _main():
 
     if not os.path.isfile(args.cocci_file):
         return -2
+    if not os.path.isfile(args.target_dir) and not os.path.isdir(args.target_dir):
+        logwrite("Path (%s) is not a file or directory\n" % (args.target_dir))
+        return -2
+
+    current_branch = None
+    smpl_branch_name = "pycocci-smpl-" + str(uuid.uuid4())[:8]
+    patch_branch_name = "pycocci-patch-" + str(uuid.uuid4())[:8]
 
     extra_spatch_args = []
     if args.profile_cocci:
@@ -498,6 +546,40 @@ def _main():
     if git_reqs.reqs_match():
         git_dir = gitname(args.target_dir)
 
+    if args.show_proof:
+        # As an example if you use --show-proof patches/collateral-evolutions/network/09-threaded-irq.cocci
+        # the patches under 09-threaded-irq will be used for the proof.
+        patch_src = args.cocci_file.split('/')[-1].split('.cocci')[0]
+        dirname = os.path.dirname(args.cocci_file)
+        patch_src = os.path.abspath(os.path.join(dirname, patch_src))
+        if not os.path.isdir(patch_src):
+            logwrite("Path given (%s) must be a directory with patches\n" % (patch_src))
+            return -2
+        git_reqs = Req(chatty=True)
+        git_reqs.require('git')
+        if not git_dir:
+            if os.path.isfile(args.target_dir):
+                logwrite("Path given (%s) is a file, try passing the directory "
+                         "(%s) if you are certain you want us to create a git repo to provide a"
+                         "a proof there\n" % (args.target_dir, os.path.dirname(args.target_dir)))
+                return -2
+            logwrite("Path (%s) not part of a git tree, creating one for you...\n" % (args.target_dir))
+            git_init(tree=args.target_dir)
+            git_commit_all(tree=args.target_dir, message="Initial commit")
+        cmd = [ '--abbrev-ref', 'HEAD' ]
+        current_branch = git_rev_parse(tree=args.target_dir, extra_args = cmd)
+        logwrite("\n")
+        logwrite("Current branch: %s\n" % (current_branch))
+        logwrite("Patch   branch: %s\n" % (patch_branch_name))
+        logwrite("SmPL    branch: %s\n" % (smpl_branch_name))
+        logwrite("\n")
+        git_checkout(tree=args.target_dir, extra_args = ['-b', smpl_branch_name])
+        git_checkout(tree=args.target_dir, extra_args = ['-b', patch_branch_name])
+
+        apply_patches(args, patch_src, args.target_dir, logwrite)
+
+        git_checkout(tree=args.target_dir, extra_args = [smpl_branch_name])
+
     if os.path.isfile(glimpse_index):
        extra_spatch_args.append('--use-glimpse')
     elif has_spatch_1_0_2.reqs_match():
@@ -521,6 +603,18 @@ def _main():
                                  extra_args=extra_spatch_args)
     if args.verbose:
         logwrite(output)
+    if args.show_proof:
+        git_commit_all(tree=args.target_dir, message="Initial commit")
+        git_checkout(tree=args.target_dir, extra_args = [current_branch])
+        cmd = [ '--stat', patch_branch_name + ".." + smpl_branch_name ]
+        diff_stat = git_diff(tree=args.target_dir, extra_args = cmd)
+        if len(diff_stat) == 0:
+            logwrite('\nSmPL patch fully replaces patch series!')
+        else:
+            logwrite('\nDifferences found:\n\n')
+            logwrite('Change directory to %s and run:\n\n\tgit diff %s..%s\n\n' % (args.target_dir, patch_branch_name, smpl_branch_name))
+            logwrite('diffstat of the changes:\n')
+            logwrite(diff_stat)
     return 0
 
 if __name__ == '__main__':
-- 
2.3.2.209.gd67f9d5.dirty
