From: tipecaml@gmail.com (Cyril Roelandt)
Date: Sun, 11 Nov 2012 21:49:29 +0100
Subject: [Cocci] [PATCH 1/3] Coccinelle: Add api/d_find_alias.cocci.
In-Reply-To: <1352666971-13551-1-git-send-email-tipecaml@gmail.com>
References: <1352666971-13551-1-git-send-email-tipecaml@gmail.com>
Message-ID: <1352666971-13551-2-git-send-email-tipecaml@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Ensure that calls to d_find_alias() have a corresponding dput().

Signed-off-by: Cyril Roelandt <tipecaml@gmail.com>
---
 scripts/coccinelle/api/d_find_alias.cocci |   80 +++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 scripts/coccinelle/api/d_find_alias.cocci

diff --git a/scripts/coccinelle/api/d_find_alias.cocci b/scripts/coccinelle/api/d_find_alias.cocci
new file mode 100644
index 0000000..639eec7
--- /dev/null
+++ b/scripts/coccinelle/api/d_find_alias.cocci
@@ -0,0 +1,80 @@
+/// Make sure calls to d_find_alias() have a corresponding call to dput().
+//
+// Keywords: d_find_alias, dput
+//
+// Confidence: Moderate
+// URL: http://coccinelle.lip6.fr/
+// Options: -include_headers
+
+virtual context
+virtual org
+virtual patch
+virtual report
+
+ at r exists@
+local idexpression struct dentry *dent;
+expression E, E1;
+statement S1, S2;
+position p1, p2;
+@@
+(
+	if (!(dent at p1 = d_find_alias(...))) S1
+|
+	dent at p1 = d_find_alias(...)
+)
+
+<...when != dput(dent)
+    when != if (...) { <+... dput(dent) ...+> }
+    when != true !dent || ...
+    when != dent = E
+    when != E = dent
+if (!dent || ...) S2
+...>
+(
+	return <+...dent...+>;
+|
+	return @p2 ...;
+|
+	dent at p2 = E1;
+|
+	E1 = dent;
+)
+
+ at depends on context@
+local idexpression struct dentry *r.dent;
+position r.p1,r.p2;
+@@
+* dent at p1 = ...
+  ...
+(
+* return at p2 ...;
+|
+* dent at p2
+)
+
+
+ at script:python depends on org@
+p1 << r.p1;
+p2 << r.p2;
+@@
+cocci.print_main("Missing call to dput()",p1)
+cocci.print_secs("",p2)
+
+ at depends on patch@
+local idexpression struct dentry *r.dent;
+position r.p2;
+@@
+(
++ dput(dent);
+  return @p2 ...;
+|
++ dput(dent);
+  dent at p2 = ...;
+)
+
+ at script:python depends on report@
+p1 << r.p1;
+p2 << r.p2;
+@@
+msg = "Missing call to dput()@line %s."
+coccilib.report.print_report(p1[0], msg % (p2[0].line))
-- 
1.7.10.4
