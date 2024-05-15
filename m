Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ABFEC25B75
	for <cocci@archiver.kernel.org>; Wed, 15 May 2024 09:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=YXAHLNqW48TSCeJcYEh6IhDTwkwt5UINsUWRNjQhGKk=;
  b=nbkFN7z8HyRF33qnTbzUzPOkewq4QTev8LK2AZuDNMEGC5tAyYQyF1Vg
   4xO/75x0muV7xWixZyBBQRHXOYj897TokpjiCeSv0VaCSOnIsqWf5hl9b
   MY0hdYKixwSiIbmevWd1kCyZNxGuQAMDfvOltAAzjQWTekFM5d/N5mU/f
   4=;
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
X-IronPort-AV: E=Sophos;i="6.08,161,1712613600"; 
   d="scan'208";a="165822000"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 May 2024 11:13:14 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 614BAE0CD0; Wed, 15 May 2024 11:13:14 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id A779CE0AF1
	for <cocci@sympa.inria.fr>; Wed, 15 May 2024 11:13:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=YXAHLNqW48TSCeJcYEh6IhDTwkwt5UINsUWRNjQhGKk=;
  b=bIhHv2BwaV11nwreeGZlvh+BAeG1ioAaTqhKIoaJ/ZQuXTIvRPPeYoi3
   zHAnJ9unulrO2L9hI7Ps+RAiFh8smQqEDRSWvFvuvSSWzQN8ijsP8ifcj
   XRkzgLNLbbGlRSVLs3M3pzHnMs1QXpzN/beCertyv7iUrnvFLA3rJpVEf
   s=;
X-IronPort-AV: E=Sophos;i="6.08,161,1712613600"; 
   d="scan'208";a="165821986"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 11:13:10 +0200
Date: Wed, 15 May 2024 11:13:10 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Derek M Jones <derek@knosof.co.uk>
cc: cocci@inria.fr
In-Reply-To: <043e82d3-7299-4aac-abfe-60bd858dc598@knosof.co.uk>
Message-ID: <91657a8-93cd-6c8d-67dd-146cd2cc4abf@inria.fr>
References: <233b3043-2539-42f4-b47a-771b0094b558@knosof.co.uk> <alpine.DEB.2.22.394.2405150758100.3404@hadrien> <043e82d3-7299-4aac-abfe-60bd858dc598@knosof.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] ChatGPT 4 and Coccinelle
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1744
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/91657a8-93cd-6c8d-67dd-146cd2cc4abf%40inria.fr>



On Wed, 15 May 2024, Derek M Jones wrote:

> Julia,
>
> > I agree.  The whole premise behind Coccinelle is that the intelligence and
> > responsability of the human behind the semantic patch will make up for the
> > added ability to introduce bad code on a large scale.
>
> LLMs can write bad code without needing to use Coccinelle.
>
> Tool integration allows LLMs to offload stuff that is beyond
> their token prediction ability, e.g., how many baseballs fit in
> a Jumbo Jet gets fed into Mathematica, or a Python script on
> the open source LLMs.
>
> The code tool integration focus at the moment is on SQL.
>
> In the following, Coccinelle may have been picked first because of
> my earlier question.
>
> Derek
> What is the best tool to use to replace calls to an old version of an API with
> the equivalent calls in the new API?
>
> ChatGPT 4
> When you need to replace calls to an old version of an API with calls to a new
> version across a large codebase, using an automated refactoring tool can be
> the most efficient way to manage this task. Here are some of the best tools
> and approaches for this purpose:
>
> 1.  Coccinelle:
>         Coccinelle is a tool designed specifically for performing large-scale
> source code transformations in C programs, though it can be used for other
> languages with some adaptations. It allows you to write semantic patches (in a
> special language called SmPL) that describe both the code to find and the code
> to replace it with. This can be particularly useful for API updates where
> changes are systematic.

Great to have the ChatGPT seal of approval :)

thanks,
julia

>
> Refactoring tools in Integrated Development Environments (IDEs):
> Rector for PHP:
> JSCodeShift for JavaScript:
> Custom Scripts:
>
> --
> Derek M. Jones           Evidence-based software engineering
> blog:https://shape-of-code.com
>
