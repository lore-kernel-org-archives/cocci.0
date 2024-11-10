Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54365D5E36A
	for <cocci@archiver.kernel.org>; Sun, 10 Nov 2024 01:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=IVXW72pwCoQkAX7JFVbMnPjCmSNuzhaLnQ3GO+/K25c=;
  b=W7otd5big0CJRaaFnb/WX3+Y9XriFx9CiC0IllJTB5+y5x2tc9ZyGxWd
   Y3z9eap+XAy+0kXP14gJoNxY2HiUeIelXtmVS1t6elABRd8hcsbB/N19z
   UI7g0VoKZwkPM3nWhlFUUDJJo+z4N8md80wULbvdMKvpcIXq7/GA1smOZ
   A=;
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
   d="scan'208";a="193077104"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Nov 2024 02:37:18 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0121EE0D20; Sun, 10 Nov 2024 02:37:17 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id BF503E0D20
	for <cocci@sympa.inria.fr>; Sun, 10 Nov 2024 02:37:13 +0100 (CET)
IronPort-SDR: 67300e49_SmxxlXRWfGWXNQNCHjoI8uiLgPIxVmUk7KU/ZqgxZE0kcui
 PbtCdx1k70Z8rK48rawXDgAZMKGYoyZd+ciXBvA==
X-IPAS-Result: =?us-ascii?q?A0FaAQCQDTBnhdlUsotaHgEBCxIMgggLgkSBVzMEC0iNU?=
 =?us-ascii?q?ohynhiBfg8BAwENRAQBAQMEhQACijsCHgcBBDAJDgECBAEBAQEDAgMBAQEBA?=
 =?us-ascii?q?QEQAQEFAQEBAgEBAgQGAQIQAQEBAUBJhXsNgmIBgSSBJgEBAQEBAQEBAQEBA?=
 =?us-ascii?q?R0CDX4CAQMyAQ0BATcBD1FWGYMBgmUDshiBAYIMAQEG3B+BZAmBSIVqh1xwg?=
 =?us-ascii?q?316JxuBSUSCUIIthFg4hXeGbXYliRWYWUiBIQNZIREBVRMNCgsHBWCBFwOCV?=
 =?us-ascii?q?norgQ6BFzqBfoEiSoUaRj+CSmlNNwINAjaCJH2CT4UdhG9nLwMDAwODRYJAQ?=
 =?us-ascii?q?AMLGA1IESw1FBsGPm4HnjhGgjtyAQGBDYIkHCk6pHuhA4QkgWOfXBozlz+TD?=
 =?us-ascii?q?ph3pD2EZoFnOoFcMxowgypPAxkPjiEZiHXBEDQ1OwIHCwEBAwmOd4FLAQE?=
IronPort-PHdr: A9a23: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
 3M1
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:ctbesaGd0IBbftAUpLqE58eALOsnbusQ8zAXPo5KJyC9Ffbo8f
 xG+c536faaslYssR0b9exofZPwJE80lqQFhrX5X43SPzUO0VHAROoJ0WKh+UyFJ8SUzI9gPM
 lbHJSWcOeAb2RHsQ==
X-Talos-CUID: 9a23:3tEYUW8bh9kzBOAXoH+Vv0gJB/4nQ3fd8HnZAWqATmVDSuGPQHbFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3AtaT40g8nMvtmyKVuZP+p1tmQf8hE+5q2IQcLq8w?=
 =?us-ascii?q?ttOCEbCVBG2y9ih3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,142,1728943200"; 
   d="scan'208";a="101200593"
X-MGA-submission: =?us-ascii?q?MDF5fxMOybEhHo/9PLnSD/271qzekwhaEn8xnR?=
 =?us-ascii?q?7kEgD9kwHPALVSpB0lDMriHjx4z237OUWKkSYvtwb7b/SI8WEEYABJpH?=
 =?us-ascii?q?IjvGzE+C0IKFeiGFJgBe0+2kt7OEexZlMAf5eXIqg9krOreOohWsebNM?=
 =?us-ascii?q?KffPNnKCbzlbSz9Bc2kh9Qgg=3D=3D?=
Received: from dfw.source.kernel.org ([139.178.84.217])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2024 02:37:13 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 88A175C479A;
	Sun, 10 Nov 2024 01:36:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70568C4CED2;
	Sun, 10 Nov 2024 01:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731202631;
	bh=us5XMqVwdbsYqray5sAUkCpHJq/PzlTni1SE6suosWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FYpHijwk9mcoVCtK/bAUiFUeeUIfQf92dIktH/Ui4EM0+1FbLTrjZKR8ZDDZWsG8R
	 3tdxMA9KnbGlYbhUQoCkE3K/POCpboPw+Tsj8vHCI3RcxuB5dR0DL155C80qzwUqFa
	 LflcVEYQv/FONuhc6bx14auG8qGNtGBwrxL5Z73IrBNDp4teVkkwgILQpFk1uqSihY
	 hYnx4j3hz4//F5pxW0welWeNGSBQBr78iNnllRAmzWQQE7qyLqutK/JYjOeXc0u1QJ
	 6860ZflHe8fte6sr/phGtKskgwCDD3qWGZ4rRIzRALRMWDg9ZDbtMmBIVHbZCVUAL+
	 k0lEGg/1Euv5g==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	cocci@inria.fr,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>
Date: Sun, 10 Nov 2024 10:34:36 +0900
Message-ID: <20241110013649.34903-9-masahiroy@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241110013649.34903-1-masahiroy@kernel.org>
References: <20241110013649.34903-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [cocci] [PATCH v2 08/11] kbuild: support -fmacro-prefix-map for
 external modules
Reply-To: Masahiro Yamada <masahiroy@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 1983
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/20241110013649.34903-9-masahiroy%40kernel.org>

This commit makes -fmacro-prefix-map work for external modules built in
a separate output directory. It improves the reproducibility of external
modules and provides the benefits described in commit a73619a845d5
("kbuild: use -fmacro-prefix-map to make __FILE__ a relative path").

When building_out_of_srctree is not defined (e.g., when the kernel or
external module is built in the source directory), this option is
unnecessary.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
---

Changes in v2:
  - Check building_out_of_srctree instead of VPATH

 Makefile | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 38ce19747728..5488aa96b46b 100644
--- a/Makefile
+++ b/Makefile
@@ -1041,8 +1041,10 @@ ifdef CONFIG_CC_IS_GCC
 KBUILD_CFLAGS   += -fconserve-stack
 endif
 
-# change __FILE__ to the relative path from the srctree
-KBUILD_CPPFLAGS += $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
+# change __FILE__ to the relative path to the source directory
+ifdef building_out_of_srctree
+KBUILD_CPPFLAGS += $(call cc-option,-fmacro-prefix-map=$(srcroot)/=)
+endif
 
 # include additional Makefiles when needed
 include-y			:= scripts/Makefile.extrawarn
-- 
2.43.0

