From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Thu, 22 Oct 2015 22:11:59 +0200
Subject: [Cocci] [PATCH] cocinelle: iterators: semantic patch to delete
	unneeded of_node_put
Message-ID: <1445544719-11953-1-git-send-email-Julia.Lawall@lip6.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Device node iterators perform an of_node_put on each iteration, so putting
an of_node_put before a continue results in a double put.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 scripts/coccinelle/iterators/device_node_continue.cocci |  100 ++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/scripts/coccinelle/iterators/device_node_continue.cocci b/scripts/coccinelle/iterators/device_node_continue.cocci
new file mode 100644
index 0000000..38ab744
--- /dev/null
+++ b/scripts/coccinelle/iterators/device_node_continue.cocci
@@ -0,0 +1,100 @@
+/// Device node iterators put the previous value of the index variable, so an
+/// explicit put causes a double put.
+///
+// Confidence: High
+// Copyright: (C) 2015 Julia Lawall, Inria. GPLv2.
+// URL: http://coccinelle.lip6.fr/
+// Options: --no-includes --include-headers
+// Keywords: for_each_child_of_node, etc.
+
+virtual patch
+virtual context
+virtual org
+virtual report
+
+ at r exists@
+expression e1,e2;
+local idexpression n;
+iterator name for_each_node_by_name, for_each_node_by_type,
+for_each_compatible_node, for_each_matching_node,
+for_each_matching_node_and_match, for_each_child_of_node,
+for_each_available_child_of_node, for_each_node_with_property;
+iterator i;
+position p1,p2;
+statement S;
+@@
+
+(
+(
+for_each_node_by_name(n,e1) S
+|
+for_each_node_by_type(n,e1) S
+|
+for_each_compatible_node(n,e1,e2) S
+|
+for_each_matching_node(n,e1) S
+|
+for_each_matching_node_and_match(n,e1,e2) S
+|
+for_each_child_of_node(e1,n) S
+|
+for_each_available_child_of_node(e1,n) S
+|
+for_each_node_with_property(n,e1) S
+)
+&
+i at p1(...) {
+   ... when != of_node_get(n)
+       when any
+   of_node_put at p2(n);
+   ... when any
+}
+)
+
+ at s exists@
+local idexpression r.n;
+statement S;
+position r.p1,r.p2;
+iterator i;
+@@
+
+ of_node_put at p2(n);
+ ... when any
+ i at p1(..., n, ...)
+ S
+
+ at t depends on s && patch && !context && !org && !report@
+local idexpression n;
+position r.p2;
+@@
+
+- of_node_put at p2(n);
+
+// ----------------------------------------------------------------------------
+
+ at t_context depends on s && !patch && (context || org || report)@
+local idexpression n;
+position r.p2;
+position j0;
+@@
+
+*  of_node_put at j0@p2(n);
+
+// ----------------------------------------------------------------------------
+
+ at script:python t_org depends on org@
+j0 << t_context.j0;
+@@
+
+msg = "ERROR: probable double put."
+coccilib.org.print_todo(j0[0], msg)
+
+// ----------------------------------------------------------------------------
+
+@script:python t_report depends on report@
+j0 << t_context.j0;
+@@
+
+msg = "ERROR: probable double put."
+coccilib.report.print_report(j0[0], msg)
+
