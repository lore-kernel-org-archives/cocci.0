From: nicstange@gmail.com (Nicolai Stange)
Date: Tue, 23 Feb 2016 15:00:48 +0100
Subject: [Cocci] [PATCH v4 7/8] debugfs: unproxify files created through
	debugfs_create_blob()
In-Reply-To: <8737sjo7qa.fsf@gmail.com> (Nicolai Stange's message of "Tue, 23
 Feb 2016 14:51:25 +0100")
References: <8737sjo7qa.fsf@gmail.com>
Message-ID: <8760xfmsq7.fsf@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Currently, the struct file_operations fops_blob associated with files
created through the debugfs_create_blob() helpers are not file
lifetime aware.

Thus, a lifetime managing proxy is created around fops_blob each time such
a file is opened which is an unnecessary waste of resources.

Implement file lifetime management for the fops_bool file_operations.
Namely, make read_file_blob() safe gainst file removals by means of
debugfs_use_file_start() and debugfs_use_file_finish().

Make debugfs_create_blob() create its files in non-proxying operation mode
by means of debugfs_create_file_unsafe().

Signed-off-by: Nicolai Stange <nicstange@gmail.com>
---
 fs/debugfs/file.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index da24e0b..036ec3f 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -843,8 +843,15 @@ static ssize_t read_file_blob(struct file *file, char __user *user_buf,
 			      size_t count, loff_t *ppos)
 {
 	struct debugfs_blob_wrapper *blob = file->private_data;
-	return simple_read_from_buffer(user_buf, count, ppos, blob->data,
-			blob->size);
+	ssize_t r;
+	int srcu_idx;
+
+	r = debugfs_use_file_start(F_DENTRY(file), &srcu_idx);
+	if (likely(!r))
+		r = simple_read_from_buffer(user_buf, count, ppos, blob->data,
+					blob->size);
+	debugfs_use_file_finish(srcu_idx);
+	return r;
 }
 
 static const struct file_operations fops_blob = {
@@ -881,7 +888,7 @@ struct dentry *debugfs_create_blob(const char *name, umode_t mode,
 				   struct dentry *parent,
 				   struct debugfs_blob_wrapper *blob)
 {
-	return debugfs_create_file(name, mode, parent, blob, &fops_blob);
+	return debugfs_create_file_unsafe(name, mode, parent, blob, &fops_blob);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_blob);
 
-- 
2.7.1
