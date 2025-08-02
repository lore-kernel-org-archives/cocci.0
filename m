Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07263C87FD2
	for <cocci@archiver.kernel.org>; Sat,  2 Aug 2025 19:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=gs20HToLhMq1R9/Qc7v7KyFDLITS0G4WHVSZptlxUHE=;
  b=EDHOBt9c9QbZ6+LYdrJVAfk4tFEc37X3xnJxuIj1SktPDcXoVv/DiuCA
   SyHzVfCJt8VZpl1J0y30ErylS0Un27FfLA/Ei/HnWUGSDzdIpPPHKKIio
   6Zv3wXhwu/dvSZumGqEuenGXdZlxknlEliv8QacEeSBmA6yZTxZmVKyae
   4=;
X-CSE-ConnectionGUID: xEy8tmUASYGo8Vpt1n+Zdg==
X-CSE-MsgGUID: P5+qpZriQcqnABOELPaiyA==
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.17,258,1747692000"; 
   d="scan'208";a="233972017"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Aug 2025 21:44:59 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 322F0E0171; Sat,  2 Aug 2025 21:44:59 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 187C2E0171
	for <cocci@sympa.inria.fr>; Sat,  2 Aug 2025 21:44:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=gs20HToLhMq1R9/Qc7v7KyFDLITS0G4WHVSZptlxUHE=;
  b=Ex4hGZcG6akrFusvk2sepafSGjpc2G9yp78yAvRLYv0/WKtqSH79oH3r
   2U5bWhfOymARdgJomxJCxhNKXJyZtwPCjGHNmv20MdmqbWQCYQ1sOw/uH
   KOHUhMXU46IKtd8A5jrIDJFQDRLsTFqvfZoYtro3Qsfm8oBDvAiU8sNOL
   g=;
X-CSE-ConnectionGUID: LolFa1h3Qp+daTEx3w7SGw==
X-CSE-MsgGUID: YsF+DR7fQxqdct/3OCIAJQ==
X-IronPort-AV: E=Sophos;i="6.17,258,1747692000"; 
   d="scan'208";a="233972016"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2025 21:44:58 +0200
Date: Sat, 2 Aug 2025 21:44:57 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, Erick Karanja <karanja99erick@gmail.com>
In-Reply-To: <62af4001-9e69-4f0e-929d-f748916c7a71@web.de>
Message-ID: <alpine.DEB.2.22.394.2508022144380.3428@hadrien>
References: <6daf83a9-abbf-45f7-b82e-c6207364fd8b@web.de> <7560a81f-ba29-4b16-b8ed-95cb4d72f3f4@web.de> <alpine.DEB.2.22.394.2508021353080.3428@hadrien> <e0519749-0043-4cb0-a12d-6a34e2076f58@web.de> <alpine.DEB.2.22.394.2508021409080.3428@hadrien>
 <c5042d2d-43df-4276-9611-da4f30763940@web.de> <alpine.DEB.2.22.394.2508021502250.3428@hadrien> <6239d52e-3213-4083-8d97-9b1f59d2d5b4@web.de> <alpine.DEB.2.22.394.2508021745180.3428@hadrien> <2130ab11-8ec0-4e57-9a73-5e1ac9e41f7f@web.de>
 <alpine.DEB.2.22.394.2508021803360.3428@hadrien> <51664351-746c-4d7a-ae45-2a610ba45176@web.de> <alpine.DEB.2.22.394.2508021822490.3428@hadrien> <5e8e1f8a-6832-49af-bca5-41d2a13b1322@web.de> <alpine.DEB.2.22.394.2508021935250.3428@hadrien>
 <a86ce687-61a5-4e52-92fa-6a0d53db9360@web.de> <alpine.DEB.2.22.394.2508022111230.3428@hadrien> <7743d469-fc0e-4575-b05d-72a072c1bbb4@web.de> <alpine.DEB.2.22.394.2508022133460.3428@hadrien> <62af4001-9e69-4f0e-929d-f748916c7a71@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-354878478-1754163898=:3428"
Subject: Re: [cocci] Searching for lock calls without unlocking (with SmPL)?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2950
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-08/alpine.DEB.2.22.394.2508022144380.3428%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-354878478-1754163898=:3428
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sat, 2 Aug 2025, Markus Elfring wrote:

> >>>> It seems that this software behaviour (according to the functionality “semantic match”)
> >>>> was not officially documented so far.
> >>>> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/3aa9a6ab3b035e31292be31399b99a8857480aef/docs/manual/cocci_syntax.tex#L1214-1225
> >>>
> >>> The cited text seems totally irrelevant.
> >>
> >> I hope that the SmPL manual is relevant so far for the determination
> >> of known (and mostly desirable) software behaviour.
> >
> > The cited text describes what happens when a match occurs,
>
> Some information is provided.
>
>
> >                                                            It doesn't say
> > anything about where a match can occur, which is determined in the same
> > way for all other kinds of matches, except that for ... only the existence
> > of a path with the property is required by default rather than all paths
> > being required to have the property.
>
> Are there further clarification opportunities?

The paper from POPL 2009 explains everything.

julia
--8323329-354878478-1754163898=:3428--
