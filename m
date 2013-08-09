From: linux@rasmusvillemoes.dk (Rasmus Villemoes)
Date: Fri,  9 Aug 2013 16:15:46 +0000
Subject: [Cocci] [PATCH/RFC] coccinelle: replace 0/1 with false/true in
	functions returning bool
Message-ID: <1376064946-20232-1-git-send-email-linux@rasmusvillemoes.dk>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

This semantic patch replaces "return {0,1};" with "return
{false,true};" in functions returning bool. There doesn't seem to be
any false positives, but some whitespace mangling is happening, for
example:

diff -u -p a/block/blk-throttle.c b/block/blk-throttle.c
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -734,9 +734,7 @@ static inline void throtl_extend_slice(s
 static bool throtl_slice_used(struct throtl_grp *tg, bool rw)
 {
 	if (time_in_range(jiffies, tg->slice_start[rw], tg->slice_end[rw]))
-		return 0;
-
-	return 1;
+		return false;return true;
 }

Is there a way to prevent this, or is this the kind of thing which
must be handled in post-processing?

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 scripts/coccinelle/misc/boolreturn.cocci |   51 ++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 scripts/coccinelle/misc/boolreturn.cocci

diff --git a/scripts/coccinelle/misc/boolreturn.cocci b/scripts/coccinelle/misc/boolreturn.cocci
new file mode 100644
index 0000000..e6ece0d
--- /dev/null
+++ b/scripts/coccinelle/misc/boolreturn.cocci
@@ -0,0 +1,51 @@
+/// Return statements in functions returning bool should use
+/// true/false instead of 1/0.
+//
+
+virtual patch
+virtual report
+
+
+ at r1 depends on patch@
+identifier fn;
+typedef bool;
+symbol false;
+symbol true;
+@@
+
+bool fn ( ... )
+{
+...
+(
+-	return 0;
++	return false;
+|
+-	return 1;
++	return true;
+)
+...
+}
+
+ at r2 depends on !patch@
+identifier fn;
+position p;
+@@
+
+bool fn ( ... )
+{
+	...
+(
+*	return 0 at p ;
+|
+*	return 1 at p ;
+)
+	...
+}
+
+
+ at script:python depends on report@
+p << r2.p;
+fn << r2.fn;
+@@
+
+coccilib.report.print_report(p[0], "WARNING: return of 0/1 in function '%s' with return type bool" % fn)
-- 
1.7.9.5
