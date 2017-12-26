From: himanshujha199640@gmail.com (Himanshu Jha)
Date: Wed, 27 Dec 2017 03:10:10 +0530
Subject: [Cocci] [PATCH v2] Coccinelle: kzalloc-simple: Add all zero
	allocating functions
Message-ID: <1514324410-14561-1-git-send-email-himanshujha199640@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

There are many instances where memory is allocated using regular
allocator
functions immediately followed by setting the allocated memory
to 0 value using memset.

We already have zero memory allocator functions to set the memory to
0 value instead of manually setting it using memset.

Therefore, use zero memory allocating functions instead of regular
memory allocators followed by memset 0 to remove redundant memset and
make the code more cleaner and also reduce the code size.

Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
---

v2:
   -fix typo in copyright.
   -move all the (T *) disjunction cases before (T) as (T) matches any cast
    at all including (T *) ones which is not desirable.

 scripts/coccinelle/api/alloc/kzalloc-simple.cocci | 373 +++++++++++++++++++++-
 1 file changed, 368 insertions(+), 5 deletions(-)

diff --git a/scripts/coccinelle/api/alloc/kzalloc-simple.cocci b/scripts/coccinelle/api/alloc/kzalloc-simple.cocci
index 52c55e4..d08d526 100644
--- a/scripts/coccinelle/api/alloc/kzalloc-simple.cocci
+++ b/scripts/coccinelle/api/alloc/kzalloc-simple.cocci
@@ -1,5 +1,5 @@
 ///
-/// Use kzalloc rather than kmalloc followed by memset with 0
+/// Use zeroing allocator rather than allocator followed by memset with 0
 ///
 /// This considers some simple cases that are common and easy to validate
 /// Note in particular that there are no ...s in the rule, so all of the
@@ -8,6 +8,7 @@
 // Confidence: High
 // Copyright: (C) 2009-2010 Julia Lawall, Nicolas Palix, DIKU.  GPLv2.
 // Copyright: (C) 2009-2010 Gilles Muller, INRIA/LiP6.  GPLv2.
+// Copyright: (C) 2017 Himanshu Jha GPLv2.
 // URL: http://coccinelle.lip6.fr/rules/kzalloc.html
 // Options: --no-includes --include-headers
 //
@@ -28,11 +29,14 @@ virtual report
 @depends on context@
 type T, T2;
 expression x;
-expression E1,E2;
+expression E1;
 statement S;
 @@
 
-* x = (T)kmalloc(E1,E2);
+* x = (T)\(kmalloc(E1, ...)\|vmalloc(E1)\|dma_alloc_coherent(...,E1,...)\|
+  kmalloc_node(E1, ...)\|kmem_cache_alloc(...)\|kmem_alloc(E1, ...)\|
+  devm_kmalloc(...,E1,...)\|kvmalloc(E1, ...)\|pci_alloc_consistent(...,E1,...)\|
+  kvmalloc_node(E1,...)\);
   if ((x==NULL) || ...) S
 * memset((T2)x,0,E1);
 
@@ -43,12 +47,101 @@ statement S;
 @depends on patch@
 type T, T2;
 expression x;
-expression E1,E2;
+expression E1,E2,E3,E4;
 statement S;
 @@
 
-- x = (T)kmalloc(E1,E2);
+(
+- x = kmalloc(E1,E2);
++ x = kzalloc(E1,E2);
+|
+- x = (T *)kmalloc(E1,E2);
 + x = kzalloc(E1,E2);
+|
+- x = (T)kmalloc(E1,E2);
++ x = (T)kzalloc(E1,E2);
+|
+- x = vmalloc(E1);
++ x = vzalloc(E1);
+|
+- x = (T *)vmalloc(E1);
++ x = vzalloc(E1);
+|
+- x = (T)vmalloc(E1);
++ x = (T)vzalloc(E1);
+|
+- x = dma_alloc_coherent(E2,E1,E3,E4);
++ x = dma_zalloc_coherent(E2,E1,E3,E4);
+|
+- x = (T *)dma_alloc_coherent(E2,E1,E3,E4);
++ x = dma_zalloc_coherent(E2,E1,E3,E4);
+|
+- x = (T)dma_alloc_coherent(E2,E1,E3,E4);
++ x = (T)dma_zalloc_coherent(E2,E1,E3,E4);
+|
+- x = kmalloc_node(E1,E2,E3);
++ x = kzalloc_node(E1,E2,E3);
+|
+- x = (T *)kmalloc_node(E1,E2,E3);
++ x = kzalloc_node(E1,E2,E3);
+|
+- x = (T)kmalloc_node(E1,E2,E3);
++ x = (T)kzalloc_node(E1,E2,E3);
+|
+- x = kmem_cache_alloc(E3,E4);
++ x = kmem_cache_zalloc(E3,E4);
+|
+- x = (T *)kmem_cache_alloc(E3,E4);
++ x = kmem_cache_zalloc(E3,E4);
+|
+- x = (T)kmem_cache_alloc(E3,E4);
++ x = (T)kmem_cache_zalloc(E3,E4);
+|
+- x = kmem_alloc(E1,E2);
++ x = kmem_zalloc(E1,E2);
+|
+- x = (T *)kmem_alloc(E1,E2);
++ x = kmem_zalloc(E1,E2);
+|
+- x = (T)kmem_alloc(E1,E2);
++ x = (T)kmem_zalloc(E1,E2);
+|
+- x = devm_kmalloc(E2,E1,E3);
++ x = devm_kzalloc(E2,E1,E3);
+|
+- x = (T *)devm_kmalloc(E2,E1,E3);
++ x = devm_kzalloc(E2,E1,E3);
+|
+- x = (T)devm_kmalloc(E2,E1,E3);
++ x = (T)devm_kzalloc(E2,E1,E3);
+|
+- x = kvmalloc(E1,E2);
++ x = kvzalloc(E1,E2);
+|
+- x = (T *)kvmalloc(E1,E2);
++ x = kvzalloc(E1,E2);
+|
+- x = (T)kvmalloc(E1,E2);
++ x = (T)kvzalloc(E1,E2);
+|
+- x = pci_alloc_consistent(E2,E1,E3);
++ x = pci_zalloc_consistent(E2,E1,E3);
+|
+- x = (T *)pci_alloc_consistent(E2,E1,E3);
++ x = pci_zalloc_consistent(E2,E1,E3);
+|
+- x = (T)pci_alloc_consistent(E2,E1,E3);
++ x = (T)pci_zalloc_consistent(E2,E1,E3);
+|
+- x = kvmalloc_node(E1,E2,E3);
++ x = kvzalloc_node(E1,E2,E3);
+|
+- x = (T *)kvmalloc_node(E1,E2,E3);
++ x = kvzalloc_node(E1,E2,E3);
+|
+- x = (T)kvmalloc_node(E1,E2,E3);
++ x = (T)kvzalloc_node(E1,E2,E3);
+)
   if ((x==NULL) || ...) S
 - memset((T2)x,0,E1);
 
@@ -84,3 +177,273 @@ x << r.x;
 
 msg="WARNING: kzalloc should be used for %s, instead of kmalloc/memset" % (x)
 coccilib.report.print_report(p[0], msg)
+
+//-----------------------------------------------------------------
+ at r1 depends on org || report@
+type T, T2;
+expression x;
+expression E1;
+statement S;
+position p;
+@@
+
+ x = (T)vmalloc at p(E1);
+ if ((x==NULL) || ...) S
+ memset((T2)x,0,E1);
+
+ at script:python depends on org@
+p << r1.p;
+x << r1.x;
+@@
+
+msg="%s" % (x)
+msg_safe=msg.replace("[","@(").replace("]",")")
+coccilib.org.print_todo(p[0], msg_safe)
+
+ at script:python depends on report@
+p << r1.p;
+x << r1.x;
+@@
+
+msg="WARNING: vzalloc should be used for %s, instead of vmalloc/memset" % (x)
+coccilib.report.print_report(p[0], msg)
+
+//-----------------------------------------------------------------
+ at r2 depends on org || report@
+type T, T2;
+expression x;
+expression E1,E2,E3,E4;
+statement S;
+position p;
+@@
+
+ x = (T)dma_alloc_coherent at p(E2,E1,E3,E4);
+ if ((x==NULL) || ...) S
+ memset((T2)x,0,E1);
+
+ at script:python depends on org@
+p << r2.p;
+x << r2.x;
+@@
+
+msg="%s" % (x)
+msg_safe=msg.replace("[","@(").replace("]",")")
+coccilib.org.print_todo(p[0], msg_safe)
+
+ at script:python depends on report@
+p << r2.p;
+x << r2.x;
+@@
+
+msg="WARNING: dma_zalloc_coherent should be used for %s, instead of dma_alloc_coherent/memset" % (x)
+coccilib.report.print_report(p[0], msg)
+
+//-----------------------------------------------------------------
+ at r3 depends on org || report@
+type T, T2;
+expression x;
+expression E1,E2,E3;
+statement S;
+position p;
+@@
+
+ x = (T)kmalloc_node at p(E1,E2,E3);
+ if ((x==NULL) || ...) S
+ memset((T2)x,0,E1);
+
+ at script:python depends on org@
+p << r3.p;
+x << r3.x;
+@@
+
+msg="%s" % (x)
+msg_safe=msg.replace("[","@(").replace("]",")")
+coccilib.org.print_todo(p[0], msg_safe)
+
+ at script:python depends on report@
+p << r3.p;
+x << r3.x;
+@@
+
+msg="WARNING: kzalloc_node should be used for %s, instead of kmalloc_node/memset" % (x)
+coccilib.report.print_report(p[0], msg)
+
+//-----------------------------------------------------------------
+ at r4 depends on org || report@
+type T, T2;
+expression x;
+expression E1,E2,E3;
+statement S;
+position p;
+@@
+
+ x = (T)kmem_cache_alloc at p(E2,E3);
+ if ((x==NULL) || ...) S
+ memset((T2)x,0,E1);
+
+ at script:python depends on org@
+p << r4.p;
+x << r4.x;
+@@
+
+msg="%s" % (x)
+msg_safe=msg.replace("[","@(").replace("]",")")
+coccilib.org.print_todo(p[0], msg_safe)
+
+ at script:python depends on report@
+p << r4.p;
+x << r4.x;
+@@
+
+msg="WARNING: kmem_cache_zalloc should be used for %s, instead of kmem_cache_alloc/memset" % (x)
+coccilib.report.print_report(p[0], msg)
+
+//-----------------------------------------------------------------
+ at r5 depends on org || report@
+type T, T2;
+expression x;
+expression E1,E2;
+statement S;
+position p;
+@@
+
+ x = (T)kmem_alloc at p(E1,E2);
+ if ((x==NULL) || ...) S
+ memset((T2)x,0,E1);
+
+ at script:python depends on org@
+p << r5.p;
+x << r5.x;
+@@
+
+msg="%s" % (x)
+msg_safe=msg.replace("[","@(").replace("]",")")
+coccilib.org.print_todo(p[0], msg_safe)
+
+ at script:python depends on report@
+p << r5.p;
+x << r5.x;
+@@
+
+msg="WARNING: kmem_zalloc should be used for %s, instead of kmem_alloc/memset" % (x)
+coccilib.report.print_report(p[0], msg)
+
+//-----------------------------------------------------------------
+ at r6 depends on org || report@
+type T, T2;
+expression x;
+expression E1,E2,E3;
+statement S;
+position p;
+@@
+
+ x = (T)devm_kmalloc at p(E2,E1,E3);
+ if ((x==NULL) || ...) S
+ memset((T2)x,0,E1);
+
+ at script:python depends on org@
+p << r6.p;
+x << r6.x;
+@@
+
+msg="%s" % (x)
+msg_safe=msg.replace("[","@(").replace("]",")")
+coccilib.org.print_todo(p[0], msg_safe)
+
+ at script:python depends on report@
+p << r6.p;
+x << r6.x;
+@@
+
+msg="WARNING: devm_kzalloc should be used for %s, instead of devm_kmalloc/memset" % (x)
+coccilib.report.print_report(p[0], msg)
+
+//-----------------------------------------------------------------
+ at r7 depends on org || report@
+type T, T2;
+expression x;
+expression E1,E2;
+statement S;
+position p;
+@@
+
+ x = (T)kvmalloc at p(E1,E2);
+ if ((x==NULL) || ...) S
+ memset((T2)x,0,E1);
+
+ at script:python depends on org@
+p << r7.p;
+x << r7.x;
+@@
+
+msg="%s" % (x)
+msg_safe=msg.replace("[","@(").replace("]",")")
+coccilib.org.print_todo(p[0], msg_safe)
+
+ at script:python depends on report@
+p << r7.p;
+x << r7.x;
+@@
+
+msg="WARNING: kvzalloc should be used for %s, instead of kvmalloc/memset" % (x)
+coccilib.report.print_report(p[0], msg)
+
+//-----------------------------------------------------------------
+ at r8 depends on org || report@
+type T, T2;
+expression x;
+expression E1,E2,E3;
+statement S;
+position p;
+@@
+
+ x = (T)pci_alloc_consistent at p(E2,E1,E3);
+ if ((x==NULL) || ...) S
+ memset((T2)x,0,E1);
+
+ at script:python depends on org@
+p << r8.p;
+x << r8.x;
+@@
+
+msg="%s" % (x)
+msg_safe=msg.replace("[","@(").replace("]",")")
+coccilib.org.print_todo(p[0], msg_safe)
+
+ at script:python depends on report@
+p << r8.p;
+x << r8.x;
+@@
+
+msg="WARNING: pci_zalloc_consistent should be used for %s, instead of pci_alloc_consistent/memset" % (x)
+coccilib.report.print_report(p[0], msg)
+//-----------------------------------------------------------------
+ at r9 depends on org || report@
+type T, T2;
+expression x;
+expression E1,E2,E3;
+statement S;
+position p;
+@@
+
+ x = (T)kvmalloc_node at p(E1,E2,E3);
+ if ((x==NULL) || ...) S
+ memset((T2)x,0,E1);
+
+ at script:python depends on org@
+p << r9.p;
+x << r9.x;
+@@
+
+msg="%s" % (x)
+msg_safe=msg.replace("[","@(").replace("]",")")
+coccilib.org.print_todo(p[0], msg_safe)
+
+@script:python depends on report@
+p << r9.p;
+x << r9.x;
+@@
+
+msg="WARNING: kvzalloc_node should be used for %s, instead of kvmalloc_node/memset" % (x)
+coccilib.report.print_report(p[0], msg)
+
-- 
2.7.4
