Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA03C5AC82
	for <cocci@archiver.kernel.org>; Mon, 10 Aug 2026 08:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=mxIoSspLF0iEf/XAuOZWwFg5TEA2l+KLGc9zFjZUVoQ=;
  b=V9OlcZapcVNjeY+9QOArjkXH5gyIYuCLLSJLFEEhxP2i/Jlldp29jkkl
   jfGunjQFBn56dFCtf0E2T/9ajEEpwbdaTL1Xyv/hHGfUhbWoPg/r4+nwF
   3W3wwW1pCgU6/2GKfVrG+Evq2En8bKBTwSGysPUpQBsYVQQe3tcAr3Wo6
   0=;
X-CSE-ConnectionGUID: Tqlee5fJQjOVtwX/ryiIlg==
X-CSE-MsgGUID: WoeoSKc9SNCAuAgy2fxKjA==
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
X-IronPort-AV: E=Sophos;i="6.25,215,1779141600"; 
   d="scan'208";a="289649085"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Aug 2026 10:03:48 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 1C9CE80FBA; Mon, 10 Aug 2026 10:03:48 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 76E1E80FBA
	for <cocci@sympa.inria.fr>; Mon, 10 Aug 2026 10:03:42 +0200 (CEST)
X-CSE-ConnectionGUID: d4iSUbhkRUu29EBrw0qVqQ==
X-CSE-MsgGUID: +glEG9i+QYexNMyMZvQrjA==
X-IronPort-AV: E=Sophos;i="6.25,215,1779141600"; 
   d="scan'208";a="153952796"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 10:03:42 +0200
Date: Mon, 10 Aug 2026 10:03:42 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Guru Das Srinagesh <linux@gurudas.dev>
cc: Nicolas Palix <nicolas.palix@imag.fr>, 
    Michael Turquette <mturquette@baylibre.com>, 
    Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org, 
    cocci@inria.fr, Brian Masney <bmasney@redhat.com>, 
    linux-clk@vger.kernel.org
In-Reply-To: <anlwF9n1KVaYcnH1@gurudas.dev>
Message-ID: <a5306584-b483-5ee-eada-e5efb8ea10a1@inria.fr>
References: <20260803-cocci-clk-register-v2-1-22e789f75f98@gurudas.dev> <b351e95-b3e5-b947-ccd3-64be2971e835@inria.fr> <anlwF9n1KVaYcnH1@gurudas.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [PATCH v2] coccinelle: Detect clk_register()
 anti-pattern
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3674
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-08/5fxFCUvlJytFMV9RQCbeXQ>

> > > +@depends on context@
> > > +expression clk;
> > > +identifier voidfn =~ "^(dev_err|dev_warn|pr_err|pr_warn)$";
> > > +@@
> > > +
> > > +clk = \(clk_register\|devm_clk_register\)(...);
> > > +if ( IS_ERR(clk) )
> > > +{
> > > +...
> > > +*voidfn(...);
> > > +...
> > > +}
> >
> > This will only match an if with a then branch, no else branch.  There is
> > actually one case in the kernel where there is a relevant if with an else
> > branch, so you may as well extend this to match that cas too.  If you just
> > add else S, where S is a statement metavariable that is not used
> > elsewhere, then it will match either the case with an else or the case
> > with a then branch only.
> >
> > Likewise for the other rules.
>
> Done, thank you for catching the edge case which I'm guessing is
> drivers/media/platform/microchip/microchip-isc-clk.c.

Yes, that's the one.

julia
