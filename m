Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B32C531FA
	for <cocci@archiver.kernel.org>; Sun, 26 Jul 2026 14:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=pyc3KV0c7uGPUeGy6S3ZUZkAIvd9XcbGhm5meX3RCeI=;
  b=WpQ30pynkAEFLBXBs+1Igxg4cbtpQ430eNxUQdKCB60AhGit9NNU5HYg
   jBijtSqPgpO8h0Bf3kIA6TFSzbrYsJWaSlBcqf6HuljMZoAB1RR+Nqy+5
   09wcVtf6v6aLKJGgRuS/HoXH1nyqDLpaFKikxqUDq1icBc8SSdpzpT0Fa
   8=;
X-CSE-ConnectionGUID: RqSVyrCRT6q+C6MwNjf9zQ==
X-CSE-MsgGUID: ilvhs25pQIOuv46iKMddxA==
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
   d="scan'208";a="287941446"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Jul 2026 16:14:14 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 809B080187; Sun, 26 Jul 2026 16:14:14 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 4616F80587
	for <cocci@sympa.inria.fr>; Sun, 26 Jul 2026 16:14:08 +0200 (CEST)
X-CSE-ConnectionGUID: /xG0f2sLQzePhI5X6mmUBg==
X-CSE-MsgGUID: LTOgu4PjRlCerVEP8pT2SQ==
X-IronPort-AV: E=Sophos;i="6.25,186,1779141600"; 
   d="scan'208";a="152972072"
Received: from 88-188-149-159.subs.proxad.net (HELO hadrien.home) ([88.188.149.159])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2026 16:14:08 +0200
Date: Sun, 26 Jul 2026 16:14:07 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: Sang-Heon Jeon <ekffu200098@gmail.com>, cocci@inria.fr, 
    Nicolas Palix <nicolas.palix@imag.fr>, LKML <linux-kernel@vger.kernel.org>, 
    kernel-janitors@vger.kernel.org
In-Reply-To: <c5a73800-59cd-4870-ae57-11fe832054b9@web.de>
Message-ID: <c720b3c1-ac9a-2bf1-545-2d649b41ac5@inria.fr>
References: <20260725113303.691676-2-ekffu200098@gmail.com> <c5a73800-59cd-4870-ae57-11fe832054b9@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1864106738-1785075247=:181691"
Subject: Re: [cocci] [PATCH 1/3] coccinelle: mini_lock: improve performance
 when searching loops
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3661
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/EuO2F84kb-688P0Y2BaXBg>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1864106738-1785075247=:181691
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sun, 26 Jul 2026, Markus Elfring wrote:

> …
> > +++ b/scripts/coccinelle/locks/mini_lock.cocci
> > @@ -53,11 +53,31 @@ spin_lock_irq@p1
> >  spin_lock_irqsave@p1
> >  ) (E1@p,...);
> >
> > -@looped@
> > +@err_candidate exists@
> > +expression E1;
> > +position prelocked.p;
> > +position up != prelocked.p1;
> > +position rc;
> …
>
> Can it help a bit to avoid the repetition of the type
> for a few metavariables?
>
> +position prelocked.p, up != prelocked.p1, rc;

It's fine as is.

julia
--8323329-1864106738-1785075247=:181691--
