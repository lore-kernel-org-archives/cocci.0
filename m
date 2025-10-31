Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37A7ACCF9F8
	for <cocci@archiver.kernel.org>; Mon,  3 Nov 2025 09:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=qJRdZdByyh+AVxQ8Ai9ldEnYqeNPZHvPAku+nxc1kt8=;
  b=C31IPTQ70yFw8DZbbAL/uf+hvUT/B1SMC16PJCYSFs+2RW50GPsa93wz
   kjBpZj4s2MQ26oPvImx1ZCZCNxkcCSu6B25TJVRM0gUlywNyypecohk6K
   JDU4DehYXxzBwBcU7yl5BeBHYRJpEwiuxqxwcmQg8G6fNOkRkuql93Ns8
   8=;
X-CSE-ConnectionGUID: vJ18ZcchQUuE2VwjHxnm3Q==
X-CSE-MsgGUID: dAxZpEo8RxWcnKiv3Knzvw==
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
X-IronPort-AV: E=Sophos;i="6.19,275,1754949600"; 
   d="scan'208";a="247253424"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Nov 2025 10:54:27 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 13003E0CE4; Mon,  3 Nov 2025 10:54:26 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id BC2DFE0171
	for <cocci@sympa.inria.fr>; Fri, 31 Oct 2025 15:10:37 +0100 (CET)
X-CSE-ConnectionGUID: CgRtEnYcSvidWKHolunLsA==
X-CSE-MsgGUID: 9Vh1MQ4uSj+1bPV4ER2zPA==
IronPort-SDR: 6904c35d_e5ctvh+AwwDYAnDo+5nEyVOT+im+I1FlfGGrTP7nisqgwS5
 rgP26hyG/BSeAxl+cThO4MMXM5jtnvPg8xSFDEQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FdAQBJwgRphR/86qxaHgEBCxIMQIFFC4JAgWAzBAtJj?=
 =?us-ascii?q?VCGV4IEIJ4agX0CDwEDAQ1RBAEBAwSFAAKMUwIeBwEEMAkOAQIEAQEBAQMCA?=
 =?us-ascii?q?wEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABAQEBQEmGTw2CYgGBJIEmAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBHQINfQEBAQECAToGAQE3AQ8LGC4QRgaDFYIjByMnA7BPeIE0g?=
 =?us-ascii?q?QGCDAEBBtwlgWQJgUqFbYJkAYlqeicbgg2EPz6LB4IRFYEOhieSV1J4HANZL?=
 =?us-ascii?q?AFVExcLBwVbRUMDgQsjSwUtHYEkIh8QCBFgVECDSQ8MBmgPBoESGUkCAgIFA?=
 =?us-ascii?q?kA6gWgGHAYfEgIDAQICOlcNgXcCAgSCG36CDw+JNAMLbT03FBuVCYNfgiSBK?=
 =?us-ascii?q?pYYsB+EJoFkoECBS4I5k05HklIumFipQYFoOoFcMxoIKAiDIk8DGQ+OIRmIe?=
 =?us-ascii?q?sZLQjU8AgcLAQEDCZIegUsBAQ?=
IronPort-PHdr: A9a23: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
 EgiMy3LFeo5sg==
IronPort-Data: A9a23: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
 T3SFrAc8PR8LlGFiNv/PsCGvNo=
IronPort-HdrOrdr: A9a23:wS4dlaBq/7ygWrrlHemB55DYdb4zR+YMi2TDtnoBMCC9F/bzqy
 nApoV46faZskdzZJhCo7C90cu7MBfhHPdOiOF7AV7IZniAhILHFvAF0aLShxPlXwLz/vNAzq
 t7GpIObeHYPBxViYLV7mCDfOrIA+PqzElrv4rjJrtWIz2CopsA0ztE
X-Talos-CUID: =?us-ascii?q?9a23=3Ajhy1C2kb8SVbbe8AU0KnEXhQvPHXOVbS9mv9JX6?=
 =?us-ascii?q?zMnhoRIK2aViU5aVAiOM7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3A8nZAwA82LQfsUXwr9Fp5+PqQf5ZW4/2LMRwQqpd?=
 =?us-ascii?q?F4sO8C3BdAW2PtB3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,269,1754949600"; 
   d="scan'208";a="247022051"
X-MGA-submission: =?us-ascii?q?MDEtvy3Wyyp47kuV1HmaoWQtD4Y/7swbN/xV30?=
 =?us-ascii?q?KG40BfOLoWPT/pVmNc2HMCLVxOiK4NOqAwAgqsyXZ3E6+FU+GklI/ImR?=
 =?us-ascii?q?f50mqBKwJJJ2EH6c5dF6UCVpK40V3fUfTXWdFEjjwLz3bacDJ3+P+mTi?=
 =?us-ascii?q?EwSvvA10eQcLljr7cPHxHqWw=3D=3D?=
Received: from sea.source.kernel.org ([172.234.252.31])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 15:10:37 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 5A2AC4089D;
	Fri, 31 Oct 2025 14:10:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31EE0C4CEE7;
	Fri, 31 Oct 2025 14:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761919834;
	bh=0B0L8Lq+i3gAWgbniEZql6RTQ0bjsRjHlxIl+KdSv88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S7xchXRPtpFVO6T5D1JkSCcM8nKEjLjXwzEU4leQME3MsMInJJw6zd6fOCErOKUsG
	 YfermksGty5JVvBmJZmaL2xNFYRjtqkzdhgXU738RA1/sv1zFMguePq66wiDa/xPha
	 xsgriSUfZu4RP7srKln19T5tVvg8gYKqjTZ60cMKLjA206r32Ck8uZxSve+n8w4PIX
	 sfjlPeON1/LDLClqAGDkPjHP/lIT8BPfvd3cqwUmQ9//4/RjniZHPOcxY6cD8yptuq
	 z4QdDVLdttG4S520vKc+kYKj0DD1k5K1lPd7PMfiIqCmD59Ef69YzQpvH4y5+Btwyq
	 vYRJSy1Nk1V3A==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vEppz-000000007uC-1bOJ;
	Fri, 31 Oct 2025 15:10:43 +0100
Date: Fri, 31 Oct 2025 15:10:43 +0100
From: Johan Hovold <johan@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Jakub Kicinski <kuba@kernel.org>, Alexei Lazar <alazar@nvidia.com>,
	Simon Horman <horms@kernel.org>, cocci@inria.fr,
	linux-kernel@vger.kernel.org
Message-ID: <aQTDY6m6xuDpNSAH@hovoldconsulting.com>
References: <20251029132922.17329-1-johan@kernel.org>
 <826f2fdb-bad8-44f4-8c8e-9353c3de73cd@nvidia.com>
 <aQJDIz-8Ow0OmczH@hovoldconsulting.com>
 <3b04f763-aaba-41ee-a81f-94195043fd4b@nvidia.com>
 <aQNw5NqZSZk5JNxn@hovoldconsulting.com>
 <9c32fa45-2b8f-4005-94cd-a9755981cff5@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c32fa45-2b8f-4005-94cd-a9755981cff5@nvidia.com>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH] Revert "scripts/coccinelle: Find PTR_ERR() to
 %pe candidates"
Reply-To: Johan Hovold <johan@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 3138
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/aQTDY6m6xuDpNSAH%40hovoldconsulting.com>

On Thu, Oct 30, 2025 at 04:36:46PM +0200, Gal Pressman wrote:
> On 30/10/2025 16:06, Johan Hovold wrote:

> > It still generates noise and extra work for already overworked
> > maintainers that would need to explain over and over again why they are
> > rejecting patches that appears to fix "warnings". Some will just take
> > the patches, which leads to inconsistencies (as only a handful of
> > printks will be converted) and a push for a style which again only some
> > people prefer.
> 
> There's the subsystem maintainer "rules" documentation in
> Documentation/process/maintainer-*.rst which can document these kinds of
> stuff.

There's already too many rules in there and I guess not many people
actually read it so that doesn't really scale.

Johan
