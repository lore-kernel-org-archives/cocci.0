From: linux@rasmusvillemoes.dk (Rasmus Villemoes)
Date: Fri,  9 Aug 2013 17:59:53 +0000
Subject: [Cocci] [PATCH v2] coccinelle: replace 0/1 with false/true in
	functions returning bool
In-Reply-To: <1376064946-20232-1-git-send-email-linux@rasmusvillemoes.dk>
References: <1376064946-20232-1-git-send-email-linux@rasmusvillemoes.dk>
Message-ID: <1376071193-21146-1-git-send-email-linux@rasmusvillemoes.dk>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

This semantic patch replaces "return {0,1};" with "return
{false,true};" in functions returning bool.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
v2: Simplified script, and eliminate whitespace mangling at the same
time. Thanks to Julia Lawall.

 scripts/coccinelle/misc/boolreturn.cocci |   56 ++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 scripts/coccinelle/misc/boolreturn.cocci

diff --git a/scripts/coccinelle/misc/boolreturn.cocci b/scripts/coccinelle/misc/boolreturn.cocci
new file mode 100644
index 0000000..c8d494c
--- /dev/null
+++ b/scripts/coccinelle/misc/boolreturn.cocci
@@ -0,0 +1,56 @@
+/// Return statements in functions returning bool should use
+/// true/false instead of 1/0.
+//
+// Confidence: High
+
+virtual patch
+virtual report
+
+
+ at r1 depends on patch@
+identifier fn;
+typedef bool;
+symbol false;
+symbol true;
+@@
+
+bool fn ( ... )
+{
+...
+return
+(
+- 0
++ false
+|
+- 1
++ true
+)
+  ;
+...
+}
+
+ at r2 depends on !patch@
+identifier fn;
+position p;
+@@
+
+bool fn ( ... )
+{
+	...
+return
+(
+* 0 at p
+|
+* 1 at p
+)
+  ;
+	...
+}
+
+
+ at script:python depends on report@
+p << r2.p;
+fn << r2.fn;
+@@
+
+coccilib.report.print_report(p[0], "WARNING: return of 0/1 in function '%s' with return type bool" % fn)
-- 
1.7.9.5
