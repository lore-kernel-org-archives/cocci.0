Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20EE5C531C9
	for <cocci@archiver.kernel.org>; Sat, 25 Jul 2026 19:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=8kFBDdcAZzbpqivJqkzQ8it00qH+vp9QjL8LAdLo2kU=;
  b=I3hwU3ZfnwGhcgUPy+Rjh9vdZpoUrP4nO2RbTfvjh0NFR+3GBqGINfFa
   OgkdOM25DY86ZydWFMCCCswucRLlP8e4gG/WIcVTbZ/Mx6nl89Ik9rGUI
   vwf3SU2DcT9Jmf9ZeXO11x3WWuFIw1/fzZ9FksQxRqlzA2Z39GSuAjqhH
   M=;
X-CSE-ConnectionGUID: TNJ1rUFlSMO9HjwYjXuu0A==
X-CSE-MsgGUID: dYcz8TNBR+qYTvfGXxI0GA==
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
X-IronPort-AV: E=Sophos;i="6.25,185,1779141600"; 
   d="scan'208";a="287892521"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Jul 2026 21:48:46 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id B5B1081561; Sat, 25 Jul 2026 21:48:46 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 68290802DF
	for <cocci@sympa.inria.fr>; Sat, 25 Jul 2026 21:48:45 +0200 (CEST)
X-CSE-ConnectionGUID: i4o0cXSEQJmJcnxxhrRuDw==
X-CSE-MsgGUID: EihyYuHKQT6lfZNt4vklOg==
X-IronPort-AV: E=Sophos;i="6.25,185,1779141600"; 
   d="scan'208";a="287892509"
Received: from 88-188-149-159.subs.proxad.net (HELO hadrien.home) ([88.188.149.159])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2026 21:48:45 +0200
Date: Sat, 25 Jul 2026 21:48:45 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
cc: Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr, 
    linux-kernel@vger.kernel.org
In-Reply-To: <20260725113303.691676-3-ekffu200098@gmail.com>
Message-ID: <317de7e1-4f60-7590-28a8-2c9e64c07f3b@inria.fr>
References: <20260725113303.691676-1-ekffu200098@gmail.com> <20260725113303.691676-3-ekffu200098@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [PATCH 2/3] coccinelle: double_lock: improve
 performance when no double lock exists
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3659
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/1RHcO2chjxOERiodvl5AFg>



On Sat, 25 Jul 2026, Sang-Heon Jeon wrote:

> The 'balanced' rule collects the locks that are taken and released
> under the same condition, to prevent them from being reported as a
> double lock. It runs on every file that contains a lock call.
>
> To avoid this, collect the double-lock candidates first, so that
> 'balanced' runs only when one exists. The report then excludes what
> 'balanced' found.
>
> Every double lock that can be reported is also a candidate, so the
> same reports are made as before and the output does not change. A
> report-mode run over every .c file in the tree produces identical
> output.

This is a good preformance improvement.  Thanks!

Applied.

julia

>
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> ---
>  scripts/coccinelle/locks/double_lock.cocci | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/coccinelle/locks/double_lock.cocci b/scripts/coccinelle/locks/double_lock.cocci
> index 619cfc714409..381060849a7b 100644
> --- a/scripts/coccinelle/locks/double_lock.cocci
> +++ b/scripts/coccinelle/locks/double_lock.cocci
> @@ -38,7 +38,20 @@ write_lock@p1
>  write_trylock@p1
>  ) (E1@p,...);
>
> -@balanced@
> +@r_candidate exists@
> +expression x <= locked.E1;
> +expression locked.E1;
> +expression E2;
> +identifier lock;
> +position locked.p,p1,p2;
> +@@
> +
> +lock@p1 (E1@p,...);
> +... when != E1
> +    when != \(x = E2\|&x\)
> +lock@p2 (E1,...);
> +
> +@balanced depends on r_candidate@
>  position p1 != locked.p1;
>  position locked.p;
>  identifier lock,unlock;
> --
> 2.43.0
>
>
