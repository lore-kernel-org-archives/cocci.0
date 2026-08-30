Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FD8FC61DD9
	for <cocci@archiver.kernel.org>; Sun, 30 Aug 2026 12:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=8lgaUawsvkbyEqQ1bzA/Q5gCo8KQllxlnFV6Z6dKQ0E=;
  b=LehehgMPKL7KO154B562Inhf/hQzLhnoP+xpNRbq4ObGXtmsUalu6o4E
   b1YohGymL79WosMn1QxG6dYJwuGyQNgYgTOAQgxasOmRv1Gw4gFkKUZay
   e7g65Y5tIJ6xNw4WKZUHgm0rt++YHGYbbO52+HpcLpKJAvi6UpKI6gAnw
   I=;
X-CSE-ConnectionGUID: 0AKaQ6hES0CS28py/LGu+Q==
X-CSE-MsgGUID: GxGSwrsFSyK3C5HflkxuNA==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.25,252,1779141600"; 
   d="scan'208";a="292190038"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Aug 2026 14:39:30 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id E7C9B805DF; Sun, 30 Aug 2026 14:39:29 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id AC2F2805C9
	for <cocci@sympa.inria.fr>; Sun, 30 Aug 2026 14:39:23 +0200 (CEST)
X-CSE-ConnectionGUID: rdcxUyyeRyOGT4uFugn6fg==
X-CSE-MsgGUID: nG93uweiQhG2qZmldGNIsA==
X-IronPort-AV: E=Sophos;i="6.25,252,1779141600"; 
   d="scan'208";a="292190008"
Received: from 88-188-149-159.subs.proxad.net (HELO hadrien.home) ([88.188.149.159])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2026 14:39:23 +0200
Date: Sun, 30 Aug 2026 14:39:23 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
cc: Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr, 
    linux-kernel@vger.kernel.org
In-Reply-To: <20260823161826.3805598-7-ekffu200098@gmail.com>
Message-ID: <618633a7-eda8-5a26-b03f-2ffbaf4f1af7@inria.fr>
References: <20260823161826.3805598-1-ekffu200098@gmail.com> <20260823161826.3805598-7-ekffu200098@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [PATCH 6/7] coccinelle: atomic_as_refcounter: drop
 atomic_long_dec_and_lock
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3725
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-08/e3_hsJKmbcYNdWAWHYhOKg>



On Mon, 24 Aug 2026, Sang-Heon Jeon wrote:

> atomic_long_dec_and_lock() has never existed. So drop it from the rules.
>
> No functional change.

Applied

>
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> ---
>  scripts/coccinelle/api/atomic_as_refcounter.cocci | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/scripts/coccinelle/api/atomic_as_refcounter.cocci b/scripts/coccinelle/api/atomic_as_refcounter.cocci
> index bbe5b2932933..af82b9e094aa 100644
> --- a/scripts/coccinelle/api/atomic_as_refcounter.cocci
> +++ b/scripts/coccinelle/api/atomic_as_refcounter.cocci
> @@ -26,8 +26,6 @@ identifier fname6 =~ ".*call_rcu.*";
>   atomic_dec_and_test@p1(&(a)->x)
>  |
>   atomic_dec_and_lock@p1(&(a)->x, ...)
> -|
> - atomic_long_dec_and_lock@p1(&(a)->x, ...)
>  |
>   atomic_long_dec_and_test@p1(&(a)->x)
>  |
> @@ -69,8 +67,6 @@ identifier fname =~ ".*free.*";
>   atomic_dec_and_test@p1(&(a)->x)
>  |
>   atomic_dec_and_lock@p1(&(a)->x, ...)
> -|
> - atomic_long_dec_and_lock@p1(&(a)->x, ...)
>  |
>   atomic_long_dec_and_test@p1(&(a)->x)
>  |
> --
> 2.43.0
>
>
