Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CFA3C38A2D
	for <cocci@archiver.kernel.org>; Mon, 24 Oct 2022 16:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=RYeaGjktg15FhINrUKGgzCNcOxHSbRh2YpOTcF4smfI=;
  b=OfdKGd3OIzUbi19N+XS5nuKAopod5wdRs06u4iEDclJav4t9Lj6rsMp6
   By3Bb8JVr74fEFTSTm2MwmJy7q/LJu69Y1EYcRLW0e+6oKlhUXVp/73hK
   rRb/4KILqyrdH6yrkaV7l2xwPw3TMSmw96bI5IIOGDzVvdJPMfWdH/TJ1
   k=;
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
X-IronPort-AV: E=Sophos;i="5.95,209,1661810400"; 
   d="scan'208";a="68156883"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Oct 2022 18:39:12 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7DE37E01D1; Mon, 24 Oct 2022 18:39:12 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id BEBCDE004E
	for <cocci@sympa.inria.fr>; Mon, 24 Oct 2022 18:39:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=RYeaGjktg15FhINrUKGgzCNcOxHSbRh2YpOTcF4smfI=;
  b=Y7PedRS+iOI09vSvHTE9CsQBxavfxu/KbYzr67XicxKY/Nymkq6xSpEQ
   hwA2+n6XpuQr3Hi9UWW4nJ2a93U+sgQ+AKGYGohebro3v1vrPRR97YJHc
   qVwSMBLa9+uV6fp7cdFBdtZcZKmOhMAts7WV23IyWsvE8PbP7Sa79DLrD
   k=;
X-IronPort-AV: E=Sophos;i="5.95,209,1661810400"; 
   d="scan'208";a="68156860"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 18:39:04 +0200
Date: Mon, 24 Oct 2022 18:39:04 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, cocci@inria.fr
In-Reply-To: <trinity-c55cc02f-abdf-476b-831f-51ab24af4a03-1666629039920@3c-app-webde-bs11>
Message-ID: <2d63639e-69c1-1864-cc79-97abafdd9efe@inria.fr>
References: <CAHmME9rTWvUxsM-sFZh1r+D5gb-8rbHmeWiFEfobkjxDRrZO1Q@mail.gmail.com> <alpine.DEB.2.22.394.2210200705030.2988@hadrien> <CAHmME9p7nTuAOS87NYKhbhh1rF-XJBkuWjjmHbrkiJUrth5XHQ@mail.gmail.com> <trinity-3c34f082-c650-4c08-9ff9-f746f20e4183-1666533323595@3c-app-webde-bap48>
 <Y1WYWT0xU5hv1Gr9@zx2c4.com> <trinity-c55cc02f-abdf-476b-831f-51ab24af4a03-1666629039920@3c-app-webde-bs11>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1852758465-1666629544=:3761"
Subject: Re: [cocci] algebraic simplification possibilities with SmPL
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 685
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/2d63639e-69c1-1864-cc79-97abafdd9efe%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1852758465-1666629544=:3761
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Mon, 24 Oct 2022, Markus Elfring wrote:

> > I can do something like that. These seem to work:
>
> The software “Coccinelle 1.1.1” gave me the impression that the following
> SmPL code variant can be acceptable.
>
>
> @replacement@
> expression H, L;
> @@
> -(get_random_u32_below(H) + L)
> +get_random_u32_between(L, H + L)
>
> @cleanup@
> expression H, L, E, F;
> @@
> (
>  get_random_u32_between
>  (L,
>   H
> - - E
>   + F
> - + E
>  )
> |
>  get_random_u32_between
>  (L,
>   H
> - + E
>   + F
> - - E
>  )
> |
>  get_random_u32_between
>  (L,
>   H
> - - E
> - + E
>  )
> |
>  get_random_u32_between
>  (L,
>   H
> - + E
> - - E
>  )
> )

That is fine.

julia

>
>
> Regards,
> Markus
>
--8323329-1852758465-1666629544=:3761--
