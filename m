From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 15 Aug 2013 12:30:25 +0200
Subject: [Cocci] [PATCH] scripts/coccinelle/api: remove
	devm_request_and_ioremap.cocci
Message-ID: <1376562633-16204-1-git-send-email-wsa@the-dreams.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Use of this function is discouraged in favour of
devm_ioremap_resource(). Don't advertise it.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 .../coccinelle/api/devm_request_and_ioremap.cocci  |  105 --------------------
 1 file changed, 105 deletions(-)
 delete mode 100644 scripts/coccinelle/api/devm_request_and_ioremap.cocci

diff --git a/scripts/coccinelle/api/devm_request_and_ioremap.cocci b/scripts/coccinelle/api/devm_request_and_ioremap.cocci
deleted file mode 100644
index 562ec88..0000000
--- a/scripts/coccinelle/api/devm_request_and_ioremap.cocci
+++ /dev/null
@@ -1,105 +0,0 @@
-/// Reimplement a call to devm_request_mem_region followed by a call to ioremap
-/// or ioremap_nocache by a call to devm_request_and_ioremap.
-/// Devm_request_and_ioremap was introduced in
-/// 72f8c0bfa0de64c68ee59f40eb9b2683bffffbb0.  It makes the code much more
-/// concise.
-///
-///
-// Confidence: High
-// Copyright: (C) 2011 Julia Lawall, INRIA/LIP6.  GPLv2.
-// Copyright: (C) 2011 Gilles Muller, INRIA/LiP6.  GPLv2.
-// URL: http://coccinelle.lip6.fr/
-// Comments:
-// Options: --no-includes --include-headers
-
-virtual patch
-virtual org
-virtual report
-virtual context
-
- at nm@
-expression myname;
-identifier i;
-@@
-
-struct platform_driver i = { .driver = { .name = myname } };
-
- at depends on patch@
-expression dev,res,size;
-@@
-
--if (!devm_request_mem_region(dev, res->start, size,
--                              \(res->name\|dev_name(dev)\))) {
--   ...
--   return ...;
--}
-... when != res->start
-(
--devm_ioremap(dev,res->start,size)
-+devm_request_and_ioremap(dev,res)
-|
--devm_ioremap_nocache(dev,res->start,size)
-+devm_request_and_ioremap(dev,res)
-)
-... when any
-    when != res->start
-
-// this rule is separate from the previous one, because a single file can
-// have multiple values of myname
- at depends on patch@
-expression dev,res,size;
-expression nm.myname;
-@@
-
--if (!devm_request_mem_region(dev, res->start, size,myname)) {
--   ...
--   return ...;
--}
-... when != res->start
-(
--devm_ioremap(dev,res->start,size)
-+devm_request_and_ioremap(dev,res)
-|
--devm_ioremap_nocache(dev,res->start,size)
-+devm_request_and_ioremap(dev,res)
-)
-... when any
-    when != res->start
-
-
- at pb depends on org || report || context@
-expression dev,res,size;
-expression nm.myname;
-position p1,p2;
-@@
-
-*if
-  (!devm_request_mem_region at p1(dev, res->start, size,
-                              \(res->name\|dev_name(dev)\|myname\))) {
-   ...
-   return ...;
-}
-... when != res->start
-(
-*devm_ioremap at p2(dev,res->start,size)
-|
-*devm_ioremap_nocache at p2(dev,res->start,size)
-)
-... when any
-    when != res->start
-
- at script:python depends on org@
-p1 << pb.p1;
-p2 << pb.p2;
-@@
-
-cocci.print_main("INFO: replace by devm_request_and_ioremap",p1)
-cocci.print_secs("",p2)
-
-@script:python depends on report@
-p1 << pb.p1;
-p2 << pb.p2;
-@@
-
-msg = "INFO: devm_request_mem_region followed by ioremap on line %s can be replaced by devm_request_and_ioremap" % (p2[0].line)
-coccilib.report.print_report(p1[0],msg)
-- 
1.7.10.4
