From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 17 Nov 2014 19:19:22 +0100
Subject: [Cocci] [PATCH 1/1] hfs/hfs+: Deletion of unnecessary checks before
 the function call "hfs_bnode_put"
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
Message-ID: <546A3C2A.9050401@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 17 Nov 2014 19:13:56 +0100

The hfs_bnode_put() function tests whether its argument is NULL and then
returns immediately. Thus the test around the call is not needed.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 fs/hfs/bfind.c     | 3 +--
 fs/hfs/brec.c      | 3 +--
 fs/hfsplus/bfind.c | 3 +--
 fs/hfsplus/brec.c  | 3 +--
 4 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/hfs/bfind.c b/fs/hfs/bfind.c
index de69d8a..0e26523 100644
--- a/fs/hfs/bfind.c
+++ b/fs/hfs/bfind.c
@@ -100,8 +100,7 @@ int hfs_brec_find(struct hfs_find_data *fd)
 	int height, res;
 
 	tree = fd->tree;
-	if (fd->bnode)
-		hfs_bnode_put(fd->bnode);
+	hfs_bnode_put(fd->bnode);
 	fd->bnode = NULL;
 	nidx = tree->root;
 	if (!nidx)
diff --git a/fs/hfs/brec.c b/fs/hfs/brec.c
index 9f4ee7f..3a52b2c 100644
--- a/fs/hfs/brec.c
+++ b/fs/hfs/brec.c
@@ -272,8 +272,7 @@ static struct hfs_bnode *hfs_bnode_split(struct hfs_find_data *fd)
 		/* panic? */
 		hfs_bnode_put(node);
 		hfs_bnode_put(new_node);
-		if (next_node)
-			hfs_bnode_put(next_node);
+		hfs_bnode_put(next_node);
 		return ERR_PTR(-ENOSPC);
 	}
 
diff --git a/fs/hfsplus/bfind.c b/fs/hfsplus/bfind.c
index c1422d9..7be88e3 100644
--- a/fs/hfsplus/bfind.c
+++ b/fs/hfsplus/bfind.c
@@ -171,8 +171,7 @@ int hfs_brec_find(struct hfs_find_data *fd, search_strategy_t do_key_compare)
 	int height, res;
 
 	tree = fd->tree;
-	if (fd->bnode)
-		hfs_bnode_put(fd->bnode);
+	hfs_bnode_put(fd->bnode);
 	fd->bnode = NULL;
 	nidx = tree->root;
 	if (!nidx)
diff --git a/fs/hfsplus/brec.c b/fs/hfsplus/brec.c
index 6e560d5..59bab47 100644
--- a/fs/hfsplus/brec.c
+++ b/fs/hfsplus/brec.c
@@ -276,8 +276,7 @@ static struct hfs_bnode *hfs_bnode_split(struct hfs_find_data *fd)
 		/* panic? */
 		hfs_bnode_put(node);
 		hfs_bnode_put(new_node);
-		if (next_node)
-			hfs_bnode_put(next_node);
+		hfs_bnode_put(next_node);
 		return ERR_PTR(-ENOSPC);
 	}
 
-- 
2.1.3
