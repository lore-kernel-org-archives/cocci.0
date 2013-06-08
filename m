From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Sat,  8 Jun 2013 18:21:42 +0200
Subject: [Cocci] [PATCH] scripts/coccinelle: check for field address
	argument to kfree
Message-ID: <1370708502-21907-1-git-send-email-Julia.Lawall@lip6.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

From: Julia Lawall <Julia.Lawall@lip6.fr>

The argument to kfree should not be the address of a structure field.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 scripts/coccinelle/free/kfreeaddr.cocci |   32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/scripts/coccinelle/free/kfreeaddr.cocci b/scripts/coccinelle/free/kfreeaddr.cocci
new file mode 100644
index 0000000..662e997
--- /dev/null
+++ b/scripts/coccinelle/free/kfreeaddr.cocci
@@ -0,0 +1,32 @@
+/// Free of a structure field
+///
+// Confidence: High
+// Copyright: (C) 2013 Julia Lawall, INRIA/LIP6.  GPLv2.
+// URL: http://coccinelle.lip6.fr/
+// Comments:
+// Options: -no_includes -include_headers
+
+virtual org
+virtual report
+virtual context
+
+ at r depends on context || report || org @
+expression e;
+identifier f;
+position p;
+@@
+
+* kfree at p(&e->f)
+
+ at script:python depends on org@
+p << r.p;
+@@
+
+cocci.print_main("kfree",p)
+
+@script:python depends on report@
+p << r.p;
+@@
+
+msg = "ERROR: kfree of structure field"
+coccilib.report.print_report(p[0],msg)
