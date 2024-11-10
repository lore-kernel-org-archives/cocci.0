Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16C08D5E38C
	for <cocci@archiver.kernel.org>; Sun, 10 Nov 2024 01:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=yRX7FzgPkgrVwGLD1IAEFxu2SM9/emZzca1g1wuKhHQ=;
  b=m1RUfoQYfpHzl6PtDWD/EATuznurohOZ/ufKLLy2hgvKPwaLF3/AcaGL
   /oYx4UEYllEcAasXkAfUkV99i082g+t9bCCqVva9wZyuz+2zbIHtEdhEO
   npmauRwNP9cSiqlJw+SUgaDea3FgYy4ttzoSUH5GjlsZHKIhOnbz9gqml
   0=;
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
   d="scan'208";a="193077015"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Nov 2024 02:37:14 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id ACDE8E0D3E; Sun, 10 Nov 2024 02:37:13 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 07EC2E013D
	for <cocci@sympa.inria.fr>; Sun, 10 Nov 2024 02:37:09 +0100 (CET)
IronPort-SDR: 67300e44_vimBF3pwIfn6MscLoG06/fhrUQIcphf287avKjHzJHMemLh
 OT/fJZASR7WRd/LJAXs/6BSs+pMFkrfdRIOtsXQ==
X-IPAS-Result: =?us-ascii?q?A0EdAAAMDjBnhdlUsotaHQEBAQEJARIBBQUBgX8IAQsBg?=
 =?us-ascii?q?kN9WjMEC0iIJYROX4hygRaSCYp5gX4PAQMBDTETBAEBAwEDhQACijsCHgcBB?=
 =?us-ascii?q?DAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQEBAUBJhXsNg?=
 =?us-ascii?q?ls7cYElAQEBAQEBAQEBAQEBAR0CDX4CAQMyAQ0BATcBD1FWGYMBAYJkA7IZg?=
 =?us-ascii?q?QGCDAEBBoEI2xeBZAmBSAGFaYdccIN9eicbgUlEgRWBO4E3doRYhi+CR2pTg?=
 =?us-ascii?q?ml2JYEWhnKBDYFvghCISIEHHh0dM4oASIEhA1khEQFVEw0KCwcFYIEXA4JWe?=
 =?us-ascii?q?iuBDoEXOoF+gSJKg1iBQkY/gkppTTcCDQI2giR9gk+FHYRvZy8DAwMDg0WCQ?=
 =?us-ascii?q?EADCxgNSBEsNRQbBj5uB543AUaDLQF7BA8BG4EgCzIrJykykmiPc4IdoQOEJ?=
 =?us-ascii?q?IFjijOVKRozhVqRZZMOlhiCX6NWC1yEZoFnOoFcMxowgyoJRgMZD44hGR+CZ?=
 =?us-ascii?q?IVywRA0NTsCBwsBAQMJjneBSwEB?=
IronPort-PHdr: A9a23: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
 8hWIle0fF84DPUXDgJiBtNQef9K
IronPort-Data: A9a23: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
 E7K
IronPort-HdrOrdr: A9a23:iC/dz61PLpWOc2p+DpFnIwqjBL0kLtp133Aq2lEZdPWaSKKlfq
 eV7ZImPHrP5Qr5N0tBpTntAsW9qDbnhPtICOoqTNCftWvdyQiVxehZhOOIqQEIWReOktK1vp
 0AT0ERMrLN5CBB/KTH3DU=
X-Talos-CUID: 9a23:dqgprmyKNSo2BBjqXlMoBgUYA9F4eXrZ/E7tGH6kVH5zQaOQY36frfY=
X-Talos-MUID: 9a23:BAbxTwUUjWGQJe7q/CXQ2Cs6Hu5Y2pSJKFwzkZ9eisa2PDMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,142,1728943200"; 
   d="scan'208";a="193076923"
X-MGA-submission: =?us-ascii?q?MDHLSQEXPKJVpnrsrlzv9CoTm8C1S/85zJ49BS?=
 =?us-ascii?q?ikRbVxaTdPeo94Z7U5yKpYuIPLP7gpOeEsNv4a8GLHbR2om7a4BSv48w?=
 =?us-ascii?q?HKJCHV5V9BnHim8YmaDuEsHbv/N9DMsSWIelYLgDXzhOOA7vC1lyKJom?=
 =?us-ascii?q?Qm2WrgV+WD+fT4xANwjRgWAA=3D=3D?=
Received: from dfw.source.kernel.org ([139.178.84.217])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2024 02:37:07 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 2DFD35C0173
	for <cocci@inria.fr>; Sun, 10 Nov 2024 01:36:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5302DC4CED4;
	Sun, 10 Nov 2024 01:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731202626;
	bh=6/uwZZEPyIGrWrIPgIcKHUZ4oPZIubvfn8y9Jxnpm00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s2NB969zGfvxq3QMT+mtUPx9bmm2IGUiP6zlHtuGLob1Dc1ZLrLRY+kIftyUqQNXY
	 OeltES4Y7rmNNY8rtz8Y81LRsAtbEneYCyASyZXm9Nk4I+CsqdayNMTz3WFpkiEguE
	 iYgHt2bqNgaZez+SeXEfEntcVJZveslun1T+bnkyLbDvasAsdHY1hHZBug5H/4GPyl
	 wHwhfs8ThbxlwaWnh5ruBAtp9LHpuLP/8qbaZZZ92Py3FfGQhNOtjUdN/az/qlT9Bs
	 l9ksghibiSjNDm0ILIr6SMWtzMwXxuoLco06kIvYa7vpdhGHBaZvE1i8fXL2zQymLT
	 +VhUnauS8suvA==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	cocci@inria.fr,
	Masahiro Yamada <masahiroy@kernel.org>
Date: Sun, 10 Nov 2024 10:34:33 +0900
Message-ID: <20241110013649.34903-6-masahiroy@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241110013649.34903-1-masahiroy@kernel.org>
References: <20241110013649.34903-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [cocci] [PATCH v2 05/11] kbuild: change working directory to
 external module directory with M=
Reply-To: Masahiro Yamada <masahiroy@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 1980
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/20241110013649.34903-6-masahiroy%40kernel.org>

Currently, Kbuild always operates in the output directory of the kernel,
even when building external modules. This increases the risk of external
module Makefiles attempting to write to the kernel directory.

This commit switches the working directory to the external module
directory, allowing the removal of the $(KBUILD_EXTMOD)/ prefix from
some build artifacts.

The command for building external modules maintains backward
compatibility, but Makefiles that rely on working in the kernel
directory may break. In such cases, $(objtree) and $(srctree) should
be used to refer to the output and source directories of the kernel.

The appearance of the build log will change as follows:

[Before]

  $ make -C /path/to/my/linux M=/path/to/my/externel/module
  make: Entering directory '/path/to/my/linux'
    CC [M]  /path/to/my/externel/module/helloworld.o
    MODPOST /path/to/my/externel/module/Module.symvers
    CC [M]  /path/to/my/externel/module/helloworld.mod.o
    CC [M]  /path/to/my/externel/module/.module-common.o
    LD [M]  /path/to/my/externel/module/helloworld.ko
  make: Leaving directory '/path/to/my/linux'

[After]

  $ make -C /path/to/my/linux M=/path/to/my/externel/module
  make: Entering directory '/path/to/my/linux'
  make[1]: Entering directory '/path/to/my/externel/module'
    CC [M]  helloworld.o
    MODPOST Module.symvers
    CC [M]  helloworld.mod.o
    CC [M]  .module-common.o
    LD [M]  helloworld.ko
  make[1]: Leaving directory '/path/to/my/externel/module'
  make: Leaving directory '/path/to/my/linux'

Printing "Entering directory" twice is cumbersome. This will be
addressed later.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
 - Introduce a new 'srcroot' variable and clean-up code
 - Reword Documentation/dev-tools/coccinelle.rst

 Documentation/dev-tools/coccinelle.rst | 20 ++-----
 Documentation/kbuild/makefiles.rst     | 14 +++++
 Makefile                               | 80 +++++++++++++++-----------
 rust/Makefile                          |  4 +-
 scripts/Makefile.build                 |  2 +-
 scripts/Makefile.clean                 |  2 +-
 scripts/Makefile.compiler              |  2 +-
 scripts/Makefile.modpost               |  6 +-
 scripts/coccicheck                     |  6 +-
 scripts/nsdeps                         |  8 +--
 scripts/package/install-extmod-build   |  7 +++
 11 files changed, 85 insertions(+), 66 deletions(-)

diff --git a/Documentation/dev-tools/coccinelle.rst b/Documentation/dev-tools/coccinelle.rst
index 535ce126fb4f..6e70a1e9a3c0 100644
--- a/Documentation/dev-tools/coccinelle.rst
+++ b/Documentation/dev-tools/coccinelle.rst
@@ -250,25 +250,17 @@ variables for .cocciconfig is as follows:
 - Your directory from which spatch is called is processed next
 - The directory provided with the ``--dir`` option is processed last, if used
 
-Since coccicheck runs through make, it naturally runs from the kernel
-proper dir; as such the second rule above would be implied for picking up a
-.cocciconfig when using ``make coccicheck``.
-
 ``make coccicheck`` also supports using M= targets. If you do not supply
 any M= target, it is assumed you want to target the entire kernel.
 The kernel coccicheck script has::
 
-    if [ "$KBUILD_EXTMOD" = "" ] ; then
-        OPTIONS="--dir $srctree $COCCIINCLUDE"
-    else
-        OPTIONS="--dir $KBUILD_EXTMOD $COCCIINCLUDE"
-    fi
+    OPTIONS="--dir $srcroot $COCCIINCLUDE"
 
-KBUILD_EXTMOD is set when an explicit target with M= is used. For both cases
-the spatch ``--dir`` argument is used, as such third rule applies when whether
-M= is used or not, and when M= is used the target directory can have its own
-.cocciconfig file. When M= is not passed as an argument to coccicheck the
-target directory is the same as the directory from where spatch was called.
+Here, $srcroot refers to the source directory of the target: it points to the
+external module's source directory when M= used, and otherwise, to the kernel
+source directory. The third rule ensures the spatch reads the .cocciconfig from
+the target directory, allowing external modules to have their own .cocciconfig
+file.
 
 If not using the kernel's coccicheck target, keep the above precedence
 order logic of .cocciconfig reading. If using the kernel's coccicheck target,
diff --git a/Documentation/kbuild/makefiles.rst b/Documentation/kbuild/makefiles.rst
index 7964e0c245ae..d36519f194dc 100644
--- a/Documentation/kbuild/makefiles.rst
+++ b/Documentation/kbuild/makefiles.rst
@@ -449,6 +449,20 @@ $(obj)
   to prerequisites are referenced with $(src) (because they are not
   generated files).
 
+$(srcroot)
+  $(srcroot) refers to the root of the source you are building, which can be
+  either the kernel source or the external modules source, depending on whether
+  KBUILD_EXTMOD is set. This can be either a relative or an absolute path, but
+  if KBUILD_ABS_SRCTREE=1 is set, it is always an absolute path.
+
+$(srctree)
+  $(srctree) refers to the root of the kernel source tree. When building the
+  kernel, this is the same as $(srcroot).
+
+$(objtree)
+  $(objtree) refers to the root of the kernel object tree. It is ``.`` when
+  building the kernel, but it is different when building external modules.
+
 $(kecho)
   echoing information to user in a rule is often a good practice
   but when execution ``make -s`` one does not expect to see any output
diff --git a/Makefile b/Makefile
index cf1d55560ae2..e5f7ac7647a7 100644
--- a/Makefile
+++ b/Makefile
@@ -180,7 +180,24 @@ ifeq ("$(origin O)", "command line")
   KBUILD_OUTPUT := $(O)
 endif
 
-output := $(KBUILD_OUTPUT)
+ifdef KBUILD_EXTMOD
+    ifdef KBUILD_OUTPUT
+        objtree := $(realpath $(KBUILD_OUTPUT))
+        $(if $(objtree),,$(error specified kernel directory "$(KBUILD_OUTPUT)" does not exist))
+    else
+        objtree := $(CURDIR)
+    endif
+    output := $(KBUILD_EXTMOD)
+    # KBUILD_EXTMOD might be a relative path. Remember its absolute path before
+    # Make changes the working directory.
+    srcroot := $(realpath $(KBUILD_EXTMOD))
+    $(if $(srcroot),,$(error specified external module directory "$(KBUILD_EXTMOD)" does not exist))
+else
+    objtree := .
+    output := $(KBUILD_OUTPUT)
+endif
+
+export objtree srcroot
 
 # Do we want to change the working directory?
 ifneq ($(output),)
@@ -230,35 +247,33 @@ else # need-sub-make
 
 # We process the rest of the Makefile if this is the final invocation of make
 
-ifeq ($(abs_srctree),$(CURDIR))
-        # building in the source tree
-        srctree := .
-	building_out_of_srctree :=
+ifndef KBUILD_EXTMOD
+srcroot := $(abs_srctree)
+endif
+
+ifeq ($(srcroot),$(CURDIR))
+building_out_of_srctree :=
 else
-        ifeq ($(abs_srctree)/,$(dir $(CURDIR)))
-                # building in a subdirectory of the source tree
-                srctree := ..
-        else
-                srctree := $(abs_srctree)
-        endif
-	building_out_of_srctree := 1
+export building_out_of_srctree :=1
 endif
 
-ifneq ($(KBUILD_ABS_SRCTREE),)
-srctree := $(abs_srctree)
+ifdef KBUILD_ABS_SRCTREE
+    # Do not nothing. Use the absolute path.
+else ifeq ($(srcroot),$(CURDIR))
+    # Building in the source.
+    srcroot := .
+else ifeq ($(srcroot)/,$(dir $(CURDIR)))
+    # Building in a subdirectory of the source.
+    srcroot := ..
 endif
 
-objtree		:= .
+export srctree := $(if $(KBUILD_EXTMOD),$(abs_srctree),$(srcroot))
 
-VPATH		:=
-
-ifeq ($(KBUILD_EXTMOD),)
 ifdef building_out_of_srctree
-VPATH		:= $(srctree)
+export VPATH := $(srcroot)
+else
+VPATH :=
 endif
-endif
-
-export building_out_of_srctree srctree objtree VPATH
 
 # To make sure we do not include .config for any of the *config targets
 # catch them early, and hand them over to scripts/kconfig/Makefile
@@ -711,7 +726,7 @@ endif
 # in addition to whatever we do anyway.
 # Just "make" or "make all" shall build modules as well
 
-ifneq ($(filter all modules nsdeps %compile_commands.json clang-%,$(MAKECMDGOALS)),)
+ifneq ($(filter all modules nsdeps compile_commands.json clang-%,$(MAKECMDGOALS)),)
   KBUILD_MODULES := 1
 endif
 
@@ -1107,7 +1122,7 @@ export MODLIB
 
 PHONY += prepare0
 
-export extmod_prefix = $(if $(KBUILD_EXTMOD),$(KBUILD_EXTMOD)/)
+export extmod_prefix =
 export MODORDER := $(extmod_prefix)modules.order
 export MODULES_NSDEPS := $(extmod_prefix)modules.nsdeps
 
@@ -1799,14 +1814,10 @@ filechk_kernel.release = echo $(KERNELRELEASE)
 KBUILD_BUILTIN :=
 KBUILD_MODULES := 1
 
-build-dir := $(KBUILD_EXTMOD)
+build-dir := .
 
-compile_commands.json: $(extmod_prefix)compile_commands.json
-PHONY += compile_commands.json
-
-clean-dirs := $(KBUILD_EXTMOD)
-clean: private rm-files := $(KBUILD_EXTMOD)/Module.symvers $(KBUILD_EXTMOD)/modules.nsdeps \
-	$(KBUILD_EXTMOD)/compile_commands.json
+clean-dirs := .
+clean: private rm-files := Module.symvers modules.nsdeps compile_commands.json
 
 PHONY += prepare
 # now expand this into a simple variable to reduce the cost of shell evaluations
@@ -1948,7 +1959,7 @@ $(clean-dirs):
 
 clean: $(clean-dirs)
 	$(call cmd,rmfiles)
-	@find $(or $(KBUILD_EXTMOD), .) $(RCS_FIND_IGNORE) \
+	@find . $(RCS_FIND_IGNORE) \
 		\( -name '*.[aios]' -o -name '*.rsi' -o -name '*.ko' -o -name '.*.cmd' \
 		-o -name '*.ko.*' \
 		-o -name '*.dtb' -o -name '*.dtbo' \
@@ -1981,7 +1992,12 @@ tags TAGS cscope gtags: FORCE
 PHONY += rust-analyzer
 rust-analyzer:
 	+$(Q)$(CONFIG_SHELL) $(srctree)/scripts/rust_is_available.sh
+ifdef KBUILD_EXTMOD
+# FIXME: external modules must not descend into a sub-directory of the kernel
+	$(Q)$(MAKE) $(build)=$(objtree)/rust src=$(srctree)/rust $@
+else
 	$(Q)$(MAKE) $(build)=rust $@
+endif
 
 # Script to generate missing namespace dependencies
 # ---------------------------------------------------------------------------
diff --git a/rust/Makefile b/rust/Makefile
index b5e0a73b78f3..742740816c4b 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -362,8 +362,8 @@ rust-analyzer:
 	$(Q)$(srctree)/scripts/generate_rust_analyzer.py \
 		--cfgs='core=$(core-cfgs)' --cfgs='alloc=$(alloc-cfgs)' \
 		$(realpath $(srctree)) $(realpath $(objtree)) \
-		$(rustc_sysroot) $(RUST_LIB_SRC) $(KBUILD_EXTMOD) > \
-		$(if $(KBUILD_EXTMOD),$(extmod_prefix),$(objtree))/rust-project.json
+		$(rustc_sysroot) $(RUST_LIB_SRC) $(if $(KBUILD_EXTMOD),$(srcroot)) \
+		> rust-project.json
 
 redirect-intrinsics = \
 	__addsf3 __eqsf2 __extendsfdf2 __gesf2 __lesf2 __ltsf2 __mulsf3 __nesf2 __truncdfsf2 __unordsf2 \
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 64cd046f8fd8..1aa928a6fb4f 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -3,7 +3,7 @@
 # Building
 # ==========================================================================
 
-src := $(if $(VPATH),$(VPATH)/)$(obj)
+src := $(srcroot)/$(obj)
 
 PHONY := $(obj)/
 $(obj)/:
diff --git a/scripts/Makefile.clean b/scripts/Makefile.clean
index 4fcfab40ed61..6ead00ec7313 100644
--- a/scripts/Makefile.clean
+++ b/scripts/Makefile.clean
@@ -3,7 +3,7 @@
 # Cleaning up
 # ==========================================================================
 
-src := $(if $(VPATH),$(VPATH)/)$(obj)
+src := $(srcroot)/$(obj)
 
 PHONY := __clean
 __clean:
diff --git a/scripts/Makefile.compiler b/scripts/Makefile.compiler
index e0842496d26e..8c1029687e2e 100644
--- a/scripts/Makefile.compiler
+++ b/scripts/Makefile.compiler
@@ -13,7 +13,7 @@ cc-cross-prefix = $(firstword $(foreach c, $(1), \
 			$(if $(shell command -v -- $(c)gcc 2>/dev/null), $(c))))
 
 # output directory for tests below
-TMPOUT = $(if $(KBUILD_EXTMOD),$(firstword $(KBUILD_EXTMOD))/).tmp_$$$$
+TMPOUT = .tmp_$$$$
 
 # try-run
 # Usage: option = $(call try-run, $(CC)...-o "$$TMP",option-ok,otherwise)
diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index 12e7c15d099c..78d2ca4f25f5 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -111,13 +111,13 @@ endif
 else
 
 # set src + obj - they may be used in the modules's Makefile
-obj := $(KBUILD_EXTMOD)
-src := $(if $(VPATH),$(VPATH)/)$(obj)
+obj := .
+src := $(srcroot)
 
 # Include the module's Makefile to find KBUILD_EXTRA_SYMBOLS
 include $(kbuild-file)
 
-output-symdump := $(KBUILD_EXTMOD)/Module.symvers
+output-symdump := Module.symvers
 
 ifeq ($(wildcard $(objtree)/Module.symvers),)
 missing-input := $(objtree)/Module.symvers
diff --git a/scripts/coccicheck b/scripts/coccicheck
index e52cb43fede6..0e6bc5a10320 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -80,11 +80,7 @@ command results in a shift count error.'
     NPROC=1
 else
     ONLINE=0
-    if [ "$KBUILD_EXTMOD" = "" ] ; then
-        OPTIONS="--dir $srctree $COCCIINCLUDE"
-    else
-        OPTIONS="--dir $KBUILD_EXTMOD $COCCIINCLUDE"
-    fi
+    OPTIONS="--dir $srcroot $COCCIINCLUDE"
 
     # Use only one thread per core by default if hyperthreading is enabled
     THREADS_PER_CORE=$(LANG=C lscpu | grep "Thread(s) per core: " | tr -cd "[:digit:]")
diff --git a/scripts/nsdeps b/scripts/nsdeps
index f1718cc0d700..8ca12e2b5c03 100644
--- a/scripts/nsdeps
+++ b/scripts/nsdeps
@@ -19,12 +19,6 @@ if ! { echo "$SPATCH_REQ_VERSION"; echo "$SPATCH_VERSION"; } | sort -CV ; then
 	exit 1
 fi
 
-if [ "$KBUILD_EXTMOD" ]; then
-	src_prefix=
-else
-	src_prefix=$srctree/
-fi
-
 generate_deps_for_ns() {
 	$SPATCH --very-quiet --in-place --sp-file \
 		$srctree/scripts/coccinelle/misc/add_namespace.cocci -D nsdeps -D ns=$1 $2
@@ -34,7 +28,7 @@ generate_deps() {
 	local mod=${1%.ko:}
 	shift
 	local namespaces="$*"
-	local mod_source_files=$(sed "s|^\(.*\)\.o$|${src_prefix}\1.c|" $mod.mod)
+	local mod_source_files=$(sed "s|^\(.*\)\.o$|${srcroot}/\1.c|" $mod.mod)
 
 	for ns in $namespaces; do
 		echo "Adding namespace $ns to module $mod.ko."
diff --git a/scripts/package/install-extmod-build b/scripts/package/install-extmod-build
index 7ec1f061a519..64d958ee45f3 100755
--- a/scripts/package/install-extmod-build
+++ b/scripts/package/install-extmod-build
@@ -51,6 +51,13 @@ mkdir -p "${destdir}"
 if [ "${CC}" != "${HOSTCC}" ]; then
 	echo "Rebuilding host programs with ${CC}..."
 
+	# This leverages external module building.
+	# - Clear sub_make_done to allow the top-level Makefile to redo sub-make.
+	# - Filter out --no-print-directory to print "Entering directory" logs
+	#   when Make changes the working directory.
+	unset sub_make_done
+	MAKEFLAGS=$(echo "${MAKEFLAGS}" | sed s/--no-print-directory//)
+
 	cat <<-'EOF' >  "${destdir}/Kbuild"
 	subdir-y := scripts
 	EOF
-- 
2.43.0

