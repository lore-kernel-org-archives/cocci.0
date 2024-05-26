Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0993C25B75
	for <cocci@archiver.kernel.org>; Sun, 26 May 2024 18:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=pGZ9O40A/d7wa13bUJI/ocizf1Fw4tixoeXn9+NCuHg=;
  b=tClpnjfuIE1owisdIH8Icmd2c8bTJ6WaAtJ+E+Hb45Fhc4PlAUumce+E
   JcjandE7gGB5Ab3S1f9ZoGpGqGya4EbxnsOEXRhfAU+LwiAje2lDaiX3H
   +kXA7ysDJ6HyxErFAmexzBFbE8hpg14BkVrbeWJ1K+YQYMLSAbghKb3lU
   o=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.08,190,1712613600"; 
   d="scan'208";a="167479064"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 May 2024 20:37:00 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0DB71E0CCE; Sun, 26 May 2024 20:37:00 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 52005E00B7
	for <cocci@sympa.inria.fr>; Sun, 26 May 2024 20:36:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=pGZ9O40A/d7wa13bUJI/ocizf1Fw4tixoeXn9+NCuHg=;
  b=AP62MMrxHJb+UNAS6Vwt1rkXysPTrj7tzkJVHM76wiaXxhyd+idnTanf
   AsV+h6RIaR2/cuSLzERqXLIhtCHSPck/vHxkAlIo/MDsxaTortXptxG75
   LBYjrzLPlcLjAWBAxLI/bYCvyyohg6Uq6jLxbBzLdifKpywtZOgVmEYf6
   U=;
X-IronPort-AV: E=Sophos;i="6.08,190,1712613600"; 
   d="scan'208";a="167479061"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2024 20:36:55 +0200
Date: Sun, 26 May 2024 20:36:54 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, kernel-janitors@vger.kernel.org
In-Reply-To: <702c16f2-33ae-4493-8062-24b14b7fb0be@web.de>
Message-ID: <alpine.DEB.2.22.394.2405262036190.16852@hadrien>
References: <7eb9626c-da7b-414d-bf50-da1eed27be31@web.de> <alpine.DEB.2.22.394.2405261847380.16852@hadrien> <702c16f2-33ae-4493-8062-24b14b7fb0be@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-710957120-1716748615=:16852"
Subject: Re: [cocci] Increasing usage of mutex guards (with SmPL)?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1758
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/alpine.DEB.2.22.394.2405262036190.16852%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-710957120-1716748615=:16852
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sun, 26 May 2024, Markus Elfring wrote:

> >> Will it become helpful to offer further SmPL script variants which can be used
> >> together with the tool “coccicheck”?
> >
> > I'm not the one to decide whether we should use cleanup for mutex locks.
> > Intuitively, my opinion would be that we should not.  Something that can
> > have so much impact on the execution of the system should be visible.
>
> You are trying to influence software evolution also according to
> scope-based resource management for a while, don't you?
> https://elixir.bootlin.com/linux/v6.9.2/source/include/linux/cleanup.h#L124

I have only helped to automate what others have already shown interest in.

julia
--8323329-710957120-1716748615=:16852--
