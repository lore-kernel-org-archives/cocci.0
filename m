Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C367C38A2D
	for <cocci@archiver.kernel.org>; Mon, 24 Oct 2022 16:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=AI+Wj3cAshLSYogbdfK0+HkjiRJw5UKurNvankumEiQ=;
  b=DWzmvSLjHraw2yHoAyVzRr1cDberpyz4ozRHFV+aTqNxyIl5/La7k02t
   /LjI6PX3axxvjMcgYWHMLTC4+hgvd7UsOLGTAVsSYmosGRG3XQLn80Tvo
   Z4AdESPGknitXb17GO5H50dhPM3pPmXyuneuSYYBInz2dxrtC5SQVbDm9
   I=;
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
   d="scan'208";a="68152624"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Oct 2022 18:14:11 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7D027E01D1; Mon, 24 Oct 2022 18:14:11 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id A481DE004E
	for <cocci@sympa.inria.fr>; Mon, 24 Oct 2022 18:14:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=AI+Wj3cAshLSYogbdfK0+HkjiRJw5UKurNvankumEiQ=;
  b=AbhxfwPDQkudvGyTIw2H2+2rIaqbXMx0FVQmJId8jp2vM2PcViEle1Tl
   A3qZwMqPysPC9nhM8Y20f2EsAzCn+ixrb78WQLFvzS1wSOD3qWF/t20ZD
   OxS1IfMZ66mCrtmgQZNb+QoWOmmrYCo6Fwolm6/tjALxNbAST3GCzLy5H
   c=;
X-IronPort-AV: E=Sophos;i="5.95,209,1661810400"; 
   d="scan'208";a="33309697"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 18:14:06 +0200
Date: Mon, 24 Oct 2022 18:14:06 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, "Jason A. Donenfeld" <Jason@zx2c4.com>
In-Reply-To: <trinity-d4bcd599-1a10-4d96-b852-3ed8f3eafa19-1666617163749@3c-app-webde-bs11>
Message-ID: <1213192d-5f50-fea8-d68b-8c66c821d5b@inria.fr>
References: <CAHmME9rTWvUxsM-sFZh1r+D5gb-8rbHmeWiFEfobkjxDRrZO1Q@mail.gmail.com> <alpine.DEB.2.22.394.2210200705030.2988@hadrien> <CAHmME9p7nTuAOS87NYKhbhh1rF-XJBkuWjjmHbrkiJUrth5XHQ@mail.gmail.com> <trinity-3c34f082-c650-4c08-9ff9-f746f20e4183-1666533323595@3c-app-webde-bap48>
 <Y1WYWT0xU5hv1Gr9@zx2c4.com> <trinity-d4bcd599-1a10-4d96-b852-3ed8f3eafa19-1666617163749@3c-app-webde-bs11>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-253801203-1666628046=:3761"
Subject: Re: [cocci] algebraic simplification possibilities with SmPL
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 683
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/1213192d-5f50-fea8-d68b-8c66c821d5b%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-253801203-1666628046=:3761
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Mon, 24 Oct 2022, Markus Elfring wrote:

> > I can do something like that. These seem to work:
>
> I wonder about another error response from the software “Coccinelle 1.1.1”
> for an SmPL code variant like the following.

You can't make a disjunction like that.  The branches of a disjunction has
to be complete terms, not random strings of tokens.

julia


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
>  get_random_u32_between(L,
>   H
> (
> - - E
>   + F
> - + E
> |
> - + E
>   + F
> - - E
> |
> - - E
> - + E
> |
> - + E
> - - E
> )
>                        )
>
>
> linux@linux:…/Projekte/Coccinelle/Probe> spatch --parse-cocci suggestion3_for_Jason_Donenfeld-20221024.cocci
> …
> minus: parse error:
>   File "suggestion3_for_Jason_Donenfeld-20221024.cocci", line 12, column 0, charpos = 167
>   around = '(',
>   whole content = (
>
>
> Can such a test case trigger any further improvements for the advanced application
> of SmPL disjunctions?
>
> Regards,
> Markus
>
--8323329-253801203-1666628046=:3761--
