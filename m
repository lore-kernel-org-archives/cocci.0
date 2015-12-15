From: mcgrof@do-not-panic.com (Luis R. Rodriguez)
Date: Tue, 15 Dec 2015 14:16:30 -0800
Subject: [Cocci] [RFC v1 1/8] paravirt: rename paravirt_enabled to
	paravirt_legacy
In-Reply-To: <1450217797-19295-1-git-send-email-mcgrof@do-not-panic.com>
References: <1450217797-19295-1-git-send-email-mcgrof@do-not-panic.com>
Message-ID: <1450217797-19295-2-git-send-email-mcgrof@do-not-panic.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

From: "Luis R. Rodriguez" <mcgrof@suse.com>

paravirt_enabled conveys the idea that if this is set or if
paravirt_enabled() returns true you are in a paravirtualized
environment. This is not true, this is really only useful to
determine if you have a paravirtualization hypervisor that uses
supports legacy paravirtualized guests. At run time, this tells
us if we've booted into a Linux guest with support for legacy
paravirtualized guests.

Make emphasis about this by renaming the member and helper.
While at it, make the type bool, and document it therefore
avoiding special cased comments trying to explain it.

The rename is done using the following Coccinelle SmPL patch:

@ rename_paravirt_enabled @
@@

-paravirt_enabled()
+paravirt_legacy()

@ rename_pv_info_pv_enabled @
@@
-pv_info.paravirt_enabled
+pv_info.paravirt_legacy

@ is_pv @
identifier pv;
@@
struct pv_info pv = {
};

@ rename_struct_pv_enabled depends on is_pv @
identifier is_pv.pv;
expression val;
@@

struct pv_info pv = {
-	.paravirt_enabled
+	.paravirt_legacy
	= val,
};

Generated-by: Coccinelle SmPL
Suggested-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: cocci at systeme.lip6.fr
cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
---
 arch/x86/include/asm/paravirt.h       |  4 ++--
 arch/x86/include/asm/paravirt_types.h | 11 ++++++++++-
 arch/x86/include/asm/processor.h      |  2 +-
 arch/x86/kernel/apm_32.c              |  2 +-
 arch/x86/kernel/asm-offsets.c         |  2 +-
 arch/x86/kernel/cpu/intel.c           |  2 +-
 arch/x86/kernel/cpu/microcode/core.c  |  2 +-
 arch/x86/kernel/head.c                |  2 +-
 arch/x86/kernel/kvm.c                 |  9 +--------
 arch/x86/kernel/paravirt.c            |  2 +-
 arch/x86/kernel/tboot.c               |  2 +-
 arch/x86/lguest/boot.c                |  2 +-
 arch/x86/mm/dump_pagetables.c         |  2 +-
 arch/x86/xen/enlighten.c              |  2 +-
 drivers/pnp/pnpbios/core.c            |  2 +-
 15 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 10d0596433f8..38e698ff8cae 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -14,9 +14,9 @@
 #include <linux/types.h>
 #include <linux/cpumask.h>
 
-static inline int paravirt_enabled(void)
+static inline bool paravirt_legacy(void)
 {
-	return pv_info.paravirt_enabled;
+	return pv_info.paravirt_legacy;
 }
 
 static inline void load_sp0(struct tss_struct *tss,
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 31247b5bff7c..3d89e8e878bc 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -61,6 +61,15 @@ struct paravirt_callee_save {
 };
 
 /* general info */
+
+/**
+ * struct pv_info - hypervisor information
+ *
+ * @paravirt_legacy: true if this hypervisor supports legacy
+ * 	paravirtualized guests. Examples of features that
+ * 	characterize legacy paravirtualized guests are
+ * 	things such as the need for APM, PNP BIOS.
+ */
 struct pv_info {
 	unsigned int kernel_rpl;
 	int shared_kernel_pmd;
@@ -69,7 +78,7 @@ struct pv_info {
 	u16 extra_user_64bit_cs;  /* __USER_CS if none */
 #endif
 
-	int paravirt_enabled;
+	bool paravirt_legacy;
 	const char *name;
 };
 
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 67522256c7ff..354a0d010c59 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -471,7 +471,7 @@ static inline unsigned long current_top_of_stack(void)
 #include <asm/paravirt.h>
 #else
 #define __cpuid			native_cpuid
-#define paravirt_enabled()	0
+#define paravirt_legacy()	false
 
 static inline void load_sp0(struct tss_struct *tss,
 			    struct thread_struct *thread)
diff --git a/arch/x86/kernel/apm_32.c b/arch/x86/kernel/apm_32.c
index 052c9c3026cc..74a3e8ca2c6d 100644
--- a/arch/x86/kernel/apm_32.c
+++ b/arch/x86/kernel/apm_32.c
@@ -2267,7 +2267,7 @@ static int __init apm_init(void)
 
 	dmi_check_system(apm_dmi_table);
 
-	if (apm_info.bios.version == 0 || paravirt_enabled() || machine_is_olpc()) {
+	if (apm_info.bios.version == 0 || paravirt_legacy() || machine_is_olpc()) {
 		printk(KERN_INFO "apm: BIOS not found.\n");
 		return -ENODEV;
 	}
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index 439df975bc7a..20a7a0df2c65 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -59,7 +59,7 @@ void common(void) {
 
 #ifdef CONFIG_PARAVIRT
 	BLANK();
-	OFFSET(PARAVIRT_enabled, pv_info, paravirt_enabled);
+	OFFSET(PARAVIRT_legacy, pv_info, paravirt_legacy);
 	OFFSET(PARAVIRT_PATCH_pv_cpu_ops, paravirt_patch_template, pv_cpu_ops);
 	OFFSET(PARAVIRT_PATCH_pv_irq_ops, paravirt_patch_template, pv_irq_ops);
 	OFFSET(PV_IRQ_irq_disable, pv_irq_ops, irq_disable);
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 209ac1e7d1f0..134b5d5d9c74 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -220,7 +220,7 @@ static void intel_workarounds(struct cpuinfo_x86 *c)
 	 * The Quark is also family 5, but does not have the same bug.
 	 */
 	clear_cpu_bug(c, X86_BUG_F00F);
-	if (!paravirt_enabled() && c->x86 == 5 && c->x86_model < 9) {
+	if (!paravirt_legacy() && c->x86 == 5 && c->x86_model < 9) {
 		static int f00f_workaround_enabled;
 
 		set_cpu_bug(c, X86_BUG_F00F);
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index b3e94ef461fd..022cc8dad97f 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -630,7 +630,7 @@ int __init microcode_init(void)
 	struct cpuinfo_x86 *c = &boot_cpu_data;
 	int error;
 
-	if (paravirt_enabled() || dis_ucode_ldr)
+	if (paravirt_legacy() || dis_ucode_ldr)
 		return -EINVAL;
 
 	if (c->x86_vendor == X86_VENDOR_INTEL)
diff --git a/arch/x86/kernel/head.c b/arch/x86/kernel/head.c
index 992f442ca155..279fad7288f8 100644
--- a/arch/x86/kernel/head.c
+++ b/arch/x86/kernel/head.c
@@ -38,7 +38,7 @@ void __init reserve_ebda_region(void)
 	 * that the paravirt case can handle memory setup
 	 * correctly, without our help.
 	 */
-	if (paravirt_enabled())
+	if (paravirt_legacy())
 		return;
 
 	/* end of low (conventional) memory */
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 47190bd399e7..e2368f73bc14 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -283,14 +283,7 @@ NOKPROBE_SYMBOL(do_async_page_fault);
 static void __init paravirt_ops_setup(void)
 {
 	pv_info.name = "KVM";
-
-	/*
-	 * KVM isn't paravirt in the sense of paravirt_enabled.  A KVM
-	 * guest kernel works like a bare metal kernel with additional
-	 * features, and paravirt_enabled is about features that are
-	 * missing.
-	 */
-	pv_info.paravirt_enabled = 0;
+	pv_info.paravirt_legacy = false;
 
 	if (kvm_para_has_feature(KVM_FEATURE_NOP_IO_DELAY))
 		pv_cpu_ops.io_delay = kvm_io_delay;
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index c2130aef3f9d..326df1ce2a11 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -312,7 +312,7 @@ enum paravirt_lazy_mode paravirt_get_lazy_mode(void)
 
 struct pv_info pv_info = {
 	.name = "bare hardware",
-	.paravirt_enabled = 0,
+	.paravirt_legacy = false,
 	.kernel_rpl = 0,
 	.shared_kernel_pmd = 1,	/* Only used when CONFIG_X86_PAE is set */
 
diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
index 91a4496db434..87a5027ff242 100644
--- a/arch/x86/kernel/tboot.c
+++ b/arch/x86/kernel/tboot.c
@@ -75,7 +75,7 @@ void __init tboot_probe(void)
 	}
 
 	/* only a natively booted kernel should be using TXT */
-	if (paravirt_enabled()) {
+	if (paravirt_legacy()) {
 		pr_warning("non-0 tboot_addr but pv_ops is enabled\n");
 		return;
 	}
diff --git a/arch/x86/lguest/boot.c b/arch/x86/lguest/boot.c
index a0d09f6c6533..eb0a42bbf41b 100644
--- a/arch/x86/lguest/boot.c
+++ b/arch/x86/lguest/boot.c
@@ -1409,7 +1409,7 @@ __init void lguest_init(void)
 	/* We're under lguest. */
 	pv_info.name = "lguest";
 	/* Paravirt is enabled. */
-	pv_info.paravirt_enabled = 1;
+	pv_info.paravirt_legacy = true;
 	/* We're running at privilege level 1, not 0 as normal. */
 	pv_info.kernel_rpl = 1;
 	/* Everyone except Xen runs with this set. */
diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
index a035c2aa7801..daf87f12a0af 100644
--- a/arch/x86/mm/dump_pagetables.c
+++ b/arch/x86/mm/dump_pagetables.c
@@ -365,7 +365,7 @@ static inline bool is_hypervisor_range(int idx)
 	 * ffff800000000000 - ffff87ffffffffff is reserved for
 	 * the hypervisor.
 	 */
-	return paravirt_enabled() &&
+	return paravirt_legacy() &&
 		(idx >= pgd_index(__PAGE_OFFSET) - 16) &&
 		(idx < pgd_index(__PAGE_OFFSET));
 }
diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
index 5774800ff583..95060b31e49c 100644
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -1186,7 +1186,7 @@ static unsigned xen_patch(u8 type, u16 clobbers, void *insnbuf,
 }
 
 static const struct pv_info xen_info __initconst = {
-	.paravirt_enabled = 1,
+	.paravirt_legacy = true,
 	.shared_kernel_pmd = 0,
 
 #ifdef CONFIG_X86_64
diff --git a/drivers/pnp/pnpbios/core.c b/drivers/pnp/pnpbios/core.c
index facd43b8516c..40557bc16005 100644
--- a/drivers/pnp/pnpbios/core.c
+++ b/drivers/pnp/pnpbios/core.c
@@ -521,7 +521,7 @@ static int __init pnpbios_init(void)
 	int ret;
 
 	if (pnpbios_disabled || dmi_check_system(pnpbios_dmi_table) ||
-	    paravirt_enabled()) {
+	    paravirt_legacy()) {
 		printk(KERN_INFO "PnPBIOS: Disabled\n");
 		return -ENODEV;
 	}
-- 
2.6.2
