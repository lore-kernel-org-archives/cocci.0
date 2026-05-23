Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA274CD5BAC
	for <cocci@archiver.kernel.org>; Sat, 23 May 2026 18:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=YUaRTqqOrpJ2klSA+zdjVzXfn/WycJlm8gdHpwzBTV0=;
  b=huawjIisUZnW853QbVWHxfOWM2lNpPy5gsSjlB6Fyj87d59pYWQ9Tq8O
   4tk+Rxku6up9wiUSjB2GtGaGgz5GHWSf/wqDfi2NmWKnQuUY4vmpB7BDm
   QZlFzfvJ0MfTIo5u83nQxrDti7ck0QzlvQqSdNo+ISnuimpizjrV7rucV
   U=;
X-CSE-ConnectionGUID: 5mUNNH0HSKSqwkmvj8/lEw==
X-CSE-MsgGUID: GDEYp1DJSiW5wmtpydUbmw==
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
X-IronPort-AV: E=Sophos;i="6.24,164,1774306800"; 
   d="scan'208";a="277974854"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 May 2026 20:22:41 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id BCFA183AE9; Sat, 23 May 2026 20:22:40 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 3B79E83502
	for <cocci@sympa.inria.fr>; Sat, 23 May 2026 20:22:37 +0200 (CEST)
X-CSE-ConnectionGUID: nPhaUnldTIKZXEMEWQ7RaQ==
X-CSE-MsgGUID: 5naYgmGLQ+mTKm4GusrWtA==
X-IronPort-AV: E=Sophos;i="6.24,164,1774306800"; 
   d="scan'208";a="277974842"
Received: from 88-188-149-159.subs.proxad.net (HELO hadrien.home) ([88.188.149.159])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2026 20:22:37 +0200
Date: Sat, 23 May 2026 20:22:37 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr, vulab@iscas.ac.cn
In-Reply-To: <1da11354-3d73-4158-aa0b-98a143471a3b@web.de>
Message-ID: <dac0391-4aa-f02-f8fc-2168c118e3ef@inria.fr>
References: <47a6aeca-6c58-4be6-9a4e-a1d6726b5a0a@web.de> <8397220-4b66-acd4-32e2-cfa72ee7ac66@inria.fr> <25fb88dd-4573-4897-98ae-f5904a2324cd@web.de> <85a837b7-8a6-5fb8-eeb-1e70c5f77b2e@inria.fr> <1da11354-3d73-4158-aa0b-98a143471a3b@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2036864745-1779560557=:33802"
Subject: Re: [cocci] Checking evaluation of another SmPL script
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3507
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-05/sAdR90FwoiCtpOTEZFVxQA>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2036864745-1779560557=:33802
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sat, 23 May 2026, Markus Elfring wrote:

> >> Which data processing effects do you expect according to the program option “--no-loops”
> >> for the presented source code search pattern?
> >
> > I don't remember whether no loops looks at backward gotos.
>
> How will chances evolve to agree on corresponding information so that it can be integrated
> for a better software documentation?
>
>
> > Maybe try --no-gotos.
> Where is such a program parameter explained?

spatch --help.  Like all the other command line arguments.

julia


>
> Regards,
> Markus
>
--8323329-2036864745-1779560557=:33802--
