Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2E0DC48260
	for <cocci@archiver.kernel.org>; Sat, 10 Feb 2024 08:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=Am6XKOA77ojEKtmZTrG7ai+Ig1H8ZOuTlECzo0yQqW0=;
  b=g3tpr/QLT5YT8TaX6WudejkI+QTb2f9SfzCEB3IL7VpYPBKyy/3MSdUc
   061XaoRZJwZl7AgkF44BwHAb/c0vnRw6dA/rIIdfUQE2D4z9LzyHUCfk5
   C1ptWxpWTp3HAfIRvhUr2InRBMDObPq60vIlf7ARclg+JUwA+SOJFMqZ8
   k=;
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
X-IronPort-AV: E=Sophos;i="6.05,259,1701126000"; 
   d="scan'208";a="151298269"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Feb 2024 09:37:27 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 04AD2E0CD5; Sat, 10 Feb 2024 09:37:26 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id B7F27E008A
	for <cocci@sympa.inria.fr>; Sat, 10 Feb 2024 09:37:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Am6XKOA77ojEKtmZTrG7ai+Ig1H8ZOuTlECzo0yQqW0=;
  b=ZLU7qpEU+h50I/YsTX58Ah9zK+oLZhoz4LL4kb4BdIQT16PKqPd3mhq0
   W/CsG7Nl5IggViAAJnvAlVX55LWAtvSz0kPTdgBOCS+QoxYjW2mt9tchv
   k4qkGCHmu8WG/w+S9tY9TmK6glTZ0Y3CE54RcjYfqSM+JmWR7XoJgk3gX
   A=;
X-IronPort-AV: E=Sophos;i="6.05,259,1701126000"; 
   d="scan'208";a="79272637"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2024 09:37:24 +0100
Date: Sat, 10 Feb 2024 09:37:24 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <d4abffb5-6221-4109-9316-acb5c3720c31@web.de>
Message-ID: <alpine.DEB.2.22.394.2402100936350.53569@hadrien>
References: <d4abffb5-6221-4109-9316-acb5c3720c31@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1878559222-1707554244=:53569"
Subject: Re: [cocci] Extending handling of position information for SmPL
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1533
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/alpine.DEB.2.22.394.2402100936350.53569%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1878559222-1707554244=:53569
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sat, 10 Feb 2024, Markus Elfring wrote:

> Hello,
>
> Source code positions can be determined also by the means of the semantic patch language.
> I would occasionally like to benefit a bit more from this functionality.
>
> The SmPL manual provides the following information so far:
> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/4965f42eb94d2d67f7375c66b268997457cbcefb/docs/manual/cocci_syntax.tex#L411
> “…
> A position metavariable is used by attaching it using @ to any token,
> including another metavariable.
> …”
>
> Such a description is fine for the initial determination.
> But I suggest to reconsider data processing consequences after a corresponding
> variable assignment was performed.
> Addiional data became available. Thus I imagine that it would be more succinct
> to use these data at subsequent places in SmPL code by the following features:
>
> 1. Another character could indicate the direct reuse of a position metavariable
>    so that the identifier for a companion position metavariable does not need
>    to be repeated any more.
>
> 2. Another metavariable type (like “positioned”?) could indicate that
>    known data should be applied once more.
>
>
> How do you think about to extend the Coccinelle software here?

I can never really understand what you are asking for.  Please include a
concrete example.  A priori, I don't see any need for changing the way in
which matching of metavariables is expressed.

julia
--8323329-1878559222-1707554244=:53569--
