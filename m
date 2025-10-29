Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9F71CCF9EB
	for <cocci@archiver.kernel.org>; Wed, 29 Oct 2025 13:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=QuaL1x4ASTopM1U7tHKflFuafJDHPKy1VemXF52daRY=;
  b=dmhsVfov9jXjZ3E0oj/ciMHmr+JvKLEilQxcia4l+qG7GqNUyMExjMcF
   8qubab8ywDu6fOPp/C81NftvyBf+oQCJcW6o/yczlLM8e/sreM/N70iXY
   HtuYe3T//CfqXQfR21RIE8l90YEv0SyufWef8Njwj5qYzGydic4IivYb8
   s=;
X-CSE-ConnectionGUID: vI8rRjf1Slq9lq9we/zY/Q==
X-CSE-MsgGUID: TXVEcsIGQYiU1oHHqw1bXA==
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
X-IronPort-AV: E=Sophos;i="6.19,264,1754949600"; 
   d="scan'208";a="246688000"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Oct 2025 14:42:58 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 12460E0C55; Wed, 29 Oct 2025 14:42:58 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 4934EE0171
	for <cocci@sympa.inria.fr>; Wed, 29 Oct 2025 10:48:18 +0100 (CET)
X-CSE-ConnectionGUID: Dd8ki2mARQCjCglMq3F3sw==
X-CSE-MsgGUID: ZIKb4atRRmKQvESLX5YnXQ==
IronPort-SDR: 6901e2e1_5bIYyI7Fyz3wP1a/y7odJeqFmhWZuNrJPK0e8lZJXO8bZT3
 amGSvj+qa+5L9QZxL8VjXLtnn0mH0Rp8/9Pkabw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EBAABa4QFphR/86qxaGQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RIBAQEBAQEBAQEBAQFAgTwEAQEBAQELAYI/gQJeMwQLSQSIIIRNX4ZXggQdA?=
 =?us-ascii?q?54aFIFpAg8BAwENRA0EAQEDAQOEOkYCjFICHgcBBDAJDgECBAEBAQEDAgMBA?=
 =?us-ascii?q?QEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAQEBAUBJhk8NgmIBM3GBJQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEXAg19AQEBAQM6BgEBNwEPCxEDAQIvEDUJCAYTgwIBg?=
 =?us-ascii?q?iIHSgMRBq9uGjd4gTSBAYIMAQEGgQg+BtpZgWQDBoFKAYVsgmQBhWyDfnonG?=
 =?us-ascii?q?4INhD8+gkoXAgOBKAESAYZlghEVgQ6GJ3mBXTGPIVJ4HANZLAFVExcLBwVbR?=
 =?us-ascii?q?UMDgQsjSwUtHYEkIh8YEWBUQINJDwwGaA8GgRIZSQICAgUCQjqBaAYcBh8SA?=
 =?us-ascii?q?gMBAgI6Vw2BdwICBIIefoIVD4hwAwttPTcUG5RqF4IYTIEgFwQgEIICkwsus?=
 =?us-ascii?q?H2CRoQmgWSKOpYGgUuCOY0ThjuTGS6YWIwOgQ9rlhmFIIFoOmxwMxoIKAiDI?=
 =?us-ascii?q?hM8AxkPWI1JGSWDQoUTxlxCNQIBOQIHCwEBAwmSHoFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 bkjx5E7AvR9LlyFiwreCjxXTNqLHs/n+08=
IronPort-HdrOrdr: A9a23:27q+1q3AUoIN3lurpYSePgqjBLMkLtp133Aq2lEZdPWaSKylfu
 SV7ZImPH7P+VEssRQb9OxoV5PufZqxz/BICMwqTM6ftWrdyQ+VxeNZnOnfKlTbckWUnIJgPO
 VbAs1D4bbLfDtHZKjBgTWFLw==
X-Talos-CUID: 9a23:BDdC1WAMmVN+9z36EwVrpE0VQMUMSET2zlzfJ2qhUkgyU6LAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3Afth8/w5FRpx1QffJh0Y5yzU1xoxawoekVEkRq68?=
 =?us-ascii?q?DmPCaGBdUC2qsigSOF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,263,1754949600"; 
   d="scan'208";a="129384060"
X-MGA-submission: =?us-ascii?q?MDFnR0z7CODvvrGVLI+7Tc0jgfBjBaf1ECfGkV?=
 =?us-ascii?q?4T2EmcKNe5CPu8rztqxvWGWXjMtuUDCtFxEqX3uO6vltDh9OGiI30Lks?=
 =?us-ascii?q?Vdb+iCAidQyQIe8reJz5ZTti3IAgRasj13eV5yoXeXKqmvtfx3Y6uDUt?=
 =?us-ascii?q?zmNzO8SXfGcSv7RLVWPkLDyQ=3D=3D?=
Received: from sea.source.kernel.org ([172.234.252.31])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 10:48:17 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 6E23844E95;
	Wed, 29 Oct 2025 09:48:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46EE3C4CEF7;
	Wed, 29 Oct 2025 09:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761731293;
	bh=XXQMOmDoB7uRQoYEh/4IlSXb0ixVzJ4dV3bcqMlynHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o4qmjR+Q2B7AZMIjrxYZmfZDEtuDKXHR84Mfnkt3cBEYT1pWEaRYjfHrContgSJzd
	 SZh1ffwwye/iJFJG9DxCuWjGv4wy29SHI4BPKa4+WtkfpLyJw7LYgmV/TYEq5KLsgX
	 gyON03bOA1+IIyeR9GnZ9KjTOubkOPQ3LplmuO6Z1XILg8wihLlEtrNFG108FqG8P9
	 lOlI7rUm9QEm2sHYJS1ZhG/Tfou/R32ilV/Ahn/fHcfDoduOYoDhZ4aNV91ZOEIK8O
	 lDdxYKCtT0M/BcpE38ADt/ZefdL1Gc/yFpRRGA6qciXZK5lLQIFkdHlPl8XCT/j+Wx
	 jdXEwngxhWhBw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vE2mw-000000007qy-3Pbc;
	Wed, 29 Oct 2025 10:48:19 +0100
Date: Wed, 29 Oct 2025 10:48:18 +0100
From: Johan Hovold <johan@kernel.org>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.de,
	cocci@inria.fr, Jakub Kicinski <kuba@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>
Message-ID: <aQHi4nUfIlcN1ac6@hovoldconsulting.com>
References: <5f43ff47-70d4-8c53-efd3-6effb2e9afcb@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f43ff47-70d4-8c53-efd3-6effb2e9afcb@inria.fr>
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] drivers/phy/ti/phy-omap-usb2.c:442:4-11: WARNING:
 Consider using %pe to print PTR_ERR() (fwd)
Reply-To: Johan Hovold <johan@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 3104
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-10/aQHi4nUfIlcN1ac6%40hovoldconsulting.com>

On Tue, Oct 28, 2025 at 05:02:40PM +0100, Julia Lawall wrote:

> ---------- Forwarded message ----------
> Date: Tue, 28 Oct 2025 22:32:58 +0800
> From: kernel test robot <lkp@intel.com>
> To: oe-kbuild@lists.linux.dev
> Cc: lkp@intel.com, Julia Lawall <julia.lawall@inria.fr>
> Subject: drivers/phy/ti/phy-omap-usb2.c:442:4-11: WARNING: Consider using %pe to
>      print PTR_ERR()
> 
> BCC: lkp@intel.com
> CC: oe-kbuild-all@lists.linux.dev
> CC: linux-kernel@vger.kernel.org
> TO: Johan Hovold <johan@kernel.org>
> CC: Vinod Koul <vkoul@kernel.org>
> CC: Neil Armstrong <neil.armstrong@linaro.org>
> 
> Hi Johan,
> 
> First bad commit (maybe != root cause):
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   fd57572253bc356330dbe5b233c2e1d8426c66fd
> commit: 8209b3f79703b8ff09f84a79c46ead0df7260d9f phy: ti: omap-usb2: enable compile testing
> date:   3 months ago
> :::::: branch date: 21 hours ago
> :::::: commit date: 3 months ago
> config: sparc64-randconfig-r064-20251028 (https://download.01.org/0day-ci/archive/20251028/202510282255.6lFijMzE-lkp@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Julia Lawall <julia.lawall@inria.fr>
> | Closes: https://lore.kernel.org/r/202510282255.6lFijMzE-lkp@intel.com/
> 
> cocci warnings: (new ones prefixed by >>)
> >> drivers/phy/ti/phy-omap-usb2.c:442:4-11: WARNING: Consider using %pe to print PTR_ERR()

Why is this framed as a warning? It's at best a suggestion for a style
change that not everyone agrees with (me included). A driver may want to
use numeric errnos for consistency, and there certainly nothing
"redundant" in calling PTR_ERR() as the cocci script claims.

	https://lore.kernel.org/all/1758192227-701925-2-git-send-email-tariqt@nvidia.com/

Please consider dropping this from the tree or at least from what the
build bots run to avoid the unnecessary noise and churn this causes.

Johan
