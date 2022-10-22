Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC13FC433FE
	for <cocci@archiver.kernel.org>; Sat, 22 Oct 2022 08:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=Sslxsy1JjvplCE5PnQoeBurBKSDdSOBSi5WPPLqL67A=;
  b=DPsOuu8HSay3k0RhbmTOK9UF+5a9xfSMs7AO3gRmGe1Piz1JSCotmz8f
   MsoAM6AYG1nBRdPMZRoewXmkSPX6JZXC+IsZ6jmn8Jyv6/BrZymrwF83+
   mpD4k03WOnJa3SCeep0oQJwWYXtpZGpCSwkWQU4E1CgG6PE7ngBn9JjXr
   g=;
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
X-IronPort-AV: E=Sophos;i="5.95,204,1661810400"; 
   d="scan'208";a="67851845"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Oct 2022 10:03:54 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9414BE0152; Sat, 22 Oct 2022 10:03:53 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id A08FEE004E
	for <cocci@sympa.inria.fr>; Sat, 22 Oct 2022 10:03:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Sslxsy1JjvplCE5PnQoeBurBKSDdSOBSi5WPPLqL67A=;
  b=YOCD/yFhi1YMVGg9g4UWGtsFiRtBYnSwn2zuCDpX6kHcQsGAtSuZJVWr
   Oe/Zulmqvsgq2U4++oBXg5zku6z1CewcapoRe99ddLr/aSxV92gT8z0Ha
   XW/hW0VXDKnHZVaAvlE7BOE+EvV1GYzWdeZpZM/rrJ5TNw3twAEqjvfYH
   g=;
X-IronPort-AV: E=Sophos;i="5.95,204,1661810400"; 
   d="scan'208";a="33150971"
Received: from 51.123.68.85.rev.sfr.net (HELO hadrien) ([85.68.123.51])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2022 10:03:51 +0200
Date: Sat, 22 Oct 2022 10:03:50 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
cc: cocci@inria.fr
In-Reply-To: <CAHmME9p7nTuAOS87NYKhbhh1rF-XJBkuWjjmHbrkiJUrth5XHQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2210221003070.2700@hadrien>
References: <CAHmME9rTWvUxsM-sFZh1r+D5gb-8rbHmeWiFEfobkjxDRrZO1Q@mail.gmail.com> <alpine.DEB.2.22.394.2210200705030.2988@hadrien> <CAHmME9p7nTuAOS87NYKhbhh1rF-XJBkuWjjmHbrkiJUrth5XHQ@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] "not supported"
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 661
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
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/alpine.DEB.2.22.394.2210221003070.2700%40hadrien>



On Fri, 21 Oct 2022, Jason A. Donenfeld wrote:

> Hi Julia,
>
> On Thu, Oct 20, 2022 at 1:11 AM Julia Lawall <julia.lawall@inria.fr> wrote:
> > Maybe you have an old version of Coccinelle?  For a long time do while was
> > not supported.  But it's supported now, and your rule seemed to work fine
> > for me.
>
> Bingo, that worked. Thanks. Might consider cutting a new release soon
> so that that's available on OPAM. I built it myself for the latest.

Yes, I'll try to do that soon.

>
> I just sent these in:
> https://lore.kernel.org/lkml/20221022014403.3881893-5-Jason@zx2c4.com/
>
> I wound up just having a bunch of different instances, rather than
> trying to teach Coccinelle about strange equivalences.
>
> There's another one in that series that's kind of interesting:
>
> https://lore.kernel.org/lkml/20221022014403.3881893-6-Jason@zx2c4.com/
>
> This one has a very simple rule:
>
> @@
> expression H;
> expression L;
> @@
> - (get_random_u32_below(H) + L)
> + get_random_u32_between(L, H + L)
>
> This worked as expected, but I had to do a lot of hand simplification.
> For example, a lot of code had a pattern of:
>
> get_random_u32_below(H - L + 1) + L
>
> which then got converted into
>
> get_random_u32_between(L, H - L + 1 + L)
>
> which I then had to clean up manually into
>
> get_random_u32_between(L, H + 1)
>
> It's not like that's all that hard to do. But it would be cool if
> Cocinnelle had some sort of algebraic simplification possibility.

Maybe it's a bit special case for Coccinelle.  If there were many
recurring cases you could make extra rules.

julia
