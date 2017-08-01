From: gustavo@embeddedor.com (Gustavo A. R. Silva)
Date: Mon, 31 Jul 2017 23:38:04 -0500
Subject: [Cocci] [PATCH v2] Coccinelle: Script to remove unnecessary static
 on local variables
In-Reply-To: <20170727165848.GA15831@embeddedgus>
Message-ID: <20170801043804.GA4265@embeddedgus>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Coccinelle script to remove unnecessary static on local variables when
the variables are not used before update.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
Changes in v2:
 Update header and Copyright note.

 scripts/coccinelle/misc/static_unnecessary.cocci | 96 ++++++++++++++++++++++++
 1 file changed, 96 insertions(+)
 create mode 100644 scripts/coccinelle/misc/static_unnecessary.cocci

diff --git a/scripts/coccinelle/misc/static_unnecessary.cocci b/scripts/coccinelle/misc/static_unnecessary.cocci
new file mode 100644
index 0000000..2b10586
--- /dev/null
+++ b/scripts/coccinelle/misc/static_unnecessary.cocci
@@ -0,0 +1,96 @@
+/// Drop static on local variable when the variable is not used before update.
+//#
+//# Removing unnecessary static on local variables reduces the code
+//# size and increases maintainability.
+//#
+//# On the other hand, even though it is rare, be aware that if a
+//# large object is initialized all at once, it might not be wise
+//# to remove the static because that would increase the risk of a
+//# stack overflow.
+///
+// Confidence: Moderate
+// Copyright: (C) 2017 Julia Lawall, Inria. GPLv2.
+// URL: http://coccinelle.lip6.fr/
+// Copyright: (C) 2017 Gustavo A. R. Silva. GPLv2.
+// Work supported by a grant from
+// The Linux Foundation's Core Infrastructure Initiative.
+// URL: https://www.coreinfrastructure.org/
+// Options: --no-includes --include-headers
+// Keywords: static
+
+virtual patch
+virtual context
+virtual org
+virtual report
+
+// <smpl>
+ at bad exists@
+position p;
+identifier x;
+expression e;
+type T;
+@@
+
+T x at p;
+... when != x = e
+x = <+...x...+>
+
+ at worse exists@
+position p;
+identifier x;
+type T;
+@@
+
+T x at p;
+...
+ &x
+
+ at modify depends on patch && !context && !org && !report@
+identifier x;
+expression e;
+type T;
+position p != {bad.p,worse.p};
+@@
+
+-static
+ T x at p;
+ ... when != x
+     when strict
+?x = e;
+// </smpl>
+
+
+// ----------------------------------------------------------------------------
+
+ at modify_context depends on !patch && (context || org || report) forall@
+type T;
+identifier x;
+expression e;
+position p != {bad.p,worse.p};
+position j0;
+@@
+
+* static
+ T x at j0@p;
+ ... when != x
+     when strict
+?x = e;
+
+// ----------------------------------------------------------------------------
+
+ at script:python modify_org depends on org@
+j0 << modify_context.j0;
+@@
+
+msg = "Unnecessary static on local variable."
+coccilib.org.print_todo(j0[0], msg)
+
+// ----------------------------------------------------------------------------
+
+@script:python modify_report depends on report@
+j0 << modify_context.j0;
+@@
+
+msg = "Unnecessary static on local variable."
+coccilib.report.print_report(j0[0], msg)
+
-- 
2.5.0
