Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21737D5E36A
	for <cocci@archiver.kernel.org>; Sun, 10 Nov 2024 01:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=AoRgXcT109Nn76JpG2BlQr8RNdqczn/mZbCQIfhvQeg=;
  b=gcgVetEPtH/FmdOWCxHTh3/Ml4/Ki25MVP27+OobG3BuRE+86/dMNuPm
   OljJ390PWLF7PVoU2h+EBbC83XO6JWIRS2FLArYLoMgCsVU6khbbPyF3P
   S0AlUyzaCCbjWf1I7Bkw2nXyyaEr6qO85DPm3gDVJuylnlGHgIN32well
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
   d="scan'208";a="193077185"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Nov 2024 02:37:23 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5795CE0D1F; Sun, 10 Nov 2024 02:37:23 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id AD34FE0D1E
	for <cocci@sympa.inria.fr>; Sun, 10 Nov 2024 02:37:18 +0100 (CET)
IronPort-SDR: 67300e4e_aLen4m5iZ/g+chN3K2LgSWPjPn1B13KI/RgTVSk9VGUkTaN
 Evx0ZLR0RR4htEyjRNVdEw8KNrFLoc1EInMGdLA==
X-IPAS-Result: =?us-ascii?q?A0FaAQCQDTBnhVvBS5NaHgEBCxIMgggLgkSBVzMEC0iNU?=
 =?us-ascii?q?ohynhiBfg8BAwENRAQBAQMEhQACijsCHgcBBDAJDgECBAEBAQEDAgMBAQEBA?=
 =?us-ascii?q?QEQAQEFAQEBAgEBAgQGAQIQAQEBAUBJhXsNgmIBgSSBJgEBAQEBAQEBAQEBA?=
 =?us-ascii?q?R0CDX4CAQMnCwENAQE3AQ9RVhmDAYJlA7FlM4EBggwBAQbcH4FkCYFIhWqHX?=
 =?us-ascii?q?HCDfXonG4FJRIEVgTuCLYRYhi+CR2pTgml2JYgIgQ2Df4lPHoptSIEhA1khE?=
 =?us-ascii?q?QFVEw0KCwcFYIEXA4JWeiuBDoEXOoF+gSJKg1iBQkY/gkppTTcCDQI2giR9g?=
 =?us-ascii?q?k+FHYRvZy8DAwMDg0WCQEADCxgNSBEsNRQbBj5uB544RoMtAT0+EwGBJn0cC?=
 =?us-ascii?q?x6Sdy6SEKEDhCSBY59cGjOXP5MOmHekPYRmgWc6gVwzGjCDKk8DGQ+OIRkfi?=
 =?us-ascii?q?FbBEDQ1OwIHCwEBAwmOd4FLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:nH8niKOUsVrXscBcTs6jsMiBIKoaSvp037Dk7S5MoHtuA6qlfq
 WV8cjzuiWVtN98Yh0dcJW7Scy9qBDnhPlICOsqTNSftWDd0QPCRr2Kr7GSpwEIcBeeygcy78
 hdmtBFeb/NMWQ=
X-Talos-CUID: 9a23:lURc/W9jepGWo9FzY0yVv1M7NMJ4YGON9VjRJUWJEHluSoWLEGbFrQ==
X-Talos-MUID: 9a23:BXsa/ggZQZMQh2yOxZin78MpMvo45rWsWGQxuL44pY6qayFMBRa6k2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,142,1728943200"; 
   d="scan'208";a="101200600"
X-MGA-submission: =?us-ascii?q?MDGrTwidK+cAqj7OTr3UB3RmwDbOq4E+DDKBFC?=
 =?us-ascii?q?hEU+qSxhLLFiQdcicocTMvqvGh4ElwTDRyZgdDCNkA6bAuAp+Fyps02T?=
 =?us-ascii?q?ESk6Tksn7cYDWtDntG7+aUnabtDKCsE68N20cHbj1GarISIsToczmCXf?=
 =?us-ascii?q?CirOeyqtY63/pzRt60UhOaMg=3D=3D?=
Received: from nyc.source.kernel.org ([147.75.193.91])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2024 02:37:17 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 887BFA40343;
	Sun, 10 Nov 2024 01:35:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D4A0C4CED4;
	Sun, 10 Nov 2024 01:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731202636;
	bh=JnWxdVvEakJui+gj8y0AxBpvkUHKa2A9Zi/L+iOkT1Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bwaaGq2HqiVB2ahWcOSdWO3oIJXB7Eg6GV61J+xbFylFN/twskGjDMCQccPPIldvI
	 zS0AxzPzUaaV/bw1hlYH+M74PtywkLUgBmISlhKQyFACz962upk1J4iuF6uhL8QKnL
	 xy3mlAamzLiMZRvFiAqQItnFPAeTmxb9wzxzQrz/M5ul1BqXMQ+1T53dc9O7mp75oP
	 m+zaJzb2Sje2GMiWQ/5XADl2KZK75KQhtD9hjFRlOL7DABkghTsk+SUjUxgHlIKtm9
	 j/tqReUhKCoTZ2r41ztMH5Kyhf4ksju/aRIIHqCqkRNs4F1fL/VRW+FBOEhWPfSVkC
	 ODb2gw/ITRmKg==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	cocci@inria.fr,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>
Date: Sun, 10 Nov 2024 10:34:39 +0900
Message-ID: <20241110013649.34903-12-masahiroy@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241110013649.34903-1-masahiroy@kernel.org>
References: <20241110013649.34903-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [cocci] [PATCH v2 11/11] kbuild: allow to start building external
 modules in any directory
Reply-To: Masahiro Yamada <masahiroy@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 1986
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/20241110013649.34903-12-masahiroy%40kernel.org>

Unless an explicit O= option is provided, external module builds must
start from the kernel directory.

This can be achieved by using the -C option:

  $ make -C /path/to/kernel M=/path/to/external/module

This commit allows starting external module builds from any directory,
so you can also do the following:

  $ make -f /path/to/kernel/Makefile M=/path/to/external/module

The key difference is that the -C option changes the working directory
and parses the Makefile located there, while the -f option only
specifies the Makefile to use.

As shown in the examples in Documentation/kbuild/modules.rst, external
modules usually have a wrapper Makefile that allows you to build them
without specifying any make arguments. The Makefile typically contains
a rule as follows:

    KDIR ?= /path/to/kernel
    default:
            $(MAKE) -C $(KDIR) M=$(CURDIR) $(MAKECMDGOALS)

The log will appear as follows:

    $ make
    make -C /path/to/kernel M=/path/to/external/module
    make[1]: Entering directory '/path/to/kernel'
    make[2]: Entering directory '/path/to/external/module'
      CC [M]  helloworld.o
      MODPOST Module.symvers
      CC [M]  helloworld.mod.o
      CC [M]  .module-common.o
      LD [M]  helloworld.ko
    make[2]: Leaving directory '/path/to/external/module'
    make[1]: Leaving directory '/path/to/kernel'

This changes the working directory twice because the -C option first
switches to the kernel directory, and then Kbuild internally recurses
back to the external module directory.

With this commit, the wrapper Makefile can directly include the kernel
Makefile:

    KDIR ?= /path/to/kernel
    export KBUILD_EXTMOD := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
    include $(KDIR)/Makefile

This avoids unnecessary sub-make invocations:

    $ make
      CC [M]  helloworld.o
      MODPOST Module.symvers
      CC [M]  helloworld.mod.o
      CC [M]  .module-common.o
      LD [M]  helloworld.ko

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
---

Changes in v2:
  - Fix typos in the commit description (s/exernal/external/)
  - Fix `uname -r` to $(shell uname -r) in Example 3

 Documentation/kbuild/modules.rst | 21 +++++++++++++++++++++
 Makefile                         |  8 ++++++--
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/Documentation/kbuild/modules.rst b/Documentation/kbuild/modules.rst
index a01f3754c7fc..101de236cd0c 100644
--- a/Documentation/kbuild/modules.rst
+++ b/Documentation/kbuild/modules.rst
@@ -59,6 +59,12 @@ Command Syntax
 
 		$ make -C /lib/modules/`uname -r`/build M=$PWD modules_install
 
+	Starting from Linux 6.13, you can use the -f option instead of -C. This
+	will avoid unnecessary change of the working directory. The external
+	module will be output to the directory where you invoke make.
+
+		$ make -f /lib/modules/`uname -r`/build/Makefile M=$PWD
+
 Options
 -------
 
@@ -221,6 +227,21 @@ Separate Kbuild File and Makefile
 	consisting of several hundred lines, and here it really pays
 	off to separate the kbuild part from the rest.
 
+	Linux 6.13 and later support another way. The external module Makefile
+	can include the kernel Makefile directly, rather than invoking sub Make.
+
+	Example 3::
+
+		--> filename: Kbuild
+		obj-m  := 8123.o
+		8123-y := 8123_if.o 8123_pci.o
+
+		--> filename: Makefile
+		KDIR ?= /lib/modules/$(shell uname -r)/build
+		export KBUILD_EXTMOD := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
+		include $(KDIR)/Makefile
+
+
 Building Multiple Modules
 -------------------------
 
diff --git a/Makefile b/Makefile
index df002595341a..0825a9a58ca9 100644
--- a/Makefile
+++ b/Makefile
@@ -189,9 +189,13 @@ ifdef KBUILD_EXTMOD
         objtree := $(realpath $(KBUILD_OUTPUT))
         $(if $(objtree),,$(error specified kernel directory "$(KBUILD_OUTPUT)" does not exist))
     else
-        objtree := $(CURDIR)
+        objtree := $(abs_srctree)
     endif
-    output := $(or $(KBUILD_EXTMOD_OUTPUT),$(KBUILD_EXTMOD))
+    # If Make is invoked from the kernel directory (either kernel
+    # source directory or kernel build directory), external modules
+    # are built in $(KBUILD_EXTMOD) for backward compatibility,
+    # otherwise, built in the current directory.
+    output := $(or $(KBUILD_EXTMOD_OUTPUT),$(if $(filter $(CURDIR),$(objtree) $(abs_srctree)),$(KBUILD_EXTMOD)))
     # KBUILD_EXTMOD might be a relative path. Remember its absolute path before
     # Make changes the working directory.
     srcroot := $(realpath $(KBUILD_EXTMOD))
-- 
2.43.0

