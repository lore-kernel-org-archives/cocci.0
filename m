Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69154C531CC
	for <cocci@archiver.kernel.org>; Sun, 26 Jul 2026 11:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=Iw6a9POFq4oLT+s9rMP0lNZc6Yx+SECwpjT/XmBv66M=;
  b=CLBTUx68zLI8W7hse7MDUZj15J0iwOSf0T+BY1le/XLqK1vZGezsxXcG
   Zr/KrkhftxZ4ZRaMUlhEcMwZL0kI1S/eXLPtLJF9zssEXILX20pDbAz2a
   yJT9RvTlFEyboI2nDgZwOiUG1HmU8QAvPPuXJfP3PFZCFPQsOEtSXp2hs
   k=;
X-CSE-ConnectionGUID: 5jm0spoeSa6EOqVw8DJJVA==
X-CSE-MsgGUID: UdqHdHFVRzuxAGRh5qFMVg==
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
   d="scan'208";a="287934746"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Jul 2026 13:54:40 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id D9642806AF; Sun, 26 Jul 2026 13:54:39 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id C07CB80187
	for <cocci@sympa.inria.fr>; Sun, 26 Jul 2026 13:54:34 +0200 (CEST)
X-CSE-ConnectionGUID: lsKbkF7BTxSjxP5t6bHM3w==
X-CSE-MsgGUID: SoiMi7c2SNGdfviQITj8fA==
X-IronPort-AV: E=Sophos;i="6.25,186,1779141600"; 
   d="scan'208";a="152967579"
Received: from 88-188-149-159.subs.proxad.net (HELO hadrien.home) ([88.188.149.159])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2026 13:54:35 +0200
Date: Sun, 26 Jul 2026 13:54:34 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, Sang-Heon Jeon <ekffu200098@gmail.com>, 
    Nicolas Palix <nicolas.palix@imag.fr>, LKML <linux-kernel@vger.kernel.org>, 
    kernel-janitors@vger.kernel.org
In-Reply-To: <077ae2e1-c471-4e87-9d40-caddd3a8a358@web.de>
Message-ID: <6a456a1a-3c5f-5514-486a-9e3f9d1361a4@inria.fr>
References: <20260723184538.3888637-1-ekffu200098@gmail.com> <20260723184538.3888637-2-ekffu200098@gmail.com> <CABFDxMEuccFb2zPoA_Fdc6jswhqzMN62At9kEFqGBL5DZOj3DQ@mail.gmail.com> <514fd536-291a-bfad-fac8-15e0d0611689@inria.fr>
 <077ae2e1-c471-4e87-9d40-caddd3a8a358@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1081996736-1785066874=:181691"
Subject: Re: [cocci] [1/36] coccinelle: misc: add
 cond_return_no_effect.cocci
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3660
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/ggDAbbGpB4ZISn-uUkXQ_w>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1081996736-1785066874=:181691
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sun, 26 Jul 2026, Markus Elfring wrote:

> >>> +@depends on patch@
> >>> +type T;
> >>> +identifier collect.ret;
> >>> +constant C;
> >>> +@@
> >>> +-      T ret = C;
> >>> +       ... when != ret
> >>> +           when strict
> >>> +
> >>
> >> While testing the script, I found that this rule can unexpectedly
> >> remove the declaration of a global or static variable in the same
> >> file, even when it is still used elsewhere. There is no such case in
> >> this series, but I will fix it in v2 by matching the declaration
> >> inside a function.
> >
> > I think you could avoid matching the path from the top of the function to
> > the declaration by doing the following:
> >
> > declaration D;
> > statement S;
> >
> > (
> > - T ret = C
> > (
> >   D
> > |
> >   S
> > )
> > &
> >   T ret = C;
> >   ... when != ret
> >       when strict
> > )
>
> I would appreciate to clarify such an approach for a bit of dead-code elimination
> in more detail.

I have no idea what you are talking about.  What dead code are you
referring to?

>
> I got the impression that some versions of the C programming language do
> not handle variable declarations also as “statements”.
> https://en.cppreference.com/c/language/statements
>
> See also:
> https://en.cppreference.com/cpp/language/statements#Declaration_statements

And the conclusion would be what?  First, Coccinelle has it's own parser.
It decides what is a statement, not some wikipedia page.

Second, Coccinelle does not consider declarations to be statements.
That's what the D is there for.

>
>
> > The first part ensures that it is not a top-level declaration and the
> > second part does the check you had previously.
>
> I do not see so far that the intended source code restriction would be explicitly
> expressed here.

No idea what this means.  What intended code restriction are you referring
to?

julia

> Will further software extensions become more helpful accordingly?
>
> Regards,
> Markus
>
--8323329-1081996736-1785066874=:181691--
