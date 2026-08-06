Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA6FFC56208
	for <cocci@archiver.kernel.org>; Thu,  6 Aug 2026 21:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=vr2BTIxHyPqlCzr3Wz8UeqgAuTTu21C1/8oyIkJX+bM=;
  b=D7pnmRL6KrrWcD1rMGiUt+66HIMmsYsw/irkrBR03VIZaD9M3vsgIqVc
   H2PMvgV82MW1K+4RzlhesV2y+3QYWFJU4KoT+ZGgFRt4wRt5UWVE+k5VS
   k0cFegA/vC9MQK52RjkoAo9QIUJq2T9rSWM0K+vLYkgUxm4nHIxQ8PWBn
   k=;
X-CSE-ConnectionGUID: sUuoFrEKS7mzctZK77HchA==
X-CSE-MsgGUID: USj6WB3SSo2i31Inr53irw==
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
X-IronPort-AV: E=Sophos;i="6.25,209,1779141600"; 
   d="scan'208";a="289370437"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Aug 2026 23:14:20 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 2A2AB818C9; Thu,  6 Aug 2026 23:14:20 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id D244680FBD
	for <cocci@sympa.inria.fr>; Thu,  6 Aug 2026 23:14:13 +0200 (CEST)
X-CSE-ConnectionGUID: MuNc9Ye8TTeM3ZGwlopQ+A==
X-CSE-MsgGUID: egy0GkLbQymhii/cUS4eSQ==
X-IronPort-AV: E=Sophos;i="6.25,209,1779141600"; 
   d="scan'208";a="153781456"
Received: from 88-188-149-159.subs.proxad.net (HELO hadrien.home) ([88.188.149.159])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 23:14:13 +0200
Date: Thu, 6 Aug 2026 23:14:13 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
cc: Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr, 
    linux-kernel@vger.kernel.org
In-Reply-To: <20260727135249.1634580-1-ekffu200098@gmail.com>
Message-ID: <ee2d8872-4b8f-8ea0-282-51a3e5591ffa@inria.fr>
References: <20260727135249.1634580-1-ekffu200098@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [PATCH v2] coccinelle: mini_lock: improve performance
 when searching loops
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3668
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-08/xiOndIjjGDHEi82rsj9TJA>



On Mon, 27 Jul 2026, Sang-Heon Jeon wrote:

> The 'looped' rule collects the returns inside a for loop to
> prevent 'err' from reporting them. It searches every for loop in
> the file, and on files with large loop bodies the search explodes.
>
> For example, kernel/bpf/verifier.c runs for over 200 seconds,
> almost entirely in 'looped' according to --profile. Since the
> kernel .cocciconfig sets a 200 second timeout, coccicheck silently
> skips the file.
>
> To avoid this, collect the candidate returns first, so that
> 'looped' checks only those positions. 'err' then excludes what
> 'looped' found.
>
> Every return that 'err' can report is also a candidate, so the
> same returns are excluded as before and the output does not change.
> A report-mode run over every .c file in the tree produces identical
> output.
>
> So verifier.c now finishes well within the timeout, in a few
> seconds.

Thanks for the fixes.  Applied.

julia

>
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> ---
> Changes from v1 [1]
> - remove unnecessary depends keyword as Julia suggested
> - add exists keyword to 'looped' rule
>
> [1] https://lore.kernel.org/all/20260725113303.691676-2-ekffu200098@gmail.com/
> ---
>  scripts/coccinelle/locks/mini_lock.cocci | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/coccinelle/locks/mini_lock.cocci b/scripts/coccinelle/locks/mini_lock.cocci
> index 71065d8a5d54..c65241c895ff 100644
> --- a/scripts/coccinelle/locks/mini_lock.cocci
> +++ b/scripts/coccinelle/locks/mini_lock.cocci
> @@ -53,11 +53,31 @@ spin_lock_irq@p1
>  spin_lock_irqsave@p1
>  ) (E1@p,...);
>
> -@looped@
> +@err_candidate exists@
> +expression E1;
> +position prelocked.p;
> +position up != prelocked.p1;
> +position rc;
> +identifier lock,unlock;
> +@@
> +
> +lock(E1@p,...);
> +... when != E1
> +    when any
> +if (...) {
> +  ... when != E1
> +  return@rc ...;
> +}
> +... when != E1
> +    when any
> +unlock@up(E1,...);
> +
> +@looped exists@
> +position err_candidate.rc;
>  position r;
>  @@
>
> -for(...;...;...) { <+... return@r ...; ...+> }
> +for(...;...;...) { <+... return@rc@r ...; ...+> }
>
>  @err exists@
>  expression E1;
> --
> 2.43.0
>
>
