Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25DD3C4345F
	for <cocci@archiver.kernel.org>; Sat, 13 Apr 2024 06:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=gSk7quLbjARrHMCsbd9oge7jvV753eoTMXR2Kguk0uE=;
  b=je58kMvW7X5PCm/7JPnQ0YiPcv7VWN0nui+nRW9Yho9CUFu20PPWO4/B
   ykDDZzNfCWYtpp1WjfrL90RvO1QFvyHz8xqd3xZM+3+wPfci8hZ5DIaUw
   Trlss22Hp4rapQYlU3BZx8ba+0q1imhkATOPhCFKxyt8PsPADX7Eg9BzL
   M=;
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@sang-engineering.com
X-IronPort-AV: E=Sophos;i="6.07,198,1708383600"; 
   d="scan'208";a="161387709"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Apr 2024 08:58:16 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 44010E0AF1; Sat, 13 Apr 2024 08:58:16 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 38EA4E004E
	for <cocci@sympa.inria.fr>; Sat, 13 Apr 2024 08:58:12 +0200 (CEST)
IronPort-SDR: 661a2d03_PlZNRlk8NIkNe/kJ3eEyQJg8/v4iLcSR4LU9WkA3hBuafXA
 h4oW7s1hs2PBnsh1p/1Do1XWIDZlvQEcM2aL/aQ==
X-IPAS-Result: =?us-ascii?q?A0GVAADXKxpmkCH+dcJaHQEBAQEJARIBBQUBgXsIAQsBg?=
 =?us-ascii?q?kOBUTADBwhIjHNfpneBfg8BAwENRAQBAQMBA4R/AogZIAcEBioJDgECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGAQIQAQEBAQEBIB4QCgQnhW0NgmCBD?=
 =?us-ascii?q?YENAQEBAQEBAQEBAgEBASIrAoEJAgEDMgENAQE3AQ9RVhmDAIJgB7JagQGCC?=
 =?us-ascii?q?gEBBoJm2TeBYQmBSAGNBleEE3qCT4R9hRCFVCKQdYZzhCWFeEqBfzIBVRMOJ?=
 =?us-ascii?q?AsEDBoCGxQNJCMCLD4DCQoQAhYDHRQEMhEJCyYDKgY2AhIMBgYGWyAWCQQjA?=
 =?us-ascii?q?wgEA1ADIHARAwQaBAsHdYM7BBNEAxCBMooXggmBNCmBeYQ0S4UNgT4DCQMHB?=
 =?us-ascii?q?UlAAwsYDUgRLDUUG0duB6ASAWAaEyqVY7JQhB2hLU2XRpJumGKieYEphGOBZ?=
 =?us-ascii?q?DqBXDMaI4M3TwMZD44gGYNhnlhEMjsCBwsBAQMJiSJoYAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:bxWiuaD4mKDIcQHlHema55DYdb4zR+YMi2TDGXoRdfUzSL3gqy
 nKpp8mPHDP+VUssR0b9uxofZPwJU80lqQFh7X5X43SPjUO0VHAROsO0WKh+UyGJ8SUzI5gPM
 lbHZSWcOeAaGRSvILHzU2DF8s4hOOK6rqpg+C29RtQcT0=
X-Talos-CUID: =?us-ascii?q?9a23=3AeJWYwWrygILLGQ7qmJ1KhnfmUfA7aHTj0H3PHwy?=
 =?us-ascii?q?5JHYwYueTZ0W+3Zoxxg=3D=3D?=
X-Talos-MUID: 9a23:CJrgzQjd/WkNSNND4it5WMMpBeRY+v2KJBw2yYRf69m6ESVvEDOBpWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,198,1708383600"; 
   d="scan'208";a="161387680"
X-MGA-submission: =?us-ascii?q?MDGuAnIWkIkBvlcCVqOWM47O3Veos9VkD9j/4x?=
 =?us-ascii?q?FrEw1RC28gbJGvG2WpARz8FlMsihNHNLmpT5ib+UK4xORTq7JrNwrrZz?=
 =?us-ascii?q?KForwzmpicvfSu29aFdxwf+w55rLdsuIcD3qFLQy7Uz78RI2C5RDIjJb?=
 =?us-ascii?q?dYnTshCjqrhw1a7iZgr33jpQ=3D=3D?=
Received: from www.zeus03.de (HELO mail.zeus03.de) ([194.117.254.33])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2024 08:57:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=gSk7quLbjARrHMCsbd9oge7jvV753eoTMXR2Kguk0uE=; b=dQgNKV
	HCtK/yUVj4mPiYOFIzuLJc24TplKAdCutAVT27Upl75Vyr1KNSybOhLBGFU9yEhK
	C9yl1IpGgKP5tnihvnfh07/hazc2x4rMB2EDaRPnZ5MytlWqrjCrQqJapsQr6iUm
	iMx9ln6WcxHvUtN2JYdXacZ0eLwJJRJ09v846Bee1iYlCsL/c6ePf4UL0Vm/oLz2
	Vfy8OterEt0WgKjm7hxx9aILVUD2uuEGDBKCDYvqYMYDaQZv4CQpt4H/fiOMw111
	Pz5SsYVH+7HzfeaM9SJTAfqNgEsqCgjADrOKSbe8/4RNl7C1TGuvr9dqkZCjuwlJ
	t3+S7XdEqRxZq6LA==
Received: (qmail 1439120 invoked from network); 13 Apr 2024 08:57:31 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 Apr 2024 08:57:31 +0200
X-UD-Smtp-Session: l3s3148p1@Fc/s5vQVdN5Qk7GI
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: cocci@inria.fr
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date: Sat, 13 Apr 2024 08:57:25 +0200
Message-ID: <20240413065726.2197-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240413065726.2197-1-wsa+renesas@sang-engineering.com>
References: <20240413065726.2197-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [cocci] [PATCH 1/2] docs/manual/Makefile: check xxdate only for
 HTML builds
Reply-To: Wolfram Sang <wsa+renesas@sang-engineering.com>
X-Loop: cocci@inria.fr
X-Sequence: 1649
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-04/20240413065726.2197-2-wsa%2Brenesas%40sang-engineering.com>

This allows PDF documentation to be built without hevea installed.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 docs/manual/Makefile | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/docs/manual/Makefile b/docs/manual/Makefile
index 7a0e001a..04894c2a 100644
--- a/docs/manual/Makefile
+++ b/docs/manual/Makefile
@@ -6,12 +6,6 @@ ifneq ($(MAKECMDGOALS),distclean)
 include ../../Makefile.config
 -include ../../Makefile.local
 endif
-HEVEA = hevea
-HEVEA_XXDATE := $(shell ./find-xxdate)
-
-$(if $(HEVEA_XXDATE),,$(error Hevea: Unable to find xxdate.exe))
-
-HEVEA_CMD := $(HEVEA) -exec $(HEVEA_XXDATE)
 
 MAINSRC=main.tex
 SRC=$(wildcard *.tex)
@@ -69,17 +63,24 @@ distclean:: clean
 ##############################################################################
 # Html version
 ##############################################################################
-.PHONY: html check
+.PHONY: html check checkxxdate
 
 .SUFFIXES: .html .tex
 
+HEVEA = hevea
+HEVEA_XXDATE := $(shell ./find-xxdate)
+HEVEA_CMD := $(HEVEA) -exec $(HEVEA_XXDATE)
+
 TEX=main_grammar.tex
 WEBBASE?=~/website
 WEBDOCS=$(WEBBASE)/docs
 
 HTML=$(TEX:.tex=.html)
 
-html: $(HTML)
+checkxxdate:
+	$(if $(HEVEA_XXDATE),,$(error Hevea: Unable to find xxdate.exe))
+
+html: checkxxdate $(HTML)
 
 clean::
 	rm -f *.aux *.dvi *.pdf *.html *.haux *.htoc *.log *.out *~
-- 
2.43.0

