From: keescook@chromium.org (Kees Cook)
Date: Tue, 26 Apr 2016 15:24:42 -0700
Subject: [Cocci] [PATCH] coccicheck: add a test for repeat copy_from_user
Message-ID: <20160426222442.GA8104@www.outflux.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

This is usually a sign of a resized request. This adds a check for
potential races or confusions. The check isn't 100% accurate, so it
needs some manual review.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 scripts/coccinelle/tests/reusercopy.cocci | 36 +++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 scripts/coccinelle/tests/reusercopy.cocci

diff --git a/scripts/coccinelle/tests/reusercopy.cocci b/scripts/coccinelle/tests/reusercopy.cocci
new file mode 100644
index 000000000000..53645de8ae95
--- /dev/null
+++ b/scripts/coccinelle/tests/reusercopy.cocci
@@ -0,0 +1,36 @@
+/// Recopying from the same user buffer frequently indicates a pattern of
+/// Reading a size header, allocating, and then re-reading an entire
+/// structure. If the structure's size is not re-validated, this can lead
+/// to structure or data size confusions.
+///
+// Confidence: Moderate
+// Copyright: (C) 2016 Kees Cook, Google. License: GPLv2.
+// URL: http://coccinelle.lip6.fr/
+// Comments:
+// Options: -no_includes -include_headers
+
+virtual report
+virtual org
+
+ at cfu_twice@
+position p;
+identifier src;
+expression dest1, dest2, size1, size2, offset;
+@@
+
+*copy_from_user(dest1, src, size1)
+ ... when != src = offset
+     when != src += offset
+*copy_from_user at p(dest2, src, size2)
+
+ at script:python depends on org@
+p << cfu_twice.p;
+@@
+
+cocci.print_main("potentially dangerous second copy_from_user()",p)
+
+@script:python depends on report@
+p << cfu_twice.p;
+@@
+
+coccilib.report.print_report(p[0],"potentially dangerous second copy_from_user()")
-- 
2.6.3


-- 
Kees Cook
Chrome OS & Brillo Security
