Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8607BC531C9
	for <cocci@archiver.kernel.org>; Sun, 26 Jul 2026 16:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=3K3nrIRuSQ6XAYt8X3n4dmHi0zxQfI7PovueChypdSI=;
  b=s2wv4cQZgg5qUL1smQq8/JSU/gnXjg7bNQ4L7wMYDrgzN+3kQ99JgAYo
   d2CLIiiqdhcLPcAMNcR6hUFRjBQNhXkRUHo251pPgZkxwENnT57PxWIJr
   98q3pkZuhavVjO2gaFEtGk7QFUGRjoGSknGK6iuQSDLGCbUAVwZjv/ubX
   k=;
X-CSE-ConnectionGUID: s1H5BL17SXCrRn98lx7O/g==
X-CSE-MsgGUID: 8H+lCYs7ROGfW46YGg8L1Q==
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
   d="scan'208";a="287948323"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Jul 2026 18:42:31 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 52CD5812FF; Sun, 26 Jul 2026 18:42:32 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id D4A7081305
	for <cocci@sympa.inria.fr>; Sun, 26 Jul 2026 18:42:25 +0200 (CEST)
X-CSE-ConnectionGUID: GgriX8r2S92QvGbgKNgBug==
X-CSE-MsgGUID: BzyMBQz3SKGmDFPhBjEaUA==
X-IronPort-AV: E=Sophos;i="6.25,186,1779141600"; 
   d="scan'208";a="287948307"
Received: from 88-188-149-159.subs.proxad.net (HELO hadrien.home) ([88.188.149.159])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2026 18:42:25 +0200
Date: Sun, 26 Jul 2026 18:42:25 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
cc: Julia Lawall <Julia.Lawall@inria.fr>, 
    Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr, 
    linux-kernel@vger.kernel.org
In-Reply-To: <20260725113303.691676-2-ekffu200098@gmail.com>
Message-ID: <36ca2127-3897-367-f184-2d673993891@inria.fr>
References: <20260725113303.691676-1-ekffu200098@gmail.com> <20260725113303.691676-2-ekffu200098@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [PATCH 1/3] coccinelle: mini_lock: improve performance
 when searching loops
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3663
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/zRPfZ1Tg4sg6aLAH_kKs_w>



On Sat, 25 Jul 2026, Sang-Heon Jeon wrote:

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
>
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> ---
>  scripts/coccinelle/locks/mini_lock.cocci | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/coccinelle/locks/mini_lock.cocci b/scripts/coccinelle/locks/mini_lock.cocci
> index 71065d8a5d54..54e06cced63b 100644
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
> +@looped depends on err_candidate@
> +position err_candidate.rc;

If the rule depends on a metavariable defined in err_candidate, then there
is no need for depends on err_candidate.

Also, I think this rule can be exists.

julia

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
