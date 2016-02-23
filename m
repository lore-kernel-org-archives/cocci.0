From: nicstange@gmail.com (Nicolai Stange)
Date: Tue, 23 Feb 2016 15:02:07 +0100
Subject: [Cocci] [PATCH v4 8/8] debugfs: unproxify files created through
	debugfs_create_u32_array()
In-Reply-To: <8737sjo7qa.fsf@gmail.com> (Nicolai Stange's message of "Tue, 23
 Feb 2016 14:51:25 +0100")
References: <8737sjo7qa.fsf@gmail.com>
Message-ID: <871t83mso0.fsf@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

The struct file_operations u32_array_fops associated with files created
through debugfs_create_u32_array() has been lifetime aware already:
everything needed for subsequent operation is copied to a ->f_private
buffer at file opening time in u32_array_open(). Now, ->open() is always
protected against file removal issues by the debugfs core.

There is no need for the debugfs core to wrap the u32_array_fops
with a file lifetime managing proxy.

Make debugfs_create_u32_array() create its files in non-proxying operation
mode by means of debugfs_create_file_unsafe().

Signed-off-by: Nicolai Stange <nicstange@gmail.com>
---
 fs/debugfs/file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 036ec3f..1a03e99 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -993,7 +993,8 @@ struct dentry *debugfs_create_u32_array(const char *name, umode_t mode,
 	data->array = array;
 	data->elements = elements;
 
-	return debugfs_create_file(name, mode, parent, data, &u32_array_fops);
+	return debugfs_create_file_unsafe(name, mode, parent, data,
+					&u32_array_fops);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_u32_array);
 
-- 
2.7.1
