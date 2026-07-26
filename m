Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB65C531F9
	for <cocci@archiver.kernel.org>; Sun, 26 Jul 2026 16:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=fQ7wY/c69mDre3E5Gfwi5LSSIgrgeeygssFa4FGlijw=;
  b=u0YyareJzd9Be1BHCN44GiM1vZHwryRTb2rRB/mUlYTTrMzR6InBrkz5
   dr0HFwzfL46x76tGB5bG0IE4qd3NY2RW4JdklXGAlT/+GSYjObaWu07Yp
   yQMxYaF3k4UU1otTPiRCFO0jcA+L9DCMRvpaBWgbkZEFKDJv3WWwatt2G
   I=;
X-CSE-ConnectionGUID: LxTvNUDmQkeUC2SPlz4GLg==
X-CSE-MsgGUID: jhrWHBqCRdy6DmNZVZGFGg==
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
X-IronPort-AV: E=Sophos;i="6.25,186,1779141600"; 
   d="scan'208";a="287946900"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Jul 2026 18:11:14 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 76212812F3; Sun, 26 Jul 2026 18:11:14 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 2036780F2D
	for <cocci@sympa.inria.fr>; Sun, 26 Jul 2026 18:11:06 +0200 (CEST)
X-CSE-ConnectionGUID: 9bxL3jCkTAGERKsUuEW6Sg==
X-CSE-MsgGUID: 1GqJNy7PSuGt9a/NIp+F2Q==
X-IronPort-AV: E=Sophos;i="6.25,186,1779141600"; 
   d="scan'208";a="287946891"
Received: from 88-188-149-159.subs.proxad.net (HELO hadrien.home) ([88.188.149.159])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2026 18:11:06 +0200
Date: Sun, 26 Jul 2026 18:11:05 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
cc: Julia Lawall <Julia.Lawall@inria.fr>, 
    Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr, 
    linux-kernel@vger.kernel.org
In-Reply-To: <20260725113303.691676-4-ekffu200098@gmail.com>
Message-ID: <f16e75db-2e5a-81c6-76b5-dcd0583f2f8b@inria.fr>
References: <20260725113303.691676-1-ekffu200098@gmail.com> <20260725113303.691676-4-ekffu200098@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [PATCH 3/3] coccinelle: misc: minmax: improve
 performance when no candidate exists
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3662
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/w7fj64iqjY5QEs2Xd1a0OQ>



On Sat, 25 Jul 2026, Sang-Heon Jeon wrote:

> The rules that report an opencoded min() or max() search every
> function body, even when the file contains nothing to find.
>
> To avoid this, collect the candidates first and run the search only
> when one exists. A candidate is any conditional expression whose
> condition is a comparison.
>
> Every opencoded min() or max() is also a candidate, so the same
> opportunities are reported as before and the output does not
> change. A report-mode run over every .c file in the tree produces
> identical output.

Applied.

I also added "candidate" rules for minif and maxif, removed the outer
parentheses on rmax etc, and disabled some isomorphisms that caused the
introduction of useless variants of the conditional tests.

julia


>
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> ---
>  scripts/coccinelle/misc/minmax.cocci | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
>
> diff --git a/scripts/coccinelle/misc/minmax.cocci b/scripts/coccinelle/misc/minmax.cocci
> index ca4830ae3042..93c074b9439f 100644
> --- a/scripts/coccinelle/misc/minmax.cocci
> +++ b/scripts/coccinelle/misc/minmax.cocci
> @@ -17,7 +17,21 @@ virtual org
>  virtual context
>  virtual patch
>
> -@rmax depends on !patch@
> +@max_candidate@
> +expression E1, E2, E3, E4;
> +binary operator cmp = {>, >=};
> +@@
> +
> +	(E1 cmp E2 ? E3 : E4)
> +
> +@min_candidate@
> +expression E1, E2, E3, E4;
> +binary operator cmp = {<, <=};
> +@@
> +
> +	(E1 cmp E2 ? E3 : E4)
> +
> +@rmax depends on !patch && max_candidate@
>  identifier func;
>  expression x, y;
>  binary operator cmp = {>, >=};
> @@ -51,7 +65,7 @@ func(...)
>  }
>
>  // Ignore errcode returns.
> -@errcode@
> +@errcode depends on min_candidate@
>  position p;
>  identifier func;
>  expression x;
> @@ -65,7 +79,7 @@ func(...)
>  	...>
>  }
>
> -@rmin depends on !patch@
> +@rmin depends on !patch && min_candidate@
>  identifier func;
>  expression x, y;
>  binary operator cmp = {<, <=};
> @@ -98,7 +112,7 @@ func(...)
>  	...>
>  }
>
> -@pmax depends on patch@
> +@pmax depends on patch && max_candidate@
>  identifier func;
>  expression x, y;
>  binary operator cmp = {>=, >};
> @@ -131,7 +145,7 @@ func(...)
>  	...>
>  }
>
> -@pmin depends on patch@
> +@pmin depends on patch && min_candidate@
>  identifier func;
>  expression x, y;
>  binary operator cmp = {<=, <};
> --
> 2.43.0
>
>
