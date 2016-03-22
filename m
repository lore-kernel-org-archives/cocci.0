From: nicstange@gmail.com (Nicolai Stange)
Date: Tue, 22 Mar 2016 14:11:17 +0100
Subject: [Cocci] [PATCH v6 5/8] debugfs: unproxify integer attribute files
In-Reply-To: <1458652280-19785-1-git-send-email-nicstange@gmail.com>
References: <1458652280-19785-1-git-send-email-nicstange@gmail.com>
Message-ID: <1458652280-19785-6-git-send-email-nicstange@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Currently, the struct file_operations associated with the integer attribute
style files created through the debugfs_create_*() helpers are not file
lifetime aware as they are defined by means of DEFINE_SIMPLE_ATTRIBUTE().

Thus, a lifetime managing proxy is created around the original fops each
time such a file is opened which is an unnecessary waste of resources.

Migrate all usages of DEFINE_SIMPLE_ATTRIBUTE() within debugfs itself
to DEFINE_DEBUGFS_ATTRIBUTE() in order to implement file lifetime managing
within the struct file_operations thus defined.

Introduce the debugfs_create_mode_unsafe() helper, analogous to
debugfs_create_mode(), but distinct in that it creates the files in
non-proxying operation mode through debugfs_create_file_unsafe().

Feed all struct file_operations migrated to DEFINE_DEBUGFS_ATTRIBUTE()
into debugfs_create_mode_unsafe() instead of former debugfs_create_mode().

Signed-off-by: Nicolai Stange <nicstange@gmail.com>
---
 fs/debugfs/file.c | 123 +++++++++++++++++++++++++++++++++---------------------
 1 file changed, 75 insertions(+), 48 deletions(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 8ef56d9..4b3967e 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -328,6 +328,24 @@ static struct dentry *debugfs_create_mode(const char *name, umode_t mode,
 	return debugfs_create_file(name, mode, parent, value, fops);
 }
 
+static struct dentry *debugfs_create_mode_unsafe(const char *name, umode_t mode,
+					struct dentry *parent, void *value,
+					const struct file_operations *fops,
+					const struct file_operations *fops_ro,
+					const struct file_operations *fops_wo)
+{
+	/* if there are no write bits set, make read only */
+	if (!(mode & S_IWUGO))
+		return debugfs_create_file_unsafe(name, mode, parent, value,
+						fops_ro);
+	/* if there are no read bits set, make write only */
+	if (!(mode & S_IRUGO))
+		return debugfs_create_file_unsafe(name, mode, parent, value,
+						fops_wo);
+
+	return debugfs_create_file_unsafe(name, mode, parent, value, fops);
+}
+
 static int debugfs_u8_set(void *data, u64 val)
 {
 	*(u8 *)data = val;
@@ -338,9 +356,9 @@ static int debugfs_u8_get(void *data, u64 *val)
 	*val = *(u8 *)data;
 	return 0;
 }
-DEFINE_SIMPLE_ATTRIBUTE(fops_u8, debugfs_u8_get, debugfs_u8_set, "%llu\n");
-DEFINE_SIMPLE_ATTRIBUTE(fops_u8_ro, debugfs_u8_get, NULL, "%llu\n");
-DEFINE_SIMPLE_ATTRIBUTE(fops_u8_wo, NULL, debugfs_u8_set, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(fops_u8, debugfs_u8_get, debugfs_u8_set, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(fops_u8_ro, debugfs_u8_get, NULL, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(fops_u8_wo, NULL, debugfs_u8_set, "%llu\n");
 
 /**
  * debugfs_create_u8 - create a debugfs file that is used to read and write an unsigned 8-bit value
@@ -369,7 +387,7 @@ DEFINE_SIMPLE_ATTRIBUTE(fops_u8_wo, NULL, debugfs_u8_set, "%llu\n");
 struct dentry *debugfs_create_u8(const char *name, umode_t mode,
 				 struct dentry *parent, u8 *value)
 {
-	return debugfs_create_mode(name, mode, parent, value, &fops_u8,
+	return debugfs_create_mode_unsafe(name, mode, parent, value, &fops_u8,
 				   &fops_u8_ro, &fops_u8_wo);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_u8);
@@ -384,9 +402,9 @@ static int debugfs_u16_get(void *data, u64 *val)
 	*val = *(u16 *)data;
 	return 0;
 }
-DEFINE_SIMPLE_ATTRIBUTE(fops_u16, debugfs_u16_get, debugfs_u16_set, "%llu\n");
-DEFINE_SIMPLE_ATTRIBUTE(fops_u16_ro, debugfs_u16_get, NULL, "%llu\n");
-DEFINE_SIMPLE_ATTRIBUTE(fops_u16_wo, NULL, debugfs_u16_set, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(fops_u16, debugfs_u16_get, debugfs_u16_set, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(fops_u16_ro, debugfs_u16_get, NULL, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(fops_u16_wo, NULL, debugfs_u16_set, "%llu\n");
 
 /**
  * debugfs_create_u16 - create a debugfs file that is used to read and write an unsigned 16-bit value
@@ -415,7 +433,7 @@ DEFINE_SIMPLE_ATTRIBUTE(fops_u16_wo, NULL, debugfs_u16_set, "%llu\n");
 struct dentry *debugfs_create_u16(const char *name, umode_t mode,
 				  struct dentry *parent, u16 *value)
 {
-	return debugfs_create_mode(name, mode, parent, value, &fops_u16,
+	return debugfs_create_mode_unsafe(name, mode, parent, value, &fops_u16,
 				   &fops_u16_ro, &fops_u16_wo);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_u16);
@@ -430,9 +448,9 @@ static int debugfs_u32_get(void *data, u64 *val)
 	*val = *(u32 *)data;
 	return 0;
 }
-DEFINE_SIMPLE_ATTRIBUTE(fops_u32, debugfs_u32_get, debugfs_u32_set, "%llu\n");
-DEFINE_SIMPLE_ATTRIBUTE(fops_u32_ro, debugfs_u32_get, NULL, "%llu\n");
-DEFINE_SIMPLE_ATTRIBUTE(fops_u32_wo, NULL, debugfs_u32_set, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(fops_u32, debugfs_u32_get, debugfs_u32_set, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(fops_u32_ro, debugfs_u32_get, NULL, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(fops_u32_wo, NULL, debugfs_u32_set, "%llu\n");
 
 /**
  * debugfs_create_u32 - create a debugfs file that is used to read and write an unsigned 32-bit value
@@ -461,7 +479,7 @@ DEFINE_SIMPLE_ATTRIBUTE(fops_u32_wo, NULL, debugfs_u32_set, "%llu\n");
 struct dentry *debugfs_create_u32(const char *name, umode_t mode,
 				 struct dentry *parent, u32 *value)
 {
-	return debugfs_create_mode(name, mode, parent, value, &fops_u32,
+	return debugfs_create_mode_unsafe(name, mode, parent, value, &fops_u32,
 				   &fops_u32_ro, &fops_u32_wo);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_u32);
@@ -477,9 +495,9 @@ static int debugfs_u64_get(void *data, u64 *val)
 	*val = *(u64 *)data;
 	return 0;
 }
-DEFINE_SIMPLE_ATTRIBUTE(fops_u64, debugfs_u64_get, debugfs_u64_set, "%llu\n");
-DEFINE_SIMPLE_ATTRIBUTE(fops_u64_ro, debugfs_u64_get, NULL, "%llu\n");
-DEFINE_SIMPLE_ATTRIBUTE(fops_u64_wo, NULL, debugfs_u64_set, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(fops_u64, debugfs_u64_get, debugfs_u64_set, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(fops_u64_ro, debugfs_u64_get, NULL, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(fops_u64_wo, NULL, debugfs_u64_set, "%llu\n");
 
 /**
  * debugfs_create_u64 - create a debugfs file that is used to read and write an unsigned 64-bit value
@@ -508,7 +526,7 @@ DEFINE_SIMPLE_ATTRIBUTE(fops_u64_wo, NULL, debugfs_u64_set, "%llu\n");
 struct dentry *debugfs_create_u64(const char *name, umode_t mode,
 				 struct dentry *parent, u64 *value)
 {
-	return debugfs_create_mode(name, mode, parent, value, &fops_u64,
+	return debugfs_create_mode_unsafe(name, mode, parent, value, &fops_u64,
 				   &fops_u64_ro, &fops_u64_wo);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_u64);
@@ -524,9 +542,10 @@ static int debugfs_ulong_get(void *data, u64 *val)
 	*val = *(unsigned long *)data;
 	return 0;
 }
-DEFINE_SIMPLE_ATTRIBUTE(fops_ulong, debugfs_ulong_get, debugfs_ulong_set, "%llu\n");
-DEFINE_SIMPLE_ATTRIBUTE(fops_ulong_ro, debugfs_ulong_get, NULL, "%llu\n");
-DEFINE_SIMPLE_ATTRIBUTE(fops_ulong_wo, NULL, debugfs_ulong_set, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(fops_ulong, debugfs_ulong_get, debugfs_ulong_set,
+			"%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(fops_ulong_ro, debugfs_ulong_get, NULL, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(fops_ulong_wo, NULL, debugfs_ulong_set, "%llu\n");
 
 /**
  * debugfs_create_ulong - create a debugfs file that is used to read and write
@@ -556,26 +575,30 @@ DEFINE_SIMPLE_ATTRIBUTE(fops_ulong_wo, NULL, debugfs_ulong_set, "%llu\n");
 struct dentry *debugfs_create_ulong(const char *name, umode_t mode,
 				    struct dentry *parent, unsigned long *value)
 {
-	return debugfs_create_mode(name, mode, parent, value, &fops_ulong,
-				   &fops_ulong_ro, &fops_ulong_wo);
+	return debugfs_create_mode_unsafe(name, mode, parent, value,
+					&fops_ulong, &fops_ulong_ro,
+					&fops_ulong_wo);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_ulong);
 
-DEFINE_SIMPLE_ATTRIBUTE(fops_x8, debugfs_u8_get, debugfs_u8_set, "0x%02llx\n");
-DEFINE_SIMPLE_ATTRIBUTE(fops_x8_ro, debugfs_u8_get, NULL, "0x%02llx\n");
-DEFINE_SIMPLE_ATTRIBUTE(fops_x8_wo, NULL, debugfs_u8_set, "0x%02llx\n");
+DEFINE_DEBUGFS_ATTRIBUTE(fops_x8, debugfs_u8_get, debugfs_u8_set, "0x%02llx\n");
+DEFINE_DEBUGFS_ATTRIBUTE(fops_x8_ro, debugfs_u8_get, NULL, "0x%02llx\n");
+DEFINE_DEBUGFS_ATTRIBUTE(fops_x8_wo, NULL, debugfs_u8_set, "0x%02llx\n");
 
-DEFINE_SIMPLE_ATTRIBUTE(fops_x16, debugfs_u16_get, debugfs_u16_set, "0x%04llx\n");
-DEFINE_SIMPLE_ATTRIBUTE(fops_x16_ro, debugfs_u16_get, NULL, "0x%04llx\n");
-DEFINE_SIMPLE_ATTRIBUTE(fops_x16_wo, NULL, debugfs_u16_set, "0x%04llx\n");
+DEFINE_DEBUGFS_ATTRIBUTE(fops_x16, debugfs_u16_get, debugfs_u16_set,
+			"0x%04llx\n");
+DEFINE_DEBUGFS_ATTRIBUTE(fops_x16_ro, debugfs_u16_get, NULL, "0x%04llx\n");
+DEFINE_DEBUGFS_ATTRIBUTE(fops_x16_wo, NULL, debugfs_u16_set, "0x%04llx\n");
 
-DEFINE_SIMPLE_ATTRIBUTE(fops_x32, debugfs_u32_get, debugfs_u32_set, "0x%08llx\n");
-DEFINE_SIMPLE_ATTRIBUTE(fops_x32_ro, debugfs_u32_get, NULL, "0x%08llx\n");
-DEFINE_SIMPLE_ATTRIBUTE(fops_x32_wo, NULL, debugfs_u32_set, "0x%08llx\n");
+DEFINE_DEBUGFS_ATTRIBUTE(fops_x32, debugfs_u32_get, debugfs_u32_set,
+			"0x%08llx\n");
+DEFINE_DEBUGFS_ATTRIBUTE(fops_x32_ro, debugfs_u32_get, NULL, "0x%08llx\n");
+DEFINE_DEBUGFS_ATTRIBUTE(fops_x32_wo, NULL, debugfs_u32_set, "0x%08llx\n");
 
-DEFINE_SIMPLE_ATTRIBUTE(fops_x64, debugfs_u64_get, debugfs_u64_set, "0x%016llx\n");
-DEFINE_SIMPLE_ATTRIBUTE(fops_x64_ro, debugfs_u64_get, NULL, "0x%016llx\n");
-DEFINE_SIMPLE_ATTRIBUTE(fops_x64_wo, NULL, debugfs_u64_set, "0x%016llx\n");
+DEFINE_DEBUGFS_ATTRIBUTE(fops_x64, debugfs_u64_get, debugfs_u64_set,
+			"0x%016llx\n");
+DEFINE_DEBUGFS_ATTRIBUTE(fops_x64_ro, debugfs_u64_get, NULL, "0x%016llx\n");
+DEFINE_DEBUGFS_ATTRIBUTE(fops_x64_wo, NULL, debugfs_u64_set, "0x%016llx\n");
 
 /*
  * debugfs_create_x{8,16,32,64} - create a debugfs file that is used to read and write an unsigned {8,16,32,64}-bit value
@@ -598,7 +621,7 @@ DEFINE_SIMPLE_ATTRIBUTE(fops_x64_wo, NULL, debugfs_u64_set, "0x%016llx\n");
 struct dentry *debugfs_create_x8(const char *name, umode_t mode,
 				 struct dentry *parent, u8 *value)
 {
-	return debugfs_create_mode(name, mode, parent, value, &fops_x8,
+	return debugfs_create_mode_unsafe(name, mode, parent, value, &fops_x8,
 				   &fops_x8_ro, &fops_x8_wo);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_x8);
@@ -616,7 +639,7 @@ EXPORT_SYMBOL_GPL(debugfs_create_x8);
 struct dentry *debugfs_create_x16(const char *name, umode_t mode,
 				 struct dentry *parent, u16 *value)
 {
-	return debugfs_create_mode(name, mode, parent, value, &fops_x16,
+	return debugfs_create_mode_unsafe(name, mode, parent, value, &fops_x16,
 				   &fops_x16_ro, &fops_x16_wo);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_x16);
@@ -634,7 +657,7 @@ EXPORT_SYMBOL_GPL(debugfs_create_x16);
 struct dentry *debugfs_create_x32(const char *name, umode_t mode,
 				 struct dentry *parent, u32 *value)
 {
-	return debugfs_create_mode(name, mode, parent, value, &fops_x32,
+	return debugfs_create_mode_unsafe(name, mode, parent, value, &fops_x32,
 				   &fops_x32_ro, &fops_x32_wo);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_x32);
@@ -652,7 +675,7 @@ EXPORT_SYMBOL_GPL(debugfs_create_x32);
 struct dentry *debugfs_create_x64(const char *name, umode_t mode,
 				 struct dentry *parent, u64 *value)
 {
-	return debugfs_create_mode(name, mode, parent, value, &fops_x64,
+	return debugfs_create_mode_unsafe(name, mode, parent, value, &fops_x64,
 				   &fops_x64_ro, &fops_x64_wo);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_x64);
@@ -668,10 +691,10 @@ static int debugfs_size_t_get(void *data, u64 *val)
 	*val = *(size_t *)data;
 	return 0;
 }
-DEFINE_SIMPLE_ATTRIBUTE(fops_size_t, debugfs_size_t_get, debugfs_size_t_set,
-			"%llu\n");	/* %llu and %zu are more or less the same */
-DEFINE_SIMPLE_ATTRIBUTE(fops_size_t_ro, debugfs_size_t_get, NULL, "%llu\n");
-DEFINE_SIMPLE_ATTRIBUTE(fops_size_t_wo, NULL, debugfs_size_t_set, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(fops_size_t, debugfs_size_t_get, debugfs_size_t_set,
+			"%llu\n"); /* %llu and %zu are more or less the same */
+DEFINE_DEBUGFS_ATTRIBUTE(fops_size_t_ro, debugfs_size_t_get, NULL, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(fops_size_t_wo, NULL, debugfs_size_t_set, "%llu\n");
 
 /**
  * debugfs_create_size_t - create a debugfs file that is used to read and write an size_t value
@@ -686,8 +709,9 @@ DEFINE_SIMPLE_ATTRIBUTE(fops_size_t_wo, NULL, debugfs_size_t_set, "%llu\n");
 struct dentry *debugfs_create_size_t(const char *name, umode_t mode,
 				     struct dentry *parent, size_t *value)
 {
-	return debugfs_create_mode(name, mode, parent, value, &fops_size_t,
-				   &fops_size_t_ro, &fops_size_t_wo);
+	return debugfs_create_mode_unsafe(name, mode, parent, value,
+					&fops_size_t, &fops_size_t_ro,
+					&fops_size_t_wo);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_size_t);
 
@@ -701,10 +725,12 @@ static int debugfs_atomic_t_get(void *data, u64 *val)
 	*val = atomic_read((atomic_t *)data);
 	return 0;
 }
-DEFINE_SIMPLE_ATTRIBUTE(fops_atomic_t, debugfs_atomic_t_get,
+DEFINE_DEBUGFS_ATTRIBUTE(fops_atomic_t, debugfs_atomic_t_get,
 			debugfs_atomic_t_set, "%lld\n");
-DEFINE_SIMPLE_ATTRIBUTE(fops_atomic_t_ro, debugfs_atomic_t_get, NULL, "%lld\n");
-DEFINE_SIMPLE_ATTRIBUTE(fops_atomic_t_wo, NULL, debugfs_atomic_t_set, "%lld\n");
+DEFINE_DEBUGFS_ATTRIBUTE(fops_atomic_t_ro, debugfs_atomic_t_get, NULL,
+			"%lld\n");
+DEFINE_DEBUGFS_ATTRIBUTE(fops_atomic_t_wo, NULL, debugfs_atomic_t_set,
+			"%lld\n");
 
 /**
  * debugfs_create_atomic_t - create a debugfs file that is used to read and
@@ -720,8 +746,9 @@ DEFINE_SIMPLE_ATTRIBUTE(fops_atomic_t_wo, NULL, debugfs_atomic_t_set, "%lld\n");
 struct dentry *debugfs_create_atomic_t(const char *name, umode_t mode,
 				 struct dentry *parent, atomic_t *value)
 {
-	return debugfs_create_mode(name, mode, parent, value, &fops_atomic_t,
-				   &fops_atomic_t_ro, &fops_atomic_t_wo);
+	return debugfs_create_mode_unsafe(name, mode, parent, value,
+					&fops_atomic_t, &fops_atomic_t_ro,
+					&fops_atomic_t_wo);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_atomic_t);
 
-- 
2.7.4
