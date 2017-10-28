From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Sun, 29 Oct 2017 01:43:09 +0200
Subject: [Cocci] [PATCH] Coccinelle: use false positive annotation
Message-ID: <1509234189-26916-1-git-send-email-Julia.Lawall@lip6.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

/// is to describe the semantic patch, while //# indicates reasons
for false positives.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 scripts/coccinelle/misc/ifcol.cocci |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/coccinelle/misc/ifcol.cocci b/scripts/coccinelle/misc/ifcol.cocci
index d0d00ef..30b248b 100644
--- a/scripts/coccinelle/misc/ifcol.cocci
+++ b/scripts/coccinelle/misc/ifcol.cocci
@@ -3,9 +3,9 @@
 /// Sometimes, code after an if that is indented is actually intended to be
 /// part of the if branch.
 ///
-/// This has a high rate of false positives, because Coccinelle's column
-/// calculation does not distinguish between spaces and tabs, so code that
-/// is not visually aligned may be considered to be in the same column.
+//# This has a high rate of false positives, because Coccinelle's column
+//# calculation does not distinguish between spaces and tabs, so code that
+//# is not visually aligned may be considered to be in the same column.
 ///
 // Confidence: Low
 // Copyright: (C) 2010 Nicolas Palix, DIKU.  GPLv2.
