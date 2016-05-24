From: vaishali.thakkar@oracle.com (Vaishali Thakkar)
Date: Tue, 24 May 2016 09:49:17 +0530
Subject: [Cocci] [PATCH v3] Coccinelle: noderef: Add new rules and correct
	the old rule
Message-ID: <1464063557-5176-1-git-send-email-vaishali.thakkar@oracle.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Add new rules to detect the cases where sizeof is used in
function calls as a argument.

Also, for the patch mode third rule should behave same as
second rule with arguments reversed. So, change that as well.

Signed-off-by: Vaishali Thakkar <vaishali.thakkar@oracle.com>
---
Changes since v2:
	- Add rules for function calls. This will behave as
          more general rules and covers cases which were
          covered by the rule in previous versions of the patch
	- Change subject and commit log accordingly.
Changes since v1:
	- Declare i as an expression instead of identifier to
	  cover more cases
---
 scripts/coccinelle/misc/noderef.cocci | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/scripts/coccinelle/misc/noderef.cocci b/scripts/coccinelle/misc/noderef.cocci
index 80a831c..007f0de 100644
--- a/scripts/coccinelle/misc/noderef.cocci
+++ b/scripts/coccinelle/misc/noderef.cocci
@@ -16,6 +16,7 @@ virtual patch
 @depends on patch@
 expression *x;
 expression f;
+expression i;
 type T;
 @@
 
@@ -30,15 +31,26 @@ f(...,(T)(x),...,sizeof(
 + *x
    ),...)
 |
-f(...,sizeof(x),...,(T)(
+f(...,sizeof(
+- x
++ *x
+   ),...,(T)(x),...)
+|
+f(...,(T)(x),...,i*sizeof(
 - x
 + *x
    ),...)
+|
+f(...,i*sizeof(
+- x
++ *x
+   ),...,(T)(x),...)
 )
 
 @r depends on !patch@
 expression *x;
 expression f;
+expression i;
 position p;
 type T;
 @@
@@ -49,6 +61,10 @@ type T;
 *f(...,(T)(x),...,sizeof at p(x),...)
 |
 *f(...,sizeof at p(x),...,(T)(x),...)
+|
+*f(...,(T)(x),...,i*sizeof at p(x),...)
+|
+*f(...,i*sizeof at p(x),...,(T)(x),...)
 )
 
 @script:python depends on org@
-- 
2.1.4
