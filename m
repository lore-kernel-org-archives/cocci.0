From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Sun,  1 Jan 2017 16:40:30 +0100
Subject: [Cocci] [PATCH] coccinelle: check that dmi_system_id structures are
	null terminated
Message-ID: <1483285230-4214-1-git-send-email-Julia.Lawall@lip6.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Add dmi_system_id to the list of types for which top-level arrays are
checked to be null terminated.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 scripts/coccinelle/misc/of_table.cocci |   21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/scripts/coccinelle/misc/of_table.cocci b/scripts/coccinelle/misc/of_table.cocci
index 2294915..d1b666f 100644
--- a/scripts/coccinelle/misc/of_table.cocci
+++ b/scripts/coccinelle/misc/of_table.cocci
@@ -1,4 +1,5 @@
-/// Make sure (of/i2c/platform)_device_id tables are NULL terminated
+/// Make sure (of/i2c/platform)_device_id and dmi_system_id tables are
+/// NULL terminated
 //
 // Keywords: of_table i2c_table platform_table
 // Confidence: Medium
@@ -14,14 +15,16 @@ identifier var, arr;
 expression E;
 @@
 (
-struct \(of_device_id \| i2c_device_id \| platform_device_id\) arr[] = {
+struct
+  \(of_device_id\|i2c_device_id\|platform_device_id\|dmi_system_id\) arr[] = {
 	...,
 	{
 	.var = E,
 *	}
 };
 |
-struct \(of_device_id \| i2c_device_id \| platform_device_id\) arr[] = {
+struct
+  \(of_device_id\|i2c_device_id\|platform_device_id\|dmi_system_id\) arr[] = {
 	...,
 *	{ ..., E, ... },
 };
@@ -32,7 +35,8 @@ identifier var, arr;
 expression E;
 @@
 (
-struct \(of_device_id \| i2c_device_id \| platform_device_id\) arr[] = {
+struct
+  \(of_device_id\|i2c_device_id\|platform_device_id\|dmi_system_id\) arr[] = {
 	...,
 	{
 	.var = E,
@@ -41,7 +45,8 @@ struct \(of_device_id \| i2c_device_id \| platform_device_id\) arr[] = {
 +	{ }
 };
 |
-struct \(of_device_id \| i2c_device_id \| platform_device_id\) arr[] = {
+struct
+  \(of_device_id\|i2c_device_id\|platform_device_id\|dmi_system_id\) arr[] = {
 	...,
 	{ ..., E, ... },
 +	{ },
@@ -54,7 +59,8 @@ identifier var, arr;
 expression E;
 @@
 (
-struct \(of_device_id \| i2c_device_id \| platform_device_id\) arr[] = {
+struct
+  \(of_device_id\|i2c_device_id\|platform_device_id\|dmi_system_id\) arr[] = {
 	...,
 	{
 	.var = E,
@@ -62,7 +68,8 @@ struct \(of_device_id \| i2c_device_id \| platform_device_id\) arr[] = {
 	@p1
 };
 |
-struct \(of_device_id \| i2c_device_id \| platform_device_id\) arr[] = {
+struct
+  \(of_device_id\|i2c_device_id\|platform_device_id\|dmi_system_id\) arr[] = {
 	...,
 	{ ..., E, ... }
 	@p1
