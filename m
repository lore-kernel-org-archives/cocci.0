From: mcgrof@do-not-panic.com (Luis R. Rodriguez)
Date: Mon, 20 Apr 2015 16:30:36 -0700
Subject: [Cocci] [PATCH v1 5/6] kernel/workqueue.c: use
	module_param_config_on_off() for power_efficient
In-Reply-To: <1429572637-30234-1-git-send-email-mcgrof@do-not-panic.com>
References: <1429572637-30234-1-git-send-email-mcgrof@do-not-panic.com>
Message-ID: <1429572637-30234-6-git-send-email-mcgrof@do-not-panic.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

From: "Luis R. Rodriguez" <mcgrof@suse.com>

Use the new module_param_config_on_off() for setting / disabling of
CONFIG_WQ_POWER_EFFICIENT_DEFAULT.

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
 kernel/workqueue.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 586ad91..cf6c2f1 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -280,13 +280,7 @@ static bool wq_disable_numa;
 module_param_named(disable_numa, wq_disable_numa, bool, 0444);
 
 /* see the comment above the definition of WQ_POWER_EFFICIENT */
-#ifdef CONFIG_WQ_POWER_EFFICIENT_DEFAULT
-static bool wq_power_efficient = true;
-#else
-static bool wq_power_efficient;
-#endif
-
-module_param_named(power_efficient, wq_power_efficient, bool, 0444);
+module_param_config_on_off(power_efficient, wq_power_efficient, 0444, CONFIG_WQ_POWER_EFFICIENT_DEFAULT);
 
 static bool wq_numa_enabled;		/* unbound NUMA affinity enabled */
 
-- 
2.3.2.209.gd67f9d5.dirty
