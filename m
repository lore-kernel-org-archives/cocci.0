From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Thu, 19 May 2016 16:08:54 -0700
Subject: [Cocci] [PATCH v2 1/3] tests: add test to remove single statement
	from branch
In-Reply-To: <1463699336-16151-1-git-send-email-mcgrof@kernel.org>
References: <1463699336-16151-1-git-send-email-mcgrof@kernel.org>
Message-ID: <1463699336-16151-2-git-send-email-mcgrof@kernel.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

At leaset with coccinelle 1.0.4 this test fails with
two issues, one is the return statement is shifted,
another is debatable -- an empty branch statement is
left. This is funtional however its debatable if this
is desirable by default.

v2: do not remove the if -- the if is needed as the items
    in the branch could consist of functional run time
    changes, for instance if (bar()).

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 tests/remove-code-in-branch1.c     | 7 +++++++
 tests/remove-code-in-branch1.cocci | 4 ++++
 tests/remove-code-in-branch1.res   | 7 +++++++
 3 files changed, 18 insertions(+)
 create mode 100644 tests/remove-code-in-branch1.c
 create mode 100644 tests/remove-code-in-branch1.cocci
 create mode 100644 tests/remove-code-in-branch1.res

diff --git a/tests/remove-code-in-branch1.c b/tests/remove-code-in-branch1.c
new file mode 100644
index 000000000000..83840bdd99ac
--- /dev/null
+++ b/tests/remove-code-in-branch1.c
@@ -0,0 +1,7 @@
+int main(void)
+{
+	if (a > 1)
+		c();
+
+	return 0;
+}
diff --git a/tests/remove-code-in-branch1.cocci b/tests/remove-code-in-branch1.cocci
new file mode 100644
index 000000000000..b3f03523ac92
--- /dev/null
+++ b/tests/remove-code-in-branch1.cocci
@@ -0,0 +1,4 @@
+ at r@
+@@
+
+-c();
diff --git a/tests/remove-code-in-branch1.res b/tests/remove-code-in-branch1.res
new file mode 100644
index 000000000000..eb7985f683a0
--- /dev/null
+++ b/tests/remove-code-in-branch1.res
@@ -0,0 +1,7 @@
+int main(void)
+{
+	if (a > 1)
+		{}
+
+	return 0;
+}
-- 
2.7.2
