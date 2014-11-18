From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 18 Nov 2014 15:51:31 +0100
Subject: [Cocci] [PATCH 1/1] fs-proc: One function call less in
 proc_sys_lookup() after error detection
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
Message-ID: <546B5CF3.1070203@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 18 Nov 2014 15:42:43 +0100

The sysctl_head_finish() function was called in an inefficient way by the
implementation of the proc_sys_lookup() function in case of a lookup failure.
The corresponding source code was improved by deletion of an unnecessary
null pointer check and a few adjustments for jump labels.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 fs/proc/proc_sysctl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index f92d5dd..6606aaf 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -457,21 +457,21 @@ static struct dentry *proc_sys_lookup(struct inode *dir, struct dentry *dentry,
 		ret = sysctl_follow_link(&h, &p, current->nsproxy);
 		err = ERR_PTR(ret);
 		if (ret)
-			goto out;
+			goto inode_failure;
 	}
 
 	err = ERR_PTR(-ENOMEM);
 	inode = proc_sys_make_inode(dir->i_sb, h ? h : head, p);
 	if (!inode)
-		goto out;
+		goto inode_failure;
 
 	err = NULL;
 	d_set_d_op(dentry, &proc_sys_dentry_operations);
 	d_add(dentry, inode);
 
+inode_failure:
+	sysctl_head_finish(h);
 out:
-	if (h)
-		sysctl_head_finish(h);
 	sysctl_head_finish(head);
 	return err;
 }
-- 
2.1.3
