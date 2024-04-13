Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4BC9C4345F
	for <cocci@archiver.kernel.org>; Sat, 13 Apr 2024 06:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=PqrLRWsosKKWeLJkVDiML01ivzlepuFVpkc9BMT6AKQ=;
  b=eOy8saWAWAkLqtyIqQpzGR5Tdy0g6f3eSKbNcWODFJKYc+j3W4Z3BnPC
   4H8bhQG1HnCJHSVWB1xmoTcg2UpYGdyVCMluBg9eKdRnOdosW1uMLboUE
   0YNHd0NboyUxrDlm7CmcnO3BS2lVOrBBrSqmWC9/UDz7P8e/k29gZNT2i
   k=;
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
   d="scan'208";a="161387587"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Apr 2024 08:57:34 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 365DBE0CD0; Sat, 13 Apr 2024 08:57:34 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id B2E83E004E
	for <cocci@sympa.inria.fr>; Sat, 13 Apr 2024 08:57:32 +0200 (CEST)
IronPort-SDR: 661a2cdc_zvQZbv2J1kAUwSd+d4zliirG20xMVuJVTdfgr6SoU757067
 TPMFR8e6U0W1qdNUGVS03W/xNTs0zympN9nzx0Q==
X-IPAS-Result: =?us-ascii?q?A0F2CADXKxpmkCH+dcJagliCRIFRMAMHCEiNUqZ3gX4PA?=
 =?us-ascii?q?QMBDUQEAQEDAQOEf4gbIAYBBDAJDgECBAEBAQEDAgMBAQEBAQEIAQEFAQEBA?=
 =?us-ascii?q?gEBAgQGAQIQAQEBAQEBIB4QCgQnhW0NgmCBDYENAQEBAQEBAQEBAgEBASIrA?=
 =?us-ascii?q?oELNgENAQE3AYRPgmAHslqBAYIKAQEGgmbZN4FhCYFIjQeEaoNJhH2FEIVUI?=
 =?us-ascii?q?qIFSoF/MgFVEw4kDwwaAhsUDSQjAiw+AwkKEAIWAx0UBDIRCQsmAyoGNgISD?=
 =?us-ascii?q?AYGBlsgFgkEIwMIBANQAyBwEQMEGgQLB3WDOwQTRAMQgTKKF4M9KYF5hDRLh?=
 =?us-ascii?q?Q2BPgMJAwcFSUADCxgNSBEsNRQbKB9uB6ASAWAuKcgzhB2hLU2DcpNUkm6YY?=
 =?us-ascii?q?qJ5gSmEY4FkOoFcMxojgzdPAxkPjjmDYZ5YRDI7AgcLAQEDCYkigUgBAQ?=
IronPort-PHdr: A9a23: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
 NXSj/qobjtPoYu8wA==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:8VLEpasEV67w+BKlTixqQpHM7skDTNV00zEX/kB9WHVpmwKj9v
 xG+85rsiMc7Qx7ZJhOo6HiBEDtexzhHP1OkO0s1NWZLWvbUQKTRekJgLcKqAeBJ8SRzIBgPN
 9bAs1DIey1MXU/t8Lm+U2DH8w7wN+BmZrFudvj
X-Talos-CUID: 9a23:/Y3Lw2GK8/n8TYDrqmI50GI/HZs3WEb+3XfNLne8Tk0ueeO8HAo=
X-Talos-MUID: 9a23:U2rU7QWjGnusztzq/GexiyhLE/sz36qnN3EEo9Y3gdm8CAUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,198,1708383600"; 
   d="scan'208";a="161387583"
X-MGA-submission: =?us-ascii?q?MDEbybguRILmTLlJFcWxMeKNgZIkT6sNmq3MY4?=
 =?us-ascii?q?HvEznh0bShTcGmGDLd+h8TMSS8sE6hiyjtYJGBAuWk3nSDH2lVNwn5fW?=
 =?us-ascii?q?6O34xOlrcRyT0lxhxKqtitbXS2O32+R4m7oXYHL3Yfo2J3CSjz6SQ/PV?=
 =?us-ascii?q?/FZ8EVmrIgnTi+jg05ebNnmA=3D=3D?=
Received: from www.zeus03.de (HELO mail.zeus03.de) ([194.117.254.33])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2024 08:57:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=PqrLRWsosKKWeL
	JkVDiML01ivzlepuFVpkc9BMT6AKQ=; b=hWG33PNsg3uJUDlHY4bUuHe1koScSa
	PdAONWlW8ZkxoFfKz+xJs7IqmAJ7GLFlFCcgcWmIJktVkjythGgDq9+1gFPhaB+a
	BKlUh6s3IYayg6cM3MfhhoBb0QBQZzGSSRZwfbdgpuaYu1ceGyu7ujNfSk7p1GyG
	xYL3EBupFcj6MIh/ZXlrqYUZq4nu3X4ADXtUsHfW1D+nGhGrDfaHNRCnW+4PcMRr
	1zvpZuoF/rAzdmvAO5F2TC1fKOJpNyjtPRUZp476TdoaVwHwjIXMNkyu5JPMYDPh
	keNiIpj7VybffeX8djVhimjDB+GZiTQL9Vjqn3UXWwTkQLJa/RSHVHeQ==
Received: (qmail 1439101 invoked from network); 13 Apr 2024 08:57:30 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 Apr 2024 08:57:30 +0200
X-UD-Smtp-Session: l3s3148p1@Trrf5vQV0FhQk7GI
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: cocci@inria.fr
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date: Sat, 13 Apr 2024 08:57:24 +0200
Message-ID: <20240413065726.2197-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [cocci] [PATCH 0/2] docs: updates to hevea handling
Reply-To: Wolfram Sang <wsa+renesas@sang-engineering.com>
X-Loop: cocci@inria.fr
X-Sequence: 1647
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-04/20240413065726.2197-1-wsa%2Brenesas%40sang-engineering.com>

When compiling coccinelle on my own, I didn't have hevea installed.
Since it is not needed for the PDF docs I was interested in, I rewrote
the Makefile a little in patch 1 to move its dependency to HTML docs
only. In patch 2, I added it hevea to install.txt as optional for HTML.

Wolfram Sang (2):
  docs/manual/Makefile: check xxdate only for HTML builds
  install.txt: mention 'hevea' as dependency for HTML docs

 docs/manual/Makefile | 17 +++++++++--------
 install.txt          |  2 ++
 2 files changed, 11 insertions(+), 8 deletions(-)

-- 
2.43.0

