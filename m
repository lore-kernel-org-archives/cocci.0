From: bp@alien8.de (Borislav Petkov)
Date: Mon, 8 Feb 2016 17:35:26 +0100
Subject: [Cocci] [Xen-devel] [PATCH v2 3/3] paravirt: rename
 paravirt_enabled to paravirt_legacy
In-Reply-To: <56B8C2C8.8050406@oracle.com>
References: <CALCETrU3DaqUeo-n2dV_UmeAcTEV2dQRtxyb-atMP6WFDDif3Q@mail.gmail.com>
 <20160206085930.GF25240@wotan.suse.de>
 <CALCETrWSiN+te_0aYH0NH9oBzGALLhKqxkupiGwbAm2GdCNyVQ@mail.gmail.com>
 <20160206220437.GA4435@pd.tnic> <56B8B6BF.6030007@oracle.com>
 <20160208155507.GF28980@pd.tnic> <56B8BCDB.9040701@citrix.com>
 <56B8BE58.6070003@oracle.com> <56B8C1BC.9040603@citrix.com>
 <56B8C2C8.8050406@oracle.com>
Message-ID: <20160208163526.GI28980@pd.tnic>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, Feb 08, 2016 at 11:31:04AM -0500, Boris Ostrovsky wrote:
> I think we are OK for PV because this code will be executed after pvops are
> set and so we will be calling xen_cpuid().

Not for the early loader - it is too early for pvops then. So you're
saying something like that won't work?

---
diff --git a/arch/x86/include/asm/hypervisor.h b/arch/x86/include/asm/hypervisor.h
index 055ea9941dd5..f3e563e8b5c3 100644
--- a/arch/x86/include/asm/hypervisor.h
+++ b/arch/x86/include/asm/hypervisor.h
@@ -56,9 +56,11 @@ extern const struct hypervisor_x86 x86_hyper_kvm;
 extern void init_hypervisor(struct cpuinfo_x86 *c);
 extern void init_hypervisor_platform(void);
 extern bool hypervisor_x2apic_available(void);
+bool is_xen_hypervisor(void);
 #else
 static inline void init_hypervisor(struct cpuinfo_x86 *c) { }
 static inline void init_hypervisor_platform(void) { }
 static inline bool hypervisor_x2apic_available(void) { return false; }
+static inline bool is_xen_hypervisor(void) { return false; }
 #endif /* CONFIG_HYPERVISOR_GUEST */
 #endif /* _ASM_X86_HYPERVISOR_H */
diff --git a/arch/x86/kernel/cpu/hypervisor.c b/arch/x86/kernel/cpu/hypervisor.c
index d820d8eae96b..bda29017f946 100644
--- a/arch/x86/kernel/cpu/hypervisor.c
+++ b/arch/x86/kernel/cpu/hypervisor.c
@@ -85,3 +85,24 @@ bool __init hypervisor_x2apic_available(void)
 	       x86_hyper->x2apic_available &&
 	       x86_hyper->x2apic_available();
 }
+
+bool is_xen_hypervisor(void)
+{
+	u32 eax, ebx, ecx, edx;
+
+	eax = 0x4000000;
+	ecx = 0;
+	native_cpuid(&eax, &ebx, &ecx, &edx);
+
+	if (ebx == 0x566e6558 && ecx == 0x65584d4d && edx == 0x4d4d566e)
+		return true;
+
+	eax = 0x40000100;
+	ecx = 0;
+	native_cpuid(&eax, &ebx, &ecx, &edx);
+
+	if (ebx == 0x566e6558 && ecx == 0x65584d4d && edx == 0x4d4d566e)
+		return true;
+
+	return false;
+}
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index cea8552e2b3a..0a941ff8095c 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -35,6 +35,7 @@
 #include <asm/microcode_intel.h>
 #include <asm/cpu_device_id.h>
 #include <asm/microcode_amd.h>
+#include <asm/hypervisor.h>
 #include <asm/perf_event.h>
 #include <asm/microcode.h>
 #include <asm/processor.h>
@@ -86,7 +87,7 @@ static bool __init check_loader_disabled_bsp(void)
 	bool *res = &dis_ucode_ldr;
 #endif
 
-	if (cmdline_find_option_bool(cmdline, option))
+	if (cmdline_find_option_bool(cmdline, option) || is_xen_hypervisor())
 		*res = true;
 
 	return *res;


-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
