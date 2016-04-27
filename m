From: vaishali.thakkar@oracle.com (Vaishali Thakkar)
Date: Wed, 27 Apr 2016 17:11:29 +0530
Subject: [Cocci] [PATCH] Coccinelle: noderef: Add a rule and correct the old
	rule
Message-ID: <1461757289-21035-1-git-send-email-vaishali.thakkar@oracle.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Add a new rule to detect the cases where sizeof is used as a
subexpression rather than a top level argument.

Also, for the patch mode third rule should behave same as
second rule with arguments reversed. So, change that as well.

Signed-off-by: Vaishali Thakkar <vaishali.thakkar@oracle.com>
---
 scripts/coccinelle/misc/noderef.cocci | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/scripts/coccinelle/misc/noderef.cocci b/scripts/coccinelle/misc/noderef.cocci
index 80a831c..9991ee9 100644
--- a/scripts/coccinelle/misc/noderef.cocci
+++ b/scripts/coccinelle/misc/noderef.cocci
@@ -16,6 +16,7 @@ virtual patch
 @depends on patch@
 expression *x;
 expression f;
+identifier i;
 type T;
 @@
 
@@ -30,7 +31,12 @@ f(...,(T)(x),...,sizeof(
 + *x
    ),...)
 |
-f(...,sizeof(x),...,(T)(
+f(...,sizeof(
+- x
++ *x
+   ),...,(T)(x),...)
+|
+x = f(...,i*sizeof(
 - x
 + *x
    ),...)
@@ -39,6 +45,7 @@ f(...,sizeof(x),...,(T)(
 @r depends on !patch@
 expression *x;
 expression f;
+identifier i;
 position p;
 type T;
 @@
@@ -49,6 +56,8 @@ type T;
 *f(...,(T)(x),...,sizeof at p(x),...)
 |
 *f(...,sizeof at p(x),...,(T)(x),...)
+|
+*x = f(...,i*sizeof at p(x),...)
 )
 
 @script:python depends on org@
-- 
2.1.4
