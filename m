From: mcgrof@do-not-panic.com (Luis R. Rodriguez)
Date: Mon, 20 Apr 2015 16:30:37 -0700
Subject: [Cocci] [PATCH v1 6/6] kernel/module.c: use
	module_param_config_on() for sig_enforce
In-Reply-To: <1429572637-30234-1-git-send-email-mcgrof@do-not-panic.com>
References: <1429572637-30234-1-git-send-email-mcgrof@do-not-panic.com>
Message-ID: <1429572637-30234-7-git-send-email-mcgrof@do-not-panic.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

From: "Luis R. Rodriguez" <mcgrof@suse.com>

Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Kees Cook <keescook@chromium.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel at vger.kernel.org
Cc: cocci at systeme.lip6.fr
Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
---
 kernel/module.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index 43a1ef3..e63bbd2 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -106,13 +106,7 @@ struct list_head *kdb_modules = &modules; /* kdb needs the list of modules */
 #endif /* CONFIG_KGDB_KDB */
 
 #ifdef CONFIG_MODULE_SIG
-#ifdef CONFIG_MODULE_SIG_FORCE
-static bool sig_enforce = true;
-#else
-static bool sig_enforce = false;
-
-module_param(sig_enforce, bool_enable_only, 0644);
-#endif /* !CONFIG_MODULE_SIG_FORCE */
+module_param_config_on(sig_enforce, sig_enforce, 0644, CONFIG_MODULE_SIG_FORCE);
 #endif /* CONFIG_MODULE_SIG */
 
 /* Block module loading/unloading? */
-- 
2.3.2.209.gd67f9d5.dirty
