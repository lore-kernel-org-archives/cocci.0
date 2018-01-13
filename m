From: himanshujha199640@gmail.com (Himanshu Jha)
Date: Sat, 13 Jan 2018 21:28:15 +0530
Subject: [Cocci] [PATCH] Coccinelle: ifnullfree: Trim the warning reported
	in report mode
Message-ID: <1515859095-31824-1-git-send-email-himanshujha199640@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Remove the unncessary part of the warning reported, in the report
mode, so that a single warning produced does not exceed more than line
and hence improve readability of the warnings produced in the subsequent
reports to a file.

Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
---
 scripts/coccinelle/free/ifnullfree.cocci | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coccinelle/free/ifnullfree.cocci b/scripts/coccinelle/free/ifnullfree.cocci
index 14a4cd9..a70e123 100644
--- a/scripts/coccinelle/free/ifnullfree.cocci
+++ b/scripts/coccinelle/free/ifnullfree.cocci
@@ -55,5 +55,5 @@ cocci.print_main("NULL check before that freeing function is not needed", p)
 p << r.p;
 @@
 
-msg = "WARNING: NULL check before freeing functions like kfree, debugfs_remove, debugfs_remove_recursive or usb_free_urb is not needed. Maybe consider reorganizing relevant code to avoid passing NULL values."
+msg = "WARNING: NULL check before some freeing functions is not needed."
 coccilib.report.print_report(p[0], msg)
-- 
2.7.4
