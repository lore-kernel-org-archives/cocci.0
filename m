From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Sat,  2 Feb 2013 17:19:55 +0100
Subject: [Cocci] [PATCH] scripts/coccinelle: find constant additions that
	could be bit ors
Message-ID: <1359821995-27910-1-git-send-email-Julia.Lawall@lip6.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

From: Julia Lawall <Julia.Lawall@lip6.fr>

Semantic patch (http://coccinelle.lip6.fr/) to check for constants that are
added but are used elsewhere as bitmasks.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 scripts/coccinelle/misc/orplus.cocci |   55 +++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/scripts/coccinelle/misc/orplus.cocci b/scripts/coccinelle/misc/orplus.cocci
new file mode 100644
index 0000000..4a28cef
--- /dev/null
+++ b/scripts/coccinelle/misc/orplus.cocci
@@ -0,0 +1,55 @@
+/// Check for constants that are added but are used elsewhere as bitmasks
+/// The results should be checked manually to ensure that the nonzero
+/// bits in the two constants are actually disjoint.
+///
+// Confidence: Moderate
+// Copyright: (C) 2013 Julia Lawall, INRIA/LIP6.  GPLv2.
+// Copyright: (C) 2013 Gilles Muller, INRIA/LIP6.  GPLv2.
+// URL: http://coccinelle.lip6.fr/
+// Comments:
+// Options: -no_includes -include_headers
+
+virtual org
+virtual report
+virtual context
+
+ at r@
+constant c;
+identifier i;
+expression e;
+@@
+
+(
+e | c at i
+|
+e & c at i
+|
+e |= c at i
+|
+e &= c at i
+)
+
+ at s@
+constant r.c,c1;
+identifier i1;
+position p;
+@@
+
+(
+ c1 + c - 1
+|
+*c1 at i1 + at p c
+)
+
+ at script:python depends on org@
+p << s.p;
+@@
+
+cocci.print_main("sum of probable bitmasks, consider |",p)
+
+@script:python depends on report@
+p << s.p;
+@@
+
+msg = "WARNING: sum of probable bitmasks, consider |"
+coccilib.report.print_report(p[0],msg)
