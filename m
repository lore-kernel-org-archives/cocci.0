From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Thu,  8 Feb 2018 13:53:54 +0100
Subject: [Cocci] [PATCH] scripts/coccinelle/misc/shift.cocci: detect < or >
	that should be a shift
Message-ID: <1518094434-12852-1-git-send-email-Julia.Lawall@lip6.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

This checks for a comparison using < or > between two constants,
considering both explicit constants (1, 2, etc) and macros defined
with #define.  False positives are possible in the latter case, when
a macro may have multiple possible definitions and it is indeed
necessary to check the value.  There are currently two such false
positives, in drivers/net/ethernet/chelsio/cxgb3/sge.c:

       q->fl[0].use_pages = FL0_PG_CHUNK_SIZE > 0;
       q->fl[1].use_pages = FL1_PG_CHUNK_SIZE > 0;

It seems fairly clear that the use_pages field is intended to hold a
boolean value.  The semantic patch actually provides for this, but
the rule requires the left side of the assignment to be a bool, and
here it is declared as unsigned int.  Hopefully there will not be too
many false positives, and the benefit of including macros in the
check will execeed the cost of checking the output for errors.

Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Suggested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 scripts/coccinelle/misc/shift.cocci |   89 ++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/scripts/coccinelle/misc/shift.cocci b/scripts/coccinelle/misc/shift.cocci
new file mode 100644
index 0000000..15612f6
--- /dev/null
+++ b/scripts/coccinelle/misc/shift.cocci
@@ -0,0 +1,89 @@
+/// < and > between constants is typically meant to be a shift operation
+//# When the left argument is a #define constant, the operation can be
+//# meaningful.
+///
+// Confidence: Moderate
+// Copyright: (C) 2018 Julia Lawall, Inria, GPLv2.
+// URL: http://coccinelle.lip6.fr/
+// Options: --include-headers --include-headers-for-types
+
+virtual patch
+virtual context
+virtual org
+virtual report
+
+ at ok@
+position p;
+expression x,y;
+binary operator op = {<,>};
+typedef bool;
+bool b;
+@@
+
+(
+x op at p y || ...
+|
+x op at p y && ...
+|
+b = x op at p y
+|
+WARN_ON(x op at p y)
+|
+WARN_ON_ONCE(x op at p y)
+|
+BUG_ON(x op at p y)
+|
+BUILD_BUG_ON(x op at p y)
+|
+BUILD_BUG_ON_MSG(x op at p y,...)
+)
+
+// ----------------------------------------------------------------------------
+
+ at depends on patch && !context && !org && !report@
+type T;
+binary operator op = {<,>};
+position p != ok.p;
+constant int x, y;
+@@
+
+(
+ (T)x
+- <@p
++ <<
+ y
+|
+ (T)x
+- >@p
++ >>
+ y
+)
+
+ at r depends on !patch && (context || org || report)@
+type T;
+binary operator op = {<,>};
+position p != ok.p;
+constant int x, y;
+position j0 : script:python() { j0[0].file != "" }; // "" in ifdefs
+@@
+
+*(T)x op at p@j0 y
+
+// ----------------------------------------------------------------------------
+
+ at script:python r_org depends on org@
+j0 << r.j0;
+@@
+
+msg = "WARNING: Shift rather than comparison expected."
+coccilib.org.print_todo(j0[0], msg)
+
+// ----------------------------------------------------------------------------
+
+@script:python r_report depends on report@
+j0 << r.j0;
+@@
+
+msg = "WARNING: Shift rather than comparison expected."
+coccilib.report.print_report(j0[0], msg)
+
