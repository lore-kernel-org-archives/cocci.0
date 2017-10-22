From: aishpant@gmail.com (Aishwarya Pant)
Date: Sun, 22 Oct 2017 17:41:56 +0530
Subject: [Cocci] [PATCH v2] coccinelle: boolconv: improve script to handle
	more cases
Message-ID: <20171022121156.f5r3hthijlseqlr7@aishwarya>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Given expressions A, B and a binary operator op, the current script checks for
cases where
	A op B ? true : false can be replaced by A op B

This can be extended to handle the other case where
	A op B ? false : true can be replaced by !(A op B)

Moreover we can use the binary operator type to catch all desirable comparisons
in one go instead of writing them down.

Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
Acked-by: Julia Lawall <julia.lawall@lip6.fr>
---
Changes in v2:
Re-send after addding the appropriate mailing lists

scripts/coccinelle/misc/boolconv.cocci | 43 ++++++++--------------------------
 1 file changed, 10 insertions(+), 33 deletions(-)

diff --git a/scripts/coccinelle/misc/boolconv.cocci b/scripts/coccinelle/misc/boolconv.cocci
index 33c464d6bc71..9b32b5fd31d4 100644
--- a/scripts/coccinelle/misc/boolconv.cocci
+++ b/scripts/coccinelle/misc/boolconv.cocci
@@ -16,27 +16,19 @@ virtual report
 
 @depends on patch@
 expression A, B;
+binary operator op = {==,!=,>,<,>=,<=,&&,||};
 symbol true, false;
 @@
 
 (
-  A == B
-|
-  A != B
-|
-  A > B
-|
-  A < B
-|
-  A >= B
-|
-  A <= B
-|
-  A && B
+  A op B
+- ? true : false
 |
-  A || B
++ !(
+  A op B
++ )
+- ? false : true
 )
-- ? true : false
 
 //----------------------------------------------------------
 //  For context mode
@@ -44,28 +36,13 @@ symbol true, false;
 
 @r depends on !patch@
 expression A, B;
+binary operator op = {==,!=,>,<,>=,<=,&&,||};
 symbol true, false;
 position p;
 @@
 
-(
-  A == B
-|
-  A != B
-|
-  A > B
-|
-  A < B
-|
-  A >= B
-|
-  A <= B
-|
-  A && B
-|
-  A || B
-)
-* ? true : false at p
+  A op B
+* ? \(true\|false\) : \(false at p\|true@p\)
 
 //----------------------------------------------------------
 //  For org mode
-- 
2.11.0
