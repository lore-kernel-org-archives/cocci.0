From: mcgrof@do-not-panic.com (Luis R. Rodriguez)
Date: Mon, 20 Jul 2015 15:30:46 -0700
Subject: [Cocci] [PATCH v2 2/2] ckmake: address directory max depth
In-Reply-To: <1437431446-32619-1-git-send-email-mcgrof@do-not-panic.com>
References: <1437431446-32619-1-git-send-email-mcgrof@do-not-panic.com>
Message-ID: <1437431446-32619-3-git-send-email-mcgrof@do-not-panic.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

It seems new versions of python make the os walk recurse more
than we used to before, our ckmake implementation was picking up
more kernels targets than obviously we want to build then. Fix
this by replacing the os.walk() with a simple os.listdir()
which just keeps us at the top level directory of lib/modules.

While at it, this adds the --develdebug option which lets you
debug the the directory naming it will use for display and what
directories it will traverse without actually compiling anything
and without using ncurses. For instance to debug or ckmake without
compilation you can use:

$ ckmake --allyesconfig --develdebug
Paths for kernels:
3.4.103-0304103-generic
3.9.11-030911-generic
3.2.62-030262-generic
3.16.2-031602-generic
3.11.10-031110-generic
3.8.13-030813-generic
3.5.7-03050712-generic
3.0.101-0300101-generic
3.15.10-031510-generic
3.6.11-030611-generic
3.13.11-031311-generic
3.1.10-030110-generic
3.10.54-031054-generic
3.3.8-030308-generic
3.7.10-030710-generic
3.14.18-031418-generic
3.17.0-031700rc3-generic
3.12.27-031227-generic
IDX VERSION	DIRECTORY
1   3.0.101	/home/mcgrof/ksrc-backports/lib/modules/3.0.101-0300101-generic
2   3.1.10	/home/mcgrof/ksrc-backports/lib/modules/3.1.10-030110-generic
3   3.2.62	/home/mcgrof/ksrc-backports/lib/modules/3.2.62-030262-generic
4   3.3.8	/home/mcgrof/ksrc-backports/lib/modules/3.3.8-030308-generic
5   3.4.103	/home/mcgrof/ksrc-backports/lib/modules/3.4.103-0304103-generic
6   3.5.7	/home/mcgrof/ksrc-backports/lib/modules/3.5.7-03050712-generic
7   3.6.11	/home/mcgrof/ksrc-backports/lib/modules/3.6.11-030611-generic
8   3.7.10	/home/mcgrof/ksrc-backports/lib/modules/3.7.10-030710-generic
9   3.8.13	/home/mcgrof/ksrc-backports/lib/modules/3.8.13-030813-generic
10  3.9.11	/home/mcgrof/ksrc-backports/lib/modules/3.9.11-030911-generic
11  3.10.54	/home/mcgrof/ksrc-backports/lib/modules/3.10.54-031054-generic
12  3.11.10	/home/mcgrof/ksrc-backports/lib/modules/3.11.10-031110-generic
13  3.12.27	/home/mcgrof/ksrc-backports/lib/modules/3.12.27-031227-generic
14  3.13.11	/home/mcgrof/ksrc-backports/lib/modules/3.13.11-031311-generic
15  3.14.18	/home/mcgrof/ksrc-backports/lib/modules/3.14.18-031418-generic
16  3.15.10	/home/mcgrof/ksrc-backports/lib/modules/3.15.10-031510-generic
17  3.16.2	/home/mcgrof/ksrc-backports/lib/modules/3.16.2-031602-generic
18  3.17-rc3 	/home/mcgrof/ksrc-backports/lib/modules/3.17.0-031700rc3-generic

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 devel/ckmake | 132 +++++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 84 insertions(+), 48 deletions(-)

diff --git a/devel/ckmake b/devel/ckmake
index 0c238a65de8d..4391c315155f 100755
--- a/devel/ckmake
+++ b/devel/ckmake
@@ -455,52 +455,58 @@ class kernel_set():
                 return
         self.releases.insert(new_rel['idx'], new_rel)
 
-    def parse_releases(self, target_kranges):
+    def parse_releases(self, target_kranges, args):
         self.target_kranges = target_kranges
-        for dirname, dirnames, filenames in os.walk(modules):
-            rels = []
-            for subdirname in dirnames:
-                specifics = get_rel_spec_ubuntu(subdirname)
-                if (not specifics):
-                    continue
-                base_specs = get_base_spec(specifics)
-                if (not base_specs):
-                    continue
-                rc = False
-
-                ver = specifics['VERSION'] + '.' + \
-                    specifics['PATCHLEVEL']
-
-                if ("rc" in subdirname):
-                    rc = True
-                    ver = ver + '-rc' + specifics['EXTRAVERSION']
-                else:
-                    ver = ver + '.' + specifics['SUBLEVEL']
-
-                get_rel_spec_base(subdirname)
-                rel = dict(name=subdirname,
-                           full_path=dirname + '/' +
-                           subdirname,
-                           version=ver,
-                           is_rc=rc,
-                           ver=specifics['VERSION'],
-                           pat=specifics['PATCHLEVEL'],
-                           sub=specifics['SUBLEVEL'],
-                           ext=specifics['EXTRAVERSION'],
-                           base_weight=compute_rel_weight_base(base_specs),
-                           weight=compute_rel_weight(specifics),
-                           processed=False,
-                           log='',
-                           status=1234)
-                rels.append(rel)
-
-            def relsort(rel):
-                return int(rel['ver']), int(rel['pat']), int(rel['sub'])
-            rels.sort(key=relsort)
-            for rel in rels:
-                rel['idx'] = len(self.releases)
-                self.evaluate_new_rel(rel)
-        self.refresh()
+        rels = []
+        if args.develdebug:
+            sys.stdout.write("Paths for kernels:\n")
+        for path in os.listdir(os.path.abspath(modules)):
+            full_dir = os.path.abspath(os.path.join(modules, path))
+            if not os.path.isdir(full_dir):
+                continue
+            if args.develdebug:
+                sys.stdout.write("%s\n" % (path))
+            specifics = get_rel_spec_ubuntu(path)
+            if (not specifics):
+                continue
+            base_specs = get_base_spec(specifics)
+            if (not base_specs):
+                continue
+            rc = False
+
+            ver = specifics['VERSION'] + '.' + \
+                specifics['PATCHLEVEL']
+
+            if ("rc" in path):
+                rc = True
+                ver = ver + '-rc' + specifics['EXTRAVERSION']
+            else:
+                ver = ver + '.' + specifics['SUBLEVEL']
+
+            get_rel_spec_base(path)
+            rel = dict(name=path,
+                       full_path = full_dir,
+                       version=ver,
+                       is_rc=rc,
+                       ver=specifics['VERSION'],
+                       pat=specifics['PATCHLEVEL'],
+                       sub=specifics['SUBLEVEL'],
+                       ext=specifics['EXTRAVERSION'],
+                       base_weight=compute_rel_weight_base(base_specs),
+                       weight=compute_rel_weight(specifics),
+                       processed=False,
+                       log='',
+                       status=1234)
+            rels.append(rel)
+
+        def relsort(rel):
+            return int(rel['ver']), int(rel['pat']), int(rel['sub'])
+        rels.sort(key=relsort)
+        for rel in rels:
+            rel['idx'] = len(self.releases)
+            self.evaluate_new_rel(rel)
+        if not args.develdebug:
+            self.refresh()
 
     def setup_screen(self):
         for i in range(0, len(self.releases)):
@@ -519,6 +525,16 @@ class kernel_set():
             self.stdscr.refresh()
             self.lock.release()
 
+    def setup_screen_debug(self):
+        sys.stdout.write("%-4s" % ("IDX"))
+        sys.stdout.write("%-20s" % ("VERSION"))
+        sys.stdout.write("%-60s\n" % ("DIRECTORY"))
+        for i in range(0, len(self.releases)):
+            rel = self.releases[i]
+            sys.stdout.write("%-4d" % (rel['idx'] + 1))
+            sys.stdout.write("%-20s" % (rel['version']))
+            sys.stdout.write("%-60s\n" % (rel['full_path']))
+
     def create_threads(self, cmdline_args):
         for rel in self.releases:
             th = Thread(target=process_kernel, args=(0, self, cmdline_args))
@@ -552,9 +568,19 @@ class kernel_set():
 def main(stdscr, args, target_kranges):
     kset = kernel_set(stdscr)
 
-    kset.set_locale()
-    kset.parse_releases(target_kranges)
+    if args.develdebug:
+        kill_curses()
+    else:
+        kset.set_locale()
+
+    kset.parse_releases(target_kranges, args)
+
+    if args.develdebug:
+        kset.setup_screen_debug()
+        sys.exit(0)
+
     kset.setup_screen()
+
     kset.create_threads(args)
     kset.kick_threads()
     kset.wait_threads()
@@ -602,6 +628,9 @@ if __name__ == "__main__":
                         help='Build this defconfig rather than only backport code.')
     parser.add_argument('--revs', metavar='<revision-list>', type=str,
                         help='Optional list of kernel revisions to test for, example: 2.6.24,2.6.30,2.6.32..3.2,3.4')
+    parser.add_argument(
+        '--develdebug', const=True, default=False, action="store_const",
+        help='Development debug - use to debug which kernels we are going to process')
     args = parser.parse_args()
 
     target_kranges = []
@@ -624,8 +653,15 @@ if __name__ == "__main__":
         os.remove(ckmake_report)
     if os.path.exists(tmp_path):
         rmtree(tmp_path)
-    os.makedirs(tmp_path)
+
+    if not args.develdebug:
+        os.makedirs(tmp_path)
+
     curses.wrapper(main, args, target_kranges)
+
+    if args.develdebug:
+        sys.exit(ckmake_return)
+
     kill_curses()
     process_logs()
     clean()
-- 
2.3.2.209.gd67f9d5.dirty
