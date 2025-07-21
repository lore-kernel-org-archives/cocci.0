Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D44DBC83F25
	for <cocci@archiver.kernel.org>; Mon, 21 Jul 2025 11:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=PRAG53fPFd+FusPMiKHA0zMEILq+fqrscJN5jfa1WBY=;
  b=PRcPbgkWk5fonSUXR1KHOjUgNmAxUHeBajHuSFaWr6CyegdmNvt2XGV7
   ji3L0iT5NgjSQmc195C5U0WQhshFd+O75W8FblfHtFTpsNdZE9L/Vt56x
   TGYqL9lxHkRrNxSReaxl53/1groXizOUvW2yBdNaht2jYMiCxwJwn3jzS
   k=;
X-CSE-ConnectionGUID: wHCg8rUfTtKoepCdE2z4aQ==
X-CSE-MsgGUID: yZ0TTbWlR1arQJkuGi0xag==
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
X-IronPort-AV: E=Sophos;i="6.16,329,1744063200"; 
   d="scan'208";a="232456063"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Jul 2025 13:54:28 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3D862E0CD5; Mon, 21 Jul 2025 13:54:28 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id C7509E0171
	for <cocci@sympa.inria.fr>; Mon, 21 Jul 2025 13:54:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=PRAG53fPFd+FusPMiKHA0zMEILq+fqrscJN5jfa1WBY=;
  b=XuHbdqPLiwH/BIgliS2wUQuMw6rstWmJF1Mw+2v7sLuMfkyU9rQRLFty
   +3W3yT7eakmt2xMPF/Z8BzkI/b4vm5hb/fK2Q1IE4gcv43136N7MZyyGq
   HYOWT7oaM4ZHTNHznSP8gVabuDdYip07GL+TcxKtPohAq+wG7SkwNQmzU
   E=;
X-CSE-ConnectionGUID: Hsplj5fHQmims0HitEY7vQ==
X-CSE-MsgGUID: nTRXaCAoQpS5JVhRUfHwAw==
X-IronPort-AV: E=Sophos;i="6.16,329,1744063200"; 
   d="scan'208";a="121842730"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 13:54:21 +0200
Date: Mon, 21 Jul 2025 13:54:21 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
In-Reply-To: <457ef653-08a3-48db-89ba-6f0e9153e563@web.de>
Message-ID: <195a2f45-af9-495d-694-673f7e5fb35d@inria.fr>
References: <0830325b-6697-49d1-a0a4-d06814c6450f@web.de> <21f78cc-6034-2b33-c2fb-cdf6d3694d2@inria.fr> <fafd85e8-9d04-401f-a4a5-d4286a911264@web.de> <alpine.DEB.2.22.394.2507201608390.3477@hadrien> <bf7d6619-92c5-4471-a6fd-df4af8b97e39@web.de>
 <alpine.DEB.2.22.394.2507210747070.18950@hadrien> <6fa377f7-0612-42aa-afbc-cdeab8bea314@web.de> <8a4b47e2-725e-769e-6bb-43e01113f9fa@inria.fr> <52ce78f5-8141-46dc-9ad0-5cbfedfd92a1@web.de> <cd40be57-cdef-7834-5c8d-eda49eb3a8b@inria.fr>
 <9083cb34-5f8a-43d9-b908-43a9fe2a4281@web.de> <4752963-ce2-3e23-fe61-9cbd1acbbdc1@inria.fr> <9154fc36-842b-4797-9b55-397cfdcba283@web.de> <2914d20-68da-a23d-6345-fd48f0b9bed8@inria.fr> <457ef653-08a3-48db-89ba-6f0e9153e563@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-771258128-1753098861=:3696"
Subject: Re: [cocci] Reducing parentheses (with SmPL)?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2895
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/195a2f45-af9-495d-694-673f7e5fb35d%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-771258128-1753098861=:3696
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Mon, 21 Jul 2025, Markus Elfring wrote:

> >> Can you recognise development concerns better from another SmPL code variant?
> >>
> >>
> >> @adjustment@
> >> expression e;
> >> statement s;
> >> @@
> >> -if
> >> +my_result =
> >>     (e)
> >> +&& true;
> >> -   s
> > And what is the problem?
>
> I would expect that further checks are needed for the determination
> if remaining parentheses can be redundant.
> I find the knowledge that is encapsulated by the metavariable type “expression”
> incomplete so far.
>
>
> > If you don't want the parentheses around e, then remove them.
>
> How would you determine if extra parentheses are actually required
> for a part of a recombined expression?

The pretty printer looks at the context to some extent.  If you have a
concrete example that illustrates a problem, please provide it.  If not,
please end this discussion.

julia
--8323329-771258128-1753098861=:3696--
