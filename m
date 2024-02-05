Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1FEFC48297
	for <cocci@archiver.kernel.org>; Tue,  6 Feb 2024 14:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=ouo52r5EDr/WjKPfdZ+MSqtX2LJHIs7K9hr4bEahg+w=;
  b=LfwJFSB7C66nw1id03/I9CgeWpnCiRFhosCILS0Mc10eeMHryUrcnvdR
   sAjMISgeQasFpkMl/TO88MjyVoW3iG8zo3panU8b8pzvS0u4wiW0Si555
   EeJS5yS4X07362k7Vea/b+YwiofW9A6ywyxCNnERpa1JnA+ZPVoM97tsE
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@kernel.org
X-IronPort-AV: E=Sophos;i="6.05,247,1701126000"; 
   d="scan'208";a="150576281"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Feb 2024 15:48:54 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D09BEE0CD5; Tue,  6 Feb 2024 15:48:53 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 8AEA1E008A
	for <cocci@sympa.inria.fr>; Mon,  5 Feb 2024 18:56:44 +0100 (CET)
IronPort-SDR: 65c1215b_cggyiilht3ol7Xi3UHcNtUnhC1n45zd72/xToSNdnAmDeB8
 8o/nLNFuwCH+S/aIkz1bBUzTYQmwcVX1KzXkaAw==
X-IPAS-Result: =?us-ascii?q?A0EYAAAmIMFlkDdJKJFaHQEBAQEJARIBBQUBQIE7CAELA?=
 =?us-ascii?q?YI4fFYyBAtIjHBfhkldBoE/i3KSF4FAPg8BAwENOQsEAQEDBIR/h1gCHgcBB?=
 =?us-ascii?q?DAJDgECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGAQIQAQEBAQEBIB4QD?=
 =?us-ascii?q?ieFbA2CXAEQgQyBHgEBAQEBAQEBAQEBAQEBAQEBARcCDYE8BgEBNwGBPIMTA?=
 =?us-ascii?q?YJfAwQNBrYsgTSBAYIKAQEGgmWwGQMGgUgBiCUBiS+BIRt9gRCBFYZJAoE4P?=
 =?us-ascii?q?YYugheDPIoxi1CBUx0DgQZtGxAeNxEQEw0DCG4dAhEiOgMFAwQyChIMCx8FE?=
 =?us-ascii?q?0IDQAZJCwMCGgUDAwSBMAUNGgIQLCYDAxJJAhAUAzgDAwYDCjEwVUEMUANkH?=
 =?us-ascii?q?zIJPA8MGgIbGw0nIwIsQAMREAIWAx0WBDQRCQsmAyoGNgISDAYGBl0jFgkEJ?=
 =?us-ascii?q?QMIBANUAyF0EQMECgMUBwsHeIFRgXYEE0QDEIE0hlYDRB1AAwttPTUUGwacK?=
 =?us-ascii?q?gGCR4ENASuBBYFyo1JpoGGEG4Rqhx2VFxozly2ScphWjW2Vc4URgWM6gVxNM?=
 =?us-ascii?q?AiDIk8DGQ+OIBmDYYUUiwYgNTsCBwsBAQMJiG8zgUYBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 A==
IronPort-HdrOrdr: A9a23:ar5gsa+4/njXaSvEnQNuk+DLI+orL9Y04lQ7vn2ZhyY1TiX+rb
 HLoB17726QtN91YhwdcL+7VJVoLUmyyXcX2/hyAV7BZniEhILAFugLhuHfKlbbexEWmNQy6Z
 td
X-Talos-CUID: =?us-ascii?q?9a23=3ANr+rqGqMWTRbuPl1vcp3k2jmUdAsY3fMyFHfGWi?=
 =?us-ascii?q?1Sl42cY+OFnu63rwxxg=3D=3D?=
X-Talos-MUID: 9a23:6u0DhgrBVoj9WkvjfIMezzBiGONKzoXzMX4itbYjg/XbJR1KHCjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.05,245,1701126000"; 
   d="scan'208";a="78794031"
X-MGA-submission: =?us-ascii?q?MDEyOK1WYu8C3Pb/MozlLDBiUJZSbLpX6sefwm?=
 =?us-ascii?q?KFlV766BUU6YIj/WHdnTfuCLjC4bZYzwzQqcNYffd5iQ2RW4SJZhr99E?=
 =?us-ascii?q?hL6RlLINhxyz7ICSz6FWk9dbNRap8xhBM0b8IsUSQSp6DW4XNEhXbsLZ?=
 =?us-ascii?q?XZuCFZr5N516f1+J2Jf34OVw=3D=3D?=
Received: from sin.source.kernel.org ([145.40.73.55])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 18:56:43 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 1B1D4CE102A;
	Mon,  5 Feb 2024 17:56:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 492E2C433F1;
	Mon,  5 Feb 2024 17:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707155798;
	bh=ouo52r5EDr/WjKPfdZ+MSqtX2LJHIs7K9hr4bEahg+w=;
	h=Date:From:To:Cc:Subject:From;
	b=Q3TPMdYN6o/eNRCONseiVK/VVCDdeMcTiIM3GSPGyJ1h0I4W3LQCChZ27xSBVasuQ
	 n0VbGNSnv9O6HjU1PFWVFeUpLKBGI4kfLNMY+QXc+CZ0oHvXRINk4Wpn1QGzr3W7VX
	 gtVary/PjBCbqMhs3UTLQ4Kj12UJdDP2LULTzEVKQ5cFDFNRPIPX9+x7rPGiGAyWVt
	 ZHye+UdmIJKXFzUceWtyqYg8OmzUwoA40t+Clvr8nMdYf546RfPG2jMPeOWJmpDZPp
	 Rn6SEKUolAVoTyXniIT5sHueLCRvrtVimHHuYCrhtvl4GTov4Cdi/Mk65GCdQKF4Zu
	 3r/JG9KuS/HwQ==
Date: Mon, 5 Feb 2024 09:56:37 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
Message-ID: <20240205095637.54f3f450@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] spatch --use-patch-diff broken?
Reply-To: Jakub Kicinski <kuba@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 1503
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/20240205095637.54f3f450%40kernel.org>

Hi!

I've been trying to run coccicheck with --use-patch-diff
to try to limit the number of processed files. I _think_
it worked when I set it up early last month but recently
I went back to check and make coccicheck stops after
the first spatch call, all it prints is "hd"

https://netdev-3.bots.linux.dev/cocci/results/452585/new

spatch seems to work fine when run without --use-patch-diff
cocci version is the latest from git as of $now

FWIW the git hashes are from this tree:
https://github.com/linux-netdev/testing.git
(probably best to clone that thing with --depth $number)


Example:

/usr/local/bin/spatch -D report --no-show-diff --very-quiet --cocci-file ./scripts/coccinelle/api/err_cast.cocci --no-includes --include-headers --dir . -I ./arch/x86/include -I ./arch/x86/include/generated -I ./include -I ./arch/x86/include/uapi -I ./arch/x86/include/generated/uapi -I ./include/uapi -I ./include/generated/uapi --include ./include/linux/compiler-version.h --include ./include/linux/kconfig.h --jobs 48 --chunksize 1 --use-patch-diff b9f2444cd114a7f9c44950dc850aa1753b3edd94..be5bf59888403413619dd74e0d5f5386ffafbc90
grep: warning: + at start of expression
grep: warning: + at start of expression
grep: warning: + at start of expression
hd
