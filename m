From: mcgrof@do-not-panic.com (Luis R. Rodriguez)
Date: Fri,  5 Jun 2015 17:10:00 -0700
Subject: [Cocci] [PATCH 3/4] gentree.py: add SmPL patch equivalence proof
	support
In-Reply-To: <1433549401-17006-1-git-send-email-mcgrof@do-not-panic.com>
References: <1433549401-17006-1-git-send-email-mcgrof@do-not-panic.com>
Message-ID: <1433549401-17006-4-git-send-email-mcgrof@do-not-panic.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

If you have an SmPL patch that you think is ready to replace
a series of unified diff patches you can pass as an argument
to gentree.py '--prove-cocci' with the cocci file as the
an extra argument and gentree.py will try to prove equivalence
between the unified diff series and your Coccinelle SmPL patch.

You can use this as a guide when trying to replace an existing
unified diff series carried within backports with a respective
Coccinelle SmPL patch. You can use this to get a warm fuzzy or
to provide backports maintainers with a warm fuzzy of comfort
that your SmPL patch is sufficient.

In practice you might end up discovering as differences:

  a) minor space cosmetic differences between what the Coccinelle
     engine does and what we as humans typically would do
     Coccinelle has already received substantial modificaitons to
     address some of these minor spacing changes, but some might
     still exist.

  b) new code which previously was not modified, these are
     transformations which Coccinelle is providied to use,
     and hence further automating our backporting effort.
     If provide a backport of a collateral evolution in
     SmPL form it means we only have to write it once.

  c) bugs within Coccinelle

a) and b) the most common differences observed, whereas we
have yet to find c). If you find a) or c) please report the
differences on the Coccinelle development mailing list.

The algorithm used for SmPL patch equivalence proof is as follows,
using the command below:

mcgrof at cerro ~/backports (git::master)$ ./gentree.py --clean --prove-cocci \
	patches/collateral-evolutions/network/09-threaded-irq.cocci \
	/home/mcgrof/linux-next/ \
	/home/mcgrof/build/backports-20131206

When this is run gentree.py will first copy code we wish to backport
from linux-next into two separate directories:

  1) /home/mcgrof/build/backports-20131206
     We then only apply the Coccinelle SmPL patch 09-threaded-irq.cocci

  2) /home/mcgrof/build/backports-20131206.orig
     We then only apply the unified diff patches found within the directory:
     patches/collateral-evolutions/network/09-threaded-irq/

At this point we now have two treees with two different backporting
strategies. Internally when --prove-cocci is used gentree.py creates
within backports-20131206 a git to keep track of differences, this
includes application of the 09-threaded-irq.cocci patch. We take
advantage of the fact git is used then and replace all the files
within backports-20131206.orig into backports-20131206 and just
ask git for the differences.

In this particular case the diff stat shown reveals huge amount of
differences, in this case upon inspecting the changes it reveals
that using Coccinelle has enabled the generalized backport to
propagate into a lot of other device drivers, and hence doing
more automatic backport work for us. This is precicely why we
want to generalize backports in Coccinelle SmPL form when possible.

A diff stat with no output would mean that there is a perfect
equivalence.

The output of the command:

Copy original source files ...
Apply patches ...
Proving Coccinelle SmPL patch: 09-threaded-irq.cocci
Aggregating patch for Coccinelle SmPL 09-threaded-irq proof: drivers_net_wireless_b43_b43.patch
Aggregating patch for Coccinelle SmPL 09-threaded-irq proof: drivers_net_wireless_iwlwifi_pcie_internal.patch
Aggregating patch for Coccinelle SmPL 09-threaded-irq proof: drivers_net_wireless_ti_wlcore_main.patch
Aggregating patch for Coccinelle SmPL 09-threaded-irq proof: drivers_net_wireless_b43_main.patch
Aggregating patch for Coccinelle SmPL 09-threaded-irq proof: drivers_net_wireless_ti_wlcore_main_extra.patch
Aggregating patch for Coccinelle SmPL 09-threaded-irq proof: drivers_net_wireless_iwlwifi_pcie_trans.patch
Aggregating patch for Coccinelle SmPL 09-threaded-irq proof: drivers_net_wireless_ti_wlcore_wlcore.patch

Review the difference between what the tree looks like
by applying your SmPL patch, then reverting that and
only applying your the patches in the patch series.

Change directory to /home/mcgrof/build/backports-20131206 and run 'git diff'
diff stat of the changes:

 drivers/media/platform/via-camera.c           | 28 +-----------
 drivers/media/radio/radio-wl1273.c            | 28 +-----------
 drivers/media/radio/si470x/radio-si470x-i2c.c | 24 +----------
 drivers/media/radio/si470x/radio-si470x.h     |  3 --
 drivers/net/ieee802154/mrf24j40.c             | 20 ---------
 drivers/net/wireless/ath/wil6210/interrupt.c  | 62 +++------------------------
 drivers/net/wireless/ath/wil6210/wil6210.h    |  3 --
 drivers/net/wireless/b43/main.c               | 21 ++++-----
 drivers/net/wireless/cw1200/cw1200_sdio.c     | 21 ---------
 drivers/net/wireless/cw1200/cw1200_spi.c      | 27 +-----------
 drivers/net/wireless/iwlwifi/pcie/internal.h  |  3 ++
 drivers/net/wireless/iwlwifi/pcie/trans.c     | 34 ++++++---------
 drivers/net/wireless/ti/wlcore/main.c         | 26 +++++------
 drivers/nfc/microread/i2c.c                   | 27 +-----------
 drivers/nfc/pn544/i2c.c                       | 27 +-----------
 drivers/regulator/da9063-regulator.c          | 26 -----------
 drivers/regulator/lp8755.c                    | 23 +---------
 17 files changed, 52 insertions(+), 351 deletions(-)

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 gentree.py | 71 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 63 insertions(+), 8 deletions(-)

diff --git a/gentree.py b/gentree.py
index 636ea60..9e9293b 100755
--- a/gentree.py
+++ b/gentree.py
@@ -485,14 +485,30 @@ def apply_patches(args, desc, source_dir, patch_src, target_dir, logwrite=lambda
     a specific SmPL patch.
     """
     logwrite('Applying patches from %s to %s ...' % (patch_src, target_dir))
-    test_cocci = args.test_cocci or args.profile_cocci
+    test_cocci = args.test_cocci or args.profile_cocci or args.prove_cocci
+    # We don't skip all patches for SmPL proof, we need to use its old series
+    skip_patches = args.profile_cocci or args.test_cocci
     test_cocci_found = False
+    prove_cocci_tmp_dir = ''
+    if args.prove_cocci:
+        test_cocci = test_cocci.split('/')[-1]
+        prove_cocci_tmp_dir = target_dir + '.orig'
+        shutil.rmtree(prove_cocci_tmp_dir, ignore_errors=True)
+        copytree(target_dir, prove_cocci_tmp_dir)
     patches = []
     sempatches = []
     for root, dirs, files in os.walk(os.path.join(source_dir, patch_src)):
         for f in files:
-            if not test_cocci and f.endswith('.patch'):
-                patches.append(os.path.join(root, f))
+            if not skip_patches and f.endswith('.patch'):
+                if args.prove_cocci:
+                    # As an example if you use --prove-cocci patches/collateral-evolutions/network/09-threaded-irq.cocci
+                    # the patches under 09-threaded-irq will be used for the proof.
+                    proof_to_test_dir = test_cocci.split('/')[-1].split('.cocci')[0]
+                    if proof_to_test_dir in os.path.join(root, f):
+                        logwrite("Aggregating patch for Coccinelle SmPL %s proof: %s" % (proof_to_test_dir, f))
+                        patches.append(os.path.join(root, f))
+                else:
+                    patches.append(os.path.join(root, f))
             if f.endswith('.cocci'):
                 if test_cocci:
                     if f not in test_cocci:
@@ -502,6 +518,8 @@ def apply_patches(args, desc, source_dir, patch_src, target_dir, logwrite=lambda
                         logwrite("Testing Coccinelle SmPL patch: %s" % test_cocci)
                     elif args.profile_cocci:
                         logwrite("Profiling Coccinelle SmPL patch: %s" % test_cocci)
+                    elif args.prove_cocci:
+                        logwrite("Proving Coccinelle SmPL patch: %s" % test_cocci)
                 sempatches.append(os.path.join(root, f))
     patches.sort()
     prefix_len = len(os.path.join(source_dir, patch_src)) + 1
@@ -533,10 +551,13 @@ def apply_patches(args, desc, source_dir, patch_src, target_dir, logwrite=lambda
                 fullfn = os.path.join(target_dir, patched_file)
                 shutil.copyfile(fullfn, fullfn + '.orig_file')
 
+        patch_target_dir = target_dir
+        if args.prove_cocci:
+            patch_target_dir = prove_cocci_tmp_dir
         process = subprocess.Popen(['patch', '-p1'], stdout=subprocess.PIPE,
                                    stderr=subprocess.STDOUT, stdin=subprocess.PIPE,
                                    close_fds=True, universal_newlines=True,
-                                   cwd=target_dir)
+                                   cwd=patch_target_dir)
         output = process.communicate(input=open(pfile, 'r').read())[0]
         output = output.split('\n')
         if output[-1] == '':
@@ -578,7 +599,13 @@ def apply_patches(args, desc, source_dir, patch_src, target_dir, logwrite=lambda
             for f in files:
                 if f[-5:] == '.orig' or f[-4:] == '.rej':
                     os.unlink(os.path.join(root, f))
-        git_debug_snapshot(args, "apply %s patch %s" % (desc, print_name))
+        if patch_target_dir != target_dir:
+            for root, dirs, files in os.walk(patch_target_dir):
+                for f in files:
+                    if f[-5:] == '.orig' or f[-4:] == '.rej':
+                        os.unlink(os.path.join(root, f))
+        if not args.prove_cocci:
+            git_debug_snapshot(args, "apply %s patch %s" % (desc, print_name))
 
     sempatches.sort()
     prefix_len = len(os.path.join(source_dir, patch_src)) + 1
@@ -615,8 +642,27 @@ def apply_patches(args, desc, source_dir, patch_src, target_dir, logwrite=lambda
             for f in files:
                 if f.endswith('.cocci_backup'):
                     os.unlink(os.path.join(root, f))
+        if patch_target_dir != target_dir:
+            for root, dirs, files in os.walk(patch_target_dir):
+                for f in files:
+                    if f.endswith('.cocci_backup'):
+                        os.unlink(os.path.join(root, f))
         git_debug_snapshot(args, "apply %s SmPL patch %s" % (desc, print_name))
 
+    if args.prove_cocci:
+        copytree(prove_cocci_tmp_dir, target_dir, ignore=shutil.ignore_patterns('.git'))
+        shutil.rmtree(prove_cocci_tmp_dir, ignore_errors=True)
+        diff_stat = git.diff(tree=target_dir, extra_args=['--stat'])
+        if len(diff_stat) == 0:
+            logwrite('\nSmPL patch fully replaces patch series')
+        else:
+            logwrite('\nReview the difference between what the tree looks like ')
+            logwrite('by applying your SmPL patch, then reverting that and ')
+            logwrite('only applying your the patches in the patch series.')
+            logwrite('')
+            logwrite('Change directory to %s and run \'git diff\'' % target_dir)
+            logwrite('diff stat of the changes:\n')
+        logwrite(diff_stat)
     if test_cocci and test_cocci_found:
         logwrite('Done!')
         sys.exit(0)
@@ -675,6 +721,11 @@ def _main():
                         help='Only use the cocci file passed and pass --profile  to Coccinelle, ' +
                              'also creates a git repo on the target directory for easy inspection ' +
                              'of changes done by Coccinelle.')
+    parser.add_argument('--prove-cocci', metavar='<sp_file>', type=str, default=None,
+                        help='Only use the cocci file passed for Coccinelle and prove that it provides ' +
+                             'sufficient replacement for the patches under similar path name. Running ' +
+                             'git diff on the target directory suffices to show you what extra things' +
+                             'your SmPL patch did or what it didn\'t cover.')
     args = parser.parse_args()
 
     # When building a package we use CPTCFG as we can rely on the
@@ -721,6 +772,7 @@ def _main():
                    kup_test=args.kup_test,
                    test_cocci=args.test_cocci,
                    profile_cocci=args.profile_cocci,
+                   prove_cocci=args.prove_cocci,
                    logwrite=logwrite)
 
 def process(kerneldir, copy_list_file, git_revision=None,
@@ -730,6 +782,7 @@ def process(kerneldir, copy_list_file, git_revision=None,
             kup_test=False,
             test_cocci=None,
             profile_cocci=None,
+            prove_cocci=None,
             logwrite=lambda x:None,
             git_tracked_version=False):
     class Args(object):
@@ -738,7 +791,8 @@ def process(kerneldir, copy_list_file, git_revision=None,
                      gitdebug, verbose, extra_driver, kup,
                      kup_test,
                      test_cocci,
-                     profile_cocci):
+                     profile_cocci,
+                     prove_cocci):
             self.kerneldir = kerneldir
             self.copy_list = copy_list_file
             self.git_revision = git_revision
@@ -753,7 +807,8 @@ def process(kerneldir, copy_list_file, git_revision=None,
             self.kup_test = kup_test
             self.test_cocci = test_cocci
             self.profile_cocci = profile_cocci
-            if self.test_cocci or self.profile_cocci:
+            self.prove_cocci = prove_cocci
+            if self.test_cocci or self.profile_cocci or self.prove_cocci:
                 self.gitdebug = True
     def git_paranoia(tree=None, logwrite=lambda x:None):
         data = git.paranoia(tree)
@@ -767,7 +822,7 @@ def process(kerneldir, copy_list_file, git_revision=None,
     args = Args(kerneldir, copy_list_file,
                 git_revision, bpid, clean, refresh, base_name,
                 gitdebug, verbose, extra_driver, kup, kup_test,
-                test_cocci, profile_cocci)
+                test_cocci, profile_cocci, prove_cocci)
     rel_prep = None
 
     if bpid.integrate:
-- 
2.3.2.209.gd67f9d5.dirty
