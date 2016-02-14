From: nicstange@gmail.com (Nicolai Stange)
Date: Sun, 14 Feb 2016 02:36:13 +0100
Subject: [Cocci] [PATCH v3 4/7] debugfs: unproxify attribute files created
	through debugfs_create_XXX()
In-Reply-To: <87k2m8krhf.fsf@gmail.com> (Nicolai Stange's message of "Sun, 14
 Feb 2016 02:31:08 +0100")
References: <87k2m8krhf.fsf@gmail.com>
Message-ID: <871t8gkr8y.fsf@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Currently, the struct file_operations associated with the attribute style
files created through the debugfs_create_XXX() helpers are not file
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
index 2da5fb0..74de110 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -329,6 +329,24 @@ static struct dentry *debugfs_create_mode(const char *name, umode_t mode,
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
@@ -339,9 +357,9 @@ static int debugfs_u8_get(void *data, u64 *val)
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
@@ -370,7 +388,7 @@ DEFINE_SIMPLE_ATTRIBUTE(fops_u8_wo, NULL, debugfs_u8_set, "%llu\n");
 struct dentry *debugfs_create_u8(const char *name, umode_t mode,
 				 struct dentry *parent, u8 *value)
 {
-	return debugfs_create_mode(name, mode, parent, value, &fops_u8,
+	return debugfs_create_mode_unsafe(name, mode, parent, value, &fops_u8,
 				   &fops_u8_ro, &fops_u8_wo);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_u8);
@@ -385,9 +403,9 @@ static int debugfs_u16_get(void *data, u64 *val)
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
@@ -416,7 +434,7 @@ DEFINE_SIMPLE_ATTRIBUTE(fops_u16_wo, NULL, debugfs_u16_set, "%llu\n");
 struct dentry *debugfs_create_u16(const char *name, umode_t mode,
 				  struct dentry *parent, u16 *value)
 {
-	return debugfs_create_mode(name, mode, parent, value, &fops_u16,
+	return debugfs_create_mode_unsafe(name, mode, parent, value, &fops_u16,
 				   &fops_u16_ro, &fops_u16_wo);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_u16);
@@ -431,9 +449,9 @@ static int debugfs_u32_get(void *data, u64 *val)
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
@@ -462,7 +480,7 @@ DEFINE_SIMPLE_ATTRIBUTE(fops_u32_wo, NULL, debugfs_u32_set, "%llu\n");
 struct dentry *debugfs_create_u32(const char *name, umode_t mode,
 				 struct dentry *parent, u32 *value)
 {
-	return debugfs_create_mode(name, mode, parent, value, &fops_u32,
+	return debugfs_create_mode_unsafe(name, mode, parent, value, &fops_u32,
 				   &fops_u32_ro, &fops_u32_wo);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_u32);
@@ -478,9 +496,9 @@ static int debugfs_u64_get(void *data, u64 *val)
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
@@ -509,7 +527,7 @@ DEFINE_SIMPLE_ATTRIBUTE(fops_u64_wo, NULL, debugfs_u64_set, "%llu\n");
 struct dentry *debugfs_create_u64(const char *name, umode_t mode,
 				 struct dentry *parent, u64 *value)
 {
-	return debugfs_create_mode(name, mode, parent, value, &fops_u64,
+	return debugfs_create_mode_unsafe(name, mode, parent, value, &fops_u64,
 				   &fops_u64_ro, &fops_u64_wo);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_u64);
@@ -525,9 +543,10 @@ static int debugfs_ulong_get(void *data, u64 *val)
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
@@ -557,26 +576,30 @@ DEFINE_SIMPLE_ATTRIBUTE(fops_ulong_wo, NULL, debugfs_ulong_set, "%llu\n");
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
@@ -599,7 +622,7 @@ DEFINE_SIMPLE_ATTRIBUTE(fops_x64_wo, NULL, debugfs_u64_set, "0x%016llx\n");
 struct dentry *debugfs_create_x8(const char *name, umode_t mode,
 				 struct dentry *parent, u8 *value)
 {
-	return debugfs_create_mode(name, mode, parent, value, &fops_x8,
+	return debugfs_create_mode_unsafe(name, mode, parent, value, &fops_x8,
 				   &fops_x8_ro, &fops_x8_wo);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_x8);
@@ -617,7 +640,7 @@ EXPORT_SYMBOL_GPL(debugfs_create_x8);
 struct dentry *debugfs_create_x16(const char *name, umode_t mode,
 				 struct dentry *parent, u16 *value)
 {
-	return debugfs_create_mode(name, mode, parent, value, &fops_x16,
+	return debugfs_create_mode_unsafe(name, mode, parent, value, &fops_x16,
 				   &fops_x16_ro, &fops_x16_wo);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_x16);
@@ -635,7 +658,7 @@ EXPORT_SYMBOL_GPL(debugfs_create_x16);
 struct dentry *debugfs_create_x32(const char *name, umode_t mode,
 				 struct dentry *parent, u32 *value)
 {
-	return debugfs_create_mode(name, mode, parent, value, &fops_x32,
+	return debugfs_create_mode_unsafe(name, mode, parent, value, &fops_x32,
 				   &fops_x32_ro, &fops_x32_wo);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_x32);
@@ -653,7 +676,7 @@ EXPORT_SYMBOL_GPL(debugfs_create_x32);
 struct dentry *debugfs_create_x64(const char *name, umode_t mode,
 				 struct dentry *parent, u64 *value)
 {
-	return debugfs_create_mode(name, mode, parent, value, &fops_x64,
+	return debugfs_create_mode_unsafe(name, mode, parent, value, &fops_x64,
 				   &fops_x64_ro, &fops_x64_wo);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_x64);
@@ -669,10 +692,10 @@ static int debugfs_size_t_get(void *data, u64 *val)
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
@@ -687,8 +710,9 @@ DEFINE_SIMPLE_ATTRIBUTE(fops_size_t_wo, NULL, debugfs_size_t_set, "%llu\n");
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
 
@@ -702,10 +726,12 @@ static int debugfs_atomic_t_get(void *data, u64 *val)
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
@@ -721,8 +747,9 @@ DEFINE_SIMPLE_ATTRIBUTE(fops_atomic_t_wo, NULL, debugfs_atomic_t_set, "%lld\n");
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
2.7.1
