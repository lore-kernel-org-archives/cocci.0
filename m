Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 391AACCD184
	for <cocci@archiver.kernel.org>; Sun, 19 Oct 2025 14:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=8yFcHvdXkM5aYCWHL7ijhwiJNPkMKbqmJNZERyCqleE=;
  b=WUsQvKbpPphOfeVP3F0tUgfoXjFeRK+EBXmqHR4tNrfldTmx6Cnqn+PQ
   ntbgqUDToI7OxgWKtZFfZup5pOpICGc+Zb2shL1b8mpzJhlGNDaiZM/ka
   tGtyf+iR4Jzh8PWLLwlREw2RUdk2ysSQXirAnYOzkKNiILG3dfiltqAeH
   k=;
X-CSE-ConnectionGUID: 8V1UUjGLT1iWn87bLZe5/A==
X-CSE-MsgGUID: kAq6DPABTmW05Cnpb5HGhQ==
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
X-IronPort-AV: E=Sophos;i="6.19,240,1754949600"; 
   d="scan'208";a="245013505"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Oct 2025 16:40:41 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8F4A4E0CD5; Sun, 19 Oct 2025 16:40:41 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 96873E0171
	for <cocci@sympa.inria.fr>; Sun, 19 Oct 2025 16:40:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=8yFcHvdXkM5aYCWHL7ijhwiJNPkMKbqmJNZERyCqleE=;
  b=ErX/lH5olY1Ggmk7n4nLXjfSjY70Oqsq7MiFsja5az+ejrfca5zZkrBy
   EpmNGEsIUDkQjoeKVwU/v4kJAZeFdOiadpXxbTsnDUY3shbA5u+QtYgWe
   a1BEQrskRN+kMZ3DLVrNjRry7UiYNdZU9skLDWLpVF8ITU8/7bMvYCP2c
   I=;
X-CSE-ConnectionGUID: xe1FT+nsSMGUrrP3XCnlXA==
X-CSE-MsgGUID: L12Qks9/SCKrrCU7pQ3ijw==
X-IronPort-AV: E=Sophos;i="6.19,240,1754949600"; 
   d="scan'208";a="245013498"
Received: from unknown (HELO hadrien) ([202.187.229.14])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 16:40:34 +0200
Date: Sun, 19 Oct 2025 22:40:31 +0800 (+08)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <769428aa-9801-4805-bfc3-cd789f7541d1@web.de>
Message-ID: <9636e097-8570-7d37-3e6c-68de116cbb85@inria.fr>
References: <4afdfd37-3177-4480-9648-ab0d7f59097c@web.de> <d1b6d33d-cfc0-ff6b-47de-7bbc28e8a7d@inria.fr> <c55ea172-2c1b-4bbf-b5d4-e2d421e18b1f@web.de> <e5b2ceef-31a0-a54-dd74-c4dcdfcba5a@inria.fr> <769428aa-9801-4805-bfc3-cd789f7541d1@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Analysis challenges with SmPL for pass-through
 functions?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3081
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-10/9636e097-8570-7d37-3e6c-68de116cbb85%40inria.fr>



On Sun, 19 Oct 2025, Markus Elfring wrote:

> >>> If you don't want them to match the same thing, then you need to use a
> >>> disjunction.  In the first branch, the same metavariable should be used
> >>> twice, and then in the second branch there would be the two different
> >>> metavariables.  The match should only be indicated for the second branch.
> >> Does such a solution approach indicate a data processing requirement
> >> for multiple source code searches so that anything would be excluded finally?
> > No idea what this means.
>
> How many searches would need to be performed for the evaluation of
> SmPL disjunction elements?

I don't know what you mean by counting searches.  How is one search
defined?

julia


