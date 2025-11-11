Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1F8CCCFA1A
	for <cocci@archiver.kernel.org>; Tue, 11 Nov 2025 20:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=gYX4r+iCZz/IjvQkCG0OTljzQbpsqklSp+4MJdu2lc0=;
  b=K3MT8NteO5/eba4sirfuor37zHNlKbzSQht/ykm8BysGDHMjf3uJx+nT
   kkKJKrPmW9c2dX3uztF8bfdG7YU4zC8k4Ao4mMdgUyB0a0uP8G624XaEd
   Jgqrx+Sfww1b3tryrNWDGjZgMZE15tZNscjrWwzA9i+3stl0AZevC8q8/
   M=;
X-CSE-ConnectionGUID: /vvDklL0QrWQNgedJ8SfoQ==
X-CSE-MsgGUID: 8BbFi++FTCuQw+kuEz1yIg==
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
X-IronPort-AV: E=Sophos;i="6.19,297,1754949600"; 
   d="scan'208";a="248623194"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Nov 2025 21:41:13 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 06EB3E0B0D; Tue, 11 Nov 2025 21:41:13 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 2D025E0171
	for <cocci@sympa.inria.fr>; Tue, 11 Nov 2025 21:41:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=gYX4r+iCZz/IjvQkCG0OTljzQbpsqklSp+4MJdu2lc0=;
  b=U522YtNn1SGgc7xw9NnkStjfF8xlywOl14FAU7ipGoK1NtkA1O6f+91t
   3YG9d9TAerlHGjY6BuSjNDGyco6KdmH+V5pNZjvZN22pV83OZAB6Oz2W4
   lqgsnUWK4BFLeD6wh1e5EatvzY4JTJoozoqN2FDmmqInjnQZEFH1UrEEE
   o=;
X-CSE-ConnectionGUID: nytXkHaCTxG+gLaAfNiQvA==
X-CSE-MsgGUID: LKFrETXAT2SCGE0MfCTtzw==
X-IronPort-AV: E=Sophos;i="6.19,297,1754949600"; 
   d="scan'208";a="248623191"
Received: from 74-95-99-105-richmond.hfc.comcastbusiness.net (HELO hadrien) ([74.95.99.105])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 21:41:10 +0100
Date: Tue, 11 Nov 2025 15:41:08 -0500 (EST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <92736910-a93f-4a91-9356-f6f6c1aebd8b@web.de>
Message-ID: <3177bcc9-773-393d-edf4-8fb67a59115@inria.fr>
References: <ca1862a2-8a84-49b8-bbfd-fca9f15c6787@web.de> <c5aa7f4a-4efc-5384-3295-823dea0ea10@inria.fr> <92736910-a93f-4a91-9356-f6f6c1aebd8b@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-743573379-1762893670=:3437"
Subject: Re: [cocci] Checking SmPL support for two special expressions
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3165
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/3177bcc9-773-393d-edf4-8fb67a59115%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-743573379-1762893670=:3437
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Tue, 11 Nov 2025, Markus Elfring wrote:

> …>> -( uint64_t ) * ( ( uint64_t * ) & val )
> >> +I642U64(val)
> …>> -( int64_t ) * ( ( int64_t * ) & val )
> >> +U642I64(val)
> …> Coccinelle doesn't know these types.  You have to declare them with typedef.
>
> Are type definitions really required for the handling of casts?

Yes.  There is a potential parsing ambiguity otherwise, I believe.

julia

>
> Regards,
> Markus
>
--8323329-743573379-1762893670=:3437--
