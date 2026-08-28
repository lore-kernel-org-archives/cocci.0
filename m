Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 278C1C61DCB
	for <cocci@archiver.kernel.org>; Fri, 28 Aug 2026 14:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=ehTcZZHGYHICoMybqWSzwAd6F9OVvnlKBiWTIUGdtys=;
  b=X3koXJFWYu3JtFxeJY6qPrIryjxZZi8xpZd/6x2A2+fvgxwrrgyd6k/m
   BZrrlpp/Yn8eAnUrhvSVohebD2CKhqJ8wOlgMGLlOERj6952+RGF5+SIg
   6L0xpCW7iTzDqS5QcVqFSQ/hx2gjAih88RSEIdiak/WRnf5sRQ0NNKf+k
   g=;
X-CSE-ConnectionGUID: gdWMABRHTwSzStCmDpN4LQ==
X-CSE-MsgGUID: ZH6TSkodQzGays77gSgDLw==
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
X-IronPort-AV: E=Sophos;i="6.25,248,1779141600"; 
   d="scan'208";a="292045902"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Aug 2026 16:59:39 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 72B2781882; Fri, 28 Aug 2026 16:59:39 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 1DD0B80E4A
	for <cocci@sympa.inria.fr>; Fri, 28 Aug 2026 16:59:36 +0200 (CEST)
X-CSE-ConnectionGUID: Gu/TdZFIRFmZJaQPNLkw2A==
X-CSE-MsgGUID: uHQ7BBZZRfKsT2wnfqlR2g==
X-IronPort-AV: E=Sophos;i="6.25,248,1779141600"; 
   d="scan'208";a="155313810"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 16:59:37 +0200
Date: Fri, 28 Aug 2026 16:59:35 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, kernel-janitors@vger.kernel.org
In-Reply-To: <b2fd77fe-fc97-412e-a5d1-69b88e27f61b@web.de>
Message-ID: <47b6b35-2cfc-b5e-f96-8ec6548cd9@inria.fr>
References: <9e729258-a720-4b8f-b0f0-e84f3a984aef@web.de> <a0b9259-987b-1c92-2e86-3409ecf87e@inria.fr> <b2fd77fe-fc97-412e-a5d1-69b88e27f61b@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2146134731-1787929175=:104528"
Subject: Re: [cocci] Improving support for deleting selected macro calls
 with SmPL
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3721
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-08/xoL5h7FBH3jEG1FlM8U91g>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2146134731-1787929175=:104528
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Fri, 28 Aug 2026, Markus Elfring wrote:

> >> Another SmPL script example:
> >> @deletion@
> >> @@
> >> -READ_ONCE(dev->mtu)
> >>
> >>
> >> Questionable test result:
> >> Markus_Elfring@Sonne:…/Projekte/Coccinelle/janitor> spatch --parse-cocci delete_READ_ONCE_for_mtu.cocci
> >> …
> >> invalid minus starting on line 3
> >
> > You can't simply delete an expression.  The resulting code would not be
> > valid. …
> How do you think about to improve the error message anyhow?
>
>
> > The problemn has nothing to do with READ_ONCE being a macro.  It occurs
> > for any expression.
>
> I got the impression that some expression parts would be replaceable.

If you expected it to be replaced, you have to specify with what.

julia
--8323329-2146134731-1787929175=:104528--
