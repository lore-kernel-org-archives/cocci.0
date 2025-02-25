Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08BEFC021B8
	for <cocci@archiver.kernel.org>; Tue, 25 Feb 2025 21:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=9p37DOzjuCzAng3R06pvfZMxDpig3NRYT9lwV8XJi9Q=;
  b=RVAmXjonTy57iRn6DyzRkCaivSUj3kOX6jfjijij8cV5R/zCl67Bkqd5
   RGr2RN3zIewdG9YA2ppLJRcuP+GvEt2h4SYFL5wHKtH3qaSQf9Oa22/Jh
   9GgSfBchASNivC3aBdw7dSXykH00ExKD2XYR/wX+MrgDMjV9lEbjgPVVX
   I=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@rosenzweig.io
X-IronPort-AV: E=Sophos;i="6.13,314,1732575600"; 
   d="scan'208";a="210047127"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Feb 2025 22:17:09 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CA16AE0D20; Tue, 25 Feb 2025 22:17:08 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id DC8BEE0260
	for <cocci@sympa.inria.fr>; Tue, 25 Feb 2025 22:06:11 +0100 (CET)
IronPort-SDR: 67be30b2_78JiDtfURHqRwgTu2T8PoT/oAhXl51D2YTdGTUZP/Ec4dSF
 fK5S2U96z7HR804icxLEfNro2NZNqTA0NyFY76w==
X-IPAS-Result: =?us-ascii?q?A0HSAwAkML5nhbk6119aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UEFAQELAYJDgVY0BwhIlikghXqMbossgWgWDwEDAQ1EBAEBAwEDggyCdAILi?=
 =?us-ascii?q?wcCHwYBBDIHDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQEBA?=
 =?us-ascii?q?UBJhXsNgmIBM4IWLDZVAQEBAgE6BgEBNwEECwtGEEYGgxWCQiMHsEKBNIEBg?=
 =?us-ascii?q?gwBAQbcIIFlCR6BKgGFa4JjAYloeicbP4FOhD8+gRmJbodfp2dSexwDWSwBS?=
 =?us-ascii?q?wo1DDlwSAOBMoEjBTR7gguBMjoCDQKCQHAfhEiCN4NLeIMxgRCBY4NvghGBY?=
 =?us-ascii?q?AMDFg8Bgx93HIR/g2kdQAN4PTcUGwaiGIVVqCmhBIQlgWOgRYE4giUBpmSYf?=
 =?us-ascii?q?akwgW4EL4FceQyDIk8DGQ+OIRmGRckHKDI8AgcLAQEDCZAcgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 A==
IronPort-HdrOrdr: A9a23:rfO0gKzT5UjusrLfTFazKrPwGL1zdoMgy1knxilNoNJuHPBws/
 re+MjztCWE7Qr5PUtLpTnuAsK9qB/nmaKdpLNhWotKPzOW2ldATrsD0WKK+VSJJ8S9zJ8/6U
 4KSclD4bPLYmRSvILf4AexHspl79yA7smT9IHjJoBWID1XVw==
X-Talos-CUID: =?us-ascii?q?9a23=3AvXeQZ2gUhv+I5sMe/dIDjCTXcDJuKnvT9VH6D2u?=
 =?us-ascii?q?BBV1jSaCeRXGN2LxWup87?=
X-Talos-MUID: 9a23:VOOgJwXLEqWdrC7q/C/23iglCZtr34e/I0cIuq05h/eVJyMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,314,1732575600"; 
   d="scan'208";a="110055158"
X-MGA-submission: =?us-ascii?q?MDE5QLPKXc7oIr77PMn+RYhSQbIrD7G5tU6X+f?=
 =?us-ascii?q?AVz5NCLdPqETEmvt8pu8WzfoaJyUupdauqmZw8xfRN8IDeQnz8zxD3TE?=
 =?us-ascii?q?disBiS/cjzLuEWYWnzFWNL9FgIBgaQe6/WseovKS9uQSXZm1A/qOUupn?=
 =?us-ascii?q?wSnSFCd5rEwkqmt1rilatcDw=3D=3D?=
Received: from out-185.mta1.migadu.com ([95.215.58.185])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 22:05:54 +0100
Date: Tue, 25 Feb 2025 16:05:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
	s=key1; t=1740517543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9p37DOzjuCzAng3R06pvfZMxDpig3NRYT9lwV8XJi9Q=;
	b=P2SIKjUoZgDOLth3HabzeZFkYOoFPbZQ1n5wrcpGf7IwZG1Lx7AhwDtgQjpiEK0tWg/vsy
	xDtzsGB9nm+O5SGJbSbwvI/UGp3ppMJ6lmNpDsiDF52iMROoC4jbXrYASk+Zjxmx9WgMMB
	uIUWjdCZE5BuagAwtN2e8SzBnjkIiIWh5vD51qzuG81+pMHl+4OMawAwbq1ISlbpJAbeDk
	RqmHiN2dTXi8L0gGcyph2S3+renV/ktFyXMuQNAOb6d12hXA26nXLiwbCSstJ4hH/K4fsq
	w96QHkAShC9zRCfFgoWa5pJKNeYpTq05PrM5pgG4pYeZ5VdqFruw5ztFwwn6ew==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
Message-ID: <Z74wnyWEjnZgsJuu@blossom>
References: <Z7zjkyOeoPNYeOR3@blossom>
 <alpine.DEB.2.22.394.2502252132540.3444@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2502252132540.3444@hadrien>
X-Migadu-Flow: FLOW_OUT
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] Replacement of the form `x |= function()`
Reply-To: Alyssa Rosenzweig <alyssa@rosenzweig.io>
X-Loop: cocci@inria.fr
X-Sequence: 2453
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/Z74wnyWEjnZgsJuu%40blossom>

> What version of Coccinelle do you have?  For me it works fine...

1.1.1, apparently. I didn't realize Fedora 40 was so out-of-date, sorry!

[BTW, I'm a huge fan of Coccinelle. Thank you for writing this
phenomenal piece of software!]
