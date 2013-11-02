From: josh@joshtriplett.org (Josh Triplett)
Date: Sat, 2 Nov 2013 07:32:37 -0700
Subject: [Cocci] [PATCH] coccinelle: Add a script to find and remove
 unnecessary ifs with no body
Message-ID: <20131102143236.GA18084@leaf>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

This script matches code like:

if (foo) {}

and either eliminates it (if foo has no side effects) or replaces it
with foo (if foo has side effects).

Works perfectly in report mode; the results of patch mode are
semantically correct but may still benefit from further simplification.

Signed-off-by: Josh Triplett <josh@joshtriplett.org>
---
 scripts/coccinelle/misc/unnecessary-if.cocci | 40 ++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 scripts/coccinelle/misc/unnecessary-if.cocci

diff --git a/scripts/coccinelle/misc/unnecessary-if.cocci b/scripts/coccinelle/misc/unnecessary-if.cocci
new file mode 100644
index 0000000..7ed721f
--- /dev/null
+++ b/scripts/coccinelle/misc/unnecessary-if.cocci
@@ -0,0 +1,40 @@
+/// Remove unnecessary ifs with no statements.
+//
+// Confidence: High
+// Options: --no-includes --include-headers
+
+virtual patch
+virtual report
+virtual context
+
+ at r1 depends on patch@
+expression E, E2, f;
+@@
+(
+- if (
+      <+... \(f(...)\|++E\|--E\|E++\|E--\|E=E2\) ...+>
+- ) {}
++ ;
+|
+- if (E) {}
+)
+
+ at r2 depends on report || context@
+expression E, E2, f;
+position p;
+@@
+(
+- if at p (
+      <+... \(f(...)\|++E\|--E\|E++\|E--\|E=E2\) ...+>
+- ) {}
++ ;
+|
+- if at p (E) {}
+)
+
+ at script:python depends on report@
+p << r2.p;
+@@
+
+msg = "WARNING: Unnecessary if with no body."
+coccilib.report.print_report(p[0], msg)
-- 
1.8.4.2
