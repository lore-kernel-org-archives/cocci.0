Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADFB1CAC5B0
	for <cocci@archiver.kernel.org>; Thu, 25 Sep 2025 13:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=0YPAYLqF0Pm2iZtufcSD3JBuwld1X4Kq4HJePJNVsyU=;
  b=drxEvUmC/gby90n4rxzwSJiahIxwoBEF+uekl6GVAvfc6wQyGqJ/ALre
   5+x90pNPVEc9beJ7813289ASPvD20w0yB8L5o+b7hAo1HmVwtZn5c27LN
   IWAXcTevNrkqAnSkMFPSITajmaDfKgkXpA6w+pDIyUE2sEKRoJoRU7v/3
   A=;
X-CSE-ConnectionGUID: BdY9im+tQ0usz9cgTeFdgw==
X-CSE-MsgGUID: NvVEnj50SKCHqxJJeGZQKw==
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
   d="scan'208";a="241017591"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Sep 2025 15:03:08 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6E62AE0D6B; Thu, 25 Sep 2025 15:03:04 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 99F2BE0171
	for <cocci@sympa.inria.fr>; Tue, 23 Sep 2025 01:36:44 +0200 (CEST)
X-CSE-ConnectionGUID: saNHxBFASoWqXoIKruMiYg==
X-CSE-MsgGUID: SSee0FgsT3ypaXSN6NZE7w==
IronPort-SDR: 68d1dd8c_8DDdf5BDTE74zjGI2cwv8XdtpXlsjALLO30Wmu20KU44vQv
 MaC6+hRvNecwvW0kblymr1ThjYW6zTT6a/AFF0w==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EBAAB63NFohf4EaaxQChkBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QESAQEBAQEBAQEBAQEBQIE/BAEBAQEBCwGCP4ECWjMEC0kEjG1fhlVbAQEGg?=
 =?us-ascii?q?UGLdJBRgVUUgWkCDwEDAQ1EDQQBAQMEhQACjD8CHgcBBDAJDgECBAEBAQEDA?=
 =?us-ascii?q?gMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAQEBAUBJhk8NgmIBgSSBJgEBA?=
 =?us-ascii?q?QEBAQEBAQEBAR0CDX4BAQEDOgYBATcBDwsYLkURBgESgwIBgiIHSQMRtgWBN?=
 =?us-ascii?q?IEBggwBAQaBRgbcPQMGgUkBiE8BhWw7g0J6Jxt9gRCEPz6EDgEHCwE2hi+CJ?=
 =?us-ascii?q?oEWinWFPIJbMYl8UngcA1ksAVUTFwsHBVtFQwMqNDEjSwUtHYEnd4QUg1lFK?=
 =?us-ascii?q?0+CHHKBdFdBg1MRDQZrDwaBFRlJAgICBQJDPoFrBhwGHxICAwECAjpXDYF6A?=
 =?us-ascii?q?gIEgkqBEhNAAwttPTcUGwaXdYQsP4ITH5ZcAYxwgTZroQ6EJoRwhy6VORozl?=
 =?us-ascii?q?1KTGS6YWCKLbIF6mzmBaDpscE0wCIMiEzwDGQ+OIRmIesM/IzUCOgIHCwEBA?=
 =?us-ascii?q?wmSHoFLAQE?=
IronPort-PHdr: A9a23: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
 pO2qX9EnQV5Y4xsTZE=
IronPort-Data: A9a23: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
 WzfHwOw3oxd5pDfVWbFdT7kbW+YxM9nxvSHEZI=
IronPort-HdrOrdr: A9a23:ddx/fqujoiiFKq953ipZTrE27skDedV00zEX/kB9WHVpmwKj9v
 xG+85rsyMc6QxhP03I/OrsBEDuex/hHPJOjrX5eI3SPjUO21HYSL2Kj7GSoAEIcheWnoU26U
 4jSdkaNDSaNzhHZKjBjjWFLw==
X-Talos-CUID: =?us-ascii?q?9a23=3Aj6JA6WvcNkgWasazJNMdNt746Is+e1v93F3+CnS?=
 =?us-ascii?q?/Nn9ZT5y2U0K1+ZJrxp8=3D?=
X-Talos-MUID: 9a23:NXF00AhEkDVl9uvN3OFZn8MpD/xl7vyAB1sxyoQesvm/E3JWCRrCk2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,286,1751234400"; 
   d="scan'208";a="240506232"
X-MGA-submission: =?us-ascii?q?MDGMfoZ6PMRZ68tR52DnmjW/U35UAAvfdloOPD?=
 =?us-ascii?q?wkP4EXZzmPg6rXV1tQMynY09E2oNWPTJRw++tJIRg/EodQ5mtJFrd0B+?=
 =?us-ascii?q?7C0RJOeax6Emuk4Cmg7vrYAJRWtkVU7Entiu5wdRyH0Lkzy/EklFiqzy?=
 =?us-ascii?q?yUPpRNBRJlGPlz47ZG+RhoQw=3D=3D?=
Received: from tor.source.kernel.org ([172.105.4.254])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 01:36:44 +0200
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 814726025C;
	Mon, 22 Sep 2025 23:36:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82915C4CEF0;
	Mon, 22 Sep 2025 23:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758584202;
	bh=QeuRrV0v+yB9NH3xmx+Y4CRYP/Vppq+zRFRPlfbQ+MA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Mbah3QxTzFBIvH7XVept/nzwoq5gK8MDEwQHE7ym78wga5i6lsTIV1a5oVkUAAwrl
	 oXw0BxjYvhNC6ECJXqTV28ducyJrqfahDkAmagM8WTPEgzEIWzWYyCJY5ZtqHCuT2U
	 Got7JIvcOwIAUNPTHLegTnlQtfpUJFdPEgx/NgYQg9zmAHmUN30+37bY1qhncw/kID
	 GgFtxaXh94zebz69fddhlLXBIYfgoRwVN7O1l4Gt7DmLhuRCoHii9q5Fti9Dv/C4NS
	 zeJtXpLSGBCnc55dBB9Fj7qcVej0+tvUp7sfbmbba9z9k46aPsGcQxJ4cEFJwb8aaj
	 lOJeXJxc4s/ng==
Date: Mon, 22 Sep 2025 16:36:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Julia Lawall" <Julia.Lawall@inria.fr>, Nicolas Palix
 <nicolas.palix@imag.fr>
Cc: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Saeed Mahameed
 <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Mark Bloch
 <mbloch@nvidia.com>, Richard Cochran <richardcochran@gmail.com>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, <cocci@inria.fr>, "Gal Pressman"
 <gal@nvidia.com>
Message-ID: <20250922163640.2fc887e4@kernel.org>
In-Reply-To: <1758192227-701925-2-git-send-email-tariqt@nvidia.com>
References: <1758192227-701925-1-git-send-email-tariqt@nvidia.com>
	<1758192227-701925-2-git-send-email-tariqt@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH net-next 1/2] scripts/coccinelle: Find PTR_ERR()
 to %pe candidates
Reply-To: Jakub Kicinski <kuba@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 3040
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-09/20250922163640.2fc887e4%40kernel.org>

On Thu, 18 Sep 2025 13:43:46 +0300 Tariq Toukan wrote:
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

Hi Julia, Nicolas,

would you be willing to give us a review tag for this script?
Would you prefer to take the script via your tree?

https://lore.kernel.org/all/1758192227-701925-2-git-send-email-tariqt@nvidia.com/
