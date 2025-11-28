Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76E92CFD376
	for <cocci@archiver.kernel.org>; Fri, 28 Nov 2025 11:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=WrBnnZmvy78JnLBGVf1bAqyITUVdEMZuf901FD77s1M=;
  b=fXATTbOYNmTLBzeHwNHR16xN3DgXJsHithk2mmKeMDsw/2D9lpv3yYRU
   pdr32pWIvdnnRIKsRKfHr45CaZmmyBfLJzrUGrDxIa3GXCOF0yI0i6C1J
   XNedsnRoHtBoBlrdbrKeb1bM01DLqABRdHQt3LPzcSelryju1N2naq1ej
   g=;
X-CSE-ConnectionGUID: fOAOfsxfRjK79YTLjsIU5A==
X-CSE-MsgGUID: PcFdL7wtTpC0Zp66YlcUxA==
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.20,232,1758578400"; 
   d="scan'208";a="251756942"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Nov 2025 12:41:09 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CBF4DE0CD7; Fri, 28 Nov 2025 12:41:09 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 545F6E0157
	for <cocci@sympa.inria.fr>; Fri, 28 Nov 2025 12:41:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=WrBnnZmvy78JnLBGVf1bAqyITUVdEMZuf901FD77s1M=;
  b=hpvFL+XWYYvIV2HwQyUWibNUJ4/dNpGu1daceMRSTXSCtLFmntKtZ6qo
   EhvKBpZIfx2fmqkJBu/vM7heZ7ITXxV0lRfl9qvrB95VgcTvMxV/zaiuj
   URp0kDtGDtzQaSjM213ENxeY3qwtv+BkzM9aCEvKx6QI5OW/71NMQsQG5
   E=;
X-CSE-ConnectionGUID: bH+Y7ol5RSadfm3HiHFung==
X-CSE-MsgGUID: DkJYFFeSS/iF5ZlEqCO2+w==
X-IronPort-AV: E=Sophos;i="6.20,232,1758578400"; 
   d="scan'208";a="251756922"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2025 12:41:05 +0100
Date: Fri, 28 Nov 2025 12:41:05 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <c5653e62-9d5d-4220-9c79-7750cb2ab647@web.de>
Message-ID: <7fcab8f9-1a55-3ba9-858f-6ed333ac9b4b@inria.fr>
References: <d08dc115-5c88-4545-8a77-b588382db1e7@web.de> <aa45d63e-bce0-47a7-b34f-434311ecd9ed@web.de> <6ab5b7b8-9655-67f2-4acd-e78c81e94ed@inria.fr> <c5653e62-9d5d-4220-9c79-7750cb2ab647@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-954031187-1764330065=:3739"
Subject: Re: [cocci] Data processing challenges with usage of not operators
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3201
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/7fcab8f9-1a55-3ba9-858f-6ed333ac9b4b%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-954031187-1764330065=:3739
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Fri, 28 Nov 2025, Markus Elfring wrote:

> >> How does the generated SmPL disjunction look after the software adjustment
> >> “avoid duplicates in disjunctions” (from 2025-11-23)?
> …>> How long will I wait until I can see a corresponding data processing result myself?
> > I have no idea what you are asking about.
>
> I find such a feedback strange.
>
>
> >                                            Can't you write --parse-cocci?
>
> I became curious about another recent software improvement.
> Some dependencies hinder me to build current software components myself.

I don't know what depdencies have changed, but if somethign has changed
that could be something to fix.

julia

>
>
> > Does it take too long to run?  There is no way I can debug a problem with
> > that without having your code.
>
> Under which circumstances would you become interested to take another look
> at information from this clarification approach?
> https://lore.kernel.org/cocci/d08dc115-5c88-4545-8a77-b588382db1e7@web.de/
> https://sympa.inria.fr/sympa/arc/cocci/2025-11/msg00056.html
>
> Regards,
> Markus
>
--8323329-954031187-1764330065=:3739--
