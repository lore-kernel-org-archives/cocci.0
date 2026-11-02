Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A25A606A336
	for <cocci@archiver.kernel.org>; Mon,  2 Nov 2026 09:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=O3pVsg/f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=IYFW2lTOpyKjEnXh2uR1HGY+0FKkCifbwuEO2xZ7rNE=;
  b=O3pVsg/fR8sv7vXfdDZKQ0PpfzqHqJeVO2r6Zl/4X8jAG1GVTQJSVjr5
   /N940Lzvr5OLtEVZBaSRHirBaZ1Det+GEtui7C+oCSvDcygsenA1FirB4
   sqdxpTkRhkyCVcduzK9llXHk2Ak0vSELiyzfiS7p3jzvsKBwTdS62Ox7f
   o=;
X-CSE-ConnectionGUID: UR4sJvi4TMKDA4Qwx4Nk8A==
X-CSE-MsgGUID: 9sLVGlHZR/Wp+Olj9zZupw==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.27 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:128.93.162.27 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.27,191,1787004000"; 
   d="scan'208";a="303298726"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Nov 2026 10:09:27 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 84A08819CA; Mon,  2 Nov 2026 10:09:27 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 65ED0819B7
	for <cocci@sympa.inria.fr>; Mon,  2 Nov 2026 10:09:21 +0100 (CET)
X-CSE-ConnectionGUID: ozxKcFvfTKausaSb0UebIw==
X-CSE-MsgGUID: SEgQBXdrT0O1xls2NlHySQ==
X-IronPort-AV: E=Sophos;i="6.27,191,1787004000"; 
   d="scan'208";a="303298693"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 10:09:21 +0100
Date: Mon, 2 Nov 2026 10:09:21 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Kees Cook <kees@kernel.org>
cc: Joe Perches <joe@perches.com>, Greg KH <gregkh@linuxfoundation.org>, 
    linux-kernel@vger.kernel.org, 
    Linus Torvalds <torvalds@linux-foundation.org>, 
    driver-core@lists.linux.dev, Nicolas Palix <nicolas.palix@imag.fr>, 
    cocci@inria.fr
In-Reply-To: <E7A57F75-AB90-4B41-B942-55D65F2B65D8@kernel.org>
Message-ID: <c47392bc-e522-19b6-a653-1e85b44cefba@inria.fr>
References: <9b55b3e3269ef43ede64fff34f42121f7aa47979.camel@perches.com> <1a6026c4-3e19-a1a9-e637-f1842172482b@inria.fr> <E7A57F75-AB90-4B41-B942-55D65F2B65D8@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [resend PATCH] coccinelle: Add devm_kmalloc_objs
 conversion script
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3761
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-11/t5_kWfw5YtZNVPDc5QBKVw>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On Mon, 2 Nov 2026, Kees Cook wrote:

>
>
> On November 1, 2026 3:51:53 PM PST, Julia Lawall <julia.lawall@inria.fr> wrote:
> >
> >
> >On Sun, 1 Nov 2026, Joe Perches wrote:
> >
> >> Like commit bdc5071d7f7b ("coccinelle: Add kmalloc_objs conversion script")
> >> with commit 1c7bbaeed110 ("coccinelle: kmalloc_obj: Remove default GFP_KERNEL arg")
> >>
> >> Finds and converts sized devm_kmalloc-family of allocations into the typed
> >> devm_kmalloc_obj-family of allocations.
> >
> >Applied
>
> Please don't send this. I already did this. See the PR I sent for rc1:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=for-linus/v7.4-rc1/devm_kmalloc_obj

Too late.

julia

>
>
> --
> Kees Cook
>
