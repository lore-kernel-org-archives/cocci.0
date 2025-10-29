Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C011CCF9F1
	for <cocci@archiver.kernel.org>; Wed, 29 Oct 2025 16:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=H4Qn2gyEdCs6fN/TrIfN2c7pV3wU9AE+BiHCPHrj+tI=;
  b=tWsIj/M0ffcdK8U2/iJhE2yF2ZKASFzp50lCUAwar/wDeO6q1Jt8etX1
   dsULNblAVTW2n/5Z/JDA4gSIHXvxvcJdQn5aAqLibavRQTDiK38/pYSVK
   JjEWs9bZDx2B0LuTNs/y7q+86eCRecgqhpSAIFoYcyPzMTulyMIYhYaRh
   Y=;
X-CSE-ConnectionGUID: Vgy0d3cESpSqyzyloO/aOA==
X-CSE-MsgGUID: BgelbOsJTRG4BNRNrREFtQ==
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
   d="scan'208";a="246728201"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Oct 2025 17:48:14 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6E513E0CE0; Wed, 29 Oct 2025 17:48:14 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 5D729E0171
	for <cocci@sympa.inria.fr>; Wed, 29 Oct 2025 17:38:54 +0100 (CET)
X-CSE-ConnectionGUID: 945/UneIS9uhnM31lMR8tA==
X-CSE-MsgGUID: 3XuZEqg/SoiijYbGYbHvig==
IronPort-SDR: 6902431e_jyJuytxzBBaQ0C4pdxALilRJ1YPailSLHJGOaq6nCxmd5DZ
 HQfb8VbaoX824NyZvDNUnW4OLNNNxIOEB08pkGQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EZAABoQgJphf4EaaxaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T0GAQELAYI/gQJeMwQLSQSNTIZXgiEDnhqBfQIPAQMBDT0UBAEBAwSFAAKMU?=
 =?us-ascii?q?wIeBwEEMQgOAQIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABA?=
 =?us-ascii?q?QEBQEmGTw2CYgGBJIEmAQEBAQEBAQEBAQEBHQINfQEBAQECAToGAQE3AQQLC?=
 =?us-ascii?q?xguEEYGE4MCAYIiByMnAxGxG3iBNIEBggwBAQbcJYFkAwaBSgGFbIJkAYlqe?=
 =?us-ascii?q?icbgg2DPYECPosHgiaBDoYniDOJd1J4HANZLAFVExcLBwVbRUMDgQsjSwUtH?=
 =?us-ascii?q?YEkIh8QCBFgVECDSQ8MBmgPBoESGUkCAgIFAkI6gWgGHAYfEgIDAQICOlcNg?=
 =?us-ascii?q?XcCAgSCHn6CFQ+IcgMLbT03FBuUaoQUIiAwgRVNARuWQZoElF2BPoQmgWSKO?=
 =?us-ascii?q?pYGgUuWB5MZLphYjA6BepYZhSCBaQE4gVwzGggoCIMiTwMZD44hGYh6xnRCN?=
 =?us-ascii?q?QI6AgcLAQEDCZIea2ABAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 T3SFrAc8PR8LlGFiNv/PsCGvNo=
IronPort-HdrOrdr: A9a23:hX+gL6yXiK6rLafjs1PhKrPwLb1zdoMgy1knxilNoNJuEvBws/
 re+sjztCWE7wr5PUtMpTnuAsa9qB/nm6KdpLNhRItKPzOW3FdATrsSj7cKqgeIc0aVmtK1l5
 0QFpSWY+eAbmSS4/ya3DWF
X-Talos-CUID: 9a23:RJ/3G2xrYX4OCTYli2fuBgVFRp1iT3vQ7UyBPk++LD0wTJivGUO5rfY=
X-Talos-MUID: 9a23:O82vBgl6fVOVzksyzu+fdno5BNpazr2hT3sKkJQEisOrBCZQJTaS2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,264,1754949600"; 
   d="scan'208";a="246726262"
X-MGA-submission: =?us-ascii?q?MDFQH2ACpfQUlU+4WOGvj5+ne79WsiKXeTwUTb?=
 =?us-ascii?q?jn9qwdzUNC7430DxggStYBaOYwjddAlRKK66+bX7GEfrGpKR5WxQiAEg?=
 =?us-ascii?q?rgYD3u4CW1Vh+TBzA1MwwC6ZBoeOB1i6TSUy/25OumtMrzCZn1Nbebyr?=
 =?us-ascii?q?JZE4qZi9XR5H3icThGvezVZw=3D=3D?=
Received: from tor.source.kernel.org ([172.105.4.254])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 17:38:54 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 5E18E61D11;
	Wed, 29 Oct 2025 16:38:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0351FC4CEF7;
	Wed, 29 Oct 2025 16:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761755932;
	bh=JzF4xXvjF4bM00J3P3bfsQf+HnmAoBbcubTCtVQ0mVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HOw+60y5wQLxea2WHve3tJ+LC9YD9G+8rFGXTkAivVue7AXQXFhwpsbS4lTNXD+a6
	 Twaq14+wy50hgH62Eh2gLnV0GaEkQn2ddWlKwLjmybkcTMd/QgZwoKxSmBhycFfoj8
	 hMTCKCCtoZZdvxMA3NqCX8nR8KhIN9W2zUnXEtE6eOqw3i9XPHEpzRVUSqGlmxQF9j
	 jAzJyjjFFQN0pGCpfB0oW8T/zpycs8VEtTPWnBievBKfAFuoCEZ66ash1iZlZcnysc
	 jd8qqbwqy2u6Uo0Am3T6nQadxriGsnwUwtMU1YacpJMMgbl9kZQOxEI7Vbwtlns/Ou
	 sal1yyalkEMOA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vE9CN-000000007JD-1mOD;
	Wed, 29 Oct 2025 17:38:59 +0100
Date: Wed, 29 Oct 2025 17:38:59 +0100
From: Johan Hovold <johan@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Jakub Kicinski <kuba@kernel.org>, Alexei Lazar <alazar@nvidia.com>,
	Simon Horman <horms@kernel.org>, cocci@inria.fr,
	linux-kernel@vger.kernel.org
Message-ID: <aQJDIz-8Ow0OmczH@hovoldconsulting.com>
References: <20251029132922.17329-1-johan@kernel.org>
 <826f2fdb-bad8-44f4-8c8e-9353c3de73cd@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <826f2fdb-bad8-44f4-8c8e-9353c3de73cd@nvidia.com>
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH] Revert "scripts/coccinelle: Find PTR_ERR() to
 %pe candidates"
Reply-To: Johan Hovold <johan@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 3108
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-10/aQJDIz-8Ow0OmczH%40hovoldconsulting.com>

On Wed, Oct 29, 2025 at 03:59:50PM +0200, Gal Pressman wrote:
> On 29/10/2025 15:29, Johan Hovold wrote:
> > This reverts commit 57c49d2355729c12475554b4c51dbf830b02d08d.
> > 
> > Using "%pe" to print errnos is in no way mandated and a driver authors
> > may chose not to use it, for example, for consistency reasons.
> > 
> > Drop the recently added cocci script that has gotten the build bots to
> > send warning emails about perfectly valid code and which will likely
> > only result in churn and inconsistency.
> > 
> > Link: https://lore.kernel.org/all/aQHi4nUfIlcN1ac6@hovoldconsulting.com/
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> 
> The test by no means mandates authors to use %pe, as the output says:
> WARNING: Consider using %pe to print PTR_ERR()
> 
> "Consider" :).

Right, but it's preceded by a big "WARNING".

> I would consider it best practice to use it, and a few drivers were
> converted thanks to this test.

Unlike the rest of the misc cocci scripts I skimmed, this one does not
guard against any bugs. Instead it's pushing for a subjective style
preference, which is just going to result in churn when the clean up
crew starts sending mindless conversions of individual printks.

By all means, use %pe for your drivers, but it should not be forced
upon the rest of us this way.

> If the issue is with automatic build bots, then maybe this test should
> be excluded from them, rather than deleted?

It's both; it's the noise the new warnings generate but also the coming
flood up patches to "fix" them. There are already some 40 commits or so
in linux-next referencing this script.

Johan
