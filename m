Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54F6AC9830E
	for <cocci@archiver.kernel.org>; Sun, 27 Sep 2026 09:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=2aoFxEgokmQWGqINNJ7vIW0aKYOBVkbBsEmmrHIq0y4=;
  b=FZ7YfR9+sVczULyeNZIdi+9Caj/KxXfh0c8eELayTRKmvA8XahC2P1Qx
   N38GIidJasugC65qfRXZX7hTuJ1NDuxPUqq1YehKFGUOfscWCh9szwbJ/
   Qu36GfHK4VjL55TafEHSsvu7pRDtFZe+pjx6NtLFZ/hhWsaUNWg8X2YkG
   w=;
X-CSE-ConnectionGUID: ydIRDY5PSzi5djxQ/P8R9A==
X-CSE-MsgGUID: dBkQgiUmTyOfzz2xFE6qiA==
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
X-IronPort-AV: E=Sophos;i="6.27,126,1787004000"; 
   d="scan'208";a="297133167"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Sep 2026 11:21:59 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 1112581329; Sun, 27 Sep 2026 11:21:59 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 4A56081329
	for <cocci@sympa.inria.fr>; Sun, 27 Sep 2026 11:21:55 +0200 (CEST)
X-CSE-ConnectionGUID: jy8MPurzT/ehz4YEmId2qw==
X-CSE-MsgGUID: pPI13OtRQ9+LBqdG32oU4w==
X-IronPort-AV: E=Sophos;i="6.27,126,1787004000"; 
   d="scan'208";a="158107121"
Received: from 88-188-149-159.subs.proxad.net (HELO hadrien.home) ([88.188.149.159])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2026 11:21:55 +0200
Date: Sun, 27 Sep 2026 11:21:54 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Alejandro Colomar <alx@kernel.org>
cc: cocci@inria.fr, Markus Elfring <Markus.Elfring@web.de>, 
    Kees Cook <kees@kernel.org>, Nicolas Palix <nicolas.palix@imag.fr>
In-Reply-To: <arLXllXUgeG7jdpw@debian>
Message-ID: <127f7c71-6ab7-5b4-2540-2e2dc3313a@inria.fr>
References: <arLXllXUgeG7jdpw@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [PATCH v3 (resend)] scripts/coccinelle: Add script for
 using ARRAY_END()
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3741
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-09/odgNMYreM9eQNUuel6NSMQ>



On Tue, 22 Sep 2026, Alejandro Colomar wrote:

> Recently, we added an ARRAY_END() macro to simplify finding a pointer
> one past the last element in an array.  Such a pointer is often called
> the 'end', and thus the macro name.
>
> Make it easy to find more places where that macro should be used.
>
> See also:
> 436debc9cad8 ("array_size.h: add ARRAY_END()")
> 8118f197b7b7 ("mm: fix benign off-by-one bugs")
> a9e5620c9a9e ("kernel: fix off-by-one benign bugs")
> 61e9210e2392 ("mm: use ARRAY_END() instead of open-coding it")
>
> Cc: Kees Cook <kees@kernel.org>
> Cc: Markus Elfring <Markus.Elfring@web.de>
> Cc: Julia Lawall <Julia.Lawall@inria.fr>
> Cc: Nicolas Palix <nicolas.palix@imag.fr>
> Signed-off-by: Alejandro Colomar <alx@kernel.org>
> ---
>
>
> Hi Julia,
>
> Resent the patch now, as you asked me to do.

Applied, thanks.

Afterwards, I made two changes:

    * Add disable zero_multiple_format to each rule to avoid considering
    the possibility that an array index is expressed using '\0'

    * Omit outer parentheses on context and org/report rules that
    only match ubt don't transform, since matching a subterm gives
    the same result whether or not the parentheses are present.

julia


>
>
> Cheers,
> Alex
>
> Here's the original message that came with the patch:
>
> Hi!
>
> This v3 only has one change: I've removed the comment about the false
> negatives.  They were due to spatch(1) not being able to correctly parse
> unrelated code elsewhere.
>
> See range-diff and interdiff at the bottom.
>
>
> Have a lovely night!
> Alex
>
>  scripts/coccinelle/misc/array_end.cocci | 73 +++++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 scripts/coccinelle/misc/array_end.cocci
>
> diff --git a/scripts/coccinelle/misc/array_end.cocci b/scripts/coccinelle/misc/array_end.cocci
> new file mode 100644
> index 00000000..88c664de
> --- /dev/null
> +++ b/scripts/coccinelle/misc/array_end.cocci
> @@ -0,0 +1,73 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/// Use ARRAY_END instead of an expression derived from ARRAY_SIZE
> +//
> +// Confidence: High
> +// Copyright: 2026, Alejandro Colomar <alx@kernel.org>
> +// Options: --no-includes --include-headers
> +
> +virtual patch
> +virtual context
> +virtual org
> +virtual report
> +
> +@depends on context@
> +type T;
> +T[] a;
> +expression b;
> +@@
> +(
> +* (a + ARRAY_SIZE(a))
> +|
> +* (&a[0] + ARRAY_SIZE(a))
> +|
> +* (&a[ARRAY_SIZE(a)])
> +|
> +* (&a[ARRAY_SIZE(a) - b])
> +)
> +
> +@depends on patch@
> +type T;
> +T[] a;
> +expression b;
> +@@
> +(
> +- (a + ARRAY_SIZE(a))
> ++ ARRAY_END(a)
> +|
> +- (&a[0] + ARRAY_SIZE(a))
> ++ ARRAY_END(a)
> +|
> +- (&a[ARRAY_SIZE(a)])
> ++ ARRAY_END(a)
> +|
> +- (&a[ARRAY_SIZE(a) - b])
> ++ ARRAY_END(a) - b
> +)
> +
> +@r depends on org || report@
> +type T;
> +T[] a;
> +expression b;
> +position p;
> +@@
> +(
> + (a@p + ARRAY_SIZE(a))
> +|
> + (&a[0]@p + ARRAY_SIZE(a))
> +|
> + (&a[ARRAY_SIZE(a)]@p)
> +|
> + (&a[ARRAY_SIZE(a)@p - b])
> +)
> +
> +@script:python depends on org@
> +p << r.p;
> +@@
> +
> +coccilib.org.print_todo(p[0], "WARNING should use ARRAY_END")
> +
> +@script:python depends on report@
> +p << r.p;
> +@@
> +
> +coccilib.report.print_report(p[0], "WARNING: opportunity for ARRAY_END")
>
> Range-diff:
> 1:  9fd8d3d1 ! 1:  2ae22f8b scripts/coccinelle: Add script for using ARRAY_END()
>     @@ scripts/coccinelle/misc/array_end.cocci (new)
>      +//
>      +// Confidence: High
>      +// Copyright: 2026, Alejandro Colomar <alx@kernel.org>
>     -+// Comments: No known false positives, but has a few false negatives
>      +// Options: --no-includes --include-headers
>      +
>      +virtual patch
> --
> 2.53.0
>
>
> ----- End forwarded message -----
>
> --
> <https://www.alejandro-colomar.es>
>
