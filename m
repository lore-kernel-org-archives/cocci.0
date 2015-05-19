From: fabf@skynet.be (Fabian Frederick)
Date: Tue, 19 May 2015 20:35:01 +0200
Subject: [Cocci] [PATCH 1/1] scripts/coccinelle/misc: add swap.cocci
Message-ID: <1432060501-9463-1-git-send-email-fabf@skynet.be>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Operations like

int a, b, tmp;

tmp = a;
a = b;
b = tmp;

can be replaced by

int a, b;

swap(a, b);

This uses kernel.h macro definition and simplifies the code.

Thanks to Julia Lawall for suggestions about expressions and sgen

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 scripts/coccinelle/misc/swap.cocci | 62 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 scripts/coccinelle/misc/swap.cocci

diff --git a/scripts/coccinelle/misc/swap.cocci b/scripts/coccinelle/misc/swap.cocci
new file mode 100644
index 0000000..0f0929c
--- /dev/null
+++ b/scripts/coccinelle/misc/swap.cocci
@@ -0,0 +1,62 @@
+/// Use swap macro instead of complete operation to simplify the code
+///
+// # Generated with sgen
+//
+// Confidence: Moderate
+// Copyright: (C) 2015 Fabian Frederick. GPLv2.
+
+virtual patch
+virtual context
+virtual org
+virtual report
+
+ at r depends on patch && !context && !org && !report@
+identifier i1, i2, tmp;
+type t1;
+@@
+
+- t1 tmp;
+<+... when any
+- tmp = i1;
+- i1 = i2;
+- i2 = tmp;
++ swap(i1, i2);
+...+>
+
+
+// ----------------------------------------------------------------------------
+
+ at r_context depends on !patch && (context || org || report)@
+type t1;
+identifier i1, i2, tmp;
+position j0, j1;
+@@
+
+*  t1 tmp at j0;
+<+... when any
+*  tmp@j1 = i1;
+*  i1 = i2;
+*  i2 = tmp;
+...+>
+
+// ----------------------------------------------------------------------------
+
+ at script:python r_org depends on org@
+j0 << r_context.j0;
+j1 << r_context.j1;
+@@
+
+msg = "swap.cocci"
+coccilib.org.print_todo(j0[0], msg)
+coccilib.org.print_link(j1[0], "")
+
+// ----------------------------------------------------------------------------
+
+@script:python r_report depends on report@
+j0 << r_context.j0;
+j1 << r_context.j1;
+@@
+
+msg = "WARNING: use swap() and remove temporary variable if it's not used elsewhere around line %s." % (j1[0].line)
+coccilib.report.print_report(j0[0], msg)
+
-- 
2.4.0
