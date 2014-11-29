From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 29 Nov 2014 07:44:46 +0100
Subject: [Cocci] [PATCH v2] fs-fat: Less function calls in fat_fill_super()
 after error detection
In-Reply-To: <alpine.DEB.2.02.1411152117540.2225@localhost6.localdomain6>
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
 <5317A59D.4@users.sourceforge.net> <5467B12C.4010602@users.sourceforge.net>
 <alpine.DEB.2.02.1411152117540.2225@localhost6.localdomain6>
Message-ID: <54796B5E.5040707@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 29 Nov 2014 07:37:34 +0100

The iput() function was called in an inefficient way by the implementation
of the fat_fill_super() function in case of an allocation failure.
The corresponding source code was improved by deletion of two unnecessary
null pointer checks and a few adjustments for jump labels.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 fs/fat/inode.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index 756aead..a39afe8 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -1716,20 +1716,20 @@ int fat_fill_super(struct super_block *sb, void *data, int silent, int isvfat,
 
 	fsinfo_inode = new_inode(sb);
 	if (!fsinfo_inode)
-		goto out_fail;
+		goto fsinfo_inode_failure;
 	fsinfo_inode->i_ino = MSDOS_FSINFO_INO;
 	sbi->fsinfo_inode = fsinfo_inode;
 	insert_inode_hash(fsinfo_inode);
 
 	root_inode = new_inode(sb);
 	if (!root_inode)
-		goto out_fail;
+		goto failure_exit;
 	root_inode->i_ino = MSDOS_ROOT_INO;
 	root_inode->i_version = 1;
 	error = fat_read_root(root_inode);
 	if (error < 0) {
 		iput(root_inode);
-		goto out_fail;
+		goto failure_exit;
 	}
 	error = -ENOMEM;
 	insert_inode_hash(root_inode);
@@ -1737,7 +1737,7 @@ int fat_fill_super(struct super_block *sb, void *data, int silent, int isvfat,
 	sb->s_root = d_make_root(root_inode);
 	if (!sb->s_root) {
 		fat_msg(sb, KERN_ERR, "get root inode failed");
-		goto out_fail;
+		goto failure_exit;
 	}
 
 	if (sbi->options.discard) {
@@ -1756,11 +1756,13 @@ out_invalid:
 	if (!silent)
 		fat_msg(sb, KERN_INFO, "Can't find a valid FAT filesystem");
 
+failure_exit:
+	iput(fsinfo_inode);
+
+fsinfo_inode_failure:
+	iput(fat_inode);
+
 out_fail:
-	if (fsinfo_inode)
-		iput(fsinfo_inode);
-	if (fat_inode)
-		iput(fat_inode);
 	unload_nls(sbi->nls_io);
 	unload_nls(sbi->nls_disk);
 	if (sbi->options.iocharset != fat_default_iocharset)
-- 
2.1.3
