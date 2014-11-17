From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 17 Nov 2014 19:42:35 +0100
Subject: [Cocci] [PATCH 1/1] configfs: Deletion of unnecessary checks before
 the function call "config_item_put"
In-Reply-To: <5317A59D.4@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net>
 <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
 <530A086E.8010901@users.sourceforge.net>
 <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6>
 <530A72AA.3000601@users.sourceforge.net>
 <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6>
 <530B5FB6.6010207@users.sourceforge.net>
 <alpine.DEB.2.10.1402241710370.2074@hadrien>
 <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net>
Message-ID: <546A419B.7060409@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 17 Nov 2014 19:37:03 +0100

The config_item_put() function tests whether its argument is NULL and then
returns immediately. Thus the test around the call is not needed.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 fs/configfs/file.c | 3 +--
 fs/configfs/item.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/configfs/file.c b/fs/configfs/file.c
index 1d1c41f..48f36e7 100644
--- a/fs/configfs/file.c
+++ b/fs/configfs/file.c
@@ -291,8 +291,7 @@ static int configfs_release(struct inode * inode, struct file * filp)
 	struct module * owner = attr->ca_owner;
 	struct configfs_buffer * buffer = filp->private_data;
 
-	if (item)
-		config_item_put(item);
+	config_item_put(item);
 	/* After this point, attr should not be accessed. */
 	module_put(owner);
 
diff --git a/fs/configfs/item.c b/fs/configfs/item.c
index e65f9ff..891b20e 100644
--- a/fs/configfs/item.c
+++ b/fs/configfs/item.c
@@ -153,8 +153,7 @@ static void config_item_cleanup(struct config_item *item)
 		t->ct_item_ops->release(item);
 	if (s)
 		config_group_put(s);
-	if (parent)
-		config_item_put(parent);
+	config_item_put(parent);
 }
 
 static void config_item_release(struct kref *kref)
-- 
2.1.3
