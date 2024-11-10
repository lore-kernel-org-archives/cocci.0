Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C3AD5E38E
	for <cocci@archiver.kernel.org>; Sun, 10 Nov 2024 01:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Xwdm1BZkjpCku3oivgfpV8jTSpZ28BbqJibInTXXlds=;
  b=EEToXEQwrD/IuTBkXdH7hwPs+PFw1Xrw4ENSZNFfny7/Skp2S8WwQMKh
   63G4fpaMeoEuwZtel5Gj5ZnrGkoq/g9IJ1VqULo/Oh3oFUqqlKHTFqAAu
   fyTNOBP6yeWtjH3OKb2KG/VtJ04SYCsAMwmKZyFYsTRJ47yzVRfFoU8pH
   U=;
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
   d="scan'208";a="193077131"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Nov 2024 02:37:19 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E3907E00B7; Sun, 10 Nov 2024 02:37:18 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 52799E013D
	for <cocci@sympa.inria.fr>; Sun, 10 Nov 2024 02:37:15 +0100 (CET)
IronPort-SDR: 67300e4a_kan6YJAZcpBAHwnmyHnt5yl0HjICkQkeBCWVocvFA7q4sXi
 SyD7VoBAof+pEgz5pzWN+DNGeN9nwBZ0iVQoL6Q==
X-IPAS-Result: =?us-ascii?q?A0FaAQCQDTBnhVvBS5NaHgEBCxIMgggLgkSBVzMEC0iNU?=
 =?us-ascii?q?qcKgX4PAQMBDUQEAQEDBIUAAoo7Ah4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBE?=
 =?us-ascii?q?AEBBQEBAQIBAQIEBgECEAEBAQFASYV7DYJiAYEkgSYBAQEBAQEBAQEBAQEdA?=
 =?us-ascii?q?g1+AgEDMgENAQE3AQ9RVhmDAYJlA7IYgQGCDAEBBtwfgWQJgUiFaodccIN9e?=
 =?us-ascii?q?icbgUlEhH2EWDiFVSKHY4dPgWuBb4waHTOKAEiBIQNZIREBVRMNCgsHBWCBF?=
 =?us-ascii?q?wOCVnorgQ6BFzqBfoEiSoNYgUJGP4JKaU03Ag0CNoIkfYJPhR2Eb2cvAwMDA?=
 =?us-ascii?q?4NFgkBAAwsYDUgRLDUUGwY+bgeeOEaCejSBDoJApV6hA4QkgWOfXBozlz+TD?=
 =?us-ascii?q?ph3o1ZnhGaBZzqBXDMaMIMqTwMZD44hGYh1wRA0NTsCBwsBAQMJjneBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:XRi3LK/ofsEYObfej8huk+DXI+orL9Y04lQ7vn2ZhyY6TiX+rb
 HJoB1/73LJYVkqOE3I9ertBEDEewK4yXcX2/h3AV7BZniEhILAFugLhuHfKn/baknDH4VmtJ
 uIHZIQNDSJNykZsfrH
X-Talos-CUID: 9a23:x/PHemB/xaDsCPD6Eys/8xdIIPweSWT2ynbZLHGXFzh3WoTAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3Au8rwxQ+zwpiTP8+ILyGrd+yQf9ZM+J2jDmcDqrY?=
 =?us-ascii?q?LkdKIJwxIASXEqyviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,142,1728943200"; 
   d="scan'208";a="101200595"
X-MGA-submission: =?us-ascii?q?MDHQVFkEJWMAkQSxvYB9SC1yQ81Di6qulnOqVa?=
 =?us-ascii?q?Bvo+4LfuMhIduqCZUofj0bXxhCHdBUvyeSoj6pRwpi98E4v9ypfeqNDJ?=
 =?us-ascii?q?kmoMdMwEN05JRzKkmhNFIEiVhnXi5HXro/C3MlwBRTWfeBgq0zfTDTzb?=
 =?us-ascii?q?LM691HSZVcEWzUKNdd5Sb9qQ=3D=3D?=
Received: from nyc.source.kernel.org ([147.75.193.91])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2024 02:37:14 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 55CEEA405AA;
	Sun, 10 Nov 2024 01:35:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3521EC4CECE;
	Sun, 10 Nov 2024 01:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731202633;
	bh=rI9k7enmxwz9ojQI4LH1nAFQpHFd3uNrpzEHxR5/YGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GBfoOi0k288Oc2FpvxiCdfmOinmODTTYiDyFLw6K17s+T/wbrVbtbnuZMSDqwE1ET
	 msNvULVPK63bqpTIbrFlLy0KbKYWEin2Ci6T2Fg4ZvI/x/ZvCRikUxejIoGB97Byl9
	 uYPTr678oz1rAViMzpPddJ4CJu/E32uL4xaQAdmWAr+5S/9zKqv5uiHOFpzEySzL6z
	 bQ8PQARZgubVRi6qgUDxHgogBBEVRp5J0vgeYUoEq27uOFL0kzCEx7YL3sTNwJeUN9
	 UuUzef+TBBmDpObs3j8i87lWEhlOacTFmEiPKfX9kK1BwQvy5KjYxy51kOYXV4sHYm
	 Jr/yUTv1Q3Zmg==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	cocci@inria.fr,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>
Date: Sun, 10 Nov 2024 10:34:37 +0900
Message-ID: <20241110013649.34903-10-masahiroy@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241110013649.34903-1-masahiroy@kernel.org>
References: <20241110013649.34903-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [cocci] [PATCH v2 09/11] kbuild: use absolute path in the generated
 wrapper Makefile
Reply-To: Masahiro Yamada <masahiroy@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 1984
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/20241110013649.34903-10-masahiroy%40kernel.org>

Keep the consistent behavior when this Makefile is invoked from another
directory.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
---

(no changes since v1)

 Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 5488aa96b46b..35e34cce4942 100644
--- a/Makefile
+++ b/Makefile
@@ -644,8 +644,9 @@ ifdef building_out_of_srctree
 
 quiet_cmd_makefile = GEN     Makefile
       cmd_makefile = { \
-	echo "\# Automatically generated by $(srctree)/Makefile: don't edit"; \
-	echo "include $(srctree)/Makefile"; \
+	echo "\# Automatically generated by $(abs_srctree)/Makefile: don't edit"; \
+	echo "export KBUILD_OUTPUT = $(CURDIR)"; \
+	echo "include $(abs_srctree)/Makefile"; \
 	} > Makefile
 
 outputmakefile:
-- 
2.43.0

