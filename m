Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA4CEF3718
	for <cocci@archiver.kernel.org>; Mon,  9 Mar 2026 11:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=7nNx4Iyc2/imBw5Tui/WljzGJuysqz2B4nsrBQSnvGI=;
  b=hITLdeHiV2F0u1yuswpoLdVJvbjuPvrSgcmavXTNCSorF4O8pVlZt21M
   4VGZvRSByI/+rxcMK6eOtvvDuOFC4mvTTFIHEbIgLNnXeqqKmNarww2wj
   Ud+e5tYdaHjx3FfybCWpPSZujrPE+ZDBZneeWswp75QiF0fPOj18Ah/wt
   c=;
X-CSE-ConnectionGUID: ewPtwWYKRJK5VsjjUEY0vw==
X-CSE-MsgGUID: yK+4M26CRGCGxmDQh1saOA==
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
X-IronPort-AV: E=Sophos;i="6.23,109,1770591600"; 
   d="scan'208";a="266876584"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Mar 2026 12:59:55 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 867048307C; Mon,  9 Mar 2026 12:59:55 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 4165083046
	for <cocci@sympa.inria.fr>; Mon,  9 Mar 2026 12:59:48 +0100 (CET)
X-CSE-ConnectionGUID: E4RQBa7yRuuOIViRAvxgaQ==
X-CSE-MsgGUID: ANJlQXodTZSLqBW6Aspzew==
X-IronPort-AV: E=Sophos;i="6.23,109,1770591600"; 
   d="scan'208";a="266876557"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 12:59:48 +0100
Date: Mon, 9 Mar 2026 12:59:48 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: Alejandro Colomar <alx@kernel.org>, cocci@inria.fr, 
    Nicolas Palix <nicolas.palix@imag.fr>, LKML <linux-kernel@vger.kernel.org>, 
    kernel-janitors@vger.kernel.org, Kees Cook <kees@kernel.org>
In-Reply-To: <cab3d2a8-4c3f-45e6-9e7f-8bdca48a6209@web.de>
Message-ID: <4aa2fc38-3c32-75a1-161-1c90709252be@inria.fr>
References: <cover.1772752564.git.alx@kernel.org> <f1c9dff525752dc5a839760269a1c96d6e0870b4.1772752564.git.alx@kernel.org> <cab3d2a8-4c3f-45e6-9e7f-8bdca48a6209@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1303160379-1773057588=:9033"
Subject: Re: [cocci] [PATCH] scripts/coccinelle: Add script for using
 ARRAY_END()
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3354
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/Iv2_HS7XmChE-6i0zV4z8Q>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1303160379-1773057588=:9033
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Mon, 9 Mar 2026, Markus Elfring wrote:

> …
> > This script makes it easy to find more places where that macro should be
> > used.
>
> See also:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v7.0-rc3#n94
>
>
> …
> > +++ b/scripts/coccinelle/misc/array_end.cocci
> > @@ -0,0 +1,93 @@
> …
>
>
> > +// Confidence: ???
>
> I hope that a more reasonable value can be determined for this information.
>
>
> …
> > +// Comments:
>
> Please omit such an empty field.
>
>
> …
> > +@i@
> > +@@
> > +
> > +#include <linux/kernel.h>
>
> I doubt that such an SmPL rule would be required.
>
>
> > +
> > +//----------------------------------------------------------
> > +//  For context mode
> > +//----------------------------------------------------------
> > +
>
> Please omit such extra comment lines.

No problem to put such comments.

>
>
> > +@depends on i&&context@
> > +type T;
> > +T[] a;
> > +expression b;
> > +@@
> > +(
> > +* (a + ARRAY_SIZE(a))
> > +|
> > +* (&a[0] + ARRAY_SIZE(a))
> > +|
> > +* (&a[ARRAY_SIZE(a)])
> > +|
> > +* (&a[ARRAY_SIZE(a) - b])
> > +)
>
> Extra space characters may be omitted directly after SmPL asterisks.

No concern about the spaces either.

>
>
> …
> > +@r depends on (org || report)@
>
> You may omit parentheses here.
>
>
> …
> > +@script:python depends on report@
> > +p << r.p;
> > +@@
> > +
> > +msg="WARNING: Use ARRAY_END"
> > +coccilib.report.print_report(p[0], msg)
>
> Would the following command variant be a bit nicer?
>
> coccilib.report.print_report(p[0], "WARNING: opportunity for ARRAY_END()")

Either way.

julia
--8323329-1303160379-1773057588=:9033--
