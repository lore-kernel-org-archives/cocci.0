From: himanshujha199640@gmail.com (Himanshu Jha)
Date: Mon, 15 Jan 2018 18:06:45 +0530
Subject: [Cocci] [PATCH] demos: python_regexp: Fix regex matching
Message-ID: <1516019805-4523-1-git-send-email-himanshujha199640@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Fix regex matching by using correct python syntax by passing the
compiled regex object to the argument of search function for effective
searching.

Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
---
 demos/python_regexp.cocci | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/demos/python_regexp.cocci b/demos/python_regexp.cocci
index ce43367..ffb4bd1 100644
--- a/demos/python_regexp.cocci
+++ b/demos/python_regexp.cocci
@@ -16,7 +16,7 @@ id << r_init.id;
 @@
 
 print "COCCI: Analyzing %s" % id
-if m.search(id.ident) != None:
+if m.search(id) != None:
 	print "COCCI: %s matchs '_new$'" % id
 else:
 	print "COCCI: %s discarded" % id
-- 
2.7.4
