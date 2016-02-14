From: nicstange@gmail.com (Nicolai Stange)
Date: Sun, 14 Feb 2016 02:35:08 +0100
Subject: [Cocci] [PATCH v3 3/7] debugfs: add support for self-protecting
	attribute file fops
In-Reply-To: <87k2m8krhf.fsf@gmail.com> (Nicolai Stange's message of "Sun, 14
 Feb 2016 02:31:08 +0100")
References: <87k2m8krhf.fsf@gmail.com>
Message-ID: <8760xskrar.fsf@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

In order to protect them against file removal issues, debugfs_create_file()
creates a lifetime managing proxy around each struct file_operations
handed in.

In cases where this struct file_operations is able to manage file lifetime
by itself already, the proxy created by debugfs is a waste of resources.

The most common class of struct file_operations given to debugfs are those
defined by means of the DEFINE_SIMPLE_ATTRIBUTE() macro.

Introduce a DEFINE_DEBUGFS_ATTRIBUTE() macro to allow any
struct file_operations of this class to be easily made file lifetime aware
and thus, to be operated unproxied.

Specifically, introduce debugfs_attr_read() and debugfs_attr_write()
which wrap simple_attr_read() and simple_attr_write() under the protection
of a debugfs_use_file_start()/debugfs_use_file_finish() pair.

Make DEFINE_DEBUGFS_ATTRIBUTE() set the defined struct file_operations'
->read() and ->write() members to these wrappers.

Export debugfs_create_file_unsafe() in order to allow debugfs users to
create their files in non-proxying operation mode.

Finally, add a Coccinelle script chasing down possible candidates
for a DEFINE_SIMPLE_ATTRIBUTE()/debugfs_create_file() to
DEFINE_DEBUGFS_ATTRIBUTE()/debugfs_create_file_unsafe() migration.

Signed-off-by: Nicolai Stange <nicstange@gmail.com>
---
 fs/debugfs/file.c                                  | 28 +++++++++
 fs/debugfs/inode.c                                 | 28 +++++++++
 include/linux/debugfs.h                            | 26 +++++++++
 .../api/debugfs/debugfs_simple_attr.cocci          | 68 ++++++++++++++++++++++
 4 files changed, 150 insertions(+)
 create mode 100644 scripts/coccinelle/api/debugfs/debugfs_simple_attr.cocci

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index f638dbc..2da5fb0 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -285,6 +285,34 @@ const struct file_operations debugfs_full_proxy_file_operations = {
 	.open = full_proxy_open,
 };
 
+ssize_t debugfs_attr_read(struct file *file, char __user *buf,
+			size_t len, loff_t *ppos)
+{
+	ssize_t ret;
+	int srcu_idx;
+
+	ret = debugfs_use_file_start(F_DENTRY(file), &srcu_idx);
+	if (likely(!ret))
+		ret = simple_attr_read(file, buf, len, ppos);
+	debugfs_use_file_finish(srcu_idx);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(debugfs_attr_read);
+
+ssize_t debugfs_attr_write(struct file *file, const char __user *buf,
+			 size_t len, loff_t *ppos)
+{
+	ssize_t ret;
+	int srcu_idx;
+
+	ret = debugfs_use_file_start(F_DENTRY(file), &srcu_idx);
+	if (likely(!ret))
+		ret = simple_attr_write(file, buf, len, ppos);
+	debugfs_use_file_finish(srcu_idx);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(debugfs_attr_write);
+
 static struct dentry *debugfs_create_mode(const char *name, umode_t mode,
 					  struct dentry *parent, void *value,
 				          const struct file_operations *fops,
diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 42a9b34..f95e355 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -368,6 +368,33 @@ struct dentry *debugfs_create_file(const char *name, umode_t mode,
 }
 EXPORT_SYMBOL_GPL(debugfs_create_file);
 
+/**
+ * debugfs_create_file_unsafe - create a file in the debugfs filesystem
+ * @name: a pointer to a string containing the name of the file to create.
+ * @mode: the permission that the file should have.
+ * @parent: a pointer to the parent dentry for this file.  This should be a
+ *          directory dentry if set.  If this parameter is NULL, then the
+ *          file will be created in the root of the debugfs filesystem.
+ * @data: a pointer to something that the caller will want to get to later
+ *        on.  The inode.i_private pointer will point to this value on
+ *        the open() call.
+ * @fops: a pointer to a struct file_operations that should be used for
+ *        this file.
+ *
+ * debugfs_create_file_unsafe() is completely analogous to
+ * debugfs_create_file(), the only difference being that the fops
+ * handed it will not get protected against file removals by the
+ * debugfs core.
+ *
+ * It is your responsibility to protect your struct file_operation
+ * methods against file removals by means of debugfs_use_file_start()
+ * and debugfs_use_file_finish(). ->open() is still protected by
+ * debugfs though.
+ *
+ * Any struct file_operations defined by means of
+ * DEFINE_DEBUGFS_ATTRIBUTE() is protected against file removals and
+ * thus, may be used here.
+ */
 struct dentry *debugfs_create_file_unsafe(const char *name, umode_t mode,
 				   struct dentry *parent, void *data,
 				   const struct file_operations *fops)
@@ -378,6 +405,7 @@ struct dentry *debugfs_create_file_unsafe(const char *name, umode_t mode,
 					&debugfs_noop_file_operations,
 				fops);
 }
+EXPORT_SYMBOL_GPL(debugfs_create_file_unsafe);
 
 /**
  * debugfs_create_file_size - create a file in the debugfs filesystem
diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
index 6d45ae6..c880fe9 100644
--- a/include/linux/debugfs.h
+++ b/include/linux/debugfs.h
@@ -50,6 +50,9 @@ extern struct srcu_struct debugfs_srcu;
 struct dentry *debugfs_create_file(const char *name, umode_t mode,
 				   struct dentry *parent, void *data,
 				   const struct file_operations *fops);
+struct dentry *debugfs_create_file_unsafe(const char *name, umode_t mode,
+				   struct dentry *parent, void *data,
+				   const struct file_operations *fops);
 
 struct dentry *debugfs_create_file_size(const char *name, umode_t mode,
 					struct dentry *parent, void *data,
@@ -74,6 +77,26 @@ int debugfs_use_file_start(const struct dentry *dentry, int *srcu_idx)
 
 void debugfs_use_file_finish(int srcu_idx) __releases(&debugfs_srcu);
 
+ssize_t debugfs_attr_read(struct file *file, char __user *buf,
+			size_t len, loff_t *ppos);
+ssize_t debugfs_attr_write(struct file *file, const char __user *buf,
+			size_t len, loff_t *ppos);
+
+#define DEFINE_DEBUGFS_ATTRIBUTE(__fops, __get, __set, __fmt)		\
+static int __fops ## _open(struct inode *inode, struct file *file)	\
+{									\
+	__simple_attr_check_format(__fmt, 0ull);			\
+	return simple_attr_open(inode, file, __get, __set, __fmt);	\
+}									\
+static const struct file_operations __fops = {				\
+	.owner	 = THIS_MODULE,					\
+	.open	 = __fops ## _open,					\
+	.release = simple_attr_release,				\
+	.read	 = debugfs_attr_read,					\
+	.write	 = debugfs_attr_write,					\
+	.llseek  = generic_file_llseek,				\
+}
+
 struct dentry *debugfs_rename(struct dentry *old_dir, struct dentry *old_dentry,
                 struct dentry *new_dir, const char *new_name);
 
@@ -183,6 +206,9 @@ static int debugfs_use_file_start(const struct dentry *dentry, int *srcu_idx)
 static void debugfs_use_file_finish(int srcu_idx) __releases(&debugfs_srcu)
 { }
 
+#define DEFINE_DEBUGFS_ATTRIBUTE(__fops, __get, __set, __fmt)	\
+	static const struct file_operations __fops = { 0 }
+
 static inline struct dentry *debugfs_rename(struct dentry *old_dir, struct dentry *old_dentry,
                 struct dentry *new_dir, char *new_name)
 {
diff --git a/scripts/coccinelle/api/debugfs/debugfs_simple_attr.cocci b/scripts/coccinelle/api/debugfs/debugfs_simple_attr.cocci
new file mode 100644
index 0000000..bdc418d
--- /dev/null
+++ b/scripts/coccinelle/api/debugfs/debugfs_simple_attr.cocci
@@ -0,0 +1,68 @@
+///
+/// Use DEFINE_DEBUGFS_ATTRIBUTE rather than DEFINE_SIMPLE_ATTRIBUTE
+/// for debugfs files.
+///
+/// Rationale: DEFINE_SIMPLE_ATTRIBUTE + debugfs_create_file()
+/// imposes some significant overhead as compared to
+/// DEFINE_DEBUGFS_ATTRIBUTE + debugfs_create_file_unsafe().
+///
+// Copyright (C): 2016 Nicolai Stange
+// Options: --no-includes
+//
+
+virtual context
+virtual patch
+virtual org
+virtual report
+
+ at dsa@
+declarer name DEFINE_SIMPLE_ATTRIBUTE;
+identifier dsa_fops;
+expression dsa_get, dsa_set, dsa_fmt;
+position p;
+@@
+DEFINE_SIMPLE_ATTRIBUTE at p(dsa_fops, dsa_get, dsa_set, dsa_fmt);
+
+ at dcf@
+expression name, mode, parent, data;
+identifier dsa.dsa_fops;
+@@
+debugfs_create_file(name, mode, parent, data, &dsa_fops)
+
+
+ at context_dsa depends on context && dcf@
+declarer name DEFINE_DEBUGFS_ATTRIBUTE;
+identifier dsa.dsa_fops;
+expression dsa.dsa_get, dsa.dsa_set, dsa.dsa_fmt;
+@@
+* DEFINE_SIMPLE_ATTRIBUTE(dsa_fops, dsa_get, dsa_set, dsa_fmt);
+
+
+ at patch_dcf depends on patch expression@
+expression name, mode, parent, data;
+identifier dsa.dsa_fops;
+@@
+- debugfs_create_file(name, mode, parent, data, &dsa_fops)
++ debugfs_create_file_unsafe(name, mode, parent, data, &dsa_fops)
+
+ at patch_dsa depends on patch_dcf && patch@
+identifier dsa.dsa_fops;
+expression dsa.dsa_get, dsa.dsa_set, dsa.dsa_fmt;
+@@
+- DEFINE_SIMPLE_ATTRIBUTE(dsa_fops, dsa_get, dsa_set, dsa_fmt);
++ DEFINE_DEBUGFS_ATTRIBUTE(dsa_fops, dsa_get, dsa_set, dsa_fmt);
+
+
+ at script:python depends on org && dcf@
+fops << dsa.dsa_fops;
+p << dsa.p;
+@@
+msg="%s should be defined with DEFINE_DEBUGFS_ATTRIBUTE" % (fops)
+coccilib.org.print_todo(p[0], msg)
+
+@script:python depends on report && dcf@
+fops << dsa.dsa_fops;
+p << dsa.p;
+@@
+msg="WARNING: %s should be defined with DEFINE_DEBUGFS_ATTRIBUTE" % (fops)
+coccilib.report.print_report(p[0], msg)
-- 
2.7.1
