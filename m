Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8793C83F1A
	for <cocci@archiver.kernel.org>; Mon, 21 Jul 2025 06:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=GwMAXoP1OVPSvSgyObaiD0gzNqVT0+S4k8lhDX1GXZE=;
  b=r9B+ooQ0XP0tsXjApZA0aDjrJdDDLwVHPoBiQSlyH+R1oTcZqn+az54D
   gYxoWcgRfTAEsvAjVKytXjQ3bL37PfpoBUbiPbrLrMBR0KfgmLzHXMq6U
   0iZOk12boWGdT0M4wqMc+T5PSEkfdIISDK4i855iC7iOA0wVQeZ0DjMC3
   g=;
X-CSE-ConnectionGUID: QFsVig5QT12ms063jNTckg==
X-CSE-MsgGUID: nSkccPKpTX6ALa1dT2XN9Q==
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
   d="scan'208";a="232395429"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Jul 2025 08:46:43 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DC2D6E0CE1; Mon, 21 Jul 2025 08:46:42 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 6DD03E0CDB
	for <cocci@sympa.inria.fr>; Mon, 21 Jul 2025 08:46:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=GwMAXoP1OVPSvSgyObaiD0gzNqVT0+S4k8lhDX1GXZE=;
  b=qQ+X+eGDZY+ES+N2y+GKpC4ZPQXVkTTaPT+I2RIf8BPDiWpPbhjDq7Ri
   wRZ66ofFurnfVSJ8VXLO/rwuYrAtbF7kucZonLQWuWkeUkU9OrQalJI5F
   AAkFMT7PUNbiKyZLx/txF2dfR6YLGfun9GtB7OFYlVlHk6/f1hf4mueSJ
   c=;
X-CSE-ConnectionGUID: J2qf+XFLR0yKIlU0E/ujEA==
X-CSE-MsgGUID: 2eQeM8E0RwuwJQyu75rjMQ==
X-IronPort-AV: E=Sophos;i="6.16,328,1744063200"; 
   d="scan'208";a="232395406"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 08:46:38 +0200
Date: Mon, 21 Jul 2025 08:46:38 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <6fa377f7-0612-42aa-afbc-cdeab8bea314@web.de>
Message-ID: <8a4b47e2-725e-769e-6bb-43e01113f9fa@inria.fr>
References: <0830325b-6697-49d1-a0a4-d06814c6450f@web.de> <21f78cc-6034-2b33-c2fb-cdf6d3694d2@inria.fr> <fafd85e8-9d04-401f-a4a5-d4286a911264@web.de> <alpine.DEB.2.22.394.2507201608390.3477@hadrien> <bf7d6619-92c5-4471-a6fd-df4af8b97e39@web.de>
 <alpine.DEB.2.22.394.2507210747070.18950@hadrien> <6fa377f7-0612-42aa-afbc-cdeab8bea314@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-336406230-1753080398=:3696"
Subject: Re: [cocci] Reducing parentheses (with SmPL)?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2884
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/8a4b47e2-725e-769e-6bb-43e01113f9fa%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-336406230-1753080398=:3696
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Mon, 21 Jul 2025, Markus Elfring wrote:

> >> * Metavariable contents can be reused for plus slice specifications.
> >>   Desirable source code adjustments should be “expressed” here.
> >>   Which control can we get on the advanced handling of parentheses then?
> >
> > I have no idea what you are trying to do,
>
> I find such feedback strange.
>
>
> >                                           and you are never going to
> > succeed with your strange way of expressing yourself.
>
> I hope still that remaining communication difficulties can be resolved better.
>
>
> >                                                        If you want to know
> > how to do something, please provide a concrete and minimal example of C
> > code and show what you would like it to be transformed into.  That is the
> > only thing I can precisely understand.
>
> Your public activities seem to indicate that you are capable for more.
>
> * We would occasionally like to transform selected expressions
>   (which were captured by instances of the metavariable type “expression”),
>   don't we?

Yes.

> * Do we care then if it would be needed to specify extra parentheses (or not)
>   for plus slice specifications?

No.

julia
--8323329-336406230-1753080398=:3696--
