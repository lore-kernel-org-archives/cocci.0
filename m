From: yhuelf@gmail.com (=?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Yhuel?=)
Date: Sun, 23 Feb 2014 22:17:52 +0100
Subject: [Cocci] [PATCH] small fix for Python3 compatibility
Message-ID: <1393190272-8855-1-git-send-email-yhuelf@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

running 2to3 on the other files of the 'python' directory shows other
problems, but it seems that we only need this patch to get coccigrep
working with Python3
---
 python/coccilib/xml_firehose.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/python/coccilib/xml_firehose.py b/python/coccilib/xml_firehose.py
index 72048c1..b60267a 100644
--- a/python/coccilib/xml_firehose.py
+++ b/python/coccilib/xml_firehose.py
@@ -24,7 +24,7 @@ def import_firehose():
     try:
         globals()['firehose'] = __import__('firehose.model')
     except ImportError:
-        print "Error: Firehose is not installed or not in the Python path."
+        print("Error: Firehose is not installed or not in the Python path.")
 
 class Analysis(object):
     """
-- 
1.9.0
