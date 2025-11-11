Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F21CCF9E3
	for <cocci@archiver.kernel.org>; Tue, 11 Nov 2025 11:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=C8U6AGgQse/av4QZwT8a5YEAdx4rvZDmaJ5zEzLaHhM=;
  b=B966WiajjKI3fuVxt6Cp3YBsKG89hTIYO4BhotlOvG3jcB/Lx835iA7M
   8WDBJI0mxjQLnvr2MCtMkU8ecMGwfShXmENGjIg2YtTjUTzFYQO0Wq3d2
   DqRZmyDwpJKdNCo5FIxlSe+mA4cd5Xa8KKgpaDAciJuLZtnkDeN+sugSA
   A=;
X-CSE-ConnectionGUID: /VgJ8AhjRk6xugh8JLfGSg==
X-CSE-MsgGUID: ax3JEDsERbyPvWvtJUXpDA==
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
X-IronPort-AV: E=Sophos;i="6.19,296,1754949600"; 
   d="scan'208";a="248583087"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Nov 2025 12:53:13 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 14656E0264; Tue, 11 Nov 2025 12:53:13 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id E44ADE0171
	for <cocci@sympa.inria.fr>; Tue, 11 Nov 2025 12:53:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=C8U6AGgQse/av4QZwT8a5YEAdx4rvZDmaJ5zEzLaHhM=;
  b=I9fXe6u1yKcbyFFBaCIwEwtkzAoYZDxJV36DU9ERVFfehNLAE+17//rM
   mz11xMkm9CtbYlZUyBWbSt5aTkD/32WotWf71mhpcb3arCudGfEng5s6t
   k4HyB4X1bWJbiOIsUAiXFy+NXHFs77AH7LALNwEDTSLMy9q8hLU2tKnLY
   I=;
X-CSE-ConnectionGUID: jLcOYcbrQMmKvPiE8nTZ3g==
X-CSE-MsgGUID: 3/GSMp9oQ/mt34/HA+k6Eg==
X-IronPort-AV: E=Sophos;i="6.19,296,1754949600"; 
   d="scan'208";a="248583081"
Received: from c-76-123-3-165.hsd1.va.comcast.net (HELO hadrien) ([76.123.3.165])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 12:53:07 +0100
Date: Tue, 11 Nov 2025 06:53:05 -0500 (EST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <cd413c87-f5d2-4706-ad87-652075f39eac@web.de>
Message-ID: <c44ee564-c4b6-59b8-73e1-38de94d05577@inria.fr>
References: <a2551ccb-edd1-403c-bcd6-3f9cd5381bcb@web.de> <338F2B21-0F98-450A-BDA0-6F7E4F22F9FD@inria.fr> <cd413c87-f5d2-4706-ad87-652075f39eac@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Moving string literals with SmPL?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3160
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/c44ee564-c4b6-59b8-73e1-38de94d05577%40inria.fr>



On Tue, 11 Nov 2025, Markus Elfring wrote:

> >> // See also:
> >> // crypto_rng_show()
> >> // https://elixir.bootlin.com/linux/v6.18-rc4/source/crypto/rng.c#L82-L86
> >> @adjustment@
> >> constant char[] last_literal, literal;
> >> expression context;
> >> @@
> >> -seq_printf(context, literal);
> >> seq_printf(context,
> >> +           literal
> >
> > Why is there no comma after literal?
> >
> >>            last_literal,
> >>            ...);
>
> I would like to use adjacent string literals here.
> https://en.cppreference.com/w/c/language/string_literal.html#Explanation

That is not supported.
