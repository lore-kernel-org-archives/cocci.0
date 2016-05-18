From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Wed, 18 May 2016 14:42:22 -0700
Subject: [Cocci] [RFC 2/3] tests: add basic series of tests for exists and
	forall
In-Reply-To: <1463607743-11947-1-git-send-email-mcgrof@kernel.org>
References: <1463607743-11947-1-git-send-email-mcgrof@kernel.org>
Message-ID: <1463607743-11947-3-git-send-email-mcgrof@kernel.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

This should not only help test but also demo use of exists
and forall.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 tests/exists1.c     | 20 ++++++++++++++++++++
 tests/exists1.cocci |  9 +++++++++
 tests/exists1.res   | 21 +++++++++++++++++++++
 tests/exists2.c     | 21 +++++++++++++++++++++
 tests/exists2.cocci | 13 +++++++++++++
 tests/exists2.res   | 23 +++++++++++++++++++++++
 tests/exists3.c     | 21 +++++++++++++++++++++
 tests/exists3.cocci | 12 ++++++++++++
 tests/exists3.res   | 23 +++++++++++++++++++++++
 tests/exists4.c     | 22 ++++++++++++++++++++++
 tests/exists4.cocci | 13 +++++++++++++
 tests/exists4.res   | 21 +++++++++++++++++++++
 12 files changed, 219 insertions(+)
 create mode 100644 tests/exists1.c
 create mode 100644 tests/exists1.cocci
 create mode 100644 tests/exists1.res
 create mode 100644 tests/exists2.c
 create mode 100644 tests/exists2.cocci
 create mode 100644 tests/exists2.res
 create mode 100644 tests/exists3.c
 create mode 100644 tests/exists3.cocci
 create mode 100644 tests/exists3.res
 create mode 100644 tests/exists4.c
 create mode 100644 tests/exists4.cocci
 create mode 100644 tests/exists4.res

diff --git a/tests/exists1.c b/tests/exists1.c
new file mode 100644
index 000000000000..5cc37415bfef
--- /dev/null
+++ b/tests/exists1.c
@@ -0,0 +1,20 @@
+void bar(void)
+{
+	int a;
+
+	a = 300;
+	b();
+}
+
+int main(void)
+{
+	int a;
+
+	a = 10;
+	b();
+
+	c = 400;
+	c();
+
+	return 0;
+}
diff --git a/tests/exists1.cocci b/tests/exists1.cocci
new file mode 100644
index 000000000000..af95363de18f
--- /dev/null
+++ b/tests/exists1.cocci
@@ -0,0 +1,9 @@
+// this rule lacks exists, without exists, all control flows possible
+// must match the rule when + or - is used. In the case of exists1.c only
+// one possible control flow exists, the flow is completely linear.
+ at r@
+@@
+
+b();
+...
+-c();
diff --git a/tests/exists1.res b/tests/exists1.res
new file mode 100644
index 000000000000..cd83e4b2b6b1
--- /dev/null
+++ b/tests/exists1.res
@@ -0,0 +1,21 @@
+#include <stdio.h>
+
+int bar(void)
+{
+	int a;
+
+	a = 300;
+	b();
+}
+
+int main(void)
+{
+	int a;
+
+	a = 10;
+	b();
+
+	c = 400;
+
+	return 0;
+}
diff --git a/tests/exists2.c b/tests/exists2.c
new file mode 100644
index 000000000000..486a8f5633d9
--- /dev/null
+++ b/tests/exists2.c
@@ -0,0 +1,21 @@
+void bar(void)
+{
+	int a;
+
+	a = 300;
+	b();
+}
+
+int main(void)
+{
+	int a;
+
+	a = 10;
+	b();
+
+	c = 400;
+	if (a > 5)
+		c();
+
+	return 0;
+}
diff --git a/tests/exists2.cocci b/tests/exists2.cocci
new file mode 100644
index 000000000000..576b3cd3af24
--- /dev/null
+++ b/tests/exists2.cocci
@@ -0,0 +1,13 @@
+// this rule lacks exists, without exists, all control flows possible
+// must match the rule. In the case of exists2.c two possible control
+// flows exists on main():
+// 1. b() --> a > 5 --> c();
+// 2. b() --> a <= 5 ---> no c();
+// Not all control flows match, so no changes are made.
+// To visualize the control graph use: spatch --control-flow exists2.c
+ at r@
+@@
+
+b();
+...
+-c();
diff --git a/tests/exists2.res b/tests/exists2.res
new file mode 100644
index 000000000000..9d6401eb7d05
--- /dev/null
+++ b/tests/exists2.res
@@ -0,0 +1,23 @@
+#include <stdio.h>
+
+int bar(void)
+{
+	int a;
+
+	a = 300;
+	b();
+}
+
+int main(void)
+{
+	int a;
+
+	a = 10;
+	b();
+
+	c = 400;
+	if (a > 5)
+		c();
+
+	return 0;
+}
diff --git a/tests/exists3.c b/tests/exists3.c
new file mode 100644
index 000000000000..486a8f5633d9
--- /dev/null
+++ b/tests/exists3.c
@@ -0,0 +1,21 @@
+void bar(void)
+{
+	int a;
+
+	a = 300;
+	b();
+}
+
+int main(void)
+{
+	int a;
+
+	a = 10;
+	b();
+
+	c = 400;
+	if (a > 5)
+		c();
+
+	return 0;
+}
diff --git a/tests/exists3.cocci b/tests/exists3.cocci
new file mode 100644
index 000000000000..64cb43aa8ec4
--- /dev/null
+++ b/tests/exists3.cocci
@@ -0,0 +1,12 @@
+// this rule uses exists, with it, the rule is successful if at least
+// one of the possible control flows possible match.
+// exists3.c has two possible control flows on main():
+// 1. b() --> a > 5 --> c();
+// 2. b() --> a <= 5 ---> no c();
+// The match on 1. enables the changes to take place.
+ at r exists @
+@@
+
+b();
+...
+-c();
diff --git a/tests/exists3.res b/tests/exists3.res
new file mode 100644
index 000000000000..f6b53c361fa5
--- /dev/null
+++ b/tests/exists3.res
@@ -0,0 +1,23 @@
+#include <stdio.h>
+
+int bar(void)
+{
+	int a;
+
+	a = 300;
+	b();
+}
+
+int main(void)
+{
+	int a;
+
+	a = 10;
+	b();
+
+	c = 400;
+	if (a > 5)
+		{}
+
+	return 0;
+}
diff --git a/tests/exists4.c b/tests/exists4.c
new file mode 100644
index 000000000000..0b3dab08e6e1
--- /dev/null
+++ b/tests/exists4.c
@@ -0,0 +1,22 @@
+void bar(void)
+{
+	int a;
+
+	a = 300;
+	b();
+	c();
+}
+
+int main(void)
+{
+	int a;
+
+	a = 10;
+	b();
+
+	c = 400;
+	if (a > 5)
+		c();
+
+	return 0;
+}
diff --git a/tests/exists4.cocci b/tests/exists4.cocci
new file mode 100644
index 000000000000..d80c71a9d3f3
--- /dev/null
+++ b/tests/exists4.cocci
@@ -0,0 +1,13 @@
+// this rule uses forall, with it, all control flows must match.
+//
+// The exists4.c was extended to add a c() in comparison to exists2.c
+// this is done to show that using forall will still have an effect
+// on bar() even though it does not match on main()
+//
+// This is the default behaviour when + or - is used as well.
+ at r forall@
+@@
+
+b();
+...
+-c();
diff --git a/tests/exists4.res b/tests/exists4.res
new file mode 100644
index 000000000000..486a8f5633d9
--- /dev/null
+++ b/tests/exists4.res
@@ -0,0 +1,21 @@
+void bar(void)
+{
+	int a;
+
+	a = 300;
+	b();
+}
+
+int main(void)
+{
+	int a;
+
+	a = 10;
+	b();
+
+	c = 400;
+	if (a > 5)
+		c();
+
+	return 0;
+}
-- 
2.7.2
