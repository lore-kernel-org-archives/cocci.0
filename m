From: hofrat@osadl.org (Nicholas Mc Guire)
Date: Tue,  5 May 2015 12:12:41 +0200
Subject: [Cocci] [PATCH RFC] Coccinelle: Check for return not matching
	function signature
Message-ID: <1430820761-28122-1-git-send-email-hofrat@osadl.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Check if the signature of a function and the return value type match. This
is currently not the case in more than 2300 functions. In many cases this
mismatch will have no side-effects but in some cases it may lead to hard
to locate problems - and for readability and code understanding it is also
helpful when types match.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

Did not see any false positives in a scan of 4.0-rc2 (but did not check
all results either).

Not sure if scripts/coccinelle/tests/ is the right place for this
It did not seem to trigger any false positives but in some cases (notably
void pointers) the warning might be unnecessary.

The output is a bit lengthy - not sure if that is too much but it seemed
useful to me to see the non-matching types explicitly in the warning
message.

Patch is against 4.1-rc2 (localversion-next is -next-20150505)

 .../coccinelle/tests/signature_matches_ret.cocci   |   31 ++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 scripts/coccinelle/tests/signature_matches_ret.cocci

diff --git a/scripts/coccinelle/tests/signature_matches_ret.cocci b/scripts/coccinelle/tests/signature_matches_ret.cocci
new file mode 100644
index 0000000..2dd1086
--- /dev/null
+++ b/scripts/coccinelle/tests/signature_matches_ret.cocci
@@ -0,0 +1,31 @@
+// Find functions where return type and signature do not match
+// Comments:
+// Options: --no-includes --include-headers
+
+virtual context
+virtual org
+virtual report
+
+ at match@
+identifier f,ret;
+position p;
+type T1,T2;
+@@
+
+T1 f(...) {
+ T2 ret;
+<+...
+* return@p ret
+;
+...+>
+}
+
+ at script:python@
+p << match.p;
+fn << match.f;
+T1 << match.T1;
+T2 << match.T2;
+@@
+
+if T1 != T2:
+   print "%s:%s,%s WARNING: return of wrong type (%s != %s)" % (p[0].file,fn,p[0].line,T1,T2)
-- 
1.7.10.4
