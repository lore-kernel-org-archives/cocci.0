From: fabf@skynet.be (Fabian Frederick)
Date: Tue, 25 Apr 2017 20:11:16 +0200
Subject: [Cocci] [PATCH 1/1 linux-next] scripts/coccinelle/misc: Warn about
	NULL check on kmap()
Message-ID: <20170425181116.2499-1-fabf@skynet.be>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

This script removes NULL check on kmap() and all process involved
(OOM message ...)

Thanks to Jan Kara for explanations.

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 scripts/coccinelle/misc/kmap.cocci | 43 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 scripts/coccinelle/misc/kmap.cocci

diff --git a/scripts/coccinelle/misc/kmap.cocci b/scripts/coccinelle/misc/kmap.cocci
new file mode 100644
index 0000000..9ae4a6e
--- /dev/null
+++ b/scripts/coccinelle/misc/kmap.cocci
@@ -0,0 +1,43 @@
+/// kmap never fails; remove NULL test case.
+///
+// Copyright: (C) 2017 Fabian Frederick.  GPLv2.
+// Comments: -
+// Options: --no-includes --include-headers
+
+virtual patch
+virtual org
+virtual report
+virtual context
+
+ at r2 depends on patch@
+expression E;
+position p;
+@@
+
+E = kmap(...);
+- if (!E) {
+- ...
+- }
+
+ at r depends on context || report || org @
+expression E;
+position p;
+@@
+
+* E = kmap(...);
+* if (@p!E) {
+* ...
+* }
+
+ at script:python depends on org@
+p << r.p;
+@@
+
+cocci.print_main("kmap() can't fail, NULL check and special process is not needed", p)
+
+@script:python depends on report@
+p << r.p;
+@@
+
+msg = "WARNING: NULL check on kmap() result is not needed."
+coccilib.report.print_report(p[0], msg)
-- 
2.9.3
