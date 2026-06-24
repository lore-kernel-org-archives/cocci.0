Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 487DBCDB479
	for <cocci@archiver.kernel.org>; Wed, 24 Jun 2026 17:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=jRYcjXWetLM2iI5Bj0lMnHKhPtsWHztUHyuM98LC3DE=;
  b=ZQZnpqAEpFQIbYuHRGQeMWQ3BJ5CW+MJgu0Fgzj/ehALy/m844gwlkYj
   +oPm9+r8fZNu8+S/ZCXJ5hqatOU169W6An1qFmvnRdv6dK2/jZ5DE/QFh
   an1VPJXAfjaJr9OSOjEjs46+Mle9YR80viDfAFcERFQw2H0qZv0DUe5AY
   w=;
X-CSE-ConnectionGUID: sdDA7du4Stu3lpS8N942fQ==
X-CSE-MsgGUID: l6qIt3kZQ/+HwXHw5cQDwg==
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
X-IronPort-AV: E=Sophos;i="6.24,222,1774306800"; 
   d="scan'208";a="283248050"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jun 2026 19:25:53 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 7ABD781CE8; Wed, 24 Jun 2026 19:25:53 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id CC00E81CC6
	for <cocci@sympa.inria.fr>; Wed, 24 Jun 2026 19:25:51 +0200 (CEST)
X-CSE-ConnectionGUID: wfoyA//uRqOVzVv3S49qRg==
X-CSE-MsgGUID: 4KNeUs82SdOyxJQf12Zqdg==
X-IronPort-AV: E=Sophos;i="6.24,222,1774306800"; 
   d="scan'208";a="283248040"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 19:25:51 +0200
Date: Wed, 24 Jun 2026 19:25:51 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Joe Perches <joe@perches.com>
cc: Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
    Kees Cook <kees@kernel.org>, driver-core@lists.linux.dev, 
    Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr
In-Reply-To: <50755b746bb30bea3989db9c1f262d5257e8ee1e.camel@perches.com>
Message-ID: <dc6cfcc-4ec4-8b87-19c3-974818448b8c@inria.fr>
References: <eed0c57a2c897e34d411229c3de41c5402791894.1781575297.git.joe@perches.com> <50755b746bb30bea3989db9c1f262d5257e8ee1e.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [PATCH] coccinelle: Add devm_kmalloc_objs conversion
 script
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3587
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-06/0P32_UkyEZFAJ47Fw2U3PQ>



On Wed, 24 Jun 2026, Joe Perches wrote:

> On Mon, 2026-06-15 at 19:10 -0700, Joe Perches wrote:
> > Like commit bdc5071d7f7b ("coccinelle: Add kmalloc_objs conversion script")
> > with commit 1c7bbaeed110 ("coccinelle: kmalloc_obj: Remove default GFP_KERNEL arg")
> >
> > Finds and converts sized devm_kmalloc-family of allocations into the typed
> > devm_kmalloc_obj-family of allocations.
>
> Its been a bit.
> Any comments or negatives about using or running this script?
>
> This script would change more than 8000 instances in more than
> 5000 files in Linus' current master.

I was going to try it this evening.  Are you concerned that it is too
much?

julia

>
> $ spatch -D patch --very-quiet --cocci-file ./scripts/coccinelle/api/devm_kmalloc_objs.cocci \
>     --include-headers-for-types --all-includes --include-headers --keep-comments \
>     -I ./arch/x86/include -I ./arch/x86/include/generated -I ./include \
>     -I ./arch/x86/include/uapi -I ./arch/x86/include/generated/uapi -I ./include/uapi \
>     -I ./include/generated/uapi --include ./include/linux/compiler-version.h \
>     --include ./include/linux/kconfig.h .
>
