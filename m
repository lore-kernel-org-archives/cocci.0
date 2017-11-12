From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 12 Nov 2017 17:08:26 +0100 (CET)
Subject: [Cocci] [PATCH] coccinelle: flags.cocci: reorganize patterns to
 improve efficiency
Message-ID: <alpine.DEB.2.20.1711121704350.10412@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

An initial rule just matching a function call makes it possible to focus
on one all at a time, which improves performance in complex functions with
multiple locking calls.  Using a constraint expression lock2 != pre.lock1;
makes it possible to eliminate the double matching of the lock, lock
sequence.

Signed-off-by: Julia Lawall <julia.lawall@lip6.fr>

---

diff --git a/scripts/coccinelle/locks/flags.cocci b/scripts/coccinelle/locks/flags.cocci
index debd70e..33f29a5 100644
--- a/scripts/coccinelle/locks/flags.cocci
+++ b/scripts/coccinelle/locks/flags.cocci
@@ -12,9 +12,9 @@ virtual context
 virtual org
 virtual report

- at r exists@
-expression lock1,lock2,flags;
-position p1,p2;
+ at pre exists@
+expression lock1,flags;
+position p1;
 @@

 (
@@ -24,25 +24,12 @@ read_lock_irqsave at p1(lock1,flags)
 |
 write_lock_irqsave at p1(lock1,flags)
 )
-... when != flags
-(
-spin_lock_irqsave(lock1,flags)
-|
-read_lock_irqsave(lock1,flags)
-|
-write_lock_irqsave(lock1,flags)
-|
-spin_lock_irqsave at p2(lock2,flags)
-|
-read_lock_irqsave at p2(lock2,flags)
-|
-write_lock_irqsave at p2(lock2,flags)
-)

- at d exists@
-expression f <= r.flags;
-expression lock1,lock2,flags;
-position r.p1, r.p2;
+ at r exists@
+expression lock2 != pre.lock1;
+expression f <= pre.flags;
+expression pre.lock1,pre.flags;
+position pre.p1,p2;
 @@

 (
@@ -63,16 +50,16 @@ position r.p1, r.p2;

 // ----------------------------------------------------------------------

- at script:python depends on d && org@
-p1 << r.p1;
+ at script:python depends on org@
+p1 << pre.p1;
 p2 << r.p2;
 @@

 cocci.print_main("original lock",p1)
 cocci.print_secs("nested lock+irqsave that reuses flags",p2)

- at script:python depends on d && report@
-p1 << r.p1;
+@script:python depends on report@
+p1 << pre.p1;
 p2 << r.p2;
 @@
