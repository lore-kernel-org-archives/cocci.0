Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE163F3C244
	for <cocci@archiver.kernel.org>; Mon,  9 Mar 2026 12:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=AWIGNcIzvb7iNDxlrolA7O0lOcBu+LNYktCT3HNi/44=;
  b=LfLvNzzDfqeWtM4tHPWIHLVOGtu/Cf9w1/Y766w36kvFRjdCBRznunc1
   wnshUlBxPyNLAX5yQsutK+XJwBesMJPkONxbV5zAjV3hqL9qJFwvo9v15
   ihKQ+LTokKn56R223aD1SrUYYXlnvYgqa4j5gcfGD4SsztpakFmnofk/Q
   0=;
X-CSE-ConnectionGUID: gpYUR4aMRnW9+eAu5ui2dA==
X-CSE-MsgGUID: /gERDchhRtiujuZYuez4WA==
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
   d="scan'208";a="266881663"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Mar 2026 13:21:28 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 655DA83090; Mon,  9 Mar 2026 13:21:28 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id AAA7683084
	for <cocci@sympa.inria.fr>; Mon,  9 Mar 2026 13:21:23 +0100 (CET)
X-CSE-ConnectionGUID: gNfqHJ8vSqOJgtBr0CW+2w==
X-CSE-MsgGUID: 3+Ykd1VWT1yVaC694jRg4A==
X-IronPort-AV: E=Sophos;i="6.23,109,1770591600"; 
   d="scan'208";a="266881645"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 13:21:23 +0100
Date: Mon, 9 Mar 2026 13:21:23 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Alejandro Colomar <alx@kernel.org>
cc: Markus Elfring <Markus.Elfring@web.de>, cocci@inria.fr, 
    Nicolas Palix <nicolas.palix@imag.fr>, LKML <linux-kernel@vger.kernel.org>, 
    kernel-janitors@vger.kernel.org, Kees Cook <kees@kernel.org>
In-Reply-To: <aa6vSvsp4J6InmiB@devuan>
Message-ID: <f950c541-1c21-7d5-b7d7-1a14bb6e8a4@inria.fr>
References: <cover.1772752564.git.alx@kernel.org> <f1c9dff525752dc5a839760269a1c96d6e0870b4.1772752564.git.alx@kernel.org> <cab3d2a8-4c3f-45e6-9e7f-8bdca48a6209@web.de> <aa6vSvsp4J6InmiB@devuan>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1865276325-1773058883=:9033"
Subject: Re: [cocci] [PATCH] scripts/coccinelle: Add script for using
 ARRAY_END()
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3355
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/zaGbOS8ZbA6sVIR4hBOkUw>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1865276325-1773058883=:9033
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Mon, 9 Mar 2026, Alejandro Colomar wrote:

> Hi Markus,
>
> On 2026-03-09T12:17:00+0100, Markus Elfring wrote:
> > …
> > > This script makes it easy to find more places where that macro should be
> > > used.
> >
> > See also:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v7.0-rc3#n94
>
> Thanks!
>
> > …
> > > +++ b/scripts/coccinelle/misc/array_end.cocci
> > > @@ -0,0 +1,93 @@
> > …
> >
> >
> > > +// Confidence: ???
> >
> > I hope that a more reasonable value can be determined for this information.
>
> I don't know how the scale works.  I know the script has a few false
> negatives, and AFAIK there are no false positives.  To what level of
> confidence would that belong?

Probably high would be fine.  The goal is mostly to indiacte whether the
results are most likely correct or whether they will require a lot of
study to know if everything is ok.

>
> Is that field a keyword, or may I be explicit such as with this?:
>
> // Confidence: no false positives, but a few false negatives
>
> Or maybe I should write that in Comments...
>
> > …
> > > +// Comments:
> >
> > Please omit such an empty field.
>
> Ok; thanks!
>
> $ grep -rh '^// Comments:' scripts/coccinelle/ | sort | uniq -c
>      34 // Comments:
>       2 // Comments: -
>       1 // Comments: -I ... -all_includes can give more complete results
>       1 // Comments: Comments on code can be deleted if near code that is removed.
>       1 // Comments: Some false positives on empty default cases in switch statements.
>       1 // Comments: requires at least Coccinelle 0.2.4, lex or parse error otherwise
> $ find scripts/coccinelle/ -type f | wc -l
> 76
>
>
> It seems around half of the existing scripts have that.  You may want to
> remove those empty comments.  I added it because the scripts I looked at
> do have it.

I don't require taht an empty comments field be removed.

> > …
> > > +@i@
> > > +@@
> > > +
> > > +#include <linux/kernel.h>
> >
> > I doubt that such an SmPL rule would be required.
>
> Okay, I'll remove it.  Thanks!

I'm lacking context.  You maye need this if the file doesn't already have
it.  But it is hard to know if it could be include indirectly...

julia


>
> > > +
> > > +//----------------------------------------------------------
> > > +//  For context mode
> > > +//----------------------------------------------------------
> > > +
> >
> > Please omit such extra comment lines.
>
> Agree.  BTW, you may want to remove such lines from existing scripts:
>
> $ grep -r '^//.*For context mode' scripts/coccinelle/
> scripts/coccinelle/null/deref_null.cocci:// For context mode
> scripts/coccinelle/misc/boolconv.cocci://  For context mode
> scripts/coccinelle/misc/array_size.cocci://  For context mode
> scripts/coccinelle/misc/struct_size.cocci://  For context mode
> scripts/coccinelle/misc/newline_in_nl_msg.cocci://  For context mode
> scripts/coccinelle/misc/badty.cocci://  For context mode
> scripts/coccinelle/api/alloc/pool_zalloc-simple.cocci://  For context mode
> scripts/coccinelle/api/alloc/zalloc-simple.cocci://  For context mode
> scripts/coccinelle/api/alloc/alloc_cast.cocci://  For context mode
> scripts/coccinelle/api/pm_runtime.cocci://  For context mode
> scripts/coccinelle/api/resource_size.cocci://  For context mode
> scripts/coccinelle/api/vma_pages.cocci://  For context mode
>
> > > +@depends on i&&context@
> > > +type T;
> > > +T[] a;
> > > +expression b;
> > > +@@
> > > +(
> > > +* (a + ARRAY_SIZE(a))
> > > +|
> > > +* (&a[0] + ARRAY_SIZE(a))
> > > +|
> > > +* (&a[ARRAY_SIZE(a)])
> > > +|
> > > +* (&a[ARRAY_SIZE(a) - b])
> > > +)
> >
> > Extra space characters may be omitted directly after SmPL asterisks.
>
> Good to know; thanks!
>
> Although most scripts seem to be using white space (space (164) or
> tab (26)) after the asterisk.  Please confirm if you prefer it removed
> in new scripts.  Only 39 scripts don't have white space after it.
>
> $ grep -rh '^\*' scripts/coccinelle/ | grep -o '^..' | sort | uniq -c
>      26 *
>     164 *
>       4 *(
>       1 *;
>       1 *E
>       1 *I
>       1 *P
>       2 *W
>       1 *\
>       1 *b
>       1 *c
>       3 *d
>       1 *e
>       4 *f
>       1 *g
>       2 *i
>       1 *l
>       4 *r
>       2 *s
>       1 *u
>       2 *w
>       5 *x
> $ grep -rh '^\*' scripts/coccinelle/ | grep -o '^.\s' | sort | uniq -c | hd
> 00000000  20 20 20 20 20 32 36 20  2a 09 0a 20 20 20 20 31  |     26 *..    1|
> 00000010  36 34 20 2a 20 0a                                 |64 * .|
> 00000016
> $ grep -rh '^\*' scripts/coccinelle/ | grep -o '^.\S' | wc -l
> 39
>
>
> > …
> > > +@r depends on (org || report)@
> >
> > You may omit parentheses here.
>
> Ok.
>
> > …
> > > +@script:python depends on report@
> > > +p << r.p;
> > > +@@
> > > +
> > > +msg="WARNING: Use ARRAY_END"
> > > +coccilib.report.print_report(p[0], msg)
> >
> > Would the following command variant be a bit nicer?
> >
> > coccilib.report.print_report(p[0], "WARNING: opportunity for ARRAY_END()")
>
> Sounds good.
>
> > By the way:
> > How do you think about to omit a cover letter for a single patch?
>
> Sounds reasonable.  I like the cover letter as it holds the range-diff,
> which may become a bit confusing when it's in the same email as the
> patch, but maybe that's just me.
>
> I'll send v2 in a single email.
>
> >
> > Regards,
> > Markus
>
> Have a lovely day!
> Alex
>
> --
> <https://www.alejandro-colomar.es>
>
--8323329-1865276325-1773058883=:9033--
