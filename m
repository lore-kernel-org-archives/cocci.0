Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2270DC433F5
	for <cocci@archiver.kernel.org>; Sat, 12 Mar 2022 13:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=Fg00UdtTNWoCTbNTP+mqzkzXIivg5HmSbVVp+6gjsF8=;
  b=l0eUAzgrYKJJzbjVZUfd/dqo2lwDczbZJNxhLNglh8CwlzfOuWZA9E0p
   ZdB+Vb40FEE2OcTJmwBdSY46GjM/+ms9NnwC1119WTMXN06in3/Jssp1L
   rmciYFffubtml8J/GG1tqiceeNVcZqLkqsNkxjtB6iB9QwnIndxONCRKM
   U=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.90,175,1643670000"; 
   d="scan'208";a="25792475"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Mar 2022 14:53:02 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 179A8E0045; Sat, 12 Mar 2022 14:53:02 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 32C9AE0045
	for <cocci@sympa.inria.fr>; Sat, 12 Mar 2022 14:52:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Fg00UdtTNWoCTbNTP+mqzkzXIivg5HmSbVVp+6gjsF8=;
  b=SVY3gAgG1p7oXr1/FjLgpbKE78g7j+jasSKh/AKCK7Z4ENdZNBZrOyoU
   FTiAo0SAHPAiXZ1eY+P/faWXSaotPg8GXZbFN6CkF/bpBLg95yxOQITTO
   i1haTqceVFqbuSQYSChf6uXQJjm5bYOURq3FZs3G3K3HjCqtUn6ISN5Vs
   s=;
X-IronPort-AV: E=Sophos;i="5.90,175,1643670000"; 
   d="scan'208";a="8362534"
Received: from 203.107.68.85.rev.sfr.net (HELO hadrien) ([85.68.107.203])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2022 14:52:59 +0100
Date: Sat, 12 Mar 2022 14:52:58 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <d9dae057-06ad-f6a3-f4ac-5cd56c9ce081@web.de>
Message-ID: <alpine.DEB.2.22.394.2203121452420.18925@hadrien>
References: <d9dae057-06ad-f6a3-f4ac-5cd56c9ce081@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1681323505-1647093178=:18925"
Subject: Re: [cocci] Collateral evolution because of context-dependent
 grammar of SmPL?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 208
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/alpine.DEB.2.22.394.2203121452420.18925%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1681323505-1647093178=:18925
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sat, 12 Mar 2022, Markus Elfring wrote:

> Hello,
>
> I have taken another look at details from the grammar of the semantic patch language
> (Coccinelle software).
> I interpret the SmPL script programming structure in the way that optional header
> information can be specified before the main data processing part.
> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/5479fc964d209209e84ddd5caf3f395667721e7c/docs/manual/cocci_syntax.tex#L31
> https://github.com/coccinelle/coccinelle/blob/ae337fce1512ff15aabc3ad5b6d2e537f97ab62a/docs/manual/cocci_syntax.tex#L31
>
> The main part usually contains some SmPL rules.
> Each SmPL rule is split into two sections.
>
> 1. The beginning and end of the metavariable declaration block is denoted by
>    a pair of @ characters.
>    Additional settings can be specified also within the first pair of @ characters.
>
> 2. Code from supported scripting and programming languages can be specified for
>    desired analyses and transformations.
>    @ operators can be applied for the combination of metavariables
>    as they would be needed for selected data processing tasks.
>
>
> I got the impression that such characteristics result in the classification
> that the grammar of the semantic patch language is context-dependent.
>
> Something was achieved by the application of the software tool “Menhir”.
> http://gallium.inria.fr/~fpottier/menhir/
>
> This parser generator for the OCaml programming language is using the technique “LR(1)”.
>
> The Chomsky–Schützenberger hierarchy denotes some computational properties
> for such language categories.
> https://en.wikipedia.org/wiki/Context-sensitive_language#Computational_properties
>
> Advices were published that context-dependent grammars should safely be handled
> by more sophisticated parsing technologies.
> https://en.wikipedia.org/wiki/Comparison_of_parser_generators#Context-sensitive_grammars
>
> How do you think about to clarify corresponding design challenges any further?

The parser has different entry points according to the context.

julia
--8323329-1681323505-1647093178=:18925--
