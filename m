Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B30A5CCF9F7
	for <cocci@archiver.kernel.org>; Wed, 29 Oct 2025 17:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=DswSWcpdhUNpTYiOgel+WTnKrl9ams5tl81lABUIc+s=;
  b=PRa3ncyJs4JngVPoptvpEvAAMukv47LhdBDvKAZS7HS9qJXzlZSqvXKY
   U2JRLAEfR1sHbTrnoEffyavzoFaVgcoXcWzbm+8kSDt7YVEFEsMqm4iQF
   xDrvwg3U/HyI3uSVZVs7HpvWBBCPjsN+U9MMwRPoU5VN1k1iJutogJR5y
   o=;
X-CSE-ConnectionGUID: tFtVSZS5SjOQJhd3VYS5bw==
X-CSE-MsgGUID: 5yen+KbUT2yFMUtl/A9yfA==
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
   d="scan'208";a="246735184"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Oct 2025 18:37:55 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 05BE5E0C55; Wed, 29 Oct 2025 18:37:55 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 5A488E0171
	for <cocci@sympa.inria.fr>; Wed, 29 Oct 2025 18:26:36 +0100 (CET)
X-CSE-ConnectionGUID: zNSohfmoRWyv1Tv7JoC11Q==
X-CSE-MsgGUID: Uv4LY7qOTiif6Sqb5f9Wqw==
IronPort-SDR: 69024e4b_CjWGwtgjSJt+Fq7kv9VTTMC6yE5ajLGXtDcH2igKheNCvNL
 Dx2YpS+lQ3bOgmLr9wk6Rq3jWrG6YxNj27iIXuQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EeAADuTAJphR/86qxaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T0GAQELAYI/gWAzBAtJjVCGV1sBAQaBQYt0kiaBfQIPAQMBDVEEAQEDBIUAA?=
 =?us-ascii?q?oxTAh4HAQQxCA4BAgQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEBgECE?=
 =?us-ascii?q?AEBAQFASYZPDYJiAYEkgSYBAQEBAQEBAQEBAQEdAg1+AQEBAzoGAQE3AQ8LG?=
 =?us-ascii?q?C5WBoMVgiMHSgOyRIE0gQGCDAEBBt4JCYFKAYhQAYlqeicbfYEQgz2BAj6EW?=
 =?us-ascii?q?IYvgzSGJ4gziX9SeBwDWSwBVRMXCwcFW0VDA4ELI0sFLR2BJCIfEAgRYFRAg?=
 =?us-ascii?q?0kPDAZoDwaBEhlJAgICBQJCOoFoBhwGHxICAwECAjpXDYF3AgIEgh5+ghUPi?=
 =?us-ascii?q?HoDC209NxQbBpRngkc2gVkPLpgyjiZroQ6EJoRwnGcaM5dSkxkumFikIYUgg?=
 =?us-ascii?q?WoDNYFcTTAIO4JnTwMZD44hGYh6xwAjNTwCBwsBAQMJkh5rYAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 T3TFrMc8/RxLlxUqT4v28GG
IronPort-HdrOrdr: A9a23:2q/9NamtkSl97mu8Qoee2rBURYfpDfIj3DAbv31ZSRFFG/FwWf
 rOoB19726TtN9xYgBGpTnkAsS9qBznmaKdjbN/AV7mZniFhILKFvAH0WKB+UyCJ8SWzIc0vs
 1dmupFebjN5DNB7foSjjPXL+od
X-Talos-CUID: 9a23:onh3ZGE7wPgNydiyqmJ10nUTGs4gdUfi3WmJH1HnK2FCEeSsHAo=
X-Talos-MUID: 9a23:/iCwfAUrqOOQOPvq/ALy2BVTa95P36WvBh42iJ9btZi7LDMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,264,1754949600"; 
   d="scan'208";a="129429030"
X-MGA-submission: =?us-ascii?q?MDHaoMJbShcdX51NW5dd2EL16JNgsw7IkRIezF?=
 =?us-ascii?q?UHyGwy76dNsT0B8Pj+3IIV3/SZf35eN7tPY3c7nVprszRaojwAI7kClW?=
 =?us-ascii?q?SWXy7ZJO2Db85C358XesFZbC8azQoIBgE3PF0+J6Tp+N1nwzQB3iT8kg?=
 =?us-ascii?q?lkilIayj19OnMzlXLC67teeg=3D=3D?=
Received: from sea.source.kernel.org ([172.234.252.31])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 18:26:35 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C19A243A14;
	Wed, 29 Oct 2025 17:26:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48640C4CEF7;
	Wed, 29 Oct 2025 17:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761758791;
	bh=COCBHjoGNg+MNgwpImmfllkJEQc0gKS1BnO36JSJT+E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YlU1971gG22p/Dx7YV2h8reYt3n6Ia0q89xAHaMn7GmLNBp5rFBbyAZ4IDm/WZpg0
	 /yO6WAp4trikzy/F7HsLTrqEL5wwOvy96jfkjuAyl80mI0ZMWUvfcKnkUrLb7Mho9u
	 P2ZTeNVUBw+g+bbbj7u67EQXPgWT1/kXRZRnr4mxZl8x7q5+CIqOf02/T+VJs0UlZz
	 p8I7SPHE9M1ElOfOKfJnRPVpQPcALfqQkbhyEi1vcsqB/aVokbwEkfsNxY7Aw/cBpy
	 p6M1gej5wi8aCYPm0Uui+AFFG0mcV3rmqqYgHAr4ParDDVCw3QyZ07NloSfs78wLwB
	 xAuOLjoBcazwQ==
Date: Wed, 29 Oct 2025 10:26:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Gal Pressman <gal@nvidia.com>, Johan Hovold <johan@kernel.org>, Nicolas
 Palix <nicolas.palix@imag.fr>, Alexei Lazar <alazar@nvidia.com>, Simon
 Horman <horms@kernel.org>, cocci@inria.fr, linux-kernel@vger.kernel.org
Message-ID: <20251029102630.2a9bd6e7@kernel.org>
In-Reply-To: <47ef2f61-85c1-92fa-12dc-e5918d90488@inria.fr>
References: <20251029132922.17329-1-johan@kernel.org>
	<826f2fdb-bad8-44f4-8c8e-9353c3de73cd@nvidia.com>
	<47ef2f61-85c1-92fa-12dc-e5918d90488@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH] Revert "scripts/coccinelle: Find PTR_ERR() to
 %pe candidates"
Reply-To: Jakub Kicinski <kuba@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 3110
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-10/20251029102630.2a9bd6e7%40kernel.org>

On Wed, 29 Oct 2025 15:04:36 +0100 (CET) Julia Lawall wrote:
> > The test by no means mandates authors to use %pe, as the output says:
> > WARNING: Consider using %pe to print PTR_ERR()
> >
> > "Consider" :).
> >
> > I would consider it best practice to use it, and a few drivers were
> > converted thanks to this test.
> >
> > If the issue is with automatic build bots, then maybe this test should
> > be excluded from them, rather than deleted?  
> 
> This is easy to do.  Or I can discard them when they come to me for
> approval.

FWIW I'd also prefer for the script to say in the tree.
Some kind of opt-out mechanism per subsystem would be ideal, 
and presumably belongs in the bots themselves. We maintain 
a list of regexp's in netdev CI to silence cocci checks we 
don't find worth complaining about. But the %pe check so far 
have not been too bad. 

And we have a policy against semi-automated patches which "clean up"
cocci or checkpatch warnings. Something we may want to adopt more
widely.
