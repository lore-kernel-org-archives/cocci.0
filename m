From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Mon, 20 Jun 2016 14:54:08 -0700
Subject: [Cocci] [PATCH v2 3/3] docs: document .cocciconfig
In-Reply-To: <1466459648-17477-1-git-send-email-mcgrof@kernel.org>
References: <1466459648-17477-1-git-send-email-mcgrof@kernel.org>
Message-ID: <1466459648-17477-4-git-send-email-mcgrof@kernel.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Add documentation and example to manual and man page.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 docs/manual/cocci_syntax.tex | 23 +++++++++++++++++++++++
 docs/spatch.1.in             | 32 +++++++++++++++++++++++++++++++-
 2 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/docs/manual/cocci_syntax.tex b/docs/manual/cocci_syntax.tex
index 5adfc95b0ce1..dc7aa17712af 100644
--- a/docs/manual/cocci_syntax.tex
+++ b/docs/manual/cocci_syntax.tex
@@ -1782,6 +1782,29 @@ When using ocaml scripting a hash table is used for the same purposes.
 Coccinelle itself provides no support for this and as such addressing
 this with scripting is necessary.
 
+\section{.cocciconfig support}
+
+Coccinelle supports enabling custom options to be preferred when running
+spatch.  This is supported through the search of .cocciconfig files in each of
+the following directories, later lines extend and may override earlier ones:
+
+\begin{itemize}
+	\item Your current user's home directory is processed first
+	\item Your directory from which spatch is called is processed next
+	\item The directory provided with the --dir option is processed last, if used
+\end{itemize}
+
+Newlines, even with \, are not tolerated in attribute values. An example
+follows:
+
+\begin{quote}
+\begin{verbatim}
+[spatch]
+	options = --jobs 4
+	options = --show-trying
+\end{verbatim}
+\end{quote}
+
 %%% Local Variables:
 %%% mode: LaTeX
 %%% TeX-master: "main_grammar"
diff --git a/docs/spatch.1.in b/docs/spatch.1.in
index dae38952e88c..121048b1ea0b 100644
--- a/docs/spatch.1.in
+++ b/docs/spatch.1.in
@@ -55,7 +55,8 @@ and at the \fBscripts/coccinelle\fP directory of the Linux Kernel source
 code.
 
 .SH OPTIONS
-Here is a summary of the most commonly used options:
+Here is a summary of the most commonly used options (also
+see the "Configuration Mechanism" section below):
 
 .TP
 .B \-\-sp\-file \fI<file>\fP
@@ -566,6 +567,31 @@ It's for the other (internal) uses of the spatch program.
 \fB\-\-compare\-c\fR
 <file1> <file2>
 
+.SH CONFIGURATION MECHANISM
+
+Coccinelle uses a simple text format to store customizations into
+\.cocciconfig files, that can be per project, user, or target. The order
+in which the configuration file is processed is as follows, the
+later lines always extend and may override earlier ones:
+
+  o Your current user's home directory is processed first
+  o Your directory from which spatch is called is processed next
+  o The directory provided with the --dir option is processed last, if used
+
+Such a configuration file may look like this:
+
+.if n \{\
+.RS 4
+.\}
+.nf
+[spatch]
+	options = --jobs 4
+	options = --show-trying
+.fi
+.if n \{\
+.RE
+.\}
+
 .SH FILES
 .I @SHAREDIR@/standard.iso
 .RS
@@ -574,6 +600,10 @@ This file contains the default set of isomorphisms.
 .I @SHAREDIR@/standard.h
 .RS
 This file contains the default set of macro hints.
+.RE
+.I .cocciconfig
+.RS
+This file contains the custom set of spatch options.
 
 .SH ENVIRONMENT
 .IP COCCINELLE_HOME
-- 
2.8.2
