From: himangi774@gmail.com (Himangi Saraogi)
Date: Thu, 19 Jun 2014 21:59:54 +0530
Subject: [Cocci] [PATCH] Coccinelle: Script to drop parenthesis in the
 return statements
Message-ID: <20140619162954.GA4698@himangi-Dell>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

This script detects the use of a parenthesis around return value ot the
return statements and removes them as they are unnecessary and against
the CodingStyle. A new directory called checkpatch is added for semantic
patches that just make patches for what checkpatch does. This will help
developers having checkpatch problems, to run the semantic patches in this
directory on their code and fix some of them automatically.

Signed-off-by: Himangi Saraogi <himangi774@gmail.com>
Acked-by: Julia Lawall <julia.lawall@lip6.fr>
---
 .../coccinelle/checkpatch/drop_parenthesis.cocci   | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 scripts/coccinelle/checkpatch/drop_parenthesis.cocci

diff --git a/scripts/coccinelle/checkpatch/drop_parenthesis.cocci b/scripts/coccinelle/checkpatch/drop_parenthesis.cocci
new file mode 100644
index 0000000..49c0538
--- /dev/null
+++ b/scripts/coccinelle/checkpatch/drop_parenthesis.cocci
@@ -0,0 +1,33 @@
+/// Remove parenthesis around return value in return statements
+///
+//# This makes an effort to find cases of parenthesis in the return
+//# statements when returning an identifier or a constant and removes
+//# the parenthesis as they are not required.
+//
+// Confidence: High
+// Copyright: 2014, Himangi Saraogi  GPLv2.
+// Comments:
+// Options: --no-includes --include-headers
+//
+
+virtual patch
+
+//----------------------------------------------------------
+//  For patch mode
+//----------------------------------------------------------
+
+ at depends on patch disable paren@
+identifier a;
+constant C;
+@@
+ return
+-(
+(
+C
+|
+a
+)
+-)
+ ;
+
-- 
1.9.1
