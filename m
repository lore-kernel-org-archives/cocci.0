Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C986DC4345F
	for <cocci@archiver.kernel.org>; Tue, 16 Apr 2024 08:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=yFAspJZiElnV7ukAcy7TezRh9JQm8uQrSj63spw6SrQ=;
  b=E7YcVzVrBwxNywOAWAmTAC++BubIT5csET2prLGA4RONhbHTPCYsg4L6
   6stqHLTiwZch7aIK4ZgSj9BeI1XLCoUTHpDRDEI5+7/GglppAaHh68m5+
   bTN7B5HTkxB0TlNbLdUeR5t/yFPKk/7rFY7ArJtjU1AZ7amWyQE+2VFjJ
   0=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.07,205,1708383600"; 
   d="scan'208";a="161799983"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Apr 2024 10:32:20 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E51EFE0138; Tue, 16 Apr 2024 10:32:19 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id D5E5FE0035
	for <cocci@sympa.inria.fr>; Tue, 16 Apr 2024 10:32:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=yFAspJZiElnV7ukAcy7TezRh9JQm8uQrSj63spw6SrQ=;
  b=DlAUHYf0e5Aqj6iIpamUPwirUZwwNkwrWCOJ6YJ31SbATaWX+aLW8qCd
   xnreRUqQx/oeoXmoWeFz1I0ne+Uo8mAAjIQBD1FKkw4BVUdiqPBl2PLvt
   qztUxP7pVe7H36/8PfwJoz92sPKaVnT4EZo09e8BB+A1BLiVnbjj/f9i1
   s=;
X-IronPort-AV: E=Sophos;i="6.07,205,1708383600"; 
   d="scan'208";a="161799962"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 10:32:10 +0200
Date: Tue, 16 Apr 2024 10:32:09 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Ricardo Ribalda <ribalda@chromium.org>
cc: Nicolas Palix <nicolas.palix@imag.fr>, Denis Efremov <efremov@linux.com>, 
    cocci@inria.fr, linux-kernel@vger.kernel.org
In-Reply-To: <20240415-minimax-v1-1-5feb20d66a79@chromium.org>
Message-ID: <ebdeebc4-f840-295-1a25-fc66127e1238@inria.fr>
References: <20240415-minimax-v1-1-5feb20d66a79@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [PATCH] coccinelle: misc: minmax: Suppress reports for
 err returns
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1653
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-04/ebdeebc4-f840-295-1a25-fc66127e1238%40inria.fr>



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

I agree.  Thanks for the patch.

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
