Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7546C54EAA
	for <cocci@archiver.kernel.org>; Thu, 26 Jan 2023 22:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=9MIGNN/QFpWV8BC9A6j3SI6+uueVFhl5L3EK1/3tyuU=;
  b=nbrPsNc+LcAIXfvyTAJpuKjLhycj81ivrOe15oryLDAB9wDv87NKotTF
   l+8PvWydiZy3Xq22Zjhg2283RhxLP1jS77WFx8MM/Z3eJvytukBxaaq3p
   8O5Cp/dW7+Azf3SG4kpGI1gwYXWBsCHHNSUicnIV8z9HYVc9jEu2skhmZ
   M=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@kernel.org
X-IronPort-AV: E=Sophos;i="5.97,249,1669071600"; 
   d="scan'208";a="89634275"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Jan 2023 23:12:36 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id AF033E03B5; Thu, 26 Jan 2023 23:12:36 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 3EBAFE021D
	for <cocci@sympa.inria.fr>; Thu, 26 Jan 2023 22:56:22 +0100 (CET)
IronPort-SDR: 63d2f705_gR0tT837cpVwk1MgoJDIk3mP1s+m0h3hqC+Ypv/8j2BC4/j
 4zhUVz/VpPIoCF5vD2QgGq5gSxaSiliOBuDXBZw==
X-IPAS-Result: =?us-ascii?q?A0EjAgDs9dJjkNlUsotahQWBXi4EC0WNTadfDwEDAQ1EB?=
 =?us-ascii?q?AEBAwSFAIUlAh0HAQQ0EwECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEA?=
 =?us-ascii?q?QECEAEBAQEBARcJHhAOBSKFaA2CNykBdYEIAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RYCDVKBMAENAQE3AYE9E4J+gyMDA6xrgQGCCAEBBp1JgV4JgUCLYYRLgSEcg?=
 =?us-ascii?q?g2BFYE8giyEC06GKo4djTwKgTl4gSUOTHqBDwIJAhF0VgMJAwcFSUADCxgNF?=
 =?us-ascii?q?jIKEyw1FkorGhsHgQYqKBUDBAQDAgYTAyICDSgxFAQpEw0nJmkJAgMiYgMDB?=
 =?us-ascii?q?CgtCSAfByYkPAdWNwYCDx83BgMJAwIfT3EvEhIFAwsVKkcECDYFBlISAggPE?=
 =?us-ascii?q?g8sRA5CNzQTBlwBKQsOEQNQRxluBIIRLyafKoEOf8UYg3yBUp59GjKBRIIik?=
 =?us-ascii?q?xWSLgGXTaM8hFSBeSOBXE0wCIMiTwMZD445iG2KXUE0OwIHCwEBAwmJSoJZA?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23: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
 zHd/IYGS76OkeSVzDdjFh1UpWQS7L8=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:j5WTO68ArUDafJWg43Ruk+DVI+orL9Y04lQ7vn2ZKCYlFfBw8v
 rFoB11726WtN98YhEdcLO7WZVoI0msl6KdiLN5VdyftWLdyQ6Vxe9ZnO/fKv7bdxEWNNQx6U
 6tScdD4RTLY2RHsQ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.97,249,1669071600"; 
   d="scan'208";a="46122958"
X-MGA-submission: =?us-ascii?q?MDGpaTcxaY/tTQlFuFAHOvSo/xf2FnjVwE+5L0?=
 =?us-ascii?q?/+UsGfA7bFPfaGpFtRI0Y7XlHDEcpvLUtFO6TOR7xlua1oPvQ1BjqtMj?=
 =?us-ascii?q?K4Tl/aWAFi+MEfMxUwlC0esxsQF3yr91twPXL02/5Zlsr5viC+y704YY?=
 =?us-ascii?q?V65VQHZMagW38egJ7Nl+x6qQ=3D=3D?=
Received: from dfw.source.kernel.org ([139.178.84.217])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 22:56:21 +0100
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 651C861902;
	Thu, 26 Jan 2023 21:56:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 746E6C433EF;
	Thu, 26 Jan 2023 21:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1674770178;
	bh=89eL4l2vH6KCZTfrG7vyQ7zHN+D+4zoTm+z0+a6kYA4=;
	h=From:To:Cc:Subject:Date:From;
	b=X3Ijtpavk2nl0kbJmvOx/mICvbhWFQO+eT+KZXaFBFXVtSNMzNUzEY7dqXNQSaKTs
	 HCeHOSi2V6Fd8NkozdRvZfkrWcdKUnFt+YiuqmO2g2Rft23oTXh4PgmuKG2juWiXWb
	 f5GEeVS3077wko+ePk0NLg+SjFiEMtKMGG2eBkjLiPn7rNU3UrhbVedKQNkAKsJ+jl
	 Z5gsJHrhp+xjJCoqDDAI6xKsa5OCnt6SCqSg9im1sL8trTfyQylyo84usrcDZfvGFw
	 HrHiBLRwKG51MTRJSOWaRddrNlg/l6yUrFtKjL4r/CcPia9NxdeAXY8kr/f5qyZxHa
	 iVx+J1bdtqohQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Julia Lawall <Julia.Lawall@inria.fr>
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	cocci@inria.fr (moderated list:COCCINELLE/Semantic Patches (SmPL)),
	linux-kernel@vger.kernel.org (open list)
Date: Thu, 26 Jan 2023 21:56:12 +0000
Message-Id: <20230126215612.86436-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH] scripts: coccicheck: Use /usr/bin/env
Reply-To: Jarkko Sakkinen <jarkko@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 819
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-01/20230126215612.86436-1-jarkko%40kernel.org>

If bash is not located under /bin, coccicheck fails to run.  In the real
world, this happens for instance when NixOS is used in the host.  Instead,
use /usr/bin/env to locate the executable binary for bash.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 scripts/coccicheck | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index 2956fce8fa4f..b4d0d6eb3e73 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/usr/bin/env bash
 # SPDX-License-Identifier: GPL-2.0
 # Linux kernel coccicheck
 #
-- 
2.38.1

