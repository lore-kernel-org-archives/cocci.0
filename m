From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Wed,  8 Jun 2016 13:50:46 -0700
Subject: [Cocci] [PATCH] docs/demos: add ++ transformation documentation and
	demos
Message-ID: <1465419046-24096-1-git-send-email-mcgrof@kernel.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

This perhaps is not the best demo for use of ++ but it
should suffice. This adds some basic documentation for it
and a demo.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 demos/vars1.c                |  26 ++++++++
 demos/vars1.cocci            |  28 +++++++++
 demos/vars1.res              |  26 ++++++++
 demos/vars2.c                |  28 +++++++++
 demos/vars2.cocci            |  36 ++++++++++++
 demos/vars2.res              |  28 +++++++++
 docs/manual/cocci_syntax.tex | 137 +++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 309 insertions(+)
 create mode 100644 demos/vars1.c
 create mode 100644 demos/vars1.cocci
 create mode 100644 demos/vars1.res
 create mode 100644 demos/vars2.c
 create mode 100644 demos/vars2.cocci
 create mode 100644 demos/vars2.res

diff --git a/demos/vars1.c b/demos/vars1.c
new file mode 100644
index 000000000000..b308c05b2013
--- /dev/null
+++ b/demos/vars1.c
@@ -0,0 +1,26 @@
+#include <stdio.h>
+#include <stdbool.h>
+
+struct foo {
+	int a;
+	int b;
+	int c;
+};
+
+struct foo stuff {
+	a = 1,
+	b = 2,
+	c = 3,
+};
+
+int main(void)
+{
+	struct foo *bar = &stuff;
+	int copy_a = bar->a;
+
+	if (true) {
+		printf("copy_a: %d\n", copy_a);
+	}
+
+	return 0;
+}
diff --git a/demos/vars1.cocci b/demos/vars1.cocci
new file mode 100644
index 000000000000..055afbc34688
--- /dev/null
+++ b/demos/vars1.cocci
@@ -0,0 +1,28 @@
+/*
+ * This can move unused variables declaration and assignment
+ * which is only used in the branch into the branch. Its
+ * resticted however to only apply to code where this happens
+ * only once. Refer to vars2.[c|cocci] for handling multiple
+ * cases.
+ */
+
+ at simpleplus@
+identifier f, x, i, var;
+expression e1;
+type T;
+@@
+
+f (...) {
+ ... when != x
+     when any
+-T x = i->var;
+ ... when != x
+     when != i = e1
+     when any
+ if (...) {
++  T x = var;
+   <+...x...+>
+  }
+... when != x
+    when any
+}
diff --git a/demos/vars1.res b/demos/vars1.res
new file mode 100644
index 000000000000..98270324eea5
--- /dev/null
+++ b/demos/vars1.res
@@ -0,0 +1,26 @@
+#include <stdio.h>
+#include <stdbool.h>
+
+struct foo {
+	int a;
+	int b;
+	int c;
+};
+
+struct foo stuff {
+	a = 1,
+	b = 2,
+	c = 3,
+};
+
+int main(void)
+{
+	struct foo *bar = &stuff;
+
+	if (true) {
+		int copy_a = bar->a;
+		printf("copy_a: %d\n", copy_a);
+	}
+
+	return 0;
+}
diff --git a/demos/vars2.c b/demos/vars2.c
new file mode 100644
index 000000000000..b58bb467b388
--- /dev/null
+++ b/demos/vars2.c
@@ -0,0 +1,28 @@
+#include <stdio.h>
+#include <stdbool.h>
+
+struct foo {
+	int a;
+	int b;
+	int c;
+};
+
+struct foo stuff {
+	a = 1,
+	b = 2,
+	c = 3,
+};
+
+int main(void)
+{
+	struct foo *bar = &stuff;
+	int copy_a = bar->a;
+	int copy_b = bar->b;
+
+	if (true) {
+		printf("copy_a: %d\n", copy_a);
+		printf("copy_b: %d\n", copy_b);
+	}
+
+	return 0;
+}
diff --git a/demos/vars2.cocci b/demos/vars2.cocci
new file mode 100644
index 000000000000..d42b4acbcb5a
--- /dev/null
+++ b/demos/vars2.cocci
@@ -0,0 +1,36 @@
+/*
+ * This can move more than one unused variables declaration and assignment
+ * which is only used in the branch into the branch.
+ *
+ * This uses ++ to support the fact that the rule may be working
+ * with multiple variables that we need to modify and that order
+ * doe snot matter.
+ *
+ * If you don't use "++" you'll get "already tagged token" error since
+ * Coccinelle is concerned that the user has no way of specifying the order
+ * in which they should appear. By using "++" you are telling Coccinelle
+ *
+ *   "I know that a lot of things can collect here, and I'm OK
+ *    with that.  I'm also OK with things getting added out of order.
+ */
+
+ at plusplus@
+identifier f, x, i, var;
+expression e1;
+type T;
+@@
+
+f (...) {
+ ... when != x
+     when any
+-T x = i->var;
+ ... when != x
+     when != i = e1
+     when any
+ if (...) {
+++  T x = var;
+   <+...x...+>
+  }
+... when != x
+    when any
+}
diff --git a/demos/vars2.res b/demos/vars2.res
new file mode 100644
index 000000000000..e798c8f54529
--- /dev/null
+++ b/demos/vars2.res
@@ -0,0 +1,28 @@
+#include <stdio.h>
+#include <stdbool.h>
+
+struct foo {
+	int a;
+	int b;
+	int c;
+};
+
+struct foo stuff {
+	a = 1,
+	b = 2,
+	c = 3,
+};
+
+int main(void)
+{
+	struct foo *bar = &stuff;
+
+	if (true) {
+		int copy_a = bar->a;
+		int copy_b = bar->b;
+		printf("copy_a: %d\n", copy_a);
+		printf("copy_b: %d\n", copy_b);
+	}
+
+	return 0;
+}
diff --git a/docs/manual/cocci_syntax.tex b/docs/manual/cocci_syntax.tex
index e8d74a7d015f..7cbbc9d0d74f 100644
--- a/docs/manual/cocci_syntax.tex
+++ b/docs/manual/cocci_syntax.tex
@@ -851,6 +851,11 @@ rule should apply if rule XXX was never matched at all.
 
 \section{Transformation}
 
+Coccinelle allows for transformations to enable modifying C code using
+very precise grammar.
+
+\subsection{Basic transformations}
+
 The transformation specification essentially has the form of C code, except
 that lines to remove are annotated with \verb+-+ in the first column, and
 lines to add are annotated with \verb-+-.  A transformation specification
@@ -1100,6 +1105,138 @@ write
 Some kinds of terms can only appear in + code.  These include comments,
 ifdefs, and attributes (\texttt{\_\_attribute\_\_((...))}).
 
+\subsection{Advanced transformations}
+
+You may run into the situation where grammar you specificy for
+transformations might associate itself with a few consecutive tokens
+in code, in such cases Coccinelle cannot gaurantee order when making
+additions. If you are sure that order does not matter you can use the
+optional double addition token \texttt{++} to annotate that Coccinelle
+may add things out of order. For instance, the following rule helps
+move unused variable declaration into the branch if its only used
+there.
+
+\begin{lstlisting}[language=Cocci]
+ at simpleplus@
+identifier f, x, i, var;
+expression e1;
+type T;
+@@
+
+f (...) {
+ ... when != x
+     when any
+-T x = i->var;
+ ... when != x
+     when != i = e1
+     when any
+ if (...) {
++  T x = var;
+   <+...x...+>
+  }
+... when != x
+    when any
+}
+\end{lstlisting}
+
+This simpleplus rule transformation works well when only one token is being
+modified in code. For instance if we had simpleplus.c:
+
+\begin{lstlisting}[language=C]
+#include <stdio.h>
+#include <stdbool.h>
+
+struct foo {
+	int a;
+	int b;
+	int c;
+};
+
+struct foo stuff {
+	a = 1,
+	b = 2,
+	c = 3,
+};
+
+int main(void)
+{
+	struct foo *bar = &stuff;
+	int copy_a = bar->a;
+
+	if (true) {
+		printf("copy_a: %d\n", copy_a);
+	}
+
+	return 0;
+}
+\end{lstlisting}
+
+If however you have two consecutive tokens that Coccinelle
+can transform order cannot be guaranteed for how Coccinelle
+makes additions. If you are sure order does not matter for
+the transformation you may use \texttt{++} instead, as follows:
+
+\begin{lstlisting}[language=Cocci]
+ at plusplus@
+identifier f, x, i, var;
+expression e1;
+type T;
+@@
+
+f (...) {
+ ... when != x
+     when any
+-T x = i->var;
+ ... when != x
+     when != i = e1
+     when any
+ if (...) {
+++  T x = var;
+   <+...x...+>
+  }
+... when != x
+    when any
+}
+\end{lstlisting}
+
+This rule would work against say a plusplus.c which had just
+one more token added in comparison to simpleplus.c:
+
+\begin{lstlisting}[language=C]
+#include <stdio.h>
+#include <stdbool.h>
+
+struct foo {
+	int a;
+	int b;
+	int c;
+};
+
+struct foo stuff {
+	a = 1,
+	b = 2,
+	c = 3,
+};
+
+int main(void)
+{
+	struct foo *bar = &stuff;
+	int copy_a = bar->a;
+	int copy_b = bar->b;
+
+	if (true) {
+		printf("copy_a: %d\n", copy_a);
+		printf("copy_b: %d\n", copy_b);
+	}
+
+	return 0;
+}
+\end{lstlisting}
+
+If you used simpleplus rule on plusplus.c you would end up with
+an "already tagged token" error due to the ordering considerations
+explained in this section.
+
 \section{Types}
 \label{types}
 
-- 
2.8.2
