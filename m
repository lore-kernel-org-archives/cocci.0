From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Sun, 27 Apr 2014 02:29:46 +0200
Subject: [Cocci] [PATCH 1/1] scripts/coccinelle: use BIT() macro if possible
Message-ID: <1398558586-28931-1-git-send-email-javier@dowhile0.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Using the BIT() macro instead of manually shifting bits
makes the code less error prone and also more readable.

Signed-off-by: Javier Martinez Canillas <javier@dowhile0.org>
---

An example of the patches that can be obtained with this spatch:

http://www.mail-archive.com/linux-gpio at vger.kernel.org/msg02722.html

 scripts/coccinelle/api/bit.cocci | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 scripts/coccinelle/api/bit.cocci

diff --git a/scripts/coccinelle/api/bit.cocci b/scripts/coccinelle/api/bit.cocci
new file mode 100644
index 0000000..a5df73a
--- /dev/null
+++ b/scripts/coccinelle/api/bit.cocci
@@ -0,0 +1,25 @@
+// Use the macro BIT() macro if possible
+//
+// Confidence: High
+// Copyright (C) 2014 Javier Martinez Canillas.  GPLv2.
+// URL: http://coccinelle.lip6.fr/
+// Options: --include-headers
+
+ at hasbitops@
+@@
+
+#include <linux/bitops.h>
+
+ at depends on hasbitops@
+expression E;
+@@
+
+- 1 << E
++ BIT(E)
+
+@depends on hasbitops@
+expression E;
+@@
+
+- BIT((E))
++ BIT(E)
-- 
1.9.1
