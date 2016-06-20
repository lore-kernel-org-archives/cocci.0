From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Mon, 20 Jun 2016 14:54:06 -0700
Subject: [Cocci] [PATCH v2 1/3] docs/demos: add a few ++ documentation and
	demos
In-Reply-To: <1466459648-17477-1-git-send-email-mcgrof@kernel.org>
References: <1466459648-17477-1-git-send-email-mcgrof@kernel.org>
Message-ID: <1466459648-17477-2-git-send-email-mcgrof@kernel.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

This perhaps is not the best demo for use of ++ but it
should suffice. This adds some basic documentation for it
and a demo.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 demos/plusplus1.c            |  4 ++
 demos/plusplus1.cocci        | 17 ++++++++
 demos/plusplus1.res          |  5 +++
 demos/plusplus2.c            |  7 ++++
 demos/plusplus2.cocci        | 26 ++++++++++++
 demos/plusplus2.res          | 10 +++++
 docs/manual/cocci_syntax.tex | 95 ++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 164 insertions(+)
 create mode 100644 demos/plusplus1.c
 create mode 100644 demos/plusplus1.cocci
 create mode 100644 demos/plusplus1.res
 create mode 100644 demos/plusplus2.c
 create mode 100644 demos/plusplus2.cocci
 create mode 100644 demos/plusplus2.res

diff --git a/demos/plusplus1.c b/demos/plusplus1.c
new file mode 100644
index 000000000000..2a28c8037cac
--- /dev/null
+++ b/demos/plusplus1.c
@@ -0,0 +1,4 @@
+struct x {
+	int z;
+	char b;
+};
diff --git a/demos/plusplus1.cocci b/demos/plusplus1.cocci
new file mode 100644
index 000000000000..86e5950b2a93
--- /dev/null
+++ b/demos/plusplus1.cocci
@@ -0,0 +1,17 @@
+// This adds a float for one int variable found.
+// Doing this however is limited to one int in the data structure, if
+// more one int variable in the structure we would not know where to
+// place the new one safely order-wise. See plusplus2.cocci for an
+// example of dealing with this issue.
+
+ at simpleplus@
+identifier x,v;
+fresh identifier xx = v ## "_float";
+@@
+
+struct x {
++	float xx;
+	...
+	int v;
+	...
+}
diff --git a/demos/plusplus1.res b/demos/plusplus1.res
new file mode 100644
index 000000000000..ba5c5341639e
--- /dev/null
+++ b/demos/plusplus1.res
@@ -0,0 +1,5 @@
+struct x {
+	float z_float;
+	int z;
+	char b;
+};
diff --git a/demos/plusplus2.c b/demos/plusplus2.c
new file mode 100644
index 000000000000..a03d26c6da14
--- /dev/null
+++ b/demos/plusplus2.c
@@ -0,0 +1,7 @@
+struct x {
+	int z;
+	int a;
+	char b;
+	int c;
+	int *d;
+};
diff --git a/demos/plusplus2.cocci b/demos/plusplus2.cocci
new file mode 100644
index 000000000000..bd61ac8f8771
--- /dev/null
+++ b/demos/plusplus2.cocci
@@ -0,0 +1,26 @@
+// This can support having a structure with more than two int variables,
+// and adding a respective float for each. It can do this as order does
+// not matter.
+//
+// This uses ++ to support the fact that the rule may be working
+// with multiple variables that we need to modify and that order
+// does not matter.
+//
+// If you don't use "++" you'll get "already tagged token" error since
+// Coccinelle is concerned that the user has no way of specifying the order
+// in which they should appear. By using "++" you are telling Coccinelle
+//
+//   "I know that a lot of things can collect here, and I'm OK
+//    with that.  I'm also OK with things getting added out of order.
+
+ at plusplus@
+identifier x,v;
+fresh identifier xx = v ## "_float";
+@@
+
+struct x {
+++	float xx;
+	...
+	int v;
+	...
+}
diff --git a/demos/plusplus2.res b/demos/plusplus2.res
new file mode 100644
index 000000000000..4920fb7d7df9
--- /dev/null
+++ b/demos/plusplus2.res
@@ -0,0 +1,10 @@
+struct x {
+	float a_float;
+	float c_float;
+	float z_float;
+	int z;
+	int a;
+	char b;
+	int c;
+	int *d;
+};
diff --git a/docs/manual/cocci_syntax.tex b/docs/manual/cocci_syntax.tex
index e8d74a7d015f..49602ef1d732 100644
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
@@ -1100,6 +1105,96 @@ write
 Some kinds of terms can only appear in + code.  These include comments,
 ifdefs, and attributes (\texttt{\_\_attribute\_\_((...))}).
 
+\subsection{Advanced transformations}
+
+You may run into the situation where grammar you specificy for
+transformations might associate itself with a few consecutive tokens
+in code, in such cases Coccinelle cannot gaurantee order when making
+additions. If you are sure that order does not matter you can use the
+optional double addition token \texttt{++} to annotate that Coccinelle
+may add things out of order. This may be for intance rather safe in
+certain situations when extending a data structure with more members,
+based on existing members of the data structure. The following rule helps
+to extend a data structure with a respective float for one present int.
+This works well with the simple \texttt{+}.
+
+\begin{lstlisting}[language=Cocci]
+ at simpleplus@
+identifier x,v;
+fresh identifier xx = v ## "_float";
+@@
+
+struct x {
++	float xx;
+	...
+	int v;
+	...
+}
+\end{lstlisting}
+
+This simpleplus rule transformation works well when only one token is being
+modified in code. For instance if we had plusplus1.c:
+
+\begin{lstlisting}[language=C]
+struct x {
+	int z;
+	char b;
+};
+\end{lstlisting}
+
+If however you have two consecutive tokens that Coccinelle
+can transform, order cannot be guaranteed for how Coccinelle
+makes additions. If you are sure order does not matter for
+the transformation you may use \texttt{++} instead, as follows:
+
+\begin{lstlisting}[language=Cocci]
+ at plusplus@
+identifier x,v;
+fresh identifier xx = v ## "_float";
+@@
+
+struct x {
+++	float xx;
+	...
+	int v;
+	...
+}
+\end{lstlisting}
+
+This rule would work against say a plusplus2.c which had two
+more tokens added in comparison to plusplus1.c:
+
+\begin{lstlisting}[language=C]
+struct x {
+	int z;
+	int a;
+	char b;
+	int c;
+	int *d;
+};
+\end{lstlisting}
+
+You would end up with a C file which would look similar to this, the
+precise order of the where each float is placed is however not gauranteed
+with respect to each other:
+
+\begin{lstlisting}[language=C]
+struct x {
+	float a_float;
+	float c_float;
+	float z_float;
+	int z;
+	int a;
+	char b;
+	int c;
+	int *d;
+};
+\end{lstlisting}
+
+If you used simpleplus rule on plusplus2.c you would end up with
+an "already tagged token" error due to the ordering considerations
+explained in this section.
+
 \section{Types}
 \label{types}
 
-- 
2.8.2
