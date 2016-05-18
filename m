From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Wed, 18 May 2016 14:42:23 -0700
Subject: [Cocci] [RFC 3/3] coccinelle: add control flow documentation
In-Reply-To: <1463607743-11947-1-git-send-email-mcgrof@kernel.org>
References: <1463607743-11947-1-git-send-email-mcgrof@kernel.org>
Message-ID: <1463607743-11947-4-git-send-email-mcgrof@kernel.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

From: "Luis R. Rodriguez" <mcgrof@suse.com>

Add control flow documentation.

Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
---
 docs/manual/Makefile         |   6 +-
 docs/manual/cocci_syntax.tex | 249 +++++++++++++++++++++++++++++++++++++++++++
 docs/manual/flow1.c          |  10 ++
 docs/manual/flow2.c          |  11 ++
 4 files changed, 275 insertions(+), 1 deletion(-)
 create mode 100644 docs/manual/flow1.c
 create mode 100644 docs/manual/flow2.c

diff --git a/docs/manual/Makefile b/docs/manual/Makefile
index 98e397ac5b69..c0a28bd9bd4b 100644
--- a/docs/manual/Makefile
+++ b/docs/manual/Makefile
@@ -36,7 +36,11 @@ manual.pdf: $(SRC)
 	$(PDFLATEX_CMD) manual.tex
 	$(PDFLATEX_CMD) manual.tex
 
-main_grammar.pdf: main_grammar.tex cocci_syntax.tex  macros_listing_cocci.tex macros_grammar.tex macros_common.tex examples.tex tips.tex
+main_grammar.pdf: main_grammar.tex cocci_syntax.tex flow1.c macros_listing_cocci.tex macros_grammar.tex macros_common.tex examples.tex tips.tex
+	#spatch --control-flow-to-file flow1.c
+	#spatch --control-flow-to-file flow2.c
+	#dot -Gsize="0.5,0.5" -Tpdf flow1:main.dot > flow1.pdf
+	#dot -Gsize="0.5,0.5" -Tpdf flow1:main.dot > flow2.pdf
 	$(PDFLATEX_CMD) main_grammar.tex
 	$(PDFLATEX_CMD) main_grammar.tex
 
diff --git a/docs/manual/cocci_syntax.tex b/docs/manual/cocci_syntax.tex
index 2c0f622251f6..4c0c3b3b84b1 100644
--- a/docs/manual/cocci_syntax.tex
+++ b/docs/manual/cocci_syntax.tex
@@ -584,6 +584,255 @@ rule is only applied if all of the metavariables for which there are no
 default values have values.  See demos/defaultscript.cocci for examples of
 the use of this feature.
 
+\section{Control Flow}
+
+Rules describe a property which Coccinelle must match, when the property
+described is matched the rule is considered successful. Program control
+flows vary, a control flow describes a possible run time path taken by
+a program.
+
+When using Coccinelle you often want to be able to express certain code
+within certain types of control flows. Typically you will use ellipses
+("...") to indicate to Coccinelle anything can be present between
+consecutive statements. For instance the following SmPL patch tells Coccinelle
+that rule r0 wishes to remove call calls to function c().
+
+\begin{center}
+\begin{tabular}{c}
+\begin{lstlisting}[language=Cocci]
+ at r0@
+@@
+
+-c();
+
+\end{lstlisting}\\
+\end{tabular}
+\end{center}
+
+The context of the rule provides no other guidlines to Coccinelle to hint
+about any possible control flow other than this is a statement, and that
+c() must be called. We can modify the required control flow required for
+this rule by providing additional requirements and usign ellipses in between.
+For instance, if we only wanted to remove call calls to c() but which also
+had a prior call to foo() we'd use the following SmPL patch:
+
+\begin{center}
+\begin{tabular}{c}
+\begin{lstlisting}[language=Cocci]
+ at r1@
+@@
+
+foo()
+...
+-c();
+\end{lstlisting}\\
+\end{tabular}
+\end{center}
+
+There are two possible modifiers to the control flow for ellipses, one
+is to annotate that statements in between ellipses are optional (<... ...>),
+or that the statements in between must be present at leaset once (<+... ...+).
+For instance the following SmPL patch tells Coccinelle to remove all
+calls to c() but foo() must be present at least once.
+
+\begin{center}
+\begin{tabular}{c}
+\begin{lstlisting}[language=Cocci]
+@r2@
+@@
+
+<+...
+foo()
+...+>
+-c();
+
+\end{lstlisting}\\
+\end{tabular}
+\end{center}
+
+Alternatively, if you wanted to be explicit that foo() was optional,
+you could use the following SmPL rule.
+
+\begin{center}
+\begin{tabular}{c}
+\begin{lstlisting}[language=Cocci]
+ at r3@
+@@
+
+<...
+foo()
+...>
+-c();
+
+\end{lstlisting}\\
+\end{tabular}
+\end{center}
+
+Let's consider some sample code to review, this is flow1.c.
+
+\begin{center}
+\begin{tabular}{c}
+\begin{lstlisting}[language=C]
+
+int main(void)
+{
+	int ret, a = 2;
+
+	a = foo(a);
+	ret = bar(a);
+	c();
+
+	return ret;
+}
+\end{lstlisting}\\
+\end{tabular}
+\end{center}
+
+Applying the SmPL rule r0 to flow1.c would remove the c() line as the control
+flow provides no specific context requirements. Applying rule r1 would also
+succeed as the call to foo() is present. Likewise rules r2 and r3 would also
+succeed. If the foo() call is removed from flow1.c only rules r0 and r3 would
+succeed, as foo() would not be present and only rules r0 and r3 allow for
+foo() to not be present.
+
+The program flow1.1 has a linear control flow, it has no branches. The main
+routine has a McCabe cyclomatic complexity of 1. The McCabe cyclomatic
+complexity can be computed using
+{\tt pmccabe} (https://www.gnu.org/software/complexity/manual/html\_node/pmccabe-parsing.html).
+
+\begin{center}
+\begin{tabular}{c}
+\begin{lstlisting}[language=C]
+pmccabe /flow1.c
+1       1       5       1       10      flow1.c(1): main
+\end{lstlisting}\\
+\end{tabular}
+\end{center}
+
+Since programs can use branches, often times you may also wish to annotate
+requirements for control flows in consideration for branches, for when
+the McCabe cyclomatic complexity is > 1. The following program, flow2.c,
+enables the control flow to diverge on line 7 due to the branch, if (a) --
+one control flow possible is if (a) is true, another when if (a) is false.
+
+\begin{center}
+\begin{tabular}{c}
+\begin{lstlisting}[language=C]
+int main(void)
+{
+	int ret, a = 2;
+
+	a = foo(a);
+	ret = bar(a);
+	if (a)
+		c();
+
+	return ret;
+}
+\end{lstlisting}\\
+\end{tabular}
+\end{center}
+
+This program has a McCabe cyclomatic complexity of 2.
+
+\begin{center}
+\begin{tabular}{c}
+\begin{lstlisting}[language=C]
+pmccabe flow2.c
+2       2       6       1       11      flow2.c(1): main
+\end{lstlisting}\\
+\end{tabular}
+\end{center}
+
+Using the McCabe cyclomatic complexity is one way to get an idea of
+the complexity of the control graph for a function, another way is
+to visualize all possible paths. Coccinelle provides a way to visualize
+control flows of programs, this however requires {\tt dot}
+(http://www.graphviz.org/) and {\tt gv} to be installed (typically provided
+by a package called graphviz). To visualize control flow or a program
+using Coccinelle you use:
+
+\begin{center}
+\begin{tabular}{c}
+spatch --control-flow-to-file flow1.c
+spatch --control-flow-to-file flow2.c
+\end{tabular}
+\end{center}
+
+Below are the two generated control flow graphs for flow1.c and flow2.c
+respectively.
+
+%\begin{figure}
+%	\[\includegraphics[width=\linewidth]{flow1.pdf}\]
+%	\caption{Linear flow example}
+%	\label{devmodel}
+%\end{figure}
+
+%\begin{figure}
+%	\[\includegraphics[width=\linewidth]{flow2.pdf}\]
+%	\caption{Linear flow example}
+%	\label{devmodel}
+%\end{figure}
+
+Behind the scenes this generates a dot file and uses gv to generate
+a PDF file for viewing. To generate and inspect these manually you
+can use the following:
+
+\begin{center}
+\begin{tabular}{c}
+spatch --control-flow-to-file flow2.c
+dot -Tpdf flow1:main.dot > flow1.pdf
+\end{tabular}
+\end{center}
+
+By default properties described in a rule must match all control
+flows possible within a code section being inspected by Coccinelle.
+So for instance, in the following SmPL patch rule r1 would match all
+the control flow possible on flow1.c as its linear, however it would
+not match the control possible on flow2.c. The rule r1 would not
+be successful in flow2.c
+
+\begin{center}
+\begin{tabular}{c}
+\begin{lstlisting}[language=Cocci]
+ at r1@
+@@
+
+foo()
+...
+-c();
+
+\end{lstlisting}\\
+\end{tabular}
+\end{center}
+
+The default control flow can be modified by using the keyword "exists"
+following the rule name. In the following SmPL patch the rule r2 would
+be successful on both flow1.c and flow2.c
+
+\begin{center}
+\begin{tabular}{c}
+\begin{lstlisting}[language=Cocci]
+ at r2 exists@
+@@
+
+foo()
+...
+-c();
+
+\end{lstlisting}\\
+\end{tabular}
+\end{center}
+
+If the rule is followed by the "forall" keyword, then all control flow
+paths must match in order for the rule to succeed. By default when one
+has "-" and "+", or when one has no annotations at all and only script
+code, ellipses ("...") uses the forall semantics.  And when one uses
+context annotation ("*"), the ellipses ("...") uses the exists semantics.
+Using the keyword "forall" or "exists" in the rule header affects
+all ellipses ("...") uses in the rule. You can also annotate each
+ellipses ("...") with "when exists" or "when forall" individually.
+
 \section{Transformation}
 
 The transformation specification essentially has the form of C code, except
diff --git a/docs/manual/flow1.c b/docs/manual/flow1.c
new file mode 100644
index 000000000000..43e45ed32843
--- /dev/null
+++ b/docs/manual/flow1.c
@@ -0,0 +1,10 @@
+int main(void)
+{
+	int ret, a = 2;
+
+	a = foo(a);
+	ret = bar(a);
+	c();
+
+	return ret;
+}
diff --git a/docs/manual/flow2.c b/docs/manual/flow2.c
new file mode 100644
index 000000000000..bb0d95e4c310
--- /dev/null
+++ b/docs/manual/flow2.c
@@ -0,0 +1,11 @@
+int main(void)
+{
+	int ret, a = 2;
+
+	a = foo(a);
+	ret = bar(a);
+	if (a)
+		c();
+
+	return ret;
+}
-- 
2.7.2
