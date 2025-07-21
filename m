Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC452C87FC5
	for <cocci@archiver.kernel.org>; Mon, 21 Jul 2025 08:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=ieEtvN/dI4GMh5KqLAhB/HAwUG0xAinqeUKqI+NgLqQ=;
  b=Xhr0HSRHW2N3J/A/li8N8wzP/mRGIVXKm7KeGZX1W/BxjVONyZEzoFwl
   2LWJMA0VmqGy3xc6KjJkdptq1R3n+7vUs0Z0+L3wEIQp6bGuR+K+PemUK
   7x5/lgWahnVtjzt0AmFiaLCuMvOPeobNg8Oo6Iag26VhKnMCcmm3giera
   4=;
X-CSE-ConnectionGUID: zMTm9e9rSbu18lzsCTDn/g==
X-CSE-MsgGUID: +/ojoOFwS/i+grUq1DkA7Q==
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
X-IronPort-AV: E=Sophos;i="6.16,328,1744063200"; 
   d="scan'208";a="232416990"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Jul 2025 10:23:47 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 03DA9E0CD5; Mon, 21 Jul 2025 10:23:47 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 78198E0171
	for <cocci@sympa.inria.fr>; Mon, 21 Jul 2025 10:23:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ieEtvN/dI4GMh5KqLAhB/HAwUG0xAinqeUKqI+NgLqQ=;
  b=ZC4RAqh++S1G+Hz4Wmb2WQ8fJc7+TaUIsb3235FFOeEmcOknCedNI4o4
   vLOGT153XtkLmjsr2PK7EYnZOypnObiLbIBAE/W+GNYyHtXPP0D/65l5Y
   yqd538Dldb6zjxuq4OtwonwLonk4UY3RfOdQo72fH+7HcnA9b34s/v62z
   0=;
X-CSE-ConnectionGUID: fpqaROEnRaqNKqS8skbgYA==
X-CSE-MsgGUID: 9f9G3NsIR7+7uzGd7C+VxQ==
X-IronPort-AV: E=Sophos;i="6.16,328,1744063200"; 
   d="scan'208";a="121822929"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 10:23:43 +0200
Date: Mon, 21 Jul 2025 10:23:42 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <b725f4d0-3c8b-40f8-872f-c79ee0d74c30@web.de>
Message-ID: <e4b6fe43-bcf-90ce-3cda-69912574ff45@inria.fr>
References: <0830325b-6697-49d1-a0a4-d06814c6450f@web.de> <21f78cc-6034-2b33-c2fb-cdf6d3694d2@inria.fr> <fafd85e8-9d04-401f-a4a5-d4286a911264@web.de> <alpine.DEB.2.22.394.2507201608390.3477@hadrien> <bf7d6619-92c5-4471-a6fd-df4af8b97e39@web.de>
 <alpine.DEB.2.22.394.2507210747070.18950@hadrien> <6fa377f7-0612-42aa-afbc-cdeab8bea314@web.de> <8a4b47e2-725e-769e-6bb-43e01113f9fa@inria.fr> <52ce78f5-8141-46dc-9ad0-5cbfedfd92a1@web.de> <cd40be57-cdef-7834-5c8d-eda49eb3a8b@inria.fr>
 <9083cb34-5f8a-43d9-b908-43a9fe2a4281@web.de> <4752963-ce2-3e23-fe61-9cbd1acbbdc1@inria.fr> <b725f4d0-3c8b-40f8-872f-c79ee0d74c30@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1003892187-1753086223=:3696"
Subject: Re: [cocci] Reducing parentheses (with SmPL)?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2890
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/e4b6fe43-bcf-90ce-3cda-69912574ff45%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1003892187-1753086223=:3696
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Mon, 21 Jul 2025, Markus Elfring wrote:

> >> Would you find it really easier to clarify known data processing challenges
> >> with the help of another SmPL script example?
> > I at least understand th script.  But I don't kjnow what problem does it raise?
> …>> @display@
> >> expression e;
> >> statement x, y;
> >> @@
> >>  if (
> >> *    e
> >>     )
> >>     x
> >>  else
> >>     y
>
> Repetition:
> Would we occasionally like to put the found expression as a subitem
> into another SmPL plus slice specification?

I don't know what we would occasionally like to do.  I don't know what
specific plus slice specification you are referring to.  Precedence with
respect to arithmetic operators is handled.  If you have some other
concern in mind please make a concrete example that shows the problem.  I
can't guess what you think someone might occasionally like to do.

> Will additional parentheses become relevant then (or not)?

How about actually trying something and seeing what is the result?

julia
--8323329-1003892187-1753086223=:3696--
