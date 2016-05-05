From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Thu,  5 May 2016 13:03:44 -0700
Subject: [Cocci] [PATCH 5/5] pycocci: enable SmPL <=> Patch equivalence tests
In-Reply-To: <1462478624-25117-1-git-send-email-mcgrof@kernel.org>
References: <1462478624-25117-1-git-send-email-mcgrof@kernel.org>
Message-ID: <1462478624-25117-6-git-send-email-mcgrof@kernel.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Coccinelle has integrated tests support into it, these
tests are performed really fast, the current test framework
enables testing with respective single C file and a respective
cocci file, ie: foo.c, foo.cocci, foo.res. If one wants to add
extensive tests, to reflect more real-life sized projects the
current test scheme is a bit limited.

We can extend Coccinelle's existing test framework to support
multiple files, header files, but a different can also consist
of making use of SmPL <=> Patch equivalence support. Instead of
relying on .res files, this relies on patches that provide
a outline of differences using standard diff. This enables
extending test coverage to more complex cases. This is not
meant to replace Coccinelle's internal test functionality but
rather complement it.

For now, since I can't figure out how to only remove from
the reflog the temporary branch creation stuff without expiring
your entire relog immediately, just keep the pycocci-check
separate from the standard tests. If we're happy to have a
chatty reflog when testing we can later enable this by
default, but this just doesn't seem appropriate as a default
setting.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 Makefile                                               |  3 +++
 scripts/pycocci-check.sh                               |  8 ++++++++
 tests/pycocci/code/0001-proto3/proto3.c                |  7 +++++++
 tests/pycocci/code/0001-proto3/proto3.h                |  3 +++
 tests/pycocci/patches/0001-proto3.cocci                | 11 +++++++++++
 .../patches/0001-proto3/0001-change-prototypes.patch   | 18 ++++++++++++++++++
 6 files changed, 50 insertions(+)
 create mode 100755 scripts/pycocci-check.sh
 create mode 100644 tests/pycocci/code/0001-proto3/proto3.c
 create mode 100644 tests/pycocci/code/0001-proto3/proto3.h
 create mode 100644 tests/pycocci/patches/0001-proto3.cocci
 create mode 100644 tests/pycocci/patches/0001-proto3/0001-change-prototypes.patch

diff --git a/Makefile b/Makefile
index a98eefd2d83b..364e1cc68154 100644
--- a/Makefile
+++ b/Makefile
@@ -489,6 +489,9 @@ check: scripts/spatch
 	@$(ECHO) running the test suite
 	COCCINELLE_HOME="$$(pwd)" ./scripts/spatch --testall --no-update-score-file
 
+pycocci-check:
+	COCCINELLE_HOME="$$(pwd)" ./scripts/pycocci-check.sh
+
 # -inline 0  to see all the functions in the profile.
 # Can also use the profile framework in commons/ and run your program
 # with -profile.
diff --git a/scripts/pycocci-check.sh b/scripts/pycocci-check.sh
new file mode 100755
index 000000000000..ca81ca9cb156
--- /dev/null
+++ b/scripts/pycocci-check.sh
@@ -0,0 +1,8 @@
+#!/bin/bash
+set -e
+
+for i in tests/pycocci/patches/*.cocci; do
+	TEST=${i%%.cocci}
+	CODE_TEST=tests/pycocci/code/$(basename $TEST)
+	./tools/pycocci --clean-proof $i $CODE_TEST
+done
diff --git a/tests/pycocci/code/0001-proto3/proto3.c b/tests/pycocci/code/0001-proto3/proto3.c
new file mode 100644
index 000000000000..db3818afd5da
--- /dev/null
+++ b/tests/pycocci/code/0001-proto3/proto3.c
@@ -0,0 +1,7 @@
+#include "proto3.h"
+
+static void bch_sched_event(struct BCState *bcs, int event)
+{
+	bcs->event |= 1 << event;
+	schedule_work(&bcs->work);
+}
diff --git a/tests/pycocci/code/0001-proto3/proto3.h b/tests/pycocci/code/0001-proto3/proto3.h
new file mode 100644
index 000000000000..d4365e8c890e
--- /dev/null
+++ b/tests/pycocci/code/0001-proto3/proto3.h
@@ -0,0 +1,3 @@
+void bch_l2l1(struct PStack *st, int pr, void *arg);
+void bch_sched_event(struct BCState *bcs, int event);
+void bch_empty_fifo(struct BCState *bcs, int count);
diff --git a/tests/pycocci/patches/0001-proto3.cocci b/tests/pycocci/patches/0001-proto3.cocci
new file mode 100644
index 000000000000..d81678ef6d6e
--- /dev/null
+++ b/tests/pycocci/patches/0001-proto3.cocci
@@ -0,0 +1,11 @@
+@@
+identifier fn2;
+identifier bcs, ev;
+@@
+
+- fn2(struct BCState *bcs, int ev) {
++ fn2(int ev) {
+   ...
+   bcs->event |= 1 << ev;
+   schedule_work(&bcs->work);
+ }
diff --git a/tests/pycocci/patches/0001-proto3/0001-change-prototypes.patch b/tests/pycocci/patches/0001-proto3/0001-change-prototypes.patch
new file mode 100644
index 000000000000..e5b504e0acbb
--- /dev/null
+++ b/tests/pycocci/patches/0001-proto3/0001-change-prototypes.patch
@@ -0,0 +1,18 @@
+--- a/proto3.c
++++ b/proto3.c
+@@ -1,7 +1,6 @@
+ #include "proto3.h"
+ 
+-static void bch_sched_event(struct BCState *bcs, int event)
+-{
++static void bch_sched_event(int event) {
+ 	bcs->event |= 1 << event;
+ 	schedule_work(&bcs->work);
+ }
+--- a/proto3.h
++++ b/proto3.h
+@@ -1,3 +1,3 @@
+ void bch_l2l1(struct PStack *st, int pr, void *arg);
+-void bch_sched_event(struct BCState *bcs, int event);
++void bch_sched_event(int event);
+ void bch_empty_fifo(struct BCState *bcs, int count);
-- 
2.7.2
