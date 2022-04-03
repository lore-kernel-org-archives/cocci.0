Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDE7EC433F5
	for <cocci@archiver.kernel.org>; Sun,  3 Apr 2022 08:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=VE6mxyPSr8bJeU1NOzROGvvgckNFR44+h/0foFoLlhw=;
  b=PYeU6kGDZlrki/YnoQc07NS8vL6TZsdtq9DHDUVdCkAZ+qnTstUyTqIb
   xY74uz08LdiFtlwsSmMk3FHgPdphM6+0QIL0qwIrIOR3m32L7bMoIuydr
   MFvPvvu6bxAcz6Ar/qo8+owX9hKLI+IoBNDfq4eWPWYvF9VTtqv5xvmyw
   8=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.90,231,1643670000"; 
   d="scan'208";a="29726854"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Apr 2022 10:04:37 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 25D60E033B; Sun,  3 Apr 2022 10:04:37 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 57332E00A8
	for <cocci@sympa.inria.fr>; Sun,  3 Apr 2022 10:04:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=VE6mxyPSr8bJeU1NOzROGvvgckNFR44+h/0foFoLlhw=;
  b=fUHmiOi8lArPp/t10TwHiAwyi13dM+wMeWY20VKxKDwWbz10Tk+EGi2Q
   OkneP4ufBcg1RgBxz4Sa6ejcrPGI9oO1wbQky6fZyUd8nAyai2S+WyNMR
   bJZyvr0gAGHYg1LUB816n3v4n3d0xWefGIjB6Dg120PFZs1uyHpiuI9AY
   8=;
X-IronPort-AV: E=Sophos;i="5.90,231,1643670000"; 
   d="scan'208";a="29726851"
Received: from 203.107.68.85.rev.sfr.net (HELO hadrien) ([85.68.107.203])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2022 10:04:33 +0200
Date: Sun, 3 Apr 2022 10:04:32 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Eric Wheeler <cocci@lists.ewheeler.net>
cc: Markus Elfring <Markus.Elfring@web.de>, cocci@inria.fr
In-Reply-To: <24fefed0-f544-ee40-f21d-6f50a3f1d76e@ewheeler.net>
Message-ID: <alpine.DEB.2.22.394.2204031002530.3114@hadrien>
References: <feae2a17-e570-e92-656b-3562fdaeb720@ewheeler.net> <300be2e3-15c8-712c-8e99-b2d91150d0d9@web.de> <24fefed0-f544-ee40-f21d-6f50a3f1d76e@ewheeler.net>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-313415723-1648973073=:3114"
Subject: Re: [cocci] Checking the handling of =?UTF-8?Q?=E2=80=9Cspace-del?=
 =?UTF-8?Q?imited=E2=80=9D?= string literals by SmPL
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 344
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-04/alpine.DEB.2.22.394.2204031002530.3114%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-313415723-1648973073=:3114
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sat, 2 Apr 2022, Eric Wheeler wrote:

> On Sat, 2 Apr 2022, Markus Elfring wrote:
> > > I've tried to do something like this, but it is invalid SmPL:
> > >
> > > 	@ p @
> > > 	expression list EL;
> > > 	constant FOO, C =~ "BUG";
> > > 	@@
> > > 	-printf(FOO C, EL);
> > > 	+BUG(C, EL);
> >
> >
> > Thanks for your interest in software adjustments also for this area.
> >
> >
> >
> > > Just ideas, I'm open to whatever you think is best for the project.
> >
> >
> > How do you think about to influence the evolution any further
> > also according to information from discussions around a topic like
> > “Adding metavariable types for the handling of string literals?”?
> > https://lore.kernel.org/cocci/alpine.DEB.2.22.394.2203271450370.3119@hadrien/
> > https://sympa.inria.fr/sympa/arc/cocci/2022-03/msg00140.html
>
> +1 for matching (and inserting/appending to) a series of quoted literals.
> I could have used that a few times recently and I don't know how to use
> cocci+python (yet!).

While such strings are surely useful, learning how to use python will be
even more useful to you in the short term.  Just look at the demos that
contain script:python.

julia
--8323329-313415723-1648973073=:3114--
