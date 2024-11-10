Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C71C6D5E36A
	for <cocci@archiver.kernel.org>; Sun, 10 Nov 2024 01:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=EwXDCzrK8F84PS3eww8O2CHlWgO5J8X0dG0sjLkqit8=;
  b=uOdoaq7IqnWN6GHmJbNZNsYq+lgi0YkesQSsWLLf6HrdvJQfAHk5ybty
   q9sb5utMsHHq5WypiCEgjtqCEJOwClnRgBqza1va+19HYV3FJhDtINeI3
   yLXlq/WhgvvOTHTbwKJRH+dCZ5fZJEyWig+2qLe2fl8+zLETaVU4YDW9R
   w=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@kernel.org
X-IronPort-AV: E=Sophos;i="6.12,142,1728943200"; 
   d="scan'208";a="193076952"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Nov 2024 02:37:11 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1E143E0133; Sun, 10 Nov 2024 02:37:11 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id BE90DE00B7
	for <cocci@sympa.inria.fr>; Sun, 10 Nov 2024 02:37:03 +0100 (CET)
IronPort-SDR: 67300e3e_CgNcmZgwJo5Y/VjUn9oNs085UCvvDWc2KgzmZv4wFpf7TDT
 Gz0Uby6MoSAWSV+T1CbZGU4VEaOviMfFlEpBo6w==
X-IPAS-Result: =?us-ascii?q?A0FcAQCQDTBnhdlUsotaHgEBCxIMgggLghwofVozBAtIi?=
 =?us-ascii?q?CWFLYhynhiBfg8BAwENMRMEAQEDAQOFAAKKOwIeBwEEMAkOAQIEAQEBAQMCA?=
 =?us-ascii?q?wEBAQEBARABAQUBAQECAQECBAYBAhABAQEBQEmFew2CYgEzcYElAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAR0CDX4CAQMyAQ0BATcBD1FWGYMBAYJkA7IYgQGCDAEBBoEI2xeBZ?=
 =?us-ascii?q?AmBSIVqh1xwRIM5eicbgUlEglCBN3aEWIYvgkdqSoNoJYcqgWuBb4waHTOKA?=
 =?us-ascii?q?EiBIQNZIREBVRMNCgsHBWCBFwOCVnorgQ6BFzqBfoEiSoUaRj+CSmlNNwINA?=
 =?us-ascii?q?jaCJH2CT4UdhG9nLwMDAwODRYJAQAMLGA1IESw1FBsGPm4HnjcBRoMtAQF6E?=
 =?us-ascii?q?wEvE4F9k2KRfKEDhCSBY4ozlSkaM4QEgVaRZUaSSJh3o2EmNoRmgWc6gVwzG?=
 =?us-ascii?q?jCDKglGAxkPjiEZH3YBAYFshByBVoE9v1M0NTsCBwsBAQMJjneBSwEB?=
IronPort-PHdr: A9a23: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
 RwSzuGgRbk=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:iZXlnKP40J+w88BcTs6jsMiBIKoaSvp037Dk7S5MoHtuA6qlfq
 WV8cjzuiWVtN98Yh0dcJW7Scy9qBDnhPlICOsqTNSftWDd0QPCRr2Kr7GSpwEIcBeeygcy78
 hdmtBFeb/NMWQ=
X-Talos-CUID: 9a23:1sqiKm5mzVtE3MaOeNss6hc+HcR6XUbmx27iMnXnAn9CTrCnVgrF
X-Talos-MUID: 9a23:ib9fXgQOV6bdgBEpRXSr2gpFN8dH256IJ2kEtr4gtParK29/bmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,142,1728943200"; 
   d="scan'208";a="101200583"
X-MGA-submission: =?us-ascii?q?MDE4MvA0XBh5a18/vvDS8Y3RcG3uobUUj8jMBo?=
 =?us-ascii?q?2rhsTXn3jfAIEsqaJn96YfjFmeo9ObBE2jdKwVaUzEPqlh/PHteFx/hX?=
 =?us-ascii?q?+/0wlh/O9+sKLoKycgLhYzPMnCjykLdTWhszl/TFSUPsUu+fRPcK3HML?=
 =?us-ascii?q?9KMwTtiun9PjGvd9SkEdKJwg=3D=3D?=
Received: from dfw.source.kernel.org ([139.178.84.217])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2024 02:37:02 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id CAD9C5C576A;
	Sun, 10 Nov 2024 01:36:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1433C4CED4;
	Sun, 10 Nov 2024 01:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731202621;
	bh=6i1YYERXoeK4NchDSXf7fBlYYK9mmrlTiZyLP0h7vss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iEh8VqkPzPuEgZNPH3JpYX1chq5w5yux7r0655wlb4LVkns8l8XFiXqVR5weZZ1v0
	 eMPSlFtK3Aq4//BKzP0+CHMzMoQUZLP2N5t2rry5sU237lkRIbIc+WsDDofMaGIYV0
	 haVd1X1MrizC+md/6FGJTuuwsbD9tx7d0f7pHwnnLbgE1CBQZkARbuvOpwWzg7K9jz
	 QEo1zLsNmSJvg0NsqbMhXOXAy/YThw6WwQ58t/CqE8Y9BhZQri+alX87/9SQxBvsDs
	 eLO0+qEMooWkS3o1ygYLpB0DJ2oJJRs792MCzfby3F/Bj1dFGdo9ahnZlwbBspUkru
	 fGUjf/+t+/bFw==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	cocci@inria.fr,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>
Date: Sun, 10 Nov 2024 10:34:30 +0900
Message-ID: <20241110013649.34903-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241110013649.34903-1-masahiroy@kernel.org>
References: <20241110013649.34903-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [cocci] [PATCH v2 02/11] kbuild: add $(objtree)/ prefix to some
 in-kernel build artifacts
Reply-To: Masahiro Yamada <masahiroy@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 1977
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/20241110013649.34903-3-masahiroy%40kernel.org>

$(objtree) refers to the top of the output directory of kernel builds.

This commit adds the explicit $(objtree)/ prefix to build artifacts
needed for building external modules.

This change has no immediate impact, as the top-level Makefile
currently defines:

  objtree         := .

This commit prepares for supporting the building of external modules
in a different directory.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
---

Changes in v2:
  - Add more $(objtree)/ to arch/*/Makefile

 Makefile                  | 10 +++++-----
 arch/arm/Makefile         |  4 ++--
 arch/arm64/Makefile       |  2 +-
 arch/powerpc/Makefile     |  4 ++--
 arch/riscv/Makefile       |  2 +-
 scripts/Kbuild.include    |  2 +-
 scripts/Makefile.build    |  4 ++--
 scripts/Makefile.modfinal | 14 +++++++-------
 scripts/Makefile.modinst  |  2 +-
 scripts/Makefile.modpost  | 12 ++++++------
 scripts/depmod.sh         |  4 ++--
 11 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/Makefile b/Makefile
index 891d28e54791..9b8f4f4cb01b 100644
--- a/Makefile
+++ b/Makefile
@@ -354,7 +354,7 @@ else # !mixed-build
 include $(srctree)/scripts/Kbuild.include
 
 # Read KERNELRELEASE from include/config/kernel.release (if it exists)
-KERNELRELEASE = $(call read-file, include/config/kernel.release)
+KERNELRELEASE = $(call read-file, $(objtree)/include/config/kernel.release)
 KERNELVERSION = $(VERSION)$(if $(PATCHLEVEL),.$(PATCHLEVEL)$(if $(SUBLEVEL),.$(SUBLEVEL)))$(EXTRAVERSION)
 export VERSION PATCHLEVEL SUBLEVEL KERNELRELEASE KERNELVERSION
 
@@ -720,7 +720,7 @@ endif
 export KBUILD_MODULES KBUILD_BUILTIN
 
 ifdef need-config
-include include/config/auto.conf
+include $(objtree)/include/config/auto.conf
 endif
 
 ifeq ($(KBUILD_EXTMOD),)
@@ -783,13 +783,13 @@ else # !may-sync-config
 # and include/config/auto.conf but do not care if they are up-to-date.
 # Use auto.conf to show the error message
 
-checked-configs := include/generated/autoconf.h include/generated/rustc_cfg include/config/auto.conf
+checked-configs := $(addprefix $(objtree)/, include/generated/autoconf.h include/generated/rustc_cfg include/config/auto.conf)
 missing-configs := $(filter-out $(wildcard $(checked-configs)), $(checked-configs))
 
 ifdef missing-configs
-PHONY += include/config/auto.conf
+PHONY += $(objtree)/include/config/auto.conf
 
-include/config/auto.conf:
+$(objtree)/include/config/auto.conf:
 	@echo   >&2 '***'
 	@echo   >&2 '***  ERROR: Kernel configuration is invalid. The following files are missing:'
 	@printf >&2 '***    - %s\n' $(missing-configs)
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index aafebf145738..00ca7886b18e 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -264,13 +264,13 @@ stack_protector_prepare: prepare0
 		-mstack-protector-guard=tls \
 		-mstack-protector-guard-offset=$(shell	\
 			awk '{if ($$2 == "TSK_STACK_CANARY") print $$3;}'\
-				include/generated/asm-offsets.h))
+				$(objtree)/include/generated/asm-offsets.h))
 else
 stack_protector_prepare: prepare0
 	$(eval SSP_PLUGIN_CFLAGS := \
 		-fplugin-arg-arm_ssp_per_task_plugin-offset=$(shell	\
 			awk '{if ($$2 == "TSK_STACK_CANARY") print $$3;}'\
-				include/generated/asm-offsets.h))
+				$(objtree)/include/generated/asm-offsets.h))
 	$(eval KBUILD_CFLAGS += $(SSP_PLUGIN_CFLAGS))
 	$(eval GCC_PLUGINS_CFLAGS += $(SSP_PLUGIN_CFLAGS))
 endif
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 9efd3f37c2fd..358c68565bfd 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -71,7 +71,7 @@ stack_protector_prepare: prepare0
 				-mstack-protector-guard-reg=sp_el0	  \
 				-mstack-protector-guard-offset=$(shell	  \
 			awk '{if ($$2 == "TSK_STACK_CANARY") print $$3;}' \
-					include/generated/asm-offsets.h))
+				$(objtree)/include/generated/asm-offsets.h))
 endif
 
 ifeq ($(CONFIG_ARM64_BTI_KERNEL),y)
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index bbfe4a1f06ef..321b596d2550 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -402,9 +402,9 @@ prepare: stack_protector_prepare
 PHONY += stack_protector_prepare
 stack_protector_prepare: prepare0
 ifdef CONFIG_PPC64
-	$(eval KBUILD_CFLAGS += -mstack-protector-guard-offset=$(shell awk '{if ($$2 == "PACA_CANARY") print $$3;}' include/generated/asm-offsets.h))
+	$(eval KBUILD_CFLAGS += -mstack-protector-guard-offset=$(shell awk '{if ($$2 == "PACA_CANARY") print $$3;}' $(objtree)/include/generated/asm-offsets.h))
 else
-	$(eval KBUILD_CFLAGS += -mstack-protector-guard-offset=$(shell awk '{if ($$2 == "TASK_CANARY") print $$3;}' include/generated/asm-offsets.h))
+	$(eval KBUILD_CFLAGS += -mstack-protector-guard-offset=$(shell awk '{if ($$2 == "TASK_CANARY") print $$3;}' $(objtree)/include/generated/asm-offsets.h))
 endif
 endif
 
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index d469db9f46f4..a08cfeb6cbf9 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -129,7 +129,7 @@ stack_protector_prepare: prepare0
 				-mstack-protector-guard-reg=tp		  \
 				-mstack-protector-guard-offset=$(shell	  \
 			awk '{if ($$2 == "TSK_STACK_CANARY") print $$3;}' \
-					include/generated/asm-offsets.h))
+				$(objtree)/include/generated/asm-offsets.h))
 endif
 
 # arch specific predefines for sparse
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index ed8a7493524b..8c311b997e24 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -205,7 +205,7 @@ if_changed_dep = $(if $(if-changed-cond),$(cmd_and_fixdep),@:)
 
 cmd_and_fixdep =                                                             \
 	$(cmd);                                                              \
-	scripts/basic/fixdep $(depfile) $@ '$(make-cmd)' > $(dot-target).cmd;\
+	$(objtree)/scripts/basic/fixdep $(depfile) $@ '$(make-cmd)' > $(dot-target).cmd;\
 	rm -f $(depfile)
 
 # Usage: $(call if_changed_rule,foo)
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 8f423a1faf50..64cd046f8fd8 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -34,7 +34,7 @@ subdir-asflags-y :=
 subdir-ccflags-y :=
 
 # Read auto.conf if it exists, otherwise ignore
--include include/config/auto.conf
+-include $(objtree)/include/config/auto.conf
 
 include $(srctree)/scripts/Kbuild.include
 include $(srctree)/scripts/Makefile.compiler
@@ -107,7 +107,7 @@ cmd_cpp_i_c       = $(CPP) $(c_flags) -o $@ $<
 $(obj)/%.i: $(obj)/%.c FORCE
 	$(call if_changed_dep,cpp_i_c)
 
-genksyms = scripts/genksyms/genksyms		\
+genksyms = $(objtree)/scripts/genksyms/genksyms	\
 	$(if $(1), -T $(2))			\
 	$(if $(KBUILD_PRESERVE), -p)		\
 	-r $(or $(wildcard $(2:.symtypes=.symref)), /dev/null)
diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index 1482884ec3ca..6d8aa3059ee2 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -6,7 +6,7 @@
 PHONY := __modfinal
 __modfinal:
 
-include include/config/auto.conf
+include $(objtree)/include/config/auto.conf
 include $(srctree)/scripts/Kbuild.include
 
 # for c_flags
@@ -37,15 +37,15 @@ quiet_cmd_ld_ko_o = LD [M]  $@
       cmd_ld_ko_o =							\
 	$(LD) -r $(KBUILD_LDFLAGS)					\
 		$(KBUILD_LDFLAGS_MODULE) $(LDFLAGS_MODULE)		\
-		-T scripts/module.lds -o $@ $(filter %.o, $^)
+		-T $(objtree)/scripts/module.lds -o $@ $(filter %.o, $^)
 
 quiet_cmd_btf_ko = BTF [M] $@
       cmd_btf_ko = 							\
-	if [ ! -f vmlinux ]; then					\
+	if [ ! -f $(objtree)/vmlinux ]; then				\
 		printf "Skipping BTF generation for %s due to unavailability of vmlinux\n" $@ 1>&2; \
 	else								\
-		LLVM_OBJCOPY="$(OBJCOPY)" $(PAHOLE) -J $(PAHOLE_FLAGS) $(MODULE_PAHOLE_FLAGS) --btf_base vmlinux $@; \
-		$(RESOLVE_BTFIDS) -b vmlinux $@; 			\
+		LLVM_OBJCOPY="$(OBJCOPY)" $(PAHOLE) -J $(PAHOLE_FLAGS) $(MODULE_PAHOLE_FLAGS) --btf_base $(objtree)/vmlinux $@; \
+		$(RESOLVE_BTFIDS) -b $(objtree)/vmlinux $@;		\
 	fi;
 
 # Same as newer-prereqs, but allows to exclude specified extra dependencies
@@ -57,8 +57,8 @@ if_changed_except = $(if $(call newer_prereqs_except,$(2))$(cmd-check),      \
 	printf '%s\n' 'savedcmd_$@ := $(make-cmd)' > $(dot-target).cmd, @:)
 
 # Re-generate module BTFs if either module's .ko or vmlinux changed
-%.ko: %.o %.mod.o $(extmod_prefix).module-common.o scripts/module.lds $(and $(CONFIG_DEBUG_INFO_BTF_MODULES),$(KBUILD_BUILTIN),vmlinux) FORCE
-	+$(call if_changed_except,ld_ko_o,vmlinux)
+%.ko: %.o %.mod.o $(extmod_prefix).module-common.o $(objtree)/scripts/module.lds $(and $(CONFIG_DEBUG_INFO_BTF_MODULES),$(KBUILD_BUILTIN),$(objtree)/vmlinux) FORCE
+	+$(call if_changed_except,ld_ko_o,$(objtree)/vmlinux)
 ifdef CONFIG_DEBUG_INFO_BTF_MODULES
 	+$(if $(newer-prereqs),$(call cmd,btf_ko))
 endif
diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
index d97720943189..6fa9af4a25b4 100644
--- a/scripts/Makefile.modinst
+++ b/scripts/Makefile.modinst
@@ -6,7 +6,7 @@
 PHONY := __modinst
 __modinst:
 
-include include/config/auto.conf
+include $(objtree)/include/config/auto.conf
 include $(srctree)/scripts/Kbuild.include
 
 install-y :=
diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index 44936ebad161..12e7c15d099c 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -35,10 +35,10 @@
 PHONY := __modpost
 __modpost:
 
-include include/config/auto.conf
+include $(objtree)/include/config/auto.conf
 include $(srctree)/scripts/Kbuild.include
 
-MODPOST = scripts/mod/modpost
+MODPOST = $(objtree)/scripts/mod/modpost
 
 modpost-args =										\
 	$(if $(CONFIG_MODULES),-M)							\
@@ -119,11 +119,11 @@ include $(kbuild-file)
 
 output-symdump := $(KBUILD_EXTMOD)/Module.symvers
 
-ifeq ($(wildcard Module.symvers),)
-missing-input := Module.symvers
+ifeq ($(wildcard $(objtree)/Module.symvers),)
+missing-input := $(objtree)/Module.symvers
 else
-modpost-args += -i Module.symvers
-modpost-deps += Module.symvers
+modpost-args += -i $(objtree)/Module.symvers
+modpost-deps += $(objtree)/Module.symvers
 endif
 
 modpost-args += -e $(addprefix -i , $(KBUILD_EXTRA_SYMBOLS))
diff --git a/scripts/depmod.sh b/scripts/depmod.sh
index e22da27fe13e..3c34fecacbc8 100755
--- a/scripts/depmod.sh
+++ b/scripts/depmod.sh
@@ -12,7 +12,7 @@ KERNELRELEASE=$1
 
 : ${DEPMOD:=depmod}
 
-if ! test -r System.map ; then
+if ! test -r "${objtree}/System.map" ; then
 	echo "Warning: modules_install: missing 'System.map' file. Skipping depmod." >&2
 	exit 0
 fi
@@ -25,7 +25,7 @@ if [ -z $(command -v $DEPMOD) ]; then
 	exit 0
 fi
 
-set -- -ae -F System.map
+set -- -ae -F "${objtree}/System.map"
 if test -n "$INSTALL_MOD_PATH"; then
 	set -- "$@" -b "$INSTALL_MOD_PATH"
 fi
-- 
2.43.0

