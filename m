Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B38EEC531FA
	for <cocci@archiver.kernel.org>; Fri, 24 Jul 2026 14:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=oOFJwSNj0Z4nVyQH8tvJ0RXrpmeOW2HtVJbrF0WUJXc=;
  b=MKgVOj6p6shh3H3uQX25HLGX+oqPeoXN3rjRIhk4xOrYnpo/E86kRAUI
   IR992tJlaT8jVVGVndultxWbqCaace4oczx0Ev/JWfPcRczVSZj268GAR
   ESU+nzFRp5afKYqVEbOZVPdLbsDupw8vMfZ52vx33nPfDdrCG4ut5Oz+e
   Y=;
X-CSE-ConnectionGUID: fEq7ZCzxRs+LRkipONdPNQ==
X-CSE-MsgGUID: iSqZxOegShupehyCalyLuQ==
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
X-IronPort-AV: E=Sophos;i="6.25,182,1779141600"; 
   d="scan'208";a="287799147"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jul 2026 16:55:44 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 483BA81A45; Fri, 24 Jul 2026 16:55:44 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 1A39981A2A
	for <cocci@sympa.inria.fr>; Fri, 24 Jul 2026 16:55:42 +0200 (CEST)
X-CSE-ConnectionGUID: L5yH1VKbSwq8fqaHcx35iA==
X-CSE-MsgGUID: XmK2LrNATZiDa962EkNrIQ==
X-IronPort-AV: E=Sophos;i="6.25,182,1779141600"; 
   d="scan'208";a="287799131"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 16:55:42 +0200
Date: Fri, 24 Jul 2026 16:55:42 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
cc: Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr, 
    linux-kernel@vger.kernel.org
In-Reply-To: <CABFDxMEuccFb2zPoA_Fdc6jswhqzMN62At9kEFqGBL5DZOj3DQ@mail.gmail.com>
Message-ID: <514fd536-291a-bfad-fac8-15e0d0611689@inria.fr>
References: <20260723184538.3888637-1-ekffu200098@gmail.com> <20260723184538.3888637-2-ekffu200098@gmail.com> <CABFDxMEuccFb2zPoA_Fdc6jswhqzMN62At9kEFqGBL5DZOj3DQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1189440701-1784904942=:3487"
Subject: Re: [cocci] [PATCH 01/36] coccinelle: misc: add
 cond_return_no_effect.cocci
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3647
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/Jzdyj0BWDracz2XHZSDSmg>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1189440701-1784904942=:3487
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Fri, 24 Jul 2026, Sang-Heon Jeon wrote:

> On Fri, Jul 24, 2026 at 3:45 AM Sang-Heon Jeon <ekffu200098@gmail.com> wrote:
> >
> > Add a new Coccinelle script which removes a conditional return that
> > has no effect:
> >
> >         if (ret)
> >                 return ret;
> >         return ret;
> >
> > Both branches return the same value, so the check can be removed.
> > The condition can also be a negation or a comparison with a
> > constant. Such code is usually a leftover from removing a
> > statement between the two returns.
> >
> > When a local variable is assigned right before the check, the
> > assignment and the two returns turn into a single return of the
> > assigned expression, and the declaration is dropped if nothing
> > else uses the variable. Otherwise only the check is removed.
> >
> > The fold can delete comments between the check and the final
> > return, so the generated patch should be reviewed.
> >
> > Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> > ---
> >  .../misc/cond_return_no_effect.cocci          | 121 ++++++++++++++++++
> >  1 file changed, 121 insertions(+)
> >  create mode 100644 scripts/coccinelle/misc/cond_return_no_effect.cocci
> >
> > diff --git a/scripts/coccinelle/misc/cond_return_no_effect.cocci b/scripts/coccinelle/misc/cond_return_no_effect.cocci
> > new file mode 100644
> > index 000000000000..541aafdc32c6
> > --- /dev/null
> > +++ b/scripts/coccinelle/misc/cond_return_no_effect.cocci
> > @@ -0,0 +1,121 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +///
> > +/// Remove a conditional return that has no effect:
> > +///
> > +///    if (ret)
> > +///            return ret;
> > +///    return ret;
> > +///
> > +/// Both branches return the same variable, so the check has no
> > +/// effect. It can also be a negation or a comparison with a
> > +/// constant.
> > +///
> > +/// When a local variable is assigned right before the check, the
> > +/// assignment and the two returns turn into a single return of the
> > +/// assigned expression, and the declaration is dropped if nothing
> > +/// else uses the variable. Otherwise only the check is removed.
> > +///
> > +// Such code is usually a leftover from removing a statement between
> > +// the two returns.
> > +//
> > +// Confidence: High
> > +// Copyright: (C) 2026 Sang-Heon Jeon
> > +// Comments: The fold can delete comments between the check and the
> > +//           final return, so review the generated patch.
> > +// Options: --no-includes --include-headers
> > +
> > +virtual patch
> > +virtual context
> > +virtual org
> > +virtual report
> > +
> > +//----------------------------------------------------------
> > +//  For patch mode
> > +//----------------------------------------------------------
> > +
> > +@collect depends on patch@
> > +identifier ret;
> > +expression E;
> > +binary operator cmp = {<, <=, >, >=, ==, !=};
> > +constant C;
> > +@@
> > +       ret = E;
> > +       if (\(ret \| !ret \| ret cmp C\))
> > +               return ret;
> > +       return ret;
> > +
> > +@depends on patch@
> > +local idexpression ret;
> > +expression E;
> > +binary operator cmp = {<, <=, >, >=, ==, !=};
> > +constant C;
> > +@@
> > +-      ret = E;
> > +-      if (\(ret \| !ret \| ret cmp C\))
> > +-              return ret;
> > +-      return ret;
> > ++      return E;
> > +
>
> If we can make these rules depend on an earlier rule, it should
> improve the performance a bit. I will look into whether it is
> worthwhile.

I don't see an opportunity for more efficiency for the above rules, but go
ahead if you have some idea.

>
> > +@depends on patch@
> > +idexpression ret;
> > +binary operator cmp = {<, <=, >, >=, ==, !=};
> > +constant C;
> > +@@
> > +-      if (\(ret \| !ret \| ret cmp C\))
> > +-              return ret;
> > +       return ret;
> > +
> > +@depends on patch@
> > +type T;
> > +identifier collect.ret;
> > +@@
> > +-      T ret;
> > +       ... when != ret
> > +           when strict
> > +
> > +@depends on patch@
> > +type T;
> > +identifier collect.ret;
> > +constant C;
> > +@@
> > +-      T ret = C;
> > +       ... when != ret
> > +           when strict
> > +
>
> While testing the script, I found that this rule can unexpectedly
> remove the declaration of a global or static variable in the same
> file, even when it is still used elsewhere. There is no such case in
> this series, but I will fix it in v2 by matching the declaration
> inside a function.

I think you could avoid matching the path from the top of the function to
the declaration by doing the following:

declaration D;
statement S;

(
- T ret = C
(
  D
|
  S
)
&
  T ret = C;
  ... when != ret
      when strict
)

The first part ensures that it is not a top-level declaration and the
second part does the check you had previously.

To ensure that it doesn't match "static T ret = C;" you can put the
following in the @depends on patch@:

disable optional_storage

julia


> fn(...) {
>       ...
> -     T ret;
>       ... when != ret
>           when strict
> }
>
> > +
> > +//----------------------------------------------------------
> > +//  For context mode
> > +//----------------------------------------------------------
> > +
> > +@depends on context@
> > +idexpression ret;
> > +binary operator cmp = {<, <=, >, >=, ==, !=};
> > +constant C;
> > +@@
> > +*      if (\(ret \| !ret \| ret cmp C\))
> > +*              return ret;
> > +       return ret;
> > +
> > +//----------------------------------------------------------
> > +//  For org and report mode
> > +//----------------------------------------------------------
> > +
> > +@r depends on org || report@
> > +idexpression ret;
> > +binary operator cmp = {<, <=, >, >=, ==, !=};
> > +constant C;
> > +position p;
> > +@@
> > +       if@p (\(ret \| !ret \| ret cmp C\))
> > +               return ret;
> > +       return ret;
> > +
> > +@script:python depends on org@
> > +p << r.p;
> > +@@
> > +cocci.print_main("WARNING: conditional return with no effect (both branches return the same value)", p)
> > +
> > +@script:python depends on report@
> > +p << r.p;
> > +@@
> > +coccilib.report.print_report(p[0], "WARNING: conditional return with no effect (both branches return the same value)")
> > --
> > 2.43.0
> >
>
--8323329-1189440701-1784904942=:3487--
