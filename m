Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13133C25B0E
	for <cocci@archiver.kernel.org>; Tue, 16 Aug 2022 21:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=APrq6QtboxrmriyF9xtrzXE/9gaG/UZMzJg5C73Gd5A=;
  b=YCc4kRDl2b0o17YANkdd+yWyBWs1PJKwUjjcGTgM0bGp9kP6xrlFuq21
   2ke69FA2wGvlpXIrg5peTzzaeQIqXINAd4idPdZG+rh5mnCdiT2NlAorI
   fiuntZxMBQZyM/ozS8flCWOuLsk4yIl/v2oDBk3pWOgpoAJF81O0EDysj
   Q=;
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
X-IronPort-AV: E=Sophos;i="5.93,242,1654552800"; 
   d="scan'208";a="48944953"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Aug 2022 23:07:54 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E86A5E0382; Tue, 16 Aug 2022 23:07:53 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 87F53E0380
	for <cocci@sympa.inria.fr>; Tue, 16 Aug 2022 23:07:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=APrq6QtboxrmriyF9xtrzXE/9gaG/UZMzJg5C73Gd5A=;
  b=r2aYVD+CZbGBZRKbo1zrKm6w/f+VF5hf7odnbZ6uGht8+in+KD/K72Am
   2Ig6YaPbz29haP8nEoKoD0vfciaY5lTxCcjXNYYKiE3QFCd7qVk+85C7H
   9uwB6HPwfJN+sYGfqnaKM/rQFlUv6IjvoiFQx/YA7NRUQbyBfIjPDhMWv
   o=;
X-IronPort-AV: E=Sophos;i="5.93,242,1654552800"; 
   d="scan'208";a="21388011"
Received: from unknown (HELO hadrien) ([95.166.247.26])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 23:07:52 +0200
Date: Tue, 16 Aug 2022 23:07:44 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To: Jakob Koschel <jkl820.git@gmail.com>
cc: cocci@inria.fr
In-Reply-To: <29F3BFF3-ADB0-4E8C-BE30-298D0ABB8F1A@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2208162306410.2625@hadrien>
References: <20220816085416.1542114-1-jkl820.git@gmail.com> <alpine.DEB.2.22.394.2208161337001.2561@hadrien> <29F3BFF3-ADB0-4E8C-BE30-298D0ABB8F1A@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] match arbitrary argument position
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 510
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-08/alpine.DEB.2.22.394.2208162306410.2625%40hadrien>

> >> Based on that I was wondering if there is a way to say: match if the expression is
> >> within an expression list. So if I for instance have something like this:
> >>
> >>  @main@
> >>  type T;
> >>  parameter list P;
> >>  expression list E;
> >>  expression E1;
> >>  identifier func, func_call;
> >>  @@
> >>
> >>  T func(P@E) {
> >>    ...
> >>    func_call(E1 in E)
> >>    ...
> >>  }
> >>
> >> (above is not valid syntax of course)
> >>
> >> Ideally I would like to make and get the parameters of 'func' that are used in any position
> >> as arguments in 'func_call' if that makes sense?
>
> Do you have any idea regarding the expression lists?
>
> looking at the following code snippet:
>
> test.c:
>
>    int func1(int argc, char *argv) {
>       func2(argc, argv);
>
>       func3(argc, argv);
>
>       func3(argv);
>    }
>
> what works is (only matches the first func3 call):
>
>    @main4@
>    expression list Es;
>    @@
>
>    func2(Es)
>
>    @main5@
>    expression list main4.Es;
>    identifier func;
>    @@
>
>      func(Es);
>    + // add comment
>
>
> what doesn't work (matching on the expression list from the parameter list):
>
>    @main4@
>    expression list Es;
>    @@
>
>    int func1(Ps@Es) {
>    ...
>    }
>
>    @main5@
>    expression list main4.Es;

Could you try

expression list main4.Ps;

It may transform the parameters into a list of expressions.

julia

>    identifier func;
>    @@
>
>      func(Es);
>    + // add comment
>
>
> Ideally I would like to 'find' all parameters used in a function call,
> I also tried this:
>
>    @main4@
>    parameter P;
>    expression E;
>    @@
>
>    int func1(..., P@E, ...) {
>    ...
>    }
>
>    @main5@
>    expression main4.E;
>    identifier func;
>    @@
>
>      func(..., E, ...);
>    + // add comment
>
>
> But it throws: 'rule starting on line 41 contains unattached metavariables: main4.E'.
>
> Any idea, why e.g. the second one doesn't work? If I print it with python the expression list
> looks the same as for the first one.
> Also in the end this boils down to: is it possible to match to any of the expression list elements?
>
> Thanks,
> Jakob
>
> >>
> >>
> >> Any help is very much appreciated!
> >>
> >> Thanks,
> >> Jakob
>
>
