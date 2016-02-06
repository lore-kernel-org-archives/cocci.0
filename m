From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Fri,  5 Feb 2016 20:30:14 -0800
Subject: [Cocci] [PATCH v2 3/3] paravirt: rename paravirt_enabled to
	paravirt_legacy
In-Reply-To: <1454733014-15237-1-git-send-email-mcgrof@kernel.org>
References: <1454733014-15237-1-git-send-email-mcgrof@kernel.org>
Message-ID: <1454733014-15237-4-git-send-email-mcgrof@kernel.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

paravirt_enabled conveys the idea that if this is set or if
paravirt_enabled() returns true you are in a paravirtualized
environment. This is not true by any means, and left as-is
is just causing confusion and is prone to be misused and abused.

This primitive is really only useful to determine if you have a
paravirtualization hypervisor that supports legacy paravirtualized
guests. At run time, this tells us if we've booted into a Linux guest
with support for legacy devices and features.

To avoid further issues with semantics on this we loosely borrow
the definition of "legacy" from both the ACPI 5.2.9.3 "IA-PC Boot
Architecture Flags" section and the PC 2001 definition in the PC
Systems design guide [0]:

  paravirt_legacy() is true if this hypervisor supports legacy
                    x86 paravirtualized guests.

Renaming the member and helper to make this clear and document
this well. With proper documentation now we can avoiding special
cased comments trying to explain what the heck this is.

[0] http://tech-insider.org/windows/research/2000/1102.html
[1] http://www.acpi.info/DOWNLOADS/ACPIspec50.pdf

v2:

* Fix 0-day bot build issue on arch/x86/entry/entry_32.S
  where I forgot to update the upper cas eoffset name,
  defined in arch/x86/kernel/asm-offsets.c

* Add more documentation and references for what exactly is
  x86 legacy, and how this inspired the notion of a paravirt
  legacy device or feature.

* Use supports_x86_legacy on the struct member to make it
  clearer what this bool is for, keep the paravirt_legacy()
  from v1.

* Split out changes into a few patches to make it easier
  to review and test.

The rename is done using the following Coccinelle SmPL patch:

@ rename_paravirt_enabled @
@@

-paravirt_enabled()
+paravirt_legacy()

@ rename_pv_info_pv_enabled @
@@
-pv_info.paravirt_enabled
+pv_info.supports_x86_legacy

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
+	.supports_x86_legacy
	= val,
};

Generated-by: Coccinelle SmPL
Suggested-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Robert Moore <robert.moore@intel.com>
Cc: Fengguang Wu <fengguang.wu at intel.com
Cc: rafael.j.wysocki at intel.com
Cc: lv.zheng at intel.com
Cc: david.e.box at intel.com
Cc: cocci at systeme.lip6.fr
cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 arch/x86/entry/entry_32.S             |  2 +-
 arch/x86/include/asm/paravirt.h       |  6 +++---
 arch/x86/include/asm/paravirt_types.h | 35 +++++++++++++++++++++++++++++++++--
 arch/x86/include/asm/processor.h      |  2 +-
 arch/x86/kernel/apm_32.c              |  2 +-
 arch/x86/kernel/asm-offsets.c         |  2 +-
 arch/x86/kernel/cpu/intel.c           |  2 +-
 arch/x86/kernel/cpu/microcode/core.c  |  2 +-
 arch/x86/kernel/head.c                |  2 +-
 arch/x86/kernel/kvm.c                 |  9 +--------
 arch/x86/kernel/paravirt.c            |  2 +-
 arch/x86/kernel/rtc.c                 |  2 +-
 arch/x86/kernel/tboot.c               |  2 +-
 arch/x86/lguest/boot.c                |  4 ++--
 arch/x86/mm/dump_pagetables.c         |  2 +-
 arch/x86/xen/enlighten.c              |  2 +-
 drivers/pnp/pnpbios/core.c            |  2 +-
 17 files changed, 52 insertions(+), 28 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 4c5228352744..6a248022549c 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -395,7 +395,7 @@ ldt_ss:
 	 * is still available to implement the setting of the high
 	 * 16-bits in the INTERRUPT_RETURN paravirt-op.
 	 */
-	cmpl	$0, pv_info+PARAVIRT_enabled
+	cmpl	$0, pv_info+PARAVIRT_legacy
 	jne	restore_nocheck
 #endif
 
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 6542aa99714b..b3885c1f2156 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -14,14 +14,14 @@
 #include <linux/types.h>
 #include <linux/cpumask.h>
 
-static inline bool paravirt_enabled(void)
+static inline bool paravirt_legacy(void)
 {
-	return pv_info.paravirt_enabled;
+	return pv_info.supports_x86_legacy;
 }
 
 static inline bool paravirt_has_feature(unsigned int feature)
 {
-	WARN_ON_ONCE(!paravirt_enabled());
+	WARN_ON_ONCE(!paravirt_legacy());
 	return !!(pv_info.features & feature);
 }
 
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index de2382b023f2..b4094a57435d 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -61,6 +61,37 @@ struct paravirt_callee_save {
 };
 
 /* general info */
+
+/**
+ * struct pv_info - paravirt hypervisor information
+ *
+ * @supports_x86_legacy: true if this hypervisor supports legacy x86
+ * 	paravirtualized guests.  The definition of legacy here adheres
+ * 	*loosely* to both the notion of legacy in the ACPI 5.2.9.3 "IA-PC Boot
+ * 	Architecture Flags" section and the PC 2001 "legacy free" concept [1]
+ * 	referred to in the PC System Design Guide [2] [3] on Chapter 3, Page 50
+ * 	[4].  Legacy x86 guests systems are guest systems which are not "legacy
+ * 	free" as per the PC 2001 definition, and in the ACPI sense could have
+ * 	any of the legacy ACPI IA-PC Boot architecture flags set. These are x86
+ * 	systems with any type of legacy peripherals or requirements.
+ *
+ *	Examples of some popular legacy peripherals:
+ *
+ *	  a) Floppy drive
+ *	  b) Legacy ports [1] such as such as parallel ports, PS/2 connectors,
+ *	     serial ports / RS-232, game ports Parallel ATA, and IEEE 1394
+ *	  c) ISA bus
+ *
+ *	Examples of features required to support such type of legacy guests
+ *	are the need for APM and a PNP BIOS.
+ *
+ * 	[0] http://www.acpi.info/DOWNLOADS/ACPIspec50.pdf
+ *	[1] https://en.wikipedia.org/wiki/Legacy-free_PC
+ *	[2] https://en.wikipedia.org/wiki/PC_System_Design_Guide
+ *	[3] http://tech-insider.org/windows/research/2000/1102.html
+ *	[4] http://tech-insider.org/windows/research/acrobat/001102/03sys-2001.pdf
+ *	[5] https://en.wikipedia.org/wiki/Legacy_port
+ */
 struct pv_info {
 	unsigned int kernel_rpl;
 	int shared_kernel_pmd;
@@ -69,8 +100,8 @@ struct pv_info {
 	u16 extra_user_64bit_cs;  /* __USER_CS if none */
 #endif
 
-	bool paravirt_enabled;
-	unsigned int features;	  /* valid only if paravirt_enabled is set */
+	bool supports_x86_legacy;
+	unsigned int features;	  /* valid only on pv x86 legacy systems */
 	const char *name;
 };
 
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 5a8e7a61d5be..6052a038b27f 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -470,7 +470,7 @@ static inline unsigned long current_top_of_stack(void)
 #include <asm/paravirt.h>
 #else
 #define __cpuid			native_cpuid
-#define paravirt_enabled()	false
+#define paravirt_legacy()	false
 #define paravirt_has(x) 	false
 
 static inline void load_sp0(struct tss_struct *tss,
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
index 84a7524b202c..f49b9cbf0561 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -59,7 +59,7 @@ void common(void) {
 
 #ifdef CONFIG_PARAVIRT
 	BLANK();
-	OFFSET(PARAVIRT_enabled, pv_info, paravirt_enabled);
+	OFFSET(PARAVIRT_legacy, pv_info, supports_x86_legacy);
 	OFFSET(PARAVIRT_PATCH_pv_cpu_ops, paravirt_patch_template, pv_cpu_ops);
 	OFFSET(PARAVIRT_PATCH_pv_irq_ops, paravirt_patch_template, pv_irq_ops);
 	OFFSET(PV_IRQ_irq_disable, pv_irq_ops, irq_disable);
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 6040bd71679f..aab7d031f612 100644
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
index faec7120c508..5137e06028b3 100644
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
index 5c717b247e1b..177773e75b4d 100644
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
-	pv_info.paravirt_enabled = false;
+	pv_info.supports_x86_legacy = false;
 
 	if (kvm_para_has_feature(KVM_FEATURE_NOP_IO_DELAY))
 		pv_cpu_ops.io_delay = kvm_io_delay;
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 6b1f205a6ac7..a2ccb328c287 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -294,7 +294,7 @@ enum paravirt_lazy_mode paravirt_get_lazy_mode(void)
 
 struct pv_info pv_info = {
 	.name = "bare hardware",
-	.paravirt_enabled = false,
+	.supports_x86_legacy = false,
 	.kernel_rpl = 0,
 	.shared_kernel_pmd = 1,	/* Only used when CONFIG_X86_PAE is set */
 
diff --git a/arch/x86/kernel/rtc.c b/arch/x86/kernel/rtc.c
index 4af8d063fb36..1d20e3347906 100644
--- a/arch/x86/kernel/rtc.c
+++ b/arch/x86/kernel/rtc.c
@@ -200,7 +200,7 @@ static __init int add_rtc_cmos(void)
 	}
 #endif
 
-	if (paravirt_enabled() && !paravirt_has(RTC))
+	if (paravirt_legacy() && !paravirt_has(RTC))
 		return -ENODEV;
 
 	platform_device_register(&rtc_device);
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
index c6f302f6dedb..dc33156e4d53 100644
--- a/arch/x86/lguest/boot.c
+++ b/arch/x86/lguest/boot.c
@@ -1408,8 +1408,8 @@ __init void lguest_init(void)
 {
 	/* We're under lguest. */
 	pv_info.name = "lguest";
-	/* Paravirt is enabled. */
-	pv_info.paravirt_enabled = true;
+	/* Hypervisor supports x86 legacy guest systems . */
+	pv_info.supports_x86_legacy = true;
 	/* We're running at privilege level 1, not 0 as normal. */
 	pv_info.kernel_rpl = 1;
 	/* Everyone except Xen runs with this set. */
diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
index 4a6f1d9b5106..e9cc69c5ad54 100644
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
index e303e0043881..2485a1613c2f 100644
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -1186,7 +1186,7 @@ static unsigned xen_patch(u8 type, u16 clobbers, void *insnbuf,
 }
 
 static const struct pv_info xen_info __initconst = {
-	.paravirt_enabled = true,
+	.supports_x86_legacy = true,
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
2.7.0
