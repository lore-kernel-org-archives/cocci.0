Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD7CBCAC5B7
	for <cocci@archiver.kernel.org>; Thu, 25 Sep 2025 13:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=69k3stPC8SJThMb+EVxTdDRp2Q3m244EWxKy0S416aE=;
  b=lPZCDDcuM09hnbMnBaJloRABuwKfNfXfxfSk78AbFbPZfTFpufOvjL9d
   OygDKN54hR3bFalS1Ax0V6Uj83YK0LWU+w9VpdK9nnWSrRB+WE361GPa4
   8u/z06ljuAlYtLiajMxDJDJwYe2vtu3z+xDjMf2YQm5f2ajzMHaNpqXiv
   I=;
X-CSE-ConnectionGUID: Mk+NprRhQVWqJj2Gf1kQSA==
X-CSE-MsgGUID: P4kVyeghTJK4yvkhmSGq+g==
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
   d="scan'208";a="241017526"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Sep 2025 15:03:06 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 51A2BE0D33; Thu, 25 Sep 2025 15:03:04 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 4D95AE0171
	for <cocci@sympa.inria.fr>; Fri, 19 Sep 2025 18:55:23 +0200 (CEST)
X-CSE-ConnectionGUID: 0GowR5tWS/KuVuD0AKIKtg==
X-CSE-MsgGUID: 0u90kTVASKCcjtcfQQu5/A==
IronPort-SDR: 68cd8afa_LVnyVgJVpoL2T5nPPL/ThmOjstKdnNPucCxpT7k8rMRmJOc
 pG36q+tv9doqdZUetjRfGLc6/D3MLmet5WlUABg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EAAACpic1oj/4EaaxaGQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RIBAQEBAQEBAQEBAQFAgT8EAQEBAQELAYI/gVwzBAtJjHFfhlWCJIt0kiaBf?=
 =?us-ascii?q?QIPAQMBDVEEAQEDBIUAAow+Ah4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAQEBD?=
 =?us-ascii?q?QEBBQEBAQIBAQIEBgECEAEBAQEBATkFSYZPDYJiAYEkgSYBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEdAg19AQEBAQM6BgEBNwEPCxUDLlYGE4MCgiMHSQO3OHiBNIEBggwBAQbeC?=
 =?us-ascii?q?QmBSQGITwGFbIN9eicbfYEQgUqCdT6IWIIvgiaBFpAwjGRSeBwDWSwBVRMXC?=
 =?us-ascii?q?wcFW0VDA4EPI0sFLR2BJ3eEFIQdK0+CHHKBdFdBg1MRDQZrDwaBFRlJAgICB?=
 =?us-ascii?q?QJDPoFrBhwGHxICAwECAjpXEIF8AgIEglpMQAMLbT03FBuXT4MxfC9mgT6We?=
 =?us-ascii?q?gGwH4QmhHCcZwQWM4Nxk2GTGZkGqUGBaDqBXDMaCCgIgyJPAxkPjiEZiHrAC?=
 =?us-ascii?q?EI1PAIHCwEBAwmSHoFLAQE?=
IronPort-PHdr: A9a23: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
 XE=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:sxLZGKnHiJ4F8KpWGdrod3IC9fzpDfIn3DAbv31ZSRFFG/FwWf
 rOoB1973/JYVcqM03I9urvBEDtex/hHNtOjrX5Q43SPzUOyVHDEGgK1+KL/9SjIVydygc378
 pdmsZFebjN5CBB/KLH3DU=
X-Talos-CUID: 9a23:wmVGUmydepLzksgOtRF9BgVMNcc6SCDB80yXAFKGFEoxYZ60akOfrfY=
X-Talos-MUID: 9a23:xuVJ9wWx/e8zNe/q/Gfx1WlhCPlB2IeFA0IRmps/gtTZcgUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,278,1751234400"; 
   d="scan'208";a="126047694"
X-MGA-submission: =?us-ascii?q?MDFH7nK1OffsmUeTwGDSTFcd4eBvERzNkqixbT?=
 =?us-ascii?q?ohd+SXFLEDlqpeMQdC11O3YWTyWP/2s4LyDxozUUz4Wf08UrOD+Bl0Dd?=
 =?us-ascii?q?dI7liuMr0CwxrcQ4Q1DWV3H5pjDFOjpkDBGqan+cuG3DRK39AcDX0ih/?=
 =?us-ascii?q?/pKgwuFfJyI4rea6PjqvczUA=3D=3D?=
Received: from tor.source.kernel.org ([172.105.4.254])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 18:55:21 +0200
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 684D26013A;
	Fri, 19 Sep 2025 16:55:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E47F2C4CEF0;
	Fri, 19 Sep 2025 16:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758300920;
	bh=p9xSgb/by5KzTQC9wcVAcHSIVEKzi/zwG++yqatSoWI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VOgl9Jy4pTb4PjbMByu9d/tPnn4JbXLgVAILkVvlYmFhkaNxaly9sNhC4ZeZadEa+
	 Mk5PAIxnwkDNsZUvFCxPLUcEEAYM1kAYxO19v6DfSNpZY00P5inHvayscprs/rpVCm
	 TNThH8bZVatCNHBQM+/J4t4icON9dDZb0VoZmKEJrTYeRMQ3YGu/HdkPohe0dIYDQ5
	 DDi3MU/Vu70BxhbrRuGeoFD3KyI7hcvu8x2WZHFVnUw/MGwMCLwgJnWdtjnbtOPifK
	 QBnQ9t33UZLxwbkOFk926TvSb2tBzVM567WRnWb8rp5ukKMvhJnZpdpgb5q0AcW5NT
	 AfCLc1jiZz1aA==
Date: Fri, 19 Sep 2025 17:55:14 +0100
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
Message-ID: <20250919165514.GC589507@horms.kernel.org>
References: <1758192227-701925-1-git-send-email-tariqt@nvidia.com>
 <1758192227-701925-3-git-send-email-tariqt@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1758192227-701925-3-git-send-email-tariqt@nvidia.com>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH net-next 2/2] net/mlx5: Use %pe format specifier
 for error pointers
Reply-To: Simon Horman <horms@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 3039
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-09/20250919165514.GC589507%40horms.kernel.org>

On Thu, Sep 18, 2025 at 01:43:47PM +0300, Tariq Toukan wrote:
> From: Gal Pressman <gal@nvidia.com>
> 
> Using the coccinelle test introduced in previous commit
> (scripts/coccinelle/misc/ptr_err_to_pe.cocci), convert error logging
> throughout the mlx5 driver to use the %pe format specifier instead of
> PTR_ERR() with integer format specifiers.
> 
> Signed-off-by: Gal Pressman <gal@nvidia.com>
> Reviewed-by: Alexei Lazar <alazar@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Simple, mechanical change that improves readability.
Looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

