Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E65A0D5E390
	for <cocci@archiver.kernel.org>; Sun, 10 Nov 2024 01:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=D2r6bufLfFAcPp1iqWJa+TjUg9Q/79r34GOWgWVKJcM=;
  b=cBzB+hrfiF5S9j8NnEuiQk5GDxWGS7kDYBejhmMaWTSI568Y9LI+4m2l
   tkCoBfwXQtauUMuILS1EoGUQZ8sIhSvgtfYphCbi7mepicSvH2oSpPuNf
   iFik3Kqp4lhS1f0JagTeERyuEgN7UDyMcjApEUXhRAWI5ofV9MvTOIcX5
   o=;
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
   d="scan'208";a="193077076"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Nov 2024 02:37:15 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5A1B9E00B7; Sun, 10 Nov 2024 02:37:14 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 07FBCE00B7
	for <cocci@sympa.inria.fr>; Sun, 10 Nov 2024 02:37:11 +0100 (CET)
IronPort-SDR: 67300e46_2fLVsIKZU0etJbw0FIsoUFE0wOd2HLpwXUpkEU8QV0ps3j4
 cWcmGDZ5bjErDm06AHQZuk3VSe0ijGwB6YpZv3w==
X-IPAS-Result: =?us-ascii?q?A0EXAACQDTBnhdlUsotaHQEBAQEJARIBBQUBgX8IAQsBg?=
 =?us-ascii?q?kN9WjMEC0iIJYROX4hygRaSCYp5gX4PAQMBDTUPBAEBAwEDhQACijsCHgcBB?=
 =?us-ascii?q?DAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQEBAUBJhXsNg?=
 =?us-ascii?q?mIBgSSBJQEBAQEBAQEBAQEBAQEdAg1+AgEDMgENAQE3AQ9RVhmDAQGCZAOyG?=
 =?us-ascii?q?IEBggwBAQaBCNsXgWQJgUgBhWmHXHCDfXonG4FJRIEVgTuBN3aEWIYvgkdqh?=
 =?us-ascii?q?CASJYkVgW+MGh0zigBIgSEDWSERAVUTDQoLBwVggRcDglZ6K4EOgRc6gX6BI?=
 =?us-ascii?q?kqFGkY/gkppTTcCDQI2giR9gk+FHYRvZy8DAwMDg0WCQEADCxgNSBEsNRQbB?=
 =?us-ascii?q?j5uB543AUaDLgGBDQF7UF0Xk06SEKEDhCSBY4ozlSkaM4QEgVaRZUaSSC6IA?=
 =?us-ascii?q?JBJpD2EZoFnOoFcMxowQ4JnCUYDGQ+OIRkfhwCBVlFsv1M0NTsCBwsBAQMJj?=
 =?us-ascii?q?neBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:BXoxnaEUIT+7A4I+pLqE58eALOsnbusQ8zAXPo5KJyC9Ffbo8f
 xG+c536faaslYssR0b9exofZPwJE80lqQFhrX5X43SPzUO0VHAROoJ0WKh+UyFJ8SUzI9gPM
 lbHJSWcOeAb2RHsQ==
X-Talos-CUID: =?us-ascii?q?9a23=3AY5YKDmhE82HjwYvJzU1yTEmbBTJuYCDswHvyOlO?=
 =?us-ascii?q?BMG9tVayVGWOf5YZ9jJ87?=
X-Talos-MUID: 9a23:DvDxrQS+LDERdVeXRXT1rRp9P/tzw5+UFUYQlZpegZGldilJbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,142,1728943200"; 
   d="scan'208";a="101200589"
X-MGA-submission: =?us-ascii?q?MDFodM4+MBOG3QD8+xzmCljSOKVn4ZdIZDeLTc?=
 =?us-ascii?q?9rT2cChHxrN0YFTiC+PPRvug+ipKdgtvup89Y9tzrv01rRQAote2LuEe?=
 =?us-ascii?q?q06WUvLPDt/4BL+luzo3jrRA3lg//Py0D3LV6ozSa8RyM0rGztpfuxfE?=
 =?us-ascii?q?v4QeoVZ5St455TMD3AHI4ehA=3D=3D?=
Received: from dfw.source.kernel.org ([139.178.84.217])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2024 02:37:09 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 17F205C137C;
	Sun, 10 Nov 2024 01:36:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13FA1C4CED8;
	Sun, 10 Nov 2024 01:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731202628;
	bh=BhVBR2hhzdfNMnrLYX5uGVTvLEYjQ0ro7XBUDNN+P64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uWGrXmo3OaqsolvcUncI7F8NnDPtJEviXVOkvhh9spAMVKgwDmrlTx4k67gb1Ona4
	 LQmgRk3eHiVymIGeYDdXZYuZiUQ4/vfIfAj6DVOBeLe2X2S92I2PWGq+I8DFFWwWo7
	 EMUCrGtRx6Ad60NUR8xsAsQqSJUVxylGwJ9Y/wytiKfc409BjIiuPEHVgfndW0BAKt
	 ne7TojjqzJgbE6QZAyZwDaNm8YweRLCSuumaxHRtSyi2YM7qpYRO+BHranSKc6F5KE
	 TQpKiSMi+NRiZNn6roJEixDxTODdAfT4dQh0hcWfNJ7kM7A5dLoJsyuw7d2JrKTXNq
	 /IrgL3rrdJtOw==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	cocci@inria.fr,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>
Date: Sun, 10 Nov 2024 10:34:34 +0900
Message-ID: <20241110013649.34903-7-masahiroy@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241110013649.34903-1-masahiroy@kernel.org>
References: <20241110013649.34903-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [cocci] [PATCH v2 06/11] kbuild: remove extmod_prefix, MODORDER,
 MODULES_NSDEPS variables
Reply-To: Masahiro Yamada <masahiroy@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 1981
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/20241110013649.34903-7-masahiroy%40kernel.org>

With the previous changes, $(extmod_prefix), $(MODORDER), and
$(MODULES_NSDEPS) are constant. (empty, modules.order, and
modules.nsdeps, respectively).

Remove these variables and hard-code their values.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
---

Changes in v2:
 - More cleanups

 Makefile                  | 22 +++++++++-------------
 scripts/Makefile.modfinal |  8 ++++----
 scripts/Makefile.modinst  |  6 +++---
 scripts/Makefile.modpost  |  6 +++---
 scripts/nsdeps            |  2 +-
 5 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/Makefile b/Makefile
index e5f7ac7647a7..c7eeb10455b6 100644
--- a/Makefile
+++ b/Makefile
@@ -1122,10 +1122,6 @@ export MODLIB
 
 PHONY += prepare0
 
-export extmod_prefix =
-export MODORDER := $(extmod_prefix)modules.order
-export MODULES_NSDEPS := $(extmod_prefix)modules.nsdeps
-
 ifeq ($(KBUILD_EXTMOD),)
 
 build-dir	:= .
@@ -1876,7 +1872,7 @@ endif
 
 ifdef CONFIG_MODULES
 
-$(MODORDER): $(build-dir)
+modules.order: $(build-dir)
 	@:
 
 # KBUILD_MODPOST_NOFINAL can be set to skip the final link of modules.
@@ -1887,7 +1883,7 @@ ifneq ($(KBUILD_MODPOST_NOFINAL),1)
 endif
 
 PHONY += modules_check
-modules_check: $(MODORDER)
+modules_check: modules.order
 	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/modules-check.sh $<
 
 else # CONFIG_MODULES
@@ -1928,15 +1924,15 @@ $(single-ko): single_modules
 $(single-no-ko): $(build-dir)
 	@:
 
-# Remove MODORDER when done because it is not the real one.
+# Remove modules.order when done because it is not the real one.
 PHONY += single_modules
 single_modules: $(single-no-ko) modules_prepare
-	$(Q){ $(foreach m, $(single-ko), echo $(extmod_prefix)$(m:%.ko=%.o);) } > $(MODORDER)
+	$(Q){ $(foreach m, $(single-ko), echo $(m:%.ko=%.o);) } > modules.order
 	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modpost
 ifneq ($(KBUILD_MODPOST_NOFINAL),1)
 	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modfinal
 endif
-	$(Q)rm -f $(MODORDER)
+	$(Q)rm -f modules.order
 
 single-goals := $(addprefix $(build-dir)/, $(single-no-ko))
 
@@ -2013,12 +2009,12 @@ nsdeps: modules
 quiet_cmd_gen_compile_commands = GEN     $@
       cmd_gen_compile_commands = $(PYTHON3) $< -a $(AR) -o $@ $(filter-out $<, $(real-prereqs))
 
-$(extmod_prefix)compile_commands.json: $(srctree)/scripts/clang-tools/gen_compile_commands.py \
+compile_commands.json: $(srctree)/scripts/clang-tools/gen_compile_commands.py \
 	$(if $(KBUILD_EXTMOD),, vmlinux.a $(KBUILD_VMLINUX_LIBS)) \
-	$(if $(CONFIG_MODULES), $(MODORDER)) FORCE
+	$(if $(CONFIG_MODULES), modules.order) FORCE
 	$(call if_changed,gen_compile_commands)
 
-targets += $(extmod_prefix)compile_commands.json
+targets += compile_commands.json
 
 PHONY += clang-tidy clang-analyzer
 
@@ -2026,7 +2022,7 @@ ifdef CONFIG_CC_IS_CLANG
 quiet_cmd_clang_tools = CHECK   $<
       cmd_clang_tools = $(PYTHON3) $(srctree)/scripts/clang-tools/run-clang-tools.py $@ $<
 
-clang-tidy clang-analyzer: $(extmod_prefix)compile_commands.json
+clang-tidy clang-analyzer: compile_commands.json
 	$(call cmd,clang_tools)
 else
 clang-tidy clang-analyzer:
diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index 6d8aa3059ee2..bab53884f7e3 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -13,7 +13,7 @@ include $(srctree)/scripts/Kbuild.include
 include $(srctree)/scripts/Makefile.lib
 
 # find all modules listed in modules.order
-modules := $(call read-file, $(MODORDER))
+modules := $(call read-file, modules.order)
 
 __modfinal: $(modules:%.o=%.ko)
 	@:
@@ -30,7 +30,7 @@ quiet_cmd_cc_o_c = CC [M]  $@
 %.mod.o: %.mod.c FORCE
 	$(call if_changed_dep,cc_o_c)
 
-$(extmod_prefix).module-common.o: $(srctree)/scripts/module-common.c FORCE
+.module-common.o: $(srctree)/scripts/module-common.c FORCE
 	$(call if_changed_dep,cc_o_c)
 
 quiet_cmd_ld_ko_o = LD [M]  $@
@@ -57,13 +57,13 @@ if_changed_except = $(if $(call newer_prereqs_except,$(2))$(cmd-check),      \
 	printf '%s\n' 'savedcmd_$@ := $(make-cmd)' > $(dot-target).cmd, @:)
 
 # Re-generate module BTFs if either module's .ko or vmlinux changed
-%.ko: %.o %.mod.o $(extmod_prefix).module-common.o $(objtree)/scripts/module.lds $(and $(CONFIG_DEBUG_INFO_BTF_MODULES),$(KBUILD_BUILTIN),$(objtree)/vmlinux) FORCE
+%.ko: %.o %.mod.o .module-common.o $(objtree)/scripts/module.lds $(and $(CONFIG_DEBUG_INFO_BTF_MODULES),$(KBUILD_BUILTIN),$(objtree)/vmlinux) FORCE
 	+$(call if_changed_except,ld_ko_o,$(objtree)/vmlinux)
 ifdef CONFIG_DEBUG_INFO_BTF_MODULES
 	+$(if $(newer-prereqs),$(call cmd,btf_ko))
 endif
 
-targets += $(modules:%.o=%.ko) $(modules:%.o=%.mod.o) $(extmod_prefix).module-common.o
+targets += $(modules:%.o=%.ko) $(modules:%.o=%.mod.o) .module-common.o
 
 # Add FORCE to the prerequisites of a target to force it to be always rebuilt.
 # ---------------------------------------------------------------------------
diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
index 6fa9af4a25b4..f97c9926ed31 100644
--- a/scripts/Makefile.modinst
+++ b/scripts/Makefile.modinst
@@ -40,7 +40,7 @@ $(addprefix $(MODLIB)/, modules.builtin modules.builtin.modinfo modules.builtin.
 
 endif
 
-modules := $(call read-file, $(MODORDER))
+modules := $(call read-file, modules.order)
 
 ifeq ($(KBUILD_EXTMOD),)
 dst := $(MODLIB)/kernel
@@ -59,7 +59,7 @@ suffix-$(CONFIG_MODULE_COMPRESS_XZ)	:= .xz
 suffix-$(CONFIG_MODULE_COMPRESS_ZSTD)	:= .zst
 endif
 
-modules := $(patsubst $(extmod_prefix)%.o, $(dst)/%.ko$(suffix-y), $(modules))
+modules := $(patsubst %.o, $(dst)/%.ko$(suffix-y), $(modules))
 install-$(CONFIG_MODULES) += $(modules)
 
 __modinst: $(install-y)
@@ -119,7 +119,7 @@ endif
 # Create necessary directories
 $(foreach dir, $(sort $(dir $(install-y))), $(shell mkdir -p $(dir)))
 
-$(dst)/%.ko: $(extmod_prefix)%.ko FORCE
+$(dst)/%.ko: %.ko FORCE
 	$(call cmd,install)
 	$(call cmd,strip)
 	$(call cmd,sign)
diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index 78d2ca4f25f5..ab0e94ea6249 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -46,7 +46,7 @@ modpost-args =										\
 	$(if $(CONFIG_MODULE_SRCVERSION_ALL),-a)					\
 	$(if $(CONFIG_SECTION_MISMATCH_WARN_ONLY),,-E)					\
 	$(if $(KBUILD_MODPOST_WARN),-w)							\
-	$(if $(KBUILD_NSDEPS),-d $(MODULES_NSDEPS))					\
+	$(if $(KBUILD_NSDEPS),-d modules.nsdeps)					\
 	$(if $(CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS)$(KBUILD_NSDEPS),-N)	\
 	$(if $(findstring 1, $(KBUILD_EXTRA_WARN)),-W)					\
 	-o $@
@@ -61,8 +61,8 @@ endif
 # Read out modules.order to pass in modpost.
 # Otherwise, allmodconfig would fail with "Argument list too long".
 ifdef KBUILD_MODULES
-modpost-args += -T $(MODORDER)
-modpost-deps += $(MODORDER)
+modpost-args += -T modules.order
+modpost-deps += modules.order
 endif
 
 ifeq ($(KBUILD_EXTMOD),)
diff --git a/scripts/nsdeps b/scripts/nsdeps
index 8ca12e2b5c03..bab4ec870e50 100644
--- a/scripts/nsdeps
+++ b/scripts/nsdeps
@@ -51,4 +51,4 @@ generate_deps() {
 while read line
 do
 	generate_deps $line
-done < $MODULES_NSDEPS
+done < modules.nsdeps
-- 
2.43.0

