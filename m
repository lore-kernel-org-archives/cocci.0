Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 671E6CCF9FE
	for <cocci@archiver.kernel.org>; Thu, 30 Oct 2025 14:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=vxWjvKmEJw0d9tPTSAjKDptrWQRCObx4DDpaKYHi3yg=;
  b=ceEbYA3smkadrvWRmmin9qNwuPG0M4pHnBdcxOc4CTxiYLP6CVm3d5Ml
   MpuRCdEpDbJ7E4Qxp1EdUVNPOdGPUvXy5Obhid7Cs3+St626QXswFLySF
   ikkfrZoCZUkB9/t74xVQBGJYdC00xvSscoqMjnU8xH24ZQBUNnXah2aKN
   8=;
X-CSE-ConnectionGUID: DqaL9a2iSu2pTIBQxEmsIw==
X-CSE-MsgGUID: VhtA4eAfSIqyt3dLgMIxXw==
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
X-IronPort-AV: E=Sophos;i="6.19,266,1754949600"; 
   d="scan'208";a="246874787"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Oct 2025 15:27:11 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0CA6FE0BE9; Thu, 30 Oct 2025 15:27:11 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 22A61E0171
	for <cocci@sympa.inria.fr>; Thu, 30 Oct 2025 15:06:25 +0100 (CET)
X-CSE-ConnectionGUID: 9jC1NQm9Qcyhw3SxFFskZA==
X-CSE-MsgGUID: 9rIi8Y3HQyCv3wtGgGsSnA==
IronPort-SDR: 690370e0_WCMGv/jf33JEyz0EKjHMOYOspCaJpn/JTZ2TYYcCeLx4iEC
 GG3RB6CE2fpgC1fVy6Ez+Gel2m9+zYqi0s24ArA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EQAAD6bwNphf4EaaxaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TwHAQELAYI/gWAzBAtJjHFfhleCBB0DnhqBfQIPAQMBDVEEAQEDBIUAAoxTA?=
 =?us-ascii?q?h4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEBgECEAEBA?=
 =?us-ascii?q?QFASYZPDYJiAYEkgSYBAQEBAQEBAQEBAQEdAg19AQEBAQIBOgYBATcBBAsLG?=
 =?us-ascii?q?C4QRgaDFYIjByMnA69WeIE0gQGCDAEBBtwlgWQJgUoBhWyCZAGJanonG4INh?=
 =?us-ascii?q?D8+iweCJoEOhimSPVJ4HANZLAFVExcLBwVbRUMDgQsjSwUtHYEkIh8QCBFgV?=
 =?us-ascii?q?ECDSQ8MBmgPBoESGUkCAgIFAkA6gWgGHAYfEgIDAQICOlcNgXcCAgSCG36CD?=
 =?us-ascii?q?w+JEAMLbT03FBuUdoIagV1fgXMgRJJjgzWQRok+lF2BPoQmgWSgQIFLlgeTG?=
 =?us-ascii?q?S6YWKlBgWg6gVwzGggoCIMiTwMZD44hGYh6xkBCNTwCBwsBAQMJkh5rYAEB?=
IronPort-PHdr: A9a23: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
 h49XAo=
IronPort-Data: A9a23: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
 D3VxpE80tVdDH2kqSb/K8FXWdta+84=
IronPort-HdrOrdr: A9a23:2sqhUaE/J7wQeSWTpLqE6ceALOsnbusQ8zAXPo5KKSC9Vvbo8f
 xG/c5rsiMc7Qx9ZJhOo7+90cW7L080sKQFmLX5Xo3SODUO2lHYTr2KhLGKq1aLdxEWtNQtsJ
 uIGJIOa+EYY2IasfrH
X-Talos-CUID: 9a23:jkrhMmBnFUSo57b6E3hl3xcyI8V0S3bMzGiLGF+WJ31qepTAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3Ah8D6mA87aUrPBc30SRdqqZqQf5ZywqX+ORstqIQ?=
 =?us-ascii?q?tpZKbKQN/FCymih3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,266,1754949600"; 
   d="scan'208";a="129505696"
X-MGA-submission: =?us-ascii?q?MDGP7neiVve159tN7/Vph6dg2g/aVFuKj3ig8e?=
 =?us-ascii?q?g4coeIapavxI8pR+as/DWw+RhDwrq1qC9SlW2MFNtTe8fH3tF6xeOOYv?=
 =?us-ascii?q?bf19XvQm4VYO3YzCUOEP3A3F6UmmNDhvywIYMmb/DV7tth1ev1uTrvoj?=
 =?us-ascii?q?USxdEeMzXSyEbvCiWOiX6LHw=3D=3D?=
Received: from tor.source.kernel.org ([172.105.4.254])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 15:06:23 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 18D3362179;
	Thu, 30 Oct 2025 14:06:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6828C4CEF1;
	Thu, 30 Oct 2025 14:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761833180;
	bh=4fpQvQLAvy45wN1LShQwKGzOvmvppBJjTWW+1FEd13Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A89erkzpjSlD09K1Omuwu52VNRfQi6xWM6FpgpQhiDUR3zB6JUEhGkyCezse7E2tN
	 caoJk1xo4NZ8QXZEzCUsmFyrlSPQvCNL5yxhSwbmAvYK85fVWa6W2UQbJgPa4DmFF+
	 imR43jde2A4BWIlzsUnH0xqi9DeSVKrwx63s7KawdUikTs/e/0ltRPIoyASAzCKoiX
	 drajFvvVTwfmLiub+J8xTEl48Ef8NwvQUgv2uaNXUTpUf2cAsp3ikpKAGHWOT+K182
	 V7tT9peJNODmGRj7ZZCo0dqYNZdYEjBjvJ1eXF1s5PU3IIqJAKcd3n1QSCwGc5EtpQ
	 tbCu3XZvZkXJw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vETIK-000000002uX-2T5Z;
	Thu, 30 Oct 2025 15:06:28 +0100
Date: Thu, 30 Oct 2025 15:06:28 +0100
From: Johan Hovold <johan@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Jakub Kicinski <kuba@kernel.org>, Alexei Lazar <alazar@nvidia.com>,
	Simon Horman <horms@kernel.org>, cocci@inria.fr,
	linux-kernel@vger.kernel.org
Message-ID: <aQNw5NqZSZk5JNxn@hovoldconsulting.com>
References: <20251029132922.17329-1-johan@kernel.org>
 <826f2fdb-bad8-44f4-8c8e-9353c3de73cd@nvidia.com>
 <aQJDIz-8Ow0OmczH@hovoldconsulting.com>
 <3b04f763-aaba-41ee-a81f-94195043fd4b@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b04f763-aaba-41ee-a81f-94195043fd4b@nvidia.com>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH] Revert "scripts/coccinelle: Find PTR_ERR() to
 %pe candidates"
Reply-To: Johan Hovold <johan@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 3128
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-10/aQNw5NqZSZk5JNxn%40hovoldconsulting.com>

On Wed, Oct 29, 2025 at 07:35:25PM +0200, Gal Pressman wrote:
> On 29/10/2025 18:38, Johan Hovold wrote:
> > On Wed, Oct 29, 2025 at 03:59:50PM +0200, Gal Pressman wrote:

> > Unlike the rest of the misc cocci scripts I skimmed, this one does not
> > guard against any bugs. Instead it's pushing for a subjective style
> > preference, which is just going to result in churn when the clean up
> > crew starts sending mindless conversions of individual printks.
> 
> Not all cocci scripts are used for fixing bugs:
> err_cast.cocci
> memdup.cocci
> minmax.cocci
> string_choices.cocci
> 
> They are used to improve the code.

I only skimmed the misc ones, but I still things there's a difference
here since "%pe" is changing the output (e.g. unlike err_cast.cocci) and
is essentially a subjective preference.

> We can probably agree that for new code %pe is preferable, but I
> understand your concerns about the churn of conversions.

I'm not even convinced about new drivers. For consistency you'd need to
add *ERR_PTR()* to more or less every dev_err() in the driver (which
becomes ugly):

	if (ret)
		dev_err(dev, "failed to ...: %pe\n", ERR_PTR(ret));

And by now many of us recognise (or can easily lookup) the errnos used
in the occasional error message if at all needed.

Note that in most cases you have ret variable that holds the errno,
which would not be caught by this cocci script either:

	ret = PTR_ERR(p);
	dev_err(dev, "failed to ...: %d\n", ret);
	return ret; // or goto out;

> >> If the issue is with automatic build bots, then maybe this test should
> >> be excluded from them, rather than deleted?
> > 
> > It's both; it's the noise the new warnings generate but also the coming
> > flood up patches to "fix" them. There are already some 40 commits or so
> > in linux-next referencing this script.
> 
> It's OK to not like these conversion patches, it's up to the maintainer
> to accept/reject them.
> 
> For example, I know Jakub dislikes the string_choices.cocci script and
> rejects conversion patches. But the script still exists and can be used
> in other places in the kernel who might have a different opinion.

It still generates noise and extra work for already overworked
maintainers that would need to explain over and over again why they are
rejecting patches that appears to fix "warnings". Some will just take
the patches, which leads to inconsistencies (as only a handful of
printks will be converted) and a push for a style which again only some
people prefer.

So I still think this script should be dropped. And you still need to
review drivers manually if you really want to use %pe consistently (e.g.
for all the cases where there is no error pointer to begin with).

Johan
