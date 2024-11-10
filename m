Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAEBCD5E38C
	for <cocci@archiver.kernel.org>; Sun, 10 Nov 2024 01:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=dQQCKenQbVBNFv2HPwRRoC7oKrrHk1aPi8s7G4EX9R8=;
  b=ELzv9o/oa+Hult9RsTIErmWWACY/yuUOboko9JTOVexvxyVEyz/eE0Dp
   p+XEawCC5ujATmXDduhy9BVzY5DbBgoYUdGQ+rO3E8qbZdE83pnyzlXrH
   FWAdWFquaaiX6asYcOW/gaY7IJ0APFi4YAvys1H/VT7ygLUxkvmbv9hT5
   s=;
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
   d="scan'208";a="193076927"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Nov 2024 02:37:08 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 79DFFE0D24; Sun, 10 Nov 2024 02:37:08 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 846BCE00B7
	for <cocci@sympa.inria.fr>; Sun, 10 Nov 2024 02:37:02 +0100 (CET)
IronPort-SDR: 67300e3e_Yu4ZB65ErZky121G9BC9C4CKLWn/7Pm5GRW0U5ih3CB5HRY
 tzTarRUaY9BKJvrRa6QUxyEwAb0SQGJFKTYoEnQ==
X-IPAS-Result: =?us-ascii?q?A0FaAQCQDTBnhdlUsotaHgEBCxIMgggLgkSBVzMEC0iNU?=
 =?us-ascii?q?qcKgX4PAQMBDUQEAQEDBIUAAoo7Ah4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBE?=
 =?us-ascii?q?AEBBQEBAQIBAQIEBgECEAEBAQFASYV7DYJiAYEkgSYBAQEBAQEBAQEBAQEdA?=
 =?us-ascii?q?g1+AgEDMgENAQE3AQ9RVhmDAYJlA7IYgQGCDAEBBtwfgWQJgUiFaodccIN9e?=
 =?us-ascii?q?icbgUlEhH2EWDiFVSKGbXYliRWKe41eSIEhA1khEQFVEw0KCwcFYIEXA4JWe?=
 =?us-ascii?q?iuBDoEXOoF+gSJKhRpGP4JKaU03Ag0CNoIkfYJPhR2Eb2cvAwMDA4NFgkBAA?=
 =?us-ascii?q?wsYDUgRLDUUGwY+bgeeOEaDLoEOgXlHpV6hA4QkgWOfXBozlz+TDi6YSaQ9h?=
 =?us-ascii?q?GaBZzqBXDMaMIMqTwMZD44hGR+IVsEQNDU7AgcLAQEDCY53gUsBAQ?=
IronPort-PHdr: A9a23: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
 RRamdvF
IronPort-Data: A9a23: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
 A==
IronPort-HdrOrdr: A9a23:apHcdqN/0VxV1MBcTs6jsMiBIKoaSvp037Dk7S5MoHtuA6qlfq
 WV8cjzuiWVtN98Yh0dcJW7Scy9qBDnhPlICOsqTNSftWDd0QPCRr2Kr7GSpwEIcBeeygcy78
 hdmtBFeb/NMWQ=
X-Talos-CUID: 9a23:nnmk6G/8ZUw8ri4KuH6Vv0USHM0nbSfY9XOOCG+0JWhyaZGYEFDFrQ==
X-Talos-MUID: 9a23:5j3g6ghkbroI2r2/Y6uIV8MpKdV6oKu1DBk2yc8Jm/LHPBNIIAmBk2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,142,1728943200"; 
   d="scan'208";a="101200581"
X-MGA-submission: =?us-ascii?q?MDFS1KNsINwNVjnt5mjd+b5Pnr3oGdEvY9DYBH?=
 =?us-ascii?q?Nichmv7uIAdNDwwhr575XZGUds/UQdw1r/xTg6S7ACUz+yvUFewxvgHF?=
 =?us-ascii?q?Kg4CVE9LUnpxpKCILhYDdJnJebebrTwzBpaNH9/UNnA7+u84hDpoxN7B?=
 =?us-ascii?q?Bzqak/5cTBB4wZSdz4qOyk4Q=3D=3D?=
Received: from dfw.source.kernel.org ([139.178.84.217])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2024 02:37:01 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E592B5C4758;
	Sun, 10 Nov 2024 01:36:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3A9CC4CED4;
	Sun, 10 Nov 2024 01:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731202619;
	bh=CuefUAuu2ymiIcWDp7fjjKsIw2/LHtdF4FuH73CuyK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i7gQgzTRVWoE3MSGJo91WHpUNSu3jtq16SwETWmoDxFzWgfy+IA/6eqHr0gmxctPD
	 Ezay9mIHwLgrsAcz3ji5zL6xLNl5C8bMWaBByQn6TrXO6X0voGE9Ab1c4GABhbVT3C
	 GnuhVYXofepqdtV0hrIZtiHJ5xQdzTCSCzKNyrgWaKIsoHRBShdA5CAcWftM24CTHN
	 i7RtSxOMkUTCKCsAo3jd2bd5NPcXMbYDEYOHj6oOJ5JKxFWfaVtExBVUdYMA3sFy+O
	 nuZRaX78Gidhg1Q1KSCPrp9M51rI5LAgKJy07TVClwSqjNoK7Fd46dpsU5YsBbc4W2
	 cVU0U0X79lgJA==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	cocci@inria.fr,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nicolas Schier <n.schier@avm.de>
Date: Sun, 10 Nov 2024 10:34:29 +0900
Message-ID: <20241110013649.34903-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241110013649.34903-1-masahiroy@kernel.org>
References: <20241110013649.34903-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [cocci] [PATCH v2 01/11] kbuild: replace two $(abs_objtree) with
 $(CURDIR) in top Makefile
Reply-To: Masahiro Yamada <masahiroy@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 1976
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/20241110013649.34903-2-masahiroy%40kernel.org>

Kbuild changes the working directory until it matches $(abs_objtree).

When $(need-sub-make) is empty, $(abs_objtree) is the same as $(CURDIR).

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nicolas Schier <n.schier@avm.de>
---

(no changes since v1)

 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 8dceb6830486..891d28e54791 100644
--- a/Makefile
+++ b/Makefile
@@ -228,12 +228,12 @@ else # need-sub-make
 
 # We process the rest of the Makefile if this is the final invocation of make
 
-ifeq ($(abs_srctree),$(abs_objtree))
+ifeq ($(abs_srctree),$(CURDIR))
         # building in the source tree
         srctree := .
 	building_out_of_srctree :=
 else
-        ifeq ($(abs_srctree)/,$(dir $(abs_objtree)))
+        ifeq ($(abs_srctree)/,$(dir $(CURDIR)))
                 # building in a subdirectory of the source tree
                 srctree := ..
         else
-- 
2.43.0

