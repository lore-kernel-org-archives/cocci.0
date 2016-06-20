From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Mon, 20 Jun 2016 14:54:07 -0700
Subject: [Cocci] [PATCH v2 2/3] docs/manual/cocci_syntax.tex: extend with
	python iteration
In-Reply-To: <1466459648-17477-1-git-send-email-mcgrof@kernel.org>
References: <1466459648-17477-1-git-send-email-mcgrof@kernel.org>
Message-ID: <1466459648-17477-3-git-send-email-mcgrof@kernel.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 docs/manual/cocci_syntax.tex | 51 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 40 insertions(+), 11 deletions(-)

diff --git a/docs/manual/cocci_syntax.tex b/docs/manual/cocci_syntax.tex
index 49602ef1d732..5adfc95b0ce1 100644
--- a/docs/manual/cocci_syntax.tex
+++ b/docs/manual/cocci_syntax.tex
@@ -1698,9 +1698,12 @@ of every token.
 \section{Iteration}
 
 It is possible to iterate Coccinelle, giving the subsequent iterations a
-different set of virtual rules or virtual identifier bindings.  And example
-is found in {\tt demos/iteration.cocci}.  The example shown there is as
-follows:
+different set of virtual rules or virtual identifier bindings.  Coccinelle
+currently supports iteration with both ocaml and python scripting. An
+example with ocaml is fond in {\tt demos/iteration.cocci}, a python
+exmaple is found in {\tt demos/python\_iteration.cocci}.
+
+The ocaml scripting iteration example starts as follows.
 
 \begin{quote}
 \begin{verbatim}
@@ -1724,6 +1727,29 @@ with Not_found ->
 \end{verbatim}
 \end{quote}
 
+The respective python scripting iteration example starts as follows:
+
+\begin{quote}
+\begin{verbatim}
+virtual after_start
+
+ at initialize:python@
+@@
+
+seen = set()
+
+def add_if_not_present (source, f, file):
+    if (f, file) not in seen:
+        seen.add((f, file))
+        it = Iteration()
+        if file != None:
+            it.set_files([file])
+        it.add_virtual_rule(after_start)
+        it.add_virtual_identifier(err_ptr_function, f)
+        it.register()
+\end{verbatim}
+\end{quote}
+
 The virtual rule {\tt after\_start} is used to distinguish between the
 first iteration (in which it is not considered to have matched) and all
 others.  This is done by not mentioning {\tt after\_start} in the command
@@ -1734,11 +1760,12 @@ The main code for performing the iteration is found in the function {\tt
 {\tt register}.  {\tt New iteration} creates a structure representing the
 new iteration.  {\tt set\_files} sets the list of files to be considered on
 the new iteration.  If this function is not called, the new iteration
-treats the same files as the current iteration.  {\tt add\_virtual\_rule A}
-has the same effect as putting {\tt -D a} on the command line.  Note that
-the first letter of the rule name is capitalized, although this is not done
-elsewhere.  {\tt add\_virtual\_identifier X v} has the same effect as
-putting {\tt -D x=v} on the command line.  Note again the case change.
+treats the same files as the current iteration.  {\tt add\_virtual\_rule a}
+has the same effect as putting {\tt -D a} on the command line.  If
+using ocaml scripting instead of python scripting the first letter of the rule
+name is capitalized, although this is not done elsewhere.
+{\tt add\_virtual\_identifier x v} has the same effect as putting {\tt -D x=v}
+on the command line.  Again, when using ocaml scripting there is a case change.
 {\tt extend\_virtual\_identifiers()} (not shown) preserves all virtual
 identifiers of the current iteration that are not overridden by calls to
 {\tt add\_virtual\_identifier}.  Finally, the call to {\tt register} queues
@@ -1749,9 +1776,11 @@ Modification is not allowed when using iteration.  Thus, it is required to
 use the {\tt --no-show-diff}, unless the semantic patch contains {\tt *}s
 (a semantic match rather than a semantic patch).
 
-The remainder of the code above uses a hash table to ensure that the same
-information is not enqueued more than once.  Coccinelle itself provides no
-support for this.
+When using python scripting a tuple is used throughout the rest of the
+code to ensure that the same information is not enqueued more than once.
+When using ocaml scripting a hash table is used for the same purposes.
+Coccinelle itself provides no support for this and as such addressing
+this with scripting is necessary.
 
 %%% Local Variables:
 %%% mode: LaTeX
-- 
2.8.2
