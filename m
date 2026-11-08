Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DF6606A321
	for <cocci@archiver.kernel.org>; Mon,  9 Nov 2026 11:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=qvhs/QfP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:in-reply-to:references:message-id:date:to:cc:
   subject:reply-to:sender:list-id:list-help:list-subscribe:
   list-unsubscribe:list-post:list-owner:list-archive;
  bh=0UkMIMefIrI0LzdUfAnYyhtRoKKPW1zW0p+XqV3GHKE=;
  b=qvhs/QfPtwHJ9jvUbRxeoPUmb7vNLgy/VgqDcLtCCUq0PaLxKUEAKwwU
   jSlf3UqwyM8mkNGofCkK8DkES4kCBSKXMCxG8bUvX4uxm2qsO9ncD9u8w
   8guvtvlTABGMUOjpDopEDzd11ntScTY0Ot6LMq084wzfGQP0Hka9Z9mc4
   w=;
X-CSE-ConnectionGUID: Pn3WnQ5IQ5O50kkrGmmAyw==
X-CSE-MsgGUID: SOa4+JRcSMaQvXsZeSl+Mg==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.27 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:128.93.162.27 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.27,203,1787004000"; 
   d="scan'208";a="304544184"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Nov 2026 12:15:06 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 96974817A4; Mon,  9 Nov 2026 12:15:06 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id C1339800E6
	for <cocci@sympa.inria.fr>; Mon,  9 Nov 2026 00:12:33 +0100 (CET)
X-CSE-ConnectionGUID: +k/Yp0s0SHOvh56VyeLhxQ==
X-CSE-MsgGUID: htwfjrdAQVixILjqDJa9lw==
IronPort-SDR: 6af101ce_WX4yYHa1CMUM0JLplxx9ZZYR8LrIA/DoJ1fGqSTqOL6Z+HC
 lLW7qeJA8g25YqKH9pOLklzSJSbTepTD/Iwr0eA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FhAQBXAfFqhf4EaaxaglmBblOBC2IyBAtJjVKIfZg/h?=
 =?us-ascii?q?WKBcwkCDwEDAQ0uFg0EAQEBAgSEfgKOHgIeBwEEMAkOAQIEAwIDAQEBAQEBA?=
 =?us-ascii?q?QEBAQELAQEBBAEBAQIBAQIEAwEBAQECEAEBAQFASYZPDYwaAYEkgSYBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEdAg1+AQEBAgEBAj0BATcBBAsLRlYGgxUBgiIHJCcDARAGuyOCL?=
 =?us-ascii?q?IEBggwBAQbcTYFTAwaBTY5bAYJOgi8ngiiBR4J5PoFScR4DiCWCJoEMkEWGe?=
 =?us-ascii?q?1KBFANZLAFVExcLBwWBJUMDgQYjSwUtHYEjIR0XEXYbBgUSICpBQ1uBEoEHX?=
 =?us-ascii?q?YErKF0BAh9GLRWBdgKCUYEjXQIBSUEOB0VTCSVDEkckIggSCQETGiwKgRo1P?=
 =?us-ascii?q?AkmPxUMZAsaBRpHCAILAgx0KBEQEx0eJC8FHCY+Gwo2bT03FRkEk3WDc1cCt?=
 =?us-ascii?q?BqVGZBOlVQzg3EBk2EWkwguh2aQdI4KlgGFOYFoOoFcfYMqUAMZD447iHzEZ?=
 =?us-ascii?q?kU0AgEIMgIHAgcOAwuSHIFMAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:i3HjnquGf7oLjrtlfRV4/kDG7skD1NV00zEX/kB9WHVpmwKj5r
 2TdZEguCMc5wxhI03I9ervBEDEexLhHOBOkPEs1N6ZNWGM0geVxcNZjbcKqAeOJ8SRzJ8m6Y
 5QN5FETPn9FlZ3yez95A25DpIBzbC8gdmVrNab9kwoaQ1wZa0l1At3DQ6eHiRNNW97LKt8La
 HZwsZdqTblRG8aYq2Adx44dtmGnuaOqYnvaxwLCloM7g2LjS7tyLOSKWn94j4uFwp1hYo4+W
 LGnwG8w6W4rrWax3bnpgzuxqUToeCk98BKDs6Bh4wwJi/3ggilIKRtMofy3gwdkaWX0xIWi9
 HHoRsse/9+73XNcgiO0H7Q5zU=
X-Talos-CUID: =?us-ascii?q?9a23=3AixndCmq8yUyHC7sDiRCRUF3mUYMmNUzFlGyIGG+?=
 =?us-ascii?q?fF2Y0FoOERHuQ6Joxxg=3D=3D?=
X-Talos-MUID: 9a23:u7I4tAk2PVxH2U2pkEmmdnpiKNhm4b6iIXkzkIUnn8udGQ55ajOC2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,202,1787004000"; 
   d="scan'208";a="304442533"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDE5um8FJhhN35/Kl9U/qTmn03grx2lRJD8mgP?=
 =?us-ascii?q?iDX6i7GkCVSmFApao2Meu+XAk20cIHM8KAyHupJThxUhkhf7CEH9DGyt?=
 =?us-ascii?q?hfNpKOPGMcxnBSrpym+JrLeLQuXwef0D/ENYZfq+KnrFsNL3wDWnX5nP?=
 =?us-ascii?q?MEki3gabZicdL5FfvEKN3Wmg=3D=3D?=
Received: from tor.source.kernel.org ([172.105.4.254])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 00:12:15 +0100
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 42FE4605FB;
	Sun,  8 Nov 2026 23:12:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E35241F0089F;
	Sun,  8 Nov 2026 23:12:13 +0000 (UTC)
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D83CF380821F;
	Sun,  8 Nov 2026 23:12:13 +0000 (UTC)
From: pr-tracker-bot@kernel.org
In-Reply-To: <202611052158.614CB01@keescook>
References: <202611052158.614CB01@keescook>
X-PR-Tracked-List-Id: <cocci.inria.fr>
X-PR-Tracked-Message-Id: <202611052158.614CB01@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/devm_kmalloc_obj-v7.4-rc2
X-PR-Tracked-Commit-Id: 4dd10fbbeb9c33709edc89916e19c03c780a0751
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e0d8e8de8bcb1ef7b749033b5af5518ba8df7bec
Message-Id: <179417953244.1902725.2337585856363821544.pr-tracker-bot@kernel.org>
Date: Sun, 08 Nov 2026 23:12:12 +0000
To: Kees Cook <kees@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, cocci@inria.fr, Julia Lawall <Julia.Lawall@inria.fr>, Kees Cook <kees@kernel.org>, Nicolas Palix <nicolas.palix@imag.fr>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [GIT PULL] devm_kmalloc_obj conversion for v7.4-rc2
Reply-To: pr-tracker-bot@kernel.org
X-Loop: cocci@inria.fr
X-Sequence: 3788
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-11/jNp4pm-21WS7J6WxnjrvPg>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

The pull request you sent on Thu, 5 Nov 2026 21:59:04 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/devm_kmalloc_obj-v7.4-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e0d8e8de8bcb1ef7b749033b5af5518ba8df7bec

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
