Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3190EFCE2A
	for <cocci@archiver.kernel.org>; Wed,  4 Mar 2026 18:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=tIaogVIbP8D2dLcQhX2aETJ9WugLqsR1PpfGz4qGQJ4=;
  b=PC7jesDqssYwJ7lTvWAOkKBzlUhMERn/3Kqv31hvZarrJ34hKKQdpZqs
   rlz5mSQEYFqzLBM1puM9qH+pHK96hTndzbmSA4YxBPxiE/32A5a6VOg/W
   b4nMW+i9cqRsG9Lw5Q0vxSpNDq21E7SkOcPV9G4G3vVXWiWzFMpPQ2P9H
   I=;
X-CSE-ConnectionGUID: 8wuWlCb8QMWvtsmh+W/AWQ==
X-CSE-MsgGUID: j/lBVf3TSQyXtLDSqQuvwQ==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
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
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.21,324,1763420400"; 
   d="scan'208";a="266270095"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Mar 2026 19:12:15 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 3FB10838EC; Wed,  4 Mar 2026 19:12:14 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 5393482B5C
	for <cocci@sympa.inria.fr>; Wed,  4 Mar 2026 19:12:11 +0100 (CET)
X-CSE-ConnectionGUID: SzMtzBrMT4mgNAluvk797Q==
X-CSE-MsgGUID: aq3KADA9SZ25MMIcwkuLZA==
X-IronPort-AV: E=Sophos;i="6.21,324,1763420400"; 
   d="scan'208";a="140429267"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 19:12:11 +0100
Date: Wed, 4 Mar 2026 19:12:10 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Philipp Hahn <phahn-oss@avm.de>
cc: cocci@inria.fr
In-Reply-To: <726546e758862eac541526151f085401756edc64.1772645314.git.p.hahn@avm.de>
Message-ID: <b186181-f4ef-4af9-20e8-862c926e1cce@inria.fr>
References: <726546e758862eac541526151f085401756edc64.1772645314.git.p.hahn@avm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [RFC] Coccinelle: Use IS_ERR_OR_NULL
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3322
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/gjGfHg5PH6EN2qTUOvdPYQ>



On Wed, 4 Mar 2026, Philipp Hahn wrote:

> Hello,
>
> after a colleague of mine recently gave a talk about Coccinelle, I had look
> myself and created the below semantic patch to find and convert uses of
> IS_ERR() plus NULL check to IS_ERR_OR_NULL() in the Linux kernel.
>
> On 7.0.0-rc2 the patch applies to 79 files and finds most places I identified
> manually. Fantastic!
>
> There are some cases where the checks are part of a larger expression:
> - mm/kmemleak.c:1095
> - mm/kmemleak.c:1155
> - mm/kmemleak.c:1173
> - mm/kmemleak.c:1290
> - mm/kmemleak.c:1328
> - mm/kmemleak.c:1241
> - mm/kmemleak.c:1310
> - mm/kmemleak.c:1258
> - net/mac80211/tx.c:4831
> - net/netlink/af_netlink.c:2670
> - security/keys/internal.h:367
> So far I've been unable to teach Coccinelle to also generate patches for
> these. Is there some easy solution to fix my patch to also handle those cases?

The problem is the associativity of && which is not what you would hope
for in these cases.  You can write:

@@
expression e,e1;
@@

- e1 && e && !IS_ERR(e)
+ e1 && !IS_ERR_OR_NULL(e)

It doesn't catch net/mac80211/tx.c:4831 and security/keys/internal.h:367
though, which are different from the others.

>
> There are several cases where `!ptr && WARN_ON[_ONCE](IS_ERR(ptr))` is
> used; they are not found and changed.
> - arch/x86/kernel/callthunks.c:215 WARN_ON_ONCE
> - drivers/clk/clk.c:4561 WARN_ON_ONCE
> - drivers/interconnect/core.c:793 WARN_ON
> - drivers/reset/core.c:718 WARN_ON
> I don't expect Cocinelle to create a patch there and would ask the maintainers,
> if they prefer the WARN_ON[_ONCE] to remain or would prefer changing it to
> IS_ERR_OR_NULL.

You can always make another rule that will do this.

> drivers/clocksource/mips-gic-timer.c:283 looks suspicious: ret != clk
> I'll ask the maintainer if this is on purpose or an error.
>
>
> How are new semantic patches normally handled:
> - are they first discussed on some mailing list?
> - should I then create the individual patches myself and send them to the
>   subsystem maintainers myself?
> - when should the semantic patch itself be included with the Linux kernel?

You can send semantic patches to whereever get_maintainer tells you to
send them.  It's nice to know when the semantic patch has led to patches
that have been accepted.

Thanks for trying Coccinelle.

julia

> Thank you for the feedback.
>
> Philipp Hahn
> ---
>  scripts/coccinelle/api/is_err_or_null.cocci | 86 +++++++++++++++++++++
>  1 file changed, 86 insertions(+)
>  create mode 100644 scripts/coccinelle/api/is_err_or_null.cocci
>
> diff --git a/scripts/coccinelle/api/is_err_or_null.cocci b/scripts/coccinelle/api/is_err_or_null.cocci
> new file mode 100644
> index 0000000000000..942ba95a206f9
> --- /dev/null
> +++ b/scripts/coccinelle/api/is_err_or_null.cocci
> @@ -0,0 +1,86 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +///
> +/// Use IF_ERR_OR_NULL() instead of IS_ERR() plus a check for (not) NULL
> +///
> +// Copyright: (C) 2026 Philipp Hahn, FRITZ! Technology GmbH.
> +// Confidence: Medium
> +// Options: --no-includes --include-headers
> +// Keywords: IS_ERR, IS_ERR_OR_NULL
> +
> +virtual patch
> +virtual report
> +virtual org
> +
> +@p1 depends on patch@
> +expression E;
> +@@
> +(
> +-	E != NULL && !IS_ERR(E)
> ++	!IS_ERR_OR_NULL(E)
> +|
> +-	E == NULL || IS_ERR(E)
> ++	!IS_ERR_OR_NULL(E)
> +|
> +-	!IS_ERR(E) && E != NULL
> ++	IS_ERR_OR_NULL(E)
> +|
> +-	IS_ERR(E) || E == NULL
> ++	IS_ERR_OR_NULL(E)
> +)
> +
> +@r1 depends on report || org@
> +expression E;
> +position p;
> +@@
> +(
> + 	E != NULL && ... && !IS_ERR@p(E)
> +|
> + 	E == NULL || ... || IS_ERR@p(E)
> +|
> + 	!IS_ERR@p(E) && ... && E != NULL
> +|
> + 	IS_ERR@p(E) || ... || E == NULL
> +)
> +
> +@script:python depends on report@
> +p << r1.p;
> +@@
> +coccilib.report.print_report(p[0], "opportunity for IS_ERR_OR_NULL()")
> +
> +@script:python depends on org@
> +p << r1.p;
> +@@
> +coccilib.org.print_todo(p[0], "opportunity for IS_ERR_OR_NULL()")
> +
> +@p2 depends on patch@
> +identifier I;
> +expression E;
> +@@
> +(
> +-	(I = E) != NULL && !IS_ERR(I)
> ++	!IS_ERR_OR_NULL((I = E))
> +|
> +-	(I = E) == NULL || IS_ERR(I)
> ++	IS_ERR_OR_NULL((I = E))
> +)
> +
> +@r2 depends on report || org@
> +identifier I;
> +expression E;
> +position p;
> +@@
> +(
> +*	(I = E) != NULL && ... && !IS_ERR@p(I)
> +|
> +*	(I = E) == NULL || ... || IS_ERR@p(I)
> +)
> +
> +@script:python depends on report@
> +p << r2.p;
> +@@
> +coccilib.report.print_report(p[0], "opportunity for IS_ERR_OR_NULL()")
> +
> +@script:python depends on org@
> +p << r2.p;
> +@@
> +coccilib.org.print_todo(p[0], "opportunity for IS_ERR_OR_NULL()")
> --
> 2.43.0
>
>
