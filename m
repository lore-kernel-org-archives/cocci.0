From: nicstange@gmail.com (Nicolai Stange)
Date: Sun, 14 Feb 2016 02:37:14 +0100
Subject: [Cocci] [PATCH v3 5/7] debugfs: unproxify files created through
	debugfs_create_bool()
In-Reply-To: <87k2m8krhf.fsf@gmail.com> (Nicolai Stange's message of "Sun, 14
 Feb 2016 02:31:08 +0100")
References: <87k2m8krhf.fsf@gmail.com>
Message-ID: <87wpq8jcmt.fsf@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Currently, the struct file_operations fops_bool associated with files
created through the debugfs_create_bool() helpers are not file
lifetime aware.

Thus, a lifetime managing proxy is created around fops_bool each time such
a file is opened which is an unnecessary waste of resources.

Implement file lifetime management for the fops_bool file_operations.
Namely, make debugfs_read_file_bool() and debugfs_write_file_bool() safe
against file removals by means of debugfs_use_file_start() and
debugfs_use_file_finish().

Make debugfs_create_bool() create its files in non-proxying operation mode
through debugfs_create_mode_unsafe().

Finally, purge debugfs_create_mode() as debugfs_create_bool() had been its
last user.

Signed-off-by: Nicolai Stange <nicstange@gmail.com>
---
 fs/debugfs/file.c | 41 ++++++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 74de110..da24e0b 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -313,22 +313,6 @@ ssize_t debugfs_attr_write(struct file *file, const char __user *buf,
 }
 EXPORT_SYMBOL_GPL(debugfs_attr_write);
 
-static struct dentry *debugfs_create_mode(const char *name, umode_t mode,
-					  struct dentry *parent, void *value,
-				          const struct file_operations *fops,
-				          const struct file_operations *fops_ro,
-				          const struct file_operations *fops_wo)
-{
-	/* if there are no write bits set, make read only */
-	if (!(mode & S_IWUGO))
-		return debugfs_create_file(name, mode, parent, value, fops_ro);
-	/* if there are no read bits set, make write only */
-	if (!(mode & S_IRUGO))
-		return debugfs_create_file(name, mode, parent, value, fops_wo);
-
-	return debugfs_create_file(name, mode, parent, value, fops);
-}
-
 static struct dentry *debugfs_create_mode_unsafe(const char *name, umode_t mode,
 					struct dentry *parent, void *value,
 					const struct file_operations *fops,
@@ -757,9 +741,17 @@ ssize_t debugfs_read_file_bool(struct file *file, char __user *user_buf,
 			       size_t count, loff_t *ppos)
 {
 	char buf[3];
-	bool *val = file->private_data;
+	bool val;
+	int r, srcu_idx;
+
+	r = debugfs_use_file_start(F_DENTRY(file), &srcu_idx);
+	if (likely(!r))
+		val = *(bool *)file->private_data;
+	debugfs_use_file_finish(srcu_idx);
+	if (r)
+		return r;
 
-	if (*val)
+	if (val)
 		buf[0] = 'Y';
 	else
 		buf[0] = 'N';
@@ -775,6 +767,7 @@ ssize_t debugfs_write_file_bool(struct file *file, const char __user *user_buf,
 	char buf[32];
 	size_t buf_size;
 	bool bv;
+	int r, srcu_idx;
 	bool *val = file->private_data;
 
 	buf_size = min(count, (sizeof(buf)-1));
@@ -782,8 +775,14 @@ ssize_t debugfs_write_file_bool(struct file *file, const char __user *user_buf,
 		return -EFAULT;
 
 	buf[buf_size] = '\0';
-	if (strtobool(buf, &bv) == 0)
-		*val = bv;
+	if (strtobool(buf, &bv) == 0) {
+		r = debugfs_use_file_start(F_DENTRY(file), &srcu_idx);
+		if (likely(!r))
+			*val = bv;
+		debugfs_use_file_finish(srcu_idx);
+		if (r)
+			return r;
+	}
 
 	return count;
 }
@@ -835,7 +834,7 @@ static const struct file_operations fops_bool_wo = {
 struct dentry *debugfs_create_bool(const char *name, umode_t mode,
 				   struct dentry *parent, bool *value)
 {
-	return debugfs_create_mode(name, mode, parent, value, &fops_bool,
+	return debugfs_create_mode_unsafe(name, mode, parent, value, &fops_bool,
 				   &fops_bool_ro, &fops_bool_wo);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_bool);
-- 
2.7.1
