Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 033DCD5E38E
	for <cocci@archiver.kernel.org>; Sun, 10 Nov 2024 01:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=xuDjCFyPbc079hPyssYw9YRgOxPACfiYQtMroWhNFEw=;
  b=PVPsDHlgB05Vfggsk9Q0pB9cFGOawo+79sVmZi60aUX9etZxucBHL3+x
   zge7E3jOurex8xMHVvsOAZe2nusSZgDJ5ViqsSoS1u4+AMk/DvmJl8QHL
   APRW2yXJ7l9qVNTLPdz9VKU+sx/47AkavpyqiUr9st1ZcI4eVva2Yj8ki
   c=;
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
   d="scan'208";a="193076977"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Nov 2024 02:37:12 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A0630E00B7; Sun, 10 Nov 2024 02:37:12 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 0A175E00B7
	for <cocci@sympa.inria.fr>; Sun, 10 Nov 2024 02:37:05 +0100 (CET)
IronPort-SDR: 67300e40_k0aqpEHEHNIBA960mNvTSlZMMjmkfjc/BR4vPiYHM6nZ569
 ozl0Pi/1UVNsJOnB6yut0IZ+O2KJuUNEeGyKEDQ==
X-IPAS-Result: =?us-ascii?q?A0EWAACQDTBnhdlUsotaHQEBAQEJARIBBQUBgX8IAQsBg?=
 =?us-ascii?q?kOBVzMEC0iMc1+nCoF+DwEDAQ1EBAEBAwSFAAKKOwIeBwEEMAkOAQIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBARABAQUBAQECAQECBAYBAhABAQEBQEmFew2CYgGBJIEmAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBHQINfgIBAzIBDQEBNwEPUVYZgwGCZQOyGIEBggwBAQbcH4FkC?=
 =?us-ascii?q?YFIAYVph1xwg316JxuBSUSBFYE7gi2EWDiFd4ZtdiWJFZhZSIEhA1khEQFVE?=
 =?us-ascii?q?w0KCwcFYIEXA4JWeiuBDoEXOoF+gSJKhRpGP4JKaU03Ag0CNoIkfYJPhR2Eb?=
 =?us-ascii?q?2cvAwMDA4NFgkBAAwsYDUgRLDUUGwY+bgeeOEaDLnsTgkBjklqQBIIdgTefT?=
 =?us-ascii?q?IQkgWOfXBozlz+TDi6YSaQ9hGaBZzqBXDMaMIMqTwMZD44hGYh1wRA0NTsCB?=
 =?us-ascii?q?wsBAQMJjneBSwEB?=
IronPort-PHdr: A9a23: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
 RRamNvF
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:xzqncKPZHtt1h8BcTs6jsMiBIKoaSvp037Dk7S5MoHtuA6qlfq
 WV8cjzuiWVtN98Yh0dcJW7Scy9qBDnhPlICOsqTNSftWDd0QPCRr2Kr7GSpwEIcBeeygcy78
 hdmtBFeb/NMWQ=
X-Talos-CUID: =?us-ascii?q?9a23=3Avkyi6WuUSATeGVEtRkJLGMLl6IsLNUTa3SjAO3O?=
 =?us-ascii?q?+AEJZSeDOV0Se8qB7xp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AmpvVDg0AQAD0DpeGTPkIk/c5xzUjvpmxKm4pn58?=
 =?us-ascii?q?95YqHOwV+Pg3atzmaa9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,142,1728943200"; 
   d="scan'208";a="101200585"
X-MGA-submission: =?us-ascii?q?MDHOXssycsJUbrhwINcOMCqtwZQEFiKgeQLOI+?=
 =?us-ascii?q?AnVKEkPps7z419J09fni7/MA1P5P0RqiDJoWAvHLBVgVV2Sc6xnqdCLK?=
 =?us-ascii?q?iafDC6VtTG8kuSszO2rwo57xVtRXP6cRcR7MK9hfNxLhKWJ1NMWv12BG?=
 =?us-ascii?q?yw2bKHzwzzdFB9WWQHyQp6Hg=3D=3D?=
Received: from dfw.source.kernel.org ([139.178.84.217])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2024 02:37:04 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7DBD65C137C;
	Sun, 10 Nov 2024 01:36:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98BAEC4CED2;
	Sun, 10 Nov 2024 01:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731202622;
	bh=iCeqjzcVDDdoLZ9nZgMa6Iw5IDXnP0Lvgh2TSIu2WD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eIrvovJJ4eitOtZYlTjmKrd3/mINe+aHZaNaC9amwYwqn34fP4V9WsiBWhQytQCvd
	 TejFnusbblJS3ES9FDUk53jndG/8Ucdsh7GMP845PWwdG5THIUCEtUq58mlm62rn6q
	 Jksnm9XLgD0YyumgHtsq6+GHVUewVZVdulDOYNdBu7KfDevReKG7phUrBV04GG6WVh
	 qgntF0qk3pIQWr3E42vbYW4zXINh5jPdm9ltGHlcOdERvPEgfl9ELlayNmKZIC+YqE
	 csxr8hP420L+ElVWAKB0LlszcJ1Bhqfp1NmLwVfkawD8BHYO0cWPnSKNI/htgYVp4O
	 U4E1hut/47g1Q==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	cocci@inria.fr,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>
Date: Sun, 10 Nov 2024 10:34:31 +0900
Message-ID: <20241110013649.34903-4-masahiroy@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241110013649.34903-1-masahiroy@kernel.org>
References: <20241110013649.34903-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [cocci] [PATCH v2 03/11] kbuild: rename abs_objtree to abs_output
Reply-To: Masahiro Yamada <masahiroy@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 1978
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/20241110013649.34903-4-masahiroy%40kernel.org>

'objtree' refers to the top of the output directory of kernel builds.

Rename abs_objtree to a more generic name, to better reflect its use in
the context of external module builds.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
---

(no changes since v1)

 Makefile | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 9b8f4f4cb01b..deb3f01863f8 100644
--- a/Makefile
+++ b/Makefile
@@ -40,7 +40,7 @@ __all:
 
 this-makefile := $(lastword $(MAKEFILE_LIST))
 abs_srctree := $(realpath $(dir $(this-makefile)))
-abs_objtree := $(CURDIR)
+abs_output := $(CURDIR)
 
 ifneq ($(sub_make_done),1)
 
@@ -185,8 +185,8 @@ ifneq ($(KBUILD_OUTPUT),)
 # $(realpath ...) gets empty if the path does not exist. Run 'mkdir -p' first.
 $(shell mkdir -p "$(KBUILD_OUTPUT)")
 # $(realpath ...) resolves symlinks
-abs_objtree := $(realpath $(KBUILD_OUTPUT))
-$(if $(abs_objtree),,$(error failed to create output directory "$(KBUILD_OUTPUT)"))
+abs_output := $(realpath $(KBUILD_OUTPUT))
+$(if $(abs_output),,$(error failed to create output directory "$(KBUILD_OUTPUT)"))
 endif # ifneq ($(KBUILD_OUTPUT),)
 
 ifneq ($(words $(subst :, ,$(abs_srctree))), 1)
@@ -197,7 +197,7 @@ export sub_make_done := 1
 
 endif # sub_make_done
 
-ifeq ($(abs_objtree),$(CURDIR))
+ifeq ($(abs_output),$(CURDIR))
 # Suppress "Entering directory ..." if we are at the final work directory.
 no-print-directory := --no-print-directory
 else
@@ -221,7 +221,7 @@ $(filter-out $(this-makefile), $(MAKECMDGOALS)) __all: __sub-make
 
 # Invoke a second make in the output directory, passing relevant variables
 __sub-make:
-	$(Q)$(MAKE) $(no-print-directory) -C $(abs_objtree) \
+	$(Q)$(MAKE) $(no-print-directory) -C $(abs_output) \
 	-f $(abs_srctree)/Makefile $(MAKECMDGOALS)
 
 else # need-sub-make
-- 
2.43.0

