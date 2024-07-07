Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1EBCC30653
	for <cocci@archiver.kernel.org>; Sun,  7 Jul 2024 14:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=W+iFoFafxXmA+rKi7G2mQu/NhxSFfr5roXcIPHAXuKo=;
  b=voubYFaWaWQzA9iC31g7R7QpU+7aKgPklVuTtFsnYBWTZKMHmGwhWqEi
   2dY97al/fmd3O0zV+Ly45E6UFWnPQuWN9cLJmc0jpikx0pFBURvyAvphr
   Xv1SaiS70qi/wnGaqJT2WZA5b7yMa6wMMoIjGu3EZuPrwnkpRDP+VjKN8
   Q=;
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
X-IronPort-AV: E=Sophos;i="6.09,190,1716242400"; 
   d="scan'208";a="174323760"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Jul 2024 16:37:34 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 560F3E0CCE; Sun,  7 Jul 2024 16:37:34 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 710C3E004E
	for <cocci@sympa.inria.fr>; Sun,  7 Jul 2024 16:37:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=W+iFoFafxXmA+rKi7G2mQu/NhxSFfr5roXcIPHAXuKo=;
  b=ZOY80sUQVSsRG19QW6K+w5cXJdIEhv8E+q94xQQjJTjLWnNI5CxqdWHr
   m9NcsUdlQI7ZCmWLjWjOl1gYiZERac/balU0+6BoqtOnXhcGl6RDTYJAQ
   hMPaNDE9Sr09g9LFojZ7na8lz5mdyHAIaqzRszVQkN19c2ebxJZ6JGo48
   g=;
X-IronPort-AV: E=Sophos;i="6.09,190,1716242400"; 
   d="scan'208";a="91551430"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2024 16:37:33 +0200
Date: Sun, 7 Jul 2024 16:37:32 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, cocci@inria.fr
In-Reply-To: <1d7aa71d-be7e-4750-b1cd-c1ee34e877c3@web.de>
Message-ID: <alpine.DEB.2.22.394.2407071635530.3414@hadrien>
References: <8d145e35-33af-4f81-a77a-2bbc5c734045@web.de> <ZoqY5GQlpKwZ3SEo@shikoro> <1d7aa71d-be7e-4750-b1cd-c1ee34e877c3@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Deleting unwanted semicolons (with SmPL)?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1804
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-07/alpine.DEB.2.22.394.2407071635530.3414%40hadrien>



On Sun, 7 Jul 2024, Markus Elfring wrote:

> >> @deletion@
> >> @@
> >>  return ...;
> >>  }
> >> -;
> >
> > How should coccinelle transfer this incomplete function body to an AST?

How about

@@
statement S;
@@

S
- ;

On the other hand if you mean that you want to find ; after the end of a
function definition, Coccinelle won't help with that.

julia


>
> I hope that the support will grow also for advanced handling of abstract
> syntax trees and semantic graphs.
>
> Development interests grew somehow for programming languages like C++ and Rust
> to some degree (for example).
>
>
> >> Will the shown source code transformation approach ever become supported
> >> by the Coccinelle software?
> >
> > Wrong tool. I suggest AWK for such changes.
>
> This programming language is also powerful. But I guess that its support
> is too limited so far for more desirable source code transformations.
>
> Further improvements can eventually happen depending on corresponding
> development resources.
>
> See also another clarification approach:
> Add a metavariable for the handling of source code
> 2018-05-23
> https://github.com/coccinelle/coccinelle/issues/140
>
> Regards,
> Markus
>
