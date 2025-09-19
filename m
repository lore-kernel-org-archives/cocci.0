Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDE19CAC5A5
	for <cocci@archiver.kernel.org>; Thu, 25 Sep 2025 13:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=7NFNVORvYaiXhOpEr2BMgRVXwD1GDvoojxcjR62cz20=;
  b=Wyb0cXs2zspJ8Jo4BDXsUZ4H+5+oSDJXrillJ0w6h3dD8DkO52+s8LaP
   64P8Ni4G+sgo6CKE2OyVn9a7XNrZEVluZc15yC/p0EJf70bN2A4HiQ3+r
   d33u1IQmcfkm8TMBGxBqk6BlgxYLXPB2bF5CCkQ9Ss8Y1GJphn6mrhKee
   Y=;
X-CSE-ConnectionGUID: OXgwTDbcRIiGX5A3SB9eyQ==
X-CSE-MsgGUID: R+GGtlZjT8qPuuMmTIHjXw==
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
X-IronPort-AV: E=Sophos;i="6.18,292,1751234400"; 
   d="scan'208";a="241017496"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Sep 2025 15:03:06 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D072CE0D06; Thu, 25 Sep 2025 15:03:03 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id D26DEE0171
	for <cocci@sympa.inria.fr>; Fri, 19 Sep 2025 18:54:46 +0200 (CEST)
X-CSE-ConnectionGUID: +cZrE3SjTDajr+IuIQq14g==
X-CSE-MsgGUID: 5eqW19DrRsOYvmShFqThTw==
IronPort-SDR: 68cd8ad6_BDgPFkGK04d7mF9h9pC1jpcYjSKN75J2Cvqiz+Rq14NExYc
 5GPwO3MaH5iUr10p5FeTY0oiLT7IUnlPgSmqqMQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EAAAAgis1oj/4EaaxQChkBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QESAQEBAQEBAQEBAQEBQIE/BAEBAQEBCwGCP4FcMwQLSYxxX4ZVgiSLdJImg?=
 =?us-ascii?q?X0CDwEDAQ1RBAEBAwSFAAKMPgIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQEBA?=
 =?us-ascii?q?Q0BAQUBAQECAQECBAYBAhABAQEBAQE5BUmGTw2CYgGBJIEmAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBHQINfQEBAQEDOgYBATcBDwsVAy5WBhODAoIjB0kDtz94gTSBAYIMAQEG3?=
 =?us-ascii?q?gkJgUkBiE8BhWwbg2J6Jxt9gRCBSoJ1PoQWhEKCL4ImRFKQMIxkUngcA1ksA?=
 =?us-ascii?q?VUTFwsHBVtFQwOBDyNLBS0dgSd3hBSDWEUrT4IccoF0V0GDUxENBmsPBoEVG?=
 =?us-ascii?q?UkCAgIFAkM+gWsGHAYfEgIDAQICOlcQgXwCAgSCWkxAAwttPTcUG5dPgzN6g?=
 =?us-ascii?q?lOWegGMcKMvhCaEcJxnBBYzl1KTGS6YWKlBgWg6gVwzGggoCIMiTwMZD44hG?=
 =?us-ascii?q?Yh6wARCNTwCBwsBAQMJkh6BSwEB?=
IronPort-PHdr: A9a23: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
 h49XAo=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:9xsGeKGeZRDYo04epLqE58eALOsnbusQ8zAXPo5KKCC9Vvbo8P
 xG/c5rsSMc7Qx9ZJhOo7y90cW7Lk80sKQFh7X5Xo3SOTUO2lHYT72KhLGKq1aLJ8S9zJ8+6U
 4KSchD4bPLY2RHsQ==
X-Talos-CUID: 9a23:50i2eGA3hRhmV8D6E2psxlQ5QfsnTlHUzm2TAlKZMH8wFLLAHA==
X-Talos-MUID: 9a23:I2UOCgSNym0lsa8YRXSxiShdbZZE+Z61L3ETlK4GldC4NRBvbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,278,1751234400"; 
   d="scan'208";a="240103904"
X-MGA-submission: =?us-ascii?q?MDHu6Mk2ZIIdTatbF+75DkY2JhsZEeWIafsRAB?=
 =?us-ascii?q?skNfyf+gsMFUVki/pK2Rsw7k9knZSIPVffi3VAZyWGhVVC7CGo7L3uLa?=
 =?us-ascii?q?6Pid1U72bz73ZT7xMbtdy+2AjIASFzCavwX372vIT0sBQs9ycasQj8iP?=
 =?us-ascii?q?Mt7U1XX4bbN9Vas2N4e3PCUA=3D=3D?=
Received: from tor.source.kernel.org ([172.105.4.254])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 18:54:46 +0200
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 50A5B6013A;
	Fri, 19 Sep 2025 16:54:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC430C4CEF7;
	Fri, 19 Sep 2025 16:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758300884;
	bh=NZu0V+WzD5N8m0SVaI1EL9lbDRhIMMw5OUDb/otoK1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C3bgr892RrzxJ5WoKTjd1JfSCJE9KwluV/MOD7kt7TvFEv18k+ldcL84ehHnA7odE
	 HaWuQaYt3DssBQ7S08c8BRabe68Q4BfWmDwwTcBegvru694XVdXgxThV27MGxGUYNU
	 nUcfXj/kwsHnYFDIjxo1xZTGqSPUgB5bhhumvMv6OdBZbnR+LpXqQFIaEIJM8puH2G
	 8uXMtZ8/gOw1L4K+0ATQHQlVELlg7Q23FExHdhRN+05k+KWH68ZFQubO+p3FULj+P0
	 i1Ed4SEeERoN6+ZVgtMoHs0ZTuptCQ6m6uoKyWX2R7/AlwscIDhG67diTgNtiGIH5Q
	 CgzhmruGwYB/w==
Date: Fri, 19 Sep 2025 17:54:38 +0100
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, cocci@inria.fr,
	Gal Pressman <gal@nvidia.com>
Message-ID: <20250919165438.GB589507@horms.kernel.org>
References: <1758192227-701925-1-git-send-email-tariqt@nvidia.com>
 <1758192227-701925-2-git-send-email-tariqt@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1758192227-701925-2-git-send-email-tariqt@nvidia.com>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH net-next 1/2] scripts/coccinelle: Find PTR_ERR()
 to %pe candidates
Reply-To: Simon Horman <horms@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 3038
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-09/20250919165438.GB589507%40horms.kernel.org>

On Thu, Sep 18, 2025 at 01:43:46PM +0300, Tariq Toukan wrote:
> From: Gal Pressman <gal@nvidia.com>
> 
> Add a new Coccinelle script to identify places where PTR_ERR() is used
> in print functions and suggest using the %pe format specifier instead.
> 
> For printing error pointers (i.e., a pointer for which IS_ERR() is true)
> %pe will print a symbolic error name (e.g,. -EINVAL), opposed to the raw
> errno (e.g,. -22) produced by PTR_ERR().
> It also makes the code cleaner by saving a redundant call to PTR_ERR().
> 
> The script supports context, report, and org modes.
> 
> Example transformation:
>     printk("Error: %ld\n", PTR_ERR(ptr));  // Before
>     printk("Error: %pe\n", ptr);          // After
> 
> Signed-off-by: Gal Pressman <gal@nvidia.com>
> Reviewed-by: Alexei Lazar <alazar@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Thanks, having this check seems very nice to me.

Reviewed-by: Simon Horman <horms@kernel.org>
