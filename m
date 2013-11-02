From: josh@joshtriplett.org (Josh Triplett)
Date: Sat, 2 Nov 2013 08:15:01 -0700
Subject: [Cocci] [PATCHv2] coccinelle: Add a script to find unnecessary ifs
 with no body
In-Reply-To: <alpine.DEB.2.02.1311021550330.2261@hadrien>
References: <20131102143236.GA18084@leaf>
 <alpine.DEB.2.02.1311021550330.2261@hadrien>
Message-ID: <20131102151500.GW15704@leaf>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

This script finds code like this, with an unnecessary if:

if (foo) {}

Provides report mode only, since patching often eliminates conditionals
that contain TODO comments or similar.

Signed-off-by: Josh Triplett <josh@joshtriplett.org>
---

v2: Drop patch mode.

 scripts/coccinelle/misc/unnecessary-if.cocci | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 scripts/coccinelle/misc/unnecessary-if.cocci

diff --git a/scripts/coccinelle/misc/unnecessary-if.cocci b/scripts/coccinelle/misc/unnecessary-if.cocci
new file mode 100644
index 0000000..28ac895
--- /dev/null
+++ b/scripts/coccinelle/misc/unnecessary-if.cocci
@@ -0,0 +1,23 @@
+/// Find unnecessary ifs with no statements.
+//
+// Report mode only, since patch mode often deletes ifs that contain TODO
+// comments.
+//
+// Confidence: High
+// Options: --no-includes --include-headers
+
+virtual report
+virtual context
+
+ at r depends on report || context@
+expression E;
+position p;
+@@
+if at p (E) {}
+
+ at script:python depends on report@
+p << r.p;
+@@
+
+msg = "WARNING: Unnecessary if with no body."
+coccilib.report.print_report(p[0], msg)
-- 
1.8.4.2
