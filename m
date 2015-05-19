From: d.granat@samsung.com (Daniel Granat)
Date: Tue, 19 May 2015 13:58:49 +0200
Subject: [Cocci] [PATCH v3] Added tables i2c_device_id and
 platform_device_id for checking. Extend checking on tables containing
 structures which are initialized without specifying member name.
In-Reply-To: <1425043313-15844-1-git-send-email-d.granat@samsung.com>
References: <1425043313-15844-1-git-send-email-d.granat@samsung.com>
Message-ID: <1432036729-20809-1-git-send-email-d.granat@samsung.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Signed-off-by: Daniel Granat <d.granat@samsung.com>
---
 scripts/coccinelle/misc/of_table.cocci | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/scripts/coccinelle/misc/of_table.cocci b/scripts/coccinelle/misc/of_table.cocci
index 3c93404..74f7dbb 100644
--- a/scripts/coccinelle/misc/of_table.cocci
+++ b/scripts/coccinelle/misc/of_table.cocci
@@ -1,6 +1,6 @@
-/// Make sure of_device_id tables are NULL terminated
+/// Make sure (of_device_id | i2c_device_id | platform_device_id) tables are NULL terminated
 //
-// Keywords: of_table
+// Keywords: of_table i2c_table platform_table
 // Confidence: Medium
 // Options: --include-headers
 
@@ -13,7 +13,7 @@ virtual report
 identifier var, arr;
 expression E;
 @@
-struct of_device_id arr[] = {
+struct \(of_device_id \| i2c_device_id \| platform_device_id\) arr[] = {
 	...,
 	{
 	.var = E,
@@ -24,7 +24,8 @@ struct of_device_id arr[] = {
 identifier var, arr;
 expression E;
 @@
-struct of_device_id arr[] = {
+(
+struct \(of_device_id \| i2c_device_id \| platform_device_id\) arr[] = {
 	...,
 	{
 	.var = E,
@@ -32,19 +33,34 @@ struct of_device_id arr[] = {
 +	},
 +	{ }
 };
+|
+struct \(of_device_id \| i2c_device_id \| platform_device_id\) arr[] = {
+	...,
+	{ ..., E, ... },
++	{ },
+};
+)
 
 @r depends on org || report@
 position p1;
 identifier var, arr;
 expression E;
 @@
-struct of_device_id arr[] = {
+(
+struct \(of_device_id \| i2c_device_id \| platform_device_id\) arr[] = {
 	...,
 	{
 	.var = E,
 	}
 	@p1
 };
+|
+struct \(of_device_id \| i2c_device_id \| platform_device_id\) arr[] = {
+	...,
+	{ ..., E, ... },
+	@p1
+};
+)
 
 @script:python depends on org@
 p1 << r.p1;
-- 
1.9.1
