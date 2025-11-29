Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1100CFD2F6
	for <cocci@archiver.kernel.org>; Sat, 29 Nov 2025 15:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=Po1cgGWfqz58NjzkyKDEyPXn40fy/ySIbCy/rcM9LRw=;
  b=FcpIruM+4vLZ9Qxwx7bdHHLawwlXcsswnEp5nvj20nZgUy67piF4h0ks
   uvGYWOJpWNnROnJyH8hJVaiAlUSTWMUkKLYnrXHjnIzv8NcwxVVmMyAGJ
   Yav3X4CFJ0HRl0h8maGQp6GZa5k1rJllgb8dU/qHD6m9aioC8VOA2agSH
   A=;
X-CSE-ConnectionGUID: 3OUYm8JyS8m3rAU+GdoEDA==
X-CSE-MsgGUID: 5LT1Af4KQ9aCADR3js5Gfg==
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
X-IronPort-AV: E=Sophos;i="6.20,236,1758578400"; 
   d="scan'208";a="251892601"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Nov 2025 16:01:02 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7FF8EE0AF1; Sat, 29 Nov 2025 16:01:02 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id E1014E0157
	for <cocci@sympa.inria.fr>; Sat, 29 Nov 2025 16:00:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Po1cgGWfqz58NjzkyKDEyPXn40fy/ySIbCy/rcM9LRw=;
  b=NWhhHkut/U8N+JK5EUsExTQfCugwZ9bTztvDyct2y0SQArrkZylqU9+x
   Lq0VIktjUn1MjQ9PC1wvEs69GqPGQE5oIvQug/Y6upnOrd+qnYsJdzBJU
   K7yAhkQfzyB7neMyfofPGs2RFIRogN0nhZR6ft8mYN8WewLkKAG+Jw7L4
   c=;
X-CSE-ConnectionGUID: Aj0uwuhATZq+986VSJq48g==
X-CSE-MsgGUID: FSPtHDt9TkKGsPAFLQMhxQ==
X-IronPort-AV: E=Sophos;i="6.20,236,1758578400"; 
   d="scan'208";a="132283941"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2025 16:00:57 +0100
Date: Sat, 29 Nov 2025 16:00:57 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: Julia Lawall <julia.lawall@inria.fr>, 
    Tobias Deiminger <tobias.deiminger@posteo.de>, cocci@inria.fr
In-Reply-To: <24d6e1ac-0dcb-4334-bc44-65c3012f7764@web.de>
Message-ID: <cdd549f-17ec-1dda-8f49-2fbdb9cf4439@inria.fr>
References: <4f6e259891de0666aa1fa10b810a5dd3@posteo.de> <b4884a21-4a59-c549-8466-164a20a76abe@inria.fr> <2897bda0c438111e967017f6bb3422f0@posteo.de> <caf02577-eee9-d55d-1f42-7b1f3bd2f60@inria.fr> <24d6e1ac-0dcb-4334-bc44-65c3012f7764@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Can we match a known macro by macro name instead of
 expanded function name?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3210
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/cdd549f-17ec-1dda-8f49-2fbdb9cf4439%40inria.fr>



On Sat, 29 Nov 2025, Markus Elfring wrote:

> >> How else to look for functions with attributes then?
> > The return type for the function is required in this case:
> >
> > @r@
> > attribute a;
> > identifier fn;
> > types t;
> > @@
> >
> > * t a fn(...) { ... }
>
> Would a similar source code search approach become interesting
> for further clarifications?
>
> Exclude macro calls from searches for function implementations
> 2024-10-28
> https://github.com/coccinelle/coccinelle/issues/381

Coccinelle expands macros when it has them available and when it is not
able to parse the code without doing the expansion.  This is not
controllable by the user.  The only thing you can do it perhaps provide a
different definition of the macro that better corresponds to the results
you hope for (or just remove the definition of the macro entirely, which
will cause a parse failure and thus no results for the affected code).

julia
