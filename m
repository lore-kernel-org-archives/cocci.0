From: kborer@gmail.com (Kris Borer)
Date: Sat, 15 Aug 2015 13:18:52 -0400
Subject: [Cocci] [PATCH] coccinelle: add style check for assignment in if
Message-ID: <1439659132-4452-1-git-send-email-kborer@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Add a semantic patch for fixing some cases of checkpatch.pl error:

ERROR: do not use assignment in if condition

Reviewed-by: Julia Lawall <julia.lawall@lip6.fr>
Signed-off-by: Kris Borer <kborer@gmail.com>
---
 scripts/coccinelle/style/assignment_in_if.cocci | 92 +++++++++++++++++++++++++
 1 file changed, 92 insertions(+)
 create mode 100644 scripts/coccinelle/style/assignment_in_if.cocci

diff --git a/scripts/coccinelle/style/assignment_in_if.cocci b/scripts/coccinelle/style/assignment_in_if.cocci
new file mode 100644
index 0000000..22ab161
--- /dev/null
+++ b/scripts/coccinelle/style/assignment_in_if.cocci
@@ -0,0 +1,92 @@
+// find checkpatch.pl errors of the type:
+//	ERROR: do not use assignment in if condition
+//
+// This script is designed to correct code where assignments exist in if
+// conditions. It is only capable of handling a subset of such problems.
+//
+// For example:
+//
+//	if(result = myfun())
+//
+// would become:
+//
+//	result = myfun();
+//	if(result)
+//
+// Confidence: Moderate
+
+
+// if ( ret = call() )
+ at if1@
+identifier i;
+expression E;
+statement S1, S2;
+@@
+
++ i = E;
+  if (
+- (i = E)
++ i
+  ) S1 else S2
+
+
+// if ( (ret = call()) < 0 )
+@if2@
+identifier i;
+expression E;
+statement S1, S2;
+binary operator b;
+@@
+
++ i = E;
+  if (
+- (i = E)
++ i
+  b ... ) S1 else S2
+
+// if ( ptr->fun && (ret = ptr->fun()) < 0 )
+@if3@
+identifier i, i2;
+expression E1, E2;
+constant c;
+binary operator b;
+@@
+
++ if( E1->i ) {
++  	i2 = E2;
++ 	if (i2 b c) {
+- if( E1->i && ((i2 = E2) b c) ) {
+  ...
+- }
++ 	}
++ }
+
+// if ( (ret = call()) < 0 && ret != -1 )
+ at if4@
+identifier i;
+expression E, E2;
+statement S1, S2;
+binary operator b;
+@@
+
++ i = E;
+  if (
+- (i = E)
++ i
+  b
+  ... && E2 ) S1 else S2
+
+// if ( (ret = call()) < 0 && ret != -1 && ret != -2 )
+@if5@
+identifier i;
+expression E, E2, E3;
+statement S1, S2;
+binary operator b;
+@@
+
++ i = E;
+  if (
+- (i = E)
++ i
+  b
+  ... && E2 && E3 ) S1 else S2
-- 
1.9.1
