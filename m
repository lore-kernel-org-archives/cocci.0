Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5542C4345F
	for <cocci@archiver.kernel.org>; Thu, 18 Apr 2024 20:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=G8QTA78gicQvOzCOLPgT2dkGgBOXRzDjv6gxywnqqYY=;
  b=mMZg5p7P9ShWY4IiEqxW1NTcMn2yivqYG+AdDeVtwgT7TF73FZbrynVh
   rrrq4ku6IZIZBHA3aGpf1qRRTbauxTadOTPHa5/JKYSCxmDNrWDlzxhFS
   tzE1WbSBYjLRX2btb9DlsN007kW46X8pitj6kNJbujMIvOYDMqI0o9caP
   s=;
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
X-IronPort-AV: E=Sophos;i="6.07,213,1708383600"; 
   d="scan'208";a="162321959"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Apr 2024 22:55:29 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8729FE0138; Thu, 18 Apr 2024 22:55:29 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 6D155E0035
	for <cocci@sympa.inria.fr>; Thu, 18 Apr 2024 22:55:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=G8QTA78gicQvOzCOLPgT2dkGgBOXRzDjv6gxywnqqYY=;
  b=iKBMnnufEm63BJiJ736VH7eybDpAcLSFt8Jpjcc7GivmlCaKDSvE+BHY
   DYyD4JvBLFKAZEkhcykeFxkpU6IcFxPWOTqzBqhd3OvJkg60LdGUTyymg
   aMx1dYFxSkgpHpk1pZMcPOTLdBdk7JHPUDfYzZ0lCgP+0ZFfIyMnyQOrq
   c=;
X-IronPort-AV: E=Sophos;i="6.07,213,1708383600"; 
   d="scan'208";a="162321955"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 22:55:24 +0200
Date: Thu, 18 Apr 2024 22:55:23 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Ricardo Ribalda <ribalda@chromium.org>
cc: Nicolas Palix <nicolas.palix@imag.fr>, Denis Efremov <efremov@linux.com>, 
    cocci@inria.fr, linux-kernel@vger.kernel.org
In-Reply-To: <20240415-minimax-v1-1-5feb20d66a79@chromium.org>
Message-ID: <alpine.DEB.2.22.394.2404182255010.3213@hadrien>
References: <20240415-minimax-v1-1-5feb20d66a79@chromium.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [PATCH] coccinelle: misc: minmax: Suppress reports for
 err returns
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1673
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-04/alpine.DEB.2.22.394.2404182255010.3213%40hadrien>



On Mon, 15 Apr 2024, Ricardo Ribalda wrote:

> Most of the people prefer:
>
> return ret < 0 ? ret: 0;
>
> than:
>
> return min(ret, 0);
>
> Let's tweak the cocci file to ignore those lines completely.
>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Applied, thanks. (Coccinelle for-6.10 branch).

julia

> ---
> Following discussion at:
> https://lore.kernel.org/linux-media/20240415203304.GA3460978@ragnatech.se/T/#m4dce34572312bd8a02542d798f21af7e4fc05fe8
> ---
>  scripts/coccinelle/misc/minmax.cocci | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/scripts/coccinelle/misc/minmax.cocci b/scripts/coccinelle/misc/minmax.cocci
> index fcf908b34f27..ca4830ae3042 100644
> --- a/scripts/coccinelle/misc/minmax.cocci
> +++ b/scripts/coccinelle/misc/minmax.cocci
> @@ -50,11 +50,26 @@ func(...)
>  	...>
>  }
>
> +// Ignore errcode returns.
> +@errcode@
> +position p;
> +identifier func;
> +expression x;
> +binary operator cmp = {<, <=};
> +@@
> +
> +func(...)
> +{
> +	<...
> +	return ((x) cmp@p 0 ? (x) : 0);
> +	...>
> +}
> +
>  @rmin depends on !patch@
>  identifier func;
>  expression x, y;
>  binary operator cmp = {<, <=};
> -position p;
> +position p != errcode.p;
>  @@
>
>  func(...)
> @@ -116,21 +131,6 @@ func(...)
>  	...>
>  }
>
> -// Don't generate patches for errcode returns.
> -@errcode depends on patch@
> -position p;
> -identifier func;
> -expression x;
> -binary operator cmp = {<, <=};
> -@@
> -
> -func(...)
> -{
> -	<...
> -	return ((x) cmp@p 0 ? (x) : 0);
> -	...>
> -}
> -
>  @pmin depends on patch@
>  identifier func;
>  expression x, y;
>
> ---
> base-commit: 71b3ed53b08d87212fbbe51bdc3bf44eb8c462f8
> change-id: 20240415-minimax-1e9110d4697b
>
> Best regards,
> --
> Ricardo Ribalda <ribalda@chromium.org>
>
>
