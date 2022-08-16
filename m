Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FE65C25B0E
	for <cocci@archiver.kernel.org>; Tue, 16 Aug 2022 11:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=822doZFBolVCnadmcuZVkXO81cnoOT7Fks4BFHnFkx0=;
  b=j4UCFN3ezF3FCCdS9PtoYcJDb42Bbd2+XkJrkXoIlpcXLQ4fLl1FhW00
   3fHI6OSecEOZ/fFTGuXS52L8PJ0Gdu6MFNDQRg0jenY/ojDasI7Rl8yJn
   zRulbp8Ez/tEEJeUMXTTrYQ4c5v7wKjbGhVazK5qP4yshKBV3kedwqiOA
   s=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.93,240,1654552800"; 
   d="scan'208";a="48896685"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Aug 2022 13:37:51 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 02AF7E0385; Tue, 16 Aug 2022 13:37:50 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id E2ACCE0380
	for <cocci@sympa.inria.fr>; Tue, 16 Aug 2022 13:37:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=822doZFBolVCnadmcuZVkXO81cnoOT7Fks4BFHnFkx0=;
  b=DC6cIXgZwIV+/U8cchpBeEJ+79r5quW7tuSAuVyhQbnOTkd4hHFh3pvn
   HZh02a0BY2YeWIHOwzVlThrQQzFTxGA+lAdxD1drcrW/dKC1gNg7enDNa
   Fc1x4IjJN//MjLr1K3MFNNCthyQdLtPilj2nqzanTUx6vphHYMWFUAb4p
   o=;
X-IronPort-AV: E=Sophos;i="5.93,240,1654552800"; 
   d="scan'208";a="48896677"
Received: from unknown (HELO hadrien) ([130.226.87.156])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 13:37:45 +0200
Date: Tue, 16 Aug 2022 13:37:45 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To: Jakob Koschel <jkl820.git@gmail.com>
cc: cocci@inria.fr, jkl820.misc@gmail.com
In-Reply-To: <20220816085416.1542114-1-jkl820.git@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2208161337001.2561@hadrien>
References: <20220816085416.1542114-1-jkl820.git@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] match arbitrary argument position
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 507
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-08/alpine.DEB.2.22.394.2208161337001.2561%40hadrien>



On Tue, 16 Aug 2022, Jakob Koschel wrote:

> Hi,
>
> sorry if this question is not suiting here.
>
> I went through the documentation and most of the examples I could find, but wasn't
> able to easily answer my question I'm wondering about.
>
> Basically: is there a way to match to *any* argument? E.g. make something match both of
> the 'x' uses in the function calls here:
>
> int x = 5;
>
> function_call1(x, 12, 12);
>
> function_call2(0, x);

f(...,x,...)

or

f(...,<+...x...+>,...)

In the second case, x would be a subexpression of the considered argument.

julia


>
>
>
> Based on that I was wondering if there is a way to say: match if the expression is
> within an expression list. So if I for instance have something like this:
>
>   @main@
>   type T;
>   parameter list P;
>   expression list E;
>   expression E1;
>   identifier func, func_call;
>   @@
>
>   T func(P@E) {
>     ...
>     func_call(E1 in E)
>     ...
>   }
>
> (above is not valid syntax of course)
>
> Ideally I would like to make and get the parameters of 'func' that are used in any position
> as arguments in 'func_call' if that makes sense?
>
>
> Any help is very much appreciated!
>
> Thanks,
> Jakob
>
