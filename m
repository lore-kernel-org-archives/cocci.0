From: standby24x7@gmail.com (Masanari Iida)
Date: Sun, 17 Jul 2016 17:29:23 +0900
Subject: [Cocci] [PATCH 4/4] [bug-cocci] Fixed : typo in spatch_options.tex
In-Reply-To: <20160717082923.1771-1-standby24x7@gmail.com>
References: <alpine.DEB.2.10.1607170817320.3253@hadrien>
 <20160717082923.1771-1-standby24x7@gmail.com>
Message-ID: <20160717082923.1771-4-standby24x7@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

This patch fix 5 spelling typos found in
docs/manual/spatch_options.tex

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 docs/manual/spatch_options.tex | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/docs/manual/spatch_options.tex b/docs/manual/spatch_options.tex
index ca74a0d5a7d7..190931a2fdcd 100644
--- a/docs/manual/spatch_options.tex
+++ b/docs/manual/spatch_options.tex
@@ -78,7 +78,7 @@ patch file and print out some information about it.}
   containing the semantic patch.  The file name should end in {\tt .cocci}.
 All three options do the same thing.  These options are optional.  If they
 are not used, the single file whose name ends in \texttt{.cocci} is
-assoumed to be the name of the file containing the semantic patch.}
+assumed to be the name of the file containing the semantic patch.}
 
 \rare{-{}-sp ``semantic patch string''}{Specify a semantic match as a
   command-line argument.  See the section ``Command-line semantic match''
@@ -296,7 +296,7 @@ which score file to compare with in the testall run}
 \rare{-{}-parse-error-msg}{Show parsing errors in the C file.}
 
 \rare{-{}-verbose-parsing}{Show parsing errors in the C file, as well as
-  information about attempts to accomodate such errors.  This implicitly
+  information about attempts to accommodate such errors.  This implicitly
   sets {\bf -{}-parse-error-msg.}}
 
 \rare{-{}-parse-handler $\langle$file$\rangle$}{Loads the file containing
@@ -304,8 +304,8 @@ which score file to compare with in the testall run}
   have arguments 1) the line number containing the error, 2) the sequence
   of tokens, the starting and ending line of the function containing the
   error, and array containing the lines of the file containing the error,
-  and the pass of the parser on which the error occurs.  This functyion
-  should then be passed to the fuction {\tt
+  and the pass of the parser on which the error occurs.  This function
+  should then be passed to the function {\tt
     Parse\_c.set\_parse\_error\_function}.}
 
 \rare{-{}-type-error-msg}{Show information about where the C type checker
@@ -603,7 +603,7 @@ stars are used in column 0 rather than {\tt -} and {\tt +}, then the {\tt
 
 \normal{-{}-indent $n$}{The number of spaces to indent, if no other
   information is available.  If this information is not provided, then the
-  default indentation is a tab.  This option is thus particularly relevent
+  default indentation is a tab.  This option is thus particularly relevant
   to projects that don't use tabs.}
 
 \rare{-o $\langle$file$\rangle$}{ This causes the transformed code to be
-- 
2.9.2.277.g2949358
