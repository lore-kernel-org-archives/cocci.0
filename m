From: standby24x7@gmail.com (Masanari Iida)
Date: Sun, 17 Jul 2016 17:29:22 +0900
Subject: [Cocci] [PATCH 3/4] [bug-cocci] Fixed: typo in cocci_syntax.tex
In-Reply-To: <20160717082923.1771-1-standby24x7@gmail.com>
References: <alpine.DEB.2.10.1607170817320.3253@hadrien>
 <20160717082923.1771-1-standby24x7@gmail.com>
Message-ID: <20160717082923.1771-3-standby24x7@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

This patch fix 3 spelling typos found in docs/manual/cocci_syntax.tex

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 docs/manual/cocci_syntax.tex | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/docs/manual/cocci_syntax.tex b/docs/manual/cocci_syntax.tex
index 230b8552031c..d0c9b492acb1 100644
--- a/docs/manual/cocci_syntax.tex
+++ b/docs/manual/cocci_syntax.tex
@@ -17,7 +17,7 @@ possible C-language constants.
 
 A square bracket that is surrounded by spaces in the description of a term
 should appear explicitly in the term, as in an array reference.  On the
-other hand, square brackets that surround some other term indicat that the
+other hand, square brackets that surround some other term indicate that the
 presence of that term is optional.
 
 %
@@ -654,7 +654,7 @@ foo()
 \end{tabular}
 \end{center}
 
-Alternatively, the following inidcates that foo() is allowed but optional.
+Alternatively, the following indicates that foo() is allowed but optional.
 This case is typically most useful when all occurrences, if any, of foo()
 prior to c() should be transformed.
 
@@ -1062,7 +1062,7 @@ last matching include that is not under an ifdef in the file.
 
 Each element of a disjunction must be a proper term like an expression, a
 statement, an identifier or a declaration. The constraint on a conjunction
-is similiar.  Thus, the rule on the left below is not a syntactically
+is similar.  Thus, the rule on the left below is not a syntactically
 correct SmPL rule. One may use the rule on the right instead.
 
 \begin{center}
-- 
2.9.2.277.g2949358
