Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE2BAC43458
	for <cocci@archiver.kernel.org>; Thu,  2 Jul 2026 00:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=0djR5b+fDbWKriqa7QNOFjzBhDKvc8M5TtzuS/kiVjA=;
  b=ow0zIcsjrC7h/MtUSCK6cAZUHye7nT2R3wKqoN5U8gW2WUO9qH6FIqaM
   x+IPLgo6e1eznCtbnorDEzPI5k1xSMOj5CQ5+evjJ6hD/6jfRPL19LqFH
   1bPkWWYtRUUbCmUtBe4IYNM75jLNKk+Lvki9aEAtDiaLmU1QvhxRxsQ00
   c=;
X-CSE-ConnectionGUID: qKAiQHBqRkOkOP7laiV/gg==
X-CSE-MsgGUID: lcD4bUosRBC6X0t5owdZ6A==
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
X-IronPort-AV: E=Sophos;i="6.25,142,1779141600"; 
   d="scan'208";a="284459792"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Jul 2026 02:35:30 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 3EE6681ECA; Thu,  2 Jul 2026 02:35:30 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id DD59780FDC
	for <cocci@sympa.inria.fr>; Thu,  2 Jul 2026 02:35:24 +0200 (CEST)
X-CSE-ConnectionGUID: Z9mzzeGYSB61H2fKKospgw==
X-CSE-MsgGUID: Xb8KBRTKSPuki7baq1z0rA==
X-IronPort-AV: E=Sophos;i="6.25,142,1779141600"; 
   d="scan'208";a="151032485"
Received: from c-76-123-3-53.hsd1.va.comcast.net (HELO hadrien) ([76.123.3.53])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 02:35:24 +0200
Date: Wed, 1 Jul 2026 20:35:20 -0400 (EDT)
From: Julia Lawall <julia.lawall@inria.fr>
To: Joe Perches <joe@perches.com>
cc: Julia Lawall <Julia.Lawall@inria.fr>, cocci@inria.fr
In-Reply-To: <ca5bdfaf3b5f4a785bccccd910c7c04c33089e13.camel@perches.com>
Message-ID: <2a6c1fd-f546-8bab-59ba-3430195a41a4@inria.fr>
References: <20260630190843.3563858-1-liam@infradead.org>  <20260630190843.3563858-17-liam@infradead.org> <ca5bdfaf3b5f4a785bccccd910c7c04c33089e13.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Possible cocci test & that should be |
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3591
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/Nf6H0NKFNsOvAOebO18mmA>



On Wed, 1 Jul 2026, Joe Perches wrote:

> Hi Julia.
>
> A suggestion for a possible (new?) test.
>
> On Tue, 2026-06-30 at 15:08 -0400, Liam R. Howlett (Oracle) wrote:
> > The GFP flags in two tests are obviously incorrect.  Make the tests
> > correctly run by updating the GFP flags.
> > Link: [https://lore.kernel.org/all/d9cbb89faa5bdb71d451781d214a51ce8923a83e.camel@perches.com/](https://lore.kernel.org/all/d9cbb89faa5bdb71d451781d214a51ce8923a83e.camel@perches.com/)
> > Reported-by: Joe Perches <[joe@perches.com](mailto:joe@perches.com)>
> []
> > diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
> []
> > @@ -35234,7 +35234,7 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
> > -	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL & GFP_NOWAIT) == 0);
> > +	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_NOWAIT) == 0);
>
> Is it possible for cocci to find uses of enums/constants
> that are anded together where the result is a likely
> unintentional 0 where presumably the & should be an | ?

The only & on named constants I found was:

sound/soc/codecs/aw88261.c:
reg_val &= (AW88261_AMPPD_MASK & AW88261_PWDN_MASK & AW88261_HMUTE_MASK);

This looks ok, because there are a lot of uses of ~ in the definitions.

julia
