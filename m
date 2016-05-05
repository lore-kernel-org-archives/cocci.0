From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Wed,  4 May 2016 22:30:54 -0700
Subject: [Cocci] [RFC 2/2] tests: convert sp.cocci test to pycocci proof
In-Reply-To: <1462426254-22633-1-git-send-email-mcgrof@kernel.org>
References: <1462426254-22633-1-git-send-email-mcgrof@kernel.org>
Message-ID: <1462426254-22633-3-git-send-email-mcgrof@kernel.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 Makefile                            | 1 +
 scripts/test.sh                     | 8 ++++++++
 tests/{sp.cocci => 0001-sp.cocci}   | 0
 tests/0001-sp/replace-typedef.patch | 9 +++++++++
 tests/{ => code/0001-sp}/sp.c       | 0
 tests/sp.res                        | 4 ----
 6 files changed, 18 insertions(+), 4 deletions(-)
 create mode 100755 scripts/test.sh
 rename tests/{sp.cocci => 0001-sp.cocci} (100%)
 create mode 100644 tests/0001-sp/replace-typedef.patch
 rename tests/{ => code/0001-sp}/sp.c (100%)
 delete mode 100644 tests/sp.res

diff --git a/Makefile b/Makefile
index a98eefd2d83b..312f287fd61d 100644
--- a/Makefile
+++ b/Makefile
@@ -488,6 +488,7 @@ check: scripts/spatch
 		COCCINELLE_HOME="$$(pwd)" ./scripts/spatch --sp-file demos/hello/hello-python.cocci demos/hello/helloworld.c --very-quiet | grep -q 'Hello at: 2'; fi
 	@$(ECHO) running the test suite
 	COCCINELLE_HOME="$$(pwd)" ./scripts/spatch --testall --no-update-score-file
+	COCCINELLE_HOME="$$(pwd)" ./scripts/test.sh
 
 # -inline 0  to see all the functions in the profile.
 # Can also use the profile framework in commons/ and run your program
diff --git a/scripts/test.sh b/scripts/test.sh
new file mode 100755
index 000000000000..efaaa88e67be
--- /dev/null
+++ b/scripts/test.sh
@@ -0,0 +1,8 @@
+#!/bin/bash
+set -e
+
+for i in tests/0001-sp.cocci; do
+	TEST=${i%%.cocci}
+	CODE_TEST=tests/code/$(basename $TEST)
+	./tools/pycocci -v -s $i $CODE_TEST
+done
diff --git a/tests/sp.cocci b/tests/0001-sp.cocci
similarity index 100%
rename from tests/sp.cocci
rename to tests/0001-sp.cocci
diff --git a/tests/0001-sp/replace-typedef.patch b/tests/0001-sp/replace-typedef.patch
new file mode 100644
index 000000000000..5097b94cbfca
--- /dev/null
+++ b/tests/0001-sp/replace-typedef.patch
@@ -0,0 +1,9 @@
+--- a/sp.c
++++ b/sp.c
+@@ -1,4 +1,4 @@
+-typedef struct {
++struct name {
+ 	unsigned long gcr;
+ 	struct pci_dev *pci;
+-} snd_card_als4000_t;
++};
diff --git a/tests/sp.c b/tests/code/0001-sp/sp.c
similarity index 100%
rename from tests/sp.c
rename to tests/code/0001-sp/sp.c
diff --git a/tests/sp.res b/tests/sp.res
deleted file mode 100644
index a97fecceb3f0..000000000000
--- a/tests/sp.res
+++ /dev/null
@@ -1,4 +0,0 @@
-struct name {
-	unsigned long gcr;
-	struct pci_dev *pci;
-};
-- 
2.7.2
