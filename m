Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89641C4829D
	for <cocci@archiver.kernel.org>; Tue,  6 Feb 2024 14:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=NPqZNgzoaGVAKGmCDSCnjjv6u6nkrNconl+34DkHb5o=;
  b=Q1jbFvGc5OKAE1Mz8XTk4mNaTNeKcaJ9GD9+MdHgqAHthl70FL9XEI/f
   iokp0k/EBfQDZZu57CRWcl4w6voGLhY9eeYuW5Zfk0+3YEGc84piXuOq6
   aO64WZ/bHiKMvPxUsXCes0IjeROKmNJoImNCtKvEZi6rnTLCzdc7ZiUbF
   E=;
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
   d="scan'208";a="150576308"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Feb 2024 15:48:55 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DEA15E0CD8; Tue,  6 Feb 2024 15:48:54 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 27903E008A
	for <cocci@sympa.inria.fr>; Mon,  5 Feb 2024 21:02:56 +0100 (CET)
IronPort-SDR: 65c13eef_ybJDeK0XEUG+cdQjQaW6oywZCjyG6mzLXjGaX5YVeC/+wQ2
 dee9ZTT/hUp3MhnoSQZRiMRFXQ+Gtsrvgq27Whg==
X-IPAS-Result: =?us-ascii?q?A0FIAQA4PcFlkNlUsotaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?U+COXxWMgQLSI1PhkldBoE/A4tvk1c+DwEDAQ05CwQBAQMEhH8Ch1YCHgcBB?=
 =?us-ascii?q?DQTAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBAhABAQEBAQEgHhAOJ?=
 =?us-ascii?q?4VsDYJcARCBDIEeAQEBAQEBAQEBAQEBAQEBAQEBFwINfAECAzoGAQE3AQ8LG?=
 =?us-ascii?q?C5WBoMTAYJfAxEGtwCBNIEBggoBAQaCZbAZAwaBSIgmAYkveicbfYEQgRWDK?=
 =?us-ascii?q?j6CYQKBOD2GLoIXgzyKMYt3VH8dA4EGBFwNGxAeNxEQEw0DCG4dAhEiOgMFA?=
 =?us-ascii?q?wQyChIMCx8FE0IDQAZJCwMCGgUDAwSBMAUNGgIQGgYMJgMDEkkCEBQDOAMDB?=
 =?us-ascii?q?gMKMTBVQQxQA2QfMgk8DwwaAhsbDScjAixAAxEQAhYDHRYENBEJCyYDKgY2A?=
 =?us-ascii?q?hIMBgYGXSMWCQQlAwgEA1QDIXQRAwQKAxQHCwd4gVE4gT4EE0QDEIE0hUGBR?=
 =?us-ascii?q?gNEHUADC209NRQbBiOcJwGCR4ENASuBBUCBMqNSaaBhhBuEaocdhzCNZxozl?=
 =?us-ascii?q?y2ScphWjW2Vc4URgXojgVxNMAiDIk8DGQ+OIBmDYYUUiwYgNTsCBwsBAQMJi?=
 =?us-ascii?q?G8zgUYBAQ?=
IronPort-PHdr: A9a23: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
 pcKDLhBWw5tfhv1IkdoBtoPJNFwRDx2yNam
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:rDk9kamuETTsh4GzumdFsIu28dvpDfIj3DAbv31ZSRFFG/FwWf
 rOoB19726TtN9xYgBGpTnkAsS9qBznmaKdjbN/AV7mZniFhILKFvAH0WKB+UyCJ8SWzIc0vs
 1dmupFebjN5DNB7foSjjPXL+od
X-Talos-CUID: 9a23:eFbWam+s1eWj8JxPNzKVv2kkJ+odfS3a8E/vfXO1Ujw0Z5yFblDFrQ==
X-Talos-MUID: 9a23:VbpYSAg1r6ZpaXphhtnDrcMpauFE3IWNJkE0ir4q6pWYMAYvBm2Ek2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.05,245,1701126000"; 
   d="scan'208";a="78802881"
X-MGA-submission: =?us-ascii?q?MDHUIzwBU0d7iEp1eL/Hq76FvbQNwHMgQ7BZG/?=
 =?us-ascii?q?arhv9gWxG7e1cFG5KSlggOJluyoZwyTk92Alv4MW4b+hyhhYLN8/SftN?=
 =?us-ascii?q?sHPdu+KXPOJ3rVcfW6TKSZxaWS8OmM0dinWD3aclJZp4GBp5/Fw69HZh?=
 =?us-ascii?q?2CU88vviwp6pb4sIkE9Em5xQ=3D=3D?=
Received: from dfw.source.kernel.org ([139.178.84.217])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 21:02:55 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A594C61088;
	Mon,  5 Feb 2024 20:02:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43B85C433C7;
	Mon,  5 Feb 2024 20:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707163372;
	bh=ne3yTUuQ0xl+cEmBJyqs4ReBGJ9oLsFNNh0xZXXWYpk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ClaYh5qkjckFU6NjKKBf2uZUndXZRYVIeE7d9l/rfArH3DFM6wSY6OdNBP+GFYonC
	 vuLEWo9ZhhNXbZBlv7UcqmJxGXlp85ZEUdKQItl4+rQAl0DulaUdJhDV/xCLiaNj70
	 tuy51vg2h8qQaD84K6tBV+l3tHzIbYlJnGvhc+7NISwO+4g9P6MDZH7max0Anwh+iX
	 CeC0Wtkwec63dOVJOdmReJgBtCULieET6zvCm69Hkox6ENx0GOG0kWlVQD080hKjGh
	 zAW0fR9/J/HxqRACHL53RmQjfPRKfVePrIo8GivzZqsF2k9nr7IcFqr75gxyaShfNc
	 3232atVK+UoyQ==
Date: Mon, 5 Feb 2024 12:02:51 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
Message-ID: <20240205120251.1c5e82b2@kernel.org>
In-Reply-To: <alpine.DEB.2.22.394.2402052038430.25075@hadrien>
References: <20240205095637.54f3f450@kernel.org>
	<alpine.DEB.2.22.394.2402052038430.25075@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] spatch --use-patch-diff broken?
Reply-To: Jakub Kicinski <kuba@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 1504
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/20240205120251.1c5e82b2%40kernel.org>

On Mon, 5 Feb 2024 20:39:16 +0100 (CET) Julia Lawall wrote:
> On Mon, 5 Feb 2024, Jakub Kicinski wrote:
> > I've been trying to run coccicheck with --use-patch-diff
> > to try to limit the number of processed files. I _think_
> > it worked when I set it up early last month but recently
> > I went back to check and make coccicheck stops after
> > the first spatch call, all it prints is "hd"
> >
> > https://netdev-3.bots.linux.dev/cocci/results/452585/new
> >
> > spatch seems to work fine when run without --use-patch-diff
> > cocci version is the latest from git as of $now
> >
> > FWIW the git hashes are from this tree:
> > https://github.com/linux-netdev/testing.git
> > (probably best to clone that thing with --depth $number)  
> 
> It might help to drop the --very-quiet argument.  Then you might get more
> information about the source of the problem.

I was looking for a --verbose argument, I didn't spot the --very-quiet
:)  No luck, sadly:

$ /usr/local/bin/spatch -D report --cocci-file ./scripts/coccinelle/api/err_cast.cocci --no-includes --include-headers --dir . -I ./arch/x86/include -I ./arch/x86/include/generated -I ./include -I ./arch/x86/include/uapi -I ./arch/x86/include/generated/uapi -I ./include/uapi -I ./include/generated/uapi --include ./include/linux/compiler-version.h --include ./include/linux/kconfig.h --jobs 48 --chunksize 1 --use-patch-diff b9f2444cd114a7f9c44950dc850aa1753b3edd94..be5bf59888403413619dd74e0d5f5386ffafbc90
init_defs_builtins: /usr/local/lib/coccinelle/standard.h
grep: warning: + at start of expression
grep: warning: + at start of expression
grep: warning: + at start of expression
hd

FWIW:

$ ocaml --version
The OCaml toplevel, version 4.13.1
